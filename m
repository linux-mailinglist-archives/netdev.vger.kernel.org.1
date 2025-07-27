Return-Path: <netdev+bounces-210415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DDAB1328C
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 01:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE0E174DA9
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 23:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFFE25228D;
	Sun, 27 Jul 2025 23:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="CGQt7ErB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF5D24C676
	for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 23:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753660647; cv=none; b=jpuXE1acglYqwR1p1WXTCOfNvntAFRXlRdvkp80Xu5BFMtife1YwwkS99DsZBy25SFQ/3ROYNBrat2U0BQSlyEgvbNTAMXDpIIF45bU13azjYA/raeTO3SXG1hshUca+n3w4hyIctmfjjC2Yv0UcAHhXab/yIbqeG+uwl0w7osY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753660647; c=relaxed/simple;
	bh=/5UgpumCN8IrYGClXUK3J48/YZx8XyXQbhDAJfzaqtg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ijj0GiFn5Qdu0q/1OffJ3C5Wx+YnUU3V6DKe43qe4vSaGfTJ4bM5YbFzGAGYOwX8wHy5e0qCyNa19xn3xhssiNwHrm0HMiGxXse+rsR1v5cbypABvZ9wya+4aMG7NvPqSgvkp2ZxEC5G4ylEqA9nsMphTyGJaSjv+eutuD2+wbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=CGQt7ErB; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail2; t=1753660637; x=1753919837;
	bh=o2XIJBuRkM7KtY0xtOtzZbweDQrM9GacTwEP1PuO8cY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=CGQt7ErBOFif5du2KYsLAkSgEs3vPbP8vM2CXv4sOMd4MdAlmHw5Jts2+YK9sTvgc
	 6PgRco/sWtLKChDtBf09Rz/9a/WSgp3n5wWTKaO657Xufei3VcEvya3jbbtys91Ufu
	 755kmwimDaEOnz+MT1iPZLdc75apNq7n7JFpgKbaRJJM6tAdJ9JxwL3nmyH3DMvNGq
	 Kd+P/1OYLgszz8y/FHR/UDlqjcx7hXOdsPr5qh52aVGBUPkuZqo7R1njajcEjOa8Rg
	 CBaLWtUeGkFYxwCLaqGwcomGQYpw2jXzrlmbSTagRXH7r+Yin/D92kVFLlG3SOnupG
	 /Tx4DNnkdV8Kg==
Date: Sun, 27 Jul 2025 23:57:10 +0000
To: netdev@vger.kernel.org
From: William Liu <will@willsroot.io>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, kuba@kernel.org, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, savy@syst3mfailure.io, victor@mojatatu.com, William Liu <will@willsroot.io>
Subject: [PATCH net v4 2/2] selftests/tc-testing: Check backlog stats in gso_skb case
Message-ID: <20250727235642.216527-1-will@willsroot.io>
In-Reply-To: <20250727235602.216450-1-will@willsroot.io>
References: <20250727235602.216450-1-will@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 948cce2fcfca3fae34819719cd936bf4a33bfb69
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add tests to ensure proper backlog accounting in hhf, codel, pie, fq,
fq_pie, and fq_codel qdiscs. We check for the bug pattern originally
found in fq, fq_pie, and fq_codel, which was an underflow in the tbf
parent backlog stats upon child qdisc removal.

Signed-off-by: William Liu <will@willsroot.io>
Reviewed-by: Savino Dicanosa <savy@syst3mfailure.io>
---
v3 -> v4:
  - Unify tests to check against underflow in tbf stats on purge
v2 -> v3:
  - Simplify ping command in test cases
  - Remove scapyPlugin dependency
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 198 ++++++++++++++++++
 1 file changed, 198 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json =
b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index c6db7fa94f55..14c6224866e8 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -185,6 +185,204 @@
             "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
         ]
     },
+    {
+        "id": "34c0",
+        "name": "Test TBF with HHF Backlog Accounting in gso_skb case agai=
nst underflow",
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
+            ],
+            "$TC qdisc change dev $DUMMY handle 2: parent 1:1 hhf limit 1"
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
+        "id": "fd68",
+        "name": "Test TBF with CODEL Backlog Accounting in gso_skb case ag=
ainst underflow",
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
+            ],
+            "$TC qdisc change dev $DUMMY handle 2: parent 1:1 codel limit =
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
+    {
+        "id": "514e",
+        "name": "Test TBF with PIE Backlog Accounting in gso_skb case agai=
nst underflow",
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
+            ],
+            "$TC qdisc change dev $DUMMY handle 2: parent 1:1 pie limit 1"
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



