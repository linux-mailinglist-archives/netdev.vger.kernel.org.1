Return-Path: <netdev+bounces-146789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0669D5DB2
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 12:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 390CFB25083
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 11:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8D91DEFD9;
	Fri, 22 Nov 2024 11:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnJ3pZ2+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01A31A0BDC
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273373; cv=none; b=ALxt/g1qR7hDPChiLZwJ3D8bkLTeuzXX6Vxb5YbxQTnkksHykKx0rcvlfoen9eOcidBnYooOm1itAPyCZxThTM94VLHgqIwRgrFWbQ73DbJSFtLYHM6AKVjULcn7189eQh+6fdTGObQ+EH0X5pA3odHZbjaruHk895HuTBY8cOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273373; c=relaxed/simple;
	bh=r4AQyT9tfU7UPqvSwv8lR9f8z3ohbGL2eIzaroF1BKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGwJUkbgIFqoZB2uetYl/hQ6iMYO3k5s7l2lTiFtqBqLzMzOdeCpOpY9H2LrN4UBhGqP2geUG6bYptSFaBSjlYDobjP6AxikB0LSFzuI5CjV1mmn9FmWRyQ370A6OMsoxXDAq4B5i797qNqc+epkiNBCXbdNi7anntbF+zsMLf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gnJ3pZ2+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732273370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kx1r1eHBFcZinlJjp7CMDfbt/6PQm3ynAv6Uq537Uaw=;
	b=gnJ3pZ2+oW9E+QsogwJKwl9/fFCOyBlVcDu4ZCv6Iec55QbyrF6gk1gAms79C5dF0XKxxy
	lbUc0Q6zvvV7FAESUFjI4xTP7aNzKNcUyixcuPMU4UAFCsFhBl33YRS4tI2sVxHMfGQh6T
	GFmSl5mt6QDDjKO5WfTD5/yxFq87Wog=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-mjYiHrsmOaapGz2as_mNuA-1; Fri,
 22 Nov 2024 06:02:47 -0500
X-MC-Unique: mjYiHrsmOaapGz2as_mNuA-1
X-Mimecast-MFC-AGG-ID: mjYiHrsmOaapGz2as_mNuA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D9E81955F41;
	Fri, 22 Nov 2024 11:02:46 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.31])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2C9E719560A3;
	Fri, 22 Nov 2024 11:02:43 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	stefan.wiehler@nokia.com
Subject: [PATCH net 2/3] ip6mr: fix tables suspicious RCU usage
Date: Fri, 22 Nov 2024 12:02:15 +0100
Message-ID: <38d5e7abdc4946a7ab851e207fa1e14c505392d6.1732270911.git.pabeni@redhat.com>
In-Reply-To: <cover.1732270911.git.pabeni@redhat.com>
References: <cover.1732270911.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
index 275784a8f35b..c7eeb0694621 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -125,7 +125,7 @@ static struct mr_table *ip6mr_mr_table_iter(struct net *net,
 	return ret;
 }
 
-static struct mr_table *ip6mr_get_table(struct net *net, u32 id)
+static struct mr_table *__ip6mr_get_table(struct net *net, u32 id)
 {
 	struct mr_table *mrt;
 
@@ -136,6 +136,16 @@ static struct mr_table *ip6mr_get_table(struct net *net, u32 id)
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
@@ -177,7 +187,7 @@ static int ip6mr_rule_action(struct fib_rule *rule, struct flowi *flp,
 
 	arg->table = fib_rule_get_table(rule, arg);
 
-	mrt = ip6mr_get_table(rule->fr_net, arg->table);
+	mrt = __ip6mr_get_table(rule->fr_net, arg->table);
 	if (!mrt)
 		return -EAGAIN;
 	res->mrt = mrt;
@@ -304,6 +314,8 @@ static struct mr_table *ip6mr_get_table(struct net *net, u32 id)
 	return net->ipv6.mrt6;
 }
 
+#define __ip6mr_get_table ip6mr_get_table
+
 static int ip6mr_fib_lookup(struct net *net, struct flowi6 *flp6,
 			    struct mr_table **mrt)
 {
@@ -387,7 +399,7 @@ static struct mr_table *ip6mr_new_table(struct net *net, u32 id)
 {
 	struct mr_table *mrt;
 
-	mrt = ip6mr_get_table(net, id);
+	mrt = __ip6mr_get_table(net, id);
 	if (mrt)
 		return mrt;
 
@@ -420,13 +432,15 @@ static void *ip6mr_vif_seq_start(struct seq_file *seq, loff_t *pos)
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
 
@@ -2287,11 +2301,13 @@ int ip6mr_get_route(struct net *net, struct sk_buff *skb, struct rtmsg *rtm,
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
@@ -2571,7 +2587,7 @@ static int ip6mr_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 		grp = nla_get_in6_addr(tb[RTA_DST]);
 	tableid = nla_get_u32_default(tb[RTA_TABLE], 0);
 
-	mrt = ip6mr_get_table(net, tableid ?: RT_TABLE_DEFAULT);
+	mrt = __ip6mr_get_table(net, tableid ?: RT_TABLE_DEFAULT);
 	if (!mrt) {
 		NL_SET_ERR_MSG_MOD(extack, "MR table does not exist");
 		return -ENOENT;
@@ -2618,7 +2634,7 @@ static int ip6mr_rtm_dumproute(struct sk_buff *skb, struct netlink_callback *cb)
 	if (filter.table_id) {
 		struct mr_table *mrt;
 
-		mrt = ip6mr_get_table(sock_net(skb->sk), filter.table_id);
+		mrt = __ip6mr_get_table(sock_net(skb->sk), filter.table_id);
 		if (!mrt) {
 			if (rtnl_msg_family(cb->nlh) != RTNL_FAMILY_IP6MR)
 				return skb->len;
-- 
2.45.2


