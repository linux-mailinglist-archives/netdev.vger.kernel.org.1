Return-Path: <netdev+bounces-93891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7944A8BD84E
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 01:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 144091F23E56
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 23:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7A515E5A5;
	Mon,  6 May 2024 23:53:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E30015E1EA
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 23:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715039592; cv=none; b=tUr2JN0aZn1VGg6Ubz7143MyMJGcza9FE57hM5MV3Byauw/moj9s0BUvtLEvnUN2M5RT/pGgmib0/wQuztg9Z5GojL3YoCXnTdbas9MA7yvyGXXZi11qPDILLzbgQjpCRlKS7Lf7w88wbq89zE8v4rPTmZowWLbYDD/wVg25xgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715039592; c=relaxed/simple;
	bh=DrL781yAVZfg5eGOAE7yEVfr22huJX4IWzOcnnt01WY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WooXAN2CPSKwYpKAghfH6mGjowh9W7+WcCQXSf6uZQiTdSB1tIwHvGUPUOV4EqsUSOtppzML0uy6j1ghPkvLI4uwQ0Z2i1OGbJ5toqBBYYlyUefcXjOojXTAinW10ih1zPlEyK0qOkWaniHZ9EG0I1CrH2+dx64nTE4b+WROp7s=
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
Subject: [PATCH net-next,v3 08/12] gtp: remove IPv4 and IPv6 header from context object
Date: Tue,  7 May 2024 01:52:47 +0200
Message-Id: <20240506235251.3968262-9-pablo@netfilter.org>
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

Based on the idea that ip_tunnel_get_dsfield() provides the tos field
regardless the IP version, use either iph->tos or ipv6_get_dsfield().

This comes in preparation to support for IPv4-in-IPv6-GTP and
IPv6-in-IPv4-GTP.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 drivers/net/gtp.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index d5a17195098f..41503c649a97 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -927,10 +927,6 @@ static inline void gtp1_push_header(struct sk_buff *skb, struct pdp_ctx *pctx)
 
 struct gtp_pktinfo {
 	struct sock		*sk;
-	union {
-		struct iphdr	*iph;
-		struct ipv6hdr	*ip6h;
-	};
 	union {
 		struct flowi4	fl4;
 		struct flowi6	fl6;
@@ -941,6 +937,7 @@ struct gtp_pktinfo {
 	};
 	struct pdp_ctx		*pctx;
 	struct net_device	*dev;
+	__u8			tos;
 	__be16			gtph_port;
 };
 
@@ -959,13 +956,13 @@ static void gtp_push_header(struct sk_buff *skb, struct gtp_pktinfo *pktinfo)
 }
 
 static inline void gtp_set_pktinfo_ipv4(struct gtp_pktinfo *pktinfo,
-					struct sock *sk, struct iphdr *iph,
+					struct sock *sk, __u8 tos,
 					struct pdp_ctx *pctx, struct rtable *rt,
 					struct flowi4 *fl4,
 					struct net_device *dev)
 {
 	pktinfo->sk	= sk;
-	pktinfo->iph	= iph;
+	pktinfo->tos	= tos;
 	pktinfo->pctx	= pctx;
 	pktinfo->rt	= rt;
 	pktinfo->fl4	= *fl4;
@@ -973,13 +970,13 @@ static inline void gtp_set_pktinfo_ipv4(struct gtp_pktinfo *pktinfo,
 }
 
 static void gtp_set_pktinfo_ipv6(struct gtp_pktinfo *pktinfo,
-				 struct sock *sk, struct ipv6hdr *ip6h,
+				 struct sock *sk, __u8 tos,
 				 struct pdp_ctx *pctx, struct rt6_info *rt6,
 				 struct flowi6 *fl6,
 				 struct net_device *dev)
 {
 	pktinfo->sk	= sk;
-	pktinfo->ip6h	= ip6h;
+	pktinfo->tos	= tos;
 	pktinfo->pctx	= pctx;
 	pktinfo->rt6	= rt6;
 	pktinfo->fl6	= *fl6;
@@ -1057,7 +1054,7 @@ static int gtp_build_skb_ip4(struct sk_buff *skb, struct net_device *dev,
 		goto err_rt;
 	}
 
-	gtp_set_pktinfo_ipv4(pktinfo, pctx->sk, iph, pctx, rt, &fl4, dev);
+	gtp_set_pktinfo_ipv4(pktinfo, pctx->sk, iph->tos, pctx, rt, &fl4, dev);
 	gtp_push_header(skb, pktinfo);
 
 	netdev_dbg(dev, "gtp -> IP src: %pI4 dst: %pI4\n",
@@ -1080,6 +1077,7 @@ static int gtp_build_skb_ip6(struct sk_buff *skb, struct net_device *dev,
 	struct ipv6hdr *ip6h;
 	struct rt6_info *rt;
 	struct flowi6 fl6;
+	__u8 tos;
 	int mtu;
 
 	/* Read the IP destination address and resolve the PDP context.
@@ -1135,7 +1133,8 @@ static int gtp_build_skb_ip6(struct sk_buff *skb, struct net_device *dev,
 		goto err_rt;
 	}
 
-	gtp_set_pktinfo_ipv6(pktinfo, pctx->sk, ip6h, pctx, rt, &fl6, dev);
+	tos = ipv6_get_dsfield(ip6h);
+	gtp_set_pktinfo_ipv6(pktinfo, pctx->sk, tos, pctx, rt, &fl6, dev);
 	gtp_push_header(skb, pktinfo);
 
 	netdev_dbg(dev, "gtp -> IP src: %pI6 dst: %pI6\n",
@@ -1182,7 +1181,7 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	case ETH_P_IP:
 		udp_tunnel_xmit_skb(pktinfo.rt, pktinfo.sk, skb,
 				    pktinfo.fl4.saddr, pktinfo.fl4.daddr,
-				    pktinfo.iph->tos,
+				    pktinfo.tos,
 				    ip4_dst_hoplimit(&pktinfo.rt->dst),
 				    0,
 				    pktinfo.gtph_port, pktinfo.gtph_port,
@@ -1194,7 +1193,7 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 #if IS_ENABLED(CONFIG_IPV6)
 		udp_tunnel6_xmit_skb(&pktinfo.rt6->dst, pktinfo.sk, skb, dev,
 				     &pktinfo.fl6.saddr, &pktinfo.fl6.daddr,
-				     ipv6_get_dsfield(pktinfo.ip6h),
+				     pktinfo.tos,
 				     ip6_dst_hoplimit(&pktinfo.rt->dst),
 				     0,
 				     pktinfo.gtph_port, pktinfo.gtph_port,
-- 
2.30.2


