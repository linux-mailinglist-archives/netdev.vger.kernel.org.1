Return-Path: <netdev+bounces-265224-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LTIB6jrrGkYwAEAu9opvQ
	(envelope-from <netdev+bounces-265224-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 04:23:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E67C22E6DC
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 04:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57A5C301070E
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 03:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40DF2E5B2D;
	Sun,  8 Mar 2026 03:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dgj1yJQZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A2929BDB4
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 03:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772940192; cv=none; b=A+8dgwtPXPsPxDgEFooBRI5BbsL2ITmSDBPeo7XglETMPEYPUjAgvO3nVuXJ6DsAUH8xblxKhACZxBbYNsPwvmDftegxSpECN5cjIpz5+3fj4iI93ybftkTzvIWQbEyvye78/TjRLYQGdWIVTmvOycdDlcoRn46HRdDyg+qkf4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772940192; c=relaxed/simple;
	bh=FbyORNTsn4rDxUlaxbtGW3E1Ty5WIDbJQKfw2uzBeWU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L/5Dye9C6K7obPY0Y5k2DKmuqUVFrWl026BIi+Mx+QPryGKVOetZWl6sBhwqgMfC7BST0p4kN15lf869S5hEP6ZPnfHVatS4UqfWm3ykDxZSCFmpQ9CqcswOSm4vfwzFhqOjx0w3UJGWh0F+C9Tg4PdHVr6LjnL/NY6DUBNRkt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dgj1yJQZ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c7378ffeeacso15415747a12.0
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 19:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772940191; x=1773544991; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jgILOvi5MCvwV7CMFZxp2knVI9RwY6VzBIpsUeMYwas=;
        b=Dgj1yJQZOwU3A6H1sHEhCWL+jRbKjnR18fEbEv2SybGAloqTpF9n7owDb+jOJe1Xrw
         nmsWmo8JKeUNF4GZrgo8raJpO2Zt9MqakIthBE/Vf+vca6q9b2y3uMrk0o87mOX5Df5E
         Pm9X7HyuM6fYf9jQ+rKHn6YSBUW3zg+TEqLi1sdtU0iq7vVCj+pDKPV3nIimgYbdpjwq
         tMg577EyS1q9o/6V2JwAs1iS2LI8DEt2qwHPmak3ahHzsByGNCFw/sPhFBeJLt/JVo5P
         UdiiyHfW7UhnEXYLF+T2NsFtb2y3Pi88wZzVrsn6kuorBgDDOHSRoYulVjmpt60XGnh8
         ky4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772940191; x=1773544991;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgILOvi5MCvwV7CMFZxp2knVI9RwY6VzBIpsUeMYwas=;
        b=Vw0fz9Tm0EvHY58rspWdY8DK0+WQ7y41fWBQ1bgV3ZQOVbbWkwucUUIsDkAw1jc7ir
         IMqthOzEP7GzybfliFhgzKjHZ2xGWFpbRkL1yKjMst+QmJwN/I/cVAR2dwXqSk/k4YW8
         xAUCW/RIaGpxF+KdRuzkG0OfCJd0zAgSUk12oZ5h5mmj5AfQFP8ZaNXldZ0/HvRrmeVb
         uA9jHXJLQTcmvwff+Mg9GI18FEMQRmaRQyl8GobqP7mPKWEeNVws0Dn4Eg/svbrZp2WW
         ZGze0JZHyDby77VdedtdNoPayef2fVntLFdgMSwRNJjldNUOU75gjA9Y7WjDG0e7jh7S
         cuPw==
X-Forwarded-Encrypted: i=1; AJvYcCW/bn3UC6MT7JQ7P83CLN17T24SlSC/YMDpTg0Ha7oDk1VEerLy0oXdFCXwtExuRVWNedOGp+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YytKgKY56xLp+1/LBehcHRgCxHOEq4usOj0cdCGZ20NcP2bOnb8
	hnPhv7SDmTHDebhui28yuiaP6Zi9yoqN35hRaO+McI6wma3mHMjVItA7eQVHDqMKz707sP08MPa
	MJKQWFQ==
X-Received: from pgdi10.prod.google.com ([2002:a05:6a02:51ea:b0:c6e:1eff:44ec])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:94c8:b0:334:a523:abe7
 with SMTP id adf61e73a8af0-39858fe5076mr7631200637.27.1772940190757; Sat, 07
 Mar 2026 19:23:10 -0800 (PST)
Date: Sun,  8 Mar 2026 03:22:55 +0000
In-Reply-To: <20260308032304.1841198-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260308032304.1841198-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260308032304.1841198-3-kuniyu@google.com>
Subject: [PATCH v2 net 2/2] ipv6: Don't remove permanent routes with
 exceptions from tb6_gc_hlist.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 1E67C22E6DC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265224-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.988];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

The cited commit mechanically put fib6_remove_gc_list()
just after every fib6_clean_expires() call.

When a temporary route is promoted to a permanent route,
there may already be exception routes tied to it.

If fib6_remove_gc_list() removes the route from tb6_gc_hlist,
such exception routes will no longer be aged.

Let's replace fib6_remove_gc_list() with a new helper
fib6_may_remove_gc_list() and use fib6_age_exceptions() there.

Fixes: 5eb902b8e719 ("net/ipv6: Remove expired routes with a separated list of routes.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: Fix build failure when CONFIG_IPV6=n (no net->ipv6 definition)
---
 include/net/ip6_fib.h | 19 ++++++++++++++++++-
 net/ipv6/addrconf.c   |  4 ++--
 net/ipv6/ip6_fib.c    |  6 +++---
 net/ipv6/route.c      |  2 +-
 4 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 88b0dd4d8e09..63183abf61b7 100644
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
 
+#ifdef CONFIG_IPV6
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
+	gc_args.timeout = READ_ONCE(net->ipv6.sysctl.ip6_rt_gc_interval),
+	gc_args.more = 0,
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


