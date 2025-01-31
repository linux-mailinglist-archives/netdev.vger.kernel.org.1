Return-Path: <netdev+bounces-161805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A68A241AF
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 18:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D64167060
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 17:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA841F2C25;
	Fri, 31 Jan 2025 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PLS+YlMO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9561F2390
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738343642; cv=none; b=UXFzuByfLAKAaTTxrhxYoN7QdxwSEvnN41HopHxBwqcV0BQTf9rPjUHmo2KeDJPBRMSt4w6rvq3TQbTFM82FP96PBWmQ1DCbR7zHX9earf8xekOzi7oo4QxpEv7U/eko1zU5rUg4vL62N2UMhhUcSEXzNfr9j9DdnGOKi62hEoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738343642; c=relaxed/simple;
	bh=vB1tcCBfi6QS2jhS7Otwrdnw2ozc1kTc/2lNYJtWrj8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SS8cmSdkgJtXdOjmOS5U5ai1gLkihbzr9FI1Hndik7L2GZE66MnFy9v8Xw0PN3jbu607ls69x1spawbO2m0aAOcWgRZHs1BXP/XY8Av9Uj6hghlRaJK3rub3XIhFNNSu1krP0csy8CpodiQtfK8YwATI6l1fQUKPsy+pKSb/sWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PLS+YlMO; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-46dd46d759eso38084701cf.2
        for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 09:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738343639; x=1738948439; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LMYGwiaH4MNc/5hPheSk1j/6B+0JYlfvn+NzQmGNcXc=;
        b=PLS+YlMOzzP8PMYI+zHoOyc+xrLs2YLdqa6oGJYGbIcQJMLhBC91+sIkatvt1CL/+x
         qUZ0JUnIMEptGQFBEjrqxyqnllln+vyGCNk7MQeAcDyg4dp5KKdSBjTH+NQ+RNKVFPpt
         HC/EcTBeawEsAOBdmjoH14Y6quaK2Hb/cvxDi7S5efSyestQOPriQPu8hGZ2wrJXEWMa
         dABpe0kZ1yU8u04mFpyljDicpXek0+WwCn8gwDOWlKKB8ik37gZUJzxBs7jntPdx0ROD
         67840288Q0hvz1JDyvXLHnaqSAwXhW4USj8S49r08WUAhGh7OM2fZvaHi7pEPmkeg7y8
         UIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738343639; x=1738948439;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LMYGwiaH4MNc/5hPheSk1j/6B+0JYlfvn+NzQmGNcXc=;
        b=qWvVmaOR7h8Sr+Lep4iZA+CTC2CxIB4MtzdZ1no51Zk6UNCKOK1MWO7Os2yWQpwntp
         kZLrvNj3wrFOaSbEobC2eLhQh8rekHWpp328NiHatN+QmS3Fhqj3Tnaj3XePg+84fVcG
         M0VG2XW24TRAzwuMC1PO6dA8CvMwLLuWjSCzrd4c4A0P3SHsFN8DJET0DYorzw1wdn0t
         HF3+mDBoEgVKwJYM87gjYSAFYro/BEzIE4alWvmrkyrKmMZG11iJf+LmZN+Viz8dA5vL
         Xp2Sf2wLeqFpWgjMTqMI7Ik92jM0Kzdafn9DZQAGRif1AGKDoBPDsmGp7mcSmPD9psg1
         Wg6Q==
X-Gm-Message-State: AOJu0Yx12qbPwObnKT5+gLcMoUUzWfEMC2IyIy4QhHnLRVyEQu5quGTm
	1dnWCanBFJRKhoHIb7YbsZu24MXc1xfHj1mIJF+ne7BqyTCnXdVswVJsS/2a5RYyBRiNdEIkiYK
	/DYlo2zjzyA==
X-Google-Smtp-Source: AGHT+IEbizUkcAuCGTDTIhoLQGhaq/mgv3mgNFv3LP8mZ1cYzF9dLHd58Qc2s1GONcmrUdiU+AYa6ovXYvq92A==
X-Received: from qtbfg5.prod.google.com ([2002:a05:622a:5805:b0:467:6ece:2e03])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:57ce:0:b0:467:6b96:dc5a with SMTP id d75a77b69052e-46fd0bcc544mr197993351cf.47.1738343639399;
 Fri, 31 Jan 2025 09:13:59 -0800 (PST)
Date: Fri, 31 Jan 2025 17:13:32 +0000
In-Reply-To: <20250131171334.1172661-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250131171334.1172661-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250131171334.1172661-15-edumazet@google.com>
Subject: [PATCH net 14/16] net: filter: convert to dev_net_rcu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

All calls to dev_net() from net/core/filter.c are currently
done under rcu_read_lock().

Convert them to dev_net_rcu() to ensure LOCKDEP support.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/filter.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 2ec162dd83c463640dcf3c151327206f519b217a..4db537a982d55fa9b42aaa70820cb337d5283299 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2244,7 +2244,7 @@ static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 				   struct bpf_nh_params *nh)
 {
 	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
-	struct net *net = dev_net(dev);
+	struct net *net = dev_net_rcu(dev);
 	int err, ret = NET_XMIT_DROP;
 
 	if (!nh) {
@@ -2348,7 +2348,7 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 				   struct bpf_nh_params *nh)
 {
 	const struct iphdr *ip4h = ip_hdr(skb);
-	struct net *net = dev_net(dev);
+	struct net *net = dev_net_rcu(dev);
 	int err, ret = NET_XMIT_DROP;
 
 	if (!nh) {
@@ -2438,7 +2438,7 @@ BPF_CALL_3(bpf_clone_redirect, struct sk_buff *, skb, u32, ifindex, u64, flags)
 	if (unlikely(flags & (~(BPF_F_INGRESS) | BPF_F_REDIRECT_INTERNAL)))
 		return -EINVAL;
 
-	dev = dev_get_by_index_rcu(dev_net(skb->dev), ifindex);
+	dev = dev_get_by_index_rcu(dev_net_rcu(skb->dev), ifindex);
 	if (unlikely(!dev))
 		return -EINVAL;
 
@@ -2482,7 +2482,7 @@ static struct net_device *skb_get_peer_dev(struct net_device *dev)
 int skb_do_redirect(struct sk_buff *skb)
 {
 	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	struct net_device *dev;
 	u32 flags = ri->flags;
 
@@ -2497,7 +2497,7 @@ int skb_do_redirect(struct sk_buff *skb)
 		dev = skb_get_peer_dev(dev);
 		if (unlikely(!dev ||
 			     !(dev->flags & IFF_UP) ||
-			     net_eq(net, dev_net(dev))))
+			     net_eq(net, dev_net_rcu(dev))))
 			goto out_drop;
 		skb->dev = dev;
 		dev_sw_netstats_rx_add(dev, skb->len);
@@ -4425,7 +4425,7 @@ __xdp_do_redirect_frame(struct bpf_redirect_info *ri, struct net_device *dev,
 		break;
 	case BPF_MAP_TYPE_UNSPEC:
 		if (map_id == INT_MAX) {
-			fwd = dev_get_by_index_rcu(dev_net(dev), ri->tgt_index);
+			fwd = dev_get_by_index_rcu(dev_net_rcu(dev), ri->tgt_index);
 			if (unlikely(!fwd)) {
 				err = -EINVAL;
 				break;
@@ -4550,7 +4550,7 @@ int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
 	ri->map_type = BPF_MAP_TYPE_UNSPEC;
 
 	if (map_type == BPF_MAP_TYPE_UNSPEC && map_id == INT_MAX) {
-		fwd = dev_get_by_index_rcu(dev_net(dev), ri->tgt_index);
+		fwd = dev_get_by_index_rcu(dev_net_rcu(dev), ri->tgt_index);
 		if (unlikely(!fwd)) {
 			err = -EINVAL;
 			goto err;
@@ -6203,12 +6203,12 @@ BPF_CALL_4(bpf_xdp_fib_lookup, struct xdp_buff *, ctx,
 	switch (params->family) {
 #if IS_ENABLED(CONFIG_INET)
 	case AF_INET:
-		return bpf_ipv4_fib_lookup(dev_net(ctx->rxq->dev), params,
+		return bpf_ipv4_fib_lookup(dev_net_rcu(ctx->rxq->dev), params,
 					   flags, true);
 #endif
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
-		return bpf_ipv6_fib_lookup(dev_net(ctx->rxq->dev), params,
+		return bpf_ipv6_fib_lookup(dev_net_rcu(ctx->rxq->dev), params,
 					   flags, true);
 #endif
 	}
@@ -6228,7 +6228,7 @@ static const struct bpf_func_proto bpf_xdp_fib_lookup_proto = {
 BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
 	   struct bpf_fib_lookup *, params, int, plen, u32, flags)
 {
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	int rc = -EAFNOSUPPORT;
 	bool check_mtu = false;
 
@@ -6283,7 +6283,7 @@ static const struct bpf_func_proto bpf_skb_fib_lookup_proto = {
 static struct net_device *__dev_via_ifindex(struct net_device *dev_curr,
 					    u32 ifindex)
 {
-	struct net *netns = dev_net(dev_curr);
+	struct net *netns = dev_net_rcu(dev_curr);
 
 	/* Non-redirect use-cases can use ifindex=0 and save ifindex lookup */
 	if (ifindex == 0)
@@ -6806,7 +6806,7 @@ bpf_skc_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 	int ifindex;
 
 	if (skb->dev) {
-		caller_net = dev_net(skb->dev);
+		caller_net = dev_net_rcu(skb->dev);
 		ifindex = skb->dev->ifindex;
 	} else {
 		caller_net = sock_net(skb->sk);
@@ -6906,7 +6906,7 @@ BPF_CALL_5(bpf_tc_skc_lookup_tcp, struct sk_buff *, skb,
 {
 	struct net_device *dev = skb->dev;
 	int ifindex = dev->ifindex, sdif = dev_sdif(dev);
-	struct net *caller_net = dev_net(dev);
+	struct net *caller_net = dev_net_rcu(dev);
 
 	return (unsigned long)__bpf_skc_lookup(skb, tuple, len, caller_net,
 					       ifindex, IPPROTO_TCP, netns_id,
@@ -6930,7 +6930,7 @@ BPF_CALL_5(bpf_tc_sk_lookup_tcp, struct sk_buff *, skb,
 {
 	struct net_device *dev = skb->dev;
 	int ifindex = dev->ifindex, sdif = dev_sdif(dev);
-	struct net *caller_net = dev_net(dev);
+	struct net *caller_net = dev_net_rcu(dev);
 
 	return (unsigned long)__bpf_sk_lookup(skb, tuple, len, caller_net,
 					      ifindex, IPPROTO_TCP, netns_id,
@@ -6954,7 +6954,7 @@ BPF_CALL_5(bpf_tc_sk_lookup_udp, struct sk_buff *, skb,
 {
 	struct net_device *dev = skb->dev;
 	int ifindex = dev->ifindex, sdif = dev_sdif(dev);
-	struct net *caller_net = dev_net(dev);
+	struct net *caller_net = dev_net_rcu(dev);
 
 	return (unsigned long)__bpf_sk_lookup(skb, tuple, len, caller_net,
 					      ifindex, IPPROTO_UDP, netns_id,
@@ -6992,7 +6992,7 @@ BPF_CALL_5(bpf_xdp_sk_lookup_udp, struct xdp_buff *, ctx,
 {
 	struct net_device *dev = ctx->rxq->dev;
 	int ifindex = dev->ifindex, sdif = dev_sdif(dev);
-	struct net *caller_net = dev_net(dev);
+	struct net *caller_net = dev_net_rcu(dev);
 
 	return (unsigned long)__bpf_sk_lookup(NULL, tuple, len, caller_net,
 					      ifindex, IPPROTO_UDP, netns_id,
@@ -7016,7 +7016,7 @@ BPF_CALL_5(bpf_xdp_skc_lookup_tcp, struct xdp_buff *, ctx,
 {
 	struct net_device *dev = ctx->rxq->dev;
 	int ifindex = dev->ifindex, sdif = dev_sdif(dev);
-	struct net *caller_net = dev_net(dev);
+	struct net *caller_net = dev_net_rcu(dev);
 
 	return (unsigned long)__bpf_skc_lookup(NULL, tuple, len, caller_net,
 					       ifindex, IPPROTO_TCP, netns_id,
@@ -7040,7 +7040,7 @@ BPF_CALL_5(bpf_xdp_sk_lookup_tcp, struct xdp_buff *, ctx,
 {
 	struct net_device *dev = ctx->rxq->dev;
 	int ifindex = dev->ifindex, sdif = dev_sdif(dev);
-	struct net *caller_net = dev_net(dev);
+	struct net *caller_net = dev_net_rcu(dev);
 
 	return (unsigned long)__bpf_sk_lookup(NULL, tuple, len, caller_net,
 					      ifindex, IPPROTO_TCP, netns_id,
@@ -7510,7 +7510,7 @@ BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, struct sock *, sk, u64, flags)
 		return -EINVAL;
 	if (!skb_at_tc_ingress(skb))
 		return -EOPNOTSUPP;
-	if (unlikely(dev_net(skb->dev) != sock_net(sk)))
+	if (unlikely(dev_net_rcu(skb->dev) != sock_net(sk)))
 		return -ENETUNREACH;
 	if (sk_unhashed(sk))
 		return -EOPNOTSUPP;
@@ -11985,7 +11985,7 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
 	if (!skb_at_tc_ingress(skb))
 		return -EINVAL;
 
-	net = dev_net(skb->dev);
+	net = dev_net_rcu(skb->dev);
 	if (net != sock_net(sk))
 		return -ENETUNREACH;
 
-- 
2.48.1.362.g079036d154-goog


