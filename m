Return-Path: <netdev+bounces-162340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB830A26931
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 01:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A6A1640C2
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 00:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B76139579;
	Tue,  4 Feb 2025 00:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ba6uiDza"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656D378F2F
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 00:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630750; cv=none; b=aMSTXDBFTUC0kNgK2ejOwjqmWc4iWkGtB7wtLVtbae2cEHwswQx7dYuSWq88SDfGag8te2LbRSKxaWNAwdlp+3Cb3YCVxW8ajEo/Zdpan9e8L1Pqiyrg6MBraq7QEgxLrCqGa6YdR9hyPMNYJqll2dPZOqCsVDQrmcEXeqNJYAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630750; c=relaxed/simple;
	bh=LWgxvj/KN59RqGC2OzK72Rk7dSY8bsknwV4JHD+nX5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o/sQTVViPpLgjhOH19DYVHum8wxWvHp29fudhGQPN9SLsmwclsrwuH6Oslzd6VPxm+PatxOUP8BvFes30WwHtfT5IHIywwFe0J4n11e7KcJUKgkcrpxUMEAlgwEtVY/ZG2U/R51n/+Q+r0qSpNWVTromdWn6reRTc5r0C6z3U4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ba6uiDza; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2165448243fso96838415ad.1
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 16:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738630748; x=1739235548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odZxDNANPjw9aQ1OR267U96V34DuukeaJXbQIgo9WJg=;
        b=Ba6uiDzajcn5bEf0NwUwDzUGz4DLFfvpK5QXD8zoOhEKJYwTuhP/xypPpqL9uQDY0z
         33irYmUh8W/sINF17FR9rbWx1l3SoDZV2EbsQPUvRw6s4zlnsO1ZoOcv6eUZnwkP8fRh
         xJi4oTw4nnax0lX42MFlFHBFzJTxnfGvaPBCQHN84p0bx1fPPAvEwqdyaeWuARbtdtWi
         lVfAxB+XLP1jc0FNQHAVWgv59gsYH5MIgK7vo5ZaSxQgJZyoSGTGbcAzQ06mBWbi9bmE
         KhQGmvsl64/9F52LhqhCMM+pc3v6yYUnWmnQb0CrKP3ye+OEPQ1+ZDsS1gzwFbNzlFBw
         h50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738630748; x=1739235548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odZxDNANPjw9aQ1OR267U96V34DuukeaJXbQIgo9WJg=;
        b=j53kjPJyVU7jhBOdo0BqIXyvuOQBpeMF5JxZyPH8Haz0BhLhVgZZSCrPxKB/VElA2+
         HCB2+bAB/hx1AI8lw3rt3WCuzl230DctpHgTujzy72YEnTs8+ZNmngBj3qIk8+vARwWq
         oPcTxEuHSKWgQCYf5p5gP9kVM1pb+sFbztuqQT9HMwYIuBlSsvw7fPNRhp7UZ1ZHTZpm
         0SVd+kIfehBwPbs7+3x1RaNIqAsKE99tQ7fofCVaowSHqMJFsELIl5Eh7D+qF+5+ewMX
         Ellmhvddhaps9C4d+dARQ0aNGL07LxgV1fzdD6ubzf4oM1Qq119QC8H2SeP3IMORcq+3
         V6Dw==
X-Gm-Message-State: AOJu0YxhiCDFZTSLkm44N6l7eK2MrlYCoZa9M1oR3yQtauLtzX5rHmmO
	H9unHBUBwGWlzGqKxqh6eevXqlxz786Vdw/IPsf/PV07yo+DTjIQu6cF8A==
X-Gm-Gg: ASbGnct3nryEvSNzMmQBDsR+/ikWxncNC9u2CO4cZFgUWR1Z6wJWSwnz7BFTKoXNedQ
	U0I2xNSD303w8l6kAUYhL4xYLEwS0A9ayWFZX/3UmdyT7UC/LVqb0hFUQkjCrFeBQxB2Z82YzPU
	OwEi/OovKRDNglmwiVS5Fe8AaQOsC931bDvWra+ZSmOErIgehuU5BCAZWDqRD/LiElVIKUQ3k5V
	PQzutE57JPyjgyl0ytMtoK5h5MWI6UBLcukOd3Pg3Bxl601zaLaIM7dY+yY/hKUoO49mIX5vXQe
	YiUyOCLKM1NV2aLReez4FQiY+yL17tcxMRvks5YF93aS
X-Google-Smtp-Source: AGHT+IEYts8rmKm/Av0SFIwF3dEAW0dmW/mJI70jc2SmDm6nbtWaeZtugiMPfZ7c/gXXIu+FR2MfwQ==
X-Received: by 2002:a05:6a00:218a:b0:725:eb85:f7ef with SMTP id d2e1a72fcca58-72fd0bffcf0mr31440900b3a.14.1738630748155;
        Mon, 03 Feb 2025 16:59:08 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:90d2:24fd:b5ba:920d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6427b95sm9207069b3a.49.2025.02.03.16.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 16:59:07 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	pctammela@mojatatu.com,
	mincho@theori.io,
	quanglex97@gmail.com,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch net v3 4/4] selftests/tc-testing: Add a test case for qdisc_tree_reduce_backlog()
Date: Mon,  3 Feb 2025 16:58:41 -0800
Message-Id: <20250204005841.223511-5-xiyou.wangcong@gmail.com>
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

From: Cong Wang <cong.wang@bytedance.com>

Integrate the test case provided by Mingi Cho into TDC.

All test results:

1..4
ok 1 ca5e - Check class delete notification for ffff:
ok 2 e4b7 - Check class delete notification for root ffff:
ok 3 33a9 - Check ingress is not searchable on backlog update
ok 4 a4b9 - Test class qlen notification

Cc: Mingi Cho <mincho@theori.io>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 34 ++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index d3dd65b05b5f..9044ac054167 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -94,5 +94,37 @@
             "$TC qdisc del dev $DUMMY ingress",
             "$IP addr del 10.10.10.10/24 dev $DUMMY"
         ]
-    }
+    },
+    {
+	"id": "a4b9",
+	"name": "Test class qlen notification",
+	"category": [
+	    "qdisc"
+	],
+	"plugins": {
+	    "requires": "nsPlugin"
+	},
+	"setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: drr",
+            "$TC filter add dev $DUMMY parent 1: basic classid 1:1",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 drr",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 2: netem",
+            "$TC qdisc add dev $DUMMY parent 2: handle 3: drr",
+            "$TC filter add dev $DUMMY parent 3: basic action drop",
+            "$TC class add dev $DUMMY parent 3: classid 3:1 drr",
+            "$TC class del dev $DUMMY classid 1:1",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 drr"
+        ],
+        "cmdUnderTest": "ping -c1 -W0.01 -I $DUMMY 10.10.10.1",
+        "expExitCode": "1",
+        "verifyCmd": "$TC qdisc ls dev $DUMMY",
+        "matchPattern": "drr 1: root",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root handle 1: drr",
+            "$IP addr del 10.10.10.10/24 dev $DUMMY"
+        ]
+   }
 ]
-- 
2.34.1


