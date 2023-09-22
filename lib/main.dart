import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Env { development, staging, production }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadEnvironment(Env.staging.name);
  runApp(const MyApp());
}

Future<void> loadEnvironment(String environment) async {
  String fileName = '.env';
  fileName += '.$environment';
  await dotenv.load(fileName: fileName);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiBaseUrl = dotenv.env['API_BASE_URL']!;
    final debug = dotenv.env['DEBUG'] == 'true';

    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Environment Variables Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('API Base URL: $apiBaseUrl'),
              Text('Debug Mode: $debug'),
            ],
          ),
        ),
      ),
    );
  }
}
