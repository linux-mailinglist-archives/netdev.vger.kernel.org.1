Return-Path: <netdev+bounces-37166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA0D7B40F4
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 16:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 11D3A2825F1
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 14:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9907C9440;
	Sat, 30 Sep 2023 14:36:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9261D1401D
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 14:36:00 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261791A5
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 07:35:58 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7742da399a2so732453385a.0
        for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 07:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696084556; x=1696689356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1i2GVj3+UN1pG2rRWRK6h5BYJlD5qWgzjn+UWz+Pl0=;
        b=rNg8/oufUxIGvywtbcWSc7FugvHUSk+gN0u/tEJrFlfYNGRr2vW2EpkJ8E6/hnlrs5
         T3gP0bBogjzsesFG+h/PtuREId9Lc7SKn9ZJRcG+bThvG5oz2e7rhGXWdwhXOzuzdf5u
         YuLRqhhPnzlZErqFNiWEJUWzMtUoWMwFVR03cGYwUje29E/RbRmVAEAyvK48MAA2QmKv
         3vbPnRTYnrY9CiBr+jmxTpvsGcv1DytaFxK0674GiUBVpc+VT9w2NPC3FaMxMxSJ9MeW
         7fmWBU75v1XrTDKVkOxvdQ65vC2mpxodT7fR0TjYTQNvz+nSpMcM7fkbJIRsSJObOgOB
         glHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696084556; x=1696689356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1i2GVj3+UN1pG2rRWRK6h5BYJlD5qWgzjn+UWz+Pl0=;
        b=ByplOOI4zp3cPYnEdn5yuFwwATy7sJ+2M2b10BtU0omxASNeppjlANIqWRh1x/doAR
         64ztQspqmqSOnDyU9NpFN+yDU9z3+/xDHsE4L6vLEDGzaGlunKQz98u3OqnuO5J0C9ui
         csvpDmeM5/zUgEcv00Ig0vS0aUGMZBdU+UTCP6kmCi66DiV+ZPlXifuoW+URJYpML5qX
         W5dNyEgNho4NXMSdrqohxcTBWjliv15+uXUxgxTrhi/6XbS6H/Pf/31UFcATruHazWw/
         2gNe1GNcUWj6kWwMnVZangolnn5IKe8fcaqeXSFMvIQHSmTuAN6esx9XvB1IXRQlCU0j
         qLew==
X-Gm-Message-State: AOJu0Yxwz7TTyDE2So5c6wKE1Orc5cIWLujRB4hCdKBLCYW3rocvRYWe
	cFGdXUDIxEenoLqqGEVDS/aJ7oZH0PdH8hvZ+d0=
X-Google-Smtp-Source: AGHT+IGKyrMP/ajDm6e26unCE7aXfXGy7+fNBfM7fZ1OsL0pGJd5D6ThPoIOy15F8vPOTF7uWhmXRQ==
X-Received: by 2002:a05:620a:4316:b0:775:a534:c010 with SMTP id u22-20020a05620a431600b00775a534c010mr277060qko.57.1696084556367;
        Sat, 30 Sep 2023 07:35:56 -0700 (PDT)
Received: from majuu.waya ([174.93.66.252])
        by smtp.gmail.com with ESMTPSA id vr25-20020a05620a55b900b0077434d0f06esm4466409qkn.52.2023.09.30.07.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 07:35:55 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	kernel@mojatatu.com,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com
Subject: [PATCH RFC v6 net-next 03/17] net/sched: act_api: Update tc_action_ops to account for dynamic actions
Date: Sat, 30 Sep 2023 10:35:28 -0400
Message-Id: <20230930143542.101000-4-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930143542.101000-1-jhs@mojatatu.com>
References: <20230930143542.101000-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	TVD_PH_SUBJ_META1 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The initialisation of P4TC action instances require access to a struct
p4tc_act (which appears in later patches) to help us to retrieve
information like the dynamic action parameters etc. In order to retrieve
struct p4tc_act we need the pipeline name or id and the action name or id.
Also recall that P4TC action IDs are dynamic and are net namespace
specific. The init callback from tc_action_ops parameters had no way of
supplying us that information. To solve this issue, we decided to create a
new tc_action_ops callback (init_ops), that provies us with the
tc_action_ops  struct which then provides us with the pipeline and action
name. In addition we add a new refcount to struct tc_action_ops called
dyn_ref, which accounts for how many action instances we have of a specific
action.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/act_api.h |  6 ++++++
 net/sched/act_api.c   | 14 +++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index b38a7029a..1fdf502a5 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -109,6 +109,7 @@ struct tc_action_ops {
 	char    kind[ACTNAMSIZ];
 	enum tca_id  id; /* identifier should match kind */
 	unsigned int	net_id;
+	refcount_t dyn_ref;
 	size_t	size;
 	struct module		*owner;
 	int     (*act)(struct sk_buff *, const struct tc_action *,
@@ -120,6 +121,11 @@ struct tc_action_ops {
 			struct nlattr *est, struct tc_action **act,
 			struct tcf_proto *tp,
 			u32 flags, struct netlink_ext_ack *extack);
+	/* This should be merged with the original init action */
+	int     (*init_ops)(struct net *net, struct nlattr *nla,
+			    struct nlattr *est, struct tc_action **act,
+			   struct tcf_proto *tp, struct tc_action_ops *ops,
+			   u32 flags, struct netlink_ext_ack *extack);
 	int     (*walk)(struct net *, struct sk_buff *,
 			struct netlink_callback *, int,
 			const struct tc_action_ops *,
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 70c9eba62..f0ec70b42 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1023,7 +1023,7 @@ int tcf_register_action(struct tc_action_ops *act,
 	struct tc_action_ops *a;
 	int ret;
 
-	if (!act->act || !act->dump || !act->init)
+	if (!act->act || !act->dump || (!act->init && !act->init_ops))
 		return -EINVAL;
 
 	/* We have to register pernet ops before making the action ops visible,
@@ -1484,8 +1484,16 @@ struct tc_action *tcf_action_init_1(struct net *net, struct tcf_proto *tp,
 			}
 		}
 
-		err = a_o->init(net, tb[TCA_ACT_OPTIONS], est, &a, tp,
-				userflags.value | flags, extack);
+		/* When we arrive here we guarantee that a_o->init or
+		 * a_o->init_ops exist.
+		 */
+		if (a_o->init)
+			err = a_o->init(net, tb[TCA_ACT_OPTIONS], est, &a, tp,
+					userflags.value | flags, extack);
+		else
+			err = a_o->init_ops(net, tb[TCA_ACT_OPTIONS], est, &a,
+					    tp, a_o, userflags.value | flags,
+					    extack);
 	} else {
 		err = a_o->init(net, nla, est, &a, tp, userflags.value | flags,
 				extack);
-- 
2.34.1


