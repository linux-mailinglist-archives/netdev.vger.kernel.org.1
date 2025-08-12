Return-Path: <netdev+bounces-213123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0EDB23CDC
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 02:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B0F585458
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 23:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1236F2E9EC1;
	Tue, 12 Aug 2025 23:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="O/czVvYk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97762D6E6E
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 23:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755043122; cv=none; b=lhNFQ5pZc9Fo2j002n+4zLG9xiJQ8bkwwa6xqMyWB7wmm3yik/+GJlkJlb5bhAFAuq6JV0TsEyGdAQeUBBlBau89sPD3PUJzmn+umrfbdCEeCfanP9eRtnkA2QHtJyDE/xOgCwz9Sl9PzM/hckhb3phHjg0aUo/ldcHIHDDNgw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755043122; c=relaxed/simple;
	bh=rXuDJyer3xJ0CfepDrjtw53lITk8HLGl2RLZWQIqPiU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdt8X7AZnrg3+M8O4zg0CxpmdrBei3UouKl5cm4Hkt0aiSME7e49Nh605qu3rRWAXCp5DMZd1fJqeuGz0z/uC+udk2bI71mOFR4yo7y95jg2yRz6QwzPqGK6iPk8QCgh7soTvOOVIurvFoWrNs9uU338DSdkPut30LfUy9sgCyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=O/czVvYk; arc=none smtp.client-ip=109.224.244.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail2; t=1755043111; x=1755302311;
	bh=uZO25XDKGi7u1uY/94p7XG9fnODDOi9Tq81QLfiaMWk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=O/czVvYky9foIWDRi8Gzlds4cYcSzrJSYRY2f1/S6flYj3c8SxJGJb/XFKF8JqQGp
	 JyQwJ4RPxiyUI9t+e0h4A8QHfhuTJqq66kF+5N6fGTOX4nRJvSPqJcvFdzHmLHHPKW
	 RlW4GOesc1k9mQ+zUPBTMnbBncBlYwzWI7O1jNcjLF27V8x2IloF59uAVeDO9A7GmK
	 1DeFvF1Z8ttuvSvtXnmgU7tg3PiQCTyVF2pQrB1E5YvWv9FDpuo5A++DbiQh0ChVhK
	 F41FYhNVe43pVCw7N10YcI+N4VxJwd0n68hOc7F9/JaJ73Fm6zEGRzyVtd5ic+tJw8
	 +wrpIB1liUjFQ==
Date: Tue, 12 Aug 2025 23:58:26 +0000
To: netdev@vger.kernel.org
From: William Liu <will@willsroot.io>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, kuba@kernel.org, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, savy@syst3mfailure.io, victor@mojatatu.com, William Liu <will@willsroot.io>
Subject: [PATCH net v5 2/2] selftests/tc-testing: Check backlog stats in gso_skb case
Message-ID: <20250812235808.45281-1-will@willsroot.io>
In-Reply-To: <20250812235725.45243-1-will@willsroot.io>
References: <20250812235725.45243-1-will@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 36a83b8b8ce2f9356c44c1a6a95880c4484371f2
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
index 23a61e5b99d0..998e5a2f4579 100644
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



