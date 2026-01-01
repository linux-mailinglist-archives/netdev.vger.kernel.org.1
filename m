Return-Path: <netdev+bounces-246488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32829CED0FE
	for <lists+netdev@lfdr.de>; Thu, 01 Jan 2026 14:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D18A3014A05
	for <lists+netdev@lfdr.de>; Thu,  1 Jan 2026 13:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB73E25EF87;
	Thu,  1 Jan 2026 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="mXgKKAA+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F467261B92
	for <netdev@vger.kernel.org>; Thu,  1 Jan 2026 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767275789; cv=none; b=YhfPPHem+iwXb9H28sOqoGS9Vrs3F713xOLZdsj+x1uW/UkocqQypjT0GVHbOc+uvOYEoHQZIbm8j4Fd2M1LJJ2amu9QXhyOfUbFu9ZErBvUo7o654YYPfJK3vUAjkNTFMIxockP9lOCMqUcwLkS6Y7ciX7fmqrpe7GztrFzdy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767275789; c=relaxed/simple;
	bh=dBoN+gi0lP6wdEk5BwTuJZbvMqX+LiNf1NENoGkTXrg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EztHlrYaFzG0KogZ/Bx2RnmohAw8Nzt35M6dhkphUTYoR1R+FKQhiVDIsF2c9wcHONdmI/6Mx6dkeCXuRW0zjopCgvKBUnvyjvCFubsIJsiKyv37jXmBld2kfhvAh7xWwRb8gePQw2L4nxbPqAcWgBP8KnvKPJG0Je4jnigtMGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=mXgKKAA+; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c07bc2ad13so672767785a.2
        for <netdev@vger.kernel.org>; Thu, 01 Jan 2026 05:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1767275787; x=1767880587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CP2pgVXp4ITRWaLl4ke/WX7ZKsnY3Kk5bfGYDKdqGaY=;
        b=mXgKKAA+X0n9HYlu6t4Mj594rLrUdlpxlMIaKemwZUsjfbTInk8ZrFq5uQ1hdqyHGe
         6dz2cABvUjLo7YOuUvIh4jbaoW0oRW5ks4p2cOg3nqw34/w6wUgJzOerMxoDbghalB5B
         paOF/XlOPIfVDTIGTY41bB7UOLhSuGwsO+E805YNz3j8efarOYEmXMKHsr8g/w36g6QT
         C9BeqaRpvQ99IVjD5rh/VxeAbHpN+RhZLLP6AhS7B27CLsGeM5TO7WHJJM9ifj7VztXz
         zK/D/krKWK93e2IHyQlZKnp4PkmqPl5hGBnQYs5Z3EzIl2BBnjp5YtPX+FJogZa/Hk0s
         RQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767275787; x=1767880587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CP2pgVXp4ITRWaLl4ke/WX7ZKsnY3Kk5bfGYDKdqGaY=;
        b=l/Oav+iAtV1YxK1k6hBMk5ReT2eydA+LzMQitjEdw9T584CNoF8Y6eWKqZAdswPM8h
         RRr/wwBajh4O+pR94NjKNxPfzF+MM7dw5b5jykDvEW40WqHIsqAlAKnS+QU7g1xQL31e
         4mHGMEaGS7lV7jn29JgXUkxQiHs1024yhhg7BZSXbpcFNNt1I47o1i17YVdytwfZXWcN
         4ZaAKYHfbrdUrc7aW3KUxb0PyODUPsk4sY7oViLn3FA+IV2ibGHWrll2RXCuhwEaGgRc
         za4TdEE0GGPzj3JNdOMwLQpIo9yDNaNWhsMLR1aorPP5SYbtDqlJ1kB2Lske3fw6xEnG
         dCHg==
X-Gm-Message-State: AOJu0YxUBdrmOmfWfmKS3y9Z7uOujFw6AKgwMrxHd5grbCgzoaSOw/6P
	zP+Oiz2eEOwvdBTdhFKh1Dti8mEha94maKqdjQwG+c/hCuYaeH1ZdrkBR+/M8N8BoQ==
X-Gm-Gg: AY/fxX7ypvhdpvsKAXjWCQid0QIA73FdRe3vvg3vi1gugdV9pqq46S9xP5sAVPgmfes
	HK4IUlei9iMlYQgzIKlOWyCWOecOL6Qon6UC1/002exQL+XBgkgmIISsXBIssvDFgeGc+kwXuYU
	YNknItBgjupquxrJhBQOnx20Q1iuyIAqu1COdWQ/NDMuvI9WSATcAZypByR+7kZ4FbxAJPOPivW
	e9TCMSMJOOakIP9jb8YWJMcg3nCatxkLefEqb4A4GQh8PJ/lIusxIlrrwRCVD757JkK2aeUm9lQ
	DgZtzv4RtiE8vfvYubMChOJqLwnrNRIynM4uoP990AuGAgWfbIbqMI7YuDxqtqVlNDSaL6AwcnF
	CBEz0PxvE5koVH5BhdNPYnHCbqFLIIt+7Sz/s56az6Cqu5y3+tD2J2rfch3fnvj8KVf8nETuU5V
	U96zdjLMkbAe6ZToAgQ1ixhg==
X-Google-Smtp-Source: AGHT+IGr64QGqC4JTtX10hZxjUETT7pDH+dZNwq8cBfROh0KAGR50vZgE2L1xbnRaFAjUwWnhpGlUA==
X-Received: by 2002:a05:620a:2956:b0:89f:66a7:338a with SMTP id af79cd13be357-8c08fbdf147mr6171264785a.22.1767275787199;
        Thu, 01 Jan 2026 05:56:27 -0800 (PST)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0970f5fcdsm2964577985a.29.2026.01.01.05.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 05:56:26 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	victor@mojatatu.com
Subject: [PATCH net v2 2/2] selftests/tc-testing: Add test case redirecting to self on egress
Date: Thu,  1 Jan 2026 08:56:08 -0500
Message-Id: <20260101135608.253079-3-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260101135608.253079-1-jhs@mojatatu.com>
References: <20260101135608.253079-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Nogueira <victor@mojatatu.com>

Add single mirred test case that attempts to redirect to self on egress
using clsact

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 .../tc-testing/tc-tests/actions/mirred.json   | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
index da156feabcbf..b056eb966871 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/mirred.json
@@ -1098,5 +1098,52 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY root"
         ]
+    },
+    {
+        "id": "4ed9",
+        "name": "Try to redirect to self on egress with clsact",
+        "category": [
+            "filter",
+            "mirred"
+        ],
+        "plugins": {
+            "requires": [
+                "nsPlugin"
+            ]
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY clsact",
+            "$TC filter add dev $DUMMY egress protocol ip prio 10 matchall action mirred egress redirect dev $DUMMY index 1"
+        ],
+        "cmdUnderTest": "ping -c1 -W0.01 -I $DUMMY 10.10.10.1",
+        "expExitCode": "1",
+        "verifyCmd": "$TC -j -s actions get action mirred index 1",
+        "matchJSON": [
+            {
+                "total acts": 0
+            },
+            {
+                "actions": [
+                    {
+                        "order": 1,
+                        "kind": "mirred",
+                        "mirred_action": "redirect",
+                        "direction": "egress",
+                        "index": 1,
+                        "stats": {
+                            "packets": 1,
+                            "overlimits": 1
+                        },
+                        "not_in_hw": true
+                    }
+                ]
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
     }
+
 ]
-- 
2.34.1


