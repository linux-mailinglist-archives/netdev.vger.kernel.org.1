Return-Path: <netdev+bounces-52566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D6F7FF376
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 16:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D81E2819D2
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 15:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AE1524BA;
	Thu, 30 Nov 2023 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="02TTBh5X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571D81BD5
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 07:21:37 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cbbfdf72ecso1047837b3a.2
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 07:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701357696; x=1701962496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PV/FnAxElgomcsnpFDOxAMkh9FJZjFm56tGPBQMJCpg=;
        b=02TTBh5Xvudy3ZooW9MqXRPYIJJCE6IXCYaYPZJqiNiYDt1cU0KWfItqj5G8ohmuW+
         56xta9fAY993dbgqTDVZubSezlJzzALrZm7imFMHBnmCTaoGY0K6agbBAaQ4DzLpeLuD
         VwR/ie7wlz8bZG9IwbxUUbXCBFS4uTGmkM5x4Bw6w+jDrETdpMNN+YqjubbEqgdOayCs
         6vqygy6y981oOhJVURxXWD3VG4rDFM84MHC5jxQ8X9m95t/0YngYZgZqVZXoqPS7p1lE
         /eDFadkisWIqWBfCjBPQyxIhrxh1GDv6cYMhUG2Vgg2rGHiASQ7FgpqJ5KU9y6NJzFnQ
         b35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701357696; x=1701962496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PV/FnAxElgomcsnpFDOxAMkh9FJZjFm56tGPBQMJCpg=;
        b=SsXpPanEN1QGtjzMdsDU6oz11UJ2G7jPX1uIVK5hb/s/PG1eo1sGQggiLRfqNtawVT
         q5BrwHD/iXOHcsSQFmCpcOeA+MDIEIcnhwY5BFjPOmij6EUU/5az407fHZ6I61Cz6TYM
         wJgQL0XSjBGGxnyeIUR56PqOMm5AXxU/n/mbCEwCcdrQ7HDKMEra8wFcUX5x753Lh0CI
         OXxDzNNbNt9/VppL5eE9/wq9nRGe4bm4sVSTVeg+l3v2fUJQlH1tXe9siBUCNxVp441z
         gWwklyT3itjIBB6+8mYLVNkLYcKQ8uzC1TkaR5sPTk7bBZJbkwkpNJP6E7YSLSYeXyb7
         9jBg==
X-Gm-Message-State: AOJu0YyoDaYIQbYTozEttRRwtM/qIGAtXwCK9fJlz3Qv3oqGSELgnawR
	Ll6jnrvtd6fyev86wLoAHjn2K4M1ckU6+Inpi88=
X-Google-Smtp-Source: AGHT+IG5vth8u1O/rujHGOtQq4NWRbPLGKGkux7W+2h906NnbxeKqMUHKHtGx8SijIeehTx/lsmrHQ==
X-Received: by 2002:a05:6a20:9382:b0:18b:962c:1ead with SMTP id x2-20020a056a20938200b0018b962c1eadmr26851331pzh.3.1701357696487;
        Thu, 30 Nov 2023 07:21:36 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id p16-20020aa78610000000b006cc02a6d18asm1342579pfn.61.2023.11.30.07.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:21:36 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	mleitner@redhat.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 4/4] net/sched: act_api: use tcf_act_for_each_action in tcf_idr_insert_many
Date: Thu, 30 Nov 2023 12:20:41 -0300
Message-Id: <20231130152041.13513-5-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231130152041.13513-1-pctammela@mojatatu.com>
References: <20231130152041.13513-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The actions array is contiguous, so stop processing whenever a NULL
is found. This is already the assumption for tcf_action_destroy[1],
which is called from tcf_actions_init.

[1] https://elixir.bootlin.com/linux/v6.7-rc3/source/net/sched/act_api.c#L1115

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/act_api.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index d3cb9f5b25da..abec5c45b5a4 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1285,14 +1285,12 @@ static const struct nla_policy tcf_action_policy[TCA_ACT_MAX + 1] = {
 
 void tcf_idr_insert_many(struct tc_action *actions[])
 {
+	struct tc_action *a;
 	int i;
 
-	for (i = 0; i < TCA_ACT_MAX_PRIO; i++) {
-		struct tc_action *a = actions[i];
+	tcf_act_for_each_action(i, a, actions) {
 		struct tcf_idrinfo *idrinfo;
 
-		if (!a)
-			continue;
 		idrinfo = a->idrinfo;
 		mutex_lock(&idrinfo->lock);
 		/* Replace ERR_PTR(-EBUSY) allocated by tcf_idr_check_alloc if
-- 
2.40.1


