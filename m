Return-Path: <netdev+bounces-200511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40526AE5C44
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 07:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F125189E5BC
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 05:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E681F242D99;
	Tue, 24 Jun 2025 05:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="gU+c/rkw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10625.protonmail.ch (mail-10625.protonmail.ch [79.135.106.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A072523C8D5
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 05:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750744728; cv=none; b=Wnpy9eLYRoMVbADV+3Xfh2V4/5WV9OMAm9yc3nmM1vRJHH/CAM8jkDCZNDCgbpLBjeLV7z+Se1Uf/8sTt42ISRUS+fUlNbXov37IZEimxPbuYR5okgAzEluczzsDyxO5DUNzgpNxuWAby7o5LwcVlY9qm9zpjsYgcFweTCbPh6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750744728; c=relaxed/simple;
	bh=PGUxgafawITU9oJKUlvjkZJMxiTsHxs04axFJ1wu1qY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EhHSdNoZKosTUoNXDQas1Um7eLS8XVVRfctkWaP7jFW5hP/Czt/A+Swq02Y9hC7I4agrIaXVU7O2kBgOvXxgafxqARWrVK6QEhPoSPPoD6Kx8M+pzcqgEFC+reMdpFNDXFarUh14Y0TzM2Z6YqoEs1ZX/MOnaHs1+ctr66zrnpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=gU+c/rkw; arc=none smtp.client-ip=79.135.106.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1750744720; x=1751003920;
	bh=jlhiM7eGqAoWV6RLRZcoBqaGLEBaI4IW4+LXCbueE+Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=gU+c/rkwOgBzkzIAPwqUIn6wod22qmdaSA6tDf4V2hObdXdu3oAUrU9f2eBKrXX7q
	 wPHxJvZaDD+2gVBbCsj+2yiDdRfj5X0nUOEk2iXudlUL/scZJEadQsBMHk3JIzlSIy
	 paaMUWczVRjH5grAeP4T/5cymiSNoaE/hVN2tiWVWp5uY/VZR9fnSvHrswUNrSLmq2
	 ba3TKxj6COjxtstddfDltzHJkZ+bESEPsjrf6/HwbB7cJ5aDyneREmcKRdXjx1lKqO
	 +uGtgESgKMnPYiJy9Rx2Y1YLsWLHBLrdPdUK6ZowQRh8kFQQ4tj8tvWPnQuvqH3SQk
	 tMva7K9L6agaQ==
Date: Tue, 24 Jun 2025 05:58:35 +0000
To: netdev@vger.kernel.org
From: William Liu <will@willsroot.io>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, victor@mojatatu.com, pctammela@mojatatu.com, pabeni@redhat.com, kuba@kernel.org, stephen@networkplumber.org, dcaratti@redhat.com, savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, William Liu <will@willsroot.io>
Subject: [PATCH net v3 2/2] selftests/tc-testing: Add tests for restrictions on netem duplication
Message-ID: <20250624055706.531880-1-will@willsroot.io>
In-Reply-To: <20250624055537.531731-1-will@willsroot.io>
References: <20250624055537.531731-1-will@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 4ecf9eee8ee0ef9054d417776408d31d432f78f4
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
v1 -> v2: https://lore.kernel.org/all/20250622190344.446090-2-will@willsroo=
t.io/
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



