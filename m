Return-Path: <netdev+bounces-269298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AO5BHV4u2lvkgIAu9opvQ
	(envelope-from <netdev+bounces-269298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 05:15:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5E02C5D8E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 05:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20D333113CA8
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 04:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F342E3093C3;
	Thu, 19 Mar 2026 04:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YG3cGMa4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD10319601
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 04:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773893675; cv=none; b=ISSOug/T7BdMhEaQgij8htbdNuPlQGLZS7i1y5xpfFc3HLUFD8U36LE5GEBiBp4134m7JTWsUMv3/EAXgHElDTHpg1e0D56/DOrCckCay+5O5JITBhpGAeTsC6mz6opOw7rfr9UOj5KChxodi7PkfMp9qYXhc68kQ7Sad/nyTt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773893675; c=relaxed/simple;
	bh=+HVgGLlv6KNGyR2/CA0SMGcpJmTDZ/nhO6x2Bec9coI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qNM1JZjkzmqAGSzHpbsAZuYz8MkALkaciPUXJbAJLMQzdCy7fc0nP+If90rR+ydD+o/SUvrp6fdGphTPpzBVZ0IIztTwnI/AG7k5XzhEebyIm6vWGXLoLqQ15rTiaCktWg2hbWI17BiLxwbxFXrWzxVTe41sgR8tR6ZQOpoSMkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YG3cGMa4; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c741c4cebf3so449338a12.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 21:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773893674; x=1774498474; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t0YQdolEGVcIVcg+gKLTKpcYU2BOZVFnWs1kY8PEKX8=;
        b=YG3cGMa4xSuKO7fLBp43U/YdK97WNUxnKFyMKaYeIGTSldrJ7y2+DyVIan02DOoWQZ
         8v1YA6OtZpH/tizPdL1OAtsqS2gx0afu6/4eVl3svi7K0wsxN4Q1t9Z3zMgAVh1DSpLW
         JlvCXwYve2YH5OzoQjGm1zCvgH2kG48PeEwinIDZFt/gWSDA6oW2LIArlft6QZ3B3fYf
         qYtpDimOaOoYkD/WoshyEx3cHI+4b/opRabZlLHJBaZFhjgni4f8zl4uUyAb3UX/ypyJ
         IOv1kH4ayhV6A3UstslvfqW7lcak+ucYeahFFzQpsIA0lAEV+TD4sILy7Cllj6pvK351
         HxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773893674; x=1774498474;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t0YQdolEGVcIVcg+gKLTKpcYU2BOZVFnWs1kY8PEKX8=;
        b=fOfDfTxJ37zG9SiZzAAgfJlnq1vEPixgnpYdZPreQe4nVfxTgzLpdZrVIXk9Jx5q/A
         TnI+9McHsUGm+gbdT72nV1Qm5bLkieBHm27wqjxyUJpm4Idpe2CjpvDgLYeu7KL+kWp9
         zhMfyoHTtcx+YSs+Ktl9yYQMiUIMazn7mX/dZP4EnvadAdclGF3/5pv3med3idF7bZ09
         w00M/iESFN03G4oGMBf+mCB+mD5tTXmSWZW5RsBaS82or8iXJ8FIcoCwj/KCHaUHaEzs
         WbxuNDJpGH40EfZ+0QPWbO23Ka+nSYQHsgPGNsyk+DcrI5C5xQV0wcMSR+DzxT8r6c/c
         IYlQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4l9ymba2/sWsbhRl7YvyamNndO3lyLJweRgs2HwRcoVRtY8QcQ5MQTxGAn4NzVeu0/c5lO6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YysQwcGIwLMEEffVhj5Xg4itFgcQNOQzog+wXgqBhJ6kpGR8OvO
	O6Gimsix0+LSfIjNPfjHsW0rBTtYy60X2uZVg/1SG7eabnABIpaOWw+dGosh1ognGNMQjkY/9FK
	a5e8BIw==
X-Received: from pggh18.prod.google.com ([2002:a63:c012:0:b0:c73:9a26:bb53])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9d8e:b0:38e:9405:beff
 with SMTP id adf61e73a8af0-39b9a084bc6mr5533586637.65.1773893673755; Wed, 18
 Mar 2026 21:14:33 -0700 (PDT)
Date: Thu, 19 Mar 2026 04:13:51 +0000
In-Reply-To: <20260319041427.1528743-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319041427.1528743-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260319041427.1528743-3-kuniyu@google.com>
Subject: [PATCH v5 net 2/3] ipv6: Don't remove permanent routes with
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269298-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.779];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B5E02C5D8E
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
2.53.0.851.ga537e3e6e9-goog


