Return-Path: <netdev+bounces-17202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 911C8750CD2
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 17:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1CAB1C2118B
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0863D387;
	Wed, 12 Jul 2023 15:40:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F9A34CFB
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 15:40:13 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34401BDC
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:40:07 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a1ebb85f99so6085532b6e.2
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689176407; x=1691768407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZ4RY/IF0/2FGn2l5ILgU9CCqZOHuGvuT5AQ/VhiInE=;
        b=oBj6acWV65SbHkcaePgecxZ/w+G0pS/oOTbPnVNky5qT1CTZdViCjCDRi2GAxG95sh
         fyqRlfAhXeMqYafT77JbwDMWxrYMFPGwTqe//zeKujHMhVSqOaB91X+REy193VguSkX/
         ukFuceDB5Avkota/d/LLScGPJKg0r/dquQhAoZPO3qEPyIe9Zc5+KBLtFiBi03Jd1QAn
         nCAjMeD+A2IdMCvjfzjo69RrZ2sHE13e+MuICMUjf9aAUGJGsDGsFVftALO+CDE9/GLH
         afNDgYEd2uESgOENkviU1WGcVTHAqnOkaORztYnRFB06KPxYQ/qBBYmeJGYjyS1Ed2Tb
         tgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689176407; x=1691768407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZ4RY/IF0/2FGn2l5ILgU9CCqZOHuGvuT5AQ/VhiInE=;
        b=JRqMPu2VVoPXpX78c07JUH1REpy4X/2/smxTDYpHrpka3GUETus13gYtdVvf5xa94L
         Qs00fyZNHTHdxyP+hBbAv6bWi5QZ619Pp5PdbKQwSe/Nr1uO6BzAyTGZ61gjcQBI6UHb
         sRDEyXllxh3DgBh6ONUD9u4qEB63FZTodQ0O9TeZIRR0ii00CK24NEJur3jHpGzaJ2dh
         WYcWclSacKWQP3cZgoRZFMczcnU3MvH1IOryWwncE37xnPOWrjtOpi5zy8u4jrwp+7iO
         a7RtWWYP8FfAW1tNkDWLRCtKtwF6s+ZxGx568N/lS8EbC/27WZjPFxJAz0Sa4VeMYQOJ
         XYkg==
X-Gm-Message-State: ABy/qLbaxIbDF+lVqvFOWBrxQ/DoIMMtVNVl8XBbATGBOLDs5ojHupI5
	U8W3KPJ1ZQC2QPxwSSvxKfUJJIZvA8579p4BuH8MgA==
X-Google-Smtp-Source: APBJJlENqre2uei5AA0WMvBlUk3G/XdphlzQV58YB5kbsIi3ySfEyhc7LoJu0uGhz84divzgetHtmQ==
X-Received: by 2002:a05:6808:2382:b0:3a3:6489:e83e with SMTP id bp2-20020a056808238200b003a36489e83emr23170109oib.11.1689176406795;
        Wed, 12 Jul 2023 08:40:06 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id r3-20020a0ccc03000000b0063211e61875sm2283827qvk.14.2023.07.12.08.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 08:40:06 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	Vipin.Jain@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	simon.horman@corigine.com,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com,
	john.andy.fingerhut@intel.com
Subject: [PATCH RFC v4 net-next 05/22] net/sched: act_api: add struct p4tc_action_ops as a parameter to lookup callback
Date: Wed, 12 Jul 2023 11:39:32 -0400
Message-Id: <20230712153949.6894-6-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712153949.6894-1-jhs@mojatatu.com>
References: <20230712153949.6894-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For P4TC dynamic actions, we require information from struct tc_action_ops,
specifically the action kind, to find and locate the dynamic action
information for the lookup operation.

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/act_api.h | 3 ++-
 net/sched/act_api.c   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index c2236274a..19770e8af 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -115,7 +115,8 @@ struct tc_action_ops {
 		       struct tcf_result *); /* called under RCU BH lock*/
 	int     (*dump)(struct sk_buff *, struct tc_action *, int, int);
 	void	(*cleanup)(struct tc_action *);
-	int     (*lookup)(struct net *net, struct tc_action **a, u32 index);
+	int     (*lookup)(struct net *net, const struct tc_action_ops *ops,
+			  struct tc_action **a, u32 index);
 	int     (*init)(struct net *net, struct nlattr *nla,
 			struct nlattr *est, struct tc_action **act,
 			struct tcf_proto *tp,
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 19d948fd0..42af73eaa 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -728,7 +728,7 @@ int __tcf_idr_search(struct net *net, const struct tc_action_ops *ops,
 	struct tc_action_net *tn = net_generic(net, ops->net_id);
 
 	if (unlikely(ops->lookup))
-		return ops->lookup(net, a, index);
+		return ops->lookup(net, ops, a, index);
 
 	return tcf_idr_search(tn, a, index);
 }
-- 
2.34.1


