Return-Path: <netdev+bounces-93886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2CA8BD849
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 01:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26E68B22021
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 23:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC1715D5AB;
	Mon,  6 May 2024 23:53:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFBB15D5AF
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 23:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715039589; cv=none; b=fn4pbFiaD3KKxsdcmwAETsqRo7DezN5ZdZxnY8iOoYMg9SK19mBVTSawwXgdPmVRvKdaaQctrJ6qNxiiwr4HUSyo6GyMxXyV4uq0B8XWmofVZ2I3tHCDoBDPzEd78slniAzoCsBF5TBHXu4hLbiM4+SFZ4KAaEzABKEAOtvEGbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715039589; c=relaxed/simple;
	bh=rG9dcmrYbbE4yFwBStl8+anzRTdMti0toX6FP032bL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MoB0YjRqGzWBivzhb0ffQGFUyf+51PB53vU9LJFOmM/4H/Qp2jtzxJY9laYJF+go/XWZ4Ev8iD1ITe4Hv6XR/xlFZMaqQyH2GkOi9mukJkJ9BbMQFmMrwY1be+igJyAfH/Ijlo/0IxsAPqan9SIDJmOkR+SEZ1e5BAvI+szhdeo=
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
Subject: [PATCH net-next,v3 03/12] gtp: prepare for IPv6 support
Date: Tue,  7 May 2024 01:52:42 +0200
Message-Id: <20240506235251.3968262-4-pablo@netfilter.org>
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

Use union artifact to prepare for IPv6 support.
Add and use GTP_{IPV4,TH}_MAXLEN.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 drivers/net/gtp.c | 151 +++++++++++++++++++++++++++++-----------------
 1 file changed, 96 insertions(+), 55 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 0522b20242ba..811e4a660636 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -50,8 +50,12 @@ struct pdp_ctx {
 	u8			gtp_version;
 	u16			af;
 
-	struct in_addr		ms_addr_ip4;
-	struct in_addr		peer_addr_ip4;
+	union {
+		struct in_addr	addr;
+	} ms;
+	union {
+		struct in_addr	addr;
+	} peer;
 
 	struct sock		*sk;
 	struct net_device       *dev;
@@ -80,9 +84,15 @@ struct gtp_dev {
 };
 
 struct echo_info {
-	struct in_addr		ms_addr_ip4;
-	struct in_addr		peer_addr_ip4;
+	u16			af;
 	u8			gtp_version;
+
+	union {
+		struct in_addr	addr;
+	} ms;
+	union {
+		struct in_addr	addr;
+	} peer;
 };
 
 static unsigned int gtp_net_id __read_mostly;
@@ -163,7 +173,7 @@ static struct pdp_ctx *ipv4_pdp_find(struct gtp_dev *gtp, __be32 ms_addr)
 
 	hlist_for_each_entry_rcu(pdp, head, hlist_addr) {
 		if (pdp->af == AF_INET &&
-		    pdp->ms_addr_ip4.s_addr == ms_addr)
+		    pdp->ms.addr.s_addr == ms_addr)
 			return pdp;
 	}
 
@@ -181,9 +191,9 @@ static bool gtp_check_ms_ipv4(struct sk_buff *skb, struct pdp_ctx *pctx,
 	iph = (struct iphdr *)(skb->data + hdrlen);
 
 	if (role == GTP_ROLE_SGSN)
-		return iph->daddr == pctx->ms_addr_ip4.s_addr;
+		return iph->daddr == pctx->ms.addr.s_addr;
 	else
-		return iph->saddr == pctx->ms_addr_ip4.s_addr;
+		return iph->saddr == pctx->ms.addr.s_addr;
 }
 
 /* Check if the inner IP address in this packet is assigned to any
@@ -292,13 +302,39 @@ static void gtp0_build_echo_msg(struct gtp0_header *hdr, __u8 msg_type)
 		hdr->length = 0;
 }
 
+static int gtp0_send_echo_resp_ip(struct gtp_dev *gtp, struct sk_buff *skb)
+{
+	struct iphdr *iph = ip_hdr(skb);
+	struct flowi4 fl4;
+	struct rtable *rt;
+
+	/* find route to the sender,
+	 * src address becomes dst address and vice versa.
+	 */
+	rt = ip4_route_output_gtp(&fl4, gtp->sk0, iph->saddr, iph->daddr);
+	if (IS_ERR(rt)) {
+		netdev_dbg(gtp->dev, "no route for echo response from %pI4\n",
+			   &iph->saddr);
+		return -1;
+	}
+
+	udp_tunnel_xmit_skb(rt, gtp->sk0, skb,
+			    fl4.saddr, fl4.daddr,
+			    iph->tos,
+			    ip4_dst_hoplimit(&rt->dst),
+			    0,
+			    htons(GTP0_PORT), htons(GTP0_PORT),
+			    !net_eq(sock_net(gtp->sk1u),
+				    dev_net(gtp->dev)),
+			    false);
+
+	return 0;
+}
+
 static int gtp0_send_echo_resp(struct gtp_dev *gtp, struct sk_buff *skb)
 {
 	struct gtp0_packet *gtp_pkt;
 	struct gtp0_header *gtp0;
-	struct rtable *rt;
-	struct flowi4 fl4;
-	struct iphdr *iph;
 	__be16 seq;
 
 	gtp0 = (struct gtp0_header *)(skb->data + sizeof(struct udphdr));
@@ -325,27 +361,15 @@ static int gtp0_send_echo_resp(struct gtp_dev *gtp, struct sk_buff *skb)
 	gtp_pkt->ie.tag = GTPIE_RECOVERY;
 	gtp_pkt->ie.val = gtp->restart_count;
 
-	iph = ip_hdr(skb);
-
-	/* find route to the sender,
-	 * src address becomes dst address and vice versa.
-	 */
-	rt = ip4_route_output_gtp(&fl4, gtp->sk0, iph->saddr, iph->daddr);
-	if (IS_ERR(rt)) {
-		netdev_dbg(gtp->dev, "no route for echo response from %pI4\n",
-			   &iph->saddr);
+	switch (gtp->sk0->sk_family) {
+	case AF_INET:
+		if (gtp0_send_echo_resp_ip(gtp, skb) < 0)
+			return -1;
+		break;
+	case AF_INET6:
 		return -1;
 	}
 
-	udp_tunnel_xmit_skb(rt, gtp->sk0, skb,
-			    fl4.saddr, fl4.daddr,
-			    iph->tos,
-			    ip4_dst_hoplimit(&rt->dst),
-			    0,
-			    htons(GTP0_PORT), htons(GTP0_PORT),
-			    !net_eq(sock_net(gtp->sk1u),
-				    dev_net(gtp->dev)),
-			    false);
 	return 0;
 }
 
@@ -360,8 +384,8 @@ static int gtp_genl_fill_echo(struct sk_buff *skb, u32 snd_portid, u32 snd_seq,
 		goto failure;
 
 	if (nla_put_u32(skb, GTPA_VERSION, echo.gtp_version) ||
-	    nla_put_be32(skb, GTPA_PEER_ADDRESS, echo.peer_addr_ip4.s_addr) ||
-	    nla_put_be32(skb, GTPA_MS_ADDRESS, echo.ms_addr_ip4.s_addr))
+	    nla_put_be32(skb, GTPA_PEER_ADDRESS, echo.peer.addr.s_addr) ||
+	    nla_put_be32(skb, GTPA_MS_ADDRESS, echo.ms.addr.s_addr))
 		goto failure;
 
 	genlmsg_end(skb, genlh);
@@ -372,12 +396,20 @@ static int gtp_genl_fill_echo(struct sk_buff *skb, u32 snd_portid, u32 snd_seq,
 	return -EMSGSIZE;
 }
 
+static void gtp0_handle_echo_resp_ip(struct sk_buff *skb, struct echo_info *echo)
+{
+	struct iphdr *iph = ip_hdr(skb);
+
+	echo->ms.addr.s_addr = iph->daddr;
+	echo->peer.addr.s_addr = iph->saddr;
+	echo->gtp_version = GTP_V0;
+}
+
 static int gtp0_handle_echo_resp(struct gtp_dev *gtp, struct sk_buff *skb)
 {
 	struct gtp0_header *gtp0;
 	struct echo_info echo;
 	struct sk_buff *msg;
-	struct iphdr *iph;
 	int ret;
 
 	gtp0 = (struct gtp0_header *)(skb->data + sizeof(struct udphdr));
@@ -385,10 +417,13 @@ static int gtp0_handle_echo_resp(struct gtp_dev *gtp, struct sk_buff *skb)
 	if (!gtp0_validate_echo_hdr(gtp0))
 		return -1;
 
-	iph = ip_hdr(skb);
-	echo.ms_addr_ip4.s_addr = iph->daddr;
-	echo.peer_addr_ip4.s_addr = iph->saddr;
-	echo.gtp_version = GTP_V0;
+	switch (gtp->sk0->sk_family) {
+	case AF_INET:
+		gtp0_handle_echo_resp_ip(skb, &echo);
+		break;
+	case AF_INET6:
+		return -1;
+	}
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
 	if (!msg)
@@ -549,8 +584,8 @@ static int gtp1u_handle_echo_resp(struct gtp_dev *gtp, struct sk_buff *skb)
 		return -1;
 
 	iph = ip_hdr(skb);
-	echo.ms_addr_ip4.s_addr = iph->daddr;
-	echo.peer_addr_ip4.s_addr = iph->saddr;
+	echo.ms.addr.s_addr = iph->daddr;
+	echo.peer.addr.s_addr = iph->saddr;
 	echo.gtp_version = GTP_V1;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
@@ -801,9 +836,15 @@ static inline void gtp1_push_header(struct sk_buff *skb, struct pdp_ctx *pctx)
 
 struct gtp_pktinfo {
 	struct sock		*sk;
-	struct iphdr		*iph;
-	struct flowi4		fl4;
-	struct rtable		*rt;
+	union {
+		struct iphdr	*iph;
+	};
+	union {
+		struct flowi4	fl4;
+	};
+	union {
+		struct rtable	*rt;
+	};
 	struct pdp_ctx		*pctx;
 	struct net_device	*dev;
 	__be16			gtph_port;
@@ -864,18 +905,18 @@ static int gtp_build_skb_ip4(struct sk_buff *skb, struct net_device *dev,
 	}
 	netdev_dbg(dev, "found PDP context %p\n", pctx);
 
-	rt = ip4_route_output_gtp(&fl4, pctx->sk, pctx->peer_addr_ip4.s_addr,
+	rt = ip4_route_output_gtp(&fl4, pctx->sk, pctx->peer.addr.s_addr,
 				  inet_sk(pctx->sk)->inet_saddr);
 	if (IS_ERR(rt)) {
 		netdev_dbg(dev, "no route to SSGN %pI4\n",
-			   &pctx->peer_addr_ip4.s_addr);
+			   &pctx->peer.addr.s_addr);
 		dev->stats.tx_carrier_errors++;
 		goto err;
 	}
 
 	if (rt->dst.dev == dev) {
 		netdev_dbg(dev, "circular route to SSGN %pI4\n",
-			   &pctx->peer_addr_ip4.s_addr);
+			   &pctx->peer.addr.s_addr);
 		dev->stats.collisions++;
 		goto err_rt;
 	}
@@ -977,11 +1018,11 @@ static const struct device_type gtp_type = {
 	.name = "gtp",
 };
 
+#define GTP_TH_MAXLEN	(sizeof(struct udphdr) + sizeof(struct gtp0_header))
+#define GTP_IPV4_MAXLEN	(sizeof(struct iphdr) + GTP_TH_MAXLEN)
+
 static void gtp_link_setup(struct net_device *dev)
 {
-	unsigned int max_gtp_header_len = sizeof(struct iphdr) +
-					  sizeof(struct udphdr) +
-					  sizeof(struct gtp0_header);
 	struct gtp_dev *gtp = netdev_priv(dev);
 
 	dev->netdev_ops		= &gtp_netdev_ops;
@@ -990,7 +1031,7 @@ static void gtp_link_setup(struct net_device *dev)
 
 	dev->hard_header_len = 0;
 	dev->addr_len = 0;
-	dev->mtu = ETH_DATA_LEN - max_gtp_header_len;
+	dev->mtu = ETH_DATA_LEN - GTP_IPV4_MAXLEN;
 
 	/* Zero header length. */
 	dev->type = ARPHRD_NONE;
@@ -1001,7 +1042,7 @@ static void gtp_link_setup(struct net_device *dev)
 	dev->features	|= NETIF_F_LLTX;
 	netif_keep_dst(dev);
 
-	dev->needed_headroom	= LL_MAX_HEADER + max_gtp_header_len;
+	dev->needed_headroom	= LL_MAX_HEADER + GTP_IPV4_MAXLEN;
 	gtp->dev = dev;
 }
 
@@ -1341,9 +1382,9 @@ static void ipv4_pdp_fill(struct pdp_ctx *pctx, struct genl_info *info)
 {
 	pctx->gtp_version = nla_get_u32(info->attrs[GTPA_VERSION]);
 	pctx->af = AF_INET;
-	pctx->peer_addr_ip4.s_addr =
+	pctx->peer.addr.s_addr =
 		nla_get_be32(info->attrs[GTPA_PEER_ADDRESS]);
-	pctx->ms_addr_ip4.s_addr =
+	pctx->ms.addr.s_addr =
 		nla_get_be32(info->attrs[GTPA_MS_ADDRESS]);
 
 	switch (pctx->gtp_version) {
@@ -1444,13 +1485,13 @@ static struct pdp_ctx *gtp_pdp_add(struct gtp_dev *gtp, struct sock *sk,
 	switch (pctx->gtp_version) {
 	case GTP_V0:
 		netdev_dbg(dev, "GTPv0-U: new PDP ctx id=%llx ssgn=%pI4 ms=%pI4 (pdp=%p)\n",
-			   pctx->u.v0.tid, &pctx->peer_addr_ip4,
-			   &pctx->ms_addr_ip4, pctx);
+			   pctx->u.v0.tid, &pctx->peer.addr,
+			   &pctx->ms.addr, pctx);
 		break;
 	case GTP_V1:
 		netdev_dbg(dev, "GTPv1-U: new PDP ctx id=%x/%x ssgn=%pI4 ms=%pI4 (pdp=%p)\n",
 			   pctx->u.v1.i_tei, pctx->u.v1.o_tei,
-			   &pctx->peer_addr_ip4, &pctx->ms_addr_ip4, pctx);
+			   &pctx->peer.addr, &pctx->ms.addr, pctx);
 		break;
 	}
 
@@ -1622,8 +1663,8 @@ static int gtp_genl_fill_info(struct sk_buff *skb, u32 snd_portid, u32 snd_seq,
 
 	if (nla_put_u32(skb, GTPA_VERSION, pctx->gtp_version) ||
 	    nla_put_u32(skb, GTPA_LINK, pctx->dev->ifindex) ||
-	    nla_put_be32(skb, GTPA_PEER_ADDRESS, pctx->peer_addr_ip4.s_addr) ||
-	    nla_put_be32(skb, GTPA_MS_ADDRESS, pctx->ms_addr_ip4.s_addr))
+	    nla_put_be32(skb, GTPA_PEER_ADDRESS, pctx->peer.addr.s_addr) ||
+	    nla_put_be32(skb, GTPA_MS_ADDRESS, pctx->ms.addr.s_addr))
 		goto nla_put_failure;
 
 	switch (pctx->gtp_version) {
-- 
2.30.2


