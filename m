Return-Path: <netdev+bounces-176619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDFDA6B1A0
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 00:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FBCC188E391
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 23:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2B822ACF3;
	Thu, 20 Mar 2025 23:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rnx4gX+M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BE9218ADD
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 23:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513162; cv=none; b=hJ8z2BuSEYSSGzFy4tjimxhIcPwK3MoLTeoeUoMCbh6r+sCSkBZbU7IK0t82QHu8AHIZhNU2g+STGKjhBkx2L0D5b+Vg0InfQWM2sK2UHvBcMwuVJOlxNcZ0w+7ps3VQ9egLNApFMMZ//8hR2w1v161d/3lYHaG6c7UAHt8Or1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513162; c=relaxed/simple;
	bh=dApKGmJ/IF/wGEWe4n8B5OuVLv2uAAZs/hIwWmymfaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P4hgxdLFv/hEQUQmc/s8T88KmXMpOCo84A3Ao67eC5jUsjy/MYth/fDhH+NEaVSWwv3t3QYrHEAkTRuwAsveKwgUnN5ZIr8BdUm6GEbZ1WRpz6MdU3LuVfzFAcR0cI7DFHPpsIYOX1fSMCPrXTjH4+Yn938vu1bqnDhyyCDJJHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rnx4gX+M; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2241053582dso33592045ad.1
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 16:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742513156; x=1743117956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2RGUSJ1w4xWHYvp/jlzn59SSKnfWw+9Twnn1Z1lsAU=;
        b=Rnx4gX+MFs3SFPq4nPuYflC61yd6WoK/UG/35Zkom8tOxAPcbsWFlljp1jdPbtwZkt
         1Wt/Cpl/slOw7n0EkK4eENoOeDx+nNX/J0ygF1x2sWcniI+Yuu6/R9ZvHdGuDBTFZ3HC
         4Hp+ect88mBOQbeK6tsT4Pp8zfOTFgmvmMN3mDvO0bBAqLbXOqfRXDCWEjswD/g8RK+j
         4txACw+lqUpH2M/L8g/NeJZ2teYLw3eruzD0GyKkz64As+5DQKsbHICxAc+1DJ9n4ccL
         KMq9bxgvnEZmjizVimzjpF45D4ylzgr2GHg7jrhrSnVnAdFcVr536bJfTdYU4+BUDkeD
         hRCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742513156; x=1743117956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2RGUSJ1w4xWHYvp/jlzn59SSKnfWw+9Twnn1Z1lsAU=;
        b=ImZtVfBpMecn7rAvAC4uQ5Z745aSLL4mNlnxgcFCcLAwKdPXvnYhhgsCDbuBoRxI9q
         DfqyJVaUvDXwHD3o4ufUkeANhZyqKfLSeDIaR4oPBNIdA8j8T8JtBXF0fSq68JiJD2VZ
         GHyEz0NIH+668wmQXm60BaIcWXL41gqK0e67LQAaOJjKWrf8d3eQlhb6HNv6PUlKwSqu
         mOmtROx3aJx8GlM1fN5E0vc+ApJ8s3boaeLd+LYikNII0+NtpIvaa5HJJBUKBArHSBAM
         mXsBzEr/zihipW3QSICOgBHeM5uWGkC9SLiM2CYU+uJr/zUVg47ZuoWI+jARgd5fj7BR
         1dgA==
X-Gm-Message-State: AOJu0YypCcuSRGJ03s1xxw3vc0k9o3mCfcce3mRiGs5Fco23EN7yPVBH
	udv0O4z6L5Mpurtj6k64rbW4WS0oJbCYZRUPi6Qq3A1CpMghMsPZql8vIDMg
X-Gm-Gg: ASbGncvozpCyqtNSvNYZsAafWymrPTAFMkC4ozNEzg/4ggmnMElPv1tdb/YLe0PRAY2
	n5CeL8aFk+tbpLlLlxDRxjQYKtTPmZMbGjZIfr0P7y0nlqusIRt5xfn3vXTkd/NSJwm/gIhfO2e
	m651uYM9qFiVHR1tE/j5KlsWUPstbSnJ3Y/06gCzghHwfo1TjHF3HtUcWeqQOSyJDkBL3D2Mvnc
	LiFdGBh6sR6so4ENtAL8tZTWZWD6+0i5J2lBc9DwnI6ttgjWjLFdodOjLDXr8xZupwYvBiZbg27
	9peuQ4d64f60/7HeE25v1SD1s/MUhTfbA5FEQaZL3GDxYSxn45MtBCo=
X-Google-Smtp-Source: AGHT+IENDqsMgAt7miux9jGTFme73My/jmhTSgpiWcIAAvj2ITkE5k0Q7qws6aApPTbuuAm+tBVM/w==
X-Received: by 2002:a05:6a00:1409:b0:737:e73:f64b with SMTP id d2e1a72fcca58-7390593b7ffmr1775638b3a.1.1742513156528;
        Thu, 20 Mar 2025 16:25:56 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611ccf8sm416306b3a.120.2025.03.20.16.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 16:25:55 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	edumazet@google.com,
	gerrard.tai@starlabs.sg,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [Patch net 07/12] selftests/tc-testing: Add a test case for FQ_CODEL with HTB parent
Date: Thu, 20 Mar 2025 16:25:34 -0700
Message-Id: <20250320232539.486091-7-xiyou.wangcong@gmail.com>
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

Add a test case for FQ_CODEL with HTB parent to verify packet drop
behavior when the queue becomes empty. This helps ensure proper
notification mechanisms between qdiscs.

Note this is best-effort, it is hard to play with those parameters
perfectly to always trigger ->qlen_notify().

Cc: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 33 ++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 9044ac054167..06cb2c3c577e 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -126,5 +126,36 @@
             "$TC qdisc del dev $DUMMY root handle 1: drr",
             "$IP addr del 10.10.10.10/24 dev $DUMMY"
         ]
-   }
+   },
+    {
+        "id": "a4bb",
+        "name": "Test FQ_CODEL with HTB parent - force packet drop with empty queue",
+        "category": [
+            "qdisc",
+            "fq_codel",
+            "htb"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY handle 1: root htb default 10",
+            "$TC class add dev $DUMMY parent 1: classid 1:10 htb rate 1kbit",
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
+    }
 ]
-- 
2.34.1


