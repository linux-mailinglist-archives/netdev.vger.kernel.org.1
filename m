Return-Path: <netdev+bounces-176623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1613A6B1A5
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 00:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05831188F1AB
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 23:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E59B22CBE3;
	Thu, 20 Mar 2025 23:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNI7Um6F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEC022256A
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 23:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513166; cv=none; b=sWgXv0UlAxtyeLI6mrVQ8kitZpBpiX6Ig85pju7XJyYGbuvWESaRLJ03UYByCudHcqGdrh+RegNNoIhgHVLw5w12w4iICGp/sDhHvNsmmwKBdyd6qXnhsCyXm2iWGVHvlCYitPjYjF/zxuMAlK6nOjo699TUjAjAZf2za5w/Quw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513166; c=relaxed/simple;
	bh=lU3xfMh0qYoMIiSplM10X9CtTvMO8HnfZ9zDyMl+1+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E0SBMyBK1rHuDPJJ/HhxFwZr+9YGU9A/sSWEL63BVAVgLDIIeIltfHAbPYjIPuO/cWoKeUysjNqJeaobYnCK5nuCobjOhQcT1WtWlBshZRkgEW5wA5z3WH64oHnmjmMb1AdkbsprF51nzpMmDqE45zu1zSajnovFv5V8f1CMfA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNI7Um6F; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2255003f4c6so26464225ad.0
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 16:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742513164; x=1743117964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MesFb9x0ZQABDBU0pFo6C4lSwKMMx5MhhAXZ9rv2n9c=;
        b=CNI7Um6F1O6gHWK1jb0uIhL/S3B96cYbgukPqrbCr79xOTpqJNxB4lGzFPtTkL7/u5
         PXVlbkP2UXCBDz7oxmO3LnlYQdTjadVhIVGQ15WXsaO0iaEIvG68osgRENXIcVvCBYdd
         Dg3Saa3OlRZZMquRP+tBax+SLs8N3sQ9To5OOclkCJ6U7x6VWEMToAnrtyTnchL/GV1v
         +zZZ22S7vrs2F6TP2H4jUDLB5GYb7gWhItePUMKllugpdie3CGH/ZfF2u3qxGX/aE0V7
         mPzSldm1dFHCkHQjSL2KCtuiWS9efBOtdegGOjG4f0FgEMOSJFBcf2fFiwSfpVpg4Y0J
         Q/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742513164; x=1743117964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MesFb9x0ZQABDBU0pFo6C4lSwKMMx5MhhAXZ9rv2n9c=;
        b=km3QdwZmDskgBBCvmDUTpEiTZjf8w2WpJ6hy0w5McWSEECm0b1kwv+vYfzDzkXR+Qv
         E1jx7r25+tWQPx8GokHq58HpTervpqabRQ6dsjCx+mPw/t9CCEMX3oNoglyBDpnFgjgs
         /J0320KkTCi0slXNdGDBzKJ/B5d4JtrRuCMGlFIceK95qa93faizO5SKRVn7slgZDZYC
         hW/J2ur36jzMWfu7C85izaktb7FnKZkvTgby2h7SinmT8KOeVJWkgI5rrrOMv0TZYSRj
         Dw05hMivoqdNzw6LCqGc+7/Cw2MMuZimNUhxDn4I/zJM4MLFrK7fImq2C87plSkmTzfF
         y84A==
X-Gm-Message-State: AOJu0Yz8oI3d3BIb6keHtCh2aCteFefCbNrcutHSvpFzm7BoGXBSYpKC
	EXvqgfMI8F48lzcesTDRIuxsb2bLGFmSrEyfRhhWkEqPFErxexjqv/Uy9qH/
X-Gm-Gg: ASbGncv6gH3DK9WBwlDBptOJS90Pc3ZeNTcj2SvWj61OCNa3IBw+jLvyhilbvWwVDYH
	bhFwSf4gkqSAaAUJ8vcYps/z1rIYLWwlcneM5L4jkcDGEO9yaprwdmA1hlG/Kt6Ft1HrZ/lB2ns
	cWMHuzC/7RYqramPTR8qCQPXFjcxWZDL6mAKHSVdC/EZ91wNdjLQHU2UXrpnnuhyJbGW8Yu3vQF
	S2IVqHcYQ89cZjOw8agQHQ80STxumRD97LxnRbGtanQutk3eussPs5Ab/K/5qfslQErIkaeok+D
	bsXPSbxFQktC+KinNy/Ih2HiZVplI0Evo2Fm/BRJtGxXOi6+gFxYojM=
X-Google-Smtp-Source: AGHT+IFSTLEGpzdDMtGc0MwSEaPOzZ11IIgObET1BsNuIE43xcqLuR1H3TKPYO2MZFN6frAfdGWPRQ==
X-Received: by 2002:aa7:88c7:0:b0:736:5725:59b9 with SMTP id d2e1a72fcca58-7390593d43fmr1924313b3a.2.1742513163569;
        Thu, 20 Mar 2025 16:26:03 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611ccf8sm416306b3a.120.2025.03.20.16.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 16:26:03 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	edumazet@google.com,
	gerrard.tai@starlabs.sg,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [Patch net 12/12] selftests/tc-testing: Add a test case for FQ_CODEL with ETS parent
Date: Thu, 20 Mar 2025 16:25:39 -0700
Message-Id: <20250320232539.486091-12-xiyou.wangcong@gmail.com>
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
index a6d6ca245909..3e38f81f830c 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -281,5 +281,36 @@
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


