Return-Path: <netdev+bounces-209823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D4EB10FFD
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 18:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD0D117FE36
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 16:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E397B2EA754;
	Thu, 24 Jul 2025 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="HmsGoX9W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2722E543E
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 16:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753376165; cv=none; b=hcq18+EqA9GdYblpjQa297UCtq51nbnAWqQHV7i7pB9UOkwJSDkiMVf7muJn9mX/jt1Mcns3o+LOBOL/2fhKd1oqFdc2+p7+d4PYOs1vWzNiSrNEUFMqmGY/p4i49enltUR1wMHTiT2s+hUWLJqiQrNxZuAXguoZ/TXUfuowM28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753376165; c=relaxed/simple;
	bh=iqm/OYtfOPclwUYLAETaKoJ8BpJPg0xIMtE90PVnoR0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EIlKx5GOF8Umw6g/ESr60eRznplL9Ixzzy5fBrMeSBIsQw6g1rvyNc1xa/oDuufyfJTfytaVtyddkbHGH/dAtWoFsht9iTxFivzMBX0mjvzXw2OaJsAczGnlIZfxy7xDTm+ErWJvKPaWStvEBqWzAvByRqfUz7HTv/SbIYEtXBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=HmsGoX9W; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail2; t=1753376160; x=1753635360;
	bh=ZBp34tqxxYA9JsG+z0lIT30r7T3akk9BPIkC/OSKalQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=HmsGoX9WxfLfkctLbJSSwE377QimjZXjV31UC9WVo2w8nxhAbziUsZsb6ptDhOiEI
	 TIsakA866JumHkRnDqBDSKJR5NtWQJTjTPXFCX5VOMKa+H/RBNHRONAKmV/Ucpjwrr
	 dqscZKHHqyl8PK30I5ip2zsKRts1//Wg58FTV7/42ETn6GOvrqagnyQlJ9UcadEceP
	 x/IW7m0r9qXDOwlYbIZ/4QSuyzjE1SpsAyQBzWZT8Y6/iNCmCQmUUi85Wwguu4diVe
	 MjD1l4QE6+vz/hfLrNXHARCYYyo00+UyKXmxa8mg8iuLviI7YaxGjsjZYo9Xni/ixA
	 2LCI1B9P3y6nQ==
Date: Thu, 24 Jul 2025 16:55:53 +0000
To: netdev@vger.kernel.org
From: William Liu <will@willsroot.io>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, kuba@kernel.org, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, savy@syst3mfailure.io, William Liu <will@willsroot.io>
Subject: [PATCH net v2 2/2] selftests/tc-testing: Check backlog stats in gso_skb case
Message-ID: <20250724165530.20862-1-will@willsroot.io>
In-Reply-To: <20250724165507.20789-1-will@willsroot.io>
References: <20250724165507.20789-1-will@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: c099e1226bc0ed28f0a4ad96f5734be5223c0283
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
 .../tc-testing/tc-tests/infra/qdiscs.json     | 201 ++++++++++++++++++
 1 file changed, 201 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json =
b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index c6db7fa94f55..867654a31a95 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -185,6 +185,207 @@
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
+                "nsPlugin",
+                "scapyPlugin"
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
+                "ping -I $DUMMY  -f -c8 -s32 -W0.001 10.10.11.11",
+                1
+            ]
+        ],
+        "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 2: parent 1:1 =
hhf limit 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
+        "matchPattern": "backlog 74b 1p",
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
+                "nsPlugin",
+                "scapyPlugin"
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
+                "ping -I $DUMMY  -f -c8 -s32 -W0.001 10.10.11.11",
+                1
+            ]
+        ],
+        "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 2: parent 1:1 =
codel limit 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
+        "matchPattern": "backlog 74b 1p",
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
+                "nsPlugin",
+                "scapyPlugin"
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
+                "ping -I $DUMMY  -f -c8 -s32 -W0.001 10.10.11.11",
+                1
+            ]
+        ],
+        "cmdUnderTest": "$TC qdisc change dev $DUMMY handle 2: parent 1:1 =
pie limit 1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
+        "matchPattern": "backlog 74b 1p",
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
+                "nsPlugin",
+                "scapyPlugin"
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
+                "ping -I $DUMMY  -f -c8 -s32 -W0.001 10.10.11.11",
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
+                "nsPlugin",
+                "scapyPlugin"
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
+                "ping -I $DUMMY  -f -c8 -s32 -W0.001 10.10.11.11",
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
+                "nsPlugin",
+                "scapyPlugin"
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
+                "ping -I $DUMMY  -f -c8 -s32 -W0.001 10.10.11.11",
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



