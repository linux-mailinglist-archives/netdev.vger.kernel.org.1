Return-Path: <netdev+bounces-202417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7569AEDC9B
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CE75170294
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 12:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895E028A419;
	Mon, 30 Jun 2025 12:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q7bkSOw7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07B928A402
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 12:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285994; cv=none; b=ipDvejslzcmrwZ8f42YQQuUYIrD3vPwml+UYrueBqWVNISrUauyyerqxccvLp2r+6Ri40wte1M1siD3EUAmHP14rVaGKnQl8N0gRGlvEw5DkP6c3Y4OOcqPdc2MQZKjxO3iYAzUvzDvE6z1iY0xxb8DriNTXF+5pyQIWPpDVc9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285994; c=relaxed/simple;
	bh=xD/72x59pSTBsHsDohJ7lLSbb7uuYx44wkVV8kdjZ/U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mV6RIwGl3PcjbOt5muc75q4aYTKwtlLbnv9bWHh+QJ9HZbyrMpNO7U4+rOu9XkZGy5PqmZmNZQrKBdUCuQxq2xiDBswGhXRwnnTVYIIPraaWipUNdTPrpNxgcOxs4wpmBKLHdBSz5kPwFJebAfaHRFgr0fLuOr7A9QsGkKHGLJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q7bkSOw7; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6fd0a3f15daso156592816d6.2
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 05:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751285992; x=1751890792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SpX/JVZN8xFGlRwjwGgnGn9qyOdm13weyVX0Jc7Sdyg=;
        b=Q7bkSOw7CteDpIifX3tUeirSHxoccUnN5tDD69hrh2x4i6wOJ0/0j7Ef9uspGKeETR
         ipAQbCzUos0gQlY4zqPM9KZZkKh2nDffzxFVyv/fscondE84KkgrGlJXj4dqSGynXr4+
         oZfn13r8g7G2odr694I8MczE3JvQDnIkIpEwegWkzlJ38VejqIr8y89f6ke5pTEdLw32
         NpBEupC/Yon86EoTWpc0Zs/si3mr4OdD7KnRcZcmQruhKyY560omPNiH1D7pX2r7NDQL
         QuQaNuLe3nuj7pOA/+hoBAdda2whZ/mGt4V4D9iNZZ57qtgJIgIyPc+5jLWepCH9EpTi
         hWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751285992; x=1751890792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SpX/JVZN8xFGlRwjwGgnGn9qyOdm13weyVX0Jc7Sdyg=;
        b=Gd8fnOW0hlKL+V/Hqzla7ES3Hp/dTvwutbslE4hbfEGdHzbU2dyXz+d9TeW4mUPtdO
         D6B+5OldlYPJhELnZg9D27cxkdKZEAEy2miqDYisugnK+SztCCsr39eScxe5Pcr31QBy
         8NHqwF2Pdk3afeIWlSJWXxE/zseqbBw9CkwUGp8jYmldREcnOGbvdd8o+Y5FBTPHXI/q
         CHPcsPLOmSb70dqrE3FxCG2aM5+cDJMpDQzEuvTu0eyR9QXl5tWBGcqXdRZMdWhKKvE6
         xCya7HfNk9w2ugUEijN0D3EfILPia7hSErUzHPzBG4KJtdQ+FQoVmybhOpmvK9EhGOd8
         fpjw==
X-Forwarded-Encrypted: i=1; AJvYcCWb6fR1wuGE8QbmcEkekKlq3igPazDRXmFXrZX1iLWGfOQNMg1CcMEe9ELYt8UL7r+jbOLhwmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+7tCXxpkDXw76q5zXzg4HfnBWcDYWweEm2iYnOFc7tYwHEU+w
	l0Jqr8Atd2ZdBd0tJRg/qoEmsRThonjTiCx6o0dqlDycX4zAepuF1AfnBXtcuEt5/FlbBpqsqW4
	28ZHTm57ntmfSVg==
X-Google-Smtp-Source: AGHT+IGSKBgocOUrtaAqlWpo7xB9zWo7VctwaUUkeBowZ2KVlszhOWetSSOWFNonFY7UBk6VKrZ0qXZECLzAbg==
X-Received: from qvc16.prod.google.com ([2002:a05:6214:8110:b0:6fb:1c61:2409])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:d83:b0:6fd:3a71:cf5c with SMTP id 6a1803df08f44-70002247789mr166262946d6.24.1751285991747;
 Mon, 30 Jun 2025 05:19:51 -0700 (PDT)
Date: Mon, 30 Jun 2025 12:19:34 +0000
In-Reply-To: <20250630121934.3399505-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250630121934.3399505-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250630121934.3399505-11-edumazet@google.com>
Subject: [PATCH v2 net-next 10/10] ipv6: ip6_mc_input() and ip6_mr_input() cleanups
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Both functions are always called under RCU.

We remove the extra rcu_read_lock()/rcu_read_unlock().

We use skb_dst_dev_net_rcu() instead of skb_dst_dev_net().

We use dev_net_rcu() instead of dev_net().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
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


