Return-Path: <netdev+bounces-162120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15572A25CE3
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A731887718
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5749221323E;
	Mon,  3 Feb 2025 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="32fV2SOP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C61212F94
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 14:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593071; cv=none; b=SSIEzVYYcj2vkFA84PWMFnFK6+za0bF/SM5/n9Fwwzmjo0T+twFNQBwP2zmqfqBVGk2VDLwuUofi8Z0ZtDIOjTH1N9HPSWOvhU4aPysf9g7saaZKkfCCp5EScM+n8SsWnLi8ra6sxvry5tf9wkqYGmpRyuyc7UgILZfpuTfV6+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593071; c=relaxed/simple;
	bh=bCrUEuXphnjaajetK5d7E+Vl/pwtSltcGVcBJpV2W7s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P3j6H3seM7g9O8TeMyFbphCKYDLD92ljcWYrk9l36tL4+xE7mwj1NmQSM+RPJeOkOFafI9FZS4NAzglWR/SpAb305LYsamEimGgLIaLlS4KAQxvIexhEtsQH6sL6WKc859p5koA8hMgaYIsOPvQbNL0reOpVd4SgWSubGFv/8vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=32fV2SOP; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6d8f8b9d43aso80312486d6.0
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 06:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738593068; x=1739197868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FdwFRR960fzI8SNxNneTg6AR0rewjjfndjH2F50AsxA=;
        b=32fV2SOPQiqotO862ZoOE6qY40kw7nA/f6Ur6XqOXf08PJUUikFaH0OrJUjUR6qPIm
         Tn1Yo8RU9HXn1ydFTsmGGnCJeUQ4iDQONJrFtiCTiv6xAVjtPExcAOq48FFRqVkQhrUg
         k1DijDiGmgmxWvs/BbvdblJf+9ndoPh6mQOgILjZJ4dYclqZYx6DaBQwjRDD5T/9A9nS
         svNwhlSykowhKehFQsuvBQPW9gnnZBO1zaUlZamm9su5ujW2oqNGQTOyEZbAYuhjryfu
         taJDG06kf+yRvxZm/7kDR2dICeTluFK42iibH6HI/dSbVb1jHJa7/EYP4aQt5afGeYeV
         1R5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738593068; x=1739197868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FdwFRR960fzI8SNxNneTg6AR0rewjjfndjH2F50AsxA=;
        b=OJeMNZtKnd7kiCrMjwlBAvaB1UBj9qWxhfKzMcbJngpniLtWhL6x7j64XW63mauKGl
         m6H6kUMl5uaEle1/pq4/CMdqZeho92+Cf2up34Kx95jdsxlfRcxPrCevpgoHcSq99Kef
         FwkHZ7MIrmiflWZgxY1qAJlOgaBaw+aWj5qt3/RDRoLw83l4fxZ3bcJt+AZPYCRg3wsf
         4XmgJQsqo83OmZZuNM/mGb8++ei7XQsksLUrIb/BrafS0XsSlVoPDZNMlcnGaPwea+qE
         BJEM07GTFNDCvpp7lScaw4kCAN/FcLdYTlA4YM0aHIZNDNTkcU/Ub/XIYupue7I8AsD+
         HHEg==
X-Gm-Message-State: AOJu0Yx8/rPe1qzoli8fQMlk6OEY9gLLvpffvukaH/jp3xN7sqEUaMXq
	cXPfr5e7AYvZuEp3XDrhjGlbNlSWKhft6DEAx03sQmiBqHw1NoXW+Byj71TSmvdheO0AJj/FWzj
	h8cVStAUevw==
X-Google-Smtp-Source: AGHT+IE5ZhpgsXUG4yVzeJPJ96POBJ0bLZqZaR/4U13cO5Q1WO6T0KUOJ8dID27oBtqg0gaK+KdzGOCBtsnlIw==
X-Received: from qvbkf3.prod.google.com ([2002:a05:6214:5243:b0:6e2:4dfe:895d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:3285:b0:6e1:a078:f40f with SMTP id 6a1803df08f44-6e243c7a9e7mr284058316d6.44.1738593068399;
 Mon, 03 Feb 2025 06:31:08 -0800 (PST)
Date: Mon,  3 Feb 2025 14:30:44 +0000
In-Reply-To: <20250203143046.3029343-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250203143046.3029343-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250203143046.3029343-15-edumazet@google.com>
Subject: [PATCH v2 net 14/16] net: filter: convert to dev_net_rcu()
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
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
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


