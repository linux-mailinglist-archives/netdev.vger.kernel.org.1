Return-Path: <netdev+bounces-249561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 820A2D1AF37
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 20:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88F5F305E878
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 19:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69DB359F8F;
	Tue, 13 Jan 2026 19:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClgEH1b2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53113359715
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 19:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768331223; cv=none; b=HaJbiih0I5gFa0pV2J/wrgXuxwVssbLSk4078tXsYEF5dmBOLE+fMDcfY8eAaWlBHApYrRkCmIzWFY5Gm0vVf2l+20RxuaR/UqPUwqq1bCG52cA0UFO8Ne4X0adW5BWvav4dczMVe8z1lSYW9HUBOu1w3ttdrbxWFXVysPthV6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768331223; c=relaxed/simple;
	bh=wHfxkzR0h3438LhGsyDy1mEIBWYx732C2BPFv47SFac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u873BtglpcoNQKu+9b15y5fIUb09HSPeia5ORQKj4pphYxM764yDorLF7ubYU+past21Hm03FKsFZ/PitlGEn44z7/UOwO3zktI/BQxWnMGBzwTbQL0aYUFSwosO6yOEbsZ9Mmk+9MEl+WNgKkv5ZIFy8naFKerymDM/nHbjNHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClgEH1b2; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81f4e136481so1366255b3a.3
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 11:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768331221; x=1768936021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+v3zRljF9F0bGLuoenrkyjbvLMjC//WhzqSKh4DF+88=;
        b=ClgEH1b2vzHveWpyvjZeukBH6GilXg07M0v8P5pyGD5qoT8Posbu7mfiQd59B3UZGk
         gOzpoMiec+yYzrXsFULDZ5EqTtYGh8SWzZDppaHrwQhIxsPM02SkstiztvH11TUbLliD
         LNnrNk8RZcj3MSVz/2ml/5gtr/omnUFGbMwaIxIgIxvHKQb2nDer5drnZVsKtsxv9xuy
         iMh2T7sgbrrSY6hF8RmkkRBhjYvez9+oYf49e2J+HhK2RDV60KD8F2VC+I94efEBGALw
         1diea74SVOIv+WsWq0W2RCdORq3ngeeL61lGGO/CwStQ7b3sA4DcNxq6mpu9SO4oVXiz
         YkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768331221; x=1768936021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+v3zRljF9F0bGLuoenrkyjbvLMjC//WhzqSKh4DF+88=;
        b=g6fxE1A40pYYf6iVkXnbF+9unNRC0D65MyWGaKH14KqHlds4gSqt15P1OW+tRlRdZg
         8PSzUw3G9NIhabLfZCRn9HCMBP10fDNnLSfW39XmWGoGQWjJXrLdPTs6DCtiGpuhs2yy
         V63Yarahr2VClumEHfsi60jXA7JQvEZxHjsq+cRZ3KHS1eglSFrUFinrmOues2eoAY8k
         BEeZRfq0c4GiMeusQGlsSd+HcPObr0EqYxBitUUcE9VVidQNBxA/+tc6nK7ncazZG993
         kjptX14nNjEZkbgF3/jQZwDvPr8UgE9nS3lwiI99wLNmsQy1+3sjrWxDkZCAvQ36Ehid
         QkCQ==
X-Gm-Message-State: AOJu0YwaRV9QbfOYFm0LU2oG2Zw9XBddC24PufovN98O8WsbYZohPTzS
	w9LiuQt5p7EKb82b6ExDqBGJXWw4hmeav6V0/EaQqI2ZjdNU1isVQlh1ro8D/g==
X-Gm-Gg: AY/fxX54B5s9nwnfF6LagaJDvv3SqVAV+reo7byzF5pd+WE9F71B2brt7ZNRtsj4pli
	6Ai502pGP3IxF9XGqbVNve2jFcSwEqe/a4zN6R3jBWNHzN30CrazW1cqIIXlLaxpQ41z/QJdbmq
	PVu78STV8HYSgK3ZVQHTKo2MBDu+qkOcy8bs/wdEtKLw5KWMfXZd6uJs8KNlfNVuAWPC8cAhL8J
	aR8lCpk6tafzK6ylRUGwUhG+I13GASibWMYuoc2g1lWEM5OO6M1Wf33k53GGVW5GH4NqVKtDPLl
	exad5TBcwp4EsjoGGzH1Nzf6d7GFA9upB3/qv11goLlGLJgl2UZCHLHKkabD2R2ZZ8j6W3iV6XX
	z1SDSgHqmznq7Yp4d/ieZJegejjbl8SVdGGWnNEvk0Ziqrs85tkwm6hUWC2s7hsf0seNuAj/dgx
	ERNLdZ3v9d/3stisnd
X-Google-Smtp-Source: AGHT+IFdmwRHVMxOvoKjjII2LZfCdpREgJs0k0Br5II2Xikz4yk5HOcJ4hzqby5/5WIBDgyVR1XLBw==
X-Received: by 2002:a05:6a00:430b:b0:81f:4769:6fed with SMTP id d2e1a72fcca58-81f47697393mr8242205b3a.29.1768331221125;
        Tue, 13 Jan 2026 11:07:01 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:7269:2bf1:da7f:a929])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8058d144sm187780b3a.51.2026.01.13.11.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 11:07:00 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net v7 7/9] selftests/tc-testing: Add a test case for mq with netem duplicate
Date: Tue, 13 Jan 2026 11:06:32 -0800
Message-Id: <20260113190634.681734-8-xiyou.wangcong@gmail.com>
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
index b65fe669e00a..57e6b5f35070 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -1141,5 +1141,36 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY root handle 1:"
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


