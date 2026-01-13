Return-Path: <netdev+bounces-249562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B99E2D1AF43
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 20:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D69ED3042922
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 19:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF494359F93;
	Tue, 13 Jan 2026 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2FyjDtZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B174359F89
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 19:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768331224; cv=none; b=RE0obeNLusYect+vctVwPUFoKoADjXhtZnXhTwRb47deG2Tm9yYMb3z82oP+DL1+gcUeD8Yq2suw/NecMPvieQ0+ZMduNCQyBU4j931IsYlvPONdIs7Qv2S96GJY71gUr/wY1w9ftdbaxNixzkX+s6Gqv+kOLstOshBD7PwML2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768331224; c=relaxed/simple;
	bh=f2Dp56JcuO8SzxWcSGXGRTWdbi+S8p9v3e6SZ6vXxbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=txq5S6b5f7mCEl/pDaS1OuJPNjGeGl++FB5vimw2EghFyZ6ZtVt2gSP4UIXkiPhT50i0jsXi7DMWZgtfPiOuwW7eIV9oJzymmhzr4mDGnIi6fJNMQW1K7EgJTrentNmcwzIuFzPN32WpDyYQILZQd5b2pke7A3pFZglXDyI/0OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2FyjDtZ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-81df6a302b1so3970663b3a.2
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 11:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768331222; x=1768936022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDLnpR1C4e+mRON7rrEpPzbGp1tPN24IAG9kSh0/5wA=;
        b=V2FyjDtZPms4XqDlTXEz26uGsdaNOy/n00aWZzBsFAsh17SJLDpPNXJvrWMtAo90Wf
         r6vjHfFBNnLkm+Tzq2Vcw86BR9cwBSA1Io96yf5QOw6RTMJrEgRUuHJcewf881cn5voP
         HCcNf6D6k3LbXwv8wxvUqOmsI2Ir9ME4itxiojzBBRmesB4t5Y9nhMa6+WrPCMGv2IYr
         Tw1hqONG/NEQ8YxqF8joqXB9o+/aRNPvDScFMt7wqEc2yRuiBkwQ/3P7zo5umVE+nnNO
         xir/y/HSyQaz0EoS5zYc9QmIejS9qbTtKAoTB/7JUlwtY6ojZ3ygKGYN0l1XJnqT641m
         Dl/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768331222; x=1768936022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MDLnpR1C4e+mRON7rrEpPzbGp1tPN24IAG9kSh0/5wA=;
        b=hVDLF85LP5KlgpeM2uh0SzPr2hbf5qSSPnYMbszRBzLzV/QttfhSAcW2aBvDuwRC6p
         Xu+N75Q0KHDezFvfNXXS+WL3+eknoUq+/EwRnBMbXU/58CqU+y1+sLIbXuWah2OAyKeV
         ll/lHZ3E9JkKnEbRFsNgIs4ZmngQHzC0BMj8WNt66sCRqNSd5YI3pZLEPeBiWFJH3OVO
         FQcyHahPskV53tFBTHDQkAMMvO8oYVbJuAx9v8G6g2N4XkCK8LmetyKinrNzbuOf1Qs1
         /vZFqik/KgvMP9YcjHPG8i6MPODkVAnNETUUfVeOOL0dQUv9TUOuGKqO8VM2QnRkNJZe
         LWMw==
X-Gm-Message-State: AOJu0Ywn1v2bNPIOQjH2dqhW51tBvxdcemQTwENHt2n2LRgDkwokJ0TR
	O9kN/4U93ngsfUA9Tp95ENIoJ9rD9VKl0NC/0h6oDlKo5JUEouK1qQpAGHq5hg==
X-Gm-Gg: AY/fxX4aJvmvyJeNskpFj0zeT/YSrnijFlQnn0JwB7R62yh+V/hkSzDOjAThUcSBm9s
	/FZOF3HWK7pZwzmMJ1h05nRrYuCRbGFBzZ5cmtD9kk1mteRo1YLxWUXP+QzwEKjZBaLtqFrn+qg
	PuF89bPlthVq1Dg2GK4dPJCaWkLLaBMhrnxP39V1V0tx/WPlh8gMUzGsjaQbLSp+h2w1Z8KaJN5
	2B3MbSwKqikNg+Rm+X1ado3d6fDORlfditf8s4CdAtsDsvAehZGSk+lYmF+Wi/9pdJDIuetjoJP
	SwvZ5u3QIR3BO3E2PZjkR0i5JYgbhd2yPv9C5y25MPPvaBpi6rawCs8tZH0Z4EfjetCGnpVC9D1
	SrWgQPuZTMEX/TmDO/n5AV9bDMVD28ph1ucEcFjodhCm+1wHvQsdJr1U3sCgEc0y1mLHKqkG9gC
	QDeNS/YdgLlqwCXEE7
X-Google-Smtp-Source: AGHT+IEeTgAIhvM7/nWM7cUtXUFTvyzIxC4cu11SLGGYpFe+WGndj/LkdG3ajCcSoJBvoEble+n1qg==
X-Received: by 2002:a05:6a00:328f:b0:7e8:43f5:bd0e with SMTP id d2e1a72fcca58-81b7f4ed870mr18741969b3a.35.1768331222505;
        Tue, 13 Jan 2026 11:07:02 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:7269:2bf1:da7f:a929])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8058d144sm187780b3a.51.2026.01.13.11.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 11:07:01 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net v7 8/9] selftests/tc-testing: Update test cases with netem duplicate
Date: Tue, 13 Jan 2026 11:06:33 -0800
Message-Id: <20260113190634.681734-9-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260113190634.681734-1-xiyou.wangcong@gmail.com>
References: <20260113190634.681734-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now netem does no longer trigger reentrant behaviour of its upper
qdiscs, the whole architecture becomes more solid and less error prone.

Keep these test cases since one of them still sucessfully caught a bug
in QFQ qdisc, but update them to the new netem enqueue behavior.

Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 54 +++++++++----------
 1 file changed, 25 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 57e6b5f35070..4ebdb27e39b3 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -579,7 +579,7 @@
     },
     {
         "id": "90ec",
-        "name": "Test DRR's enqueue reentrant behaviour with netem",
+        "name": "Test DRR with NETEM duplication",
         "category": [
             "qdisc",
             "drr"
@@ -597,11 +597,11 @@
         ],
         "cmdUnderTest": "ping -c 1 -I $DUMMY 10.10.10.1 > /dev/null || true",
         "expExitCode": "0",
-        "verifyCmd": "$TC -j -s qdisc ls dev $DUMMY handle 1:0",
+        "verifyCmd": "$TC -j -s qdisc ls dev $DUMMY handle 2:0",
         "matchJSON": [
             {
-                "kind": "drr",
-                "handle": "1:",
+                "kind": "netem",
+                "handle": "2:",
                 "bytes": 196,
                 "packets": 2
             }
@@ -614,7 +614,7 @@
     },
     {
         "id": "1f1f",
-        "name": "Test ETS's enqueue reentrant behaviour with netem",
+        "name": "Test ETS with NETEM duplication",
         "category": [
             "qdisc",
             "ets"
@@ -632,15 +632,13 @@
         ],
         "cmdUnderTest": "ping -c 1 -I $DUMMY 10.10.10.1 > /dev/null || true",
         "expExitCode": "0",
-        "verifyCmd": "$TC -j -s class show dev $DUMMY",
+        "verifyCmd": "$TC -j -s qdisc show dev $DUMMY handle 2:0",
         "matchJSON": [
             {
-                "class": "ets",
-                "handle": "1:1",
-                "stats": {
-                    "bytes": 196,
-                    "packets": 2
-                }
+                "kind": "netem",
+                "handle": "2:",
+                "bytes": 196,
+                "packets": 2
             }
         ],
         "matchCount": "1",
@@ -651,7 +649,7 @@
     },
     {
         "id": "5e6d",
-        "name": "Test QFQ's enqueue reentrant behaviour with netem",
+        "name": "Test QFQ with NETEM duplication",
         "category": [
             "qdisc",
             "qfq"
@@ -669,11 +667,11 @@
         ],
         "cmdUnderTest": "ping -c 1 -I $DUMMY 10.10.10.1 > /dev/null || true",
         "expExitCode": "0",
-        "verifyCmd": "$TC -j -s qdisc ls dev $DUMMY handle 1:0",
+        "verifyCmd": "$TC -j -s qdisc ls dev $DUMMY handle 2:0",
         "matchJSON": [
             {
-                "kind": "qfq",
-                "handle": "1:",
+                "kind": "netem",
+                "handle": "2:",
                 "bytes": 196,
                 "packets": 2
             }
@@ -686,7 +684,7 @@
     },
     {
         "id": "bf1d",
-        "name": "Test HFSC's enqueue reentrant behaviour with netem",
+        "name": "Test HFSC with NETEM duplication",
         "category": [
             "qdisc",
             "hfsc"
@@ -710,13 +708,11 @@
         ],
         "cmdUnderTest": "ping -c 1 10.10.10.2 -I$DUMMY > /dev/null || true",
         "expExitCode": "0",
-        "verifyCmd": "$TC -j -s qdisc ls dev $DUMMY handle 1:0",
+        "verifyCmd": "$TC -j -s qdisc ls dev $DUMMY handle 3:0",
         "matchJSON": [
             {
-                "kind": "hfsc",
-                "handle": "1:",
-                "bytes": 392,
-                "packets": 4
+                "kind": "netem",
+                "handle": "3:"
             }
         ],
         "matchCount": "1",
@@ -727,7 +723,7 @@
     },
     {
         "id": "7c3b",
-        "name": "Test nested DRR's enqueue reentrant behaviour with netem",
+        "name": "Test nested DRR with NETEM duplication",
         "category": [
             "qdisc",
             "drr"
@@ -748,13 +744,13 @@
         ],
         "cmdUnderTest": "ping -c 1 -I $DUMMY 10.10.10.1 > /dev/null || true",
         "expExitCode": "0",
-        "verifyCmd": "$TC -j -s qdisc ls dev $DUMMY handle 1:0",
+        "verifyCmd": "$TC -j -s qdisc ls dev $DUMMY handle 3:0",
         "matchJSON": [
             {
-                "kind": "drr",
-                "handle": "1:",
-                "bytes": 196,
-                "packets": 2
+                "kind": "netem",
+                "handle": "3:",
+                "bytes": 98,
+                "packets": 1
             }
         ],
         "matchCount": "1",
@@ -827,7 +823,7 @@
     },
     {
         "id": "309e",
-        "name": "Test HFSC eltree double add with reentrant enqueue behaviour on netem",
+        "name": "Test complex HFSC with NETEM duplication",
         "category": [
             "qdisc",
             "hfsc"
-- 
2.34.1


