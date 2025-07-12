Return-Path: <netdev+bounces-206367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEAAB02CE2
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 22:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975184E18CF
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 20:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2CA220698;
	Sat, 12 Jul 2025 20:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tqyYy2Tb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8D1226CF7
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 20:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752352528; cv=none; b=JkzqQi5k2uYL5PAQ5dRMGUs6/4UuCZRVGQJuGwSoFsLbRwdhyYaX3mrqU+rQtHDJ3/UkaYbcJzUljlTbjANwtvCzDiWzivWXx8pxcmKepGRrtV0/fP/Zbxi/cTvQUBl8vmrX8A6RsKJSFQmvep67LotGD/deFyPiAemmZKhP3S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752352528; c=relaxed/simple;
	bh=W6bbmLuLrv9df1jvG4c50DmBeUBuXq9Zec4JK11bub0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c21AHQMOKhHgak30Xe3uBnutLA/9lbTLN2toYT7JMP3yalEywMwj2K6uwE7bog8JOBdJ9kroRAIBHgiEfPG3OEDvo5vo/w2+tdSWJ1R9PKR9v2gLExVZuT2lvHQ/+lRszBFtIs4kZUbghc/K26iw5bEJw84q6hxzSzC0WJDevy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tqyYy2Tb; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23638e1605dso24046455ad.0
        for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 13:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752352526; x=1752957326; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qe+ZyvouzkveWcMkfgAct9x5on3zHVrLmrlUOfO3dKU=;
        b=tqyYy2TbPeuYanBQ4bWbl23MGQf/O8dmLQdEq1xqDFOmG6z5UxknpMiP395Rf6ApHU
         1+41ts7g8bU/mcAgy1AZJbHXTyS7F8RRNw18PCp5O7XYfkPHRlJ2u/rbrLc56ISuf+ZV
         +CyJecIKmDmuof9V/GkFez32f0yx9IdD/E8MnM3FbQwpZX+yi6N/AjqCwL+fsO48JKT8
         JgLN31GXiovVv4y7BX2TI1q5DdSG+uR8dEKur0qVi6RICOQVithescGuLuX++xQEOzYm
         0Ye5h3t5oP+JGtPS8HlLaRpwceMD3DD2YYKLrbUZmef29uILjMqOm1Rg0Tc+JCJHIs0Z
         ey5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752352526; x=1752957326;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qe+ZyvouzkveWcMkfgAct9x5on3zHVrLmrlUOfO3dKU=;
        b=JmKhic3m+T6BtOjV5eGnnWvDI5mmTKlDx6Plczpd8GSR/HLl2Ew8lmKNzuJS6pecim
         Ywvn8stgY/VjJAAVYpoD284Xs12dEILNeiMVe6Q2JIe2xSvQ8sbgyZLEBqo7W2H6dy3m
         lB24Ph7sACvzJ/eSYzf8k2ymFe33jcmg/+xdsBBnV27ao9x9Sb78bDIVeTy+zItP741H
         +9lcv41nIJpeINyXW2u6TZ8p9TfbZDdTD+ARJwAQYNUL9/yAeE0QxLdsg0GSfo7dqsO0
         +AGzuSm91Kl9qQNJJa/FLZ/tga/bLiqSjUnR+fOuGcZkW4wRCmqR43KZWnuyRNQW2NsQ
         srrA==
X-Forwarded-Encrypted: i=1; AJvYcCXYineIXOFm3ojagUvmiAXOY7cPZIu3r/QZ7I+S4W8RNM0qJwllhaKLBXFn5HV/UGGiFXo8sts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgvF2K+OccOGp7HCkCFIc4Tnu5ohsuEY6DAe0VeE+OktPLQx5w
	MPa7JK5PPm5gqLO+2Yg1DY49i4X5Qj7BD6wNKKQkwDA0Gbi6XQyy2DvKg1kkqeQYvW4lGjB/z0z
	rUxcO8A==
X-Google-Smtp-Source: AGHT+IGUddu+vImi2SW3CUl+am59zjz9Yevxok1ypGIOAf/y20ezJN4x27zWMh/sxeZqHW76Q3AaNzCTjbE=
X-Received: from pjq11.prod.google.com ([2002:a17:90b:560b:b0:2ff:84e6:b2bd])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec3:b0:236:6f43:7047
 with SMTP id d9443c01a7336-23dee1888a4mr101280285ad.9.1752352526274; Sat, 12
 Jul 2025 13:35:26 -0700 (PDT)
Date: Sat, 12 Jul 2025 20:34:14 +0000
In-Reply-To: <20250712203515.4099110-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250712203515.4099110-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250712203515.4099110-6-kuniyu@google.com>
Subject: [PATCH v2 net-next 05/15] neighbour: Split pneigh_lookup().
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


