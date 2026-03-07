Return-Path: <netdev+bounces-265018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDYZA76Rq2mkeQEAu9opvQ
	(envelope-from <netdev+bounces-265018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 03:47:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0476A229ABB
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 03:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B34530200E4
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 02:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F93A2DCF55;
	Sat,  7 Mar 2026 02:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4r+3d+8S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85EB26F476
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 02:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772851637; cv=none; b=cgG71le1yUJ+CTOKWW3mmuzC/hWHFxUULPg6URCdVPb446ZEkU0ZaY4miNUHa1anEh62bPKTvP0Uq5WE58JzRXZCahEfPWVz3a+Hf7wcCJBx9qj7LMVDqHOAHCJeu/ng8chnZ4jvmyhBOZiKIyCGJxDMLYDQbRBWkSo4ZkfahP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772851637; c=relaxed/simple;
	bh=PvoznXb2jkMoY6Rq/zt5ZgHaRzKfsp9wTqQzeR3hGtI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qCZj/L7i0ArCu6aEeAH+iMfGF62JGu9GvRrhIEP+8XFDJKVfU6p4RyMYB7wVQjEMUhyI5hsjiVercijVY6JJkI5WQvaXd8UGdlt8wp0CGdxyAJ+J4S81P3vVZ+X+NOwFCOmPGpryb9p5JSrmCBxrdrLaYCSxDuYSGNFvfFvKw3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4r+3d+8S; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2adef9d486bso87342305ad.2
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 18:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772851635; x=1773456435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MHiZHpv+UNZB1GUua9s+4ivCvaJlc/tiQo4N5oUALfI=;
        b=4r+3d+8SLB/etxZNa56nUp8etnGxaAcGDDfYiDUOoBgEJWNr8YCxLSaIslZx9ADflt
         U2seuqmK1RQSZPr/iOBJ+4as9KUK/SL9LNDHcb8NxAr+G3qO6O0RdImo0mDHzIRP2Xqz
         AniH9crxLyUnOPLW0Nbg6+p0cszaw9CNvtkAqbxQVl/H3aT1zc1ZSWiP/cQ9PqNXsuvh
         ZVsNL/zTZR9euPwhhZ0FT9tHopMv9VVHef+CgytTuwsIKNXkJBOiRfbeVkJ6sq3tHPGB
         /LKG9OtvWLV2OE7AeLSVfdOZdRyKgcJGhP1Dh6HXSdbafq/gPBVCg/vxHAkwfn2jymuJ
         6Yhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772851635; x=1773456435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MHiZHpv+UNZB1GUua9s+4ivCvaJlc/tiQo4N5oUALfI=;
        b=g1npqoDqNlVdEAdVCap8Wmk23rBE/CSEolhe8MS+Lcqy50U1OfB1KvfFpEx8iw4PP8
         bMyroG3a/FOdDqJ71hUGHhEl34r1A4Nkp9U1T3dce6YiT/GDMOMlSyUAAzVgUPzMk700
         AilYDCdxYyWLle3M7/rcEfysVVnQHo81tWbl5LOkZuVsp2zWLkVtABLLXGo36O+i1XWY
         A4Lz4gibqhMqkZslggC9X4qQGd7CX92fXE3mFDeamW1hmX4xEOS68uLvLYs4FTEUtQUI
         riQ/APUN7SoJNnSl/G8L+wbgDSgsOpkP79ove88LZoJ3d1bJQ4rrcPibFEaq7M1ENhqM
         yNug==
X-Forwarded-Encrypted: i=1; AJvYcCUiMXYctGNFKNRAtt0xYR+kbUCxTd092z4E56gXo96TgC4Go8pIjfNKk7IDG9UaKiIPbEEHRXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyImLa5MCCCqCMX+DF4pGTmRflUP1j3/ra/VwHVSk1Um6ZbdCvQ
	FAm/e8xW+uBDxWm/cBOJ9wfKAY7a96sRdwAwLYqk7Uv/rEgJ5QgfGy5HrIk8UaB65KL2N8l4bqs
	Px3Qulg==
X-Received: from plw20.prod.google.com ([2002:a17:903:45d4:b0:2ae:4ac1:4017])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c94a:b0:2ae:698d:94a6
 with SMTP id d9443c01a7336-2ae8241dd3dmr50729635ad.2.1772851635210; Fri, 06
 Mar 2026 18:47:15 -0800 (PST)
Date: Sat,  7 Mar 2026 02:46:57 +0000
In-Reply-To: <20260307024709.718395-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260307024709.718395-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260307024709.718395-3-kuniyu@google.com>
Subject: [PATCH v1 net 2/2] ipv6: Don't remove permanent routes with
 exceptions from tb6_gc_hlist.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0476A229ABB
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
	TAGGED_FROM(0.00)[bounces-265018-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.987];
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
 include/net/ip6_fib.h | 17 ++++++++++++++++-
 net/ipv6/addrconf.c   |  4 ++--
 net/ipv6/ip6_fib.c    |  6 +++---
 net/ipv6/route.c      |  2 +-
 4 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 88b0dd4d8e09..188494d1b509 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -507,8 +507,9 @@ void fib6_rt_update(struct net *net, struct fib6_info *rt,
 void inet6_rt_notify(int event, struct fib6_info *rt, struct nl_info *info,
 		     unsigned int flags);
 
+void fib6_age_exceptions(struct fib6_info *rt, struct fib6_gc_args *gc_args,
+			 unsigned long now);
 void fib6_run_gc(unsigned long expires, struct net *net, bool force);
-
 void fib6_gc_cleanup(void);
 
 int fib6_init(void);
@@ -545,6 +546,20 @@ static inline void fib6_remove_gc_list(struct fib6_info *f6i)
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


