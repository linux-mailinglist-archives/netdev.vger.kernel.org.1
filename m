Return-Path: <netdev+bounces-161802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C65A241AD
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 18:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E9C3AA054
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 17:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB01F1F2364;
	Fri, 31 Jan 2025 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BhAXfEh7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6D81C4A24
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738343637; cv=none; b=k5ExwG80M959hPGj1LcpyVxKqZLY224901AZ7bGy8QigJEbtrRhvvukdM+pYekcM9kGohCT0On5+ovlGsDGijGOQLTpddy2fulNFGOzYgtiSvB6IsmnxWjSImrLv7C/+jPMvqHG0hty1HfhMvkXAq0Xyfnwtfbt4LhvwdIw9O7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738343637; c=relaxed/simple;
	bh=S4kgQ8BdXq/TdAZ7H6He9G8UV/L3A5YOQeh4Jaak8Fc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KNfhHcy6srNdImbrjY9xayX5dInDexfdSsnWOU1Fp4S25NY5gS5mDLwY0JR/LSNALmPxfILdk9eYlhwBBPRxElKYa5JgFJ/LWD95F0liJuvgabPDmTOrKQZOIbyBvPQp7BVTdJiGzv3zbc+8WD9dKDITGesCkVGCGDOf9kJfCI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BhAXfEh7; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-467905ab1bbso64301661cf.1
        for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 09:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738343635; x=1738948435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eFHQV76ZnLVC/qjDKSlypzkf4Zt/+CO4gQ4lH7s0JB8=;
        b=BhAXfEh7aUgeHF6DLST7esVwob3lZC4afJz7xVBj2iEeBHwcvMhXx+XH2tgK4ClJtd
         EnUTtqfktnu9nMjnPGVU+hFodLzMCXS12KnIDgjHUd9Ta7NXXtWK0Rjk5mvMNT3CXyJD
         bWGDkvvYKdYEoEblO3U1Dl+V11q+b6Z7DfCfooDkIx2Gv1fo0WmgkfArJ8jtU/HDxA57
         PcKWac9uF0JZrxN54sgyf3aWMBf2hNyvoE4K6KdulTFndwHKht5jur/soeVGBv57oUaB
         /IFnG8QVguB92o1+Kh1+IesZaKGBmbjy/BF4YUN2lV/K8CiVi9btrWDgUeNFNxcWGIsy
         BGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738343635; x=1738948435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eFHQV76ZnLVC/qjDKSlypzkf4Zt/+CO4gQ4lH7s0JB8=;
        b=owmDrX9BVZtgJAFXRrGX4pvhCqnX4cqIGBrpKPoVmuw3c1+ayk2fjyMuV+14chvEmT
         DiBJujawYTcwBxPplEbvWnb3pRaUW/h5A7T99YsVy635yxoL8TU41NeBWkfpVvyyuy8q
         d9bMyDkGmEk2NUhqHIwoW5p9HUhxfwZkjsCnJ8mwe/faQWKEVX6L3LnUegn2y1ESZt3y
         YgvQFU2ig/r2r/jVRqZfKuW+QsS5MQ03qsF5LG9q8jajU9U+H/owR5DpiiZIKAAoscmG
         YdyAd8EhP7GEzACXsRgvNnL16IS4arNY9nQaZi9W0bPzWoOmzOGAI+InCloded/eodYO
         q8+A==
X-Gm-Message-State: AOJu0YxMF9js+qQ0SZwbY5LtqAhHao3OqzXCP5CXyFXHSY2vjpIGVpwg
	W7nUZXvzquT9DCgs31LYxHqQNAEjngrS/hrBcvJosaSp747cKfSrBotYmBDHLWjbG7UpcATyWfj
	3A72neTutfw==
X-Google-Smtp-Source: AGHT+IG8lPVOnnpSVtUE3lPuTQjrJYATDmcTF/Dgy1jKxY2iVklpAsD7Yae/HAi/V0c/9lBIPEe4C+VHC9UyCA==
X-Received: from qtbbb14.prod.google.com ([2002:a05:622a:1b0e:b0:46b:1ac5:905c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7e82:0:b0:462:c14f:d13f with SMTP id d75a77b69052e-46fd0b6e2aamr183710251cf.41.1738343634999;
 Fri, 31 Jan 2025 09:13:54 -0800 (PST)
Date: Fri, 31 Jan 2025 17:13:29 +0000
In-Reply-To: <20250131171334.1172661-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250131171334.1172661-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250131171334.1172661-12-edumazet@google.com>
Subject: [PATCH net 11/16] ipv6: input: convert to dev_net_rcu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dev_net() calls from net/ipv6/ip6_input.c seem to
happen under RCU protection.

Convert them to dev_net_rcu() to ensure LOCKDEP support.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_input.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 70c0e16c0ae6837d1c64d0036829c8b61799578b..4030527ebe098e86764f37c9068d2f2f9af2d183 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -301,7 +301,7 @@ static struct sk_buff *ip6_rcv_core(struct sk_buff *skb, struct net_device *dev,
 
 int ipv6_rcv(struct sk_buff *skb, struct net_device *dev, struct packet_type *pt, struct net_device *orig_dev)
 {
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 
 	skb = ip6_rcv_core(skb, dev, net);
 	if (skb == NULL)
@@ -330,7 +330,7 @@ void ipv6_list_rcv(struct list_head *head, struct packet_type *pt,
 
 	list_for_each_entry_safe(skb, next, head, list) {
 		struct net_device *dev = skb->dev;
-		struct net *net = dev_net(dev);
+		struct net *net = dev_net_rcu(dev);
 
 		skb_list_del_init(skb);
 		skb = ip6_rcv_core(skb, dev, net);
@@ -488,7 +488,7 @@ static int ip6_input_finish(struct net *net, struct sock *sk, struct sk_buff *sk
 int ip6_input(struct sk_buff *skb)
 {
 	return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_IN,
-		       dev_net(skb->dev), NULL, skb, skb->dev, NULL,
+		       dev_net_rcu(skb->dev), NULL, skb, skb->dev, NULL,
 		       ip6_input_finish);
 }
 EXPORT_SYMBOL_GPL(ip6_input);
@@ -500,14 +500,14 @@ int ip6_mc_input(struct sk_buff *skb)
 	struct net_device *dev;
 	bool deliver;
 
-	__IP6_UPD_PO_STATS(dev_net(skb_dst(skb)->dev),
+	__IP6_UPD_PO_STATS(dev_net_rcu(skb_dst(skb)->dev),
 			 __in6_dev_get_safely(skb->dev), IPSTATS_MIB_INMCAST,
 			 skb->len);
 
 	/* skb->dev passed may be master dev for vrfs. */
 	if (sdif) {
 		rcu_read_lock();
-		dev = dev_get_by_index_rcu(dev_net(skb->dev), sdif);
+		dev = dev_get_by_index_rcu(dev_net_rcu(skb->dev), sdif);
 		if (!dev) {
 			rcu_read_unlock();
 			kfree_skb(skb);
@@ -526,7 +526,7 @@ int ip6_mc_input(struct sk_buff *skb)
 	/*
 	 *      IPv6 multicast router mode is now supported ;)
 	 */
-	if (atomic_read(&dev_net(skb->dev)->ipv6.devconf_all->mc_forwarding) &&
+	if (atomic_read(&dev_net_rcu(skb->dev)->ipv6.devconf_all->mc_forwarding) &&
 	    !(ipv6_addr_type(&hdr->daddr) &
 	      (IPV6_ADDR_LOOPBACK|IPV6_ADDR_LINKLOCAL)) &&
 	    likely(!(IP6CB(skb)->flags & IP6SKB_FORWARDED))) {
-- 
2.48.1.362.g079036d154-goog


