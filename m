Return-Path: <netdev+bounces-56024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A161D80D522
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 19:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C4412818D1
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 18:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC3851017;
	Mon, 11 Dec 2023 18:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="acVXQg4t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0920895
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 10:18:40 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-35d3846fac9so15301145ab.2
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 10:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702318719; x=1702923519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uL2aiGs6fW6LDsYnjgtmKjJx2KIA/f1V5ZVmSpmJ+WE=;
        b=acVXQg4toF/LnKwlcsO4aMsk55uyOP2wn/dsB6WxSfA9a1LYW8PZjJgZ7EgM9rWyyw
         Wme89JOnElbizz27GZHpAd11g1l1PUDAfZ1FYXviSKcsYYrfJjGJktQ2fMClUztKBOSE
         fRpTtIyM684T2c2dOmG5dFM+VcFzUwNpyZurp+lymGsF9UMQXhtCxF7uYawdXgwu4APT
         DDXaznJMhpy/Fg3OGmHp1ndk4g3ThyUwnLV4MwDR11V13Zy3CzNag6uLj3ZKLFBerVk1
         KkI/kWLvFp1M9rpG8ySa9qDNtcYrjDRp/rwOWiRfguR4yEoAB5IkINXAX+Xqhkk8jn/r
         LidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702318719; x=1702923519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uL2aiGs6fW6LDsYnjgtmKjJx2KIA/f1V5ZVmSpmJ+WE=;
        b=Tr2Txlnc9XxXfz+PtBv1mefgFzHyRDzhG2iLolHmXB4Z5mRq3SWACCq9AcCvk2zQil
         dCQwPbCr57oIimgVKw8oHJCdWximrrOjldt6Y7XiHeeI4NIHWnNMop7LPj7mbCxBXaet
         08xZaqvfnneOMGR57VSN5UzXirSKlJDhc18+lXKeDRhvPRe67Zzk0jixtGxn02ggaxVC
         30MjLFr7T/kAUmpUQNCl0G4msVxx7JG/EJPXyJNo0ypstnkJdNhywHBDk99wCS0H+rpz
         df4nX5BwbbPP2HufVNAYhKU3BialEpHuozcpEfnvghfxARpMG2AJQIIrueervlOEhlYc
         jIVw==
X-Gm-Message-State: AOJu0YwRR4QOQuzrYqsASW7C2XWF2jPNg/NFkOY24vRRigwWFknhvh23
	ad1KrLG0OfxQlUcXgnxHc4DHQBthMTHb4fgoW6Y=
X-Google-Smtp-Source: AGHT+IH8S11fATaluRDitkjI7ZuOcvcsu/WUxX/CRQebkB0/NBDW3CgnHUAdGgWEafM+3byU4FAduw==
X-Received: by 2002:a05:6e02:1609:b0:35d:6909:3b5c with SMTP id t9-20020a056e02160900b0035d69093b5cmr7029976ilu.2.1702318719208;
        Mon, 11 Dec 2023 10:18:39 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id o17-20020a656151000000b005c2420fb198sm5756139pgv.37.2023.12.11.10.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 10:18:38 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	marcelo.leitner@gmail.com,
	vladbu@nvidia.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v2 2/2] net/sched: act_api: skip idr replace on bound actions
Date: Mon, 11 Dec 2023 15:18:07 -0300
Message-Id: <20231211181807.96028-3-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231211181807.96028-1-pctammela@mojatatu.com>
References: <20231211181807.96028-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcf_idr_insert_many will replace the allocated -EBUSY pointer in
tcf_idr_check_alloc with the real action pointer, exposing it
to all operations. This operation is only needed when the action pointer
is created (ACT_P_CREATED). For actions which are bound to (returned 0),
the pointer already resides in the idr making such operation a nop.

Even though it's a nop, it's still not a cheap operation as internally
the idr code walks the idr and then does a replace on the appropriate slot.
So if the action was bound, better skip the idr replace entirely.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 include/net/act_api.h |  2 +-
 net/sched/act_api.c   | 11 ++++++-----
 net/sched/cls_api.c   |  2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 4ae0580b63ca..ea13e1e4a7c2 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -191,7 +191,7 @@ int tcf_idr_create_from_flags(struct tc_action_net *tn, u32 index,
 			      struct nlattr *est, struct tc_action **a,
 			      const struct tc_action_ops *ops, int bind,
 			      u32 flags);
-void tcf_idr_insert_many(struct tc_action *actions[]);
+void tcf_idr_insert_many(struct tc_action *actions[], int init_res[]);
 void tcf_idr_cleanup(struct tc_action_net *tn, u32 index);
 int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
 			struct tc_action **a, int bind);
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 688227acac45..1e3de528e005 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1304,7 +1304,7 @@ static const struct nla_policy tcf_action_policy[TCA_ACT_MAX + 1] = {
 	[TCA_ACT_HW_STATS]	= NLA_POLICY_BITFIELD32(TCA_ACT_HW_STATS_ANY),
 };
 
-void tcf_idr_insert_many(struct tc_action *actions[])
+void tcf_idr_insert_many(struct tc_action *actions[], int init_res[])
 {
 	struct tc_action *a;
 	int i;
@@ -1312,11 +1312,12 @@ void tcf_idr_insert_many(struct tc_action *actions[])
 	tcf_act_for_each_action(i, a, actions) {
 		struct tcf_idrinfo *idrinfo;
 
+		if (init_res[i] == 0) /* Bound */
+			continue;
+
 		idrinfo = a->idrinfo;
 		mutex_lock(&idrinfo->lock);
-		/* Replace ERR_PTR(-EBUSY) allocated by tcf_idr_check_alloc if
-		 * it is just created, otherwise this is just a nop.
-		 */
+		/* Replace ERR_PTR(-EBUSY) allocated by tcf_idr_check_alloc */
 		idr_replace(&idrinfo->action_idr, a, a->tcfa_index);
 		mutex_unlock(&idrinfo->lock);
 	}
@@ -1516,7 +1517,7 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
 	/* We have to commit them all together, because if any error happened in
 	 * between, we could not handle the failure gracefully.
 	 */
-	tcf_idr_insert_many(actions);
+	tcf_idr_insert_many(actions, init_res);
 
 	*attr_size = tcf_action_full_attrs_size(sz);
 	err = i - 1;
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 1976bd163986..6391b341284e 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -3309,7 +3309,7 @@ int tcf_exts_validate_ex(struct net *net, struct tcf_proto *tp, struct nlattr **
 			act->type = exts->type = TCA_OLD_COMPAT;
 			exts->actions[0] = act;
 			exts->nr_actions = 1;
-			tcf_idr_insert_many(exts->actions);
+			tcf_idr_insert_many(exts->actions, init_res);
 		} else if (exts->action && tb[exts->action]) {
 			int err;
 
-- 
2.40.1


