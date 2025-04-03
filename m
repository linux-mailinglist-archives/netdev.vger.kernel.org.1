Return-Path: <netdev+bounces-179187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3041AA7B108
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B76F179B54
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 21:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEA61F873C;
	Thu,  3 Apr 2025 21:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjBXjB9T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7041F8729
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743715021; cv=none; b=kutHfujlQetqoFEdagv962Xo5D5mvpWBnIjYUofAV3PhHq1cdPCSQTE55s4Drff6oR4FL1iNk4i0qoRqTGqWQM61mJIIXt+u6ovNi/GPamiVQJg6bgbu/yYdZZckofcN6tu19IF7fgHyaIlXRoTpq9GXW2t1eHq6AsU+QXi/tys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743715021; c=relaxed/simple;
	bh=c4b5bTsli5wxRR/vhR5X7nGQ6zwor8qczbcsuLWrfvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s7N5pUnugG2Gg7yE7Evi8vPjmOXe2UUThTT0oWQMACt6uxnFEpZdr99ySilxQDieITR4GLGSOO6k2LcXBvYaD5Xp0V7oSb3IncjKY+q1mr9ZZx+8SfS2YQmP5Dsx5RVfj2XhkM1Rd6w7+uVMLe7k0mbkAjI785HFwSe13xEIY0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjBXjB9T; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-227b828de00so15028445ad.1
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 14:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743715017; x=1744319817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QxMruQONZAp7zKVfCZlsSbmanJdypIkEhyAefdjRm4=;
        b=YjBXjB9T22HkDhBHj4iWtROrASx4jJZ1HCqjpGp5Lpn61DovFVj8M6Q1LvmcA3q8J9
         71+ViP3XDcuXkhZNE0TtyBnb4XEsj3GPOnt/e5LQKpW6uaylM8vQS2tJr+r/402CFZLo
         k+RI+oCrHiI0V07f5vfpQH5npgDq43SH31Yb/st3Go93PXbsRK/mNgiP9KOSw27ISisi
         oBz3ZRM8E1UgiMyGKAd4z3u0CktGkSag6PVOwIz9iSLt6qXR6V+zrdqjZ6KOYJOQY/p4
         WVaGECkTlUpNFTwYw9Ooa9XO5lYhmlqBxWXukA1qAMY5WO30tPwYxXidcue1mF3XyhX/
         20pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743715017; x=1744319817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QxMruQONZAp7zKVfCZlsSbmanJdypIkEhyAefdjRm4=;
        b=t78KJCQg019sx16fdYRH/pwSNHjzF2uA9v8fRJM7oZXXFZHjYWXSIwyT8c+siHuypM
         VDGonQH74RvZ0dePuafJDBiuUGY8aUHoeSjxpQoMXYJaduhLMFm3xRGISQ1q5Mo9xt64
         NhqypmDQQ2veu705loEsnlfWBcKahW9esdmL+zQ7ZMljtvNkobjYg5yiixiog8RfIrwY
         PR3qxvWYEAHK4jrc3lwOIRGIv1NplxW/Is9yRMgsooyjuarAlqmVOztQxyHH8JOTtPu3
         7G7x7n6r6KgvGstgNeGjTn22PE+dammy8jJsm1n15V9ZAKqjPA9OFXLSeCYOMcYNow4W
         RVXQ==
X-Gm-Message-State: AOJu0YwdWtMcY8WwMfrL+Hhvb/VvowHCcsZmeh0DwOv+HwGr8RLlFw27
	I8Lv/8WvFS2RiRw3oPku83nx6EwT/HfV2aUUbNyOJeSe3vkkB7eOsICTUg==
X-Gm-Gg: ASbGncuKm3ehQ1cRcoIP5uiwNR9L/3oQqGyv99Yna6cLCKO1lhTgcCBwd5ENZ1KC4PX
	IEQQhfgWO0suYTbOMf0vR0dfaJsC6KUoYSRv1P4OXHPdOvbatjb7qwx5O/TU2HJm3ELqWuk5A7n
	0A1udSqKm68u3lUVmj9g67kSwIcPvjhp0cgqo64BtzqdHvQUcGpxA9vlady375PPqKTZBGgLgvB
	eklBsNCYLL2cxEu5c1tI3BkemnTxfE2MNs7oNzPU86lg0j2FuX2jsOtI+yvmfrbSx00zHiizabB
	NTl9fJIQBaO5AfQdmNOTcO14wcE1ltohDAgioBBi9KO1sUG58dr0e+UcNGVC5B3cVA==
X-Google-Smtp-Source: AGHT+IF0sm8lmYxqPhAKzZ2fbe5xPmHEw5ps3HLnwdjg9KL/epaqFYVv0UmyshyAwTZ/vF7jFHco4A==
X-Received: by 2002:a17:903:2309:b0:223:5e76:637a with SMTP id d9443c01a7336-22a8a05f554mr6921805ad.23.1743715017495;
        Thu, 03 Apr 2025 14:16:57 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e1b4sm19332145ad.181.2025.04.03.14.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 14:16:56 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [Patch net v2 11/11] selftests/tc-testing: Add a test case for FQ_CODEL with ETS parent
Date: Thu,  3 Apr 2025 14:16:36 -0700
Message-Id: <20250403211636.166257-6-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250403211636.166257-1-xiyou.wangcong@gmail.com>
References: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
 <20250403211636.166257-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case for FQ_CODEL with ETS parent to verify packet drop
behavior when the queue becomes empty. This helps ensure proper
notification mechanisms between qdiscs.

Note this is best-effort, it is hard to play with those parameters
perfectly to always trigger ->qlen_notify().

Cc: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 4a45fedad876..d4ea9cd845a3 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -282,5 +282,36 @@
             "$TC qdisc del dev $DUMMY handle 1: root",
             "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
         ]
+    },
+    {
+        "id": "a4c1",
+        "name": "Test FQ_CODEL with ETS parent - force packet drop with empty queue",
+        "category": [
+            "qdisc",
+            "fq_codel",
+            "ets"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY handle 1: root ets bands 2 strict 1",
+            "$TC class change dev $DUMMY parent 1: classid 1:1 ets",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 10: fq_codel memory_limit 1 flows 1 target 0.1ms interval 1ms",
+            "$TC filter add dev $DUMMY parent 1: protocol ip prio 1 u32 match ip protocol 1 0xff flowid 1:1",
+            "ping -c 5 -f -I $DUMMY 10.10.10.1 > /dev/null || true",
+            "sleep 0.1"
+        ],
+        "cmdUnderTest": "$TC -s qdisc show dev $DUMMY",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY | grep -A 5 'qdisc fq_codel'",
+        "matchPattern": "dropped [1-9][0-9]*",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root",
+            "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
+        ]
     }
 ]
-- 
2.34.1


