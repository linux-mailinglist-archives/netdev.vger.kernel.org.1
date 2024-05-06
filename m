Return-Path: <netdev+bounces-93893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6537E8BD850
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 01:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B23C1C22316
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 23:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D483A15E5C9;
	Mon,  6 May 2024 23:53:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D0915E208
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 23:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715039593; cv=none; b=jlQ1SKMUM5vbvlBKaQSyeiEJF8orkl9sj5a3VwGIj2QH6ZLdNCThHmuQvsL02HsZqCiaBzDjM6TyVfP8IoQ/NY63LWK6NVdbNVPH7OWvDCpjCOycWnyQ9ID9JbdF5KvxMV9tGaoL1ryXLoMVX7hpDBj9+nDOWHKGBgVj87zHGEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715039593; c=relaxed/simple;
	bh=t/fYDEwt0Hy6tNkKyZxMDzzYvLq1wx4FfhxA2+6NWsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZcVF+bbISy7lNR9laqU0mOb8YO70QUiZ+ethP73WUBsfFxwwbDMl9+ossaad7fiYCfHzYYAPTuQiDECjd+nljt/IKw4X3n2MG98azsg4TEt32C9OmQt7f3Jh86oEjKIr2O2TZdbqsVrQN2Bc7hMSKMCF5luxJZDsjAKcrnj4C1w=
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
	osmith@sysmocom.de,
	horms@kernel.org
Subject: [PATCH net-next,v3 10/12] gtp: add helper function to build GTP packets from an IPv6 packet
Date: Tue,  7 May 2024 01:52:49 +0200
Message-Id: <20240506235251.3968262-11-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240506235251.3968262-1-pablo@netfilter.org>
References: <20240506235251.3968262-1-pablo@netfilter.org>
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
index 687a0e91a0b2..1995b613a54a 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1047,6 +1047,63 @@ static int gtp_build_skb_outer_ip4(struct sk_buff *skb, struct net_device *dev,
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
@@ -1087,13 +1144,10 @@ static int gtp_build_skb_ip6(struct sk_buff *skb, struct net_device *dev,
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
@@ -1111,55 +1165,16 @@ static int gtp_build_skb_ip6(struct sk_buff *skb, struct net_device *dev,
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


