Return-Path: <netdev+bounces-182014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BC6A8752C
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 03:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5583AE40E
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 01:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CA71865EB;
	Mon, 14 Apr 2025 01:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3SHummv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664BB53E23
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 01:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744592970; cv=none; b=uErhlQQHNKn4JWfFYeQraJJJ3cDJsd4qFMOUHI05SCHT145r0CiEysxb9K7xuIcN73y9doVxB5gS5Nj1wbaMHnSY/pWusAUWtsJNEMKhDVyu8QW6lEeBCemsebGgIpSe/ukHn6wbg6PkF+ffPrt7A2OgKJ1BzKLwL0UpV+jLw6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744592970; c=relaxed/simple;
	bh=2pV/y3420+l2fMjFJLBaBa7NR09YLVGyy/3cNhJPDaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JpxJM7WQSwjV+TYbsS6D/ZSxGo7sePUGb/TbiXlCyzVH4g3706G9mMGFiMyteFPP23dZhTpLTK5JFsPJxsxnXE1u8Q6YWdr76l2ouBrHtuWyHrB3Sd3SuOTEegLbdcFCAvySKPtj/yaPq2kgPzYfm28hfAkTKgs4k1dn/LrHtyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3SHummv; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ff799d99dcso3503587a91.1
        for <netdev@vger.kernel.org>; Sun, 13 Apr 2025 18:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744592968; x=1745197768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAPatXGnPrd+2aN7MkqUVJ421sDlGmuXrXLM/Xbp31A=;
        b=Z3SHummvG9s+qZOiodr4cZ9or6XS7vdRBEUMv5XyNS287r1ZznuZHqcs/lBcDp3+B3
         dTTAzDzJZjb5Q2ZcavPFwSkMx97VKyjhkhlTDFaqhkpLlsnp9/NvkfiUILNZ04frsHME
         yic7xFXX0QWMB2FSrsbOt2GRl8APeoY2NPdnpIBx40ego75Ea8nchHjtqXjKnUL9knug
         2cbK/2eHZgb6Z3qns4wjzEv//yNvq+/Pca49ts3qMK06O3lCMVmBkF4J5YVpQlKh1BqU
         YvLmTaCYc7KqZnDrwwCdUMCcyGH41TLA1bFTp9tDZ5kgyL+KvxD1bYPMAZWp+E4AVPjs
         E45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744592968; x=1745197768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAPatXGnPrd+2aN7MkqUVJ421sDlGmuXrXLM/Xbp31A=;
        b=PFuWsYMDsV9GmIK3HQXii5KY/GF4MUYxcG1tIXQJljT5HQIjaoU872C61L8+fY5Zga
         Mc7HRHxnlgUj6YmCIvQcXlrb2MsUBEljilvVjTtRJ/N9IMF4mBN0OjoA1a9PKqtoP5Nd
         u/BcvAtX/em8NeDEGx3cRQwRw7DPf0ywtQ1YswL+71XkhPVkhv/uwVT6Jm6UpOEchP11
         Cw7jJsltOnPR4szqRV+TDt/14M5o49V6obp2C1twCW88+tmu6AEVco14OHIx09rcVeja
         iRsoA1YllCjgEDQGjH+zo0IxcxX5i1oVZ3c6vd3iQrwEmOfrSyDKb0YPtLRpsYB65UbA
         CFdA==
X-Gm-Message-State: AOJu0YwtGJazumHwENLzRrOSLsDw8X8rhOc0Z7bniBcfwVeYDjok+TLK
	PH6HSn0LuJUk7cq/pyd0hEDY/Bn8eGFT0OamSduI+q3d7Kpubq5NaB13qw==
X-Gm-Gg: ASbGncunkMdgiiuBlIfXiUsWUAnWxQDQ0yy0qDHBh1LqCnzB1tKPHCF8hdtpPr8n5vi
	l4UyImnw8GfV2llWQCBjSUTy9AUzRIg+8weCGvYeYBLwPxRFX93En+PZrUiIKi9DPOls1bl9n9H
	hyTRSGLDBy991kHWEOOW8iPUtlUla0VPqsh0ty5QNnu+7zbHvKSvQNP5blvCw1CmamOho7xUeQQ
	K/xpyraWVUUpcp/hfsBwN/Y1+MMw56l+CxMyLbPEoUZFnlPUTS1yT7XIDDfZRTQ6xLSTyoAfnE9
	cd9m2W75kAtGCmNjvBDr/qAMwW7YfTwOVAm3mTDc7eZ6Zw==
X-Google-Smtp-Source: AGHT+IGWbVM/tB05DViBcmMwAvsUkAy5HckKgf2BMeiatLwslIVuo7xKPZauvj3ORKoHjUZ3MmzsJA==
X-Received: by 2002:a17:90b:3d45:b0:2fe:a545:4c85 with SMTP id 98e67ed59e1d1-3082367f641mr13617287a91.27.1744592968105;
        Sun, 13 Apr 2025 18:09:28 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:66ce:777d:b821:87fc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd1717cesm10158183a91.31.2025.04.13.18.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 18:09:27 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	gerrard.tai@starlabs.sg,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net 2/2] selftests/tc-testing: Add test for HFSC queue emptying during peek operation
Date: Sun, 13 Apr 2025 18:09:12 -0700
Message-Id: <20250414010912.816413-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414010912.816413-1-xiyou.wangcong@gmail.com>
References: <20250414010912.816413-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a selftest to exercise the condition where qdisc implementations
like netem or codel might empty the queue during a peek operation.
This tests the defensive code path in HFSC that checks the queue length
again after peeking to handle this case.

Based on the reproducer from Gerrard, improved by Jamal.

Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index d4ea9cd845a3..e26bbc169783 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -313,5 +313,44 @@
             "$TC qdisc del dev $DUMMY handle 1: root",
             "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
         ]
+    },
+    {
+        "id": "a4c3",
+        "name": "Test HFSC with netem/blackhole - queue emptying during peek operation",
+        "category": [
+            "qdisc",
+            "hfsc",
+            "netem",
+            "blackhole"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY handle 1:0 root drr",
+            "$TC class add dev $DUMMY parent 1:0 classid 1:1 drr",
+            "$TC class add dev $DUMMY parent 1:0 classid 1:2 drr",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 2:0 plug limit 1024",
+            "$TC qdisc add dev $DUMMY parent 1:2 handle 3:0 hfsc default 1",
+            "$TC class add dev $DUMMY parent 3:0 classid 3:1 hfsc rt m1 5Mbit d 10ms m2 10Mbit",
+            "$TC qdisc add dev $DUMMY parent 3:1 handle 4:0 netem delay 1ms",
+            "$TC qdisc add dev $DUMMY parent 4:1 handle 5:0 blackhole",
+            "ping -c 3 -W 0.01 -i 0.001 -s 1 10.10.10.10 -I $DUMMY > /dev/null 2>&1 || true",
+            "$TC class change dev $DUMMY parent 3:0 classid 3:1 hfsc sc m1 5Mbit d 10ms m2 10Mbit",
+            "$TC class del dev $DUMMY parent 3:0 classid 3:1",
+            "$TC class add dev $DUMMY parent 3:0 classid 3:1 hfsc rt m1 5Mbit d 10ms m2 10Mbit",
+            "ping -c 3 -W 0.01 -i 0.001 -s 1 10.10.10.10 -I $DUMMY > /dev/null 2>&1 || true"
+        ],
+        "cmdUnderTest": "$TC class change dev $DUMMY parent 3:0 classid 3:1 hfsc sc m1 5Mbit d 10ms m2 10Mbit",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
+        "matchPattern": "qdisc hfsc 3:.*parent 1:2.*default 1",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1:0 root",
+            "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
+        ]
     }
 ]
-- 
2.34.1


