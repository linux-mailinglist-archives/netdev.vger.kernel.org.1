Return-Path: <netdev+bounces-90697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5058AFBED
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 00:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F82D1C229C7
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 22:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9B4249F7;
	Tue, 23 Apr 2024 22:39:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C3543AB4
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 22:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713911982; cv=none; b=oWgpwtm5+e1u2yh+5XPBPMXksqaIN4mCNFQmtsMHy3wdQyjtT8nvatoNRty0Ko6vxshUYjTM1Dh423J6FoYeV0k2F0bVXHsr1umk4/h++rpWurBEhf7aZczO4fMO+qx7JPv9F2zXLrr+CmmBGoeuH9XIUTaXFD0Y56RLxjYTMu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713911982; c=relaxed/simple;
	bh=wLV5fPriP+JXD+Q4b/35ofyaGTs01kj3TrayQZuUgg8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lx1ZMU/jz2zmhYuZ/FIXXWy3kG5osmjNvhvfJdGW43u35lmJuIFVNvlEJI2tF/liDmFfKb8gG2kUbkMz0wETHO6+RbT0CGaHLUcvFkLRbzaVRJBaEfkpTLUsjaiGsOixVO/tylsL7ulU1Sfpd7JtncNmaN+77DkiRoRbzzoa+oQ=
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
Subject: [PATCH net-next 11/12] gtp: support for IPv4-in-IPv6-GTP and IPv6-in-IPv4-GTP
Date: Wed, 24 Apr 2024 00:39:18 +0200
Message-Id: <20240423223919.3385493-12-pablo@netfilter.org>
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

Add new protocol field to PDP context that determines the transmit path
IP protocol to encapsulate the original packets, either IPv4 or IPv6.

Relax existing netlink attribute checks to allow to specify different
family in MS and peer attributes from the control plane.

Use build helpers to tx path to encapsulate IPv4-in-IPv6-GTP and
IPv6-in-IPv4-GTP according to the user-specified configuration.

From rx path, snoop for the inner protocol header since outer
skb->protocol might differ and use this to validate for valid PDP
context and to restore skb->protocol after decapsulation.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 drivers/net/gtp.c | 129 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 101 insertions(+), 28 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index c38dfe6a0673..0b39c4e31e67 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -267,9 +267,10 @@ static bool gtp_check_ms_ipv6(struct sk_buff *skb, struct pdp_ctx *pctx,
  * existing mobile subscriber.
  */
 static bool gtp_check_ms(struct sk_buff *skb, struct pdp_ctx *pctx,
-			     unsigned int hdrlen, unsigned int role)
+			 unsigned int hdrlen, unsigned int role,
+			 __u16 inner_proto)
 {
-	switch (ntohs(skb->protocol)) {
+	switch (inner_proto) {
 	case ETH_P_IP:
 		return gtp_check_ms_ipv4(skb, pctx, hdrlen, role);
 	case ETH_P_IPV6:
@@ -278,16 +279,47 @@ static bool gtp_check_ms(struct sk_buff *skb, struct pdp_ctx *pctx,
 	return false;
 }
 
+static int gtp_inner_proto(struct sk_buff *skb, unsigned int hdrlen,
+			   __u16 *inner_proto)
+{
+	__u8 *ip_version, _ip_version;
+
+	ip_version = skb_header_pointer(skb, hdrlen, sizeof(ip_version),
+					&_ip_version);
+	if (!ip_version)
+		return -1;
+
+	switch (*ip_version & 0xf0) {
+	case 0x40:
+		*inner_proto = ETH_P_IP;
+		break;
+	case 0x60:
+		*inner_proto = ETH_P_IPV6;
+		break;
+	default:
+		return -1;
+	}
+
+	return 0;
+}
+
 static int gtp_rx(struct pdp_ctx *pctx, struct sk_buff *skb,
-			unsigned int hdrlen, unsigned int role)
+		  unsigned int hdrlen, unsigned int role)
 {
-	if (!gtp_check_ms(skb, pctx, hdrlen, role)) {
+	__u16 inner_proto;
+
+	if (gtp_inner_proto(skb, hdrlen, &inner_proto) < 0) {
+		netdev_dbg(pctx->dev, "GTP packet does not encapsulate an IP packet\n");
+		return -1;
+	}
+
+	if (!gtp_check_ms(skb, pctx, hdrlen, role, inner_proto)) {
 		netdev_dbg(pctx->dev, "No PDP ctx for this MS\n");
 		return 1;
 	}
 
 	/* Get rid of the GTP + UDP headers. */
-	if (iptunnel_pull_header(skb, hdrlen, skb->protocol,
+	if (iptunnel_pull_header(skb, hdrlen, htons(inner_proto),
 			 !net_eq(sock_net(pctx->sk), dev_net(pctx->dev)))) {
 		pctx->dev->stats.rx_length_errors++;
 		goto err;
@@ -1107,6 +1139,7 @@ static int gtp_build_skb_ip4(struct sk_buff *skb, struct net_device *dev,
 			     struct gtp_pktinfo *pktinfo)
 {
 	struct gtp_dev *gtp = netdev_priv(dev);
+	struct net *net = gtp->net;
 	struct pdp_ctx *pctx;
 	struct iphdr *iph;
 	int ret;
@@ -1127,8 +1160,21 @@ static int gtp_build_skb_ip4(struct sk_buff *skb, struct net_device *dev,
 	}
 	netdev_dbg(dev, "found PDP context %p\n", pctx);
 
-	ret = gtp_build_skb_outer_ip4(skb, dev, pktinfo, pctx,
-				      iph->tos, iph->frag_off);
+	switch (pctx->sk->sk_family) {
+	case AF_INET:
+		ret = gtp_build_skb_outer_ip4(skb, dev, pktinfo, pctx,
+					      iph->tos, iph->frag_off);
+		break;
+	case AF_INET6:
+		ret = gtp_build_skb_outer_ip6(net, skb, dev, pktinfo, pctx,
+					      iph->tos);
+		break;
+	default:
+		ret = -1;
+		WARN_ON_ONCE(1);
+		break;
+	}
+
 	if (ret < 0)
 		return ret;
 
@@ -1166,7 +1212,19 @@ static int gtp_build_skb_ip6(struct sk_buff *skb, struct net_device *dev,
 
 	tos = ipv6_get_dsfield(ip6h);
 
-	ret = gtp_build_skb_outer_ip6(net, skb, dev, pktinfo, pctx, tos);
+	switch (pctx->sk->sk_family) {
+	case AF_INET:
+		ret = gtp_build_skb_outer_ip4(skb, dev, pktinfo, pctx, tos, 0);
+		break;
+	case AF_INET6:
+		ret = gtp_build_skb_outer_ip6(net, skb, dev, pktinfo, pctx, tos);
+		break;
+	default:
+		ret = -1;
+		WARN_ON_ONCE(1);
+		break;
+	}
+
 	if (ret < 0)
 		return ret;
 
@@ -1206,8 +1264,8 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (err < 0)
 		goto tx_err;
 
-	switch (proto) {
-	case ETH_P_IP:
+	switch (pktinfo.pctx->sk->sk_family) {
+	case AF_INET:
 		udp_tunnel_xmit_skb(pktinfo.rt, pktinfo.sk, skb,
 				    pktinfo.fl4.saddr, pktinfo.fl4.daddr,
 				    pktinfo.tos,
@@ -1218,7 +1276,7 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 					    dev_net(dev)),
 				    false);
 		break;
-	case ETH_P_IPV6:
+	case AF_INET6:
 #if IS_ENABLED(CONFIG_IPV6)
 		udp_tunnel6_xmit_skb(&pktinfo.rt6->dst, pktinfo.sk, skb, dev,
 				     &pktinfo.fl6.saddr, &pktinfo.fl6.daddr,
@@ -1693,10 +1751,19 @@ static void gtp_pdp_fill(struct pdp_ctx *pctx, struct genl_info *info)
 	}
 }
 
+static void ip_pdp_peer_fill(struct pdp_ctx *pctx, struct genl_info *info)
+{
+	if (info->attrs[GTPA_PEER_ADDRESS]) {
+		pctx->peer.addr.s_addr =
+			nla_get_be32(info->attrs[GTPA_PEER_ADDRESS]);
+	} else if (info->attrs[GTPA_PEER_ADDR6]) {
+		pctx->peer.addr6 = nla_get_in6_addr(info->attrs[GTPA_PEER_ADDR6]);
+	}
+}
+
 static void ipv4_pdp_fill(struct pdp_ctx *pctx, struct genl_info *info)
 {
-	pctx->peer.addr.s_addr =
-		nla_get_be32(info->attrs[GTPA_PEER_ADDRESS]);
+	ip_pdp_peer_fill(pctx, info);
 	pctx->ms.addr.s_addr =
 		nla_get_be32(info->attrs[GTPA_MS_ADDRESS]);
 	gtp_pdp_fill(pctx, info);
@@ -1704,7 +1771,7 @@ static void ipv4_pdp_fill(struct pdp_ctx *pctx, struct genl_info *info)
 
 static bool ipv6_pdp_fill(struct pdp_ctx *pctx, struct genl_info *info)
 {
-	pctx->peer.addr6 = nla_get_in6_addr(info->attrs[GTPA_PEER_ADDR6]);
+	ip_pdp_peer_fill(pctx, info);
 	pctx->ms.addr6 = nla_get_in6_addr(info->attrs[GTPA_MS_ADDR6]);
 	if (pctx->ms.addr6.s6_addr32[2] ||
 	    pctx->ms.addr6.s6_addr32[3])
@@ -1738,6 +1805,9 @@ static struct pdp_ctx *gtp_pdp_add(struct gtp_dev *gtp, struct sock *sk,
 	if (family == AF_INET6)
 		return ERR_PTR(-EAFNOSUPPORT);
 #endif
+	if (!info->attrs[GTPA_PEER_ADDRESS] &&
+	    !info->attrs[GTPA_PEER_ADDR6])
+		return ERR_PTR(-EINVAL);
 
 	if ((info->attrs[GTPA_PEER_ADDRESS] &&
 	     sk->sk_family == AF_INET6) ||
@@ -1748,9 +1818,7 @@ static struct pdp_ctx *gtp_pdp_add(struct gtp_dev *gtp, struct sock *sk,
 	switch (family) {
 	case AF_INET:
 		if (!info->attrs[GTPA_MS_ADDRESS] ||
-		    !info->attrs[GTPA_PEER_ADDRESS] ||
-		    info->attrs[GTPA_MS_ADDR6] ||
-		    info->attrs[GTPA_PEER_ADDR6])
+		    info->attrs[GTPA_MS_ADDR6])
 			return ERR_PTR(-EINVAL);
 
 		ms_addr = nla_get_be32(info->attrs[GTPA_MS_ADDRESS]);
@@ -1759,9 +1827,7 @@ static struct pdp_ctx *gtp_pdp_add(struct gtp_dev *gtp, struct sock *sk,
 		break;
 	case AF_INET6:
 		if (!info->attrs[GTPA_MS_ADDR6] ||
-		    !info->attrs[GTPA_PEER_ADDR6] ||
-		    info->attrs[GTPA_MS_ADDRESS] ||
-		    info->attrs[GTPA_PEER_ADDRESS])
+		    info->attrs[GTPA_MS_ADDRESS])
 			return ERR_PTR(-EINVAL);
 
 		ms_addr6 = nla_get_in6_addr(info->attrs[GTPA_MS_ADDR6]);
@@ -1825,15 +1891,13 @@ static struct pdp_ctx *gtp_pdp_add(struct gtp_dev *gtp, struct sock *sk,
 
 	switch (pctx->af) {
 	case AF_INET:
-		if (!info->attrs[GTPA_MS_ADDRESS] ||
-		    !info->attrs[GTPA_PEER_ADDRESS])
+		if (!info->attrs[GTPA_MS_ADDRESS])
 			return ERR_PTR(-EINVAL);
 
 		ipv4_pdp_fill(pctx, info);
 		break;
 	case AF_INET6:
-		if (!info->attrs[GTPA_MS_ADDR6] ||
-		    !info->attrs[GTPA_PEER_ADDR6])
+		if (!info->attrs[GTPA_MS_ADDR6])
 			return ERR_PTR(-EINVAL);
 
 		if (!ipv6_pdp_fill(pctx, info))
@@ -2051,13 +2115,22 @@ static int gtp_genl_fill_info(struct sk_buff *skb, u32 snd_portid, u32 snd_seq,
 
 	switch (pctx->af) {
 	case AF_INET:
-		if (nla_put_be32(skb, GTPA_PEER_ADDRESS, pctx->peer.addr.s_addr) ||
-		    nla_put_be32(skb, GTPA_MS_ADDRESS, pctx->ms.addr.s_addr))
+		if (nla_put_be32(skb, GTPA_MS_ADDRESS, pctx->ms.addr.s_addr))
+			goto nla_put_failure;
+		break;
+	case AF_INET6:
+		if (nla_put_in6_addr(skb, GTPA_MS_ADDR6, &pctx->ms.addr6))
+			goto nla_put_failure;
+		break;
+	}
+
+	switch (pctx->sk->sk_family) {
+	case AF_INET:
+		if (nla_put_be32(skb, GTPA_PEER_ADDRESS, pctx->peer.addr.s_addr))
 			goto nla_put_failure;
 		break;
 	case AF_INET6:
-		if (nla_put_in6_addr(skb, GTPA_PEER_ADDR6, &pctx->peer.addr6) ||
-		    nla_put_in6_addr(skb, GTPA_MS_ADDR6, &pctx->ms.addr6))
+		if (nla_put_in6_addr(skb, GTPA_PEER_ADDR6, &pctx->peer.addr6))
 			goto nla_put_failure;
 		break;
 	}
-- 
2.30.2


