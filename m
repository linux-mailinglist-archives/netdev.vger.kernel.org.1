Return-Path: <netdev+bounces-207622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 999A0B0804B
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 00:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B92566BEB
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DD62EE987;
	Wed, 16 Jul 2025 22:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EJchjHBg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38102EE96B
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 22:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703953; cv=none; b=uKuLG5wWMkQk4SWnour6YBLCYC6LO9cR63rOez5CXsL0d9gnX25pUZGM+Ds6eX2uy9X50eODYfnjQ5zSyCvFu1IxAaXDFZboBlvfAe3EqdruHO+f4rIAByEZFEawDi+fH06L4/dRBteAppY90W4SH2lIybonKvYKM8rUfRwDggA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703953; c=relaxed/simple;
	bh=thUl2OLaBXmX8kCZ/QeEFba2GZDK1k0OsQZfP5pUhR4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cRQHHYHsixaUVH91fORBbeHSDX2onbn5Qf/X+k0gTT2xX49h6FSOPCHQHk4j4lwQocFc7DWF3r6W9UUNDePwk8DJ7r7t2SuyzaomRiwcDelHJ9FN0Nj9IPHkzGY9LJ3GrVXqiR6K4Dposn7yGd1FYLo4yhwoRnyGhBH7NjSgqtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EJchjHBg; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23536f7c2d7so3694055ad.2
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 15:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752703951; x=1753308751; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8/jPWOBSfrNzBwNLO37ibMxAf9QXwhaAq+zroo7kw68=;
        b=EJchjHBgPsC+F9bUbvWaZdJUbiHE1jF+nVHBnVelv8eNgHQpzcKf6ce/C2NGD4ThRZ
         W4GsSGbmK6LVkQw9PIK8saQlK16abRsqoDJBymOsuAHBjIuxE17qMkLAtAC7TY9IqSWF
         9OPOEWb62rP28TvacWXigxGyzlFYbbYtj+WVXXCG5gcePZJJL5i85HMymvHnDCE3bEx/
         3LhMEsh+esDHZ1szFE8juB3FeDtDYkgJo7nVnWY2Ynoa75GOa5njYrwcDTWchJ7HxZsS
         rACnyzFq6CzjtPPDIG8i1xLDliV+ShlEPkrNUvvOJNekNDklTekB7XH9wxeOdoav3lPA
         S5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752703951; x=1753308751;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8/jPWOBSfrNzBwNLO37ibMxAf9QXwhaAq+zroo7kw68=;
        b=DtBs+M/7FJFQakthFj+WW6n/YW6V75ncB5xhoXPpmB5HvBqOXd8p/8URmf8U2+lGUR
         HdHFolkSFO0rvXijUDa09fh3jhh3kgDllAuOxMls6SfsG9AghQEUE7yxEtZWFRSRrXjV
         n1VKEhC+yohORjf0x6z09UmUwG2hlRSEgY0+ykcWF/x8GeAqA6YJDGzb6TPX8why0D4Q
         LrMmxBUCe/pEsGsUfphjt8sb/rebhiApay+X/8Ljvfq8sq1CnnM7Uqb+PM4M15e/lzTm
         PSLwIgF6Wbj1Js2HPQexFAth0VLhJ55vk+4iOpJavKcR1Mq64PhRPQ7HsgCI8hkXAXiG
         MTaw==
X-Forwarded-Encrypted: i=1; AJvYcCXyPpq4AhmW715U38yaKqy2rwwa4jemXe3d2b+f2i2XCUc3782kIU+8d0BBo9ttlwL37FWJLNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWFRTK0H8XGhhrOuH/CC1Tk3+uI/WBbUDINRF4bv3rxsr4PEER
	DJEY2KxcUDrNV8dXEtaCXaN05xEbxhJqhxlvpFdpYvUw0nHamOwuxfK0Wtv3SNv9eLISC5Ws33E
	ZkyDY3Q==
X-Google-Smtp-Source: AGHT+IHcxcgcjEWMSukfVmV6OLD2shDj9iNvX8ITo7X41EjMUzKVbAn6uRvqJg8+mkXFfInBEvdUGyqMp4s=
X-Received: from pjzz15.prod.google.com ([2002:a17:90b:58ef:b0:311:ef56:7694])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce0a:b0:23a:bc47:381f
 with SMTP id d9443c01a7336-23e25763d49mr53635325ad.36.1752703951021; Wed, 16
 Jul 2025 15:12:31 -0700 (PDT)
Date: Wed, 16 Jul 2025 22:08:10 +0000
In-Reply-To: <20250716221221.442239-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716221221.442239-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250716221221.442239-6-kuniyu@google.com>
Subject: [PATCH v3 net-next 05/15] neighbour: Split pneigh_lookup().
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
index c6ff53df9a012..b073b14799ce1 100644
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
@@ -3036,7 +3055,7 @@ static int neigh_get(struct sk_buff *in_skb, struct nlmsghdr *nlh,
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


