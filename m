Return-Path: <netdev+bounces-210346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 228F6B12D1E
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 01:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE344E2450
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 23:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAFB21C9E4;
	Sat, 26 Jul 2025 23:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="k2f9pYoK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED022AD16
	for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 23:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753573825; cv=none; b=ZnQttj7QZg17T4+Q3ft4wUI7wlhZfw000ZZlTSGBp96UcTBeVOflN2axeFGyyZCfAqIxZ1M83Sspdkg6tHuBmwT588N6PDL04QlitojBDPjFpxTruNSKT69hkmkonnBSGBWMx3PVgD6UJL/pDGuUx+sstrZE59T+Uw7cp9RNZkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753573825; c=relaxed/simple;
	bh=imbwbWVPGCqwACS13uLDDOB8nc/ezsWFf1MEgAHw+Zo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHBRImFqInkZcfo3TuAPi31/mLmUq9dZ3J150jqzndlyuUW51vXoQ3KKRv2YGagXoboeJEyMB2xS2s+yKGXUamJFDNt7eY6AGSYBQL5eRE8V0AJGz6/f8T3EMdQyzZwJM4HU0sANeL31RW4kg4uVY0qxeY2TdIJkqGcTc+mD0G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=k2f9pYoK; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail2; t=1753573807; x=1753833007;
	bh=CEK5+6zrXLp/FPX/X5zp9xjUzIkhXHVuXq7A4s7o1mw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=k2f9pYoKPZz/8NWyrYqO8/yU0HFyUaHBqKOOlLZo2Ly1PGPubDnRO7qmtl08AInKR
	 /7wDx9u05WGFbkqRB9cL1Z668r+vsE2QkoM0hLvI2lX9M65au2qFcDu/9/An9QtQtl
	 8Mj52Moxjg/k6IsUdau5uS9+4++X+3irXOgNqy4tXnHDizuiqyWvMJ/YzNq/UddDJO
	 /WlAM0sAyOvtMlXD5mI3MMTzclL5I+qkTBh/+1d5zYBx2Iiayz5Rlug/hOxVylbnXc
	 yqJB1P0jfz94bCCQFTozpQWnjsVscGCbNdmbw5+vYVEBdvy35wDw2wQoAl6YF56L8T
	 eSjx+O+kTnLhA==
Date: Sat, 26 Jul 2025 23:50:00 +0000
To: netdev@vger.kernel.org
From: William Liu <will@willsroot.io>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, kuba@kernel.org, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, savy@syst3mfailure.io, William Liu <will@willsroot.io>
Subject: [PATCH net v3 2/2] selftests/tc-testing: Check backlog stats in gso_skb case
Message-ID: <20250726234936.106930-1-will@willsroot.io>
In-Reply-To: <20250726234901.106808-1-will@willsroot.io>
References: <20250726234901.106808-1-will@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 90848c16dd45cdc3d727cd57b802cac3818aa934
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add tests to ensure proper backlog accounting in hhf, codel, pie, fq,
fq_pie, and fq_codel qdiscs. For hhf, codel, and pie, we check for
the correct packet count and packet size. For fq, fq_pie, and fq_codel,
we check to make sure the backlog statistics do not underflow in tbf
after removing those qdiscs, which was an original bug symptom.

Signed-off-by: William Liu <will@willsroot.io>
Reviewed-by: Savino Dicanosa <savy@syst3mfailure.io>
---
v2 -> v3:
  - Simplify ping command in test cases
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 195 ++++++++++++++++++
 1 file changed, 195 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json =
b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index c6db7fa94f55..d075129457a2 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -185,6 +185,201 @@
             "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
         ]
     },
+    {
+        "id": "34c0",
+        "name": "Test TBF with HHF Backlog Accounting in gso_skb case",
+        "category": [
+            "qdisc",
+            "tbf",
+            "hhf"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin"
+            ]
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.11.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: tbf rate 8bit burst 1=
00b latency 100ms",
+            "$TC qdisc replace dev $DUMMY handle 2: parent 1:1 hhf limit 1=
000",
+            [
+                "ping -I $DUMMY -c2 10.10.11.11",
+                1
+            ]
+        ],
+        "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 2: parent 1:1 =
hhf limit 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
+        "matchPattern": "backlog 70b 1p",
+        "matchCount": "2",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "fd68",
+        "name": "Test TBF with CODEL Backlog Accounting in gso_skb case",
+        "category": [
+            "qdisc",
+            "tbf",
+            "codel"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin"
+            ]
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.11.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: tbf rate 8bit burst 1=
00b latency 100ms",
+            "$TC qdisc replace dev $DUMMY handle 2: parent 1:1 codel limit=
 1000",
+            [
+                "ping -I $DUMMY -c2 10.10.11.11",
+                1
+            ]
+        ],
+        "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 2: parent 1:1 =
codel limit 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
+        "matchPattern": "backlog 70b 1p",
+        "matchCount": "2",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "514e",
+        "name": "Test TBF with PIE Backlog Accounting in gso_skb case",
+        "category": [
+            "qdisc",
+            "tbf",
+            "pie"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin"
+            ]
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.11.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: tbf rate 8bit burst 1=
00b latency 100ms",
+            "$TC qdisc replace dev $DUMMY handle 2: parent 1:1 pie limit 1=
000",
+            [
+                "ping -I $DUMMY -c2 10.10.11.11",
+                1
+            ]
+        ],
+        "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 2: parent 1:1 =
pie limit 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
+        "matchPattern": "backlog 70b 1p",
+        "matchCount": "2",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "6c97",
+        "name": "Test TBF with FQ Backlog Accounting in gso_skb case again=
st underflow",
+        "category": [
+            "qdisc",
+            "tbf",
+            "fq"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin"
+            ]
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.11.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: tbf rate 8bit burst 1=
00b latency 100ms",
+            "$TC qdisc replace dev $DUMMY handle 2: parent 1:1 fq limit 10=
00",
+            [
+                "ping -I $DUMMY -c2 10.10.11.11",
+                1
+            ],
+            "$TC qdisc change dev $DUMMY handle 2: parent 1:1 fq limit 1"
+        ],
+        "cmdUnderTest": "$TC qdisc del dev $DUMMY handle 2: parent 1:1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
+        "matchPattern": "backlog 0b 0p",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "5d0b",
+        "name": "Test TBF with FQ_CODEL Backlog Accounting in gso_skb case=
 against underflow",
+        "category": [
+            "qdisc",
+            "tbf",
+            "fq_codel"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin"
+            ]
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.11.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: tbf rate 8bit burst 1=
00b latency 100ms",
+            "$TC qdisc replace dev $DUMMY handle 2: parent 1:1 fq_codel li=
mit 1000",
+            [
+                "ping -I $DUMMY -c2 10.10.11.11",
+                1
+            ],
+            "$TC qdisc change dev $DUMMY handle 2: parent 1:1 fq_codel lim=
it 1"
+        ],
+        "cmdUnderTest": "$TC qdisc del dev $DUMMY handle 2: parent 1:1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
+        "matchPattern": "backlog 0b 0p",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
+    {
+        "id": "21c3",
+        "name": "Test TBF with FQ_PIE Backlog Accounting in gso_skb case a=
gainst underflow",
+        "category": [
+            "qdisc",
+            "tbf",
+            "fq_pie"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin"
+            ]
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.11.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: tbf rate 8bit burst 1=
00b latency 100ms",
+            "$TC qdisc replace dev $DUMMY handle 2: parent 1:1 fq_pie limi=
t 1000",
+            [
+                "ping -I $DUMMY -c2 10.10.11.11",
+                1
+            ],
+            "$TC qdisc change dev $DUMMY handle 2: parent 1:1 fq_pie limit=
 1"
+        ],
+        "cmdUnderTest": "$TC qdisc del dev $DUMMY handle 2: parent 1:1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
+        "matchPattern": "backlog 0b 0p",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
+    },
     {
         "id": "a4bb",
         "name": "Test FQ_CODEL with HTB parent - force packet drop with em=
pty queue",
--=20
2.43.0



