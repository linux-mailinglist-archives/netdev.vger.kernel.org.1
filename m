Return-Path: <netdev+bounces-146942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D71549D6D42
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 10:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FC46B20EC9
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 09:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202BB158DC4;
	Sun, 24 Nov 2024 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTd+4zPT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6FD8837;
	Sun, 24 Nov 2024 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732440937; cv=none; b=QQjX3VsKISCVG2D7i7Hp8CgR3rJQzFvShCypKLmV5YOCP7QKoDTXvMdL8eYxRRipQlIhMNTozjAB3GGnpT+FaHnmeB7TXUvmVHGdNJB2Xf7bRnk4DAEgCeqPErHhtPBe0SUw+3SsTuwqINIGYk7GmwKmFZra0a2p9lY19U6COUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732440937; c=relaxed/simple;
	bh=7tOwtFj93SqxzO6xWzYe/3dY+c6msOPIIaqb9P2q0Mk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SVMOm6OQMADfwbgSb0eBK532sNHiYs3M/wtdFA76jTdTdgG1zoBi7wTgseeZmkaSq1lAHYlJhGwp4UkMO57VqW5HTy5FhgmIgik4Pe+tF0om5ORpkUAbJlEGPgxtYSCEd3FY0lLqkX9krev4jF5DMXJn61EjEf4EdhwZyJjfmLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTd+4zPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1499C4CECC;
	Sun, 24 Nov 2024 09:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732440936;
	bh=7tOwtFj93SqxzO6xWzYe/3dY+c6msOPIIaqb9P2q0Mk=;
	h=From:To:Cc:Subject:Date:From;
	b=LTd+4zPTP1GuWN5MNQMw7Y88wWnTWq4F005yO5FzQkZN+zHZiTOk+2Jp+KrBxwGoC
	 kwwSuINWPUYdSq85pORIE1KjGlRY1Kn47+0TAyIcERF5S8CEpPICL3CkXPohT8gJnp
	 jN47KvWcisu/ybJ2N7i1r9uMo+iFHOZiUugtTAtDEMMZVYkq2fp6L9rLiEgaborVAO
	 rQtaFNbVTp9k2ZAwWI0mHBPHBnqRu7YA5QXuDrSXkJdzX6tIwesziD86ZSPRKe0Mgw
	 VnR+EIgTllLVUqtNIEMJtuql/Xck8RMoUjI5k7NP74wTg7oE9n0bI5eX4fCAgvvJYt
	 TBxbHd1U17FDQ==
From: Ilia Lin <ilia.lin@kernel.org>
To: steffen.klassert@secunet.com,
	leonro@nvidia.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] xfrm: Add pre-encap fragmentation for packet offload
Date: Sun, 24 Nov 2024 11:35:31 +0200
Message-Id: <20241124093531.3783434-1-ilia.lin@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In packet offload mode the raw packets will be sent to the NiC,
and will not return to the Network Stack. In event of crossing
the MTU size after the encapsulation, the NiC HW may not be
able to fragment the final packet.
Adding mandatory pre-encapsulation fragmentation for both
IPv4 and IPv6, if tunnel mode with packet offload is configured
on the state.

Signed-off-by: Ilia Lin <ilia.lin@kernel.org>
---
 net/ipv4/xfrm4_output.c | 31 +++++++++++++++++++++++++++++--
 net/ipv6/xfrm6_output.c |  8 ++++++--
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/xfrm4_output.c b/net/ipv4/xfrm4_output.c
index 3cff51ba72bb0..a4271e0dd51bb 100644
--- a/net/ipv4/xfrm4_output.c
+++ b/net/ipv4/xfrm4_output.c
@@ -14,17 +14,44 @@
 #include <net/xfrm.h>
 #include <net/icmp.h>
 
+static int __xfrm4_output_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
+{
+	return xfrm_output(sk, skb);
+}
+
 static int __xfrm4_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-#ifdef CONFIG_NETFILTER
-	struct xfrm_state *x = skb_dst(skb)->xfrm;
+	struct dst_entry *dst = skb_dst(skb);
+	struct xfrm_state *x = dst->xfrm;
+	unsigned int mtu;
+	bool toobig;
 
+#ifdef CONFIG_NETFILTER
 	if (!x) {
 		IPCB(skb)->flags |= IPSKB_REROUTED;
 		return dst_output(net, sk, skb);
 	}
 #endif
 
+	if (x->props.mode != XFRM_MODE_TUNNEL || x->xso.type != XFRM_DEV_OFFLOAD_PACKET)
+		goto skip_frag;
+
+	mtu = xfrm_state_mtu(x, dst_mtu(skb_dst(skb)));
+
+	toobig = skb->len > mtu && !skb_is_gso(skb);
+
+	if (!skb->ignore_df && toobig && skb->sk) {
+		xfrm_local_error(skb, mtu);
+		kfree_skb(skb);
+		return -EMSGSIZE;
+	}
+
+	if (toobig) {
+		IPCB(skb)->frag_max_size = mtu;
+		return ip_do_fragment(net, sk, skb, __xfrm4_output_finish);
+	}
+
+skip_frag:
 	return xfrm_output(sk, skb);
 }
 
diff --git a/net/ipv6/xfrm6_output.c b/net/ipv6/xfrm6_output.c
index 5f7b1fdbffe62..fdd2f2f5adc71 100644
--- a/net/ipv6/xfrm6_output.c
+++ b/net/ipv6/xfrm6_output.c
@@ -75,10 +75,14 @@ static int __xfrm6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	if (x->props.mode != XFRM_MODE_TUNNEL)
 		goto skip_frag;
 
-	if (skb->protocol == htons(ETH_P_IPV6))
+	if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET) {
+		mtu = xfrm_state_mtu(x, dst_mtu(skb_dst(skb)));
+		IP6CB(skb)->frag_max_size = mtu;
+	} else if (skb->protocol == htons(ETH_P_IPV6)) {
 		mtu = ip6_skb_dst_mtu(skb);
-	else
+	} else {
 		mtu = dst_mtu(skb_dst(skb));
+	}
 
 	toobig = skb->len > mtu && !skb_is_gso(skb);
 
-- 
2.25.1


