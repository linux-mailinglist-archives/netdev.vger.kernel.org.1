Return-Path: <netdev+bounces-201913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 163CBAEB64F
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671F8189AC4B
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E712D3EC9;
	Fri, 27 Jun 2025 11:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8eKWMTR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f73.google.com (mail-ua1-f73.google.com [209.85.222.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E70629DB6E
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 11:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751023554; cv=none; b=cCJQDtWPr79J53MLY05MNkdR/q3+LjVxq2AegemHMY88s/oNPGvobsub88AvdGUogBceDhLhIcfRgsD/BVYjfc3v4Ku/jR3U+nBcbHh5eUDYTriPrLIHfz0EmUi62LRDUb8hux2HwjjF8UE7vgJ6aBrjwDEVHoQWc7TkpPNdba8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751023554; c=relaxed/simple;
	bh=FfyRr5l2XHMZb+3zOxqOEXKQqbrEmecdLjDefY4zaCg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ceja7N2ypE8qaKpBHYPeL7gQD1orWwEJz/v58L8jdXulgJkrj4xq5q5k/YkmJJ9+8/HiGL4zpgbolJkcG8NjuvwBlk1FoVK0sbApmAGkhFeY8aAdBr7V29xdkkFY/5LtAuPAOQkYrdeosUyJ08BU3z62X17XMgffzH6nyEu84MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I8eKWMTR; arc=none smtp.client-ip=209.85.222.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-ua1-f73.google.com with SMTP id a1e0cc1a2514c-87ee00189c5so1922832241.1
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 04:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751023552; x=1751628352; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ojwz7dNYSjnOL7959/o/HrsXgWZ7ZlI3RJQPgBwNOM0=;
        b=I8eKWMTRCr8Dzd7cqas86SRQ6QId3waSoKlhryOO5qfGGD0g6otG9C6Z5hsvSekbon
         ELrTi9xz5dHGnR0WzU0gyJnAwqaqjMdFcTAc48y7CdsuQ4TjpSoTzw2rARgyVAEQ427P
         TeE6kpNoH9GafI8m3TQUpAkLfrpE6ZO/gPJSOyDixBsdXRhTw3dGRLjT60wyMzvgHQ6J
         MZfgt4ANaRtQEpnFd0Zrn9KhwXdphEs7X/SU/kqKiqr8fKOoES5dGWf/wmmFV4R9SerH
         D3neoVUOT0XCCTJzFTipam44a2bp5s0CQQg8wnGxNsQinZVAmjd6QQoE0rBE1tCxHWc5
         oiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751023552; x=1751628352;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojwz7dNYSjnOL7959/o/HrsXgWZ7ZlI3RJQPgBwNOM0=;
        b=UgfPXqXAA4gSipAD7WKLGIXuK8QJ9nEt54e6kxrm19+NFU4mFWQu3dQyQUvuRoWrpt
         fMjF2p+D2FX1VxlaB4Z1uHBAyudJz9mIiBnsxJ8ldIzPCWVqrzPkwbQDWmvtkZxjGOXn
         HgEU2vazFRQACDQQ0trf/QOGjb8LtWEzuUuJvBIdZ1I5QERBtyQItBpamZ+QY0rsNTMe
         1mHeVTNo/zK7znslhq0ogVae+2qmkPF9Pqe3uhVsck8nByWNiJCKAEHQiBbML7gFykyG
         IbmhHWaWoYtUwGZs3SEh2z/wPBwa00q7dbXCr6wMHYtpsOOSE6ERlqCIG+s3SdtiMjKL
         D7jA==
X-Forwarded-Encrypted: i=1; AJvYcCUXY8pS4VzQMWo7aUrZAYUUsHpne8Eq9cMnMA1RLFua8sEesBAWD9hrBKFls1deoSUGGvEJnCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR6pLz+dC8Tn3nW326R0OQS4X8bPYR2NCCWxlb4Dbmb3lm5WJE
	368tiAGWK5qITFjoFnSginY9SnHMXQCRL5l501Ot8fKizTkJzYoeb+BAbI1HB4ivZ/GcrXUjWdC
	T0VLgYVcDm+coAA==
X-Google-Smtp-Source: AGHT+IFGCBa2lrR/swuRfbO56GHFGLRkTCRBKMeBdYQX6yER0l8+aEXRe56Dli1JTcYHqzfvr20yxenJQcvjnA==
X-Received: from vsbkb21.prod.google.com ([2002:a05:6102:8095:b0:4e7:e350:addb])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:4a97:b0:4e2:e5ec:fa09 with SMTP id ada2fe7eead31-4ee508a9943mr1797646137.6.1751023552260;
 Fri, 27 Jun 2025 04:25:52 -0700 (PDT)
Date: Fri, 27 Jun 2025 11:25:26 +0000
In-Reply-To: <20250627112526.3615031-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627112526.3615031-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627112526.3615031-11-edumazet@google.com>
Subject: [PATCH net-next 10/10] ipv6: ip6_mc_input() and ip6_mr_input() cleanups
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Both functions are always called under RCU.

We remove the extra rcu_read_lock()/rcu_read_unlock().

We use skb_dst_dev_net_rcu() instead of skb_dst_dev_net().

We use dev_net_rcu() instead of dev_net().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_input.c | 29 +++++++++++------------------
 net/ipv6/ip6mr.c     |  9 ++++-----
 2 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 16953bd0096047f9b5fbb8e66bf9cc591e6693aa..0b3b81fd4a58ad62a83b807f38fd51ff24d47117 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -501,38 +501,32 @@ EXPORT_SYMBOL_GPL(ip6_input);
 
 int ip6_mc_input(struct sk_buff *skb)
 {
+	struct net_device *dev = skb->dev;
 	int sdif = inet6_sdif(skb);
 	const struct ipv6hdr *hdr;
-	struct net_device *dev;
 	bool deliver;
 
-	__IP6_UPD_PO_STATS(skb_dst_dev_net(skb),
-			 __in6_dev_get_safely(skb->dev), IPSTATS_MIB_INMCAST,
-			 skb->len);
+	__IP6_UPD_PO_STATS(skb_dst_dev_net_rcu(skb),
+			   __in6_dev_get_safely(dev), IPSTATS_MIB_INMCAST,
+			   skb->len);
 
 	/* skb->dev passed may be master dev for vrfs. */
 	if (sdif) {
-		rcu_read_lock();
-		dev = dev_get_by_index_rcu(dev_net(skb->dev), sdif);
+		dev = dev_get_by_index_rcu(dev_net_rcu(dev), sdif);
 		if (!dev) {
-			rcu_read_unlock();
 			kfree_skb(skb);
 			return -ENODEV;
 		}
-	} else {
-		dev = skb->dev;
 	}
 
 	hdr = ipv6_hdr(skb);
 	deliver = ipv6_chk_mcast_addr(dev, &hdr->daddr, NULL);
-	if (sdif)
-		rcu_read_unlock();
 
 #ifdef CONFIG_IPV6_MROUTE
 	/*
 	 *      IPv6 multicast router mode is now supported ;)
 	 */
-	if (atomic_read(&dev_net(skb->dev)->ipv6.devconf_all->mc_forwarding) &&
+	if (atomic_read(&dev_net_rcu(skb->dev)->ipv6.devconf_all->mc_forwarding) &&
 	    !(ipv6_addr_type(&hdr->daddr) &
 	      (IPV6_ADDR_LOOPBACK|IPV6_ADDR_LINKLOCAL)) &&
 	    likely(!(IP6CB(skb)->flags & IP6SKB_FORWARDED))) {
@@ -573,22 +567,21 @@ int ip6_mc_input(struct sk_buff *skb)
 			/* unknown RA - process it normally */
 		}
 
-		if (deliver)
+		if (deliver) {
 			skb2 = skb_clone(skb, GFP_ATOMIC);
-		else {
+		} else {
 			skb2 = skb;
 			skb = NULL;
 		}
 
-		if (skb2) {
+		if (skb2)
 			ip6_mr_input(skb2);
-		}
 	}
 out:
 #endif
-	if (likely(deliver))
+	if (likely(deliver)) {
 		ip6_input(skb);
-	else {
+	} else {
 		/* discard */
 		kfree_skb(skb);
 	}
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index a35f4f1c658960e4b087848461f3ea7af653d070..ea326fc33c6973fd60df464f6c8fd2ac70198db2 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2301,21 +2301,20 @@ static void ip6_mr_output_finish(struct net *net, struct mr_table *mrt,
 
 int ip6_mr_input(struct sk_buff *skb)
 {
+	struct net_device *dev = skb->dev;
+	struct net *net = dev_net_rcu(dev);
 	struct mfc6_cache *cache;
-	struct net *net = dev_net(skb->dev);
 	struct mr_table *mrt;
 	struct flowi6 fl6 = {
-		.flowi6_iif	= skb->dev->ifindex,
+		.flowi6_iif	= dev->ifindex,
 		.flowi6_mark	= skb->mark,
 	};
 	int err;
-	struct net_device *dev;
 
 	/* skb->dev passed in is the master dev for vrfs.
 	 * Get the proper interface that does have a vif associated with it.
 	 */
-	dev = skb->dev;
-	if (netif_is_l3_master(skb->dev)) {
+	if (netif_is_l3_master(dev)) {
 		dev = dev_get_by_index_rcu(net, IPCB(skb)->iif);
 		if (!dev) {
 			kfree_skb(skb);
-- 
2.50.0.727.gbf7dc18ff4-goog


