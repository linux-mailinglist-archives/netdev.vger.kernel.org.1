Return-Path: <netdev+bounces-249560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2919D1AF2B
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 20:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 571A03015595
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 19:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBF63590CD;
	Tue, 13 Jan 2026 19:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0uplujr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA8A35970B
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 19:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768331222; cv=none; b=KU9B39Wif/RpO5MRqZ6SNZ6uXq2s0jR4GEprv4cjRvZQcTmEKs+k6pxhLTJtStDdZV6dBjmftsdyI5AEQ+mbrX2rtBC4tJSi30540V+BjARCwNPg9EYNusZOd0tazmVJOeMAVFpCC7ZbP9pPEpNbASpIEm1uN8tKg96hO7vmR+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768331222; c=relaxed/simple;
	bh=DBOq4L22sMfrOVztnDSGgV1hqG3ovoQlje/7XDt10Zk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rh+4eKklolWbSO8kR7memiwvKOgBuztbtR3vlicZpIfiaXXFeTOD1QfVMdB+KJOuuNGxf8QzDfoF2Rvp2HAErHYAVbd+5BhIGisLN5eIUGClkXgmyLBzm3a/5NCNLq53tQCM/nP+vkhzLNDCMqtqSuwHi3qVOisxEvP1Tpez4PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0uplujr; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-81e8a9d521dso2326715b3a.2
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 11:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768331220; x=1768936020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6HWUCUWLvZ7C8IVhP2F6eYvFno3v/qDzqWhnBiwvgDY=;
        b=P0uplujrsYlyhDVQp4csHd/V8xVG85y982oQp6bCDsoWO8dOwOCzdKAJD1Umhguo9U
         NIC2ezYSuo/yCyOgFwfHA6thHQFUHAC3XwlVBIcNc61bL76KLmUWj8ICWPwr2YiV2VYJ
         AM/oOcDyUrGzwSuvOW1Ci60BhDMO8rc3MP1vfox+U+EMMnz3Ugp1mxtGnmlvlWJRseyD
         W3n1WjGgSD87A8aaLEFD2Q+jHu7NMBpASJGgqMyEfx6gtZJ6lwcCx1rxTb7AbVb4003b
         VyeQgj8ema3Q4BxR+kZtUvBOEox3K8Srb3xpQrkOp3uPXvjyxOxQQbPVW6XUbx3QIuHK
         j0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768331220; x=1768936020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6HWUCUWLvZ7C8IVhP2F6eYvFno3v/qDzqWhnBiwvgDY=;
        b=jloSKuk3jgcj3knordIdZ2rfRmPwP8GWK/JUFpzwkLkl7A6yZYgsMOAQSA9p3n22HG
         R3gAA448dr+DJCRWeANXlXz8j08GSOemEzdbGFaMBLkCpblkXUhPNEz5o8pkQusOV244
         DSqe3Mqi1b2euDsxZwk62JBu1T4XmJG1IeEZtfOzKiSPalkHkazZyVDZISb9nEGPlT9P
         Fo8LZBzwxspa8zCUraNcphyOihjYBdCMCWB5m5vdSeJW4ML3xNdLmN39ZLH7FEstpI59
         kaqQw/5VXnniqM3H8E0aczl5kCze0RuoN7YeHTRzX5gi1lvzbJCdUT6Db4roXGFX5X44
         sxtA==
X-Gm-Message-State: AOJu0YyGuCMwAGh09lXAgjOqoLYvGLD7+oSqD2E1l7uLuBKC2OI2c8PG
	csbU6EoMHWdIcEcQyJWMZMBB43K1msRCUX81Nnz5vTWodevzRNjzk1+gO1YXMg==
X-Gm-Gg: AY/fxX4npVU+OzasgzX/Z6NodnwkbgPrc2qxwvIc4ttnyuZL4BvVdJoYiWQFwVJEuMj
	XZUmnyvcwnz36drnYMqWoJwhiHFysz+Lvwf0jIYox4tF2sp4mxLuDbAENrn6n9nshNI7Xl82NIO
	UPqQtPUkEjctVf8elw2K3Lp6vB2PW7STt1z6Ta5zvuUL+3Oe4usGdGJhx1FoCulOFhO64xcab1x
	3+mZzurWBBgLWDRNbpIg0jvjCgTzi5w1Sr8fTP9TJb4VO6j4wGUYEtS3AHMIV1xwrhbnNMUGtO1
	q9kyFuKJEOVzGBuAbpp9Qk6m3M0G06N4h18hq50fGeOpcHcL5VZr+0WcQ4cBclW0js7V5rqSTC+
	Lea9ygCzYEqSAI+K3HTuT4gkdvfAF+duyy3LmvM/KYXRv3R7FHZbuyh81TnGfxzsvCJ2u8MSi95
	T+JIVn3PGnEFnpNwsX
X-Google-Smtp-Source: AGHT+IHQt7tY03+xDcEEz+iReSvgSkWPCnp94dF0/mNJ2asRZK7XHelJSWVVwBu73O9j5YGx5SHgMA==
X-Received: by 2002:a05:6a00:a24c:b0:81f:3edd:55f5 with SMTP id d2e1a72fcca58-81f3edd6d57mr9946637b3a.68.1768331219898;
        Tue, 13 Jan 2026 11:06:59 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:7269:2bf1:da7f:a929])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8058d144sm187780b3a.51.2026.01.13.11.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 11:06:59 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net v7 6/9] selftests/tc-testing: Add a test case for prio with netem duplicate
Date: Tue, 13 Jan 2026 11:06:31 -0800
Message-Id: <20260113190634.681734-7-xiyou.wangcong@gmail.com>
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


