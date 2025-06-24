Return-Path: <netdev+bounces-200498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40044AE5B7F
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 06:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F3DE7B02F3
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 04:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32572136658;
	Tue, 24 Jun 2025 04:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="Ff0TlPlN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch [109.224.244.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1E86136
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 04:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750739124; cv=none; b=nXb15+GCL26JWYkQ5E8hTFpvZUK2CYON5k/HjKWhUZZPdoWEsnnAu7YW/1S/sQXkeXiLmnwUqKqbaEkuqMi2pRVyjrSd9Dze76ewseVT0N3meuPgmNvtqebL0zJVbW78LFRET0aKlk4nuCpSfG/AQKc91cCX2Xi3YAY1+5RVlQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750739124; c=relaxed/simple;
	bh=aOQl5sdSyqAYyB+GNsYhDOg8w8CL8Rji9Ocylik8PJ0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hf3sd1nqtsJmldoAFXfAHby6fMCj8Ldqe3lob7Gu4rIDHKRYfCi0td5KO8yIsGSXxANAXxdgjfmKZZU6y75mIlf0c+jeFV7QoRQwsQu/pQ8oBKleNiiLJTF5SPIT+8ZCOa4Y3mNWHGTcXQZbV3WmVOL9XTzGrwTuLlx5vc0iqik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=Ff0TlPlN; arc=none smtp.client-ip=109.224.244.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1750739119; x=1750998319;
	bh=tBmDZgneGrXo7cf2JOadwfY9LTw1ZDc5BprFOzJsWHk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ff0TlPlNs2tJ+Rr7aoGWCrIBJQMVtAguSz7tDUrCK4YQ2ZaZYYPF/KMP7VfI1Rq3n
	 YfFJbkc25Y4nDDjLKSqF4Hclg364qevRJk5nSXyAOvkyUBxY22vWDzJCJN3CX+Jahq
	 arD9zC3i1PFT5be4BTl3ktsT4rIWxJePL2HMT+FdrspoWctgj3XtQ/c/bnqrwDZxuR
	 mk3ivDvuszphlogXJLfOUEu7Y7g0Rj4QNa13meYe5STynyKnVzW470+K/k3sWuKHdg
	 gGRKUXfh0eH8AP/Yaym/Itg8UXYbwpYbzo4S/3rq40kKBicvWMauIDpl+BF3RajBXx
	 nx+UYUKZQB/jQ==
Date: Tue, 24 Jun 2025 04:25:15 +0000
To: netdev@vger.kernel.org
From: William Liu <will@willsroot.io>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, victor@mojatatu.com, pctammela@mojatatu.com, pabeni@redhat.com, kuba@kernel.org, stephen@networkplumber.org, dcaratti@redhat.com, savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, William Liu <will@willsroot.io>
Subject: [PATCH net v2 2/2] selftests/tc-testing: Add tests for restrictions on netem duplication
Message-ID: <20250624042347.521360-1-will@willsroot.io>
In-Reply-To: <20250624042238.521211-1-will@willsroot.io>
References: <20250624042238.521211-1-will@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: e92a88115c4dd07d20853e912618f9bd1034fbb1
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



