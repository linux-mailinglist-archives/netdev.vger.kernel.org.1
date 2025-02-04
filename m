Return-Path: <netdev+bounces-162338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF03A2692D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 01:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9C477A0621
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 00:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7A886321;
	Tue,  4 Feb 2025 00:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYim8cxb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABAA78F2F
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 00:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630747; cv=none; b=E2SSXZmKyVYxsNeVsSpf4XRjmktXLHQKhCyBvbHRCz0jhkNMiMKuNAPVj2wTmHeUohasJpSS3vAZbtetoG1vfNARU2DWP8m1k/H7pIY487KLKFOg166+t8i0mpkVRjKWBjaWtL/74APXlE3ybr+szCwJABVHG33QribrYEQTNYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630747; c=relaxed/simple;
	bh=ArLfJitmVTdKGDLSHh6AyhH40WuhJrWZODXLjS+1+BA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rRmOgZ5Drq8E5nYZcbgi1I7QrzF3xgnXWn3D6JRuoiLM58GrbcHz63wTA/dcoXJ4TmXSUD5/3HxGpdlcNNF3Lh6JKr4w1ukhaatvU8yiYjzv4xmhKavo0DOOAj2joLRY/kjRXyAgEKIy7VzbjQ9m2ylUtIqSNHriXfN+kufX7Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYim8cxb; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-219f8263ae0so92288085ad.0
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 16:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738630745; x=1739235545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwZdkONGM82odxcc95TW8vrlHy1uQ8qkE12CRIwnO+Q=;
        b=HYim8cxbqgDAiebcq9Zrh62JL4Lbh07XPAWYLEduavDO8YMVmwhWqD5g2wLh7eI/fX
         Tf+n6uoT+0WZfX7fVyFjIZC0JF25lN3L7T1nj2yXRWHRAx2xCmkM7GyMOsk/Hv0rqq9C
         zXh8vwi6EObk7yVzIWeBZkJ1T9DfDsdgRmPkr79e5wu0htEit7UF1xcl87B7pnzVzBJ7
         V4fEEk+7YoAyNIZhlB9BKhGk4IBoWcIiYj4B3bxppnGc0MvOzRj4xXqpBeksFr4rHHV7
         lxuCZvGYERSsV8syRD1gXnorGvwK5nOqci2/n0PT6GSpDplJNNT20M6ZP/FVcit+DHAX
         SIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738630745; x=1739235545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwZdkONGM82odxcc95TW8vrlHy1uQ8qkE12CRIwnO+Q=;
        b=t+knI8yW9I423rwq3AUu21r5Q4JMxEzP2CZb4zxlkxBp7yrcKp381svkaajqb9JREM
         jRLmgnhuKW8Y6asZYOxwujGB++s4f2LVX/ksNwD4M/VupXoZ3b6mAf5VI4pjIEDn/rTp
         OL4GIggKDRgJsFlG5vo0jFMu+2mGWCxYgR8013+KuxrvCnRyk2oZpccuhNo2yKoc1IvX
         JbkA2USjNKEYGtIhnZpwJFjjh60J/tJlCQCYxMjZRT4gAeoc1dEdb5CN1KMeF2fVlzAK
         v0hNMEWAKMv6pPu0VqsVAOW/ZxDMGA0mNNWfV+vw9WcmevQ7segIG48EIinmVYPDycWA
         wwcQ==
X-Gm-Message-State: AOJu0Yx2aIrQHp0JEJXgLEN+ZNPxtNkJdAMm+VjFYGZsuOFDO0VOWKUW
	KOvy0ogoSTpSvU/M7DOJunzCiuWCPdUTQxKeaDmMsJokSiEdpXXsGDA8PQ==
X-Gm-Gg: ASbGncsoGR7vzQxtZwE6QYZvdjL4X96u4yRPm4gUXwrXGWcDyVygMKIer+wsClyTElc
	3O4bntGHFlyo9EZ9LHi8V7v7CaQWfyHRjiKlhHYb/V5G4Fufr4JOiExaPlkBt9fitRdqLesgHbv
	NK/4adBi1j9xNCKge+Haj7YhY4xoKCjb8NS1Yo4jTA436lcj7+2X49al+VhHTPnWRC4bWTYvBqj
	OaZrYadIicgwjxiJaXVed2TAvLn5PGrfaTDcZCNEl8+zPd/8At/aAJg7ga8KkI8RS49XN599ngV
	E85RXx7FhDysW3UtGuT75h4W9vfY916o/6JGfxp74El9
X-Google-Smtp-Source: AGHT+IGrwKYZNz11seBoWT8+i2GpFIqE/gyq7jMuAMPqFOhhE/f2TpL17ARcFUJBrMDtAzelbX7dMg==
X-Received: by 2002:a05:6a00:a89:b0:725:b4f7:378e with SMTP id d2e1a72fcca58-72fd0960665mr34340935b3a.0.1738630745248;
        Mon, 03 Feb 2025 16:59:05 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:90d2:24fd:b5ba:920d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6427b95sm9207069b3a.49.2025.02.03.16.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 16:59:04 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	pctammela@mojatatu.com,
	mincho@theori.io,
	quanglex97@gmail.com,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch net v3 2/4] selftests/tc-testing: Add a test case for pfifo_head_drop qdisc when limit==0
Date: Mon,  3 Feb 2025 16:58:39 -0800
Message-Id: <20250204005841.223511-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204005841.223511-1-xiyou.wangcong@gmail.com>
References: <20250204005841.223511-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Quang Le <quanglex97@gmail.com>

When limit == 0, pfifo_tail_enqueue() must drop new packet and
increase dropped packets count of the qdisc.

All test results:

1..16
ok 1 a519 - Add bfifo qdisc with system default parameters on egress
ok 2 585c - Add pfifo qdisc with system default parameters on egress
ok 3 a86e - Add bfifo qdisc with system default parameters on egress with handle of maximum value
ok 4 9ac8 - Add bfifo qdisc on egress with queue size of 3000 bytes
ok 5 f4e6 - Add pfifo qdisc on egress with queue size of 3000 packets
ok 6 b1b1 - Add bfifo qdisc with system default parameters on egress with invalid handle exceeding maximum value
ok 7 8d5e - Add bfifo qdisc on egress with unsupported argument
ok 8 7787 - Add pfifo qdisc on egress with unsupported argument
ok 9 c4b6 - Replace bfifo qdisc on egress with new queue size
ok 10 3df6 - Replace pfifo qdisc on egress with new queue size
ok 11 7a67 - Add bfifo qdisc on egress with queue size in invalid format
ok 12 1298 - Add duplicate bfifo qdisc on egress
ok 13 45a0 - Delete nonexistent bfifo qdisc
ok 14 972b - Add prio qdisc on egress with invalid format for handles
ok 15 4d39 - Delete bfifo qdisc twice
ok 16 d774 - Check pfifo_head_drop qdisc enqueue behaviour when limit == 0

Signed-off-by: Quang Le <quanglex97@gmail.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 .../tc-testing/tc-tests/qdiscs/fifo.json      | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fifo.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fifo.json
index ae3d286a32b2..6f20d033670d 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fifo.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fifo.json
@@ -313,6 +313,29 @@
         "matchPattern": "qdisc bfifo 1: root",
         "matchCount": "0",
         "teardown": [
+	]
+    },
+    {
+        "id": "d774",
+        "name": "Check pfifo_head_drop qdisc enqueue behaviour when limit == 0",
+        "category": [
+            "qdisc",
+            "pfifo_head_drop"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: pfifo_head_drop limit 0",
+            "$IP link set dev $DUMMY up || true"
+        ],
+        "cmdUnderTest": "ping -c2 -W0.01 -I $DUMMY 10.10.10.1",
+        "expExitCode": "1",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY",
+        "matchPattern": "dropped 2",
+        "matchCount": "1",
+        "teardown": [
         ]
     }
 ]
-- 
2.34.1


