Return-Path: <netdev+bounces-208365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A97B0B237
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 00:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6437AA5C09
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 22:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942452877CD;
	Sat, 19 Jul 2025 22:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mv7mXIue"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C14287501
	for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 22:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752962660; cv=none; b=Un68ODbfeIYOi2ZQLKyAkVCoE1xJJbdyeNAH/MY1dev7VleKSASN9h4fn3Rf3vzsg1MegJtABwAD4SPKAdbZehndVQHjr+sGSkIiG+BfmP2N6vFndigWK0AvXKHlyIoP0rinRgluypVXWJzoF5Bo+AUxGLTdylUhSTg6cS6U/aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752962660; c=relaxed/simple;
	bh=NIJwj1KUqebYq9wnpG4k33u+xdZqOnyuoe14DrnaOCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CSY5XuV2K6thCIfGrnS0zcU06S9VZCTX0POOE6/VZEGN1R/mek8lEP+YxoX+RqX1SWQf4MOmd4/NrCBbDcftqB4fcG9CVClEoil2i10ansKIxS33mYbwKwHhAT0gpQrGD2CXjZg9d4Sqpl0/ojdLuB/jpAdIel7ydEGXrg4Ard0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mv7mXIue; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b3182c6d03bso3541220a12.0
        for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 15:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752962658; x=1753567458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86/t1stt11+d+8nXSfBfU7cYLW7Df8DGQxNWQ/zsm5w=;
        b=Mv7mXIuewYRXf27fWqrYz7zIGQqHMsWuzio1Id4w3Q4RDN1sCCwK+yiJgCJlaF+Zav
         V1/pYmnQHSUocSBGskW9Pwb8zaqHTcKeku8dhtPmCTAi8K6PSX7cdFaX8RZAT3uROs6J
         UGNfIhgKSW2Yt0EujqlfAaPKB6TbqO5g1wcK6Fs571xhGRaXRe7faas4EjwgXIXLypUw
         yWbHRyV/5zEO2XFJ0/D6tHP2TjHJK/8YRu967RvDwiYTmCDtAFRX4hoSVIjn8/wudrzJ
         LH4rjEpKd4SodM8OUtX4HIw/UnVG94WgnB3dTFLDA67XndeXsE4rrRnps9/vg3/xKUrK
         sKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752962658; x=1753567458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86/t1stt11+d+8nXSfBfU7cYLW7Df8DGQxNWQ/zsm5w=;
        b=qWgXkJyp/PZgLV7FkHxTMZgrlGT5tKaDNlXbiHO7d32aefD0aMZQAySXQtAU3Usz6L
         6nm+7Q4l3WIz9Oqmbt6zowKL0B2aYY84esO8Oq7c6bxSNicyXx9OZU49KQgJdkdquGrl
         G2Q40cx1bvadDdGvycMaUcGrnGNwrLyzvl5w9ujoxIElazcTjNxnmhb+rBKNKHvMCWv7
         kcB35QaGMSqJpOEdvBjIDa969xGH0mvya2KL+DFPMw401Zzl4wgkIatQDWEKv9j0YCHI
         2l5i0agB5SjmdWKqVVvkvD8Mk0aLmjBbIJHla6wgCtDlXWzjhY4UVEunrhzsAbfE8/H8
         HUqA==
X-Gm-Message-State: AOJu0YxA8As4I+gmhdkQgUt4zj1mhvHhr5w7w5oGXPX5yJGE4XzgrwR8
	27EjIrq3Wwd1QXee4GBxEx/YyOQ8pH0/gHpEJMJcTcHNpNJqy5AQ7JNBJpSvWA==
X-Gm-Gg: ASbGnctbKq4+8TGqRvCYn99l5SHQ7y7xTFxCDjw1NCw8/DRWnQMQG6tH2byA03YR+2H
	lbdzulSLQhC7xgMYVl8B3cmUdwxhpAThrHS/3HuWI/44yQx6/b7PkgbMTqSylYxP2U/00421Z07
	rtx1vVH4K0yb0VR/Zdksal6hrkUB1rcu9K4MbkYrzNO3SlBFuRbH4ckLZFVFDZ46a7JKoflrF2x
	iAITfAGADu3EPXKIsSGGaf3aPUru2THhIvleZmJWqVuQdLTsyiD8ddj0Dhy4Bk/zvpIxK1BlBHV
	TT9wJLF9uDPWpfie0hlSqxR398wnOvO+reyyghJJ1bJFJfEs+YgZgAS8qvwqVcALSYjqFwvDMCd
	ITqP3U2v9XaKXdQHP9v13xIPBil8=
X-Google-Smtp-Source: AGHT+IFZTqAbfDgqUCGwZHE1j7HsIOLP75Vc7KKPUONX8+G/iUh0+SM6cqEozMLORpJPi1Wu4xBqJw==
X-Received: by 2002:a05:6a21:1709:b0:1f5:79c4:5da6 with SMTP id adf61e73a8af0-2390da529b1mr18494193637.5.1752962657965;
        Sat, 19 Jul 2025 15:04:17 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:b3bf:9327:8494:eee4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe6a09bsm3084040a12.3.2025.07.19.15.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:04:17 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	will@willsroot.io,
	stephen@networkplumber.org,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch v4 net 6/6] selftests/tc-testing: Update test cases with netem duplicate
Date: Sat, 19 Jul 2025 15:03:41 -0700
Message-Id: <20250719220341.1615951-7-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250719220341.1615951-1-xiyou.wangcong@gmail.com>
References: <20250719220341.1615951-1-xiyou.wangcong@gmail.com>
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
index b4a507bc48a3..d43cd3c17526 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -381,7 +381,7 @@
     },
     {
         "id": "90ec",
-        "name": "Test DRR's enqueue reentrant behaviour with netem",
+        "name": "Test DRR with NETEM duplication",
         "category": [
             "qdisc",
             "drr"
@@ -399,11 +399,11 @@
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
@@ -416,7 +416,7 @@
     },
     {
         "id": "1f1f",
-        "name": "Test ETS's enqueue reentrant behaviour with netem",
+        "name": "Test ETS with NETEM duplication",
         "category": [
             "qdisc",
             "ets"
@@ -434,15 +434,13 @@
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
@@ -453,7 +451,7 @@
     },
     {
         "id": "5e6d",
-        "name": "Test QFQ's enqueue reentrant behaviour with netem",
+        "name": "Test QFQ with NETEM duplication",
         "category": [
             "qdisc",
             "qfq"
@@ -471,11 +469,11 @@
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
@@ -488,7 +486,7 @@
     },
     {
         "id": "bf1d",
-        "name": "Test HFSC's enqueue reentrant behaviour with netem",
+        "name": "Test HFSC with NETEM duplication",
         "category": [
             "qdisc",
             "hfsc"
@@ -512,13 +510,11 @@
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
@@ -529,7 +525,7 @@
     },
     {
         "id": "7c3b",
-        "name": "Test nested DRR's enqueue reentrant behaviour with netem",
+        "name": "Test nested DRR with NETEM duplication",
         "category": [
             "qdisc",
             "drr"
@@ -550,13 +546,13 @@
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
@@ -629,7 +625,7 @@
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


