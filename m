Return-Path: <netdev+bounces-52302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A87797FE325
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 23:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D9CCB211A7
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 22:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9980347A5C;
	Wed, 29 Nov 2023 22:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="HSQqGDYE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C3A10FE
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 14:24:59 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cfbda041f3so2931675ad.2
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 14:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701296698; x=1701901498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSrFE3+h5zzVB7jBNvTgKunTZNHyuNKQBqWYc0dL+X4=;
        b=HSQqGDYEULa1paiNf2hCFxWTLagfz4k3QH+i6mwSLGzPZGJF2sIVIHyYKn4jXpEb3O
         FviEjsfnwomLLEqGn7JyJbQcCMBRSjYTjROmdsmGVAap4ZMOKntG94gHcsJQEnesZNpy
         VfqQ+g1SFWxxfDTOTmtX2kY5T6dDK3655xpGE+mOVog8SVR8iJjPbNr9/y+yLd3d0O8X
         MDYuy144D3g4r/fAeIF0yyES2XO2T9AVH5VSRbshqlAiMhnxxo2jalMSXM6guDYuVs7f
         uzO/z0w45dNKEOLmj/YMLaaCa6L2TUE7lJ0U9AtWcw1a8k9itoKdXA9hyY7TW1Vo3dug
         8m9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701296698; x=1701901498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lSrFE3+h5zzVB7jBNvTgKunTZNHyuNKQBqWYc0dL+X4=;
        b=oUtyfoHhZxCIzAGnPcwJJ+WL1BAvI3A9THdAHQlxXsZzxYvEOmdUebepQVjhl87a+I
         2OEl8Z1R8G4r5bMM+Z/B0axsLj0lxyDGtXXyclk3WR169S8CWBt75Rrxosw/0uXrukMq
         BaHt+5JkzGcOKdEx+TT5IRcZ2LE95x+zCnR8RYTVIQj9eFg5SncZIAf3baJaR35Pb5xv
         8cLDwxAKzSMiDoOzobzB1LUI6Q4lyjWiLCYmNwtrmzQUXKrGotpjCf3XXXygQgWRWeZn
         6jIbl4NktlFKtgw6jZ9tLLYSO7OKTrlX+iNR3600ymJZZ6BjtMztVmnRf80kg2ZPYfAo
         G2BQ==
X-Gm-Message-State: AOJu0YzwE/m27irS0qqPNVMO4yXiUfX49DRQ871Fk2jNRVgTKdPII2S9
	Mg8FRGJsWXhT8lSp2DqKibWH8yfa4M8Qjdo9Qa4=
X-Google-Smtp-Source: AGHT+IEuNs0fHPUjPJKyExFAA0yrf9VZeLwMC4OQW+7VA/d78k8KKe9c3WBTzbDAZeF+H5JHp8ikHw==
X-Received: by 2002:a17:902:8309:b0:1d0:68a:4a45 with SMTP id bd9-20020a170902830900b001d0068a4a45mr5183683plb.35.1701296698402;
        Wed, 29 Nov 2023 14:24:58 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001cfb971edf2sm8663697plg.13.2023.11.29.14.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 14:24:58 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	linux-kselftest@vger.kernel.org,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 4/4] selftests: tc-testing: remove filters/tests.json
Date: Wed, 29 Nov 2023 19:24:24 -0300
Message-Id: <20231129222424.910148-5-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231129222424.910148-1-pctammela@mojatatu.com>
References: <20231129222424.910148-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove this generic file and move the tests to their appropriate files

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 .../tc-testing/tc-tests/filters/flower.json   |  98 ++++++++++++++
 .../tc-testing/tc-tests/filters/matchall.json |  23 ++++
 .../tc-testing/tc-tests/filters/tests.json    | 123 ------------------
 3 files changed, 121 insertions(+), 123 deletions(-)
 delete mode 100644 tools/testing/selftests/tc-testing/tc-tests/filters/tests.json

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/flower.json b/tools/testing/selftests/tc-testing/tc-tests/filters/flower.json
index c2a433a4737e..6b08c0642069 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/flower.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/flower.json
@@ -173,5 +173,103 @@
             "$TC qdisc del dev $DEV2 ingress",
             "/bin/rm -rf $BATCH_DIR"
         ]
+    },
+    {
+        "id": "2ff3",
+        "name": "Add flower with max handle and then dump it",
+        "category": [
+            "filter",
+            "flower"
+        ],
+        "setup": [
+            "$TC qdisc add dev $DEV2 ingress"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV2 protocol ip pref 1 ingress handle 0xffffffff flower action ok",
+        "expExitCode": "0",
+        "verifyCmd": "$TC filter show dev $DEV2 ingress",
+        "matchPattern": "filter protocol ip pref 1 flower.*handle 0xffffffff",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV2 ingress"
+        ]
+    },
+    {
+        "id": "d052",
+        "name": "Add 1M filters with the same action",
+        "category": [
+            "filter",
+            "flower"
+        ],
+        "setup": [
+            "$TC qdisc add dev $DEV2 ingress",
+            "./tdc_batch.py $DEV2 $BATCH_FILE --share_action -n 1000000"
+        ],
+        "cmdUnderTest": "$TC -b $BATCH_FILE",
+        "expExitCode": "0",
+        "verifyCmd": "$TC actions list action gact",
+        "matchPattern": "action order 0: gact action drop.*index 1 ref 1000000 bind 1000000",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV2 ingress",
+            "/bin/rm $BATCH_FILE"
+        ]
+    },
+    {
+        "id": "4cbd",
+        "name": "Try to add filter with duplicate key",
+        "category": [
+            "filter",
+            "flower"
+        ],
+        "setup": [
+            "$TC qdisc add dev $DEV2 ingress",
+            "$TC filter add dev $DEV2 protocol ip prio 1 ingress flower dst_mac e4:11:22:11:4a:51 src_mac e4:11:22:11:4a:50 ip_proto tcp src_ip 1.1.1.1 dst_ip 2.2.2.2 action drop"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV2 protocol ip prio 1 ingress flower dst_mac e4:11:22:11:4a:51 src_mac e4:11:22:11:4a:50 ip_proto tcp src_ip 1.1.1.1 dst_ip 2.2.2.2 action drop",
+        "expExitCode": "2",
+        "verifyCmd": "$TC -s filter show dev $DEV2 ingress",
+        "matchPattern": "filter protocol ip pref 1 flower chain 0 handle",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV2 ingress"
+        ]
+    },
+    {
+        "id": "7c65",
+        "name": "Add flower filter and then terse dump it",
+        "category": [
+            "filter",
+            "flower"
+        ],
+        "setup": [
+            "$TC qdisc add dev $DEV2 ingress"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV2 protocol ip pref 1 ingress flower dst_mac e4:11:22:11:4a:51 action drop",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -br filter show dev $DEV2 ingress",
+        "matchPattern": "filter protocol ip pref 1 flower.*handle",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV2 ingress"
+        ]
+    },
+    {
+        "id": "d45e",
+        "name": "Add flower filter and verify that terse dump doesn't output filter key",
+        "category": [
+            "filter",
+            "flower"
+        ],
+        "setup": [
+            "$TC qdisc add dev $DEV2 ingress"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DEV2 protocol ip pref 1 ingress flower dst_mac e4:11:22:11:4a:51 action drop",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -br filter show dev $DEV2 ingress",
+        "matchPattern": "  dst_mac e4:11:22:11:4a:51",
+        "matchCount": "0",
+        "teardown": [
+            "$TC qdisc del dev $DEV2 ingress"
+        ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/matchall.json b/tools/testing/selftests/tc-testing/tc-tests/filters/matchall.json
index afa1b9b0c856..f8d28c415bc3 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/matchall.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/matchall.json
@@ -480,5 +480,28 @@
             "$TC qdisc del dev $DUMMY ingress",
             "$TC actions del action police index 199"
         ]
+    },
+    {
+        "id": "2638",
+        "name": "Add matchall and try to get it",
+        "category": [
+            "filter",
+            "matchall"
+        ],
+        "plugins": {
+                "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 clsact",
+            "$TC filter add dev $DEV1 protocol all pref 1 ingress handle 0x1234 matchall action ok"
+        ],
+        "cmdUnderTest": "$TC filter get dev $DEV1 protocol all pref 1 ingress handle 0x1234 matchall",
+        "expExitCode": "0",
+        "verifyCmd": "$TC filter show dev $DEV1 ingress",
+        "matchPattern": "filter protocol all pref 1 matchall chain 0 handle 0x1234",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 clsact"
+        ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/tests.json b/tools/testing/selftests/tc-testing/tc-tests/filters/tests.json
deleted file mode 100644
index 4598f1d330fe..000000000000
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/tests.json
+++ /dev/null
@@ -1,123 +0,0 @@
-[
-    {
-        "id": "2638",
-        "name": "Add matchall and try to get it",
-        "category": [
-            "filter",
-            "matchall"
-        ],
-        "plugins": {
-                "requires": "nsPlugin"
-        },
-        "setup": [
-            "$TC qdisc add dev $DEV1 clsact",
-            "$TC filter add dev $DEV1 protocol all pref 1 ingress handle 0x1234 matchall action ok"
-        ],
-        "cmdUnderTest": "$TC filter get dev $DEV1 protocol all pref 1 ingress handle 0x1234 matchall",
-        "expExitCode": "0",
-        "verifyCmd": "$TC filter show dev $DEV1 ingress",
-        "matchPattern": "filter protocol all pref 1 matchall chain 0 handle 0x1234",
-        "matchCount": "1",
-        "teardown": [
-            "$TC qdisc del dev $DEV1 clsact"
-        ]
-    },
-    {
-        "id": "2ff3",
-        "name": "Add flower with max handle and then dump it",
-        "category": [
-            "filter",
-            "flower"
-        ],
-        "setup": [
-            "$TC qdisc add dev $DEV2 ingress"
-        ],
-        "cmdUnderTest": "$TC filter add dev $DEV2 protocol ip pref 1 ingress handle 0xffffffff flower action ok",
-        "expExitCode": "0",
-        "verifyCmd": "$TC filter show dev $DEV2 ingress",
-        "matchPattern": "filter protocol ip pref 1 flower.*handle 0xffffffff",
-        "matchCount": "1",
-        "teardown": [
-            "$TC qdisc del dev $DEV2 ingress"
-        ]
-    },
-    {
-        "id": "d052",
-        "name": "Add 1M filters with the same action",
-        "category": [
-            "filter",
-            "flower"
-        ],
-        "setup": [
-            "$TC qdisc add dev $DEV2 ingress",
-            "./tdc_batch.py $DEV2 $BATCH_FILE --share_action -n 1000000"
-        ],
-        "cmdUnderTest": "$TC -b $BATCH_FILE",
-        "expExitCode": "0",
-        "verifyCmd": "$TC actions list action gact",
-        "matchPattern": "action order 0: gact action drop.*index 1 ref 1000000 bind 1000000",
-        "matchCount": "1",
-        "teardown": [
-            "$TC qdisc del dev $DEV2 ingress",
-            "/bin/rm $BATCH_FILE"
-        ]
-    },
-    {
-        "id": "4cbd",
-        "name": "Try to add filter with duplicate key",
-        "category": [
-            "filter",
-            "flower"
-        ],
-        "setup": [
-            "$TC qdisc add dev $DEV2 ingress",
-            "$TC filter add dev $DEV2 protocol ip prio 1 ingress flower dst_mac e4:11:22:11:4a:51 src_mac e4:11:22:11:4a:50 ip_proto tcp src_ip 1.1.1.1 dst_ip 2.2.2.2 action drop"
-        ],
-        "cmdUnderTest": "$TC filter add dev $DEV2 protocol ip prio 1 ingress flower dst_mac e4:11:22:11:4a:51 src_mac e4:11:22:11:4a:50 ip_proto tcp src_ip 1.1.1.1 dst_ip 2.2.2.2 action drop",
-        "expExitCode": "2",
-        "verifyCmd": "$TC -s filter show dev $DEV2 ingress",
-        "matchPattern": "filter protocol ip pref 1 flower chain 0 handle",
-        "matchCount": "1",
-        "teardown": [
-            "$TC qdisc del dev $DEV2 ingress"
-        ]
-    },
-    {
-        "id": "7c65",
-        "name": "Add flower filter and then terse dump it",
-        "category": [
-            "filter",
-            "flower"
-        ],
-        "setup": [
-            "$TC qdisc add dev $DEV2 ingress"
-        ],
-        "cmdUnderTest": "$TC filter add dev $DEV2 protocol ip pref 1 ingress flower dst_mac e4:11:22:11:4a:51 action drop",
-        "expExitCode": "0",
-        "verifyCmd": "$TC -br filter show dev $DEV2 ingress",
-        "matchPattern": "filter protocol ip pref 1 flower.*handle",
-        "matchCount": "1",
-        "teardown": [
-            "$TC qdisc del dev $DEV2 ingress"
-        ]
-    },
-    {
-        "id": "d45e",
-        "name": "Add flower filter and verify that terse dump doesn't output filter key",
-        "category": [
-            "filter",
-            "flower"
-        ],
-        "setup": [
-            "$TC qdisc add dev $DEV2 ingress"
-        ],
-        "cmdUnderTest": "$TC filter add dev $DEV2 protocol ip pref 1 ingress flower dst_mac e4:11:22:11:4a:51 action drop",
-        "expExitCode": "0",
-        "verifyCmd": "$TC -br filter show dev $DEV2 ingress",
-        "matchPattern": "  dst_mac e4:11:22:11:4a:51",
-        "matchCount": "0",
-        "teardown": [
-            "$TC qdisc del dev $DEV2 ingress"
-        ]
-    }
-]
-- 
2.40.1


