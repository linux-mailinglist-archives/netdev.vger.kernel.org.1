Return-Path: <netdev+bounces-86611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E93AE89F944
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 16:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175B21C27637
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 14:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1AA15EFA8;
	Wed, 10 Apr 2024 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="cy9QoYxZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D7C2AF16
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757708; cv=none; b=XBFAlK+YdBViZBOOlAIfBksXkIszVgJnN1KrJPgvHGdRrAVJqvUS64aAt2algMmJjv+jg2GULqwZ0PI7SaYt9c6zfzzBJo1hbbVMoVE0n3vwOv14vFkAD4V15cU92Bmdbqun1/NAVHeF17GFb/bGB9R6kWyBcD7BebcrB8s7Jo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757708; c=relaxed/simple;
	bh=4O/WIUb7/kgpfigirbxIB46qog9zU4V7JIsbS2k/iXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=El3QBWgpG6MnKYJh+aK8a7LXWXNDJ3gM9+AKnLA/RsMybDrdemiz1VCQfz3ALk/W8V2ULzcQLmf09t1lO7sLi2YPozhai4UdBP3TpGeBBCl87PSxMCJ1B1FsWxnOR29+LlSk6dD3Rs+mQvkEjkxpVHzOdoDLRsGPih2g7pymaRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=cy9QoYxZ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78d62c1e82bso254489685a.3
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 07:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1712757705; x=1713362505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u4/Ee9DXLxrW4PpRdkk7bTip4jmhx/SZcuGstgAl7q8=;
        b=cy9QoYxZ8M93uZLyW+INgNCmxmMHENlpIevZ7LdbtFS4RjJhpQq+HINs9pGUWlioej
         vaYtlYqEqLCjvwQtGLPgHruKNx7kHJW930+2l9cebqmHbD2Fgnql90QiUmYvj6ZZXQEd
         ksR39DKfXfvsCBfaFa51rTstEmRQKwTYTGnW9AY7JB3VVPI41ZK/ZAwRh70FIFz9KQUh
         nEPTYErsk9Z3QT+KHIZ6cWPEAxIGEC+8MFeqSv7ecyInLafvw3MkafBiV/6lLB3JuhhT
         GRQM9JSYN7Mtx56ROYVMHk3p7Gika8v4OpPkG2ztmXh916uJuoom1rfYdpMgLjlyUlOx
         c/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712757705; x=1713362505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u4/Ee9DXLxrW4PpRdkk7bTip4jmhx/SZcuGstgAl7q8=;
        b=wnrpMfT9wDUtPXSve5qdcr6XAr9rc5NkGKiV2Iz9UY5Sl4rkOaGweiJpvarP8iuan5
         4vYWxGpyXEgH5H/p6yG83McQC5t/+uRmrvq4Qr3JQ4NXTn5eGRQz4HElzHzTXwk7iwye
         UihObvN2DNMYWfVEg8eDy7cm4Xaa6HlVqL46OKrd2Ve15Ewxg7F8kNNsNOTW+FM+ZQtL
         5v5IwW52u8rUl5JuYko5U1xFZysZ+DYNyripAD03m4jgCdNziANCMssw6p084Icx+23p
         20YNuw74WYYjvzoyQ/ypgF7WaJUEpv/vxK5wdMB9JtjHF6hSSeI3qEJNjDWbJtc7SevN
         kjlQ==
X-Gm-Message-State: AOJu0YyLAUGg5h7OtJ14ByQ64d7oTFEsrhxIn1Eipi3P5nXUgLA7tImd
	ipUDZa9WK74PeSwbvv/R73ULAYsYYNGDjbTWDiCmf4YYKD8DlM3xNjMTyoUStJ2G4YBFLVRfDvo
	=
X-Google-Smtp-Source: AGHT+IHYKdCnuYb+h09o60K13IEj0eo95MRvI0Etd9NguW9QLmzYzmE79EX4MYWmPz5/2K/+ty2rFA==
X-Received: by 2002:a05:620a:4919:b0:789:e524:933b with SMTP id vy25-20020a05620a491900b00789e524933bmr2318709qkn.31.1712757705001;
        Wed, 10 Apr 2024 07:01:45 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-19-174-94-28-98.dsl.bell.ca. [174.94.28.98])
        by smtp.gmail.com with ESMTPSA id t30-20020a05620a035e00b0078d74f1d3c8sm1345173qkm.110.2024.04.10.07.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 07:01:44 -0700 (PDT)
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
	khalidm@nvidia.com,
	toke@redhat.com,
	victor@mojatatu.com,
	pctammela@mojatatu.com,
	bpf@vger.kernel.org
Subject: [PATCH net-next v16  01/15] net: sched: act_api: Introduce P4 actions list
Date: Wed, 10 Apr 2024 10:01:27 -0400
Message-Id: <20240410140141.495384-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410140141.495384-1-jhs@mojatatu.com>
References: <20240410140141.495384-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In P4 we require to generate new actions "on the fly" based on the
specified P4 action definition. P4 action kinds, like the pipeline
they are attached to, must be per net namespace, as opposed to native
action kinds which are global. For that reason, we chose to create a
separate structure to store P4 actions.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/act_api.h |   8 ++-
 net/sched/act_api.c   | 123 +++++++++++++++++++++++++++++++++++++-----
 net/sched/cls_api.c   |   2 +-
 3 files changed, 116 insertions(+), 17 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 77ee0c657e2c..f22be14bba64 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -105,6 +105,7 @@ typedef void (*tc_action_priv_destructor)(void *priv);
 
 struct tc_action_ops {
 	struct list_head head;
+	struct list_head p4_head;
 	char    kind[IFNAMSIZ];
 	enum tca_id  id; /* identifier should match kind */
 	unsigned int	net_id;
@@ -199,10 +200,12 @@ int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
 int tcf_idr_release(struct tc_action *a, bool bind);
 
 int tcf_register_action(struct tc_action_ops *a, struct pernet_operations *ops);
+int tcf_register_p4_action(struct net *net, struct tc_action_ops *act);
 int tcf_unregister_action(struct tc_action_ops *a,
 			  struct pernet_operations *ops);
 #define NET_ACT_ALIAS_PREFIX "net-act-"
 #define MODULE_ALIAS_NET_ACT(kind)	MODULE_ALIAS(NET_ACT_ALIAS_PREFIX kind)
+void tcf_unregister_p4_action(struct net *net, struct tc_action_ops *act);
 int tcf_action_destroy(struct tc_action *actions[], int bind);
 int tcf_action_exec(struct sk_buff *skb, struct tc_action **actions,
 		    int nr_actions, struct tcf_result *res);
@@ -210,8 +213,9 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
 		    struct nlattr *est,
 		    struct tc_action *actions[], int init_res[], size_t *attr_size,
 		    u32 flags, u32 fl_flags, struct netlink_ext_ack *extack);
-struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, u32 flags,
-					 struct netlink_ext_ack *extack);
+struct tc_action_ops *
+tc_action_load_ops(struct net *net, struct nlattr *nla,
+		   u32 flags, struct netlink_ext_ack *extack);
 struct tc_action *tcf_action_init_1(struct net *net, struct tcf_proto *tp,
 				    struct nlattr *nla, struct nlattr *est,
 				    struct tc_action_ops *a_o, int *init_res,
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 9ee622fb1160..be78df3345cf 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -57,6 +57,40 @@ static void tcf_free_cookie_rcu(struct rcu_head *p)
 	kfree(cookie);
 }
 
+static unsigned int p4_act_net_id;
+
+struct tcf_p4_act_net {
+	struct list_head act_base;
+	struct mutex act_mod_lock; /* P4 actions list mutex */
+};
+
+static __net_init int tcf_p4_act_base_init_net(struct net *net)
+{
+	struct tcf_p4_act_net *p4_base_net = net_generic(net, p4_act_net_id);
+
+	INIT_LIST_HEAD(&p4_base_net->act_base);
+	mutex_init(&p4_base_net->act_mod_lock);
+
+	return 0;
+}
+
+static void __net_exit tcf_p4_act_base_exit_net(struct net *net)
+{
+	struct tcf_p4_act_net *p4_base_net = net_generic(net, p4_act_net_id);
+	struct tc_action_ops *ops, *tmp;
+
+	list_for_each_entry_safe(ops, tmp, &p4_base_net->act_base, p4_head) {
+		list_del(&ops->p4_head);
+	}
+}
+
+static struct pernet_operations tcf_p4_act_base_net_ops = {
+	.init = tcf_p4_act_base_init_net,
+	.exit = tcf_p4_act_base_exit_net,
+	.id = &p4_act_net_id,
+	.size = sizeof(struct tc_action_ops),
+};
+
 static void tcf_set_action_cookie(struct tc_cookie __rcu **old_cookie,
 				  struct tc_cookie *new_cookie)
 {
@@ -962,6 +996,48 @@ static void tcf_pernet_del_id_list(unsigned int id)
 	mutex_unlock(&act_id_mutex);
 }
 
+static struct tc_action_ops *tc_lookup_p4_action(struct net *net, char *kind)
+{
+	struct tcf_p4_act_net *p4_base_net = net_generic(net, p4_act_net_id);
+	struct tc_action_ops *a, *res = NULL;
+
+	mutex_lock(&p4_base_net->act_mod_lock);
+	list_for_each_entry(a, &p4_base_net->act_base, p4_head) {
+		if (strcmp(kind, a->kind) == 0) {
+			if (try_module_get(a->owner))
+				res = a;
+			break;
+		}
+	}
+	mutex_unlock(&p4_base_net->act_mod_lock);
+
+	return res;
+}
+
+void tcf_unregister_p4_action(struct net *net, struct tc_action_ops *act)
+{
+	struct tcf_p4_act_net *p4_base_net = net_generic(net, p4_act_net_id);
+
+	mutex_lock(&p4_base_net->act_mod_lock);
+	list_del(&act->p4_head);
+	mutex_unlock(&p4_base_net->act_mod_lock);
+}
+EXPORT_SYMBOL(tcf_unregister_p4_action);
+
+int tcf_register_p4_action(struct net *net, struct tc_action_ops *act)
+{
+	struct tcf_p4_act_net *p4_base_net = net_generic(net, p4_act_net_id);
+
+	if (tc_lookup_p4_action(net, act->kind))
+		return -EEXIST;
+
+	mutex_lock(&p4_base_net->act_mod_lock);
+	list_add(&act->p4_head, &p4_base_net->act_base);
+	mutex_unlock(&p4_base_net->act_mod_lock);
+
+	return 0;
+}
+
 int tcf_register_action(struct tc_action_ops *act,
 			struct pernet_operations *ops)
 {
@@ -1032,7 +1108,7 @@ int tcf_unregister_action(struct tc_action_ops *act,
 EXPORT_SYMBOL(tcf_unregister_action);
 
 /* lookup by name */
-static struct tc_action_ops *tc_lookup_action_n(char *kind)
+static struct tc_action_ops *tc_lookup_action_n(struct net *net, char *kind)
 {
 	struct tc_action_ops *a, *res = NULL;
 
@@ -1040,31 +1116,48 @@ static struct tc_action_ops *tc_lookup_action_n(char *kind)
 		read_lock(&act_mod_lock);
 		list_for_each_entry(a, &act_base, head) {
 			if (strcmp(kind, a->kind) == 0) {
-				if (try_module_get(a->owner))
-					res = a;
-				break;
+				if (try_module_get(a->owner)) {
+					read_unlock(&act_mod_lock);
+					return a;
+				}
 			}
 		}
 		read_unlock(&act_mod_lock);
+
+		return tc_lookup_p4_action(net, kind);
 	}
+
 	return res;
 }
 
 /* lookup by nlattr */
-static struct tc_action_ops *tc_lookup_action(struct nlattr *kind)
+static struct tc_action_ops *tc_lookup_action(struct net *net,
+					      struct nlattr *kind)
 {
+	struct tcf_p4_act_net *p4_base_net = net_generic(net, p4_act_net_id);
 	struct tc_action_ops *a, *res = NULL;
 
 	if (kind) {
 		read_lock(&act_mod_lock);
 		list_for_each_entry(a, &act_base, head) {
+			if (nla_strcmp(kind, a->kind) == 0) {
+				if (try_module_get(a->owner)) {
+					read_unlock(&act_mod_lock);
+					return a;
+				}
+			}
+		}
+		read_unlock(&act_mod_lock);
+
+		mutex_lock(&p4_base_net->act_mod_lock);
+		list_for_each_entry(a, &p4_base_net->act_base, p4_head) {
 			if (nla_strcmp(kind, a->kind) == 0) {
 				if (try_module_get(a->owner))
 					res = a;
 				break;
 			}
 		}
-		read_unlock(&act_mod_lock);
+		mutex_unlock(&p4_base_net->act_mod_lock);
 	}
 	return res;
 }
@@ -1324,8 +1417,9 @@ void tcf_idr_insert_many(struct tc_action *actions[], int init_res[])
 	}
 }
 
-struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, u32 flags,
-					 struct netlink_ext_ack *extack)
+struct tc_action_ops *
+tc_action_load_ops(struct net *net, struct nlattr *nla,
+		   u32 flags, struct netlink_ext_ack *extack)
 {
 	bool police = flags & TCA_ACT_FLAGS_POLICE;
 	struct nlattr *tb[TCA_ACT_MAX + 1];
@@ -1356,7 +1450,7 @@ struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, u32 flags,
 		}
 	}
 
-	a_o = tc_lookup_action_n(act_name);
+	a_o = tc_lookup_action_n(net, act_name);
 	if (a_o == NULL) {
 #ifdef CONFIG_MODULES
 		bool rtnl_held = !(flags & TCA_ACT_FLAGS_NO_RTNL);
@@ -1367,7 +1461,7 @@ struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, u32 flags,
 		if (rtnl_held)
 			rtnl_lock();
 
-		a_o = tc_lookup_action_n(act_name);
+		a_o = tc_lookup_action_n(net, act_name);
 
 		/* We dropped the RTNL semaphore in order to
 		 * perform the module load.  So, even if we
@@ -1477,7 +1571,7 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
 	for (i = 1; i <= TCA_ACT_MAX_PRIO && tb[i]; i++) {
 		struct tc_action_ops *a_o;
 
-		a_o = tc_action_load_ops(tb[i], flags, extack);
+		a_o = tc_action_load_ops(net, tb[i], flags, extack);
 		if (IS_ERR(a_o)) {
 			err = PTR_ERR(a_o);
 			goto err_mod;
@@ -1683,7 +1777,7 @@ static struct tc_action *tcf_action_get_1(struct net *net, struct nlattr *nla,
 	index = nla_get_u32(tb[TCA_ACT_INDEX]);
 
 	err = -EINVAL;
-	ops = tc_lookup_action(tb[TCA_ACT_KIND]);
+	ops = tc_lookup_action(net, tb[TCA_ACT_KIND]);
 	if (!ops) { /* could happen in batch of actions */
 		NL_SET_ERR_MSG(extack, "Specified TC action kind not found");
 		goto err_out;
@@ -1731,7 +1825,7 @@ static int tca_action_flush(struct net *net, struct nlattr *nla,
 
 	err = -EINVAL;
 	kind = tb[TCA_ACT_KIND];
-	ops = tc_lookup_action(kind);
+	ops = tc_lookup_action(net, kind);
 	if (!ops) { /*some idjot trying to flush unknown action */
 		NL_SET_ERR_MSG(extack, "Cannot flush unknown TC action");
 		goto err_out;
@@ -2184,7 +2278,7 @@ static int tc_dump_action(struct sk_buff *skb, struct netlink_callback *cb)
 		return 0;
 	}
 
-	a_o = tc_lookup_action(kind);
+	a_o = tc_lookup_action(net, kind);
 	if (a_o == NULL)
 		return 0;
 
@@ -2251,6 +2345,7 @@ static int __init tc_action_init(void)
 	rtnl_register(PF_UNSPEC, RTM_GETACTION, tc_ctl_action, tc_dump_action,
 		      0);
 
+	register_pernet_subsys(&tcf_p4_act_base_net_ops);
 	return 0;
 }
 
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 17d97bbe890f..bee911bb7d37 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -3367,7 +3367,7 @@ int tcf_exts_validate_ex(struct net *net, struct tcf_proto *tp, struct nlattr **
 			struct tc_action_ops *a_o;
 
 			flags |= TCA_ACT_FLAGS_POLICE | TCA_ACT_FLAGS_BIND;
-			a_o = tc_action_load_ops(tb[exts->police], flags,
+			a_o = tc_action_load_ops(net, tb[exts->police], flags,
 						 extack);
 			if (IS_ERR(a_o))
 				return PTR_ERR(a_o);
-- 
2.34.1


