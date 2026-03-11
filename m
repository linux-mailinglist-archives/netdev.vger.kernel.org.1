Return-Path: <netdev+bounces-266484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOS6IIb+sGljpgIAu9opvQ
	(envelope-from <netdev+bounces-266484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:32:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E7725C736
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 06:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29B9B3235373
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 05:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0366032FA2C;
	Wed, 11 Mar 2026 05:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jCkn0rWj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE782332EAE
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 05:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773207001; cv=none; b=adevnXuWBbJls1125PhYz6G3hK2XFslCnaINLrVm2rU2VaEhTq4T3hTKqs4eHAsqNbPwqegIGDyRG5pM/mZRsN5m41ju+OPFL76st8+81h+QFBJ/JurFaVYCdtfoZF6+kSsDQtIGTYIigzorzo2n226ZIqk7h6vPCYU/O3f8on4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773207001; c=relaxed/simple;
	bh=C1bIPZwqowhLOIwqy1Bkc5bVsCAAe619Do6EqAEVaag=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lH1pnfSQbXTWrireKdznqngKflctqJTWQLWks3rS5ii9/iHc/qQlaAhxryvkaJZuO463RlmybK1xUvM4Snpezubm2i8zw/HoMqqV720+hZpCqVBbh+PsmR7FjaXzRzc7+ZhCN9qoYGF9NkHEHE4vCO3/K+BTVhoxX3CIb7ikmoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jCkn0rWj; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8298150caddso4959953b3a.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 22:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773207000; x=1773811800; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4XglsB4NZxlYwqffuRsPGtYnVD8KhA2LGJTl+Hyimao=;
        b=jCkn0rWj0MSvRJWaLPLIHd99gBKnMaopNnxNyhieNrI+94uW1CXPE0PIsT9l9z5Nr8
         cCD094RCiLLsyRGtqG9kvuzhKJK0EMHwFsGXHqXCWXnpWIHzzNKT2VYB5V3ZYcWjg/Hf
         M0dys+JSi6VOBVX1JAW7/R5cxpbsdQM1avXv8qQkCDgVQZcEY3h+0Sql7x1lLaxxYKW3
         0bkycDiQBNaV4z3WbWDZ42+DTFtOxsPG5ikVTW8jpQ6ePrryXDXHXxYT79FWCevYuLVg
         RhqTg6ZMda9EcquMzy130XVrSct5q/d4Zw/ae/2JhNC/3lXZE/HjTY1q1kZPcO/jkLcM
         +izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773207000; x=1773811800;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4XglsB4NZxlYwqffuRsPGtYnVD8KhA2LGJTl+Hyimao=;
        b=xBXJ1wmk1QQXTZSSlVmXXwXN05D8FdR2Qdkh/sZHFngVr07FtCdi1EUNkQmDJXU/06
         uPDqTBhJ+pYczkp6kX3izh5Et+HQiv6Yicnt5xcm9dbTmYcnwGvP2ZZFvYk43aKCQMyU
         LNoDO1JeVantclUBbpPGXJc6SKU7k3CCtBWPxJjXcJ5DYJEUCY5GxNZYfxH22qrMrsXR
         QJ+Q0WkOr46+DHosiV0BGEDkbXKO2aL9i/ZPvFzV3iZpKyB5ocKyB1CsFHq7WqTO7hpo
         qkUWckdJ+GXtHxH1YQtQjNxebsVPdTYGMNPy70ILuajfp8RvZMsDYHVxfxcLXxKq++8g
         uy8A==
X-Forwarded-Encrypted: i=1; AJvYcCWU5OfziQ3y2YBQN9swWJvFARwzm+X2bvgcgQzuZt/m+fRy4XIooQyGdQIw3Bgst0w6uj13f/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ71ySg048nYVpKOPHcelxu/tjIjCiqrIijLApyfixSWvbOHSR
	pgqyEadImvNaroaSfLfRjYmqNtXqzSh/G3qfIq4JTVYCr43B7nbEfw0Kp6hq7qLyyZoZ9Jhzvrv
	yfW8ulA==
X-Received: from pfbhm14.prod.google.com ([2002:a05:6a00:670e:b0:829:8287:d81d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:ab83:b0:81c:92ec:ccf3
 with SMTP id d2e1a72fcca58-829f6f2122emr1369358b3a.19.1773206999824; Tue, 10
 Mar 2026 22:29:59 -0700 (PDT)
Date: Wed, 11 Mar 2026 05:29:43 +0000
In-Reply-To: <20260311052954.1224278-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260311052954.1224278-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311052954.1224278-3-kuniyu@google.com>
Subject: [PATCH v4 net 2/2] ipv6: Don't remove permanent routes with
 exceptions from tb6_gc_hlist.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: D9E7725C736
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266484-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

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
v4: s/,/;/ for fib6_gc_args initialisation
v3: Use IS_ENABLED()
v2: Fix build failure when CONFIG_IPV6=n (no net->ipv6 definition)
---
 include/net/ip6_fib.h | 19 ++++++++++++++++++-
 net/ipv6/addrconf.c   |  4 ++--
 net/ipv6/ip6_fib.c    |  6 +++---
 net/ipv6/route.c      |  2 +-
 4 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 88b0dd4d8e09..438bcbc54a35 100644
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
@@ -545,6 +547,21 @@ static inline void fib6_remove_gc_list(struct fib6_info *f6i)
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
+	fib6_age_exceptions(f6i, &gc_args, jiffies);
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
2.53.0.473.g4a7958ca14-goog


