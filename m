Return-Path: <netdev+bounces-179186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1FAA7B0FB
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DEC2173B8D
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 21:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D161F75A9;
	Thu,  3 Apr 2025 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+jIMDoy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDDA1F7545
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743715018; cv=none; b=JzA+AGzpJ1NTjSQDXmK7351X8nm5GelPx8hMIzScvOIpFWLup2T+Xb/KUySm0h5+M8vsLrt66otWVy8NkO+lgYDg67HjpWXBaVpVlliNDSWFRBVkoA0BAoBnKZRnuUqi2ELSuM57MC32hBQyCo8PDO9hfPCzx81WjUhGuTYqFdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743715018; c=relaxed/simple;
	bh=anpFHzCE/5nYXAam0BvZW+WsDhGSuUA8dJl6AuCURkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t/FOD0mXOTmg2+Sl4m7PDZRm7htQKdjpMuX1bhj+I2Ohpa53XRVXNsMeTyd4A7C7x9aPiNafnQBCL7Y9PbYni+iaVaat7/cPHKkYZVBA5vFaDThRivtKducAi2Cz478CzuzrsTdpmFEbLmSr0Spus3DvLXRfQhhLySpUTEWkp+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+jIMDoy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22928d629faso14925345ad.3
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 14:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743715016; x=1744319816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afiImfPhKRRFOtoQm9EQeUQg7/8clNxSCBdEgpV2A/U=;
        b=K+jIMDoy5dsBGSYnt6CIBxL/QP205LNEUOnCxX11zILoj4EEw4qhYc6EOz80cRa6CN
         anfm3jopu0QkuD0tW1yre4IVSwSNfHFOq6iG6CRkAmBE/8B80KW3O+zSAwUwHByEbhj1
         cd7bgtaOQLQCI87q4uDs5FsTQW+fpbVCWdh2Yg6Kq4N5sSTvyCg9CTXeUfeDIXasKe/l
         IVH5gktyPT5D4CTyrBwWRk5J0Hb/ELg3Ts0IZXeFYm22d5mvXkWBYrQBop6Kq5m4bsyH
         uXhZYZPiqVuJehxTvjXsbliTLW1KiVv2yrEMpQb30+CCPf2231EP8Ml78sKNAZSOFew8
         CICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743715016; x=1744319816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afiImfPhKRRFOtoQm9EQeUQg7/8clNxSCBdEgpV2A/U=;
        b=BoAdKANZOzpNAXClV1pw58M4LP7R4iaxjUhuGLKyU8l/YQUTOTMGYEqcM3w6QsrLp4
         CTmhafVFV4kjYrmiu0Go3+7KYHS4TtpJYiqVBV3jMTm5+a8B9WniZOqndSzpIyLpZfkO
         HtLqUgyi0N8LUW3MmajJcxLN8rLr6KfvypGYDurY0YgwDlK7KERiXquX4HSb1kmx4YEX
         dthxbUpXQESps286mAQxCI/PcSMKwUOj66P6F4ve+3dLiXlPZYbeMWYVv1XtdqKjKjUo
         4v88/Ndpuz/Y+p1otdfB6zSaqqD6E6c6ZpOzW1000f6+QJVVOXIoVN3prtvLNNmqFTGK
         Iwhg==
X-Gm-Message-State: AOJu0YzSxUMFJ+LeBD40xtdRLGfhKv4wBeaEbxVCutbPeSgJf2jDGJ8F
	p2JubfJBla88mTIVkXJqMcBnu69+7e2pUnSqZddaLhcGMYbVz6XSPVFyaQ==
X-Gm-Gg: ASbGnctUpcR5JlGi1bT7ChXpOzaLVxJNOp+SBK0JPYzb+b22hROvh+lmgsWsjxI2fgi
	Eaq2COF3+eEOVAFOulqQdXCW3IoVGqqwhsPF/eqQMDAQxlHIHLAUvWh2ltoTSWv86tU0txFXGAi
	lfQCt8pAVsKjC5U2lm3b2/HjvCAERVlCvyHWbbDFrtfgqnB5XWjTIxtkwrYlWrtvdvZXOKml7hM
	nHFTZ7G7Jc7MEAZJoiU5nm4XvuGarYR7LWer3UCYaz62nqn05OzP1xgxlY5B37Q9ZcNCHvK/lpj
	vXVy4AvNakZ9ZG14cC7OTM4ZPXv0phQ5Pf8In+IgVzg3qpLfKwlldVo=
X-Google-Smtp-Source: AGHT+IFnZ8OhF6P0tA5yy41KwBPcfdKptKDUvlepEmOdTvs9LqBs4Q+T2B5+xHivrKKHrg+jBK/ZRA==
X-Received: by 2002:a17:902:e807:b0:220:d601:a704 with SMTP id d9443c01a7336-22a8a865faemr5455885ad.18.1743715016177;
        Thu, 03 Apr 2025 14:16:56 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e1b4sm19332145ad.181.2025.04.03.14.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 14:16:55 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [Patch net v2 10/11] selftests/tc-testing: Add a test case for FQ_CODEL with DRR parent
Date: Thu,  3 Apr 2025 14:16:35 -0700
Message-Id: <20250403211636.166257-5-xiyou.wangcong@gmail.com>
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
index 0347b207fe6d..4a45fedad876 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -251,5 +251,36 @@
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


