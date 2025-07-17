Return-Path: <netdev+bounces-207684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442D8B082FB
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 04:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C2617268F
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 02:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0871DACA1;
	Thu, 17 Jul 2025 02:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="TU+ZTcve"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260321D554
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 02:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752719394; cv=none; b=DQc1rdCd/8yWM45klLieg/ESZeWHzSd1/bUIw3JV1NzUJPOFVfvLYb0lqPUXRgNYNLPZ4QK9LdPep1tvuRMIHPiho9cGrw6y2EOAekRVb43ToIHSaJ15Por+4nKWhXLxMAzXKT5CKXJ1bG01gR+6Z6cfXuq5JdmdqZvl2U4lV0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752719394; c=relaxed/simple;
	bh=imDDy8bUfAIAh30pWuhk/MpzTbdsV/MUw1CAMBeo550=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JrCWpnKnd/aK91D2z9A524bDsZRP4U9LdzafXuT8Qnxbu7EAVPqsfTGov2owF2/hZmYTzGR6TABOoomniY6ZdhvF/b4q7giUixHelax+vj/cGTwtFaMW9ob7CMae8KOp/iEpELZl/9sCIgnpoBwnFo55vzlNDWVhMNDNINqrgxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=TU+ZTcve; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1752719390; x=1752978590;
	bh=SocjK4Q8cmQ38rKFyvG7uGy8JEHjQSmkbdmMaOJ0GS4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TU+ZTcvecAtXFhEOruvqiv19P9P/8Dbtvl8FvNG0TBFuj19iVc5THbrLUUvCXpHad
	 oA0zwVX+UrT8YJX6b28vYH35xw/6avCGUEO7yOJXlk5H8FeDRfNxkOCeG3H+8zsmeg
	 UedCZRg8il6fZBTOoEuWgH2zWwU18NelnkgETxceg2L3zwanehB10WEYNZsm79XwQD
	 4ZI8rHMcuEbEh5hiUWA1NTH5/cOOsbLtpQrNs5pR4WEunk3cckn2WKDAoWz2fDPFbI
	 aN7c4t3oo2F3qLDXDRLvFqkHip2okmyRlgQpY69jftdhkWllcQ1MUzqanvahJMqDK3
	 J6aWQAnftctQA==
Date: Thu, 17 Jul 2025 02:29:47 +0000
To: netdev@vger.kernel.org
From: William Liu <will@willsroot.io>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, kuba@kernel.org, savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, William Liu <will@willsroot.io>
Subject: [PATCH net v2 2/2] selftests/tc-testing: Test htb_dequeue_tree with deactivation and row emptying
Message-ID: <20250717022912.221426-1-will@willsroot.io>
In-Reply-To: <20250717022816.221364-1-will@willsroot.io>
References: <20250717022816.221364-1-will@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: b33532b6fbfb226163f86b44073f245f29118845
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ensure that any deactivation and row emptying that occurs
during htb_dequeue_tree does not cause a kernel panic.
This scenario originally triggered a kernel BUG_ON, and
we are checking for a graceful fail now.

Signed-off-by: William Liu <will@willsroot.io>
Signed-off-by: Savino Dicanosa <savy@syst3mfailure.io>
---
v1 -> v2:
  - Moved test case to earlier in the file
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json =
b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 5c6851e8d311..c54adc9b3604 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -127,6 +127,32 @@
             "$IP addr del 10.10.10.10/24 dev $DUMMY"
         ]
     },
+    {
+        "id": "5456",
+        "name": "Test htb_dequeue_tree with deactivation and row emptying"=
,
+        "category": [
+            "qdisc",
+            "htb"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.11.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: htb default 1",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 htb rate 64bit=
 ",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 2: netem",
+            "$TC qdisc add dev $DUMMY parent 2:1 handle 3: blackhole"
+        ],
+        "cmdUnderTest": "ping -c1 -W0.01 -I $DUMMY 10.10.11.11",
+        "expExitCode": "1",
+        "verifyCmd": "$TC -j qdisc show dev $DUMMY",
+        "matchJSON": [],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root"
+        ]
+    },
     {
         "id": "c024",
         "name": "Test TBF with SKBPRIO - catch qlen corner cases",
--=20
2.43.0



