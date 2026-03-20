Return-Path: <netdev+bounces-269813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WF3cGG/2vGkt5AIAu9opvQ
	(envelope-from <netdev+bounces-269813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:25:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5002D694A
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A0493024CA9
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 07:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937D93043CF;
	Fri, 20 Mar 2026 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="co3yr5YC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416F435C19B
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773991405; cv=none; b=jrYaxhEFoeVPoqXJOq25m14bw2Y7ihSPTx5UclBkSST3oCKNSB0C1anud7WAj+lOXGi2Jtayfsv4j3MwFrk9yqDKhwQkRwh7Kx3Vto0kz2foblfx+k6Bl1ksSHC2pTFLTvyV4ZOnBqDfXA07/rw1E5pJKF07WZnfzeht8QtrqdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773991405; c=relaxed/simple;
	bh=bSDLWRxIa+f/T72QYdas/3gVxgDjjbQHKzAD0zJBbqY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fCy/H943xeJCGCnp92PS85toWTrzRcNj6h8xI5FUUH7ONygpn1ahv0nkHxlEtIkaclfkC5AeZEBqe99jXfm2UXRrghWJXLGH8SXzX68DFZ9Shj5xuHNGxU+oFnZ30E8/0bFMRjhhwespyjriaLGdoK9IhcG4voUx98lNk8pE2GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=co3yr5YC; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-829a9d3073bso149294b3a.2
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 00:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773991403; x=1774596203; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yVrUr5VDInjRZ4iI7LKrLnP+c0jMXJBnbBqv2YbaKbQ=;
        b=co3yr5YCwm9mVvMyLRXF6X1maUHm4h7bzpl4xH2CGEUAwdsNVet0t/o/dyGSmMR5B3
         O/YXhUO1a2DjHierQpk++zHNQ1mKvJzHILoEJAvsCBDJxDobiyUV/vjPEstpDXBkvQWJ
         hPyfqjQZ+XURls8Ir8sFciWOZc6St18KSMUnxevkysD4sCtXB49LTG9Cn0MkD8lxEPjb
         7kZQk/0yqUpE12oJWwO3M5dBy+3kL9/8skUJVCFBTRI9rLhrTI5H9mC98b2SlPmHGOZq
         KkBW/qgIEdRBlu4wyjm0FB/p71fu6fBrSSaKRHh42S5CU7hSEtR5hcTYW8dCWWGDbcj8
         n9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773991403; x=1774596203;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yVrUr5VDInjRZ4iI7LKrLnP+c0jMXJBnbBqv2YbaKbQ=;
        b=XJ27DpZy5PiUlkHNTI67YmX3+SYLpe87pCFv1oZSHWCzk6ogSph3I//QpeVaO9x0HR
         cn0YOpUwA4yfOyUGV49rkknOdH6kJHkTgrauCdcGIR+P08JTDy6O8R7SCOEeT25oYqws
         VbBx5I8uipt4CvWpIDDL4MeJW7oNd7tm0QYlqLLhcWKifurOmDLIHmbSJLD1eyRAeUe3
         N15HwOlVOB1+oySjXUXGZ/lwIPCLEv2iIGA+r/4hpY+su2LUGAeBCm7/uL6yIOq5YVJf
         wOVy3VRe3Si3B0IoqclLwOqrXvXzmp6k58GZ5/AJFXKKuWfbF0b2ywMIU+1PwHzN5pKY
         BGsg==
X-Forwarded-Encrypted: i=1; AJvYcCVb5bGpRwA2CCnlY1rHrSPuUVD6ftt+cfe3PBNTtD/SJwy3/maVPCi5mV7ahDCWYZ2ARmTQ9WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzRx5DIWLWo1x7N3Hm55igFzxhyP8/1d4GWwnYfTqEJkJ9/Xz5
	IVCszCi3empTsX+IEPO+Zm6D1LU4S67PaR3SzLnPYUjIVbHwHAJdqC4RJglsWYDPuDm5fadaWud
	aqlu7Bw==
X-Received: from pfbde15.prod.google.com ([2002:a05:6a00:468f:b0:82a:6125:cdb])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2c95:b0:829:7187:1a80
 with SMTP id d2e1a72fcca58-82a8c37df1amr1557237b3a.45.1773991403389; Fri, 20
 Mar 2026 00:23:23 -0700 (PDT)
Date: Fri, 20 Mar 2026 07:23:00 +0000
In-Reply-To: <20260320072317.2561779-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260320072317.2561779-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320072317.2561779-3-kuniyu@google.com>
Subject: [PATCH v6 net 2/3] ipv6: Don't remove permanent routes with
 exceptions from tb6_gc_hlist.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269813-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.779];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC5002D694A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The cited commit mechanically put fib6_remove_gc_list()
just after every fib6_clean_expires() call.

When a temporary route is promoted to a permanent route,
there may already be exception routes tied to it.

If fib6_remove_gc_list() removes the route from tb6_gc_hlist,
such exception routes will no longer be aged.

Let's replace fib6_remove_gc_list() with a new helper
fib6_may_remove_gc_list() and use fib6_age_exceptions() there.

Note that net->ipv6 is only compiled when CONFIG_IPV6 is
enabled, so fib6_{add,remove,may_remove}_gc_list() are guarded.

Fixes: 5eb902b8e719 ("net/ipv6: Remove expired routes with a separated list of routes.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v6: Call fib6_age_exceptions() under RCU
v4: s/,/;/ for fib6_gc_args initialisation
v3: Use IS_ENABLED()
v2: Fix build failure when CONFIG_IPV6=n (no net->ipv6 definition)

squash
---
 include/net/ip6_fib.h | 21 ++++++++++++++++++++-
 net/ipv6/addrconf.c   |  4 ++--
 net/ipv6/ip6_fib.c    |  6 +++---
 net/ipv6/route.c      |  2 +-
 4 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 88b0dd4d8e09..9f8b6814a96a 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -507,12 +507,14 @@ void fib6_rt_update(struct net *net, struct fib6_info *rt,
 void inet6_rt_notify(int event, struct fib6_info *rt, struct nl_info *info,
 		     unsigned int flags);
 
+void fib6_age_exceptions(struct fib6_info *rt, struct fib6_gc_args *gc_args,
+			 unsigned long now);
 void fib6_run_gc(unsigned long expires, struct net *net, bool force);
-
 void fib6_gc_cleanup(void);
 
 int fib6_init(void);
 
+#if IS_ENABLED(CONFIG_IPV6)
 /* Add the route to the gc list if it is not already there
  *
  * The callers should hold f6i->fib6_table->tb6_lock.
@@ -545,6 +547,23 @@ static inline void fib6_remove_gc_list(struct fib6_info *f6i)
 		hlist_del_init(&f6i->gc_link);
 }
 
+static inline void fib6_may_remove_gc_list(struct net *net,
+					   struct fib6_info *f6i)
+{
+	struct fib6_gc_args gc_args;
+
+	if (hlist_unhashed(&f6i->gc_link))
+		return;
+
+	gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval);
+	gc_args.more = 0;
+
+	rcu_read_lock();
+	fib6_age_exceptions(f6i, &gc_args, jiffies);
+	rcu_read_unlock();
+}
+#endif
+
 struct ipv6_route_iter {
 	struct seq_net_private p;
 	struct fib6_walker w;
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 0e55f139e05d..f4e23b543585 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2862,7 +2862,7 @@ void addrconf_prefix_rcv(struct net_device *dev, u8 *opt, int len, bool sllao)
 					fib6_add_gc_list(rt);
 				} else {
 					fib6_clean_expires(rt);
-					fib6_remove_gc_list(rt);
+					fib6_may_remove_gc_list(net, rt);
 				}
 
 				spin_unlock_bh(&table->tb6_lock);
@@ -4840,7 +4840,7 @@ static int modify_prefix_route(struct net *net, struct inet6_ifaddr *ifp,
 
 		if (!(flags & RTF_EXPIRES)) {
 			fib6_clean_expires(f6i);
-			fib6_remove_gc_list(f6i);
+			fib6_may_remove_gc_list(net, f6i);
 		} else {
 			fib6_set_expires(f6i, expires);
 			fib6_add_gc_list(f6i);
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index fadfca49d6b1..dd26657b6a4a 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -1133,7 +1133,7 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 					return -EEXIST;
 				if (!(rt->fib6_flags & RTF_EXPIRES)) {
 					fib6_clean_expires(iter);
-					fib6_remove_gc_list(iter);
+					fib6_may_remove_gc_list(info->nl_net, iter);
 				} else {
 					fib6_set_expires(iter, rt->expires);
 					fib6_add_gc_list(iter);
@@ -2348,8 +2348,8 @@ static void fib6_flush_trees(struct net *net)
 /*
  *	Garbage collection
  */
-static void fib6_age_exceptions(struct fib6_info *rt, struct fib6_gc_args *gc_args,
-				unsigned long now)
+void fib6_age_exceptions(struct fib6_info *rt, struct fib6_gc_args *gc_args,
+			 unsigned long now)
 {
 	bool may_expire = rt->fib6_flags & RTF_EXPIRES && rt->expires;
 	int old_more = gc_args->more;
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 08cd86f49bf9..cb521700cee7 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1033,7 +1033,7 @@ int rt6_route_rcv(struct net_device *dev, u8 *opt, int len,
 
 		if (!addrconf_finite_timeout(lifetime)) {
 			fib6_clean_expires(rt);
-			fib6_remove_gc_list(rt);
+			fib6_may_remove_gc_list(net, rt);
 		} else {
 			fib6_set_expires(rt, jiffies + HZ * lifetime);
 			fib6_add_gc_list(rt);
-- 
2.53.0.959.g497ff81fa9-goog


