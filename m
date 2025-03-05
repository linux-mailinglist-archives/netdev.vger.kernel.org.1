Return-Path: <netdev+bounces-172139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 713B5A50516
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 17:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 702FE7A537D
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 16:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1EC19ADBA;
	Wed,  5 Mar 2025 16:37:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C29192B95
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 16:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192660; cv=none; b=hWc6Os9mIB6UU7OVv05ixW8cAp6jjvmNLTBUaKXPntB8vebpnXaoCcDex11441pPd17uT+tt/bIe2nz9VU6uVHvgEHUdXs6qJFhuQGa0Xj0WvT1qX4wLgZTRzDJka+QWsNumVgsVbhaX3zJN2MDkurKimgRkBljFFXrLnYOuNqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192660; c=relaxed/simple;
	bh=YkE+0U2JcrpqZO6460yxUHlPEay+7lKUekwAdK4i7vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2p6eEPZVUe7qaxk5WLb7FvarYaFo7S4FYeotcZRgFfRHg0Rq3OBexzQa+yJIoe64UYVrrDR0KzCoK86W6s5UJcSujw15QhNz4gRd6JkhBBBZt2HwUrhVeGOMoo2qIJTlgvuglFCN12zzsHi/Eb1CHMtjBCvvRkAdWzXtPCvz5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22359001f1aso162220545ad.3
        for <netdev@vger.kernel.org>; Wed, 05 Mar 2025 08:37:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741192658; x=1741797458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsxlOw++Acc0ZDDaf/V2vCWxwTYzJ4tVtyOcn0dOtjI=;
        b=BjzuQ5BF8zhyjpVHO6dlh+Dlq7vOt1LI+nwrQxPyXiHKRmUInHWKfb9l0bj3FkG03P
         ApCyvZnUTYPceZqsUB3rDkgbinJfn4czf+Fq6R7yPUhJxlqS9PlDEAaD7p5FEsRpV0uA
         rpYZCMyAU8LawG91sTS7kdjnjWaMYZ+uaahMsVqEaUY0hPfPeGG1Qrfdh/M++eP4+Zg3
         KBqV9Y3LAR5r8+EBAl3fJY97GFoKt6AFUridNTP/pJ+zdoujlW/1vq+oDmGIPIWGr289
         AxciV5P4i/EMWdtx8fHP//IEBND6jZQ4iRU37xYTzswhVL9YTQt/ABhGAowK/GivK9v2
         2AUg==
X-Gm-Message-State: AOJu0YzCToH3Cs41JyCJYWNjw2ry8kjYZAz+6WqY3qzZrvFenoRJ+4vO
	aqun2aFVmcQZsmDW0oDJZGMzVwO3lSib9E7EkNgJZNv/PsLtbREZGcsw
X-Gm-Gg: ASbGncvispcOH/D1DZdKxTcUWVMcuL7K0EPyLKnC5GcFICQJxqa/HbOgg5b4KezBzRX
	UzTAtmE6gaicuFbW8pRB3LarRoZ5Tcr4PRYDo3rniHL/qoMvdOBy507jOhhBbMRAu3gn/gAl23m
	tMufI+5AyE0AMtgzHq5D1P8t5Jt2RHlH0Ib0QD1o1pvGrUhhPGT/n7TsDLKphD73rvsGrpr8ERv
	TbGyNj7rV6bCc/OE2fbQgpUDcFbbehm4acC/HqdVv+QjdOlvsrQStqE1nzFcLJZTKwID6V8jnmW
	i75Ni3CHaMv5jfjgueCT93C1eQLoQ/PQMeqIXbgJxE5t
X-Google-Smtp-Source: AGHT+IGhKPI1Vrznx4fqp+PwDNUGUhhJqqmGWM4wWLms7kxyBjWvnBWbQ3T0vfDNxN2/puFY7QQ0qQ==
X-Received: by 2002:a17:902:e881:b0:223:6744:bfb9 with SMTP id d9443c01a7336-223f1d20e54mr64104905ad.41.1741192657658;
        Wed, 05 Mar 2025 08:37:37 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-736549ffd2dsm6324215b3a.87.2025.03.05.08.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 08:37:37 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v10 03/14] net: sched: wrap doit/dumpit methods
Date: Wed,  5 Mar 2025 08:37:21 -0800
Message-ID: <20250305163732.2766420-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305163732.2766420-1-sdf@fomichev.me>
References: <20250305163732.2766420-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for grabbing netdev instance lock around qdisc
operations, introduce tc_xxx wrappers that lookup netdev
and call respective __tc_xxx helper to do the actual work.
No functional changes.

Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Saeed Mahameed <saeed@kernel.org>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/sched/sch_api.c | 191 ++++++++++++++++++++++++++++----------------
 1 file changed, 123 insertions(+), 68 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index e3e91cf867eb..21940f3ae66f 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1505,27 +1505,18 @@ const struct nla_policy rtm_tca_policy[TCA_MAX + 1] = {
  * Delete/get qdisc.
  */
 
-static int tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
-			struct netlink_ext_ack *extack)
+static int __tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
+			  struct netlink_ext_ack *extack,
+			  struct net_device *dev,
+			  struct nlattr *tca[TCA_MAX + 1],
+			  struct tcmsg *tcm)
 {
 	struct net *net = sock_net(skb->sk);
-	struct tcmsg *tcm = nlmsg_data(n);
-	struct nlattr *tca[TCA_MAX + 1];
-	struct net_device *dev;
-	u32 clid;
 	struct Qdisc *q = NULL;
 	struct Qdisc *p = NULL;
+	u32 clid;
 	int err;
 
-	err = nlmsg_parse_deprecated(n, sizeof(*tcm), tca, TCA_MAX,
-				     rtm_tca_policy, extack);
-	if (err < 0)
-		return err;
-
-	dev = __dev_get_by_index(net, tcm->tcm_ifindex);
-	if (!dev)
-		return -ENODEV;
-
 	clid = tcm->tcm_parent;
 	if (clid) {
 		if (clid != TC_H_ROOT) {
@@ -1582,6 +1573,27 @@ static int tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 	return 0;
 }
 
+static int tc_get_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
+			struct netlink_ext_ack *extack)
+{
+	struct net *net = sock_net(skb->sk);
+	struct tcmsg *tcm = nlmsg_data(n);
+	struct nlattr *tca[TCA_MAX + 1];
+	struct net_device *dev;
+	int err;
+
+	err = nlmsg_parse_deprecated(n, sizeof(*tcm), tca, TCA_MAX,
+				     rtm_tca_policy, extack);
+	if (err < 0)
+		return err;
+
+	dev = __dev_get_by_index(net, tcm->tcm_ifindex);
+	if (!dev)
+		return -ENODEV;
+
+	return __tc_get_qdisc(skb, n, extack, dev, tca, tcm);
+}
+
 static bool req_create_or_replace(struct nlmsghdr *n)
 {
 	return (n->nlmsg_flags & NLM_F_CREATE &&
@@ -1601,35 +1613,19 @@ static bool req_change(struct nlmsghdr *n)
 		!(n->nlmsg_flags & NLM_F_EXCL));
 }
 
-/*
- * Create/change qdisc.
- */
-static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
-			   struct netlink_ext_ack *extack)
+static int __tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
+			     struct netlink_ext_ack *extack,
+			     struct net_device *dev,
+			     struct nlattr *tca[TCA_MAX + 1],
+			     struct tcmsg *tcm,
+			     bool *replay)
 {
-	struct net *net = sock_net(skb->sk);
-	struct tcmsg *tcm;
-	struct nlattr *tca[TCA_MAX + 1];
-	struct net_device *dev;
+	struct Qdisc *q = NULL;
+	struct Qdisc *p = NULL;
 	u32 clid;
-	struct Qdisc *q, *p;
 	int err;
 
-replay:
-	/* Reinit, just in case something touches this. */
-	err = nlmsg_parse_deprecated(n, sizeof(*tcm), tca, TCA_MAX,
-				     rtm_tca_policy, extack);
-	if (err < 0)
-		return err;
-
-	tcm = nlmsg_data(n);
 	clid = tcm->tcm_parent;
-	q = p = NULL;
-
-	dev = __dev_get_by_index(net, tcm->tcm_ifindex);
-	if (!dev)
-		return -ENODEV;
-
 
 	if (clid) {
 		if (clid != TC_H_ROOT) {
@@ -1755,7 +1751,7 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 	}
 	err = qdisc_change(q, tca, extack);
 	if (err == 0)
-		qdisc_notify(net, skb, n, clid, NULL, q, extack);
+		qdisc_notify(sock_net(skb->sk), skb, n, clid, NULL, q, extack);
 	return err;
 
 create_n_graft:
@@ -1788,8 +1784,10 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 				 tca, &err, extack);
 	}
 	if (q == NULL) {
-		if (err == -EAGAIN)
-			goto replay;
+		if (err == -EAGAIN) {
+			*replay = true;
+			return 0;
+		}
 		return err;
 	}
 
@@ -1804,6 +1802,39 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 	return 0;
 }
 
+/*
+ * Create/change qdisc.
+ */
+static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
+			   struct netlink_ext_ack *extack)
+{
+	struct net *net = sock_net(skb->sk);
+	struct nlattr *tca[TCA_MAX + 1];
+	struct net_device *dev;
+	struct tcmsg *tcm;
+	bool replay;
+	int err;
+
+replay:
+	/* Reinit, just in case something touches this. */
+	err = nlmsg_parse_deprecated(n, sizeof(*tcm), tca, TCA_MAX,
+				     rtm_tca_policy, extack);
+	if (err < 0)
+		return err;
+
+	tcm = nlmsg_data(n);
+	dev = __dev_get_by_index(net, tcm->tcm_ifindex);
+	if (!dev)
+		return -ENODEV;
+
+	replay = false;
+	err = __tc_modify_qdisc(skb, n, extack, dev, tca, tcm, &replay);
+	if (replay)
+		goto replay;
+
+	return err;
+}
+
 static int tc_dump_qdisc_root(struct Qdisc *root, struct sk_buff *skb,
 			      struct netlink_callback *cb,
 			      int *q_idx_p, int s_q_idx, bool recur,
@@ -2135,15 +2166,15 @@ static void tc_bind_tclass(struct Qdisc *q, u32 portid, u32 clid,
 
 #endif
 
-static int tc_ctl_tclass(struct sk_buff *skb, struct nlmsghdr *n,
-			 struct netlink_ext_ack *extack)
+static int __tc_ctl_tclass(struct sk_buff *skb, struct nlmsghdr *n,
+			   struct netlink_ext_ack *extack,
+			   struct net_device *dev,
+			   struct nlattr *tca[TCA_MAX + 1],
+			   struct tcmsg *tcm)
 {
 	struct net *net = sock_net(skb->sk);
-	struct tcmsg *tcm = nlmsg_data(n);
-	struct nlattr *tca[TCA_MAX + 1];
-	struct net_device *dev;
-	struct Qdisc *q = NULL;
 	const struct Qdisc_class_ops *cops;
+	struct Qdisc *q = NULL;
 	unsigned long cl = 0;
 	unsigned long new_cl;
 	u32 portid;
@@ -2151,15 +2182,6 @@ static int tc_ctl_tclass(struct sk_buff *skb, struct nlmsghdr *n,
 	u32 qid;
 	int err;
 
-	err = nlmsg_parse_deprecated(n, sizeof(*tcm), tca, TCA_MAX,
-				     rtm_tca_policy, extack);
-	if (err < 0)
-		return err;
-
-	dev = __dev_get_by_index(net, tcm->tcm_ifindex);
-	if (!dev)
-		return -ENODEV;
-
 	/*
 	   parent == TC_H_UNSPEC - unspecified parent.
 	   parent == TC_H_ROOT   - class is root, which has no parent.
@@ -2268,6 +2290,27 @@ static int tc_ctl_tclass(struct sk_buff *skb, struct nlmsghdr *n,
 	return err;
 }
 
+static int tc_ctl_tclass(struct sk_buff *skb, struct nlmsghdr *n,
+			 struct netlink_ext_ack *extack)
+{
+	struct net *net = sock_net(skb->sk);
+	struct tcmsg *tcm = nlmsg_data(n);
+	struct nlattr *tca[TCA_MAX + 1];
+	struct net_device *dev;
+	int err;
+
+	err = nlmsg_parse_deprecated(n, sizeof(*tcm), tca, TCA_MAX,
+				     rtm_tca_policy, extack);
+	if (err < 0)
+		return err;
+
+	dev = __dev_get_by_index(net, tcm->tcm_ifindex);
+	if (!dev)
+		return -ENODEV;
+
+	return __tc_ctl_tclass(skb, n, extack, dev, tca, tcm);
+}
+
 struct qdisc_dump_args {
 	struct qdisc_walker	w;
 	struct sk_buff		*skb;
@@ -2344,20 +2387,12 @@ static int tc_dump_tclass_root(struct Qdisc *root, struct sk_buff *skb,
 	return 0;
 }
 
-static int tc_dump_tclass(struct sk_buff *skb, struct netlink_callback *cb)
+static int __tc_dump_tclass(struct sk_buff *skb, struct netlink_callback *cb,
+			    struct tcmsg *tcm, struct net_device *dev)
 {
-	struct tcmsg *tcm = nlmsg_data(cb->nlh);
-	struct net *net = sock_net(skb->sk);
 	struct netdev_queue *dev_queue;
-	struct net_device *dev;
 	int t, s_t;
 
-	if (nlmsg_len(cb->nlh) < sizeof(*tcm))
-		return 0;
-	dev = dev_get_by_index(net, tcm->tcm_ifindex);
-	if (!dev)
-		return 0;
-
 	s_t = cb->args[0];
 	t = 0;
 
@@ -2374,10 +2409,30 @@ static int tc_dump_tclass(struct sk_buff *skb, struct netlink_callback *cb)
 done:
 	cb->args[0] = t;
 
-	dev_put(dev);
 	return skb->len;
 }
 
+static int tc_dump_tclass(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	struct tcmsg *tcm = nlmsg_data(cb->nlh);
+	struct net *net = sock_net(skb->sk);
+	struct net_device *dev;
+	int err;
+
+	if (nlmsg_len(cb->nlh) < sizeof(*tcm))
+		return 0;
+
+	dev = dev_get_by_index(net, tcm->tcm_ifindex);
+	if (!dev)
+		return 0;
+
+	err = __tc_dump_tclass(skb, cb, tcm, dev);
+
+	dev_put(dev);
+
+	return err;
+}
+
 #ifdef CONFIG_PROC_FS
 static int psched_show(struct seq_file *seq, void *v)
 {
-- 
2.48.1


