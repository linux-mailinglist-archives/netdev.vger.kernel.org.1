Return-Path: <netdev+bounces-208364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBFBB0B236
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 00:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 724DA561CD4
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 22:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFB32874FC;
	Sat, 19 Jul 2025 22:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzA3K+Kh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E729286D45
	for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 22:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752962658; cv=none; b=GwIIBykOwiXad5g81yL8clW0CrVpmHyQ/eSx2Hi0vRjlRCf/Fx3sV5dE3tUO+gU1/VQkGVT8jszdYMuRiGi3w2yKMzs/pbjWi7YhimzUCg4LJNBBkBxvxR8dsBaYhlwrxOtJPZ74ezq+1iAjb90/HzdIVdU94ptAeDbwPY1850k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752962658; c=relaxed/simple;
	bh=UsnpV5xSgEVFYVykVI3ER40cl8USk56Lm1968wuLq30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RuvFS+h8XdPFtZMMtkX1BYJ4gJQBjb/Y6ejXOXERiWwu6qNDZO7oFtdf2vKSxa3cFT8xYWQLRnpn1SNwJwXosadzmZvJJ2f1RlT0NjIJrhN6j/fRZh4GW7LXuTsPSC67N/7vlaL4ap5GQCJQBvjFFWtan5DX1SjOVfdjFzrKLyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzA3K+Kh; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-748e63d4b05so1962413b3a.2
        for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 15:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752962657; x=1753567457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufXJD7zn7SkLOAFyjUdg1e2NHd8yRmGvlyVYUYLWhHM=;
        b=mzA3K+KhCWvZFpJpXXS8FCPCuyp52MuTr/r/tO4LvWnPhOBFSDH6iJfmKpFdmH5mDu
         NXXtOWUXA7DP/F7hOm7U3N2jt9Km746QtTLP24ga95DnM60NUi5PUBfS8VNOqvhy1iZ4
         ZvOKxH+oPK0FFkSHSV5FQ1cMjQw/Nso0uovflI1EgpPpxLlwTh66AvweX8xwhk3/nNSs
         PSHLaR01IK1EChtM3D/Bq9TbF0aucIEqm6CYVN2eGJdrbkoKR5bO8ddJ65NjYwgOhF//
         fRuOFHnonCrZUn8vpNqFlggrhfIgkD/5iz9ws+JIXeDloOaQcyVcDO7Xg1SJ6NLLlESQ
         r3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752962657; x=1753567457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufXJD7zn7SkLOAFyjUdg1e2NHd8yRmGvlyVYUYLWhHM=;
        b=HLCT02Gf3jawib7Jid7L0G3ktAXfmdyZlekvqxoEtgraPh+kxoWD/yIsSZS9ORxETg
         5aXimVNGCEZhTrjaGmfut7Uxj7db0yT57DTouA5SuwyNub2V4vBXt12mTaXNnUnphuPW
         E94dgzTVMl5YARVwuL/x4xu9fdmtCLm+qq0dlHz5cc9Jte8+hvX8yhncQ1QmcS+XTMSS
         NjNhiboLSd9EMrvFlMwOLJ7Xvx+p+mLOhpXxecI2nHLCRp5lhcS/dEpM00qIMXnMg/YT
         qANccwjM9i9WVMBQCyalAa5y/nYVdBrjnTGa9v56KOoXtkp9XOBZ0qrg2N5REp5Qc6n+
         mwVA==
X-Gm-Message-State: AOJu0Yxgf8o+Z+uAaGdnCDqS/+s916caOJ6FL/gMDwtQWnoBWhIdPbNc
	mbMGxgsHQAVYRa45of+uqdGUq0qZ/iSE8bLALGHIrnawSRkVkrK75OUPuG4N5w==
X-Gm-Gg: ASbGncsu8Wnd5K78hYosNwBglgTn0K6SSYk5VUf307JmGS2vsPj9ov7TSgNLc5nNpdj
	QP8mOvcPnYLV7DSZlYCnpqxLv7bzGz8fvfHYVzBwPR0h5xgYTiipbXYdchqs+Vq/klXWSzflY09
	A46OCPYbCG9B2DGa/eWfBe0ZtJfBz636IuiVUdLeyIThZBkjZDVpWnNcjC16boOsbg+7oduFszj
	XOkE7OOwZyftVrFNjTmGBHDyngpYfZDj9d3t2uwVdT1KnMBr3Q5C0FltbxCjd4Jq5EoYiqx9pgI
	PlOwNDbo3m9mYRQZjU5EptCUBZN/TZza+eSQzEAtoOcHWAuVWmh2BolBA5Ek+azTXifUozUt+NN
	BWzA3i5dS6iDX1+wwTKHEyTZ+Ru4=
X-Google-Smtp-Source: AGHT+IGIv168EBV2mClZCEYfqqXIM0OKrTj0/sGiwiSnFusjzMqLCWJmKYSdviu2fiZd9JcNor0EcA==
X-Received: by 2002:a05:6a21:104:b0:21a:bdd2:c2f7 with SMTP id adf61e73a8af0-23814268895mr24208449637.29.1752962656649;
        Sat, 19 Jul 2025 15:04:16 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:b3bf:9327:8494:eee4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2fe6a09bsm3084040a12.3.2025.07.19.15.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:04:15 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	will@willsroot.io,
	stephen@networkplumber.org,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch v4 net 5/6] selftests/tc-testing: Add a test case for mq with netem duplicate
Date: Sat, 19 Jul 2025 15:03:40 -0700
Message-Id: <20250719220341.1615951-6-xiyou.wangcong@gmail.com>
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

Given that multi-queue NICs are prevalent and the global spinlock issue with
single netem instances is a known performance limitation, the setup using
mq as a parent for netem is an excellent and highly reasonable pattern for
applying netem effects like 100% duplication efficiently on modern Linux
systems.

Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 605a478032d8..b4a507bc48a3 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -793,5 +793,36 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY root handle 1: prio"
         ]
+    },
+    {
+        "id": "94a8",
+        "name": "Test MQ with NETEM duplication",
+        "category": [
+            "qdisc",
+            "mq",
+            "netem"
+        ],
+        "plugins": {
+            "requires": ["nsPlugin", "scapyPlugin"]
+        },
+        "setup": [
+            "$IP link set dev $DEV1 up",
+            "$TC qdisc add dev $DEV1 root handle 1: mq",
+            "$TC qdisc add dev $DEV1 parent 1:1 handle 10: netem duplicate 100%",
+            "$TC qdisc add dev $DEV1 parent 1:2 handle 20: netem duplicate 100%"
+        ],
+        "scapy": {
+            "iface": "$DEV0",
+            "count": 5,
+            "packet": "Ether()/IP(dst='10.10.10.1', src='10.10.10.10')/ICMP()"
+        },
+        "cmdUnderTest": "$TC -s qdisc show dev $DEV1",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DEV1 | grep -A 5 'qdisc netem' | grep -E 'Sent [0-9]+ bytes [0-9]+ pkt'",
+        "matchPattern": "Sent \\d+ bytes (\\d+) pkt",
+        "matchCount": "2",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 root handle 1: mq"
+        ]
     }
 ]
-- 
2.34.1


