Return-Path: <netdev+bounces-246157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45017CE01A2
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 20:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3074303DD0F
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 19:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC09328625;
	Sat, 27 Dec 2025 19:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ki792Lf5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E79232862A
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 19:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766864518; cv=none; b=RJ/YpxxBnFe6ZWK3EzQAvCFQmEPpmfz5QmNOQf4T3MYiwIW5vdfhZPGn4jDOzufRgYeXfWbQJ0O5AQxxcGdFexIrnLi4hAlfhPv3lM96zTBMLFGnQbiR6xztaQ3qmtsxXB64IFmtGzngl+Jn6uWNOHA36h5RpJQzvTXhZWlxyJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766864518; c=relaxed/simple;
	bh=GYRpSMMsWUf3c23IY1A/1Fs5W8qWGjrxFp1vA869jCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d72lb6qyZcIVAQaIqynFTXQYF9tNnSHpqIpxl7BDV15k/fuHvs+9TqgK/NgG8+X/wlbgdCwkmNtCSEh1Jkp6ZEzGJZsCIEOsfiifKWDkUZt8iUs9ZfE7TS0QrYP+ZX8xYBEVaDX62dXRFOPIUqMu+XiiE9MdbZXySNcbCCiFCi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ki792Lf5; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bc274b8b15bso8599503a12.1
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 11:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766864516; x=1767469316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5ukXbXXMF/+gEwMNuIxaLGA4A6pqbideAXXNZpJc28=;
        b=Ki792Lf5DnNs4NxH9eHTIbMTUV6PcPkrqtsctI4abMT3m5ciqBm7LQvuGMogSnMau1
         AX+zircWc1C618KcVFYFOToJo1NbyjpPowml35144j5EOFDmTtmlb+uzFM0uHjsY/Q49
         P7+QZVlyehIbbenw65+ntV6MO570f+nhhJHdEuYXin1AiKEF8Fdppu5SdoGaPF8v5LX4
         57BdecpVq4jWhOsD6V3zTxLqn+ULkZ0etJy5sECS63wV0aQZBXRf4pNtbwDTTlNjBtRh
         hD3arYjfsyZYgF2mtckH+R8WQooCXQkp9I/IT6sE9CYoQj+GOuWYY40PYKGqW5ZMynT8
         Wcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766864516; x=1767469316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j5ukXbXXMF/+gEwMNuIxaLGA4A6pqbideAXXNZpJc28=;
        b=nijtYczG0CX/OX8Irwn2ZH2kpAS2Kgpmw8CWYAQbkF3Oyfu1oVabJvy7bc+QUn7opE
         L1Wvu+Ezjids56UEznbHUgvtLClX/XI7ivCCXGF7mKPQxGLzb9B5g6cu4nmPkLNq7wmw
         e+Pfb/fmIEGNM1ZsfhDHnkyrGLcSnvjShhK0ah1XtXxA1YJwIdwwSL2Jl2yqGGj4vQ9l
         upH5OM6UH3LrYkwSjfR0Kmmukp8ulnnE7YJmMd+X0EzbgoBH/JnUYg2l1Ptweouf7X9N
         lM2Mhvs7jax9gCYVXWbe0LCKQDHt8SMr1LzVl86GkUChEM6TMWpRrQxgEXMbPngxYbWZ
         /6hg==
X-Gm-Message-State: AOJu0Yx5vB/5OAM3DBYiEoYpLf/WhIMoLuw75P9aT+l0kE81g4/sPrT3
	07k3LHUekDLbexqvktmW9vPDCoh0mlr5X+2sdn9+UlAjC8i6vCkE9+2Y37xtlQ==
X-Gm-Gg: AY/fxX7ERzbDbyEyTojjYzPAddTwgUEPGUu8vDrVOP0aW8wu1nP6mRQn7OLglBS0Qv2
	x8aRy+CsHCrpx3mtRN3tUySt3n9A/YY+fFdI5RTGvwbZgF9M7mhJcdzRxbQGs712lPLe/del/Bs
	8H7XgV51SziA9wO5CKK2tviH7cnJ/gYtyt2KIDJtDSg8S0mM78HmejImTUhbX5u6y+kFfJ5IJQ8
	k1lKbmO5PNfZR11FSoIWFV8MxzBU53gnU65RU/BZUDgHBtUndvuFTHBN/EWacheQSQGe2BHDWqR
	anmDUaf07xoFtovE4hP+Am10p04LddL2qY4snc4b1D0XJkUhoxrRUTNR5Ho00MwyHagEzflYERf
	mBi6sqCz4aI9CNJNKEpUVUuyWYLS7WUQV1VS4nengspW/U/LbuU5znBbYugfZsqmpmd6QbwLn2E
	9SeW20YGKY5tToYJ68
X-Google-Smtp-Source: AGHT+IFxdMixRFnuNRVujZQcA2eKQUmcg0AUEGsqn1ZtPlJxrGbClkrDjorVMvT/wh1/1UlZiDbSEA==
X-Received: by 2002:a05:7300:5611:b0:2af:cd0a:ef75 with SMTP id 5a478bee46e88-2b05ec8faa9mr15148306eec.34.1766864516147;
        Sat, 27 Dec 2025 11:41:56 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:de11:3cdc:eebf:e8cf])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fe5653esm59087584eec.1.2025.12.27.11.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 11:41:55 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net v6 8/8] selftests/tc-testing: Update test cases with netem duplicate
Date: Sat, 27 Dec 2025 11:41:35 -0800
Message-Id: <20251227194135.1111972-9-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251227194135.1111972-1-xiyou.wangcong@gmail.com>
References: <20251227194135.1111972-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now netem does no longer trigger reentrant behaviour of its upper
qdiscs, the whole architecture becomes more solid and less error prone.

Keep these test cases since one of them still successfully caught a bug
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


