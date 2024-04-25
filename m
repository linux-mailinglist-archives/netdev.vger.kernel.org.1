Return-Path: <netdev+bounces-91270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15A38B1FAC
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 12:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE28B283038
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 10:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D004B381A4;
	Thu, 25 Apr 2024 10:51:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9692C84F
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 10:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714042314; cv=none; b=PGaSKLG9if4GSKgho0yS/2LSSp4ogPkSXQWiH6b/PcEVDFhR3TXc4/m1GTvAuUXkTNbkw2FPqEZNmV9fieEvD5Droc1z6SBoe3eMNN6UrHKPSx4V4BKCkSwKfge4kqYERfZevqpZXjM4LHymyUFS48Mzq2+FhsoiZ/k4y0nOf+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714042314; c=relaxed/simple;
	bh=n+XTY3a+PokhQb2+C/ffa5qswpWHlYcoZZBUGrjQBjw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HG34UMZuqiMQGECr4bTUb5BeQfEl1kWw4yBSaA0jsQfi3fIhMjBoTpKSSTfvn55H4HhNGGMS7Hp9d6u/tz0aQ1AV6/qBScW2uzaSSBxjNDQ/T2RItySnF72afv2Bd/I6r9jE38B44SUf/kJT0gutIr0nx8KIJqHkyPlJzp8gIf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	laforge@osmocom.org,
	pespin@sysmocom.de,
	osmith@sysmocom.de,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net-next 09/12] gtp: add helper function to build GTP packets from an IPv4 packet
Date: Thu, 25 Apr 2024 12:51:35 +0200
Message-Id: <20240425105138.1361098-10-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240425105138.1361098-1-pablo@netfilter.org>
References: <20240425105138.1361098-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add routine to attach an IPv4 route for the encapsulated packet, deal
with Path MTU and push GTP header.

This helper function will be used to deal with IPv6-in-IPv4-GTP.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 drivers/net/gtp.c | 69 ++++++++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 27 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 5e4f3102fffe..3293528bd365 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -983,33 +983,16 @@ static inline void gtp_set_pktinfo_ipv6(struct gtp_pktinfo *pktinfo,
 	pktinfo->dev	= dev;
 }
 
-static int gtp_build_skb_ip4(struct sk_buff *skb, struct net_device *dev,
-			     struct gtp_pktinfo *pktinfo)
+static int gtp_build_skb_outer_ip4(struct sk_buff *skb, struct net_device *dev,
+				   struct gtp_pktinfo *pktinfo,
+				   struct pdp_ctx *pctx, __u8 tos,
+				   __be16 frag_off)
 {
-	struct gtp_dev *gtp = netdev_priv(dev);
-	struct pdp_ctx *pctx;
 	struct rtable *rt;
 	struct flowi4 fl4;
-	struct iphdr *iph;
 	__be16 df;
 	int mtu;
 
-	/* Read the IP destination address and resolve the PDP context.
-	 * Prepend PDP header with TEI/TID from PDP ctx.
-	 */
-	iph = ip_hdr(skb);
-	if (gtp->role == GTP_ROLE_SGSN)
-		pctx = ipv4_pdp_find(gtp, iph->saddr);
-	else
-		pctx = ipv4_pdp_find(gtp, iph->daddr);
-
-	if (!pctx) {
-		netdev_dbg(dev, "no PDP ctx found for %pI4, skip\n",
-			   &iph->daddr);
-		return -ENOENT;
-	}
-	netdev_dbg(dev, "found PDP context %p\n", pctx);
-
 	rt = ip4_route_output_gtp(&fl4, pctx->sk, pctx->peer.addr.s_addr,
 				  inet_sk(pctx->sk)->inet_saddr);
 	if (IS_ERR(rt)) {
@@ -1027,7 +1010,7 @@ static int gtp_build_skb_ip4(struct sk_buff *skb, struct net_device *dev,
 	}
 
 	/* This is similar to tnl_update_pmtu(). */
-	df = iph->frag_off;
+	df = frag_off;
 	if (df) {
 		mtu = dst_mtu(&rt->dst) - dev->hard_header_len -
 			sizeof(struct iphdr) - sizeof(struct udphdr);
@@ -1045,7 +1028,7 @@ static int gtp_build_skb_ip4(struct sk_buff *skb, struct net_device *dev,
 
 	skb_dst_update_pmtu_no_confirm(skb, mtu);
 
-	if (iph->frag_off & htons(IP_DF) &&
+	if (frag_off & htons(IP_DF) &&
 	    ((!skb_is_gso(skb) && skb->len > mtu) ||
 	     (skb_is_gso(skb) && !skb_gso_validate_network_len(skb, mtu)))) {
 		netdev_dbg(dev, "packet too big, fragmentation needed\n");
@@ -1054,12 +1037,9 @@ static int gtp_build_skb_ip4(struct sk_buff *skb, struct net_device *dev,
 		goto err_rt;
 	}
 
-	gtp_set_pktinfo_ipv4(pktinfo, pctx->sk, iph->tos, pctx, rt, &fl4, dev);
+	gtp_set_pktinfo_ipv4(pktinfo, pctx->sk, tos, pctx, rt, &fl4, dev);
 	gtp_push_header(skb, pktinfo);
 
-	netdev_dbg(dev, "gtp -> IP src: %pI4 dst: %pI4\n",
-		   &iph->saddr, &iph->daddr);
-
 	return 0;
 err_rt:
 	ip_rt_put(rt);
@@ -1067,6 +1047,41 @@ static int gtp_build_skb_ip4(struct sk_buff *skb, struct net_device *dev,
 	return -EBADMSG;
 }
 
+static int gtp_build_skb_ip4(struct sk_buff *skb, struct net_device *dev,
+			     struct gtp_pktinfo *pktinfo)
+{
+	struct gtp_dev *gtp = netdev_priv(dev);
+	struct pdp_ctx *pctx;
+	struct iphdr *iph;
+	int ret;
+
+	/* Read the IP destination address and resolve the PDP context.
+	 * Prepend PDP header with TEI/TID from PDP ctx.
+	 */
+	iph = ip_hdr(skb);
+	if (gtp->role == GTP_ROLE_SGSN)
+		pctx = ipv4_pdp_find(gtp, iph->saddr);
+	else
+		pctx = ipv4_pdp_find(gtp, iph->daddr);
+
+	if (!pctx) {
+		netdev_dbg(dev, "no PDP ctx found for %pI4, skip\n",
+			   &iph->daddr);
+		return -ENOENT;
+	}
+	netdev_dbg(dev, "found PDP context %p\n", pctx);
+
+	ret = gtp_build_skb_outer_ip4(skb, dev, pktinfo, pctx,
+				      iph->tos, iph->frag_off);
+	if (ret < 0)
+		return ret;
+
+	netdev_dbg(dev, "gtp -> IP src: %pI4 dst: %pI4\n",
+		   &iph->saddr, &iph->daddr);
+
+	return 0;
+}
+
 static int gtp_build_skb_ip6(struct sk_buff *skb, struct net_device *dev,
 			     struct gtp_pktinfo *pktinfo)
 {
-- 
2.30.2


