Return-Path: <netdev+bounces-91269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD588B1FAA
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 12:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237AC1F2300B
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 10:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7607B376E9;
	Thu, 25 Apr 2024 10:51:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18172C182
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714042314; cv=none; b=n6SB3geL8nd9sMnZKW34/DpWJA5ZbTs9yGteW9poOA3dQSwsqhokXuh9JQT2h6MSJzlZqp+UnVbYGqY92xWhQT3zclfK7Lta4Z2wkW4k43ho9oHAhHHXZuhps2ToIQ0EAIGn6mzrCvae7ATXr7C0H7JTpSzD3FvE9vFYH/20KWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714042314; c=relaxed/simple;
	bh=89BOXvJppBcwciHQ0OfooGovNn6C9EOI1gDfcTGNx6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h54qEpE9WIpT9c3EOOSxR741BOX9saAS/mX6SxnJHUqO4qpRFw2pTcrbdzsIHc4TLpC/pCQvuAllz0h/MBzpTlo4AZPqe9tL0Cpnw3b68iahPZHOksVBU/ZGDJIMYH/ut+SZNPuWDi6IE1dyZUfb5yjcXyZUGGOVM+IpBTOJY3s=
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
Subject: [PATCH net-next 08/12] gtp: remove IPv4 and IPv6 header from context object
Date: Thu, 25 Apr 2024 12:51:34 +0200
Message-Id: <20240425105138.1361098-9-pablo@netfilter.org>
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

Based on the idea that ip_tunnel_get_dsfield() provides the tos field
regardless the IP version, use either iph->tos or ipv6_get_dsfield().

This comes in preparation to support for IPv4-in-IPv6-GTP and
IPv6-in-IPv4-GTP.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 drivers/net/gtp.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 3d3818646387..5e4f3102fffe 100644
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
 
 static inline void gtp_set_pktinfo_ipv6(struct gtp_pktinfo *pktinfo,
-					struct sock *sk, struct ipv6hdr *ip6h,
+					struct sock *sk, __u8 tos,
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


