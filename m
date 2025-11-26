Return-Path: <netdev+bounces-242038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 318E6C8BBA9
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7011F4EF2D1
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2483446B5;
	Wed, 26 Nov 2025 19:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDSZrp3+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0261C344042
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186789; cv=none; b=eRaHsiP+xKw1doi/jkpgdt9nibsuMgE4RT1g1RrD7DUo3iGP+gkpu9skGo30OjLVBYmAoZtBDSHVdhzMW9oODHKPhv7PY+gcofIPiSFs+9sZK8wFmTEmnCli4wj2EChcfbVSsEBVgdA/zz7VfRSz3p0kQyTYFvM/kO7m+irfXbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186789; c=relaxed/simple;
	bh=cFI+lN+shy9XzBVrS2YNSGz26ES4BSyUxNoO6Fe5/XY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rn67bNH9kYIQG0TClREPxk+51tBA1v+cLqJrqf9zcuQCdxu8MagyN7pBFxbTvcB4Dx20ATjeaYGKqlWqVeOJMbE+LoQymk1Y/kmgeXqq/RLEuTGG2ZRp+qqLSLjB9I4XOej/ViUg2f00hSdCbiY2jZlZkXyRSoaiTa17505mAkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDSZrp3+; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7ade456b6abso66152b3a.3
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764186787; x=1764791587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSiCfoDACibBkDMBdJ+li964rlTJdhm27WP+g6ufx64=;
        b=UDSZrp3+zAwiRf7w7DbF+cqL7WigLVaR5okaigTGzx40WXYruXzPk2qqHcYCr9YCI+
         bgFIlNv344o/hguXLV+BOZB8Xnm5CTVhqhu6uCRDxN1GHGEwKP8HoXT+9TeZtM3vKlcN
         Wtc1u+pm21fph4voPqeU4TV/t7c8TnTUI4h8FvGJgTnF2nqXqTi3efJvDwm/S8wa6+0j
         DYwf2xIOAWXdn/Aa1AfDt0kjgI8RxZVNPGcL0PZN3nNxbaF9gXD49CUclTiiC6JbXYgr
         gOME7+VUAHt7fIODBAXHZXWGiBHTzIgVF6cGRI2EmzRaZq2Tr7pvfImCFOSDVZleJfja
         dqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186787; x=1764791587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BSiCfoDACibBkDMBdJ+li964rlTJdhm27WP+g6ufx64=;
        b=Wyd/uVFECDsZOKGayD9F0YfposmBmxeAk3qy2s4Svf7ILOPJtkoLyJ018UEtI0oyU9
         b3YJmbNWtg51xlWZxibrcmTl8m5laIT81eWiu5tz9crgvt0BFsa4ds2jZkQFSn5xSDww
         /4lpJZBEGZu7hKiMhelq1Zq1pdegvZNzoHGukjwuvEJH0Mhs8yU01wATSWuo19S5e9Uz
         9LHVvPEAOrgE2DTCmVxdynjLKBft1PRWdPQ+ifcUUj/vMadtLbOV+Qvnj8segX1vrEbo
         yprnT0++MuKDojPal/8n7LnYc3q36c/FARCqLhPqvz3eGukTviriQ+DHRyOIgPYzkrr8
         iZyQ==
X-Gm-Message-State: AOJu0Yx178wLL0TiSlWlqMA2TrqScNt0eKDCgSgFZTbfwHWd5HQeb+J6
	rrjjHwMQbVa4HWRy9pDew8Y/+X+jGtXy2swI6kmSRs2IOETGwY8CryF7fkhGspoz
X-Gm-Gg: ASbGnctE98l3iakY/NvHIKMfGOBuOLIfgV1jesAJu3Oyqi0LW9ZCRO9tg6/SwOm7PSf
	uLlrmRPGcIqltpGU4I8f3vM6oL9biGZ0Idml0fsuJK/nl0iWSyaGCm61WQKbC83eiq9MuYnGNjl
	IpSy8j5ptVrKGAlLS/Q75J//2uYZo+d9qqljCAURRxqK8zGZVDfMnD+6vxvZdc73sF1rWUAH53e
	q2ipGjpWB7MYcTH0uBA6aV1CvkAcKFOYUrI4PO/JMJUvhMSdOHi2uJvGplfXAaFFhCfs8lYepkm
	P413GCHy/D3M+eRQH3dCt6t+UhQG1Htkw4X9w3Jm5If+Wlb9y8CpKO9OXzZKqEb1SIQ29y0sTQa
	PsWWXvpWqvJN+CMqikcc15lOkpD9sByp0PWDlpuE3LCeuvVubA4cx0Dn/kZsf2MrnNBczCRoPtf
	YdcrLjeTFuBlL7XEkc6JdpNQ==
X-Google-Smtp-Source: AGHT+IGcMB2TiPcnkOWmT71VHM1h9q3B1zKAH0SZqMVFq/z4JQniZMRLaEeyeqlBCiCS3nf5bYimtg==
X-Received: by 2002:a05:7022:e988:b0:11a:485c:27b1 with SMTP id a92af1059eb24-11c9d8703d3mr12666906c88.40.1764186786921;
        Wed, 26 Nov 2025 11:53:06 -0800 (PST)
Received: from pop-os.scu.edu ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93db4a23sm101508235c88.2.2025.11.26.11.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 11:53:06 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	kuba@kernel.org,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net v5 9/9] selftests/tc-testing: Update test cases with netem duplicate
Date: Wed, 26 Nov 2025 11:52:44 -0800
Message-Id: <20251126195244.88124-10-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126195244.88124-1-xiyou.wangcong@gmail.com>
References: <20251126195244.88124-1-xiyou.wangcong@gmail.com>
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
index ce8c9c14dabb..c60ff51da810 100644
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


