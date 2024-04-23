Return-Path: <netdev+bounces-90696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5354E8AFBEC
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 00:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52791F22A58
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 22:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BD34597F;
	Tue, 23 Apr 2024 22:39:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CB041C93
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713911981; cv=none; b=pDU07Rwyhv5C4kG0BlhLznK87wF6tYeWHTti6eaaGx6bQDm/qRfkKzheN2L+TUY9/2q/39SHMSUjgbAs+o2mfR7yu1WJpICi0Mow9V/Jsu+eL3mGKCg13JENS0h2wYmHYj8Jglen1UFsPeEBpabxfFx+Z51nmVexEXZUu4WvLvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713911981; c=relaxed/simple;
	bh=RMbYJ4l4qHMFfDdeBpA3bb0BGNqAgPcOTxzSWpAjhO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ad9yrFMKQ4ap5v6pUy8FcZQkBnlko/MaTJjAEgqqEVv82VADRheOWrghkU2M+FRi0khXqKTlfwm4EhlMlntoO9+A061nrs0HtD7kBfAslb+6FG0lks9yPb5KeIBgHW95pI42d5xob0ITzvKxGjVG4Xra7J553rXWmY60k0f5T+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	laforge@osmocom.org,
	pespin@sysmocom.de,
	osmith@sysmocom.de
Subject: [PATCH net-next 10/12] gtp: add helper function to build GTP packets from an IPv6 packet
Date: Wed, 24 Apr 2024 00:39:17 +0200
Message-Id: <20240423223919.3385493-11-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240423223919.3385493-1-pablo@netfilter.org>
References: <20240423223919.3385493-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add routine to attach an IPv6 route for the encapsulated packet, deal
with Path MTU and push GTP header.

This helper function will be used to deal with IPv4-in-IPv6-GTP.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 drivers/net/gtp.c | 109 ++++++++++++++++++++++++++--------------------
 1 file changed, 62 insertions(+), 47 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 5d1247eab382..c38dfe6a0673 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1046,6 +1046,63 @@ static int gtp_build_skb_outer_ip4(struct sk_buff *skb, struct net_device *dev,
 	return -EBADMSG;
 }
 
+static int gtp_build_skb_outer_ip6(struct net *net, struct sk_buff *skb,
+				   struct net_device *dev,
+				   struct gtp_pktinfo *pktinfo,
+				   struct pdp_ctx *pctx, __u8 tos)
+{
+	struct dst_entry *dst;
+	struct rt6_info *rt;
+	struct flowi6 fl6;
+	int mtu;
+
+	rt = ip6_route_output_gtp(net, &fl6, pctx->sk, &pctx->peer.addr6,
+				  &inet6_sk(pctx->sk)->saddr);
+	if (IS_ERR(rt)) {
+		netdev_dbg(dev, "no route to SSGN %pI6\n",
+			   &pctx->peer.addr6);
+		dev->stats.tx_carrier_errors++;
+		goto err;
+	}
+	dst = &rt->dst;
+
+	if (rt->dst.dev == dev) {
+		netdev_dbg(dev, "circular route to SSGN %pI6\n",
+			   &pctx->peer.addr6);
+		dev->stats.collisions++;
+		goto err_rt;
+	}
+
+	mtu = dst_mtu(&rt->dst) - dev->hard_header_len -
+		sizeof(struct ipv6hdr) - sizeof(struct udphdr);
+	switch (pctx->gtp_version) {
+	case GTP_V0:
+		mtu -= sizeof(struct gtp0_header);
+		break;
+	case GTP_V1:
+		mtu -= sizeof(struct gtp1_header);
+		break;
+	}
+
+	skb_dst_update_pmtu_no_confirm(skb, mtu);
+
+	if ((!skb_is_gso(skb) && skb->len > mtu) ||
+	    (skb_is_gso(skb) && !skb_gso_validate_network_len(skb, mtu))) {
+		netdev_dbg(dev, "packet too big, fragmentation needed\n");
+		icmpv6_ndo_send(skb, ICMPV6_PKT_TOOBIG, 0, mtu);
+		goto err_rt;
+	}
+
+	gtp_set_pktinfo_ipv6(pktinfo, pctx->sk, tos, pctx, rt, &fl6, dev);
+	gtp_push_header(skb, pktinfo);
+
+	return 0;
+err_rt:
+	dst_release(dst);
+err:
+	return -EBADMSG;
+}
+
 static int gtp_build_skb_ip4(struct sk_buff *skb, struct net_device *dev,
 			     struct gtp_pktinfo *pktinfo)
 {
@@ -1086,13 +1143,10 @@ static int gtp_build_skb_ip6(struct sk_buff *skb, struct net_device *dev,
 {
 	struct gtp_dev *gtp = netdev_priv(dev);
 	struct net *net = gtp->net;
-	struct dst_entry *dst;
 	struct pdp_ctx *pctx;
 	struct ipv6hdr *ip6h;
-	struct rt6_info *rt;
-	struct flowi6 fl6;
 	__u8 tos;
-	int mtu;
+	int ret;
 
 	/* Read the IP destination address and resolve the PDP context.
 	 * Prepend PDP header with TEI/TID from PDP ctx.
@@ -1110,55 +1164,16 @@ static int gtp_build_skb_ip6(struct sk_buff *skb, struct net_device *dev,
 	}
 	netdev_dbg(dev, "found PDP context %p\n", pctx);
 
-	rt = ip6_route_output_gtp(net, &fl6, pctx->sk, &pctx->peer.addr6,
-				  &inet6_sk(pctx->sk)->saddr);
-	if (IS_ERR(rt)) {
-		netdev_dbg(dev, "no route to SSGN %pI6\n",
-			   &pctx->peer.addr6);
-		dev->stats.tx_carrier_errors++;
-		goto err;
-	}
-	dst = &rt->dst;
-
-	if (rt->dst.dev == dev) {
-		netdev_dbg(dev, "circular route to SSGN %pI6\n",
-			   &pctx->peer.addr6);
-		dev->stats.collisions++;
-		goto err_rt;
-	}
-
-	mtu = dst_mtu(&rt->dst) - dev->hard_header_len -
-		sizeof(struct ipv6hdr) - sizeof(struct udphdr);
-	switch (pctx->gtp_version) {
-	case GTP_V0:
-		mtu -= sizeof(struct gtp0_header);
-		break;
-	case GTP_V1:
-		mtu -= sizeof(struct gtp1_header);
-		break;
-	}
-
-	skb_dst_update_pmtu_no_confirm(skb, mtu);
-
-	if ((!skb_is_gso(skb) && skb->len > mtu) ||
-	    (skb_is_gso(skb) && !skb_gso_validate_network_len(skb, mtu))) {
-		netdev_dbg(dev, "packet too big, fragmentation needed\n");
-		icmpv6_ndo_send(skb, ICMPV6_PKT_TOOBIG, 0, mtu);
-		goto err_rt;
-	}
-
 	tos = ipv6_get_dsfield(ip6h);
-	gtp_set_pktinfo_ipv6(pktinfo, pctx->sk, tos, pctx, rt, &fl6, dev);
-	gtp_push_header(skb, pktinfo);
+
+	ret = gtp_build_skb_outer_ip6(net, skb, dev, pktinfo, pctx, tos);
+	if (ret < 0)
+		return ret;
 
 	netdev_dbg(dev, "gtp -> IP src: %pI6 dst: %pI6\n",
 		   &ip6h->saddr, &ip6h->daddr);
 
 	return 0;
-err_rt:
-	dst_release(dst);
-err:
-	return -EBADMSG;
 }
 
 static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
-- 
2.30.2


