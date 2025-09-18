Return-Path: <netdev+bounces-224287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DA6B83860
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 10:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AE0717B1D3
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 08:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992B92F4A1F;
	Thu, 18 Sep 2025 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEQWK0lN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C3A2E9EA1
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758184295; cv=none; b=KwF1supWupHw70lp0lKP21un4hYXpc7N5SJJA/Xm6nvhfG/fCd6LZcmzy7wtUwN0NG+9okGGbBOl4wl1YHLM2x++dSHWS1aQCytCkemesLpDv4PDvUrFgPDiNpCIfFY9WUTLvAOKS/Ggm7B/CNGGWPpSP0Ug1th+botmJe2hE60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758184295; c=relaxed/simple;
	bh=vqUkS8Y2cP0yaGzG1xhRUs5Wrwbq5ZuS3Qm6KBWhOBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6NFc/qdHIzNTAB2T/RN1ObRe9gNK2hnyCmTdXK4NLERfkLXU4YbcZ2f1rTAEjohzsZ2DL7kAermjhTrdR2Hd2CIF1ViMwHM2zA4v6AIwSLTPwIyYCRwH70YfN5j+YLenx7JTvs6gAY9uOzyiL5o/L7uJcRmaZbLRl3Btsh2TA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEQWK0lN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7CDC4CEE7;
	Thu, 18 Sep 2025 08:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758184294;
	bh=vqUkS8Y2cP0yaGzG1xhRUs5Wrwbq5ZuS3Qm6KBWhOBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eEQWK0lNL9eC2mGSxA/TE5SfPncUvcFGQYpfvO7j0jdw7tm4MbmGnSdma/ZceRwTD
	 5dC+jkpDPw+L/P23Oj4OpUYrMBwib/HiHAYWz+/Ut25JsH5dcjXEqY1lbYFXOSx00I
	 nYW5tBbp9ohjGM7Dj9xoy3dUxOLBBGRpYppkM25z/Eadyaum03HREwqLL1wP23k2Wm
	 AG+JLo+o6ZGl/Iv4K2gxIHNoH2hpl8LFB7OoebGq8rPsi+4LM7TWn3X+/gaZcTVube
	 3Nfq25U0Rpu7ZBcgmwho7GiDCAdaZIVnHnE/3TdNz6Sb/ynpfxR5oJ6TsH5V+PQ1L8
	 l8Xc8nRpUTW1w==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 1/4] net: ipv4: make udp_v4_early_demux explicitly return drop reason
Date: Thu, 18 Sep 2025 10:31:14 +0200
Message-ID: <20250918083127.41147-2-atenart@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250918083127.41147-1-atenart@kernel.org>
References: <20250918083127.41147-1-atenart@kernel.org>
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

Reviewed-by: David Ahern <dsahern@kernel.org>
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


