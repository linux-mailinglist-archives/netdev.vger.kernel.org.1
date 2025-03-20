Return-Path: <netdev+bounces-176624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4727AA6B1A3
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 00:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 536077AB176
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 23:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC13922C35E;
	Thu, 20 Mar 2025 23:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsvATv7i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BE022C32D
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 23:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513166; cv=none; b=XnmfztVnlHq0KPR4+mCJ1B4x6lRORbvnvvU5UzbpQGZSqE6RZ86/pWxZV7BGjpIsd8TKsxYFMd/U90oN2PhgnpGeQAXi+rQcUMB7Wb9nA1UVPAXqMDtDYPXjpSiUnQ4oG6PKRGmVLgglU/FIkuE7ohlDlT2OGpNChfE1WSBKhdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513166; c=relaxed/simple;
	bh=IouXjPK4uA3QlzLpHd+s5rpH3VsMsB2Ht5FGfwxZvmg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yx4IEOgN+7ze+Fz478W0Oo9j4C5LbFvwh9Gzedr5esf4mHY0b5rzRrbja41P3i+g2/ZMEAuGCRUSilKxuYbScE8zAFjelpPF2MJ6030D/rspPwSCvFKelyTjBuEIWgWkGmwnrfhAZ5vM8jf11Uvb9dQHe4+v4LHxgNQr0TNupkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsvATv7i; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2243803b776so36786185ad.0
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 16:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742513162; x=1743117962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7qLevD6GlCR4BimJM/IpPgnBGSFrzZ4pdh6GH/q8ro=;
        b=OsvATv7ikO4NOvQE0uw64lLfO8Y85CUsAqESPUaDR1u4FZCYsUmQfGqCmGg1M4d1PF
         vCAkG0rsnST58UOlbv26wuXW9LDpiVuQ2h30MflgOuGPBFLkWNBDIlMsEnupFvgBy6bO
         k4g2LPWsbMpwF5pSU0+fTqL3DHx+L58Jc3rdVe6LoJ53C2t1Q9Ctg2YpW/XCXSKCtJ9v
         SbxG0a4HanFfY+RxNS2JQNsAyH42Z6dXHv0h7j5ic68+3jT9aG2SHfAbtO8e2ufDL7RL
         y76VxJbUBKNx7jAfzjXsgQ+myvISQUyw6jy1e1kDRDSfmhVNE1Lh0PCoc07ws5WvR7Rn
         DBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742513162; x=1743117962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7qLevD6GlCR4BimJM/IpPgnBGSFrzZ4pdh6GH/q8ro=;
        b=Tev2GIGck/PTsdEHrsTwPc5pdn8v+C7dRP2JXX+N0SO4itZcspS9Renu9PdoFPyrWC
         CCGbUJhuG5AwX2FZZDYQuoa+0HZF+dBjB80IVXHr3sPft5VbRhoJj9XM5rlfJpS78neW
         +gcjgBPKGDJSrSzvjF24bv2rnWoplXJhMsECQPYYLNYDzVs55xVe+AWCGGccsZOvnA0f
         5HsMWlBsp4kI6tBHOSF4ct+pNVScpoFd4nn4MZgaNfyAgqTOvKBdoCGidPX4hIbBdxYb
         51QE+aj/Kk7B1LAwLRtf4UVSz1BEnKe1jpLfg2ZBM+mPl08hH7wygIE35Ty6OGt0h7oz
         XVoQ==
X-Gm-Message-State: AOJu0YyYbCijGm5c+adkfJquYminEt36kkK9zr3q721ShNmmMIaiNOoJ
	MbKK9FUzeG1L9ueYq/xmWD5a1loz8JF5hnxqvnvHUwftNjpQZSStFtz0tmVB
X-Gm-Gg: ASbGnctnbG6VyDtZQRMC6Y2McH4o5ADT2Lcr6Pp6HYaSEa5MGLBWCMr40enuEFverDB
	VYaxOezTz3zw81rPQwgGdv/PmorXw4H5zC0vWB4M3VxmPgIXzfRqHegbV+/APY58qTdToM1KoYH
	nwnnzu9NC6Y1JpOf8fTKp7E8sOaZ2PfYyfhvlmbdvLfKI6dSYGkkT/iqAuZL+YfF6fJxzDKXUch
	kkbX6qjgSsDOMz22SMfOaYmC5LJOekQ5CtMVp8JE8tQTQfvRkpBs9c9Y3pKGdnv+zErbIne9Crb
	A0jxAk45dDqtYmsZK+0n7E/g3Uu8JmyIydTXl6vlOeJpF/eYub2F685idBNp9SlbUw==
X-Google-Smtp-Source: AGHT+IGG6fOqiwVH2pG61cYEoKx4HVIZiXEP40e+igenhwYx8g6XYyN1JHnSEuCI1ORk65+ypzJ7QA==
X-Received: by 2002:a05:6a21:999a:b0:1f5:67c2:e3eb with SMTP id adf61e73a8af0-1fe43439eb8mr1951969637.41.1742513162256;
        Thu, 20 Mar 2025 16:26:02 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611ccf8sm416306b3a.120.2025.03.20.16.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 16:26:01 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	edumazet@google.com,
	gerrard.tai@starlabs.sg,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [Patch net 11/12] selftests/tc-testing: Add a test case for FQ_CODEL with DRR parent
Date: Thu, 20 Mar 2025 16:25:38 -0700
Message-Id: <20250320232539.486091-11-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250320232539.486091-1-xiyou.wangcong@gmail.com>
References: <20250320232211.485785-1-xiyou.wangcong@gmail.com>
 <20250320232539.486091-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case for FQ_CODEL with DRR parent to verify packet drop
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
index 4fda4007e520..a6d6ca245909 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -250,5 +250,36 @@
             "$TC qdisc del dev $DUMMY handle 1: root",
             "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
         ]
+    },
+    {
+        "id": "a4c0",
+        "name": "Test FQ_CODEL with DRR parent - force packet drop with empty queue",
+        "category": [
+            "qdisc",
+            "fq_codel",
+            "drr"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY handle 1: root drr",
+            "$TC class add dev $DUMMY parent 1: classid 1:10 drr quantum 1500",
+            "$TC qdisc add dev $DUMMY parent 1:10 handle 10: fq_codel memory_limit 1 flows 1 target 0.1ms interval 1ms",
+            "$TC filter add dev $DUMMY parent 1: protocol ip prio 1 u32 match ip protocol 1 0xff flowid 1:10",
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


