Return-Path: <netdev+bounces-53996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 741C28058BE
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 16:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD0D1F21817
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 15:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2155F1CE;
	Tue,  5 Dec 2023 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="k81CwbeE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995A383
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 07:30:34 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-28657040cdcso3413782a91.3
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 07:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701790234; x=1702395034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnrPR0dVCE+kR/RtDKyal/cQSVLNTf8sBi7uitToHqA=;
        b=k81CwbeEeRPAAjVK2JP8UxQYAhC8oRPuhNaySHsQ34KGrR+oEtWjXtzHEB0AQeNoUj
         7jEBCTLP66rOv6DIu5GIUuKtwkmqgn31G/ng9T3CyC47XCp3PxO7QznpjlT1wA/bddsy
         Tfx1l7659KN72VAVTSaVrNJ5B0E4mVIMSlLVSjFzZVdALRihafi5uW3RyHTpTv9OJ7kf
         tBS44gQDDACVrmLKnxuVyZh74RR3HamvjZMCcSYbruJY3d4nllAwZ1UjHr8dpT/pJIvH
         B69pC88sIbe6w3ABbuuMEOahIsQL4vr7VxW6t5n+Al3yd+0gCFgjb/gPl4qIBYYzxG5i
         O3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701790234; x=1702395034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnrPR0dVCE+kR/RtDKyal/cQSVLNTf8sBi7uitToHqA=;
        b=VxulJMH+9VgFKY1Rki7DLZAef/g0vmJawrjD31CMmrP1/Uc///nO1we7Azib59YEiB
         pkN1zzWWDnpq5z5tbQaRpE2emTzo8gUipUrV9rvoZRCxPkBSMhkxAuIQ8V5fnFBRIuw2
         hXYqzf89SdtbQeVm3GGcp8EJ8IJ0kIo/uuihK3zyKKqWqiyTXX3So8b+StHqAZ1zLK5z
         hjk1SP+yeaEewIR2JlntP4yj8qC91dPCQM8H616FqwnMd9s/wi64Ag0ztXp+FsOgW52i
         XnO8CDZ4OaKc7ZU2N1/j4B9B4jYdThhLVyWOKvahN2Wr0Eo0cg173I0RnY+G9C1llopp
         H3kA==
X-Gm-Message-State: AOJu0YxhoUcGtSwi5QVsGLvY0WDVeMx0BBZqXJj9zT/PkLnFM82h1+3/
	br7ekTAytxOIZ+hUox/+CAh5/rZA0CbdwO9eJC4=
X-Google-Smtp-Source: AGHT+IEOz9EpSTovJC5vVsGmf0c5kWp5zYZQs/KwlgzprJ+j5WwzpIg6pKffh7PTnKnK8tYWOXnmDQ==
X-Received: by 2002:a17:903:2616:b0:1d0:60ce:be09 with SMTP id jd22-20020a170903261600b001d060cebe09mr5035987plb.61.1701790233844;
        Tue, 05 Dec 2023 07:30:33 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902a70300b001cfc34965aesm10384427plq.50.2023.12.05.07.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:30:33 -0800 (PST)
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
Subject: [PATCH net-next 2/2] net/sched: act_api: skip idr replace on bound actions
Date: Tue,  5 Dec 2023 12:30:12 -0300
Message-Id: <20231205153012.484687-3-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231205153012.484687-1-pctammela@mojatatu.com>
References: <20231205153012.484687-1-pctammela@mojatatu.com>
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
index 79a044d2ae02..64d35ab46993 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1295,7 +1295,7 @@ static const struct nla_policy tcf_action_policy[TCA_ACT_MAX + 1] = {
 	[TCA_ACT_HW_STATS]	= NLA_POLICY_BITFIELD32(TCA_ACT_HW_STATS_ANY),
 };
 
-void tcf_idr_insert_many(struct tc_action *actions[])
+void tcf_idr_insert_many(struct tc_action *actions[], int init_res[])
 {
 	struct tc_action *a;
 	int i;
@@ -1303,11 +1303,12 @@ void tcf_idr_insert_many(struct tc_action *actions[])
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
@@ -1507,7 +1508,7 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
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


