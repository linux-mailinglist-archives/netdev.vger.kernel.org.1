Return-Path: <netdev+bounces-250815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 817FCD39302
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 07:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8CE73017394
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 06:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F59325782D;
	Sun, 18 Jan 2026 06:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNg3PePI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816E4213254
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 06:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768716976; cv=none; b=Dm/euBw+ZGdwDXaIPb/8ckjs/Uy1/XMiJLUH8cRiyP6lIxK3HAcqnUMxQl1PavyZOyGFDU3b2Du5HHRv1wdwHaMUN318WSU270lXJgAw/4nOBguygqYHM4x13kC0GaCr8QinFTp6kEohrTQDF0Z3J8Veb2QVtxbAxhdPRScJSsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768716976; c=relaxed/simple;
	bh=yXG4SKv46TCg3Ss3UQOqfMe0QiUpY96uny6dFAINQW0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wu5mam4b0SwMhOshgF/dD92PN1pOi3upwY1ZPcLYxeyELIsuO6kNlTlgwo2YvAqjGDxvbfdGmgnsWNLObCId/66AVHt1X2wHPBz0hJBdD3h8Fkd2kYpJgidy2YVkq4eDiskGdkakciSaWfrLzyJ7Vh0IBy9ISkz9t0vlA72WOTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNg3PePI; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b1981ca515so3637030eec.1
        for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 22:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768716971; x=1769321771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gie8zJACIa1xTFGT2JT+VPiomEmMD+esJjoH03t/RHk=;
        b=LNg3PePIhCjcZY/vMHfJHrU7aD9iPyOqzTHAzSwEgSL3NvjSmAReiLHnUzt337fkBG
         GD5oKKyVMBvV9UXr9heCPqRRJrufDmuovYIiNM1uVOG5mpVNY4sMnFKpczgk5GbiNZJs
         PKXOtsF4qgucvuxIAdGqZdXiVMY2bPshJpmgAWBrryEia6H6WM08/RxHdnMtl3V32Gi5
         SUfeGTETbiw85/cvYGMngV+8SNGyhuauki+/WpKDE+VvmbdgO9rgo9+fQgixwGIcHWRt
         4oDIYJNwXgP5YKfXM8gT4xFT6JfLLng0jaMwnFr5lsUKxAvxXhtH/O0eGXx5RcyQcDby
         lIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768716971; x=1769321771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gie8zJACIa1xTFGT2JT+VPiomEmMD+esJjoH03t/RHk=;
        b=AvowKcUKVOUsAA19sQUEV+Tvpoqf+iMQk0SEUo5TNNLkGkOzdgiMBrtLdCFR9Cp7CH
         528hjuYqZ2Ow7wCKOc8KcelO3E7Ra4JL/nYe+apmvgL1TqrR0Ge/kQY4z6x9KsfKcvU4
         4YIPzmtAPUjmjpe0jSe2InVU8fj1l0VjNqM9xpANt0Yvcy7+ZhbyAZtW2hLBIX3Do9aj
         ITlbsHazR9TPFfFHHWEtUyyTW3+hdpTX8W677rJjYeQ1YU1sZ+tedCZ7MgnUYaQI1SS/
         7MbNNrUHylhSdeO/idFcLAT6A7IvsCCqWIfPGOIrk+5vqSc9l9qOUaXz2adKMeeZBQ9A
         f3wQ==
X-Gm-Message-State: AOJu0Yyobqj3lYn+ifOd2uNKYKmXzuzbqbWemme1Hn9ZXloyDmaXEqkc
	qaRz+a63029DZpwjNHCVZ5xcOuAvXs14eEE1M3kZ+satJ74nleZCyCMM/Kk7jQ==
X-Gm-Gg: AY/fxX4y3p5xDCILcrYhuhm0fU8bSsxdKK1T/cgbRrDabaru8ntnJqLcxSsSGvcLcyd
	korcvybkkwl7PR3q1u/FRyVFymBuDkjBoNyS1gopDKBfZZhmD0lbsEHys9YeQc451g//5R1SIHy
	4jxmbP6SlmHb1JrSCFyeR86Wtp5IhIPakQvybLAHLEaaoKh4S4DuLxtHztFftKd9bdHAdv0sdco
	Z5iI2nUKNRJDDlPTHrM/S4Fp+27qa12vm0T1iDrSsRy2YWlOx5kCa3x3Z7YI1oXGxL0b+dbcBow
	RV0qi2Ic6Bpunyh1sZ0QcZHTuuzUVWePTm9P2QU76ndwOxTw0QV2YfqV6+MU9U3k4kuAnQMtX8v
	+eLAmHbjk8ynYZKIAZJXxG2MDoIzItvMycNLXWFO2UqU7CRqaK6ewOoxLdnc4/Z6dVibykL8j8C
	5ggIuY2/n8PJ3sC2UR
X-Received: by 2002:a05:7301:5f85:b0:2ab:ca55:b760 with SMTP id 5a478bee46e88-2b6b410bce9mr7241340eec.43.1768716970759;
        Sat, 17 Jan 2026 22:16:10 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:8fdd:4695:1309:5b93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c65sm8163816eec.8.2026.01.17.22.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 22:16:09 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net v8 8/9] selftests/tc-testing: Update test cases with netem duplicate
Date: Sat, 17 Jan 2026 22:15:14 -0800
Message-Id: <20260118061515.930322-9-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260118061515.930322-1-xiyou.wangcong@gmail.com>
References: <20260118061515.930322-1-xiyou.wangcong@gmail.com>
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
 .../tc-testing/tc-tests/infra/qdiscs.json     | 50 +++++++++----------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 57e6b5f35070..6cecea3f25ee 100644
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
@@ -748,11 +744,11 @@
         ],
         "cmdUnderTest": "ping -c 1 -I $DUMMY 10.10.10.1 > /dev/null || true",
         "expExitCode": "0",
-        "verifyCmd": "$TC -j -s qdisc ls dev $DUMMY handle 1:0",
+        "verifyCmd": "$TC -j -s qdisc ls dev $DUMMY handle 3:0",
         "matchJSON": [
             {
-                "kind": "drr",
-                "handle": "1:",
+                "kind": "netem",
+                "handle": "3:",
                 "bytes": 196,
                 "packets": 2
             }
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


