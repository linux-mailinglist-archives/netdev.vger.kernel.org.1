Return-Path: <netdev+bounces-179938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF9DA7EF34
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 118037A6299
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8807C221DB0;
	Mon,  7 Apr 2025 20:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tAc6d0eN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF3721C16B
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 20:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744057471; cv=none; b=hPBP0s5M5kuYEOEvcKmsjVW7JPj26PWU2mm04P4fl1JmRNHTgxorrZLLGrLhHNuCeD9/0tm8YENDeSMVgSreJaWG/fmFUrygmmTrUKHNA4wXKO4XFNs++jZfGFw26KLCw3GQ9Qx8InvBfE99vzchhuDaVz3h11DBqGvQ7fJkigU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744057471; c=relaxed/simple;
	bh=Rx70mTC5jrBBGiSG4IDZvWC3O4JrT+23oii0mRg93CM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WP6vWuHoc1FqmxGwSG+g+J18gP+c/hTabVHVJVcCz3SYx/bMT24Hu1zUQYdQWYQynXoG5FolaMpKHg2eyBadGL/96b+fXKrsyBHzM+s/X5TRMwa5sntei25JMzv7sZoDRtKTHgCwYKpriK2lH2kHJtjnlJ0kH8mxfuvvGK/ym/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tAc6d0eN; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736c135f695so3547756b3a.0
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 13:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744057469; x=1744662269; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oRmuKCfNcw+sTdkZorrOGMbmyOqx4vxcFhDxrHL5UaE=;
        b=tAc6d0eN5U45s415gsI40OpBJS5+qWkwLCOepPnKBwRPswTgOZUk3O0WJ/GGDe983O
         GD2VgURUf1aRYvWRf5I+uEtumQD4j65p5N79KKRqVyFWsSndVTbuDqyNHc9pHciaPZHN
         piQdaIak11B4thr/PAcok8wkrFL/uHQhDslnR7/hAbk/qk2aiTEDtMqUQzcsiW9GmA9x
         iTITMmqwKHk82vo94Bzuf/Y6QUBpKutZsjVi+0de/BGAMTWWWErw1jLsKmHHzsCaufbG
         DEZzwduh0Nu+ewhxSPplL1CUwXJFlq/vSUwd1it4CEFyMbZtMBul9jjFttoB6zt91ndE
         fpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744057469; x=1744662269;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRmuKCfNcw+sTdkZorrOGMbmyOqx4vxcFhDxrHL5UaE=;
        b=cmkdFyJoVtTQ86E8bRmuPXHbUcK50kRbb4DNu5ScCmRUPZyzGuGtBUzUcLQyGfbc8M
         S3/1Cz3pc/0hMeuOcG0+cBCOoXtmXCPVtEBa2ImMT77fuNa2A4k4zXrQG69Z+KbXCXO8
         kPlgeWweVx+fQGdraQlMD5mRq4FxN/JLCbHhq8oBmLHzbEDBAPI/UPfWw8NidAsMbC9E
         F2HKri5/G+hzEmq7JxXr8a7E7CBg3JSznLhiMjjWbgTuj93dsfyuRyhfJDowDtUbV0op
         2LDQvPLYsSQIY0YUuUD8nYUAlSr+1dRKl52cf744Z2n0dAS16hzNOmPhUB6KAOsrPDcq
         Xkaw==
X-Forwarded-Encrypted: i=1; AJvYcCVPG2OOxVQi1+yfJ4r3OWz4tB44VMMMGeAe02SN/pBoGmB1g8I82iHjNqWWdQplgkug/NCIKcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdcTD4uIG0Nwy2t89OcGteVV8zmWt89Q/1XrbUqaJjbl0+yUny
	VrJZMm4XCNjayKupVZPocvkpsNlvh+0w/9IwgGtfyMIPq/uPu7oL/0JzM0/nM2nbuJXZzkfapw=
	=
X-Google-Smtp-Source: AGHT+IH3nFRPIVlql3zijdnAHVFc2+NFbmwhZeb0y6aE45Wdb1wmkVaAr4XinSHW4b5Gb2P7cdUp+3I4cQ==
X-Received: from pfbdr9.prod.google.com ([2002:a05:6a00:4a89:b0:737:6e43:8e34])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e14:b0:736:4bd3:ffab
 with SMTP id d2e1a72fcca58-739e4be89demr13941563b3a.17.1744057469335; Mon, 07
 Apr 2025 13:24:29 -0700 (PDT)
Date: Mon,  7 Apr 2025 13:24:09 -0700
In-Reply-To: <20250407202409.4036738-1-tavip@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407202409.4036738-1-tavip@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407202409.4036738-4-tavip@google.com>
Subject: [PATCH net v3 3/3] selftests/tc-testing: sfq: check that a derived
 limit of 1 is rejected
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
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
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
2.49.0.504.g3bcea36a83-goog


