Return-Path: <netdev+bounces-246155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3431CE019C
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 20:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA8DD3037CEE
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 19:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E6F328B4C;
	Sat, 27 Dec 2025 19:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYb79adh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B95328B43
	for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 19:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766864516; cv=none; b=XVvOHgbiHOUvvj4Htu2tEj1CZWtzFkjfC6S4S/BER3REjVv+buKG3WyVwhi32LZDShqzSXD54BlKLFd96kWPjUtAp3yoMvI824EBkPDMQHntQCrkmBjPNj3OFEx64YKKfTk5h1NP3Juq+WJF0U4lcX8n6P2D22X2FaU71bXvO1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766864516; c=relaxed/simple;
	bh=DBOq4L22sMfrOVztnDSGgV1hqG3ovoQlje/7XDt10Zk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WHW01A+XD6NDqnWW5rnz0pW5/fCXvjDOEdp9jSC0CBx8hDeQ2BV6ObRpbWJH4jEhJXizor5TpqAhxYeoWoMghw8AMQ/hNuKnrbVZHow6zyerxgwpBuK4XuSiYXv7ur6N992j4M6UCxwjGYTrtR27IVL/K9xT04Ot+K13uqFl7wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYb79adh; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-bd1ce1b35e7so5316506a12.0
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 11:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766864513; x=1767469313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HWUCUWLvZ7C8IVhP2F6eYvFno3v/qDzqWhnBiwvgDY=;
        b=HYb79adhXSq1De5x8QHrtRaIZY3i+wVVjK8vk+PhxOJChTJYV+34LPOgnVA6eaDFHv
         wTFPyZFGfQOXjZ5GFzAPa0TLVqxPG+LFb53Vj0NSTq7uwspes+olpYap+Q9S3VFCs9T+
         ZHXQwM9VzV6Vze0JWxj6XDbycLyN2sQD0yY2jidc5eCeFYOr4sPYmFefSWVfzZ3RkcvX
         adDvbUmQFBjR5hddGRDDLIZJ6UwQP7LfcIaTqhNObg4kF5H9P08Wa53alTsTXI3Ad5TJ
         MHM485EPDSszQ8l0n7fdqoeabSsvatdERZUtgrdq/5BZ30aemWoEO0oJUzNia9TBFur0
         QaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766864513; x=1767469313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6HWUCUWLvZ7C8IVhP2F6eYvFno3v/qDzqWhnBiwvgDY=;
        b=c5UA1XQI8OjFCO0MvGcVqF4g21gLepyyh9C0y7lPhsD1uytD9GvOUk7mPcodNh1ioq
         XRMmNSdJlVVN2QLkMfvbWZEne0PiLcStn6O6Pdj41KJUtOetAoEASGS0TixKEDymi4zB
         samRaSswY3gtYuPyZokvY8KhpVYGTIJ1JKqBygCpIDkUb723OTy1SOy21q4e06f/AEZd
         5AbX8WCihPoAlx6JI2vHJuh6l3fCJ9xtYVbHIHP6Mdyg9TTP2UojCMyVerj/KaMk3wuw
         Y6MeBxHqPwXCvEVggBr/RRCNIMG8OVYCwIh4JgcRLWaY5yfPsV5Q23hWjLc9T+VVl8dG
         kunA==
X-Gm-Message-State: AOJu0Yw0OxXl2k/Z91Uj4bH3dRZV3fwfLCkPUj0XYFr3R2Y7Z/8JBaVw
	rBCErr3+ohxvK8hgr/Dm36x/ajA33sTQWUEXSCLQB7IG9lLfHanF3c7Yf17pzA==
X-Gm-Gg: AY/fxX5tOWXQ4lG8WwVsJCLJFEVI89HToEI9UFL8IpWhST7186Lu/9d0qBomLLaDGD4
	lfegvX+qS85YDhwalUftiRW2lsveSQvPYJnGjJ61Xt0WizIRKL6zZBFCgv3ZwmR8HUK6L6UWaE+
	rXhRaTK88xPPO87Pa9dztHdMn7qr6p/6lIi91OZsgdGy8zuWuEKFM9rAwxvnPV2YIaA5eZ/HU8W
	PNKgZn2N+KBd6oGltJReJwVVz0n7e2q2vNWtKFl7v0UGtNYaTXmalwDWHROXt5rSYKhUp6ZQh9L
	4LUvlWtaGcrRT6NvObCzBMcc6hJGmTy0KfOH6yaoO1LMg8FrQ3IYRLYFclMpYD183IGmGgPFd6L
	y9N2WPgD/jL8U7EE6i0EbE9GvKkTi9nRRKJwoFDS6I7tZoVeEWE+b1G+bJSAX9tCyeW2k4zeHdc
	TOjCHkpL6msxJ/6T6r
X-Google-Smtp-Source: AGHT+IGh2gdmGPwocZOCKxRb2d2h5N3eo++LNlGjbQdGAXQXC1JBbmG0dH6hh4MlKiq48dDfa2+Mrw==
X-Received: by 2002:a05:7301:4d16:b0:2b0:5306:1770 with SMTP id 5a478bee46e88-2b05ec3de81mr20398338eec.22.1766864512921;
        Sat, 27 Dec 2025 11:41:52 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:de11:3cdc:eebf:e8cf])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fe5653esm59087584eec.1.2025.12.27.11.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 11:41:52 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net v6 6/8] selftests/tc-testing: Add a test case for piro with netem duplicate
Date: Sat, 27 Dec 2025 11:41:33 -0800
Message-Id: <20251227194135.1111972-7-xiyou.wangcong@gmail.com>
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

Integrate the test case from Jamal into tc-testing:

Test 94a7: Test PRIO with NETEM duplication

All test results:

1..1
ok 1 94a7 - Test PRIO with NETEM duplication

Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index ceb993ed04b2..b65fe669e00a 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -961,6 +961,35 @@
         "matchJSON": [],
         "teardown": [
             "$TC qdisc del dev $DUMMY root"
+	]
+    },
+    {
+        "id": "94a7",
+        "name": "Test PRIO with NETEM duplication",
+        "category": [
+            "qdisc",
+            "prio",
+            "netem"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin"
+            ]
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.11.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: prio bands 3 priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0",
+            "$TC filter add dev $DUMMY parent 1:0 protocol ip matchall classid 1:1",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 10: netem limit 4 duplicate 100%"
+        ],
+        "cmdUnderTest": "ping -c1 -W0.01 -I $DUMMY 10.10.11.11",
+        "expExitCode": "1",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY | grep -A 5 'qdisc netem' | grep -E 'Sent [0-9]+ bytes [0-9]+ pkt'",
+        "matchPattern": "Sent \\d+ bytes (\\d+) pkt",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root handle 1: prio"
         ]
     },
     {
-- 
2.34.1


