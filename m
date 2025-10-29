Return-Path: <netdev+bounces-234107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E59C1C777
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 51B1734BD53
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24A3354AFE;
	Wed, 29 Oct 2025 17:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HNJAf33S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A64F351FB5
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759248; cv=none; b=OB2N8Y7icmGHleAa+yTFFDDEOS580lo1SDqaf4+6zvSjWuWWjW7eDJXIizIL9g7EPg0poHzJe+H8oiNHg6b0hCKYYNYKbEilc/eDAYe8RMONbudoqUyFhYx1JfNRvZjBet/8IvvlSldVsqDSjJlUVUGnbSX9jfSU/9MUYxjPV0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759248; c=relaxed/simple;
	bh=Pj3uGAp45ciqpF5S9vcQEJmqRP+M/A3XS73mJssYN7g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bGdxBZSLsz+9OGjmBFtB3rvPH9VVlSAFuDFnOoaujsR9SPLVz6ZBVd2vxrPrwokN2SEYPk+MnoB8znjXlj5QJKX3IHWRzD3xH6vNeBVORPPk6ljJCPOARgZ8ECPeLIjSDDR8LppPxbaAcvW78Ovj4C1e12mt53vBMrF0vfN1XQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HNJAf33S; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7a27ab05999so114246b3a.3
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 10:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761759245; x=1762364045; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hsLnXTykfewkOfQsezsJvx1PLutX8KyisRMcMpy94Zc=;
        b=HNJAf33SH62/Jw8kkXniwMa3wz+9VpyDvG5JLlvADC8qSf3dKY8+H0e42AlWEWgmKo
         qe9r/Vs1trwof0edn7Q3jXUs4lY9/Wd1hor9mClpu+vwpYQhYMNEWat7YqKI3ZtoDwiB
         iVR8C0NNvEZoWiQ7wG07gEJHLldkVSq0qKkqh2h3s5eAKQdKTnNQ9Rgua0TO94V4unTr
         oNlFZ+Jcr8BcrhM4nfSQ11greRazhYy3kYGqRtKd/+FFnOHBBm78H2DJ70TLPn3O0CK+
         geQQcNJNXKJaac3xA2jv3/82i4Psd9Rfab0hig4anBZcjGIOyGW0AdBKbo0qyYSGFKEK
         c6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759245; x=1762364045;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hsLnXTykfewkOfQsezsJvx1PLutX8KyisRMcMpy94Zc=;
        b=BgHzY6gA83hI/7k1AenmwLWGWMtOANhNyjiToG5ZgcpRbaArqM/J8viY+ABoKtj1l0
         RSyPXiA3IbIVX8pfPoKq/VVETqowJ5Yy4LNL2pi/NLeYqHA3dzShkCI5tiLhWwDioNif
         6Om8EW8kRuTj8anvjweullRzC4lukoOr2v/Pbtk0G2tUkQbfUhFgLnU/m14UZ+U5XtXc
         P2Kg+34R6V009V+GSzjGX/UHovb4Y5tGF5F3qDsTB5ZVvih+KNRrBLfgI7Rux8D+LFDm
         Fv/uQoN8QMwAijOE1582LEG70A3GEsll8/AY5WggEQ+VvYNdGF0H16EXSVbidQalepZR
         XEcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtgb68lmJUm7uW4JACz3jYBI4DXvMuWBYq9YFuKnrfn2i54cHhVRTWLYutOiqwuC13ngnbU8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZOtJqbksjJVMu2xzFMfN+knwAFfSRdgOrqW1Pr2gML6iQciCn
	qCTQWD860lFymQWI0dztNGFvYkdVM9hmDlIM69qqt7fSD61BjoocnrSghLDlEThPljecqA4FWJN
	r03kmsw==
X-Google-Smtp-Source: AGHT+IHXUMnXH/8tg7itxj8FiklUNmbzrhNkDjsVmzBVmh55Ibl2Lq0dJh6gCZHGdBQe7r8NF07Jxxi01WM=
X-Received: from pfvx27.prod.google.com ([2002:a05:6a00:271b:b0:7a4:3936:b0dc])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3947:b0:33e:6d4b:609a
 with SMTP id adf61e73a8af0-34784e3d276mr296797637.6.1761759245124; Wed, 29
 Oct 2025 10:34:05 -0700 (PDT)
Date: Wed, 29 Oct 2025 17:33:04 +0000
In-Reply-To: <20251029173344.2934622-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029173344.2934622-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029173344.2934622-13-kuniyu@google.com>
Subject: [PATCH v2 net-next 12/13] mpls: Protect net->mpls.platform_label with
 a per-netns mutex.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

MPLS (re)uses RTNL to protect net->mpls.platform_label,
but the lock does not need to be RTNL at all.

Let's protect net->mpls.platform_label with a dedicated
per-netns mutex.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/netns/mpls.h |  1 +
 net/mpls/af_mpls.c       | 55 ++++++++++++++++++++++++++--------------
 net/mpls/internal.h      |  7 ++++-
 3 files changed, 43 insertions(+), 20 deletions(-)

diff --git a/include/net/netns/mpls.h b/include/net/netns/mpls.h
index 19ad2574b267..6682e51513ef 100644
--- a/include/net/netns/mpls.h
+++ b/include/net/netns/mpls.h
@@ -16,6 +16,7 @@ struct netns_mpls {
 	int default_ttl;
 	size_t platform_labels;
 	struct mpls_route __rcu * __rcu *platform_label;
+	struct mutex platform_mutex;
 
 	struct ctl_table_header *ctl;
 };
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 49fd15232dbe..d0d047dd2245 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -79,8 +79,8 @@ static struct mpls_route *mpls_route_input(struct net *net, unsigned int index)
 {
 	struct mpls_route __rcu **platform_label;
 
-	platform_label = rtnl_dereference(net->mpls.platform_label);
-	return rtnl_dereference(platform_label[index]);
+	platform_label = mpls_dereference(net, net->mpls.platform_label);
+	return mpls_dereference(net, platform_label[index]);
 }
 
 static struct mpls_route *mpls_route_input_rcu(struct net *net, unsigned int index)
@@ -578,10 +578,8 @@ static void mpls_route_update(struct net *net, unsigned index,
 	struct mpls_route __rcu **platform_label;
 	struct mpls_route *rt;
 
-	ASSERT_RTNL();
-
-	platform_label = rtnl_dereference(net->mpls.platform_label);
-	rt = rtnl_dereference(platform_label[index]);
+	platform_label = mpls_dereference(net, net->mpls.platform_label);
+	rt = mpls_dereference(net, platform_label[index]);
 	rcu_assign_pointer(platform_label[index], new);
 
 	mpls_notify_route(net, index, rt, new, info);
@@ -1472,8 +1470,6 @@ static struct mpls_dev *mpls_add_dev(struct net_device *dev)
 	int err = -ENOMEM;
 	int i;
 
-	ASSERT_RTNL();
-
 	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
 	if (!mdev)
 		return ERR_PTR(err);
@@ -1633,6 +1629,8 @@ static int mpls_dev_notify(struct notifier_block *this, unsigned long event,
 	unsigned int flags;
 	int err;
 
+	mutex_lock(&net->mpls.platform_mutex);
+
 	if (event == NETDEV_REGISTER) {
 		mdev = mpls_add_dev(dev);
 		if (IS_ERR(mdev)) {
@@ -1695,9 +1693,11 @@ static int mpls_dev_notify(struct notifier_block *this, unsigned long event,
 	}
 
 out:
+	mutex_unlock(&net->mpls.platform_mutex);
 	return NOTIFY_OK;
 
 err:
+	mutex_unlock(&net->mpls.platform_mutex);
 	return notifier_from_errno(err);
 }
 
@@ -1973,6 +1973,7 @@ static int rtm_to_route_config(struct sk_buff *skb,
 static int mpls_rtm_delroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 			     struct netlink_ext_ack *extack)
 {
+	struct net *net = sock_net(skb->sk);
 	struct mpls_route_config *cfg;
 	int err;
 
@@ -1984,7 +1985,9 @@ static int mpls_rtm_delroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto out;
 
+	mutex_lock(&net->mpls.platform_mutex);
 	err = mpls_route_del(cfg, extack);
+	mutex_unlock(&net->mpls.platform_mutex);
 out:
 	kfree(cfg);
 
@@ -1995,6 +1998,7 @@ static int mpls_rtm_delroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 static int mpls_rtm_newroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 			     struct netlink_ext_ack *extack)
 {
+	struct net *net = sock_net(skb->sk);
 	struct mpls_route_config *cfg;
 	int err;
 
@@ -2006,7 +2010,9 @@ static int mpls_rtm_newroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto out;
 
+	mutex_lock(&net->mpls.platform_mutex);
 	err = mpls_route_add(cfg, extack);
+	mutex_unlock(&net->mpls.platform_mutex);
 out:
 	kfree(cfg);
 
@@ -2407,6 +2413,8 @@ static int mpls_getroute(struct sk_buff *in_skb, struct nlmsghdr *in_nlh,
 	u8 n_labels;
 	int err;
 
+	mutex_lock(&net->mpls.platform_mutex);
+
 	err = mpls_valid_getroute_req(in_skb, in_nlh, tb, extack);
 	if (err < 0)
 		goto errout;
@@ -2450,7 +2458,8 @@ static int mpls_getroute(struct sk_buff *in_skb, struct nlmsghdr *in_nlh,
 			goto errout_free;
 		}
 
-		return rtnl_unicast(skb, net, portid);
+		err = rtnl_unicast(skb, net, portid);
+		goto errout;
 	}
 
 	if (tb[RTA_NEWDST]) {
@@ -2542,12 +2551,14 @@ static int mpls_getroute(struct sk_buff *in_skb, struct nlmsghdr *in_nlh,
 
 	err = rtnl_unicast(skb, net, portid);
 errout:
+	mutex_unlock(&net->mpls.platform_mutex);
 	return err;
 
 nla_put_failure:
 	nlmsg_cancel(skb, nlh);
 	err = -EMSGSIZE;
 errout_free:
+	mutex_unlock(&net->mpls.platform_mutex);
 	kfree_skb(skb);
 	return err;
 }
@@ -2603,9 +2614,10 @@ static int resize_platform_label_table(struct net *net, size_t limit)
 		       lo->addr_len);
 	}
 
-	rtnl_lock();
+	mutex_lock(&net->mpls.platform_mutex);
+
 	/* Remember the original table */
-	old = rtnl_dereference(net->mpls.platform_label);
+	old = mpls_dereference(net, net->mpls.platform_label);
 	old_limit = net->mpls.platform_labels;
 
 	/* Free any labels beyond the new table */
@@ -2636,7 +2648,7 @@ static int resize_platform_label_table(struct net *net, size_t limit)
 	net->mpls.platform_labels = limit;
 	rcu_assign_pointer(net->mpls.platform_label, labels);
 
-	rtnl_unlock();
+	mutex_unlock(&net->mpls.platform_mutex);
 
 	mpls_rt_free(rt2);
 	mpls_rt_free(rt0);
@@ -2709,12 +2721,13 @@ static const struct ctl_table mpls_table[] = {
 	},
 };
 
-static int mpls_net_init(struct net *net)
+static __net_init int mpls_net_init(struct net *net)
 {
 	size_t table_size = ARRAY_SIZE(mpls_table);
 	struct ctl_table *table;
 	int i;
 
+	mutex_init(&net->mpls.platform_mutex);
 	net->mpls.platform_labels = 0;
 	net->mpls.platform_label = NULL;
 	net->mpls.ip_ttl_propagate = 1;
@@ -2740,7 +2753,7 @@ static int mpls_net_init(struct net *net)
 	return 0;
 }
 
-static void mpls_net_exit(struct net *net)
+static __net_exit void mpls_net_exit(struct net *net)
 {
 	struct mpls_route __rcu **platform_label;
 	size_t platform_labels;
@@ -2760,16 +2773,20 @@ static void mpls_net_exit(struct net *net)
 	 * As such no additional rcu synchronization is necessary when
 	 * freeing the platform_label table.
 	 */
-	rtnl_lock();
-	platform_label = rtnl_dereference(net->mpls.platform_label);
+	mutex_lock(&net->mpls.platform_mutex);
+
+	platform_label = mpls_dereference(net, net->mpls.platform_label);
 	platform_labels = net->mpls.platform_labels;
+
 	for (index = 0; index < platform_labels; index++) {
-		struct mpls_route *rt = rtnl_dereference(platform_label[index]);
-		RCU_INIT_POINTER(platform_label[index], NULL);
+		struct mpls_route *rt;
+
+		rt = mpls_dereference(net, platform_label[index]);
 		mpls_notify_route(net, index, rt, NULL, NULL);
 		mpls_rt_free(rt);
 	}
-	rtnl_unlock();
+
+	mutex_unlock(&net->mpls.platform_mutex);
 
 	kvfree(platform_label);
 }
diff --git a/net/mpls/internal.h b/net/mpls/internal.h
index 0df01a5395ee..80cb5bbcd946 100644
--- a/net/mpls/internal.h
+++ b/net/mpls/internal.h
@@ -185,6 +185,11 @@ static inline struct mpls_entry_decoded mpls_entry_decode(struct mpls_shim_hdr *
 	return result;
 }
 
+#define mpls_dereference(net, p)					\
+	rcu_dereference_protected(					\
+		(p),							\
+		lockdep_is_held(&(net)->mpls.platform_mutex))
+
 static inline struct mpls_dev *mpls_dev_rcu(const struct net_device *dev)
 {
 	return rcu_dereference(dev->mpls_ptr);
@@ -193,7 +198,7 @@ static inline struct mpls_dev *mpls_dev_rcu(const struct net_device *dev)
 static inline struct mpls_dev *mpls_dev_get(const struct net *net,
 					    const struct net_device *dev)
 {
-	return rcu_dereference_rtnl(dev->mpls_ptr);
+	return mpls_dereference(net, dev->mpls_ptr);
 }
 
 int nla_put_labels(struct sk_buff *skb, int attrtype,  u8 labels,
-- 
2.51.1.851.g4ebd6896fd-goog


