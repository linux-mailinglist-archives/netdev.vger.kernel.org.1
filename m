Return-Path: <netdev+bounces-222964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EF3B57498
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 11:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 379C04E1A38
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 09:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2322F49F8;
	Mon, 15 Sep 2025 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8xmGmzx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570282F3C00
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757928005; cv=none; b=YNJnFtnaHmHhvEOi+CXZVHfP7o2HVVFJkb2RBgieLCLQCy9DykV4IOOayaoiZ4wR0xOlkQuDnEgE/wiHaXyjpwach0el4Xr8vT/nnabmQPZ2G0wZhGilFdf1M/IT7loq40hQMRnDhGqCJRhL8kDMFlzdqq3wP1Au1h50+kFudOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757928005; c=relaxed/simple;
	bh=a1P5JscdIzAAuifOJKd79qDY8OKvG7TMF2QxbpjhGs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8ZqgOLcAfFz4u+eyWo8Qngei+NKDCKkTIBqCdPecMqNy2vM1MrKE6PXNDwMDd53K71h2drXmcsw+ag9e0+1rlaJTqeagKEKPCxpRWKyUvic0CQ44AOYSQgiR6qw6J9Qrb7QCSZJzEUBuJEsvA5sbFVcQxKId06N1lGZ5kYKk54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8xmGmzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC72C4CEF1;
	Mon, 15 Sep 2025 09:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757928004;
	bh=a1P5JscdIzAAuifOJKd79qDY8OKvG7TMF2QxbpjhGs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K8xmGmzxnuXNXn45abBr5YKKFtbKE6RGrGuAxkmMZkLYC+GE/dRCqajGj9FPwUrJR
	 NxhC7ZVlECk7pVcchK4uHgjEznTUt1IBxjxMkS71/yXob275HToXd+aVBxGqBxCIt0
	 tEm+odHqV4EWI7apC577dcg2rLZSpkO70zkFgJhQRfx9hoBvcbdXQCQDQvIRj+jBKC
	 S0Ytc8/EinO9IS0X4b3HT5ENld/vDDahyhNbEpBrKnCs1thj/VDjTSxRfoNJNjRxvo
	 9xlG5Zv0qrUFtVPAav+TZN1fMr+ddZlrxPZoCgg6kmq5qCtVyKuWdbHQWCaGH1FNaQ
	 lCOYfZa2A7iWQ==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 1/3] net: ipv4: make udp_v4_early_demux explicitly return drop reason
Date: Mon, 15 Sep 2025 11:19:54 +0200
Message-ID: <20250915091958.15382-2-atenart@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915091958.15382-1-atenart@kernel.org>
References: <20250915091958.15382-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

udp_v4_early_demux already returns drop reasons as it either returns 0
or ip_mc_validate_source, which itself returns drop reasons. Its return
value is also already used as a drop reason itself.

Makes this explicit by making it return drop reasons.

Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 include/net/udp.h   |  2 +-
 net/ipv4/ip_input.c |  2 +-
 net/ipv4/udp.c      | 12 ++++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/net/udp.h b/include/net/udp.h
index 93b159f30e88..c0f579dec091 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -398,7 +398,7 @@ static inline struct sk_buff *skb_recv_udp(struct sock *sk, unsigned int flags,
 	return __skb_recv_udp(sk, flags, &off, err);
 }
 
-int udp_v4_early_demux(struct sk_buff *skb);
+enum skb_drop_reason udp_v4_early_demux(struct sk_buff *skb);
 bool udp_sk_rx_dst_set(struct sock *sk, struct dst_entry *dst);
 int udp_err(struct sk_buff *, u32);
 int udp_abort(struct sock *sk, int err);
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index a09aca2c8567..8878e865ddf6 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -319,7 +319,7 @@ static bool ip_can_use_hint(const struct sk_buff *skb, const struct iphdr *iph,
 }
 
 int tcp_v4_early_demux(struct sk_buff *skb);
-int udp_v4_early_demux(struct sk_buff *skb);
+enum skb_drop_reason udp_v4_early_demux(struct sk_buff *skb);
 static int ip_rcv_finish_core(struct net *net,
 			      struct sk_buff *skb, struct net_device *dev,
 			      const struct sk_buff *hint)
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index cca41c569f37..a8bd42d428fb 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2807,7 +2807,7 @@ static struct sock *__udp4_lib_demux_lookup(struct net *net,
 	return NULL;
 }
 
-int udp_v4_early_demux(struct sk_buff *skb)
+enum skb_drop_reason udp_v4_early_demux(struct sk_buff *skb)
 {
 	struct net *net = dev_net(skb->dev);
 	struct in_device *in_dev = NULL;
@@ -2821,7 +2821,7 @@ int udp_v4_early_demux(struct sk_buff *skb)
 
 	/* validate the packet */
 	if (!pskb_may_pull(skb, skb_transport_offset(skb) + sizeof(struct udphdr)))
-		return 0;
+		return SKB_NOT_DROPPED_YET;
 
 	iph = ip_hdr(skb);
 	uh = udp_hdr(skb);
@@ -2830,12 +2830,12 @@ int udp_v4_early_demux(struct sk_buff *skb)
 		in_dev = __in_dev_get_rcu(skb->dev);
 
 		if (!in_dev)
-			return 0;
+			return SKB_NOT_DROPPED_YET;
 
 		ours = ip_check_mc_rcu(in_dev, iph->daddr, iph->saddr,
 				       iph->protocol);
 		if (!ours)
-			return 0;
+			return SKB_NOT_DROPPED_YET;
 
 		sk = __udp4_lib_mcast_demux_lookup(net, uh->dest, iph->daddr,
 						   uh->source, iph->saddr,
@@ -2846,7 +2846,7 @@ int udp_v4_early_demux(struct sk_buff *skb)
 	}
 
 	if (!sk)
-		return 0;
+		return SKB_NOT_DROPPED_YET;
 
 	skb->sk = sk;
 	DEBUG_NET_WARN_ON_ONCE(sk_is_refcounted(sk));
@@ -2873,7 +2873,7 @@ int udp_v4_early_demux(struct sk_buff *skb)
 						     ip4h_dscp(iph),
 						     skb->dev, in_dev, &itag);
 	}
-	return 0;
+	return SKB_NOT_DROPPED_YET;
 }
 
 int udp_rcv(struct sk_buff *skb)
-- 
2.51.0


