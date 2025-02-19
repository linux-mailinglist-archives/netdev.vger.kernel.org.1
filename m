Return-Path: <netdev+bounces-167750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6EDA3C0C3
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 14:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA0E189BE8D
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 13:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1512F1F3B90;
	Wed, 19 Feb 2025 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsI0BAey"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50B91EB197
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973094; cv=none; b=hV52f447XWbJUlwUM99Gpst05Kj1yiXyAmUCqELEqzM9zgYqKTZaSB6LtsLQUEqX3l62IAEPCLMIJ1koLwhR+vMpr0axKsemeJJw0jIKuBldGAT6On8WLX9lmUtdidSaFbt3MFQ65Fnz/ihYMq70d/i6cZY0HLDZtydgRUa7Vtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973094; c=relaxed/simple;
	bh=q4RMNvSfTnZ1+TXamaeS+NETraCQhZ3WH9XgtFNe0e4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HmuuUfwTCvZidJvbrdW802OQPupNWFp6gcESM71cRuevvz2F2nDVKkLJLv6l4IlHsLEoftjZGObz4G1HyRxujsFJ7tNgSTlTmb8zk25H0oOK7Q3xp+Bt/iWLR7ReFFgNZNLJsQ2FtsQ82H4OWzANu+eaBgPjSCTHm0z/BVQPDDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsI0BAey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45C9C4CED1;
	Wed, 19 Feb 2025 13:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739973093;
	bh=q4RMNvSfTnZ1+TXamaeS+NETraCQhZ3WH9XgtFNe0e4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EsI0BAeyZsY0n/+DQo+dNIKRHwMUxHUU9+iS5fTH8LCub4i33RMIQHYtbY33SXIVX
	 i9kcVTvT2i77zRpKWp874zDcI5qwB/vSLYOXNjHCcvEBsxHqM/NQzvwN4UEtLETn2A
	 Fj5rNnOXppqgj33UMA/gc1eLc8++qyCLRQ65lJlKcAvadlL2yS8VtXwvCAcPIXNNDf
	 l9R6KYm+KqpApzWPBQGrc+ympiE1x+uqSxbJIg9SuwJvnniAvctGdmN2/cX3725ycs
	 /BMmooZUxljNWDuq5vmSaJDEvwZCwZGwpmzJtgy+fkovv0w1jKZRnc/fAh3DqFy9od
	 MAro2hlE29C4Q==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH ipsec-next v1 5/5] xfrm: check for PMTU in tunnel mode for packet offload
Date: Wed, 19 Feb 2025 15:51:01 +0200
Message-ID: <563626dcde6e41635d67f856687c5ec9c1261795.1739972570.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739972570.git.leon@kernel.org>
References: <cover.1739972570.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

In tunnel mode, for the packet offload, there were no PMTU signaling
to the upper level about need to fragment the packet. As a solution,
call to already existing xfrm[4|6]_tunnel_check_size() to perform that.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 include/net/xfrm.h     |  9 +++++++++
 net/xfrm/xfrm_device.c | 10 ++++++++--
 net/xfrm/xfrm_output.c |  6 ++++--
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 15997374a594..39365fd2ea17 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1781,6 +1781,15 @@ int xfrm_trans_queue(struct sk_buff *skb,
 				   struct sk_buff *));
 int xfrm_output_resume(struct sock *sk, struct sk_buff *skb, int err);
 int xfrm_output(struct sock *sk, struct sk_buff *skb);
+int xfrm4_tunnel_check_size(struct sk_buff *skb);
+#if IS_ENABLED(CONFIG_IPV6)
+int xfrm6_tunnel_check_size(struct sk_buff *skb);
+#else
+static inline int xfrm6_tunnel_check_size(struct sk_buff *skb)
+{
+	return -EMSGSIZE;
+}
+#endif
 
 #if IS_ENABLED(CONFIG_NET_PKTGEN)
 int pktgen_xfrm_outer_mode_output(struct xfrm_state *x, struct sk_buff *skb);
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index f9d985ef30f2..d62f76161d83 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -418,12 +418,12 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 	struct dst_entry *dst = skb_dst(skb);
 	struct xfrm_dst *xdst = (struct xfrm_dst *)dst;
 	struct net_device *dev = x->xso.dev;
+	bool check_tunnel_size;
 
 	if (x->xso.type == XFRM_DEV_OFFLOAD_UNSPECIFIED)
 		return false;
 
-	if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET ||
-	    ((dev == xfrm_dst_path(dst)->dev) && !xdst->child->xfrm)) {
+	if ((dev == xfrm_dst_path(dst)->dev) && !xdst->child->xfrm) {
 		mtu = xfrm_state_mtu(x, xdst->child_mtu_cached);
 		if (skb->len <= mtu)
 			goto ok;
@@ -435,16 +435,22 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
 	return false;
 
 ok:
+	check_tunnel_size = x->xso.type == XFRM_DEV_OFFLOAD_PACKET &&
+			    x->props.mode == XFRM_MODE_TUNNEL;
 	switch (x->props.family) {
 	case AF_INET:
 		/* Check for IPv4 options */
 		if (ip_hdr(skb)->ihl != 5)
 			return false;
+		if (check_tunnel_size && xfrm4_tunnel_check_size(skb))
+			return false;
 		break;
 	case AF_INET6:
 		/* Check for IPv6 extensions */
 		if (ipv6_ext_hdr(ipv6_hdr(skb)->nexthdr))
 			return false;
+		if (check_tunnel_size && xfrm6_tunnel_check_size(skb))
+			return false;
 		break;
 	default:
 		break;
diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index f7abd42c077d..34c8e266641c 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -786,7 +786,7 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(xfrm_output);
 
-static int xfrm4_tunnel_check_size(struct sk_buff *skb)
+int xfrm4_tunnel_check_size(struct sk_buff *skb)
 {
 	int mtu, ret = 0;
 
@@ -812,6 +812,7 @@ static int xfrm4_tunnel_check_size(struct sk_buff *skb)
 out:
 	return ret;
 }
+EXPORT_SYMBOL_GPL(xfrm4_tunnel_check_size);
 
 static int xfrm4_extract_output(struct xfrm_state *x, struct sk_buff *skb)
 {
@@ -834,7 +835,7 @@ static int xfrm4_extract_output(struct xfrm_state *x, struct sk_buff *skb)
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
-static int xfrm6_tunnel_check_size(struct sk_buff *skb)
+int xfrm6_tunnel_check_size(struct sk_buff *skb)
 {
 	int mtu, ret = 0;
 	struct dst_entry *dst = skb_dst(skb);
@@ -864,6 +865,7 @@ static int xfrm6_tunnel_check_size(struct sk_buff *skb)
 out:
 	return ret;
 }
+EXPORT_SYMBOL_GPL(xfrm6_tunnel_check_size);
 #endif
 
 static int xfrm6_extract_output(struct xfrm_state *x, struct sk_buff *skb)
-- 
2.48.1


