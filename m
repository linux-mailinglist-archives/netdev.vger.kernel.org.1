Return-Path: <netdev+bounces-208336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BE5B0B141
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 20:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF6C16F2BD
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 18:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866EC28750F;
	Sat, 19 Jul 2025 18:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="G+FiDcGk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10624.protonmail.ch (mail-10624.protonmail.ch [79.135.106.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB1D19E806
	for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752948534; cv=none; b=Rez563j2fJoy1nONa0GDlZzEgyPi+z3txVNp4HAKhx/lxlB0BTpyc1NXtxK1vRog3tqtkuYv7y/ohEfD3zsj57vm+HI7ujO1N42P+08CvlEw8VCQ8XEYsq85vrlTDnkYMyX5/BWX1TQqk0quJ/1+P0ad2dYqHh5o6kU0xJ+eVSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752948534; c=relaxed/simple;
	bh=iqm/OYtfOPclwUYLAETaKoJ8BpJPg0xIMtE90PVnoR0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1cuOzvUZndywj7z7UgSvCL8pEPw01YeefEDOXfTfhLWbm4MKAGNPq/04I0L0nOk5+aymMni+EG/bQH2ln2/bvYP0DU7pUWoTZcTR7z9BsAdLUlF3QBQK2KUIl2PmABFaRoLdh2QMdCeuRFB1cym/HGnlOstAv88FnfItKxafVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=G+FiDcGk; arc=none smtp.client-ip=79.135.106.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1752948524; x=1753207724;
	bh=ZBp34tqxxYA9JsG+z0lIT30r7T3akk9BPIkC/OSKalQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=G+FiDcGk6DWyu4FySDk9ESkha23/nDN0g6U5RXp+XBsYZegy8AyL4PdRmFi3ybq94
	 L8OHd88DzY2P2Y3zClbhU4BWIT3bnO/CjVsOVSkhoZVDwR466oW+N04swmeHpVMzDl
	 EjIwZir4pGEDCHJ+HOTXeK36DVv5EykRPlbrJNB0Zki46pCYfYtr3sYDj9zr6KSw+7
	 9ADMUAdYYCWlucMZXPn8s/Mhuf8A2wRraYIU3gYC7/KaNcU3uAe6Hj5A7bB+32W7ka
	 Ig2I+k3WX443Ft1h2TRAWm0Y37YGWa1QGcuh4XCH2P9gZKafKXvFqxC5FBL0IqquxB
	 Fcngb39hXVIxQ==
Date: Sat, 19 Jul 2025 18:08:38 +0000
To: netdev@vger.kernel.org
From: William Liu <will@willsroot.io>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, kuba@kernel.org, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, savy@syst3mfailure.io, William Liu <will@willsroot.io>
Subject: [PATCH net 2/2] selftests/tc-testing: Check backlog stats in gso_skb case
Message-ID: <20250719180819.189347-1-will@willsroot.io>
In-Reply-To: <20250719180746.189247-1-will@willsroot.io>
References: <20250719180746.189247-1-will@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 3974d6b592a791b3061830651ca70219ea4a5940
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



