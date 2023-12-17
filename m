Return-Path: <netdev+bounces-58381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3701B8161AD
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 19:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D471F2216E
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 18:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1518847F45;
	Sun, 17 Dec 2023 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1/1+M2k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF41B47F43
	for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 18:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18025C433C8;
	Sun, 17 Dec 2023 18:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702839318;
	bh=Xf9TrRHZCW7gXqW1r7Xh+RGmkht5vIhoDqajzSrj6Ek=;
	h=From:To:Cc:Subject:Date:From;
	b=d1/1+M2kcWOEPzF7LuZYTi2PXZzfonql7FBIYh9h8yz3JbeZOFLzaOiwx4L8phSvl
	 PorjPbOSGZGTkDOeHVuy2KpI+Egib4hJgy6zBp50+ceNsK/6SgeMdv/w4DT9/9uJxJ
	 UfYRyAVLBNahqXk8YeLFAdZpMivmtg0XJrpVJ5c6MOx7Tsg/e1usTJeFgWd5MAD/JM
	 sIbxRo+OyJU0niF6WLoibPehjCFfcSg/vIosAywwrHcpQJ0Qe9YD2CU0L8cHAl+rHZ
	 Ln9j8lixT/oZ6j+BFFLvKIOXcroshGlzkGIqVnGVbznG/vaHbu1iGTpl3wGhNItRoh
	 +jsRktZx22Iog==
From: David Ahern <dsahern@kernel.org>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	David Ahern <dsahern@kernel.org>,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH net] net/ipv6: Revert remove expired routes with a separated list of routes
Date: Sun, 17 Dec 2023 11:55:05 -0700
Message-Id: <20231217185505.22867-1-dsahern@kernel.org>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Revert the remainder of 5a08d0065a915 which added a warn on if a fib
entry is still on the gc_link list, and then revert  all of the commit
in the Fixes tag. The commit has some race conditions given how expires
is managed on a fib6_info in relation to timer start, adding the entry
to the gc list and setting the timer value leading to UAF. Revert
the commit and try again in a later release.

Fixes: 3dec89b14d37 ("net/ipv6: Remove expired routes with a separated list of routes")
Cc: Kui-Feng Lee <thinker.li@gmail.com>
Signed-off-by: David Ahern <dsahern@kernel.org>
---
 include/net/ip6_fib.h | 68 +++++++++----------------------------------
 net/ipv6/ip6_fib.c    | 55 ++++------------------------------
 net/ipv6/route.c      |  6 ++--
 3 files changed, 23 insertions(+), 106 deletions(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 95ed495c3a40..9ba6413fd2e3 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -179,9 +179,6 @@ struct fib6_info {
 
 	refcount_t			fib6_ref;
 	unsigned long			expires;
-
-	struct hlist_node		gc_link;
-
 	struct dst_metrics		*fib6_metrics;
 #define fib6_pmtu		fib6_metrics->metrics[RTAX_MTU-1]
 
@@ -250,6 +247,19 @@ static inline bool fib6_requires_src(const struct fib6_info *rt)
 	return rt->fib6_src.plen > 0;
 }
 
+static inline void fib6_clean_expires(struct fib6_info *f6i)
+{
+	f6i->fib6_flags &= ~RTF_EXPIRES;
+	f6i->expires = 0;
+}
+
+static inline void fib6_set_expires(struct fib6_info *f6i,
+				    unsigned long expires)
+{
+	f6i->expires = expires;
+	f6i->fib6_flags |= RTF_EXPIRES;
+}
+
 static inline bool fib6_check_expired(const struct fib6_info *f6i)
 {
 	if (f6i->fib6_flags & RTF_EXPIRES)
@@ -257,11 +267,6 @@ static inline bool fib6_check_expired(const struct fib6_info *f6i)
 	return false;
 }
 
-static inline bool fib6_has_expires(const struct fib6_info *f6i)
-{
-	return f6i->fib6_flags & RTF_EXPIRES;
-}
-
 /* Function to safely get fn->fn_sernum for passed in rt
  * and store result in passed in cookie.
  * Return true if we can get cookie safely
@@ -328,10 +333,8 @@ static inline bool fib6_info_hold_safe(struct fib6_info *f6i)
 
 static inline void fib6_info_release(struct fib6_info *f6i)
 {
-	if (f6i && refcount_dec_and_test(&f6i->fib6_ref)) {
-		DEBUG_NET_WARN_ON_ONCE(!hlist_unhashed(&f6i->gc_link));
+	if (f6i && refcount_dec_and_test(&f6i->fib6_ref))
 		call_rcu(&f6i->rcu, fib6_info_destroy_rcu);
-	}
 }
 
 enum fib6_walk_state {
@@ -385,7 +388,6 @@ struct fib6_table {
 	struct inet_peer_base	tb6_peers;
 	unsigned int		flags;
 	unsigned int		fib_seq;
-	struct hlist_head       tb6_gc_hlist;	/* GC candidates */
 #define RT6_TABLE_HAS_DFLT_ROUTER	BIT(0)
 };
 
@@ -502,48 +504,6 @@ void fib6_gc_cleanup(void);
 
 int fib6_init(void);
 
-/* fib6_info must be locked by the caller, and fib6_info->fib6_table can be
- * NULL.
- */
-static inline void fib6_set_expires_locked(struct fib6_info *f6i,
-					   unsigned long expires)
-{
-	struct fib6_table *tb6;
-
-	tb6 = f6i->fib6_table;
-	f6i->expires = expires;
-	if (tb6 && !fib6_has_expires(f6i))
-		hlist_add_head(&f6i->gc_link, &tb6->tb6_gc_hlist);
-	f6i->fib6_flags |= RTF_EXPIRES;
-}
-
-/* fib6_info must be locked by the caller, and fib6_info->fib6_table can be
- * NULL.  If fib6_table is NULL, the fib6_info will no be inserted into the
- * list of GC candidates until it is inserted into a table.
- */
-static inline void fib6_set_expires(struct fib6_info *f6i,
-				    unsigned long expires)
-{
-	spin_lock_bh(&f6i->fib6_table->tb6_lock);
-	fib6_set_expires_locked(f6i, expires);
-	spin_unlock_bh(&f6i->fib6_table->tb6_lock);
-}
-
-static inline void fib6_clean_expires_locked(struct fib6_info *f6i)
-{
-	if (fib6_has_expires(f6i))
-		hlist_del_init(&f6i->gc_link);
-	f6i->fib6_flags &= ~RTF_EXPIRES;
-	f6i->expires = 0;
-}
-
-static inline void fib6_clean_expires(struct fib6_info *f6i)
-{
-	spin_lock_bh(&f6i->fib6_table->tb6_lock);
-	fib6_clean_expires_locked(f6i);
-	spin_unlock_bh(&f6i->fib6_table->tb6_lock);
-}
-
 struct ipv6_route_iter {
 	struct seq_net_private p;
 	struct fib6_walker w;
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 7772f42ff2b9..4fc2cae0d116 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -160,8 +160,6 @@ struct fib6_info *fib6_info_alloc(gfp_t gfp_flags, bool with_fib6_nh)
 	INIT_LIST_HEAD(&f6i->fib6_siblings);
 	refcount_set(&f6i->fib6_ref, 1);
 
-	INIT_HLIST_NODE(&f6i->gc_link);
-
 	return f6i;
 }
 
@@ -248,7 +246,6 @@ static struct fib6_table *fib6_alloc_table(struct net *net, u32 id)
 				   net->ipv6.fib6_null_entry);
 		table->tb6_root.fn_flags = RTN_ROOT | RTN_TL_ROOT | RTN_RTINFO;
 		inet_peer_base_init(&table->tb6_peers);
-		INIT_HLIST_HEAD(&table->tb6_gc_hlist);
 	}
 
 	return table;
@@ -1060,8 +1057,6 @@ static void fib6_purge_rt(struct fib6_info *rt, struct fib6_node *fn,
 				    lockdep_is_held(&table->tb6_lock));
 		}
 	}
-
-	fib6_clean_expires_locked(rt);
 }
 
 /*
@@ -1123,10 +1118,9 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 				if (!(iter->fib6_flags & RTF_EXPIRES))
 					return -EEXIST;
 				if (!(rt->fib6_flags & RTF_EXPIRES))
-					fib6_clean_expires_locked(iter);
+					fib6_clean_expires(iter);
 				else
-					fib6_set_expires_locked(iter,
-								rt->expires);
+					fib6_set_expires(iter, rt->expires);
 
 				if (rt->fib6_pmtu)
 					fib6_metric_set(iter, RTAX_MTU,
@@ -1485,10 +1479,6 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
 		if (rt->nh)
 			list_add(&rt->nh_list, &rt->nh->f6i_list);
 		__fib6_update_sernum_upto_root(rt, fib6_new_sernum(info->nl_net));
-
-		if (fib6_has_expires(rt))
-			hlist_add_head(&rt->gc_link, &table->tb6_gc_hlist);
-
 		fib6_start_gc(info->nl_net, rt);
 	}
 
@@ -2291,8 +2281,9 @@ static void fib6_flush_trees(struct net *net)
  *	Garbage collection
  */
 
-static int fib6_age(struct fib6_info *rt, struct fib6_gc_args *gc_args)
+static int fib6_age(struct fib6_info *rt, void *arg)
 {
+	struct fib6_gc_args *gc_args = arg;
 	unsigned long now = jiffies;
 
 	/*
@@ -2300,7 +2291,7 @@ static int fib6_age(struct fib6_info *rt, struct fib6_gc_args *gc_args)
 	 *	Routes are expired even if they are in use.
 	 */
 
-	if (fib6_has_expires(rt) && rt->expires) {
+	if (rt->fib6_flags & RTF_EXPIRES && rt->expires) {
 		if (time_after(now, rt->expires)) {
 			RT6_TRACE("expiring %p\n", rt);
 			return -1;
@@ -2317,40 +2308,6 @@ static int fib6_age(struct fib6_info *rt, struct fib6_gc_args *gc_args)
 	return 0;
 }
 
-static void fib6_gc_table(struct net *net,
-			  struct fib6_table *tb6,
-			  struct fib6_gc_args *gc_args)
-{
-	struct fib6_info *rt;
-	struct hlist_node *n;
-	struct nl_info info = {
-		.nl_net = net,
-		.skip_notify = false,
-	};
-
-	hlist_for_each_entry_safe(rt, n, &tb6->tb6_gc_hlist, gc_link)
-		if (fib6_age(rt, gc_args) == -1)
-			fib6_del(rt, &info);
-}
-
-static void fib6_gc_all(struct net *net, struct fib6_gc_args *gc_args)
-{
-	struct fib6_table *table;
-	struct hlist_head *head;
-	unsigned int h;
-
-	rcu_read_lock();
-	for (h = 0; h < FIB6_TABLE_HASHSZ; h++) {
-		head = &net->ipv6.fib_table_hash[h];
-		hlist_for_each_entry_rcu(table, head, tb6_hlist) {
-			spin_lock_bh(&table->tb6_lock);
-			fib6_gc_table(net, table, gc_args);
-			spin_unlock_bh(&table->tb6_lock);
-		}
-	}
-	rcu_read_unlock();
-}
-
 void fib6_run_gc(unsigned long expires, struct net *net, bool force)
 {
 	struct fib6_gc_args gc_args;
@@ -2366,7 +2323,7 @@ void fib6_run_gc(unsigned long expires, struct net *net, bool force)
 			  net->ipv6.sysctl.ip6_rt_gc_interval;
 	gc_args.more = 0;
 
-	fib6_gc_all(net, &gc_args);
+	fib6_clean_all(net, fib6_age, &gc_args);
 	now = jiffies;
 	net->ipv6.ip6_rt_last_gc = now;
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index b132feae3393..ea1dec8448fc 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3763,10 +3763,10 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 		rt->dst_nocount = true;
 
 	if (cfg->fc_flags & RTF_EXPIRES)
-		fib6_set_expires_locked(rt, jiffies +
-					clock_t_to_jiffies(cfg->fc_expires));
+		fib6_set_expires(rt, jiffies +
+				clock_t_to_jiffies(cfg->fc_expires));
 	else
-		fib6_clean_expires_locked(rt);
+		fib6_clean_expires(rt);
 
 	if (cfg->fc_protocol == RTPROT_UNSPEC)
 		cfg->fc_protocol = RTPROT_BOOT;
-- 
2.34.1


