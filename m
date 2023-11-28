Return-Path: <netdev+bounces-51760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B827FBEF2
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 17:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36A091C20BEC
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1313E4F8BF;
	Tue, 28 Nov 2023 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="dBZjOYfh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD58D51
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 08:06:57 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cfc1512df1so20734295ad.2
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 08:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701187616; x=1701792416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cpbgqexz+gfCDSTA1ICezbvaRJ8TZbvyWTHgolUElmU=;
        b=dBZjOYfh44hVuX8ErvPxA6oxh5LV9xJUxxge210FYyq5N5lbmHP5830Vh4meDfqzYj
         pqmIFjtIKl07yO+qxaMgegbtqARXCJdsWqzang9RsIkEru9AcveD8IsBqvig9LdwVWrM
         JMn79s6MDajyqHWXmGqEISD8YKkgNmDq49PjKfffhoEM6zr5rTsSGgcEGbvALHp2aaFU
         vrYGhxIv66PJ87HgBSKfbz7SogQ0hrbzI2EyDkL3KM8gf0FBigkcTF3R9qZ2ERrkWjWP
         vDxoWFYgFf20NBhVnSaxBKCmf2DNT3l0IQq/i1vm7ihwQD8pzdHmsUtILNdzuZ4VZ32h
         Rc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701187616; x=1701792416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cpbgqexz+gfCDSTA1ICezbvaRJ8TZbvyWTHgolUElmU=;
        b=m+CCnKA/IKIaEiQskX/8BY8bc3h7ZXZ2Y5n3UmFsdB/983zxlBe1sOf0T8945qVVwt
         7kvXQstSZXoOsMako2ke95/i7TGH/S6JSuY874kuTlcaWSLDV9WuXYQDCviFxJioMnX3
         +ET8q9r3hxAM10DKnys7cWvgIS2w3RoJ9PvbAFeJ/3XHGn79W//8TQVLxDALklmKT4bA
         aXH9luBcVNdmONvyUCd4YJH65ifFuTWg2APauV0rs7aGRp3cZs++Lmzfuv3bIneZziom
         a04kpJ0X7dSLmFn53mzjZm47TtHhiZqw9R7KLtB4H2v7DsxLnpGZBKUMJ1Qdo8oX7ZGm
         xxwg==
X-Gm-Message-State: AOJu0Yy7cbCpZKDVDNjjsNfVyEw46md84YLUy0BrhOifjKUIafZkGOY7
	VzSpn6fh8P/cYl2jLMXieC62uFcyzaCRaNcR+38=
X-Google-Smtp-Source: AGHT+IFk36905yO8e9pZvRfy84E5O/QYkFiK32d8UGhQjPw1I1xca/tMRQcjDD2BqwQ62PfwdjomJg==
X-Received: by 2002:a17:902:f68e:b0:1cf:9bd1:aaea with SMTP id l14-20020a170902f68e00b001cf9bd1aaeamr18787952plg.11.1701187616444;
        Tue, 28 Nov 2023 08:06:56 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id i4-20020a170902c94400b001bf52834696sm8510504pla.207.2023.11.28.08.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 08:06:56 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	vladbu@nvidia.com,
	mleitner@redhat.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH RFC net-next 2/4] net/sched: act_api: skip idr replace on bound actions
Date: Tue, 28 Nov 2023 13:06:29 -0300
Message-Id: <20231128160631.663351-3-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231128160631.663351-1-pctammela@mojatatu.com>
References: <20231128160631.663351-1-pctammela@mojatatu.com>
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
index 048e660aba30..bf6f9ca15a30 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1286,7 +1286,7 @@ static const struct nla_policy tcf_action_policy[TCA_ACT_MAX + 1] = {
 	[TCA_ACT_HW_STATS]	= NLA_POLICY_BITFIELD32(TCA_ACT_HW_STATS_ANY),
 };
 
-void tcf_idr_insert_many(struct tc_action *actions[])
+void tcf_idr_insert_many(struct tc_action *actions[], int init_res[])
 {
 	int i;
 
@@ -1296,11 +1296,12 @@ void tcf_idr_insert_many(struct tc_action *actions[])
 
 		if (!a)
 			continue;
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
@@ -1500,7 +1501,7 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
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


