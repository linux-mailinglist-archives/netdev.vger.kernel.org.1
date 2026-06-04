Return-Path: <netdev+bounces-295459-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RgSrK1oBImr+RQEAu9opvQ
	(envelope-from <netdev+bounces-295459-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:51:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 072EA643DE3
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 00:51:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=tGbEBQ0k;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295459-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295459-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B19D33061E8B
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 22:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B48B33C53D;
	Thu,  4 Jun 2026 22:47:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28DE30594F
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 22:47:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780613250; cv=none; b=MrKEJ6GNixQkUpj4h8nkzS6dgmSur6UzLYA6IlBjLRXKkFIGeBvgCdOy/wFtsRFHqVR6pf/ZNbJAQ3DI64J3devwCDsZgJMkCYw39SLAbuiezxF95KY0pY69Diq9+LK3kBr0o8+5gv/K5hqvjupt7gFFXq81LGDsndXRWPQJ8JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780613250; c=relaxed/simple;
	bh=4tOP5Xbaiyw3chab8ooB4r/AHChl49yMklWTyoU5GKI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PdNL4PrxPokPlrtUFQS0rAXaTaFxNstJ0FcITYZgsxDR+6TXuVo9s5Mc/xVtECGRFvMDTCyGLYObL/8hb993wq//9Qvy3cfooP8CU+mBoW3etlTvgT0nM1ifCj35WTTcEsnkLKpkM4WRk21nHA0MjtwDBdbgkCI2+a28mj/bGXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tGbEBQ0k; arc=none smtp.client-ip=209.85.216.73
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36bb6c41341so1448061a91.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 15:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780613247; x=1781218047; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XCVcy7HuGc8hs/BVluuXbjsahhIghgrCReA3zwv70RE=;
        b=tGbEBQ0kK2YZOX3eSHi3DVNVtvsGRq26w1KlHGQdJrOeBXAPZpQp2c/P/HwM5b/gw8
         TfekAVBHlVFenxpHlB4RAXgdRPTy3xex1bUlIWd5ZaL6z3Fno7Q/EpScQMnYMO+hq/V0
         ic5W3d33hg0/bKX5bLP4j3i1/o4rTQmfFd+EPlxXvv1pGZI4QlklDRHob5MeCXxZkADi
         l1EFfVN1YzH6TXsuN13e8CG3llYoqDEyF6/VBYZ/1r9GOeCOGSE8tEV4u8/JU84WlEjs
         N9hfsiRCVNj97ihunCO6qIvWuKBNRLC2dA/z1+yWrVIV+eFiwnmqWMw6D8YJwmNINyyD
         zfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780613247; x=1781218047;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XCVcy7HuGc8hs/BVluuXbjsahhIghgrCReA3zwv70RE=;
        b=gR//XpcC2dklOKi6QE0aAe4qLQN/WWZPRMXArk8IJ24Q768VU6q76EebJBAwwuuXGc
         k5h6grdLbQxHMywkoeQPAl9KkC7j7ZU9fg9b3QYL3wBqjLgTDMY5mIPb8TeJF7R6JnFz
         JT0+mt/slHIUW0UtT3ytW929yUvw2qbfMn6YeSyPOUiBRuKhvifPjh0IqqAG8HM5fNRm
         nYwT8LPj0azED/gduPLYxB4ouPeBqc2E8d7Wtd70+mCxF46WRshR7lfziInMjvT5ST9w
         MI7RneIQJqRWWpB8vplMy4WirGyXGVFvyFbm7cLqBwYUj5E+1IhfsCJmU/cbcZUSkD5T
         dJEQ==
X-Forwarded-Encrypted: i=1; AFNElJ8bvz5ZRf3fCtQd9zvlcryfMENir4uJsezroyt0mCGl+sTTJNPdERZx2XmDJrfPixS5UlJ6oCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6JKnhIuKgB6Mg8zEaIQURG6HwtHPM8eXueQx5u74CaBY9Kira
	uJS35GWBOrOgz7UdvogL+2UT2Q+97RC2X0FggTZwl+3w/czYLi/ezjYFqPfUvqKP2k+1LBJv+gT
	BAKqLQw==
X-Received: from pjyl21.prod.google.com ([2002:a17:90a:ec15:b0:36b:a0ab:bf1f])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3512:b0:36d:b424:4f17
 with SMTP id 98e67ed59e1d1-370ee82fa3cmr798100a91.1.1780613246516; Thu, 04
 Jun 2026 15:47:26 -0700 (PDT)
Date: Thu,  4 Jun 2026 22:46:26 +0000
In-Reply-To: <20260604224712.3209821-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260604224712.3209821-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260604224712.3209821-9-kuniyu@google.com>
Subject: [PATCH v3 net-next 08/15] ip6mr: Free mr_table after RCU grace period.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295459-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 072EA643DE3

Since default_device_exit_batch() is called after ->exit_rtnl(),
idev->mc_ifc_work could finally call mroute6_is_socket() under RCU
while ->exit_rtnl() is running. [0]

With CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=n, ip6mr_fib_lookup() does
not check if net->ipv6.mrt6 is NULL.  If ip6mr_net_exit_batch()
set net->ipv6.mrt6 to NULL and freed it, the mrt->mroute_sk access
could result in null-ptr-deref or use-after-free.

Let's prepare for that situation by applying RCU rule to ip6mr
table similarly.

!check_net(net) is added in ip6mr_cache_unresolved() and
mroute_clean_tables() to synchronise the two by mfc_unres_lock
so that ip6mr_cache_unresolved() will not queue skb after
mroute_clean_tables() purged &mrt->mfc_unres_queue.

rcu_read_lock() in reg_vif_xmit() is moved up to cover
ip6mr_fib_lookup() as with ipmr.

Link: https://lore.kernel.org/netdev/20260407184202.34cfe2d6@kernel.org/ #[0]
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6mr.c | 121 +++++++++++++++++++++++++++--------------------
 1 file changed, 69 insertions(+), 52 deletions(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 8c8ad1753c75..ddbe06397d9c 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -136,16 +136,6 @@ static struct mr_table *__ip6mr_get_table(struct net *net, u32 id)
 	return NULL;
 }
 
-static struct mr_table *ip6mr_get_table(struct net *net, u32 id)
-{
-	struct mr_table *mrt;
-
-	rcu_read_lock();
-	mrt = __ip6mr_get_table(net, id);
-	rcu_read_unlock();
-	return mrt;
-}
-
 static int ip6mr_fib_lookup(struct net *net, struct flowi6 *flp6,
 			    struct mr_table **mrt)
 {
@@ -274,7 +264,7 @@ static void __net_exit ip6mr_rules_exit(struct net *net)
 
 	ASSERT_RTNL();
 	list_for_each_entry_safe(mrt, next, &net->ipv6.mr6_tables, list) {
-		list_del(&mrt->list);
+		list_del_rcu(&mrt->list);
 		ip6mr_free_table(mrt);
 	}
 	fib_rules_unregister(net->ipv6.mr6_rules_ops);
@@ -298,28 +288,30 @@ bool ip6mr_rule_default(const struct fib_rule *rule)
 }
 EXPORT_SYMBOL(ip6mr_rule_default);
 #else
-#define ip6mr_for_each_table(mrt, net) \
-	for (mrt = net->ipv6.mrt6; mrt; mrt = NULL)
-
 static struct mr_table *ip6mr_mr_table_iter(struct net *net,
 					    struct mr_table *mrt)
 {
 	if (!mrt)
-		return net->ipv6.mrt6;
+		return rcu_dereference(net->ipv6.mrt6);
 	return NULL;
 }
 
-static struct mr_table *ip6mr_get_table(struct net *net, u32 id)
+static struct mr_table *__ip6mr_get_table(struct net *net, u32 id)
 {
-	return net->ipv6.mrt6;
+	return rcu_dereference_check(net->ipv6.mrt6,
+				     lockdep_rtnl_is_held() ||
+				     !rcu_access_pointer(net->ipv6.mrt6));
 }
 
-#define __ip6mr_get_table ip6mr_get_table
+#define ip6mr_for_each_table(mrt, net)				\
+	for (mrt = __ip6mr_get_table(net, 0); mrt; mrt = NULL)
 
 static int ip6mr_fib_lookup(struct net *net, struct flowi6 *flp6,
 			    struct mr_table **mrt)
 {
-	*mrt = net->ipv6.mrt6;
+	*mrt = rcu_dereference(net->ipv6.mrt6);
+	if (!*mrt)
+		return -EAGAIN;
 	return 0;
 }
 
@@ -330,15 +322,19 @@ static int __net_init ip6mr_rules_init(struct net *net)
 	mrt = ip6mr_new_table(net, RT6_TABLE_DFLT);
 	if (IS_ERR(mrt))
 		return PTR_ERR(mrt);
-	net->ipv6.mrt6 = mrt;
+
+	rcu_assign_pointer(net->ipv6.mrt6, mrt);
 	return 0;
 }
 
 static void __net_exit ip6mr_rules_exit(struct net *net)
 {
+	struct mr_table *mrt = rcu_dereference_protected(net->ipv6.mrt6, 1);
+
 	ASSERT_RTNL();
-	ip6mr_free_table(net->ipv6.mrt6);
-	net->ipv6.mrt6 = NULL;
+
+	RCU_INIT_POINTER(net->ipv6.mrt6, NULL);
+	ip6mr_free_table(mrt);
 }
 
 static int ip6mr_rules_dump(struct net *net, struct notifier_block *nb,
@@ -353,6 +349,17 @@ static unsigned int ip6mr_rules_seq_read(const struct net *net)
 }
 #endif
 
+static struct mr_table *ip6mr_get_table(struct net *net, u32 id)
+{
+	struct mr_table *mrt;
+
+	rcu_read_lock();
+	mrt = __ip6mr_get_table(net, id);
+	rcu_read_unlock();
+
+	return mrt;
+}
+
 static int ip6mr_hash_cmp(struct rhashtable_compare_arg *arg,
 			  const void *ptr)
 {
@@ -411,8 +418,8 @@ static void ip6mr_free_table(struct mr_table *mrt)
 	timer_shutdown_sync(&mrt->ipmr_expire_timer);
 	mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MIFS_STATIC |
 				 MRT6_FLUSH_MFC | MRT6_FLUSH_MFC_STATIC);
-	rhltable_destroy(&mrt->mfc_hash);
-	kfree(mrt);
+
+	mr_table_free(mrt);
 }
 
 #ifdef CONFIG_PROC_FS
@@ -623,18 +630,22 @@ static netdev_tx_t reg_vif_xmit(struct sk_buff *skb,
 	if (!pskb_inet_may_pull(skb))
 		goto tx_err;
 
+	rcu_read_lock();
+
 	if (ip6mr_fib_lookup(net, &fl6, &mrt) < 0)
-		goto tx_err;
+		goto tx_lookup_err;
 
 	DEV_STATS_ADD(dev, tx_bytes, skb->len);
 	DEV_STATS_INC(dev, tx_packets);
-	rcu_read_lock();
+
 	ip6mr_cache_report(mrt, skb, READ_ONCE(mrt->mroute_reg_vif_num),
 			   MRT6MSG_WHOLEPKT);
 	rcu_read_unlock();
 	kfree_skb(skb);
 	return NETDEV_TX_OK;
 
+tx_lookup_err:
+	rcu_read_unlock();
 tx_err:
 	DEV_STATS_INC(dev, tx_errors);
 	kfree_skb(skb);
@@ -1157,11 +1168,18 @@ static int ip6mr_cache_report(const struct mr_table *mrt, struct sk_buff *pkt,
 static int ip6mr_cache_unresolved(struct mr_table *mrt, mifi_t mifi,
 				  struct sk_buff *skb, struct net_device *dev)
 {
-	struct mfc6_cache *c;
+	struct net *net = read_pnet(&mrt->net);
+	struct mfc6_cache *c = NULL;
 	bool found = false;
 	int err;
 
 	spin_lock_bh(&mfc_unres_lock);
+
+	if (!check_net(net)) {
+		err = -EINVAL;
+		goto err;
+	}
+
 	list_for_each_entry(c, &mrt->mfc_unres_queue, _c.list) {
 		if (ipv6_addr_equal(&c->mf6c_mcastgrp, &ipv6_hdr(skb)->daddr) &&
 		    ipv6_addr_equal(&c->mf6c_origin, &ipv6_hdr(skb)->saddr)) {
@@ -1177,10 +1195,8 @@ static int ip6mr_cache_unresolved(struct mr_table *mrt, mifi_t mifi,
 
 		c = ip6mr_cache_alloc_unres();
 		if (!c) {
-			spin_unlock_bh(&mfc_unres_lock);
-
-			kfree_skb(skb);
-			return -ENOBUFS;
+			err = -ENOBUFS;
+			goto err;
 		}
 
 		/* Fill in the new cache entry */
@@ -1192,16 +1208,8 @@ static int ip6mr_cache_unresolved(struct mr_table *mrt, mifi_t mifi,
 		 *	Reflect first query at pim6sd
 		 */
 		err = ip6mr_cache_report(mrt, skb, mifi, MRT6MSG_NOCACHE);
-		if (err < 0) {
-			/* If the report failed throw the cache entry
-			   out - Brad Parker
-			 */
-			spin_unlock_bh(&mfc_unres_lock);
-
-			ip6mr_cache_free(c);
-			kfree_skb(skb);
-			return err;
-		}
+		if (err < 0)
+			goto err;
 
 		atomic_inc(&mrt->cache_resolve_queue_len);
 		list_add(&c->_c.list, &mrt->mfc_unres_queue);
@@ -1212,18 +1220,26 @@ static int ip6mr_cache_unresolved(struct mr_table *mrt, mifi_t mifi,
 
 	/* See if we can append the packet */
 	if (c->_c.mfc_un.unres.unresolved.qlen > 3) {
-		kfree_skb(skb);
+		c = NULL;
 		err = -ENOBUFS;
-	} else {
-		if (dev) {
-			skb->dev = dev;
-			skb->skb_iif = dev->ifindex;
-		}
-		skb_queue_tail(&c->_c.mfc_un.unres.unresolved, skb);
-		err = 0;
+		goto err;
+	}
+
+	if (dev) {
+		skb->dev = dev;
+		skb->skb_iif = dev->ifindex;
 	}
 
+	skb_queue_tail(&c->_c.mfc_un.unres.unresolved, skb);
+
+	spin_unlock_bh(&mfc_unres_lock);
+	return 0;
+
+err:
 	spin_unlock_bh(&mfc_unres_lock);
+	if (c)
+		ip6mr_cache_free(c);
+	kfree_skb(skb);
 	return err;
 }
 
@@ -1534,6 +1550,7 @@ static int ip6mr_mfc_add(struct net *net, struct mr_table *mrt,
 
 static void mroute_clean_tables(struct mr_table *mrt, int flags)
 {
+	struct net *net = read_pnet(&mrt->net);
 	struct mr_mfc *c, *tmp;
 	LIST_HEAD(list);
 	int i;
@@ -1558,8 +1575,7 @@ static void mroute_clean_tables(struct mr_table *mrt, int flags)
 				continue;
 			rhltable_remove(&mrt->mfc_hash, &c->mnode, ip6mr_rht_params);
 			list_del_rcu(&c->list);
-			call_ip6mr_mfc_entry_notifiers(read_pnet(&mrt->net),
-						       FIB_EVENT_ENTRY_DEL,
+			call_ip6mr_mfc_entry_notifiers(net, FIB_EVENT_ENTRY_DEL,
 						       (struct mfc6_cache *)c, mrt->id);
 			mr6_netlink_event(mrt, (struct mfc6_cache *)c, RTM_DELROUTE);
 			mr_cache_put(c);
@@ -1567,7 +1583,8 @@ static void mroute_clean_tables(struct mr_table *mrt, int flags)
 	}
 
 	if (flags & MRT6_FLUSH_MFC) {
-		if (atomic_read(&mrt->cache_resolve_queue_len) != 0) {
+		if (atomic_read(&mrt->cache_resolve_queue_len) != 0 ||
+		    !check_net(net)) {
 			spin_lock_bh(&mfc_unres_lock);
 			list_for_each_entry_safe(c, tmp, &mrt->mfc_unres_queue, list) {
 				list_del(&c->list);
-- 
2.54.0.1032.g2f8565e1d1-goog


