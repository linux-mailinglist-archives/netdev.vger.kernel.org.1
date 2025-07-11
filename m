Return-Path: <netdev+bounces-206241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C21C9B02449
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 21:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6798D172FC8
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 19:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F4E2F3655;
	Fri, 11 Jul 2025 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1PEMsino"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2692F3646
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 19:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261021; cv=none; b=ZNie7khUkrKd0YK1mwGzE0Wi85SSUTgKqCH2nAMsrAiVS2VCJk9ROYwx7LY/wAY3rL1ug3NlMFzj4gGln4PsXnv+x6OOzcU8ruBJtnNtH+ttUo+KDFxbO3gkbrbQiwlETHCm7kzlKYRKO4jp5dqW2druuV+KE8zcNJVmOPZwKAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261021; c=relaxed/simple;
	bh=W6bbmLuLrv9df1jvG4c50DmBeUBuXq9Zec4JK11bub0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VnaasBG0bN+yDOG/Rvhap4o7H2xMlyxOGWUaozNi3Sv5ykLE4LtvwO9eEBJuF7SllmeVp5DaJTUczHGHltN32NXFzCmeV4Ceel346EhB3jfIC9Fu7jumCF4SRmzUqGZ+oUkpIa2ULmZUDqBJ2lfzmtQUj88Ii4JzhPgpsgRZ9Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1PEMsino; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-311a6b43ed7so2382337a91.1
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 12:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752261019; x=1752865819; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qe+ZyvouzkveWcMkfgAct9x5on3zHVrLmrlUOfO3dKU=;
        b=1PEMsinoRoMRLmrk5fIsxRs0kMgXo8c9JMuWH7DOqyNgYpGPi0+ApzWfezbVNS2gZw
         73LZHWZorIHY760M/GiOnQQcQeYxHyOq7bCJ/k2LsbYQIYYTuUniNgk6e2hRpTILJxo9
         kZFuS/1Sl9gu4qkTt+dIY1n5nXi01BfUVjilWiC5tekv9O7XLAurTzUcg3rlOxSgo2Vt
         xE8ZJeUpPITH4gPKdFd8J0pYYjxuNvw/vZqvXeaqygZUmEUw+NKyIARpF2xFjnPLGqpv
         iy5SeI34twA8L16LgfBQTYS24o1RRlaB81g90lE86S3xOQ+zELtrxGVl1VxS7KVRTfLm
         x4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752261019; x=1752865819;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qe+ZyvouzkveWcMkfgAct9x5on3zHVrLmrlUOfO3dKU=;
        b=IXZUmVvJRCb9Gd2U9s9I8buHkPv46EYR70l92lVJHUYCHhbMxsnSGiFBLG+fkyCt3L
         NrGJXGqrZ0aAg5YS0W1c8B67SRuLm23SWLp5EAP7K/126et3UkW2ncSu8bv47TzgaZkI
         /aEL0/EvnLqYTUtUSjS9bsEfG07i5fNb4N/VXWJFMPp5GnqGGXpOu9kfcDM7PTRwlghL
         4/U3A99GpxAuV5uJMeUnxQHVFApozx/0Ifj1Snz76k2txskPFsjV2tfsGCvXYCWiPafz
         dYecbu43dkH/DIhKbKQa1VA1ZxnCZ0XRCjeYTP1Z2TYKO/hnF1Ea3AP81T0Sz72Jfi7w
         MwMg==
X-Forwarded-Encrypted: i=1; AJvYcCU+zRvMAn51+wTD8rhianLYvvMkf9ep7C/iUYmqNMMbKRJlfkRX3ArSe27tB3f+Wm1khrvyfGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY6V3v4RDUBlatRtGmMoOwq1CeHA8kcH/VVJNf2j8xRRylYJ1r
	A3+MhdBNQZXenvf/eX4VaRcNubzp6Wq/74GSq1zGHcJ+EvzBM0DyGo87R2M8cuTULOJ55JRzGwX
	NcDYm+g==
X-Google-Smtp-Source: AGHT+IHGs8NNpG/7j4yZAtCasYY1cEAOuyMTNjz9XXC+FbRJaWtLoScVNXb5uiz/BiAkI3AuyXQFdLyHM4s=
X-Received: from pjq11.prod.google.com ([2002:a17:90b:560b:b0:2ff:84e6:b2bd])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d4f:b0:311:fc8b:31b5
 with SMTP id 98e67ed59e1d1-31c4f4c8a5bmr5555399a91.14.1752261019068; Fri, 11
 Jul 2025 12:10:19 -0700 (PDT)
Date: Fri, 11 Jul 2025 19:06:10 +0000
In-Reply-To: <20250711191007.3591938-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250711191007.3591938-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250711191007.3591938-6-kuniyu@google.com>
Subject: [PATCH v1 net-next 05/14] neighbour: Split pneigh_lookup().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

pneigh_lookup() has ASSERT_RTNL() in the middle of the function, which
is confusing.

When called with the last argument, creat, 0, pneigh_lookup() literally
looks up a proxy neighbour entry.  This is the case of the reader path
as the fast path and RTM_GETNEIGH.

pneigh_lookup(), however, creates a pneigh_entry when called with creat 1
from RTM_NEWNEIGH and SIOCSARP, which require RTNL.

Let's split pneigh_lookup() into two functions.

We will convert all the reader paths to RCU, and read_lock_bh(&tbl->lock)
in the new pneigh_lookup() will be dropped.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/neighbour.h |  5 +++--
 net/core/neighbour.c    | 39 +++++++++++++++++++++++++++++----------
 net/ipv4/arp.c          |  4 ++--
 net/ipv6/ip6_output.c   |  2 +-
 net/ipv6/ndisc.c        |  2 +-
 5 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 7e865b14749d6..7f3d57da5689a 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -376,10 +376,11 @@ unsigned long neigh_rand_reach_time(unsigned long base);
 void pneigh_enqueue(struct neigh_table *tbl, struct neigh_parms *p,
 		    struct sk_buff *skb);
 struct pneigh_entry *pneigh_lookup(struct neigh_table *tbl, struct net *net,
-				   const void *key, struct net_device *dev,
-				   int creat);
+				   const void *key, struct net_device *dev);
 struct pneigh_entry *__pneigh_lookup(struct neigh_table *tbl, struct net *net,
 				     const void *key, struct net_device *dev);
+struct pneigh_entry *pneigh_create(struct neigh_table *tbl, struct net *net,
+				   const void *key, struct net_device *dev);
 int pneigh_delete(struct neigh_table *tbl, struct net *net, const void *key,
 		  struct net_device *dev);
 
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index ad79f173e6229..814a45fb1962e 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -28,6 +28,7 @@
 #include <net/neighbour.h>
 #include <net/arp.h>
 #include <net/dst.h>
+#include <net/ip.h>
 #include <net/sock.h>
 #include <net/netevent.h>
 #include <net/netlink.h>
@@ -746,24 +747,44 @@ struct pneigh_entry *__pneigh_lookup(struct neigh_table *tbl,
 }
 EXPORT_SYMBOL_GPL(__pneigh_lookup);
 
-struct pneigh_entry * pneigh_lookup(struct neigh_table *tbl,
-				    struct net *net, const void *pkey,
-				    struct net_device *dev, int creat)
+struct pneigh_entry *pneigh_lookup(struct neigh_table *tbl,
+				   struct net *net, const void *pkey,
+				   struct net_device *dev)
+{
+	struct pneigh_entry *n;
+	unsigned int key_len;
+	u32 hash_val;
+
+	key_len = tbl->key_len;
+	hash_val = pneigh_hash(pkey, key_len);
+
+	read_lock_bh(&tbl->lock);
+	n = __pneigh_lookup_1(tbl->phash_buckets[hash_val],
+			      net, pkey, key_len, dev);
+	read_unlock_bh(&tbl->lock);
+
+	return n;
+}
+EXPORT_IPV6_MOD(pneigh_lookup);
+
+struct pneigh_entry *pneigh_create(struct neigh_table *tbl,
+				   struct net *net, const void *pkey,
+				   struct net_device *dev)
 {
 	struct pneigh_entry *n;
 	unsigned int key_len = tbl->key_len;
 	u32 hash_val = pneigh_hash(pkey, key_len);
 
+	ASSERT_RTNL();
+
 	read_lock_bh(&tbl->lock);
 	n = __pneigh_lookup_1(tbl->phash_buckets[hash_val],
 			      net, pkey, key_len, dev);
 	read_unlock_bh(&tbl->lock);
 
-	if (n || !creat)
+	if (n)
 		goto out;
 
-	ASSERT_RTNL();
-
 	n = kzalloc(sizeof(*n) + key_len, GFP_KERNEL);
 	if (!n)
 		goto out;
@@ -787,8 +808,6 @@ struct pneigh_entry * pneigh_lookup(struct neigh_table *tbl,
 out:
 	return n;
 }
-EXPORT_SYMBOL(pneigh_lookup);
-
 
 int pneigh_delete(struct neigh_table *tbl, struct net *net, const void *pkey,
 		  struct net_device *dev)
@@ -2007,7 +2026,7 @@ static int neigh_add(struct sk_buff *skb, struct nlmsghdr *nlh,
 		}
 
 		err = -ENOBUFS;
-		pn = pneigh_lookup(tbl, net, dst, dev, 1);
+		pn = pneigh_create(tbl, net, dst, dev);
 		if (pn) {
 			pn->flags = ndm_flags;
 			pn->permanent = !!(ndm->ndm_state & NUD_PERMANENT);
@@ -3044,7 +3063,7 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (ndm->ndm_flags & NTF_PROXY) {
 		struct pneigh_entry *pn;
 
-		pn = pneigh_lookup(tbl, net, dst, dev, 0);
+		pn = pneigh_lookup(tbl, net, dst, dev);
 		if (!pn) {
 			NL_SET_ERR_MSG(extack, "Proxy neighbour entry not found");
 			err = -ENOENT;
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index c0440d61cf2ff..d93b5735b0ba4 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -864,7 +864,7 @@ static int arp_process(struct net *net, struct sock *sk, struct sk_buff *skb)
 			    (arp_fwd_proxy(in_dev, dev, rt) ||
 			     arp_fwd_pvlan(in_dev, dev, rt, sip, tip) ||
 			     (rt->dst.dev != dev &&
-			      pneigh_lookup(&arp_tbl, net, &tip, dev, 0)))) {
+			      pneigh_lookup(&arp_tbl, net, &tip, dev)))) {
 				n = neigh_event_ns(&arp_tbl, sha, &sip, dev);
 				if (n)
 					neigh_release(n);
@@ -1089,7 +1089,7 @@ static int arp_req_set_public(struct net *net, struct arpreq *r,
 	if (mask) {
 		__be32 ip = ((struct sockaddr_in *)&r->arp_pa)->sin_addr.s_addr;
 
-		if (!pneigh_lookup(&arp_tbl, net, &ip, dev, 1))
+		if (!pneigh_create(&arp_tbl, net, &ip, dev))
 			return -ENOBUFS;
 		return 0;
 	}
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index fcc20c7250eb0..0412f85446958 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -563,7 +563,7 @@ int ip6_forward(struct sk_buff *skb)
 
 	/* XXX: idev->cnf.proxy_ndp? */
 	if (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
-	    pneigh_lookup(&nd_tbl, net, &hdr->daddr, skb->dev, 0)) {
+	    pneigh_lookup(&nd_tbl, net, &hdr->daddr, skb->dev)) {
 		int proxied = ip6_forward_proxy_check(skb);
 		if (proxied > 0) {
 			/* It's tempting to decrease the hop limit
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index d4c5876e17718..a3ac26c1df6d8 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1100,7 +1100,7 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 		if (lladdr && !memcmp(lladdr, dev->dev_addr, dev->addr_len) &&
 		    READ_ONCE(net->ipv6.devconf_all->forwarding) &&
 		    READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
-		    pneigh_lookup(&nd_tbl, net, &msg->target, dev, 0)) {
+		    pneigh_lookup(&nd_tbl, net, &msg->target, dev)) {
 			/* XXX: idev->cnf.proxy_ndp */
 			goto out;
 		}
-- 
2.50.0.727.gbf7dc18ff4-goog


