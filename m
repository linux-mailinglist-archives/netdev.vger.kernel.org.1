Return-Path: <netdev+bounces-136262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ECA9A1216
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28F7028230B
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 18:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4340218DF97;
	Wed, 16 Oct 2024 18:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rVl9/2cS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C93318CC11
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729104990; cv=none; b=qGGXtBMSpfDbxSYXoZT9jGOhYBj7VShGJqHTvHz3r8F6HdCGEYng0zvjNvQes9mlieYhjQcUOfKyiq/hhJTMaovrDkE3nKLbI9XbvOEwwm/8vDpTdmL/RmFk/V+ys2zDW1C7bswe4Q9DKvBN3ErnZ3wnPTevQ4547MyTNBIXdpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729104990; c=relaxed/simple;
	bh=m+/rcZra6sVM2RNtvOLwgvTVIqtd/FcirXrgh5UrdPo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OGzCv8OA5WOypF4dAF653yJSB/K8cgnHPrADh8Bz1PQ3znVJQJdY5/dlAxl3TpEKpV5S8B7LNAw8aHZ/HRdykACuTxlzPR4U7JjBA09Qct6UsErNQHGRf24hyATq3tLd3crHQ2KlyMj5IHbLQlymnrqVWwmLTYV1rh0o7tZsLlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rVl9/2cS; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729104988; x=1760640988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+N79Wetn83v0FzNnfqq9f3gtH/vDKzTExyRZfzPEgpc=;
  b=rVl9/2cSzPTZlFzQ+I/RbhdKJ/xuaNzyPdRG/malaVgUuXkkPGKkO7Lb
   N4ky51Z/QikRUyVOlAXg9cXNO+EcSZp0S3Gvsaw4TfYHnQalFgx+XDToB
   QCZq+6QEi7fF967ho2GG/Gq3Vi2cQFbW25U2v185yaKNVfSQ19ojlqba7
   A=;
X-IronPort-AV: E=Sophos;i="6.11,208,1725321600"; 
   d="scan'208";a="432023148"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 18:56:25 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:4841]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.142:2525] with esmtp (Farcaster)
 id f25a28b9-5c25-442c-8182-a0862992dc06; Wed, 16 Oct 2024 18:56:24 +0000 (UTC)
X-Farcaster-Flow-ID: f25a28b9-5c25-442c-8182-a0862992dc06
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 16 Oct 2024 18:56:23 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 16 Oct 2024 18:56:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 07/14] rtnetlink: Protect struct rtnl_link_ops with SRCU.
Date: Wed, 16 Oct 2024 11:53:50 -0700
Message-ID: <20241016185357.83849-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241016185357.83849-1-kuniyu@amazon.com>
References: <20241016185357.83849-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Once RTNL is replaced with rtnl_net_lock(), we need a mechanism to
guarantee that rtnl_link_ops is alive during inflight RTM_NEWLINK
even when its module is being unloaded.

Let's use SRCU to protect ops.

rtnl_link_ops_get() now iterates link_ops under RCU and returns
SRCU-protected ops pointer.  The caller must call rtnl_link_ops_put()
to release the pointer after the use.

Also, __rtnl_link_unregister() unlinks the ops first and calls
synchronize_srcu() to wait for inflight RTM_NEWLINK requests to
complete.

Note that link_ops needs to be protected by its dedicated lock
when RTNL is removed.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v2:
  * Handle error of init_srcu_struct().
  * Call cleanup_srcu_struct() after synchronize_srcu().
---
 include/net/rtnetlink.h |  5 ++-
 net/core/rtnetlink.c    | 83 ++++++++++++++++++++++++++++++-----------
 2 files changed, 65 insertions(+), 23 deletions(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index bb49c5708ce7..1a6aa5ca74f3 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -3,6 +3,7 @@
 #define __NET_RTNETLINK_H
 
 #include <linux/rtnetlink.h>
+#include <linux/srcu.h>
 #include <net/netlink.h>
 
 typedef int (*rtnl_doit_func)(struct sk_buff *, struct nlmsghdr *,
@@ -69,7 +70,8 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
 /**
  *	struct rtnl_link_ops - rtnetlink link operations
  *
- *	@list: Used internally
+ *	@list: Used internally, protected by RTNL and SRCU
+ *	@srcu: Used internally
  *	@kind: Identifier
  *	@netns_refund: Physical device, move to init_net on netns exit
  *	@maxtype: Highest device specific netlink attribute number
@@ -100,6 +102,7 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
  */
 struct rtnl_link_ops {
 	struct list_head	list;
+	struct srcu_struct	srcu;
 
 	const char		*kind;
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 9c9290a6c271..31b105b3a834 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -457,15 +457,29 @@ EXPORT_SYMBOL_GPL(__rtnl_unregister_many);
 
 static LIST_HEAD(link_ops);
 
-static const struct rtnl_link_ops *rtnl_link_ops_get(const char *kind)
+static struct rtnl_link_ops *rtnl_link_ops_get(const char *kind, int *srcu_index)
 {
-	const struct rtnl_link_ops *ops;
+	struct rtnl_link_ops *ops;
 
-	list_for_each_entry(ops, &link_ops, list) {
-		if (!strcmp(ops->kind, kind))
-			return ops;
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(ops, &link_ops, list) {
+		if (!strcmp(ops->kind, kind)) {
+			*srcu_index = srcu_read_lock(&ops->srcu);
+			goto unlock;
+		}
 	}
-	return NULL;
+
+	ops = NULL;
+unlock:
+	rcu_read_unlock();
+
+	return ops;
+}
+
+static void rtnl_link_ops_put(struct rtnl_link_ops *ops, int srcu_index)
+{
+	srcu_read_unlock(&ops->srcu, srcu_index);
 }
 
 /**
@@ -480,8 +494,16 @@ static const struct rtnl_link_ops *rtnl_link_ops_get(const char *kind)
  */
 int __rtnl_link_register(struct rtnl_link_ops *ops)
 {
-	if (rtnl_link_ops_get(ops->kind))
-		return -EEXIST;
+	struct rtnl_link_ops *tmp;
+	int err;
+
+	/* When RTNL is removed, add lock for link_ops. */
+	ASSERT_RTNL();
+
+	list_for_each_entry(tmp, &link_ops, list) {
+		if (!strcmp(ops->kind, tmp->kind))
+			return -EEXIST;
+	}
 
 	/* The check for alloc/setup is here because if ops
 	 * does not have that filled up, it is not possible
@@ -491,7 +513,12 @@ int __rtnl_link_register(struct rtnl_link_ops *ops)
 	if ((ops->alloc || ops->setup) && !ops->dellink)
 		ops->dellink = unregister_netdevice_queue;
 
-	list_add_tail(&ops->list, &link_ops);
+	err = init_srcu_struct(&ops->srcu);
+	if (err)
+		return err;
+
+	list_add_tail_rcu(&ops->list, &link_ops);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__rtnl_link_register);
@@ -542,10 +569,12 @@ void __rtnl_link_unregister(struct rtnl_link_ops *ops)
 {
 	struct net *net;
 
-	for_each_net(net) {
+	list_del_rcu(&ops->list);
+	synchronize_srcu(&ops->srcu);
+	cleanup_srcu_struct(&ops->srcu);
+
+	for_each_net(net)
 		__rtnl_kill_links(net, ops);
-	}
-	list_del(&ops->list);
 }
 EXPORT_SYMBOL_GPL(__rtnl_link_unregister);
 
@@ -2158,10 +2187,11 @@ static const struct nla_policy ifla_xdp_policy[IFLA_XDP_MAX + 1] = {
 	[IFLA_XDP_PROG_ID]	= { .type = NLA_U32 },
 };
 
-static const struct rtnl_link_ops *linkinfo_to_kind_ops(const struct nlattr *nla)
+static struct rtnl_link_ops *linkinfo_to_kind_ops(const struct nlattr *nla,
+						  int *ops_srcu_index)
 {
-	const struct rtnl_link_ops *ops = NULL;
 	struct nlattr *linfo[IFLA_INFO_MAX + 1];
+	struct rtnl_link_ops *ops = NULL;
 
 	if (nla_parse_nested_deprecated(linfo, IFLA_INFO_MAX, nla, ifla_info_policy, NULL) < 0)
 		return NULL;
@@ -2170,7 +2200,7 @@ static const struct rtnl_link_ops *linkinfo_to_kind_ops(const struct nlattr *nla
 		char kind[MODULE_NAME_LEN];
 
 		nla_strscpy(kind, linfo[IFLA_INFO_KIND], sizeof(kind));
-		ops = rtnl_link_ops_get(kind);
+		ops = rtnl_link_ops_get(kind, ops_srcu_index);
 	}
 
 	return ops;
@@ -2290,8 +2320,8 @@ static int rtnl_valid_dump_ifinfo_req(const struct nlmsghdr *nlh,
 
 static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	const struct rtnl_link_ops *kind_ops = NULL;
 	struct netlink_ext_ack *extack = cb->extack;
+	struct rtnl_link_ops *kind_ops = NULL;
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct net *net = sock_net(skb->sk);
 	unsigned int flags = NLM_F_MULTI;
@@ -2302,6 +2332,7 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 	struct net *tgt_net = net;
 	u32 ext_filter_mask = 0;
 	struct net_device *dev;
+	int ops_srcu_index;
 	int master_idx = 0;
 	int netnsid = -1;
 	int err, i;
@@ -2335,7 +2366,7 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 			master_idx = nla_get_u32(tb[i]);
 			break;
 		case IFLA_LINKINFO:
-			kind_ops = linkinfo_to_kind_ops(tb[i]);
+			kind_ops = linkinfo_to_kind_ops(tb[i], &ops_srcu_index);
 			break;
 		default:
 			if (cb->strict_check) {
@@ -2361,6 +2392,10 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 		if (err < 0)
 			break;
 	}
+
+	if (kind_ops)
+		rtnl_link_ops_put(kind_ops, ops_srcu_index);
+
 	cb->seq = tgt_net->dev_base_seq;
 	nl_dump_check_consistent(cb, nlmsg_hdr(skb));
 	if (netnsid >= 0)
@@ -3747,8 +3782,9 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			struct netlink_ext_ack *extack)
 {
 	struct nlattr **tb, **linkinfo, **data = NULL;
-	const struct rtnl_link_ops *ops = NULL;
+	struct rtnl_link_ops *ops = NULL;
 	struct rtnl_newlink_tbs *tbs;
+	int ops_srcu_index;
 	int ret;
 
 	tbs = kmalloc(sizeof(*tbs), GFP_KERNEL);
@@ -3780,13 +3816,13 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		char kind[MODULE_NAME_LEN];
 
 		nla_strscpy(kind, linkinfo[IFLA_INFO_KIND], sizeof(kind));
-		ops = rtnl_link_ops_get(kind);
+		ops = rtnl_link_ops_get(kind, &ops_srcu_index);
 #ifdef CONFIG_MODULES
 		if (!ops) {
 			__rtnl_unlock();
 			request_module("rtnl-link-%s", kind);
 			rtnl_lock();
-			ops = rtnl_link_ops_get(kind);
+			ops = rtnl_link_ops_get(kind, &ops_srcu_index);
 		}
 #endif
 	}
@@ -3800,7 +3836,7 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 							  linkinfo[IFLA_INFO_DATA],
 							  ops->policy, extack);
 			if (ret < 0)
-				goto free;
+				goto put_ops;
 
 			data = tbs->attr;
 		}
@@ -3808,12 +3844,15 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		if (ops->validate) {
 			ret = ops->validate(tb, data, extack);
 			if (ret < 0)
-				goto free;
+				goto put_ops;
 		}
 	}
 
 	ret = __rtnl_newlink(skb, nlh, ops, tbs, data, extack);
 
+put_ops:
+	if (ops)
+		rtnl_link_ops_put(ops, ops_srcu_index);
 free:
 	kfree(tbs);
 	return ret;
-- 
2.39.5 (Apple Git-154)


