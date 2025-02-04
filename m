Return-Path: <netdev+bounces-162542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45434A27338
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE76118894B3
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDB221B8E7;
	Tue,  4 Feb 2025 13:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YRV8EIcW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2D721B1A0
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738675466; cv=none; b=e40S5DghbzjI8EgKP8VgFD2m+2MnkkrN2Pk7RDf3XT6LtzUTEG8oR7rY4QVM2uT9pRkZL7GvILkSnPQN/oGANTaq14SQCjH+uLFP72WgWTnWhDrXSXvy7HYZxtEDvRUIi5YUtflp3IxMuxYn/pXpElo5sV3Utx7CQxBY7MBGz0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738675466; c=relaxed/simple;
	bh=bCrUEuXphnjaajetK5d7E+Vl/pwtSltcGVcBJpV2W7s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mex7nE2HgFBhsfpBSzPWbAp+oE5JNAfSTMVQf8qP1lpmqFWeBsS1bqWruG6NVymcMDK8ryH68EJhiHFIOlQa3rUCg7u38Uk+Mk4vpjaOp/gAUr02ubRDfODlWP+jnAqLYVm+dKQr1WrAETMJ2bJV/BYef3a4rOXljJbicGBTePE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YRV8EIcW; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7b6e7f0735aso919294185a.1
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 05:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738675463; x=1739280263; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FdwFRR960fzI8SNxNneTg6AR0rewjjfndjH2F50AsxA=;
        b=YRV8EIcW5xn9ELDofTzKbvNLXcARKt0CP11CT0HK5XfeyH2R/1QdNgybEPIoHhVC2Z
         6KshLLfWVkGq2gqnumoVOCqH/r2dr8LUxXPQsj7CIu4u4Mh/knGajRsXv3PUZHmdWh6b
         olypvHSVsfqjh5nrtqqhgSITSGJcmLVCk0DuANBnS+ioyMt9QxX4VrWg3AFZuqjzwUwY
         mRnribN/VJJxA7REtfBrvRW2yxSuqYCZEjFOTlp3OrNaaJJ3x5S1aA/nRrmDt2pmIJMn
         RpHq2YfAPzA051WSGfiuO+zLGFzFacJCSZRbpqdV31RCweeLCMJuWKVe7wnCXzxJGcoH
         IqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738675463; x=1739280263;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FdwFRR960fzI8SNxNneTg6AR0rewjjfndjH2F50AsxA=;
        b=iN/rNEjlaX+pVp0T8eXRV/ZI8BlV9lsjzSMoK4dpzjA0sqAXWLk9Qpe0IlNlfhSfVA
         UOMuOh2qXFhhphvEDZQ8pG6BpxM7S/fPS1j9gF12+zuSGPZOPEcPe2RlPj40o9DaaS3j
         z0LbU4rgO7lARj8P5W6wHGXTNLjENf8GmP5zaExm7NLQ36zFjmtv+53djP03k6eoJjx/
         IFbqQ037UYTh2ffe+Z0cSsy8l3q4FKagpxu1Td8jOxh5wrSyBKiU0UzXpodb9ChR1XZw
         XTqRcKus3RU143psPF7HatbfcYVDQRu9XfUTZ0wzXaeMY/7+Ncvso11VhqO+qpxMJY6g
         kUtg==
X-Gm-Message-State: AOJu0YyW7QH7yIIbegbYDjKM+sxWjvlkAlvN8AK2C5LBDDS/nHEjD+nz
	85Plkz+99GiMhr5LLKfXplcEplguKR6FM6+cpxihcOr+KywABJ/zs7a0pO7kYVP2y68n/u0Az06
	LLgcvx9NxKg==
X-Google-Smtp-Source: AGHT+IExLUrnxfgueumcyCTYhIo5bxYig5bbEBWGW9zQzxR4RC+62Pg/cLbOcfx9j/sNrawe7W1onmoDELRepQ==
X-Received: from qknpr12.prod.google.com ([2002:a05:620a:86cc:b0:7bc:dee1:94a3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:488f:b0:7b1:7f5b:72c7 with SMTP id af79cd13be357-7bffccc4cc2mr3881290485a.1.1738675463661;
 Tue, 04 Feb 2025 05:24:23 -0800 (PST)
Date: Tue,  4 Feb 2025 13:23:55 +0000
In-Reply-To: <20250204132357.102354-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250204132357.102354-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250204132357.102354-15-edumazet@google.com>
Subject: [PATCH v3 net 14/16] net: filter: convert to dev_net_rcu()
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


