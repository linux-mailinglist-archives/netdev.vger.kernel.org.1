Return-Path: <netdev+bounces-147079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DD99D756F
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 16:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0ACA285DD4
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 15:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCE32500C7;
	Sun, 24 Nov 2024 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtvHZoJU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF022500C1
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732462882; cv=none; b=seAw8qaHhWHF56/aoPH70x07jdnmqDP7uF9RwwARrO9bVh73wsjHMweZGAxupICeFN7aOcRKHsG2lFy67lQdnJDEOW0IgkmRC7hG4jD+ctydhOv4+9NU+2NW6ltVyIn38pvEBwGm5NTSXVq1a4eMjc13CDNOaeWUdA4Lawi5GxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732462882; c=relaxed/simple;
	bh=EkMcyg62yhQl5MZ2gYa4HCwLzqoNntgE4+dVBT+ZtiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5pkamwKMzLH5BlIuUNFY5Dfg796V7LUDa6IBnXd1RkUiJW8nGv8q8EBclas/9oS4uCKHBjigyIgfGjNmBdV9dUJKiojNDmmTkVnt1yxlcrr9ScVr9denqnFBWRrqL4dMime7FIoRRUxdpha9r13mnsXbHYaXDdE/uIXVIYJmf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OtvHZoJU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732462879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lkq6MMKBa3zNmJ5dD7xQGHTGWqMV4KQJ8Ft8c5Wmucw=;
	b=OtvHZoJUtNFf+A57DpR4OBvFRbhwxym2FzSvMdVdc4M4/77HGtPOs/7gW451MBhuQnpNwb
	qPgJ3tw7L9WMTsk6oPZnwDR2/WXO3/bN7zGUY5wi4i+eW8McKXdOXYejX2HdLzKnyEI4Mx
	WwwpB9GOZq9X0TIGN7PgYZqGtHlBBKk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-6MqzUNu-MAOdCJU_LsnX5g-1; Sun,
 24 Nov 2024 10:41:15 -0500
X-MC-Unique: 6MqzUNu-MAOdCJU_LsnX5g-1
X-Mimecast-MFC-AGG-ID: 6MqzUNu-MAOdCJU_LsnX5g
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BBAAF19560AE;
	Sun, 24 Nov 2024 15:41:13 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.28])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6B3711955F43;
	Sun, 24 Nov 2024 15:41:11 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	stefan.wiehler@nokia.com,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH v2 net 2/3] ip6mr: fix tables suspicious RCU usage
Date: Sun, 24 Nov 2024 16:40:57 +0100
Message-ID: <3a8b03f560f0b4b447a227950e6e5283231d138b.1732289799.git.pabeni@redhat.com>
In-Reply-To: <cover.1732289799.git.pabeni@redhat.com>
References: <cover.1732289799.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Several places call ip6mr_get_table() with no RCU nor RTNL lock.
Add RCU protection inside such helper and provide a lockless variant
for the few callers that already acquired the relevant lock.

Note that some users additionally reference the table outside the RCU
lock. That is actually safe as the table deletion can happen only
after all table accesses are completed.

Fixes: e2d57766e674 ("net: Provide compat support for SIOCGETMIFCNT_IN6 and SIOCGETSGCNT_IN6.")
Fixes: d7c31cbde4bc ("net: ip6mr: add RTM_GETROUTE netlink op")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv6/ip6mr.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index b80fca894916..4147890fe98f 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -130,7 +130,7 @@ static struct mr_table *ip6mr_mr_table_iter(struct net *net,
 	return ret;
 }
 
-static struct mr_table *ip6mr_get_table(struct net *net, u32 id)
+static struct mr_table *__ip6mr_get_table(struct net *net, u32 id)
 {
 	struct mr_table *mrt;
 
@@ -141,6 +141,16 @@ static struct mr_table *ip6mr_get_table(struct net *net, u32 id)
 	return NULL;
 }
 
+static struct mr_table *ip6mr_get_table(struct net *net, u32 id)
+{
+	struct mr_table *mrt;
+
+	rcu_read_lock();
+	mrt = __ip6mr_get_table(net, id);
+	rcu_read_unlock();
+	return mrt;
+}
+
 static int ip6mr_fib_lookup(struct net *net, struct flowi6 *flp6,
 			    struct mr_table **mrt)
 {
@@ -182,7 +192,7 @@ static int ip6mr_rule_action(struct fib_rule *rule, struct flowi *flp,
 
 	arg->table = fib_rule_get_table(rule, arg);
 
-	mrt = ip6mr_get_table(rule->fr_net, arg->table);
+	mrt = __ip6mr_get_table(rule->fr_net, arg->table);
 	if (!mrt)
 		return -EAGAIN;
 	res->mrt = mrt;
@@ -314,6 +324,8 @@ static struct mr_table *ip6mr_get_table(struct net *net, u32 id)
 	return net->ipv6.mrt6;
 }
 
+#define __ip6mr_get_table ip6mr_get_table
+
 static int ip6mr_fib_lookup(struct net *net, struct flowi6 *flp6,
 			    struct mr_table **mrt)
 {
@@ -392,7 +404,7 @@ static struct mr_table *ip6mr_new_table(struct net *net, u32 id)
 {
 	struct mr_table *mrt;
 
-	mrt = ip6mr_get_table(net, id);
+	mrt = __ip6mr_get_table(net, id);
 	if (mrt)
 		return mrt;
 
@@ -425,13 +437,15 @@ static void *ip6mr_vif_seq_start(struct seq_file *seq, loff_t *pos)
 	struct net *net = seq_file_net(seq);
 	struct mr_table *mrt;
 
-	mrt = ip6mr_get_table(net, RT6_TABLE_DFLT);
-	if (!mrt)
+	rcu_read_lock();
+	mrt = __ip6mr_get_table(net, RT6_TABLE_DFLT);
+	if (!mrt) {
+		rcu_read_unlock();
 		return ERR_PTR(-ENOENT);
+	}
 
 	iter->mrt = mrt;
 
-	rcu_read_lock();
 	return mr_vif_seq_start(seq, pos);
 }
 
@@ -2292,11 +2306,13 @@ int ip6mr_get_route(struct net *net, struct sk_buff *skb, struct rtmsg *rtm,
 	struct mfc6_cache *cache;
 	struct rt6_info *rt = dst_rt6_info(skb_dst(skb));
 
-	mrt = ip6mr_get_table(net, RT6_TABLE_DFLT);
-	if (!mrt)
+	rcu_read_lock();
+	mrt = __ip6mr_get_table(net, RT6_TABLE_DFLT);
+	if (!mrt) {
+		rcu_read_unlock();
 		return -ENOENT;
+	}
 
-	rcu_read_lock();
 	cache = ip6mr_cache_find(mrt, &rt->rt6i_src.addr, &rt->rt6i_dst.addr);
 	if (!cache && skb->dev) {
 		int vif = ip6mr_find_vif(mrt, skb->dev);
@@ -2576,7 +2592,7 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		grp = nla_get_in6_addr(tb[RTA_DST]);
 	tableid = nla_get_u32_default(tb[RTA_TABLE], 0);
 
-	mrt = ip6mr_get_table(net, tableid ?: RT_TABLE_DEFAULT);
+	mrt = __ip6mr_get_table(net, tableid ?: RT_TABLE_DEFAULT);
 	if (!mrt) {
 		NL_SET_ERR_MSG_MOD(extack, "MR table does not exist");
 		return -ENOENT;
@@ -2623,7 +2639,7 @@ static int ip6mr_rtm_dumproute(struct sk_buff *skb, struct netlink_callback *cb)
 	if (filter.table_id) {
 		struct mr_table *mrt;
 
-		mrt = ip6mr_get_table(sock_net(skb->sk), filter.table_id);
+		mrt = __ip6mr_get_table(sock_net(skb->sk), filter.table_id);
 		if (!mrt) {
 			if (rtnl_msg_family(cb->nlh) != RTNL_FAMILY_IP6MR)
 				return skb->len;
-- 
2.45.2


