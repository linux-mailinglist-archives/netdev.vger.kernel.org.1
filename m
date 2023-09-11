Return-Path: <netdev+bounces-32954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0720F79ABAE
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 23:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10E5281477
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 21:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6DD8C12;
	Mon, 11 Sep 2023 21:52:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27758838
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 21:52:55 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2712F8E8
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 14:52:22 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6c0bbbbad81so3056093a34.3
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 14:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1694469054; x=1695073854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRPkfE0BiV80wxpOBOz69UcDTsNr0cPpVoBtQmhjeJw=;
        b=ihdH3l6vUS1hp0yO7gHbjNOsrSztVzcFh0TS6SC0pi533fnR02DBc08h5j/9fFZ3dd
         Gg8uQEYmXLX9TfX7l8e8pl84Y5U8p9cEtRcHhAsynB4Xouxk0mMqtvjqgYtzBe4ZBsUK
         SWKE/moXiCHB+gs+JPC/DXRRaUPh1pjIlEyZ5HMoZJCgPqHY/UzVZK2ZxpYowVqYaTkI
         3WQlK5qT7pQ5VdJJ2GqOte3GFogUV8V/UaONvchE6OmSMEFdMOIFnctJoEF9yvE9Txyh
         ZOCxee3zp2i4K4cdaRu3ekbsJSpObj3cAlrH/frMtJUh0aCELwTxpHG6Lj06zEE4Oilc
         dRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694469054; x=1695073854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRPkfE0BiV80wxpOBOz69UcDTsNr0cPpVoBtQmhjeJw=;
        b=b2Y59wUXcK8j13I3TeyMuQ1LS9J+9tOTax1LWZ60cSd0yr07f5kto+LrWwpY6VATRE
         lWHyh2xFoBIM2x6KJm75rMRIadOXx/Yni+R6v9maZtJMdyoPSL8vCkc0Uxx4Q3kAVJOA
         0rObyYx2FSUBRm1S35hUNrvYD//MBVHgqlNXWs5Dlf6X5ZFl1O3l6+6VE7jSU+XaUAoy
         wnWo80dU4O0PDiqz/ZH6brt8ZJklF/FGCmBthFc9zkoyOoVx9JqOUEWWcTMF07kLa+xT
         ZpLVXT0o5H8q2tiw6jDploO8ui+0MvsX2kg4jo7cXrfqeHBVARNUIXGAzr/6TzhsIhAa
         Yelw==
X-Gm-Message-State: AOJu0Yxbz90speZEWovvoKdrTXLrwNaF5Z1IO4FLmd7ocvp6mQxnf+ck
	KAPo3ejkKEjypUsAzcS+Tri3x/eQfpSWW8b7oVE=
X-Google-Smtp-Source: AGHT+IGTvs2hdrzCuWrTYeLlNwv2udurMrNIZiKhmbKz8aM3g7E63q8DRjPkOWlgXdpJELYucvZu9w==
X-Received: by 2002:a9d:7497:0:b0:6bb:1c21:c52e with SMTP id t23-20020a9d7497000000b006bb1c21c52emr11321703otk.15.1694469053947;
        Mon, 11 Sep 2023 14:50:53 -0700 (PDT)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:accd:6e1c:69ae:3f11])
        by smtp.gmail.com with ESMTPSA id 3-20020a4a0603000000b0057635c1a4f2sm3776869ooj.25.2023.09.11.14.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 14:50:53 -0700 (PDT)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	victor@mojatatu.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v3 2/4] selftests/tc-testing: cls_route: add tests for classid
Date: Mon, 11 Sep 2023 18:50:14 -0300
Message-Id: <20230911215016.1096644-3-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230911215016.1096644-1-pctammela@mojatatu.com>
References: <20230911215016.1096644-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As discussed in 'b80b829e9e2c', cls_route was handling the use of classid
incorrectly. Add a test to check if it's conforming to the correct
behaviour.

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 .../tc-testing/tc-tests/filters/route.json    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/route.json b/tools/testing/selftests/tc-testing/tc-tests/filters/route.json
index 1f6f19f02997..8d8de8f65aef 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/route.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/route.json
@@ -177,5 +177,30 @@
         "teardown": [
             "$TC qdisc del dev $DEV1 ingress"
         ]
+    },
+    {
+        "id": "b042",
+        "name": "Try to delete class referenced by route after a replace",
+        "category": [
+            "filter",
+            "route"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DEV1 parent root handle 10: drr",
+            "$TC class add dev $DEV1 parent root classid 1 drr",
+            "$TC filter add dev $DEV1 parent 10: prio 1 route from 10 classid 10:1 action ok",
+            "$TC filter replace dev $DEV1 parent 10: prio 1 route from 5 classid 10:1 action drop"
+        ],
+        "cmdUnderTest": "$TC class delete dev $DEV1 parent 10: classid 10:1",
+        "expExitCode": "2",
+        "verifyCmd": "$TC class show dev $DEV1",
+        "matchPattern": "class drr 10:1",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DEV1 parent root drr"
+        ]
     }
 ]
-- 
2.39.2


