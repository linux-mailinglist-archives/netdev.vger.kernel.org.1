Return-Path: <netdev+bounces-70389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4392F84EB35
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 23:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215351C24338
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 22:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE104F8B3;
	Thu,  8 Feb 2024 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PawZXDQn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFE35024F
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430046; cv=none; b=ZGulHCNxqLRCxQmDavxD/AjKSjQNAm5iN6gsY8wMOqJ1+mOMC/1jyDYeVnCXbXNRHJYMljePJRPHAElzrxsQJKk6hqo3cTeuguZv3HZ1yZCeWkGBn9oYipvgqU2SFgtBGQZkaVdva6NDqEP4bYww3RDOPB8Hxh68zVVD0xw3ICo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430046; c=relaxed/simple;
	bh=/8RjjliBvKi/zKAnw8MUx75V9Iqx8lozrPN6JN3XUFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YiOSD+8TggVmcIT/2fD4CBMRVARPPM9c8nkOxu58Z3rKfPYVunqG6OOY3Lr6Gi7aDLj4wZHzBpR8Dut2O9DGflDzlX3EIOFaJSgBKhCilMvlVwG0y4YfVM9F1/CLa+P4E0zpkbqN9W9CCeHJL4mGhjgnV4juLjPtpLx0qoM63FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PawZXDQn; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-604ab54bb83so4243507b3.1
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 14:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707430043; x=1708034843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBLmUSswsfGUFbq02YaJy6+IZiP7sz7gw1Rb1UaLmZ8=;
        b=PawZXDQng2mRJNwiRm2RTriyZipo9n2HiOr+wUxkwb1GQ0h4JnM+K4Q8bL5RddsaQ4
         JlBklXV6BUS3dyJBynr5qjpQfxXJoO0Bm5ZVXRZ2Yjsp1VHdlGQLfNBQSY2lGGVWl6Fg
         bzmRyoGzlY9HRCqFyTzmvbUic6SGZhUtMnJftudWkUwDHbgqAJsqznjoLDgYSyPb/nqp
         DeX9eT9chBg8UX0xiwK8Qq/aV2V6fcOwuGop1FdF1cMh8ujf2tGRotMU8Jwn8gEjtwn8
         bHFqV5usF6BMU9pLSq9bcOUa1hfIMtk+WXWM9h4i2VLz+ln0W2efnA13q8J7nMqZziKS
         tAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707430043; x=1708034843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBLmUSswsfGUFbq02YaJy6+IZiP7sz7gw1Rb1UaLmZ8=;
        b=aN4y+WOHCqxjeP7MxM8YondRGETBo9lJpsD6Pyo0zZH/JsgqNdbKlBZTkYkIvLpz39
         yWd4N/rrZ6Jb/mStgGkcxE94IdNq1e1UVZ8XNd1u2nIeC1yjX8WtWr+Yy+HX/C+iPZjh
         aYbuiLYYlbSL/WgVHYT8dnhhB1u7kNgnKuQMUp+JDrvTjUOh9FVkRZv7thABSrtemyKL
         XGlzaQuanH8LXg2vpARovsLHt8QIaNB0ixdjcl1uG5xk0F2CgKxwT5kMV7lBUpZyFIyG
         t3sn7rl47ZhROqqbJ7i5Al2esFy45EyRsZnt7p4dFLnjY/nf5UkVUv//Ds0AmzJxPu9R
         rIZA==
X-Gm-Message-State: AOJu0Yy5sBIuXGV5NbP+sCfzmmaldINU2oreM0hgESrYYbU9PPXGMC1w
	N/tXnzIOJclBEjdwgCjqB+IW/W5GAbjs3C9LIxr1DTVbL7Epk5SQ36xMz5mPK88=
X-Google-Smtp-Source: AGHT+IGdaVou97BZzBMmw4YR2m31E5qGq8RKZefbnqpOJqRuToZ31IynHcY1mGyGeTR6pKeBs9TUvg==
X-Received: by 2002:a81:7bc6:0:b0:604:91b1:5401 with SMTP id w189-20020a817bc6000000b0060491b15401mr723557ywc.38.1707430042918;
        Thu, 08 Feb 2024 14:07:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXQo6JdtQMf+sHuk8AiI7B0i/YsRbLiJIxuXdVZQ5UgNaZewNfi/QuOOsLUvp4ZSO/v8TjtC1M02P14/nH09VAJmtnE8nGv8Rugf4FiB3ESV9JHQ11aXJKro7E6K+hjlsbBqPLksZdbGxaOaOttJXVoY3UBNR79nWWC9r4gtrNzGSQqbKQiDOKDPsVUvjEADqnNkTvzpx1H23hLKi44M09vxja1NUjlJsHPuloy/6nC4boOMaXz36SY3iLuf40kegvUmqmCLQCOfBtbB/rF8hTrw8faX0Oy9Se/bKzjGg/DIX6fwWhx7vx/du4ksPB1eMbgIBb8Uah0e8lRRRc+9YpoTTMOpE/7Mvg95A==
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1c58:82ab:ea0c:f407])
        by smtp.gmail.com with ESMTPSA id m128-20020a0de386000000b006049e3167fcsm61320ywe.99.2024.02.08.14.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 14:07:22 -0800 (PST)
From: thinker.li@gmail.com
To: netdev@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	liuhangbin@gmail.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH net-next v6 3/5] net/ipv6: Remove expired routes with a separated list of routes.
Date: Thu,  8 Feb 2024 14:06:51 -0800
Message-Id: <20240208220653.374773-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208220653.374773-1-thinker.li@gmail.com>
References: <20240208220653.374773-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

FIB6 GC walks trees of fib6_tables to remove expired routes. Walking a tree
can be expensive if the number of routes in a table is big, even if most of
them are permanent. Checking routes in a separated list of routes having
expiration will avoid this potential issue.

Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/net/ip6_fib.h | 46 ++++++++++++++++++++++++++++++++-
 net/ipv6/addrconf.c   | 41 ++++++++++++++++++++++++-----
 net/ipv6/ip6_fib.c    | 60 +++++++++++++++++++++++++++++++++++++++----
 net/ipv6/ndisc.c      | 10 +++++++-
 net/ipv6/route.c      | 13 ++++++++--
 5 files changed, 154 insertions(+), 16 deletions(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 360b12e61850..323c94f1845b 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -173,6 +173,9 @@ struct fib6_info {
 
 	refcount_t			fib6_ref;
 	unsigned long			expires;
+
+	struct hlist_node		gc_link;
+
 	struct dst_metrics		*fib6_metrics;
 #define fib6_pmtu		fib6_metrics->metrics[RTAX_MTU-1]
 
@@ -241,12 +244,18 @@ static inline bool fib6_requires_src(const struct fib6_info *rt)
 	return rt->fib6_src.plen > 0;
 }
 
+/* The callers should hold f6i->fib6_table->tb6_lock if a route has ever
+ * been added to a table before.
+ */
 static inline void fib6_clean_expires(struct fib6_info *f6i)
 {
 	f6i->fib6_flags &= ~RTF_EXPIRES;
 	f6i->expires = 0;
 }
 
+/* The callers should hold f6i->fib6_table->tb6_lock if a route has ever
+ * been added to a table before.
+ */
 static inline void fib6_set_expires(struct fib6_info *f6i,
 				    unsigned long expires)
 {
@@ -327,8 +336,10 @@ static inline bool fib6_info_hold_safe(struct fib6_info *f6i)
 
 static inline void fib6_info_release(struct fib6_info *f6i)
 {
-	if (f6i && refcount_dec_and_test(&f6i->fib6_ref))
+	if (f6i && refcount_dec_and_test(&f6i->fib6_ref)) {
+		DEBUG_NET_WARN_ON_ONCE(!hlist_unhashed(&f6i->gc_link));
 		call_rcu(&f6i->rcu, fib6_info_destroy_rcu);
+	}
 }
 
 enum fib6_walk_state {
@@ -382,6 +393,7 @@ struct fib6_table {
 	struct inet_peer_base	tb6_peers;
 	unsigned int		flags;
 	unsigned int		fib_seq;
+	struct hlist_head       tb6_gc_hlist;	/* GC candidates */
 #define RT6_TABLE_HAS_DFLT_ROUTER	BIT(0)
 };
 
@@ -498,6 +510,38 @@ void fib6_gc_cleanup(void);
 
 int fib6_init(void);
 
+/* Add the route to the gc list if it is not already there
+ *
+ * The callers should hold f6i->fib6_table->tb6_lock.
+ */
+static inline void fib6_add_gc_list(struct fib6_info *f6i)
+{
+	/* If fib6_node is null, the f6i is not in (or removed from) the
+	 * table.
+	 *
+	 * There is a gap between finding the f6i from the table and
+	 * calling this function without the protection of the tb6_lock.
+	 * This check makes sure the f6i is not added to the gc list when
+	 * it is not on the table.
+	 */
+	if (!rcu_dereference_protected(f6i->fib6_node,
+				       lockdep_is_held(&f6i->fib6_table->tb6_lock)))
+		return;
+
+	if (hlist_unhashed(&f6i->gc_link))
+		hlist_add_head(&f6i->gc_link, &f6i->fib6_table->tb6_gc_hlist);
+}
+
+/* Remove the route from the gc list if it is on the list.
+ *
+ * The callers should hold f6i->fib6_table->tb6_lock.
+ */
+static inline void fib6_remove_gc_list(struct fib6_info *f6i)
+{
+	if (!hlist_unhashed(&f6i->gc_link))
+		hlist_del_init(&f6i->gc_link);
+}
+
 struct ipv6_route_iter {
 	struct seq_net_private p;
 	struct fib6_walker w;
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index d63f5d063f07..0ea44563454f 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1255,6 +1255,7 @@ static void
 cleanup_prefix_route(struct inet6_ifaddr *ifp, unsigned long expires,
 		     bool del_rt, bool del_peer)
 {
+	struct fib6_table *table;
 	struct fib6_info *f6i;
 
 	f6i = addrconf_get_prefix_route(del_peer ? &ifp->peer_addr : &ifp->addr,
@@ -1264,8 +1265,15 @@ cleanup_prefix_route(struct inet6_ifaddr *ifp, unsigned long expires,
 		if (del_rt)
 			ip6_del_rt(dev_net(ifp->idev->dev), f6i, false);
 		else {
-			if (!(f6i->fib6_flags & RTF_EXPIRES))
+			if (!(f6i->fib6_flags & RTF_EXPIRES)) {
+				table = f6i->fib6_table;
+				spin_lock_bh(&table->tb6_lock);
+
 				fib6_set_expires(f6i, expires);
+				fib6_add_gc_list(f6i);
+
+				spin_unlock_bh(&table->tb6_lock);
+			}
 			fib6_info_release(f6i);
 		}
 	}
@@ -2706,6 +2714,7 @@ EXPORT_SYMBOL_GPL(addrconf_prefix_rcv_add_addr);
 void addrconf_prefix_rcv(struct net_device *dev, u8 *opt, int len, bool sllao)
 {
 	struct prefix_info *pinfo;
+	struct fib6_table *table;
 	__u32 valid_lft;
 	__u32 prefered_lft;
 	int addr_type, err;
@@ -2782,11 +2791,20 @@ void addrconf_prefix_rcv(struct net_device *dev, u8 *opt, int len, bool sllao)
 			if (valid_lft == 0) {
 				ip6_del_rt(net, rt, false);
 				rt = NULL;
-			} else if (addrconf_finite_timeout(rt_expires)) {
-				/* not infinity */
-				fib6_set_expires(rt, jiffies + rt_expires);
 			} else {
-				fib6_clean_expires(rt);
+				table = rt->fib6_table;
+				spin_lock_bh(&table->tb6_lock);
+
+				if (addrconf_finite_timeout(rt_expires)) {
+					/* not infinity */
+					fib6_set_expires(rt, jiffies + rt_expires);
+					fib6_add_gc_list(rt);
+				} else {
+					fib6_clean_expires(rt);
+					fib6_remove_gc_list(rt);
+				}
+
+				spin_unlock_bh(&table->tb6_lock);
 			}
 		} else if (valid_lft) {
 			clock_t expires = 0;
@@ -4741,6 +4759,7 @@ static int modify_prefix_route(struct inet6_ifaddr *ifp,
 			       unsigned long expires, u32 flags,
 			       bool modify_peer)
 {
+	struct fib6_table *table;
 	struct fib6_info *f6i;
 	u32 prio;
 
@@ -4761,10 +4780,18 @@ static int modify_prefix_route(struct inet6_ifaddr *ifp,
 				      ifp->rt_priority, ifp->idev->dev,
 				      expires, flags, GFP_KERNEL);
 	} else {
-		if (!expires)
+		table = f6i->fib6_table;
+		spin_lock_bh(&table->tb6_lock);
+
+		if (!expires) {
 			fib6_clean_expires(f6i);
-		else
+			fib6_remove_gc_list(f6i);
+		} else {
 			fib6_set_expires(f6i, expires);
+			fib6_add_gc_list(f6i);
+		}
+
+		spin_unlock_bh(&table->tb6_lock);
 
 		fib6_info_release(f6i);
 	}
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 38a0348b1d17..805bbf26b3ef 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -160,6 +160,8 @@ struct fib6_info *fib6_info_alloc(gfp_t gfp_flags, bool with_fib6_nh)
 	INIT_LIST_HEAD(&f6i->fib6_siblings);
 	refcount_set(&f6i->fib6_ref, 1);
 
+	INIT_HLIST_NODE(&f6i->gc_link);
+
 	return f6i;
 }
 
@@ -246,6 +248,7 @@ static struct fib6_table *fib6_alloc_table(struct net *net, u32 id)
 				   net->ipv6.fib6_null_entry);
 		table->tb6_root.fn_flags = RTN_ROOT | RTN_TL_ROOT | RTN_RTINFO;
 		inet_peer_base_init(&table->tb6_peers);
+		INIT_HLIST_HEAD(&table->tb6_gc_hlist);
 	}
 
 	return table;
@@ -1055,6 +1058,9 @@ static void fib6_purge_rt(struct fib6_info *rt, struct fib6_node *fn,
 				    lockdep_is_held(&table->tb6_lock));
 		}
 	}
+
+	fib6_clean_expires(rt);
+	fib6_remove_gc_list(rt);
 }
 
 /*
@@ -1115,10 +1121,13 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 					rt->fib6_nsiblings = 0;
 				if (!(iter->fib6_flags & RTF_EXPIRES))
 					return -EEXIST;
-				if (!(rt->fib6_flags & RTF_EXPIRES))
+				if (!(rt->fib6_flags & RTF_EXPIRES)) {
 					fib6_clean_expires(iter);
-				else
+					fib6_remove_gc_list(iter);
+				} else {
 					fib6_set_expires(iter, rt->expires);
+					fib6_add_gc_list(iter);
+				}
 
 				if (rt->fib6_pmtu)
 					fib6_metric_set(iter, RTAX_MTU,
@@ -1477,6 +1486,10 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
 		if (rt->nh)
 			list_add(&rt->nh_list, &rt->nh->f6i_list);
 		__fib6_update_sernum_upto_root(rt, fib6_new_sernum(info->nl_net));
+
+		if (rt->fib6_flags & RTF_EXPIRES)
+			fib6_add_gc_list(rt);
+
 		fib6_start_gc(info->nl_net, rt);
 	}
 
@@ -2280,9 +2293,8 @@ static void fib6_flush_trees(struct net *net)
  *	Garbage collection
  */
 
-static int fib6_age(struct fib6_info *rt, void *arg)
+static int fib6_age(struct fib6_info *rt, struct fib6_gc_args *gc_args)
 {
-	struct fib6_gc_args *gc_args = arg;
 	unsigned long now = jiffies;
 
 	/*
@@ -2307,6 +2319,42 @@ static int fib6_age(struct fib6_info *rt, void *arg)
 	return 0;
 }
 
+static void fib6_gc_table(struct net *net,
+			  struct fib6_table *tb6,
+			  struct fib6_gc_args *gc_args)
+{
+	struct fib6_info *rt;
+	struct hlist_node *n;
+	struct nl_info info = {
+		.nl_net = net,
+		.skip_notify = false,
+	};
+
+	hlist_for_each_entry_safe(rt, n, &tb6->tb6_gc_hlist, gc_link)
+		if (fib6_age(rt, gc_args) == -1)
+			fib6_del(rt, &info);
+}
+
+static void fib6_gc_all(struct net *net, struct fib6_gc_args *gc_args)
+{
+	struct fib6_table *table;
+	struct hlist_head *head;
+	unsigned int h;
+
+	rcu_read_lock();
+	for (h = 0; h < FIB6_TABLE_HASHSZ; h++) {
+		head = &net->ipv6.fib_table_hash[h];
+		hlist_for_each_entry_rcu(table, head, tb6_hlist) {
+			spin_lock_bh(&table->tb6_lock);
+
+			fib6_gc_table(net, table, gc_args);
+
+			spin_unlock_bh(&table->tb6_lock);
+		}
+	}
+	rcu_read_unlock();
+}
+
 void fib6_run_gc(unsigned long expires, struct net *net, bool force)
 {
 	struct fib6_gc_args gc_args;
@@ -2322,7 +2370,7 @@ void fib6_run_gc(unsigned long expires, struct net *net, bool force)
 			  net->ipv6.sysctl.ip6_rt_gc_interval;
 	gc_args.more = 0;
 
-	fib6_clean_all(net, fib6_age, &gc_args);
+	fib6_gc_all(net, &gc_args);
 	now = jiffies;
 	net->ipv6.ip6_rt_last_gc = now;
 
@@ -2382,6 +2430,7 @@ static int __net_init fib6_net_init(struct net *net)
 	net->ipv6.fib6_main_tbl->tb6_root.fn_flags =
 		RTN_ROOT | RTN_TL_ROOT | RTN_RTINFO;
 	inet_peer_base_init(&net->ipv6.fib6_main_tbl->tb6_peers);
+	INIT_HLIST_HEAD(&net->ipv6.fib6_main_tbl->tb6_gc_hlist);
 
 #ifdef CONFIG_IPV6_MULTIPLE_TABLES
 	net->ipv6.fib6_local_tbl = kzalloc(sizeof(*net->ipv6.fib6_local_tbl),
@@ -2394,6 +2443,7 @@ static int __net_init fib6_net_init(struct net *net)
 	net->ipv6.fib6_local_tbl->tb6_root.fn_flags =
 		RTN_ROOT | RTN_TL_ROOT | RTN_RTINFO;
 	inet_peer_base_init(&net->ipv6.fib6_local_tbl->tb6_peers);
+	INIT_HLIST_HEAD(&net->ipv6.fib6_local_tbl->tb6_gc_hlist);
 #endif
 	fib6_tables_init(net);
 
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index a68462668158..73cb31afe935 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1237,6 +1237,7 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 	struct ndisc_options ndopts;
 	struct fib6_info *rt = NULL;
 	struct inet6_dev *in6_dev;
+	struct fib6_table *table;
 	u32 defrtr_usr_metric;
 	unsigned int pref = 0;
 	__u32 old_if_flags;
@@ -1410,8 +1411,15 @@ static enum skb_drop_reason ndisc_router_discovery(struct sk_buff *skb)
 		inet6_rt_notify(RTM_NEWROUTE, rt, &nlinfo, NLM_F_REPLACE);
 	}
 
-	if (rt)
+	if (rt) {
+		table = rt->fib6_table;
+		spin_lock_bh(&table->tb6_lock);
+
 		fib6_set_expires(rt, jiffies + (HZ * lifetime));
+		fib6_add_gc_list(rt);
+
+		spin_unlock_bh(&table->tb6_lock);
+	}
 	if (in6_dev->cnf.accept_ra_min_hop_limit < 256 &&
 	    ra_msg->icmph.icmp6_hop_limit) {
 		if (in6_dev->cnf.accept_ra_min_hop_limit <= ra_msg->icmph.icmp6_hop_limit) {
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index dd6ff5b20918..707d65bc9c0e 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -931,6 +931,7 @@ int rt6_route_rcv(struct net_device *dev, u8 *opt, int len,
 	struct net *net = dev_net(dev);
 	struct route_info *rinfo = (struct route_info *) opt;
 	struct in6_addr prefix_buf, *prefix;
+	struct fib6_table *table;
 	unsigned int pref;
 	unsigned long lifetime;
 	struct fib6_info *rt;
@@ -989,10 +990,18 @@ int rt6_route_rcv(struct net_device *dev, u8 *opt, int len,
 				 (rt->fib6_flags & ~RTF_PREF_MASK) | RTF_PREF(pref);
 
 	if (rt) {
-		if (!addrconf_finite_timeout(lifetime))
+		table = rt->fib6_table;
+		spin_lock_bh(&table->tb6_lock);
+
+		if (!addrconf_finite_timeout(lifetime)) {
 			fib6_clean_expires(rt);
-		else
+			fib6_remove_gc_list(rt);
+		} else {
 			fib6_set_expires(rt, jiffies + HZ * lifetime);
+			fib6_add_gc_list(rt);
+		}
+
+		spin_unlock_bh(&table->tb6_lock);
 
 		fib6_info_release(rt);
 	}
-- 
2.34.1


