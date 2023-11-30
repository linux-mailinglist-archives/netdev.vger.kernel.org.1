Return-Path: <netdev+bounces-52565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C087B7FF375
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 16:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796F328188F
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 15:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAF0524A9;
	Thu, 30 Nov 2023 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="zpZfp6h+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89931BD2
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 07:21:33 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6cdcd790f42so1060974b3a.3
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 07:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701357693; x=1701962493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fQ0E21BvJN0Iwjm/femF1Os2TlYZXPFt1b5fVnA6IY=;
        b=zpZfp6h+kGrYS4ziValmDIFylm3oDrzYcbNwD3yEUBAqxg94sot9DEc/nt46jHkIPt
         Y/lEyf6da4II2ZmBse5vp4qD9UfDL+omcsqYz719Y0rhjkmORNrBI0haKGNAprfFwJSh
         2ct/gQbwgAlR1rSMFfErD83aeiCu7ePIIOwbYbvhraH3dpll0pm8uH1SS6LtUqE5wRdI
         Yv4N4gozgIypK8YlPHeY1Jt63zElZ0ycbFAuDwXPUqqcBFn9lvtJDrhYR5TThxwPthmu
         eI3AGlLvo5f3SpufGFpidcQGs+K0Y7Xaxl61SwxHudOlEuzHysXp4dnp/LafL2bCiqpZ
         EJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701357693; x=1701962493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fQ0E21BvJN0Iwjm/femF1Os2TlYZXPFt1b5fVnA6IY=;
        b=fSN2LryGBuEgu3jEFEbOpOH2e1q/HD8VAIXe95zGU3yuswk9n3t6t7fTIuWG8AbZel
         LMcmHrpy/ffauyiP3u6RJuXjXwvg+xfyuRR7EmvLOEklWTEeURQqEAr00GZbhQWRrAO3
         CUT7GWxj0FF3fdza+oOwitCqtgoKTMTon6EHEbm8ep7oiuxis9uoEGTtOgyg2DfACCfO
         UW3TWf+1zwqcVQAEX59uJ1lHYaDjPqSsAE+i6ra8cuR24jHPCeM7xSKJn5YcVw8txYD3
         iPHkVcEmRuYnPrp6DuHmNxyxJ0Y3FQZ+oNexsWV5WlW5qTJS6EaA3kQAUjkvk93VJXmI
         yowg==
X-Gm-Message-State: AOJu0Yxv8O7RyYxUuRdYC6LR3BhHJWbiK0sSvWVNssDEomkIXkJkSNlY
	+LjnEHWUKwP2yZAYtnJSyflXFkYijM43/EYg+eM=
X-Google-Smtp-Source: AGHT+IGzDr40ylhmdKfs1ZggEL5dadBqX+6hB+XTy20vplwdEgsOKGh10Or5UNPFj8EZg/tpKKt+uA==
X-Received: by 2002:a05:6a00:891:b0:6c4:d5ee:c6 with SMTP id q17-20020a056a00089100b006c4d5ee00c6mr26552902pfj.1.1701357693238;
        Thu, 30 Nov 2023 07:21:33 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id p16-20020aa78610000000b006cc02a6d18asm1342579pfn.61.2023.11.30.07.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:21:32 -0800 (PST)
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
Subject: [PATCH net-next 3/4] net/sched: act_api: stop loop over ops array on NULL in tcf_action_init
Date: Thu, 30 Nov 2023 12:20:40 -0300
Message-Id: <20231130152041.13513-4-pctammela@mojatatu.com>
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

The ops array is contiguous, so stop processing whenever a NULL is found

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/act_api.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 2e948e5992b6..d3cb9f5b25da 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1506,10 +1506,8 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
 err:
 	tcf_action_destroy(actions, flags & TCA_ACT_FLAGS_BIND);
 err_mod:
-	for (i = 0; i < TCA_ACT_MAX_PRIO; i++) {
-		if (ops[i])
-			module_put(ops[i]->owner);
-	}
+	for (i = 0; i < TCA_ACT_MAX_PRIO && ops[i]; i++)
+		module_put(ops[i]->owner);
 	return err;
 }
 
-- 
2.40.1


