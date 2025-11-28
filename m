Return-Path: <netdev+bounces-242433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3815AC9063B
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 01:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9093A96D5
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 00:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA4E347C7;
	Fri, 28 Nov 2025 00:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="C5bERZ2n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9C42AD3D
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 00:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764288896; cv=none; b=GA7jSUjY32BtewvBUJ0VTNBkCu6SHatQ09mnhO1JDDw2YxhQGNhXkp2eLScRXu6vY70jHTQvGK6btLq7VTtqAGa0vPqXM4dhpb0dhw133XPw98t5a90a0QRB1SqjsoZnKOB2JzzoMjPbJdB1Ei4LKZSRuWPhuyth3RbgNPo06Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764288896; c=relaxed/simple;
	bh=Bny86a428EyVt1JOQkS0rAilG0DuZK5eJhdyytR7beA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOzwIIs17uYCGRvdlh32uewS0eo50BpULN+3AzXF4vgSrMGbRGs96ujJeMml9isE11Ym55oVEYGkBJsrGazV2suKIA139tNnQPDhKCDpLjAJdiRuc8+uZzWgYLSXD5jbOq/OIyVKyudoy+vZnsyHk6rfAAguC2dp4rivS0RtdWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=C5bERZ2n; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ba2450aba80so751050a12.1
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 16:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1764288894; x=1764893694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCaI+f5NqScl/yY8l3X4XEtMVHAuZqqjYqotFuE4Rng=;
        b=C5bERZ2nyRldt1B2N7wiYss490gOuLbZLA/n5UGRhdtXfi+AqyWH9grzzmvVkCGJys
         oF0g/SWzut/E9YJzRWaAMuUyQX5d5RJVL5Co6q0q7AyK+59+EdLZj7kINqTIXru8LtvO
         vd0/7wFlxYJvklrQc4k/txNU2o+QQxLjThoLmwvhleNb2HVv3wVmRg2H3WfINb6Us2iV
         AkbulBChcSPmvJsG7ZKxPyjtyhnVQJ/gnZwI3TejlY0YvZUU78sJ6UAUoTHSRfCqc/l7
         8rDO/XREXz0dcs3WoP9tLOr3zhmUXiJXr+X/m5PfJpGErxTn6UGbtTTqtzjG49oh+alO
         jpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764288894; x=1764893694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jCaI+f5NqScl/yY8l3X4XEtMVHAuZqqjYqotFuE4Rng=;
        b=jdPRxCoTrKd4duCM/7k58cWmPmWb7wjlFNYDRGMgSGlYJpUGx5U5ZJyKgYVSelhkGk
         PUgepQbPNG2QBFLb8sN3ci7xjEJAe+YL/DnO0kQj4jXNLdom71dY6tygYHd37T1poYci
         s25z7osn1mhMnhVxwyHrTYsitR+WoWHCYMxg7amytjcfNa5LR1GDp7skxtFdfHhnjGwR
         rRaxEz3EFVYZq4SUzWmuuutK6FFZiViUYdJ2a2vbXm0D+dBQmtBBjT7eazA9TnfUF0TE
         7vPlUmsD1/oZuc1kwQa/I/QIDbm5TAIBNC7gt6Dseu53YMZRRfGOgI7SCCOT8g69eAP7
         de3A==
X-Gm-Message-State: AOJu0YxUOWgW8fi5q1U7zpoAihGS8E5voKsZSBPeXMM15EI6mWpCx8hr
	gCzbMPM+aBhwlNb11MHM8UOKRoL3SLK7hwxDPPl7JMbusowzwagH7OI1Wq6gSsxVKA==
X-Gm-Gg: ASbGncvgxpyE2rM6Yiy9UoK4x52lhLMwEQbQLA3vJYmCKAu60LWM3cDQYA3Tn35u+wv
	Bp/Uk9S+2YtvQ7jtF7ka/hpHmIiBA7tanEPWk+zgcbQUPvgRl4qaGa8u6aZsYtcCgkLpaeNDjkP
	BM6KuNTp7O6gENYHK3lTWisWwk+k7cwtrAfNTPt3gQ3SOSOZAVesGwE5lYbINCuzsOvXY/zUn4b
	IUUk/ODNK4TM2S/EuA9MLofxpddd+7Ro8HIc24k49gg18+iE+HSPy56SHpPPjMfo4N+qJKU7HtL
	2S1cI0JzdNvFUvMgb8CkLQxi8Y43wCuD3bPsQc/yJgAV3l1YKy0g1VzZwYyXSTU1rbGIm9zV5nQ
	QYOLA4UjGvn7PjnjCkRN8oOpf1bjwW3DHeWJSCLpHHGndFfhROM3L3J9KsY084P/A+P8QlzJy2/
	Zo338eBLmoK0dEaD5IWs662uIKrgEWIJfdDFfSNQtY
X-Google-Smtp-Source: AGHT+IHk6fBcQj6sDpY9Cdk+BLtfzupbTKpmhr80wcNRLkkx6Y2dHXuAfEU5NcSPs+LoF69kmyeSlw==
X-Received: by 2002:a05:7301:3a81:b0:2a6:cb0a:19b8 with SMTP id 5a478bee46e88-2a9415942bbmr6244361eec.15.1764288894425;
        Thu, 27 Nov 2025 16:14:54 -0800 (PST)
Received: from p1.tailc0aff1.ts.net (209-147-139-51.nat.asu.edu. [209.147.139.51])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a965ae9d06sm11209080eec.4.2025.11.27.16.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 16:14:54 -0800 (PST)
From: Xiang Mei <xmei5@asu.edu>
To: security@kernel.org
Cc: netdev@vger.kernel.org,
	toke@toke.dk,
	xiyou.wangcong@gmail.com,
	cake@lists.bufferbloat.net,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v8 2/2] selftests/tc-testing: Test CAKE scheduler when enqueue drops packets
Date: Thu, 27 Nov 2025 17:14:16 -0700
Message-ID: <20251128001415.377823-3-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251128001415.377823-1-xmei5@asu.edu>
References: <20251128001415.377823-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests that trigger packet drops in cake_enqueue(): "CAKE with QFQ
Parent - CAKE enqueue with packets dropping". It forces CAKE_enqueue to
return NET_XMIT_CN after dropping the packets when it has a QFQ parent.

Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v8: rebase to resolve the conflict
---

 .../tc-testing/tc-tests/infra/qdiscs.json     | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 0091bcd91c2c..47de27fd4f90 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -1005,5 +1005,33 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY clsact"
         ]
+    },
+    {
+        "id": "4366",
+        "name": "CAKE with QFQ Parent - CAKE enqueue with packets dropping",
+        "category": [
+            "qdisc",
+            "cake",
+            "netem"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup":[
+            "$TC qdisc add dev $DUMMY handle 1: root qfq",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 qfq maxpkt 1024",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 2: cake memlimit 9",
+            "$TC filter add dev $DUMMY protocol ip parent 1: prio 1 u32 match ip protocol 1 0xff flowid 1:1",
+            "ping -I$DUMMY -f -c1 -s64 -W1 10.10.10.1 || true",
+            "$TC qdisc replace dev $DUMMY parent 1:1 handle 3: netem delay 0ms"
+        ],
+        "cmdUnderTest": "ping -I$DUMMY -f -c1 -s64 -W1 10.10.10.1 || true",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
+        "matchPattern": "qdisc qfq 1:",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
     }
 ]
-- 
2.43.0


