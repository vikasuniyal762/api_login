import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email, String password) async {
    try {
      var response =await post(

        ///API CALLING THROUGH LINK
        Uri.parse('https://reqres.in/api/register'),
        body: {
          'email': email,
          'password': password,
        },
      );
      /// to show the successful and failed status
      if (response.statusCode == 200) {
        /// to get the ID or TOKEN
        var data =jsonDecode(response.body.toString());
        print(data['Token']);
        print('Login successful');
      } else {
        // Handle error scenarios
        print('Login failed: ${response.reasonPhrase}');
      }
    } catch (e) {
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up Api'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.teal,
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.indigoAccent,
                  )),
            ),
            SizedBox(height: 20,),
            Container(
              child: Center(
              child: FloatingActionButton(
                backgroundColor: Colors.teal,
                splashColor: Colors.yellow,
                onPressed: () {
                  login(
                    emailController.text.toString(),
                    passwordController.text.toString(),
                  );
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
            )
          ],
        ),
      ),
    );
  }
}
