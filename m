Return-Path: <netdev+bounces-160948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8792A1C648
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 05:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54B9F7A37DC
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 04:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBC319DF77;
	Sun, 26 Jan 2025 04:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPvRaaVI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94BC19D07E
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 04:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737864802; cv=none; b=CxjV7/dIiZiXT4XED4O18DaG4evRR7p/BtX/vszeP/9fXTb/SkUgQh9YzTC26l3xXslVGe7DNQxGsDtzrY5Br/YOJa2COlpclYmKc1LAFiuIlIpdWZwvkHV9qS8qL0hgdZcUlszuvUD+cxVU1UW4IKU2biiwzdKtL/gDdtsr6dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737864802; c=relaxed/simple;
	bh=1h/ttW4+SudPoH/B/mpE8lr3xQALJmsLdXgmNA4NLT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F69losc6KJw8Iyb3LgrQhdkWHW2IHEbyGwz6D+Jhn7eBTTcV2+n9o5dg2f0+V+VDHLh3GNrm2W8PbNgO3YhiDO4APznAkSWeWHkTTTgicraZX6PnrlE2/Tn7d37vLRoBOfovYeOODLW7PilvGBU3yAfz6o5EdlXP0Zojb43oOpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPvRaaVI; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21631789fcdso58985805ad.1
        for <netdev@vger.kernel.org>; Sat, 25 Jan 2025 20:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737864799; x=1738469599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mv9+wtSRm4ljFbkqrQXX27pmrgFds/MtXTjPo34ID7o=;
        b=BPvRaaVIyp4GLfxarcrFmgo8JqBW44uV1gS9yJMYHwuIZFMk8xHqaibQUu5J5aPVQ0
         63KNXx5NMFjzQbosEHcCyMI1g++/su2pHLiFE09yTew5+sgmIAo2yWNkJjvwWEbK1vhP
         QnHMZL1WaMcmrwrlfcTou2PuQ5Nq+zTG8XlMA7/ayinfva3m7BL91WdtEoCP+hghA4F6
         W94QXTqkT/ERcB3gMtfhQjWsr2+cy8j5Fbnqbdo1dSTK527Z4qs38A/iFyTZNRXqcZSo
         M3hBfPnq1JVZh5Tot1Tj5BD11qZIvyEEw4FMUcW/M+cGdjVjR04OiTGXObjDKPfPenPw
         S6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737864799; x=1738469599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mv9+wtSRm4ljFbkqrQXX27pmrgFds/MtXTjPo34ID7o=;
        b=WaauwRFSDsvsxBSRj8n2PV31nc/3FMA1z4PdtAwmtnZ5jQd8IWweFkARWqFFy2wWY7
         P8uF9jjfBdaKenn8PtBlMPWpD/g/kyAziP7L/7FeFp2lUESJTI2k1l3G5iRkC5fop2Zx
         q8PFr1SsghlaN1KP1O5kPuYJ4klOVR/DuDyRl1Q9LhV20546OgRGHGNbtE122arnJYe/
         kAVijN8JPPlu0bIkM5H8dm+mxcywSBtHFXM5mOGz206wJkbw81vIewoEeqsojqIQjNWy
         F6OIukxG8iH2VK9Z5mV8SxbgAg8FpEMrVtNT7K0H17lsHzDJDMJIuACY1axFsxsp8oHR
         vuIw==
X-Gm-Message-State: AOJu0Yze7g2cbmM1IMBRnnf6dw/396yVVYAU7g8fQ3epb9aUi6zIkWws
	ax0nurhQkC+CWWTqZXWy4N21TRSkib0ZcQgSxgKaI+ya+F7iKyUB4hCE4Q==
X-Gm-Gg: ASbGncspx1w4lla2dJtxAIhmQJ0b3Xm0rkn7yUzDT7GccSL6/DhP7ejpZb8EoOxL9+7
	amMYwxzv17S8L+ZqQDHN9s1fG5LliNiEeXW7xCGDyCg98VN5J5phzKN+jtiJrKgBu/RBK+9lteX
	M8cZdbZ5a7YPI++/1Tnia1y4n6apchnIdl3Wp5kY6QJ/XbnuGArj5ZiXRXZ4WKys4EQVS/u9riU
	K2fAgH6t/MhAzHKi5o9f3C6SHP3Cbp87UFkIJVPYrDsAc/sIeOm17OOMTy8jdvCapJlVrbiSZqg
	m2kFYcn0/GRagAGnZMmVvzBKe32iEULdkg==
X-Google-Smtp-Source: AGHT+IENjnMgWigNglzj/mGuMW4GscN8/BwNq0b5VHqoQyQ6mmS5BEJJpGY+0sQZwss49PgNUgW0IQ==
X-Received: by 2002:a05:6a21:6b17:b0:1e4:745c:4965 with SMTP id adf61e73a8af0-1eb696de77bmr19665247637.8.1737864799549;
        Sat, 25 Jan 2025 20:13:19 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:86c9:5de5:8784:6d0b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a69fd40sm4514213b3a.3.2025.01.25.20.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2025 20:13:18 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	quanglex97@gmail.com,
	mincho@theori.io,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch net v2 2/4] selftests/tc-testing: Add a test case for pfifo_head_drop qdisc when limit==0
Date: Sat, 25 Jan 2025 20:12:22 -0800
Message-Id: <20250126041224.366350-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250126041224.366350-1-xiyou.wangcong@gmail.com>
References: <20250126041224.366350-1-xiyou.wangcong@gmail.com>
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
 .../tc-testing/tc-tests/qdiscs/fifo.json      | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fifo.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fifo.json
index ae3d286a32b2..94f6456ab460 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fifo.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/fifo.json
@@ -313,6 +313,31 @@
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
+            "$IP link add dev $DUMMY mtu 1279 type dummy || true",
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
+            "$IP link del dev $DUMMY"
         ]
     }
 ]
-- 
2.34.1


