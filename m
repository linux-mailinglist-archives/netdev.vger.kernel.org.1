Return-Path: <netdev+bounces-20070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABB275D85E
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 02:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8581C218E5
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 00:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC105398;
	Sat, 22 Jul 2023 00:40:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB6C7F
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 00:40:16 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F7D4205
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 17:39:50 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-583b3939521so2229297b3.0
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 17:39:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689986354; x=1690591154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qoJm8HZOejr4vVPyiih+2gft/8Nbr+RMFO1JvJRLYic=;
        b=X3rGXJyK3BbCmTSi5lz5dIYt2mi4vhxBu7e5rM51r9uq8zquX56P0tOTvNeekljLRp
         ps2DU3a2QaUL60aRdoXyfl4Ar2drzJD8a3pWa6RZKZoNw11TouGNPQrzCyJFVg4ASr6W
         oms4plpscoR5kWDawQy2WXAcpmpFAgT6sWiy6QavJd1m/kb7x334UBIrtnJIAxlC48Aq
         cq9l+YbfutkYud0gBxHYTfAuZj/baFZIrd/3ehu0VlmerbhTT9A8Ub6afmw1aTnBmOFs
         +nfeQ/1+P8lJI7BcGgbLnYjnMFC3TPdiSXf4PJo4qETl0SKuXLElqfJOIEsaMnkD3WxM
         Q/QA==
X-Gm-Message-State: ABy/qLbb9yDLdW038rjpwoGtJiG3iOMaOdB9aI7tyor6GNeEUji0q0eJ
	7QWgvtmX9xutJ86EyMtioLQ=
X-Google-Smtp-Source: APBJJlH0bLynxXBVWCKFOszGoqCCv44hIw6/zFPhmYY3b7EAtt7tzuI/7RSR01Q1IAaIcLBI8O1eLw==
X-Received: by 2002:a81:60c2:0:b0:583:8c64:930 with SMTP id u185-20020a8160c2000000b005838c640930mr1453184ywb.47.1689986354658;
        Fri, 21 Jul 2023 17:39:14 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a927:bf54:acf2:ee0a])
        by smtp.gmail.com with ESMTPSA id q2-20020a0dce02000000b005707d7686ddsm1265937ywd.76.2023.07.21.17.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 17:39:14 -0700 (PDT)
From: kuifeng@meta.com
To: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	yhs@meta.com
Cc: thinker.li@gmail.com,
	Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH net-next v4 1/2] net/ipv6: Remove expired routes with a separated list of routes.
Date: Fri, 21 Jul 2023 17:38:38 -0700
Message-Id: <20230722003839.897682-2-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722003839.897682-1-kuifeng@meta.com>
References: <20230722003839.897682-1-kuifeng@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <kuifeng@meta.com>

FIB6 GC walks trees of fib6_tables to remove expired routes. Walking a tree
can be expensive if the number of routes in a table is big, even if most of
them are permanent. Checking routes in a separated list of routes having
expiration will avoid this potential issue.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 include/net/ip6_fib.h | 65 ++++++++++++++++++++++++++++++++++---------
 net/ipv6/ip6_fib.c    | 56 +++++++++++++++++++++++++++++++++----
 net/ipv6/route.c      |  6 ++--
 3 files changed, 105 insertions(+), 22 deletions(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 05e6f756feaf..e6f4d986fb63 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -179,6 +179,9 @@ struct fib6_info {
 
 	refcount_t			fib6_ref;
 	unsigned long			expires;
+
+	struct hlist_node		gc_link;
+
 	struct dst_metrics		*fib6_metrics;
 #define fib6_pmtu		fib6_metrics->metrics[RTAX_MTU-1]
 
@@ -247,19 +250,6 @@ static inline bool fib6_requires_src(const struct fib6_info *rt)
 	return rt->fib6_src.plen > 0;
 }
 
-static inline void fib6_clean_expires(struct fib6_info *f6i)
-{
-	f6i->fib6_flags &= ~RTF_EXPIRES;
-	f6i->expires = 0;
-}
-
-static inline void fib6_set_expires(struct fib6_info *f6i,
-				    unsigned long expires)
-{
-	f6i->expires = expires;
-	f6i->fib6_flags |= RTF_EXPIRES;
-}
-
 static inline bool fib6_check_expired(const struct fib6_info *f6i)
 {
 	if (f6i->fib6_flags & RTF_EXPIRES)
@@ -267,6 +257,11 @@ static inline bool fib6_check_expired(const struct fib6_info *f6i)
 	return false;
 }
 
+static inline bool fib6_has_expires(const struct fib6_info *f6i)
+{
+	return f6i->fib6_flags & RTF_EXPIRES;
+}
+
 /* Function to safely get fn->fn_sernum for passed in rt
  * and store result in passed in cookie.
  * Return true if we can get cookie safely
@@ -388,6 +383,7 @@ struct fib6_table {
 	struct inet_peer_base	tb6_peers;
 	unsigned int		flags;
 	unsigned int		fib_seq;
+	struct hlist_head       tb6_gc_hlist;	/* GC candidates */
 #define RT6_TABLE_HAS_DFLT_ROUTER	BIT(0)
 };
 
@@ -504,6 +500,49 @@ void fib6_gc_cleanup(void);
 
 int fib6_init(void);
 
+/* fib6_info must be locked by the caller, and fib6_info->fib6_table can be
+ * NULL.
+ */
+static inline void fib6_set_expires_locked(struct fib6_info *f6i, unsigned long expires)
+{
+	struct fib6_table *tb6;
+
+	tb6 = f6i->fib6_table;
+	f6i->expires = expires;
+	if (tb6 && !fib6_has_expires(f6i))
+		hlist_add_head(&f6i->gc_link, &tb6->tb6_gc_hlist);
+	f6i->fib6_flags |= RTF_EXPIRES;
+}
+
+/* fib6_info must be locked by the caller, and fib6_info->fib6_table can be
+ * NULL.  If fib6_table is NULL, the fib6_info will no be inserted into the
+ * list of GC candidates until it is inserted into a table.
+ */
+static inline void fib6_set_expires(struct fib6_info *f6i, unsigned long expires)
+{
+	spin_lock_bh(&f6i->fib6_table->tb6_lock);
+	fib6_set_expires_locked(f6i, expires);
+	spin_unlock_bh(&f6i->fib6_table->tb6_lock);
+}
+
+static inline void fib6_clean_expires_locked(struct fib6_info *f6i)
+{
+	struct fib6_table *tb6;
+
+	tb6 = f6i->fib6_table;
+	if (tb6 && fib6_has_expires(f6i))
+		hlist_del_init(&f6i->gc_link);
+	f6i->fib6_flags &= ~RTF_EXPIRES;
+	f6i->expires = 0;
+}
+
+static inline void fib6_clean_expires(struct fib6_info *f6i)
+{
+	spin_lock_bh(&f6i->fib6_table->tb6_lock);
+	fib6_clean_expires_locked(f6i);
+	spin_unlock_bh(&f6i->fib6_table->tb6_lock);
+}
+
 struct ipv6_route_iter {
 	struct seq_net_private p;
 	struct fib6_walker w;
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index bac768d36cc1..3059e439817a 100644
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
@@ -1057,6 +1060,11 @@ static void fib6_purge_rt(struct fib6_info *rt, struct fib6_node *fn,
 				    lockdep_is_held(&table->tb6_lock));
 		}
 	}
+
+	if (fib6_has_expires(rt)) {
+		hlist_del_init(&rt->gc_link);
+		rt->fib6_flags &= ~RTF_EXPIRES;
+	}
 }
 
 /*
@@ -1118,9 +1126,9 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 				if (!(iter->fib6_flags & RTF_EXPIRES))
 					return -EEXIST;
 				if (!(rt->fib6_flags & RTF_EXPIRES))
-					fib6_clean_expires(iter);
+					fib6_clean_expires_locked(iter);
 				else
-					fib6_set_expires(iter, rt->expires);
+					fib6_set_expires_locked(iter, rt->expires);
 
 				if (rt->fib6_pmtu)
 					fib6_metric_set(iter, RTAX_MTU,
@@ -1480,6 +1488,9 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
 			list_add(&rt->nh_list, &rt->nh->f6i_list);
 		__fib6_update_sernum_upto_root(rt, fib6_new_sernum(info->nl_net));
 		fib6_start_gc(info->nl_net, rt);
+
+		if (fib6_has_expires(rt))
+			hlist_add_head(&rt->gc_link, &table->tb6_gc_hlist);
 	}
 
 out:
@@ -2285,9 +2296,8 @@ static void fib6_flush_trees(struct net *net)
  *	Garbage collection
  */
 
-static int fib6_age(struct fib6_info *rt, void *arg)
+static int fib6_age(struct fib6_info *rt, struct fib6_gc_args *gc_args)
 {
-	struct fib6_gc_args *gc_args = arg;
 	unsigned long now = jiffies;
 
 	/*
@@ -2295,7 +2305,7 @@ static int fib6_age(struct fib6_info *rt, void *arg)
 	 *	Routes are expired even if they are in use.
 	 */
 
-	if (rt->fib6_flags & RTF_EXPIRES && rt->expires) {
+	if (fib6_has_expires(rt) && rt->expires) {
 		if (time_after(now, rt->expires)) {
 			RT6_TRACE("expiring %p\n", rt);
 			return -1;
@@ -2312,6 +2322,40 @@ static int fib6_age(struct fib6_info *rt, void *arg)
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
+			fib6_gc_table(net, table, gc_args);
+			spin_unlock_bh(&table->tb6_lock);
+		}
+	}
+	rcu_read_unlock();
+}
+
 void fib6_run_gc(unsigned long expires, struct net *net, bool force)
 {
 	struct fib6_gc_args gc_args;
@@ -2327,7 +2371,7 @@ void fib6_run_gc(unsigned long expires, struct net *net, bool force)
 			  net->ipv6.sysctl.ip6_rt_gc_interval;
 	gc_args.more = 0;
 
-	fib6_clean_all(net, fib6_age, &gc_args);
+	fib6_gc_all(net, &gc_args);
 	now = jiffies;
 	net->ipv6.ip6_rt_last_gc = now;
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 64e873f5895f..a69083563689 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3760,10 +3760,10 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 		rt->dst_nocount = true;
 
 	if (cfg->fc_flags & RTF_EXPIRES)
-		fib6_set_expires(rt, jiffies +
-				clock_t_to_jiffies(cfg->fc_expires));
+		fib6_set_expires_locked(rt, jiffies +
+					clock_t_to_jiffies(cfg->fc_expires));
 	else
-		fib6_clean_expires(rt);
+		fib6_clean_expires_locked(rt);
 
 	if (cfg->fc_protocol == RTPROT_UNSPEC)
 		cfg->fc_protocol = RTPROT_BOOT;
-- 
2.34.1


