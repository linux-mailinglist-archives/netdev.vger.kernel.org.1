Return-Path: <netdev+bounces-201766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10957AEAEED
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 08:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0321C1C22751
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 06:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64E41FCD1F;
	Fri, 27 Jun 2025 06:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="jdRdl6mu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C751FFC48
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 06:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751005086; cv=none; b=GZ9r58gFJgfTBZ5pYnvbpIPE7bR0yDGo7Uiyl40yQ/zGFVS11VbAppkoFtN7TUk/sK472XMPY3+DWgcn+UoGX1IoV7WInbD0+6xf8gakN8qXZxZEfX8h/LmbQympj/CCaOLQKjoy7u58aYrjFOOo8ygVL5TJo3SuYgFno2fX3yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751005086; c=relaxed/simple;
	bh=nRSUPBHYByjGI+bPGAkDeT4viFaqCdWvJ5/hEkL/5KY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=N9bEdEQ8e3ujjEDtmelGxjRy0jW/U/4n6po0Qd2fk6MEcNtmbLN79JUab0GR3AbhNNTF25zEKnK9HinYhjocouoI5hjjhYi1BL0W7JYaWSntHjmHcDCwl7iLh0fuop42t7t1PDvT10t93kJIgynEXoWaZUwQaJj2gkTKAAS90UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=jdRdl6mu; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1751005082; x=1751264282;
	bh=7C1nIGx7piEm1LdAKi5GYm+V9SbMKpG0OmlSE+ECjWs=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=jdRdl6mufoCMWqz/AiVPmvF2RNy8HZwWV19j2w67KTKB7r7gz6KPB+IXIy6VsC9wg
	 f3yW5ggj6VZqeCrWHwTe+ihu1O4Fv6TNRotfCkw8OZGZsa1xIo4G3phBgjNrh+DJOV
	 RlhgSH//hNzckIr63SP3HsAvN619vU4Spn54PY826Iy7e4Pclh03mobAbXF9jA8Nte
	 V9R0bvONbfEEesLtt8Ym48ICJo5aYQXe70C6c+UUpW2c1bcgGFBmyJNWs6pJ+RP5mP
	 R1bydSWh2925DIEXONT1bAwyj3uqqHo2KPEyae2dzUs2/C6tPZ2ldnaj7t4pjt6ktH
	 Yhpc3Uo5emBZg==
Date: Fri, 27 Jun 2025 06:17:56 +0000
To: netdev@vger.kernel.org
From: William Liu <will@willsroot.io>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, victor@mojatatu.com, pctammela@mojatatu.com, pabeni@redhat.com, kuba@kernel.org, stephen@networkplumber.org, dcaratti@redhat.com, savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, William Liu <will@willsroot.io>
Subject: [PATCH net v4 2/2] selftests/tc-testing: Add tests for restrictions on netem duplication
Message-ID: <20250627061627.56566-1-will@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: ec528bc13ac7a2ea2f8f95d515e0f419356a1a25
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ensure that a duplicating netem cannot exist in a tree with other netems
in both qdisc addition and change. This is meant to prevent the soft
lockup and OOM loop scenario discussed in [1]. Also adjust a HFSC's
re-entrancy test case with netem for this new restriction - KASAN
still triggers upon its failure.

[1] https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsE=
BNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=3D@will=
sroot.io/

Signed-off-by: William Liu <will@willsroot.io>
Reviewed-by: Savino Dicanosa <savy@syst3mfailure.io>
---
v1 -> v2:
  - Fixed existing test case for new restrictions
  - Add test cases
  - Use dummy instead of lo
---
 .../tc-testing/tc-tests/infra/qdiscs.json     |  5 +-
 .../tc-testing/tc-tests/qdiscs/netem.json     | 81 +++++++++++++++++++
 2 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json =
b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 9aa44d8176d9..9acc88297484 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -478,7 +478,6 @@
             "$TC qdisc add dev $DUMMY parent 1:1 handle 2:0 netem duplicat=
e 100%",
             "$TC filter add dev $DUMMY parent 1:0 protocol ip prio 1 u32 m=
atch ip dst 10.10.10.1/32 flowid 1:1",
             "$TC class add dev $DUMMY parent 1:0 classid 1:2 hfsc ls m2 10=
Mbit",
-            "$TC qdisc add dev $DUMMY parent 1:2 handle 3:0 netem duplicat=
e 100%",
             "$TC filter add dev $DUMMY parent 1:0 protocol ip prio 2 u32 m=
atch ip dst 10.10.10.2/32 flowid 1:2",
             "ping -c 1 10.10.10.1 -I$DUMMY > /dev/null || true",
             "$TC filter del dev $DUMMY parent 1:0 protocol ip prio 1",
@@ -491,8 +490,8 @@
             {
                 "kind": "hfsc",
                 "handle": "1:",
-                "bytes": 392,
-                "packets": 4
+                "bytes": 294,
+                "packets": 3
             }
         ],
         "matchCount": "1",
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json =
b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
index 3c4444961488..718d2df2aafa 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
@@ -336,5 +336,86 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
+    },
+    {
+        "id": "d34d",
+        "name": "NETEM test qdisc duplication restriction in qdisc tree in=
 netem_change root",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY root handle 1: netem limit 1",
+            "$TC qdisc add dev $DUMMY parent 1: handle 2: netem limit 1"
+        ],
+        "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 1: netem dupli=
cate 50%",
+        "expExitCode": "2",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
+        "matchPattern": "qdisc netem",
+        "matchCount": "2",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1:0 root"
+        ]
+    },
+    {
+        "id": "b33f",
+        "name": "NETEM test qdisc duplication restriction in qdisc tree in=
 netem_change non-root",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY root handle 1: netem limit 1",
+            "$TC qdisc add dev $DUMMY parent 1: handle 2: netem limit 1"
+        ],
+        "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 2: netem dupli=
cate 50%",
+        "expExitCode": "2",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
+        "matchPattern": "qdisc netem",
+        "matchCount": "2",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1:0 root"
+        ]
+    },
+    {
+        "id": "cafe",
+        "name": "NETEM test qdisc duplication restriction in qdisc tree",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY root handle 1: netem limit 1 duplica=
te 100%"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY parent 1: handle 2: nete=
m duplicate 100%",
+        "expExitCode": "2",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
+        "matchPattern": "qdisc netem",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1:0 root"
+        ]
+    },
+    {
+        "id": "1337",
+        "name": "NETEM test qdisc duplication restriction in qdisc tree ac=
ross branches",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY parent root handle 1:0 hfsc",
+            "$TC class add dev $DUMMY parent 1:0 classid 1:1 hfsc rt m2 10=
Mbit",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 2:0 netem",
+            "$TC class add dev $DUMMY parent 1:0 classid 1:2 hfsc rt m2 10=
Mbit"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY parent 1:2 handle 3:0 ne=
tem duplicate 100%",
+        "expExitCode": "2",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
+        "matchPattern": "qdisc netem",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1:0 root"
+        ]
     }
 ]
--=20
2.43.0



