Return-Path: <netdev+bounces-133957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AF5997904
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 01:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99D621C226BE
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A70E1E3766;
	Wed,  9 Oct 2024 23:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VqBkGOXk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB4B1E32B1
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 23:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728515969; cv=none; b=f8oZWEHVcutfbK/3igWkO32JU4TgUjtzZRXe9vKtsK5OZzmp6VImEN7alqjOsTvsYtQ4PAC0v2os6PPTQIWhYUSbN5EIROGxxMoRqLiIChtF/Ey9Z+2adD3MQChok6flV/cijpk8TRk3HqQKdk4GXydcJykUj4DD6TcM+fboZGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728515969; c=relaxed/simple;
	bh=DmssqnzLSWgHXl5fGQHRiiZlvtKeUh0c4ysEx2JHs3c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ACkDcBTos09w/tw3OKrqzgyTmHHtDtFLJCQ6WGr5OqFFf2vMPxJeed1ltMaFrGQFP0zcpnm7z/hQR8CTJT17ujEcLjNvpYalgnV3FixswnKPxT20d7Ad5v/CJ11GfE4Fgg7J2WlvV7bDMWLE99TjUpe8c7gC3yyfGcD/DEWz65k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=VqBkGOXk; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728515968; x=1760051968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9XVLtH6//mXwRZXWOXV+fELbjGJ2W4Uwd5tTWtVl/IA=;
  b=VqBkGOXkELvkCc3NccMbG3Y1AdV05PqxPJ4bQ35F31CY974G0FuD1PPb
   z8kTaTgzkLbOJPR3vmYRZsG5pQjRS4R1kv+HPC1rbAtHqaqKECjLGc9Lg
   VdQ6AY5wD0EuBG3LbGlvILgCT4Rud+t56q+Tf4Skip8yc6VPMLmvD5rfX
   k=;
X-IronPort-AV: E=Sophos;i="6.11,191,1725321600"; 
   d="scan'208";a="32023344"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 23:19:25 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:26451]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.108:2525] with esmtp (Farcaster)
 id e072043d-f855-4e03-b0a5-1e105ffde6b0; Wed, 9 Oct 2024 23:19:24 +0000 (UTC)
X-Farcaster-Flow-ID: e072043d-f855-4e03-b0a5-1e105ffde6b0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 9 Oct 2024 23:19:24 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 9 Oct 2024 23:19:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 07/13] rtnetlink: Protect struct rtnl_link_ops with SRCU.
Date: Wed, 9 Oct 2024 16:16:50 -0700
Message-ID: <20241009231656.57830-8-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241009231656.57830-1-kuniyu@amazon.com>
References: <20241009231656.57830-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Once RTNL is replaced with rtnl_net_lock(), we need a mechanism to
guarantee that rtnl_link_ops is alive during inflight RTM_NEWLINK
even when its module is being unloaded.

Let's use SRCU to protect rtnl_link_ops.

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
 include/net/rtnetlink.h |  5 ++-
 net/core/rtnetlink.c    | 78 +++++++++++++++++++++++++++++------------
 2 files changed, 60 insertions(+), 23 deletions(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index b45d57b5968a..c873fd6193ed 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -3,6 +3,7 @@
 #define __NET_RTNETLINK_H
 
 #include <linux/rtnetlink.h>
+#include <linux/srcu.h>
 #include <net/netlink.h>
 
 typedef int (*rtnl_doit_func)(struct sk_buff *, struct nlmsghdr *,
@@ -47,7 +48,8 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
 /**
  *	struct rtnl_link_ops - rtnetlink link operations
  *
- *	@list: Used internally
+ *	@list: Used internally, protected by RTNL and SRCU
+ *	@srcu: Used internally
  *	@kind: Identifier
  *	@netns_refund: Physical device, move to init_net on netns exit
  *	@maxtype: Highest device specific netlink attribute number
@@ -78,6 +80,7 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
  */
 struct rtnl_link_ops {
 	struct list_head	list;
+	struct srcu_struct	srcu;
 
 	const char		*kind;
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 24545c5b7e48..7f464554d881 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -456,15 +456,29 @@ EXPORT_SYMBOL_GPL(rtnl_unregister_all);
 
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
@@ -479,8 +493,15 @@ static const struct rtnl_link_ops *rtnl_link_ops_get(const char *kind)
  */
 int __rtnl_link_register(struct rtnl_link_ops *ops)
 {
-	if (rtnl_link_ops_get(ops->kind))
-		return -EEXIST;
+	struct rtnl_link_ops *tmp;
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
@@ -490,7 +511,9 @@ int __rtnl_link_register(struct rtnl_link_ops *ops)
 	if ((ops->alloc || ops->setup) && !ops->dellink)
 		ops->dellink = unregister_netdevice_queue;
 
-	list_add_tail(&ops->list, &link_ops);
+	init_srcu_struct(&ops->srcu);
+	list_add_tail_rcu(&ops->list, &link_ops);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__rtnl_link_register);
@@ -541,10 +564,11 @@ void __rtnl_link_unregister(struct rtnl_link_ops *ops)
 {
 	struct net *net;
 
-	for_each_net(net) {
+	list_del_rcu(&ops->list);
+	synchronize_srcu(&ops->srcu);
+
+	for_each_net(net)
 		__rtnl_kill_links(net, ops);
-	}
-	list_del(&ops->list);
 }
 EXPORT_SYMBOL_GPL(__rtnl_link_unregister);
 
@@ -2157,10 +2181,11 @@ static const struct nla_policy ifla_xdp_policy[IFLA_XDP_MAX + 1] = {
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
@@ -2169,7 +2194,7 @@ static const struct rtnl_link_ops *linkinfo_to_kind_ops(const struct nlattr *nla
 		char kind[MODULE_NAME_LEN];
 
 		nla_strscpy(kind, linfo[IFLA_INFO_KIND], sizeof(kind));
-		ops = rtnl_link_ops_get(kind);
+		ops = rtnl_link_ops_get(kind, ops_srcu_index);
 	}
 
 	return ops;
@@ -2289,8 +2314,8 @@ static int rtnl_valid_dump_ifinfo_req(const struct nlmsghdr *nlh,
 
 static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 {
-	const struct rtnl_link_ops *kind_ops = NULL;
 	struct netlink_ext_ack *extack = cb->extack;
+	struct rtnl_link_ops *kind_ops = NULL;
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct net *net = sock_net(skb->sk);
 	unsigned int flags = NLM_F_MULTI;
@@ -2301,6 +2326,7 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 	struct net *tgt_net = net;
 	u32 ext_filter_mask = 0;
 	struct net_device *dev;
+	int ops_srcu_index;
 	int master_idx = 0;
 	int netnsid = -1;
 	int err, i;
@@ -2334,7 +2360,7 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
 			master_idx = nla_get_u32(tb[i]);
 			break;
 		case IFLA_LINKINFO:
-			kind_ops = linkinfo_to_kind_ops(tb[i]);
+			kind_ops = linkinfo_to_kind_ops(tb[i], &ops_srcu_index);
 			break;
 		default:
 			if (cb->strict_check) {
@@ -2360,6 +2386,10 @@ static int rtnl_dump_ifinfo(struct sk_buff *skb, struct netlink_callback *cb)
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
@@ -3746,8 +3776,9 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			struct netlink_ext_ack *extack)
 {
 	struct nlattr **tb, **linkinfo, **data = NULL;
-	const struct rtnl_link_ops *ops = NULL;
+	struct rtnl_link_ops *ops = NULL;
 	struct rtnl_newlink_tbs *tbs;
+	int ops_srcu_index;
 	int ret;
 
 	tbs = kmalloc(sizeof(*tbs), GFP_KERNEL);
@@ -3779,13 +3810,13 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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
@@ -3799,7 +3830,7 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 							  linkinfo[IFLA_INFO_DATA],
 							  ops->policy, extack);
 			if (ret < 0)
-				goto free;
+				goto put_ops;
 
 			data = tbs->attr;
 		}
@@ -3807,12 +3838,15 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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


