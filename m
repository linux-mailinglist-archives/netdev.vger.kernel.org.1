Return-Path: <netdev+bounces-90694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7EF8AFBEA
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 00:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56343289A17
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 22:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F20A42078;
	Tue, 23 Apr 2024 22:39:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A445738F83
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 22:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713911980; cv=none; b=WfU/1Bi5CP1KQMpgZpqRiYiiID8mlbTk5UwsfHF3GbQ8qx+DI0AxPqCDg7gcucTRIum7IN0C80AbyLctz5i7kfTAoaogmd00elhgVViwWnJnfY9V/V3Fnj2q1F093yN7DY9gzSZUyfuxJ+j1/CBwboRVVg1S5u1Tr2+/Pp/NSq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713911980; c=relaxed/simple;
	bh=AR9HeFhfpXun+k789ebjKtHLBA5zJU1+9X1LfFvX+/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pvm5kbKrwAPQb4mNe5uS7nkdOxxBDYSWVUWoVAWtDTKkpSmlJ2ewB2KppDRhzstmITDaXmJyASjDAEMl9ruCTgbxMxUjNV4lDaRDlY275ICM+jQrc9CN22mQIcw/Jb5U+5poHV0ghI9xUSsGqaTwlyicTIrkekfoye1935PpXgc=
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
Subject: [PATCH net-next 08/12] gtp: remove IPv4 and IPv6 header from context object
Date: Wed, 24 Apr 2024 00:39:15 +0200
Message-Id: <20240423223919.3385493-9-pablo@netfilter.org>
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

Based on the idea that ip_tunnel_get_dsfield() provides the tos field
regardless the IP version, use either iph->tos or ipv6_get_dsfield().

This comes in preparation to support for IPv4-in-IPv6-GTP and
IPv6-in-IPv4-GTP.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 drivers/net/gtp.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 7c9e13a9f9eb..2d11111ef63c 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -926,10 +926,6 @@ static inline void gtp1_push_header(struct sk_buff *skb, struct pdp_ctx *pctx)
 
 struct gtp_pktinfo {
 	struct sock		*sk;
-	union {
-		struct iphdr	*iph;
-		struct ipv6hdr	*ip6h;
-	};
 	union {
 		struct flowi4	fl4;
 		struct flowi6	fl6;
@@ -940,6 +936,7 @@ struct gtp_pktinfo {
 	};
 	struct pdp_ctx		*pctx;
 	struct net_device	*dev;
+	__u8			tos;
 	__be16			gtph_port;
 };
 
@@ -958,13 +955,13 @@ static void gtp_push_header(struct sk_buff *skb, struct gtp_pktinfo *pktinfo)
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
@@ -972,13 +969,13 @@ static inline void gtp_set_pktinfo_ipv4(struct gtp_pktinfo *pktinfo,
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
@@ -1056,7 +1053,7 @@ static int gtp_build_skb_ip4(struct sk_buff *skb, struct net_device *dev,
 		goto err_rt;
 	}
 
-	gtp_set_pktinfo_ipv4(pktinfo, pctx->sk, iph, pctx, rt, &fl4, dev);
+	gtp_set_pktinfo_ipv4(pktinfo, pctx->sk, iph->tos, pctx, rt, &fl4, dev);
 	gtp_push_header(skb, pktinfo);
 
 	netdev_dbg(dev, "gtp -> IP src: %pI4 dst: %pI4\n",
@@ -1079,6 +1076,7 @@ static int gtp_build_skb_ip6(struct sk_buff *skb, struct net_device *dev,
 	struct ipv6hdr *ip6h;
 	struct rt6_info *rt;
 	struct flowi6 fl6;
+	__u8 tos;
 	int mtu;
 
 	/* Read the IP destination address and resolve the PDP context.
@@ -1134,7 +1132,8 @@ static int gtp_build_skb_ip6(struct sk_buff *skb, struct net_device *dev,
 		goto err_rt;
 	}
 
-	gtp_set_pktinfo_ipv6(pktinfo, pctx->sk, ip6h, pctx, rt, &fl6, dev);
+	tos = ipv6_get_dsfield(ip6h);
+	gtp_set_pktinfo_ipv6(pktinfo, pctx->sk, tos, pctx, rt, &fl6, dev);
 	gtp_push_header(skb, pktinfo);
 
 	netdev_dbg(dev, "gtp -> IP src: %pI6 dst: %pI6\n",
@@ -1181,7 +1180,7 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	case ETH_P_IP:
 		udp_tunnel_xmit_skb(pktinfo.rt, pktinfo.sk, skb,
 				    pktinfo.fl4.saddr, pktinfo.fl4.daddr,
-				    pktinfo.iph->tos,
+				    pktinfo.tos,
 				    ip4_dst_hoplimit(&pktinfo.rt->dst),
 				    0,
 				    pktinfo.gtph_port, pktinfo.gtph_port,
@@ -1193,7 +1192,7 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
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


