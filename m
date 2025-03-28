Return-Path: <netdev+bounces-178165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A9EA7515C
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 21:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39B8218955CD
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 20:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E758F1EB5EB;
	Fri, 28 Mar 2025 20:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CQc7cF5f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741911E9B17
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 20:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743193005; cv=none; b=iWrs2vQb2cxQ30wDvZNn9Fvb5yvtaL5W3IcHMHLiR9pQWNBy66KHt9X9QlhPNHNBUkKkGww5e9RKQ1bVMt3YBTAvrtgWXFuWB3dJR129YJts9ZF/ZCXFfyOfn4Vps0MXgi5Fc3/dithU65j9moTDPJBy+TVUN+t+tE4DrLBia6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743193005; c=relaxed/simple;
	bh=le48TpsLIXgwRUE7JK2oXHpEVjkDjeIk8bkxcrTUacQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mqfIJ4jChd6x6uxJ+Fylef9vn20QrrkKJTJxNAwK3O9i3qTH+8nRSPX1OBH/M3Xma3lKm2q1Z5vItt6VwNCaFSr4u9vKYC7Hmd0VzxTYu9XoCz2SN7mUQD0p6Vf2S0a1IJOywDVhk/PDOavGyAydgu0aI6ytbi1TUESE6jA4xhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CQc7cF5f; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2240a96112fso74872685ad.2
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 13:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743193003; x=1743797803; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WR5OMrXI1sfyljYWNGyiK+AjZvbJe/Y00ticFJRI05Y=;
        b=CQc7cF5fRIg/cVLPM418s4IZ7czghI291HBtM24bg9tG8Pr8jlmUw8bxvXISz5sQ8l
         3YG7qv59Fj8bVLawjK83iYRQLFH79nng9SoarHQlQLMw/VLrYJOAR2cqbSQLAKWrwHek
         fWbseJNwM/sDM9zgmjV6qEhY3lE+ZJdf5Xnc4RW771Sy34QsA2iflM6tfxXh8vsF4PQ+
         q5XS+2tJWF4OfuyAhipJbMIuM5ob98wzM37yDuMst3PWDvG2mUiXRDuHjKY0vkQmppn7
         oKQATCg14Sk0Cm3JchC8ivGhF4dVbiDpLq38yrMTAIbq6aiVNWi1hkWIpreZmPIlv1R8
         IeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743193003; x=1743797803;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WR5OMrXI1sfyljYWNGyiK+AjZvbJe/Y00ticFJRI05Y=;
        b=WyU8YLyqYwE8WKwtVTyLSeJ8TYDtxRDHf+/yDAs2PIhluMzk3ovbg1dZh0YT5ugcgD
         L+iif57Xov2IVco2if48KNxRQJ9SULkWur/+Jp0CeMBRm55JabP/sPLdHemJgJtt20J2
         3TfxvIlsWMz1lnbyVNy07r8bH2ZOeLTZSyZ9/uKC8SdnoqtVcjeHVOWcAzboY70r+03Z
         CVYYfjfU0wU9Pdh0icdU43IsZ/wlU64gGrJ5icN5qDMmmNzRq8Cx/I77YTKpXy0r/+4W
         fOYZ152mFLnSPm/r+IPRTZaA36THuJUAuYL82E1t4fIQ1FUllH9/4p40elfPHwNriRar
         UGrw==
X-Forwarded-Encrypted: i=1; AJvYcCVk9g+5s2/XjOSlpl3y90cwrooGhw76oSFh+Wcwt6kdSpV1X1ajnejN9nhSl4+Q5mF9iHoBhpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4yml3QR/ApY87yAaHUOBkhmo/SQm6Ih/q95nnSZulvNB2kZ0c
	TxHPbQN9dYci2A+6U5LArpKet8VgrRc9bI3OOJQHKmiReUH1e9CEnQdr/Zwo3G3yitLe2crHjQ=
	=
X-Google-Smtp-Source: AGHT+IF/gmMBHEO5lFnJQmBUNEDIBqTm9oF7h64VgCkip8w3eGBGSWXUZKzfHz2IR6MvtfrZnBYeGVCPoQ==
X-Received: from pfbit9.prod.google.com ([2002:a05:6a00:4589:b0:736:5b36:db8f])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1309:b0:736:546c:eb69
 with SMTP id d2e1a72fcca58-7398036fb06mr799581b3a.9.1743193002576; Fri, 28
 Mar 2025 13:16:42 -0700 (PDT)
Date: Fri, 28 Mar 2025 13:16:34 -0700
In-Reply-To: <20250328201634.3876474-1-tavip@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250328201634.3876474-1-tavip@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250328201634.3876474-4-tavip@google.com>
Subject: [PATCH net 3/3] selftests/tc-testing: sfq: check that a derived limit
 of 1 is rejected
From: Octavian Purdila <tavip@google.com>
To: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org, 
	Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"

Because the limit is updated indirectly when other parameters are
updated, there are cases where even though the user requests a limit
of 2 it can actually be set to 1.

Add the following test cases to check that the kernel rejects them:
- limit 2 depth 1 flows 1
- limit 2 depth 1 divisor 1

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 .../tc-testing/tc-tests/qdiscs/sfq.json       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfq.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfq.json
index 50e8d72781cb..28c6ce6da7db 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfq.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/sfq.json
@@ -228,5 +228,41 @@
         "matchCount": "0",
         "teardown": [
         ]
+    },
+    {
+        "id": "7f8f",
+        "name": "Check that a derived limit of 1 is rejected (limit 2 depth 1 flows 1)",
+        "category": [
+            "qdisc",
+            "sfq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfq limit 2 depth 1 flows 1",
+        "expExitCode": "2",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "sfq",
+        "matchCount": "0",
+        "teardown": []
+    },
+    {
+        "id": "5168",
+        "name": "Check that a derived limit of 1 is rejected (limit 2 depth 1 divisor 1)",
+        "category": [
+            "qdisc",
+            "sfq"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root sfq limit 2 depth 1 divisor 1",
+        "expExitCode": "2",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "sfq",
+        "matchCount": "0",
+        "teardown": []
     }
 ]
-- 
2.49.0.472.ge94155a9ec-goog


