Return-Path: <netdev+bounces-91265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7478B1FA6
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 12:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A372845E6
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 10:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D825E2C6B6;
	Thu, 25 Apr 2024 10:51:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8744622616
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 10:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714042312; cv=none; b=qvMJ5f+0vpewj03g293ILKCr+FF1Tn1wLWTpQ4QP/de7dxpQdvkrtcIHgaeyCEsaWhyHifQI42KnZKse5Zfp4wcEOLZiUOgllLP/mSv8Gu8pBZnRoJsgUPWnF3o+z8+Z/Sv+/kS0pfrkbJAH0Xua0bsfNW1cTtG1Tvuqbn+IIbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714042312; c=relaxed/simple;
	bh=quHhPPsv74MgM3MJ2VAsa10LRi6As9lpuSY+8CjGRH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eM7EK5PxoWIGwwcUx6R+ylDAso8fW/hNv4gUn8Lk64Fmf5xF2U+6PrL4m0MmT8jS/2+Zoyrw0VI1JQYZTasByE/wHDRM/sON6X8HUTgnuqGhY0qwXP+fDv22Z0PvcTTDj9ZTGkihN8IOTAp3DAFOCBkUTDKdh7I+EKX7ciiusQQ=
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
Subject: [PATCH net-next 04/12] gtp: add IPv6 support
Date: Thu, 25 Apr 2024 12:51:30 +0200
Message-Id: <20240425105138.1361098-5-pablo@netfilter.org>
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

Add new iflink attributes to configure in-kernel UDP listener socket
address: IFLA_GTP_LOCAL and IFLA_GTP_LOCAL6. If none of these attributes
are specified, default is still to IPv4 INADDR_ANY for backward
compatibility.

Add new attributes to set up family and IPv6 address of GTP tunnels:
GTPA_FAMILY, GTPA_PEER_ADDR6 and GTPA_MS_ADDR6. If no GTPA_FAMILY is
specified, AF_INET is assumed for backward compatibility.

setsockopt IPV6_ADDRFORM allows to downgrade socket from IPv6 to IPv4
after socket is bound. Assumption is that socket listener that is
attached to the gtp device needs to be either IPv4 or IPv6. Therefore,
GTP socket listener does not allow for IPv4-mapped-IPv6 listener.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 drivers/net/gtp.c            | 390 ++++++++++++++++++++++++++++++++---
 include/uapi/linux/gtp.h     |   3 +
 include/uapi/linux/if_link.h |   2 +
 3 files changed, 368 insertions(+), 27 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 1c4429d24cfc..69d865e592df 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -24,6 +24,7 @@
 #include <net/net_namespace.h>
 #include <net/protocol.h>
 #include <net/ip.h>
+#include <net/ipv6.h>
 #include <net/udp.h>
 #include <net/udp_tunnel.h>
 #include <net/icmp.h>
@@ -52,9 +53,11 @@ struct pdp_ctx {
 
 	union {
 		struct in_addr	addr;
+		struct in6_addr	addr6;
 	} ms;
 	union {
 		struct in_addr	addr;
+		struct in6_addr	addr6;
 	} peer;
 
 	struct sock		*sk;
@@ -131,6 +134,11 @@ static inline u32 ipv4_hashfn(__be32 ip)
 	return jhash_1word((__force u32)ip, gtp_h_initval);
 }
 
+static inline u32 ipv6_hashfn(const struct in6_addr *ip6)
+{
+	return jhash(ip6, sizeof(*ip6), gtp_h_initval);
+}
+
 /* Resolve a PDP context structure based on the 64bit TID. */
 static struct pdp_ctx *gtp0_pdp_find(struct gtp_dev *gtp, u64 tid)
 {
@@ -180,6 +188,23 @@ static struct pdp_ctx *ipv4_pdp_find(struct gtp_dev *gtp, __be32 ms_addr)
 	return NULL;
 }
 
+static struct pdp_ctx *ipv6_pdp_find(struct gtp_dev *gtp,
+				     const struct in6_addr *ms_addr)
+{
+	struct hlist_head *head;
+	struct pdp_ctx *pdp;
+
+	head = &gtp->addr_hash[ipv6_hashfn(ms_addr) % gtp->hash_size];
+
+	hlist_for_each_entry_rcu(pdp, head, hlist_addr) {
+		if (pdp->af == AF_INET6 &&
+		    memcmp(&pdp->ms.addr6, ms_addr, sizeof(struct in6_addr)) == 0)
+			return pdp;
+	}
+
+	return NULL;
+}
+
 static bool gtp_check_ms_ipv4(struct sk_buff *skb, struct pdp_ctx *pctx,
 				  unsigned int hdrlen, unsigned int role)
 {
@@ -196,6 +221,28 @@ static bool gtp_check_ms_ipv4(struct sk_buff *skb, struct pdp_ctx *pctx,
 		return iph->saddr == pctx->ms.addr.s_addr;
 }
 
+static bool gtp_check_ms_ipv6(struct sk_buff *skb, struct pdp_ctx *pctx,
+			      unsigned int hdrlen, unsigned int role)
+{
+	struct ipv6hdr *ip6h;
+	int ret;
+
+	if (!pskb_may_pull(skb, hdrlen + sizeof(struct ipv6hdr)))
+		return false;
+
+	ip6h = (struct ipv6hdr *)(skb->data + hdrlen);
+
+	if (role == GTP_ROLE_SGSN) {
+		ret = memcmp(&ip6h->daddr, &pctx->ms.addr6,
+			     sizeof(struct in6_addr));
+	} else {
+		ret = memcmp(&ip6h->saddr, &pctx->ms.addr6,
+			     sizeof(struct in6_addr));
+	}
+
+	return ret == 0;
+}
+
 /* Check if the inner IP address in this packet is assigned to any
  * existing mobile subscriber.
  */
@@ -205,6 +252,8 @@ static bool gtp_check_ms(struct sk_buff *skb, struct pdp_ctx *pctx,
 	switch (ntohs(skb->protocol)) {
 	case ETH_P_IP:
 		return gtp_check_ms_ipv4(skb, pctx, hdrlen, role);
+	case ETH_P_IPV6:
+		return gtp_check_ms_ipv6(skb, pctx, hdrlen, role);
 	}
 	return false;
 }
@@ -260,6 +309,27 @@ static struct rtable *ip4_route_output_gtp(struct flowi4 *fl4,
 	return ip_route_output_key(sock_net(sk), fl4);
 }
 
+static struct rt6_info *ip6_route_output_gtp(struct net *net,
+					     struct flowi6 *fl6,
+					     const struct sock *sk,
+					     const struct in6_addr *daddr,
+					     struct in6_addr *saddr)
+{
+	struct dst_entry *dst;
+
+	memset(fl6, 0, sizeof(*fl6));
+	fl6->flowi6_oif		= sk->sk_bound_dev_if;
+	fl6->daddr		= *daddr;
+	fl6->saddr		= *saddr;
+	fl6->flowi6_proto	= sk->sk_protocol;
+
+	dst = ipv6_stub->ipv6_dst_lookup_flow(net, sk, fl6, NULL);
+	if (IS_ERR(dst))
+		return ERR_PTR(-ENETUNREACH);
+
+	return (struct rt6_info *)dst;
+}
+
 /* GSM TS 09.60. 7.3
  * In all Path Management messages:
  * - TID: is not used and shall be set to 0.
@@ -838,12 +908,15 @@ struct gtp_pktinfo {
 	struct sock		*sk;
 	union {
 		struct iphdr	*iph;
+		struct ipv6hdr	*ip6h;
 	};
 	union {
 		struct flowi4	fl4;
+		struct flowi6	fl6;
 	};
 	union {
 		struct rtable	*rt;
+		struct rt6_info	*rt6;
 	};
 	struct pdp_ctx		*pctx;
 	struct net_device	*dev;
@@ -878,6 +951,20 @@ static inline void gtp_set_pktinfo_ipv4(struct gtp_pktinfo *pktinfo,
 	pktinfo->dev	= dev;
 }
 
+static inline void gtp_set_pktinfo_ipv6(struct gtp_pktinfo *pktinfo,
+					struct sock *sk, struct ipv6hdr *ip6h,
+					struct pdp_ctx *pctx, struct rt6_info *rt6,
+					struct flowi6 *fl6,
+					struct net_device *dev)
+{
+	pktinfo->sk	= sk;
+	pktinfo->ip6h	= ip6h;
+	pktinfo->pctx	= pctx;
+	pktinfo->rt6	= rt6;
+	pktinfo->fl6	= *fl6;
+	pktinfo->dev	= dev;
+}
+
 static int gtp_build_skb_ip4(struct sk_buff *skb, struct net_device *dev,
 			     struct gtp_pktinfo *pktinfo)
 {
@@ -959,6 +1046,81 @@ static int gtp_build_skb_ip4(struct sk_buff *skb, struct net_device *dev,
 	return -EBADMSG;
 }
 
+static int gtp_build_skb_ip6(struct sk_buff *skb, struct net_device *dev,
+			     struct gtp_pktinfo *pktinfo)
+{
+	struct gtp_dev *gtp = netdev_priv(dev);
+	struct net *net = gtp->net;
+	struct dst_entry *dst;
+	struct pdp_ctx *pctx;
+	struct ipv6hdr *ip6h;
+	struct rt6_info *rt;
+	struct flowi6 fl6;
+	int mtu;
+
+	/* Read the IP destination address and resolve the PDP context.
+	 * Prepend PDP header with TEI/TID from PDP ctx.
+	 */
+	ip6h = ipv6_hdr(skb);
+	if (gtp->role == GTP_ROLE_SGSN)
+		pctx = ipv6_pdp_find(gtp, &ip6h->saddr);
+	else
+		pctx = ipv6_pdp_find(gtp, &ip6h->daddr);
+
+	if (!pctx) {
+		netdev_dbg(dev, "no PDP ctx found for %pI6, skip\n",
+			   &ip6h->daddr);
+		return -ENOENT;
+	}
+	netdev_dbg(dev, "found PDP context %p\n", pctx);
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
+	gtp_set_pktinfo_ipv6(pktinfo, pctx->sk, ip6h, pctx, rt, &fl6, dev);
+	gtp_push_header(skb, pktinfo);
+
+	return 0;
+err_rt:
+	dst_release(dst);
+err:
+	return -EBADMSG;
+}
+
 static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	unsigned int proto = ntohs(skb->protocol);
@@ -977,6 +1139,9 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	case ETH_P_IP:
 		err = gtp_build_skb_ip4(skb, dev, &pktinfo);
 		break;
+	case ETH_P_IPV6:
+		err = gtp_build_skb_ip6(skb, dev, &pktinfo);
+		break;
 	default:
 		err = -EOPNOTSUPP;
 		break;
@@ -1000,6 +1165,21 @@ static netdev_tx_t gtp_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 					    dev_net(dev)),
 				    false);
 		break;
+	case ETH_P_IPV6:
+#if IS_ENABLED(CONFIG_IPV6)
+		netdev_dbg(pktinfo.dev, "gtp -> IP src: %pI6 dst: %pI6\n",
+			   &pktinfo.ip6h->saddr, &pktinfo.ip6h->daddr);
+		udp_tunnel6_xmit_skb(&pktinfo.rt6->dst, pktinfo.sk, skb, dev,
+				     &pktinfo.fl6.saddr, &pktinfo.fl6.daddr,
+				     ipv6_get_dsfield(pktinfo.ip6h),
+				     ip6_dst_hoplimit(&pktinfo.rt->dst),
+				     0,
+				     pktinfo.gtph_port, pktinfo.gtph_port,
+				     false);
+#else
+		goto tx_err;
+#endif
+		break;
 	}
 
 	return NETDEV_TX_OK;
@@ -1057,17 +1237,45 @@ static void gtp_destructor(struct net_device *dev)
 	kfree(gtp->tid_hash);
 }
 
-static struct sock *gtp_create_sock(int type, struct gtp_dev *gtp)
+static int gtp_sock_udp_config(struct udp_port_cfg *udp_conf,
+			       const struct nlattr *nla, int family)
+{
+	udp_conf->family = family;
+
+	switch (udp_conf->family) {
+	case AF_INET:
+		udp_conf->local_ip.s_addr = nla_get_be32(nla);
+		break;
+#if IS_ENABLED(CONFIG_IPV6)
+	case AF_INET6:
+		udp_conf->local_ip6 = nla_get_in6_addr(nla);
+		break;
+#endif
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static struct sock *gtp_create_sock(int type, struct gtp_dev *gtp,
+				    const struct nlattr *nla, int family)
 {
 	struct udp_tunnel_sock_cfg tuncfg = {};
-	struct udp_port_cfg udp_conf = {
-		.local_ip.s_addr	= htonl(INADDR_ANY),
-		.family			= AF_INET,
-	};
+	struct udp_port_cfg udp_conf = {};
 	struct net *net = gtp->net;
 	struct socket *sock;
 	int err;
 
+	if (nla) {
+		err = gtp_sock_udp_config(&udp_conf, nla, family);
+		if (err < 0)
+			return ERR_PTR(err);
+	} else {
+		udp_conf.local_ip.s_addr = htonl(INADDR_ANY);
+		udp_conf.family = AF_INET;
+	}
+
 	if (type == UDP_ENCAP_GTP0)
 		udp_conf.local_udp_port = htons(GTP0_PORT);
 	else if (type == UDP_ENCAP_GTP1U)
@@ -1089,16 +1297,17 @@ static struct sock *gtp_create_sock(int type, struct gtp_dev *gtp)
 	return sock->sk;
 }
 
-static int gtp_create_sockets(struct gtp_dev *gtp, struct nlattr *data[])
+static int gtp_create_sockets(struct gtp_dev *gtp, const struct nlattr *nla,
+			      int family)
 {
 	struct sock *sk1u;
 	struct sock *sk0;
 
-	sk0 = gtp_create_sock(UDP_ENCAP_GTP0, gtp);
+	sk0 = gtp_create_sock(UDP_ENCAP_GTP0, gtp, nla, family);
 	if (IS_ERR(sk0))
 		return PTR_ERR(sk0);
 
-	sk1u = gtp_create_sock(UDP_ENCAP_GTP1U, gtp);
+	sk1u = gtp_create_sock(UDP_ENCAP_GTP1U, gtp, nla, family);
 	if (IS_ERR(sk1u)) {
 		udp_tunnel_sock_release(sk0->sk_socket);
 		return PTR_ERR(sk1u);
@@ -1111,6 +1320,9 @@ static int gtp_create_sockets(struct gtp_dev *gtp, struct nlattr *data[])
 	return 0;
 }
 
+#define GTP_TH_MAXLEN	(sizeof(struct udphdr) + sizeof(struct gtp0_header))
+#define GTP_IPV6_MAXLEN	(sizeof(struct ipv6hdr) + GTP_TH_MAXLEN)
+
 static int gtp_newlink(struct net *src_net, struct net_device *dev,
 		       struct nlattr *tb[], struct nlattr *data[],
 		       struct netlink_ext_ack *extack)
@@ -1120,6 +1332,11 @@ static int gtp_newlink(struct net *src_net, struct net_device *dev,
 	struct gtp_net *gn;
 	int hashsize, err;
 
+#if !IS_ENABLED(CONFIG_IPV6)
+	if (data[IFLA_GTP_LOCAL6])
+		return -EAFNOSUPPORT;
+#endif
+
 	gtp = netdev_priv(dev);
 
 	if (!data[IFLA_GTP_PDP_HASHSIZE]) {
@@ -1148,13 +1365,24 @@ static int gtp_newlink(struct net *src_net, struct net_device *dev,
 	if (err < 0)
 		return err;
 
-	if (data[IFLA_GTP_CREATE_SOCKETS])
-		err = gtp_create_sockets(gtp, data);
-	else
+	if (data[IFLA_GTP_CREATE_SOCKETS]) {
+		if (data[IFLA_GTP_LOCAL6])
+			err = gtp_create_sockets(gtp, data[IFLA_GTP_LOCAL6], AF_INET6);
+		else
+			err = gtp_create_sockets(gtp, data[IFLA_GTP_LOCAL], AF_INET);
+	} else {
 		err = gtp_encap_enable(gtp, data);
+	}
+
 	if (err < 0)
 		goto out_hashtable;
 
+	if ((gtp->sk0 && gtp->sk0->sk_family == AF_INET6) ||
+	    (gtp->sk1u && gtp->sk1u->sk_family == AF_INET6)) {
+		dev->mtu = ETH_DATA_LEN - GTP_IPV6_MAXLEN;
+		dev->needed_headroom = LL_MAX_HEADER + GTP_IPV6_MAXLEN;
+	}
+
 	err = register_netdevice(dev);
 	if (err < 0) {
 		netdev_dbg(dev, "failed to register new netdev %d\n", err);
@@ -1198,6 +1426,8 @@ static const struct nla_policy gtp_policy[IFLA_GTP_MAX + 1] = {
 	[IFLA_GTP_ROLE]			= { .type = NLA_U32 },
 	[IFLA_GTP_CREATE_SOCKETS]	= { .type = NLA_U8 },
 	[IFLA_GTP_RESTART_COUNT]	= { .type = NLA_U8 },
+	[IFLA_GTP_LOCAL]		= { .type = NLA_U32 },
+	[IFLA_GTP_LOCAL6]		= { .len = sizeof(struct in6_addr) },
 };
 
 static int gtp_validate(struct nlattr *tb[], struct nlattr *data[],
@@ -1297,6 +1527,12 @@ static struct sock *gtp_encap_enable_socket(int fd, int type,
 		goto out_sock;
 	}
 
+	if (sk->sk_family == AF_INET6 &&
+	    !sk->sk_ipv6only) {
+		sk = ERR_PTR(-EADDRNOTAVAIL);
+		goto out_sock;
+	}
+
 	lock_sock(sk);
 	if (sk->sk_user_data) {
 		sk = ERR_PTR(-EBUSY);
@@ -1348,6 +1584,13 @@ static int gtp_encap_enable(struct gtp_dev *gtp, struct nlattr *data[])
 	gtp->sk0 = sk0;
 	gtp->sk1u = sk1u;
 
+	if (sk0 && sk1u &&
+	    sk0->sk_family != sk1u->sk_family) {
+		gtp_encap_disable_sock(sk0);
+		gtp_encap_disable_sock(sk1u);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -1377,14 +1620,9 @@ static struct gtp_dev *gtp_find_dev(struct net *src_net, struct nlattr *nla[])
 	return gtp;
 }
 
-static void ipv4_pdp_fill(struct pdp_ctx *pctx, struct genl_info *info)
+static void gtp_pdp_fill(struct pdp_ctx *pctx, struct genl_info *info)
 {
 	pctx->gtp_version = nla_get_u32(info->attrs[GTPA_VERSION]);
-	pctx->af = AF_INET;
-	pctx->peer.addr.s_addr =
-		nla_get_be32(info->attrs[GTPA_PEER_ADDRESS]);
-	pctx->ms.addr.s_addr =
-		nla_get_be32(info->attrs[GTPA_MS_ADDRESS]);
 
 	switch (pctx->gtp_version) {
 	case GTP_V0:
@@ -1404,21 +1642,78 @@ static void ipv4_pdp_fill(struct pdp_ctx *pctx, struct genl_info *info)
 	}
 }
 
+static void ipv4_pdp_fill(struct pdp_ctx *pctx, struct genl_info *info)
+{
+	pctx->peer.addr.s_addr =
+		nla_get_be32(info->attrs[GTPA_PEER_ADDRESS]);
+	pctx->ms.addr.s_addr =
+		nla_get_be32(info->attrs[GTPA_MS_ADDRESS]);
+	gtp_pdp_fill(pctx, info);
+}
+
+static void ipv6_pdp_fill(struct pdp_ctx *pctx, struct genl_info *info)
+{
+	pctx->peer.addr6 = nla_get_in6_addr(info->attrs[GTPA_PEER_ADDR6]);
+	pctx->ms.addr6 = nla_get_in6_addr(info->attrs[GTPA_MS_ADDR6]);
+	gtp_pdp_fill(pctx, info);
+}
+
 static struct pdp_ctx *gtp_pdp_add(struct gtp_dev *gtp, struct sock *sk,
 				   struct genl_info *info)
 {
 	struct pdp_ctx *pctx, *pctx_tid = NULL;
 	struct net_device *dev = gtp->dev;
 	u32 hash_ms, hash_tid = 0;
+	struct in6_addr ms_addr6;
 	unsigned int version;
 	bool found = false;
 	__be32 ms_addr;
+	int family;
 
-	ms_addr = nla_get_be32(info->attrs[GTPA_MS_ADDRESS]);
-	hash_ms = ipv4_hashfn(ms_addr) % gtp->hash_size;
 	version = nla_get_u32(info->attrs[GTPA_VERSION]);
 
-	pctx = ipv4_pdp_find(gtp, ms_addr);
+	if (info->attrs[GTPA_FAMILY])
+		family = nla_get_u8(info->attrs[GTPA_FAMILY]);
+	else
+		family = AF_INET;
+
+#if !IS_ENABLED(CONFIG_IPV6)
+	if (family == AF_INET6)
+		return ERR_PTR(-EAFNOSUPPORT);
+#endif
+
+	if ((info->attrs[GTPA_PEER_ADDRESS] &&
+	     sk->sk_family == AF_INET6) ||
+	    (info->attrs[GTPA_PEER_ADDR6] &&
+	     sk->sk_family == AF_INET))
+		return ERR_PTR(-EAFNOSUPPORT);
+
+	switch (family) {
+	case AF_INET:
+		if (!info->attrs[GTPA_MS_ADDRESS] ||
+		    !info->attrs[GTPA_PEER_ADDRESS] ||
+		    info->attrs[GTPA_MS_ADDR6] ||
+		    info->attrs[GTPA_PEER_ADDR6])
+			return ERR_PTR(-EINVAL);
+
+		ms_addr = nla_get_be32(info->attrs[GTPA_MS_ADDRESS]);
+		hash_ms = ipv4_hashfn(ms_addr) % gtp->hash_size;
+		pctx = ipv4_pdp_find(gtp, ms_addr);
+		break;
+	case AF_INET6:
+		if (!info->attrs[GTPA_MS_ADDR6] ||
+		    !info->attrs[GTPA_PEER_ADDR6] ||
+		    info->attrs[GTPA_MS_ADDRESS] ||
+		    info->attrs[GTPA_PEER_ADDRESS])
+			return ERR_PTR(-EINVAL);
+
+		ms_addr6 = nla_get_in6_addr(info->attrs[GTPA_MS_ADDR6]);
+		hash_ms = ipv6_hashfn(&ms_addr6) % gtp->hash_size;
+		pctx = ipv6_pdp_find(gtp, &ms_addr6);
+		break;
+	default:
+		return ERR_PTR(-EAFNOSUPPORT);
+	}
 	if (pctx)
 		found = true;
 	if (version == GTP_V0)
@@ -1441,7 +1736,14 @@ static struct pdp_ctx *gtp_pdp_add(struct gtp_dev *gtp, struct sock *sk,
 		if (!pctx)
 			pctx = pctx_tid;
 
-		ipv4_pdp_fill(pctx, info);
+		switch (pctx->af) {
+		case AF_INET:
+			ipv4_pdp_fill(pctx, info);
+			break;
+		case AF_INET6:
+			ipv6_pdp_fill(pctx, info);
+			break;
+		}
 
 		if (pctx->gtp_version == GTP_V0)
 			netdev_dbg(dev, "GTPv0-U: update tunnel id = %llx (pdp %p)\n",
@@ -1461,7 +1763,24 @@ static struct pdp_ctx *gtp_pdp_add(struct gtp_dev *gtp, struct sock *sk,
 	sock_hold(sk);
 	pctx->sk = sk;
 	pctx->dev = gtp->dev;
-	ipv4_pdp_fill(pctx, info);
+	pctx->af = family;
+
+	switch (pctx->af) {
+	case AF_INET:
+		if (!info->attrs[GTPA_MS_ADDRESS] ||
+		    !info->attrs[GTPA_PEER_ADDRESS])
+			return ERR_PTR(-EINVAL);
+
+		ipv4_pdp_fill(pctx, info);
+		break;
+	case AF_INET6:
+		if (!info->attrs[GTPA_MS_ADDR6] ||
+		    !info->attrs[GTPA_PEER_ADDR6])
+			return ERR_PTR(-EINVAL);
+
+		ipv6_pdp_fill(pctx, info);
+		break;
+	}
 	atomic_set(&pctx->tx_seq, 0);
 
 	switch (pctx->gtp_version) {
@@ -1523,9 +1842,7 @@ static int gtp_genl_new_pdp(struct sk_buff *skb, struct genl_info *info)
 	int err;
 
 	if (!info->attrs[GTPA_VERSION] ||
-	    !info->attrs[GTPA_LINK] ||
-	    !info->attrs[GTPA_PEER_ADDRESS] ||
-	    !info->attrs[GTPA_MS_ADDRESS])
+	    !info->attrs[GTPA_LINK])
 		return -EINVAL;
 
 	version = nla_get_u32(info->attrs[GTPA_VERSION]);
@@ -1592,6 +1909,10 @@ static struct pdp_ctx *gtp_find_pdp_by_link(struct net *net,
 		__be32 ip = nla_get_be32(nla[GTPA_MS_ADDRESS]);
 
 		return ipv4_pdp_find(gtp, ip);
+	} else if (nla[GTPA_MS_ADDR6]) {
+		struct in6_addr addr = nla_get_in6_addr(nla[GTPA_MS_ADDR6]);
+
+		return ipv6_pdp_find(gtp, &addr);
 	} else if (nla[GTPA_VERSION]) {
 		u32 gtp_version = nla_get_u32(nla[GTPA_VERSION]);
 
@@ -1662,10 +1983,22 @@ static int gtp_genl_fill_info(struct sk_buff *skb, u32 snd_portid, u32 snd_seq,
 
 	if (nla_put_u32(skb, GTPA_VERSION, pctx->gtp_version) ||
 	    nla_put_u32(skb, GTPA_LINK, pctx->dev->ifindex) ||
-	    nla_put_be32(skb, GTPA_PEER_ADDRESS, pctx->peer.addr.s_addr) ||
-	    nla_put_be32(skb, GTPA_MS_ADDRESS, pctx->ms.addr.s_addr))
+	    nla_put_u8(skb, GTPA_FAMILY, pctx->af))
 		goto nla_put_failure;
 
+	switch (pctx->af) {
+	case AF_INET:
+		if (nla_put_be32(skb, GTPA_PEER_ADDRESS, pctx->peer.addr.s_addr) ||
+		    nla_put_be32(skb, GTPA_MS_ADDRESS, pctx->ms.addr.s_addr))
+			goto nla_put_failure;
+		break;
+	case AF_INET6:
+		if (nla_put_in6_addr(skb, GTPA_PEER_ADDR6, &pctx->peer.addr6) ||
+		    nla_put_in6_addr(skb, GTPA_MS_ADDR6, &pctx->ms.addr6))
+			goto nla_put_failure;
+		break;
+	}
+
 	switch (pctx->gtp_version) {
 	case GTP_V0:
 		if (nla_put_u64_64bit(skb, GTPA_TID, pctx->u.v0.tid, GTPA_PAD) ||
@@ -1892,6 +2225,9 @@ static const struct nla_policy gtp_genl_policy[GTPA_MAX + 1] = {
 	[GTPA_NET_NS_FD]	= { .type = NLA_U32, },
 	[GTPA_I_TEI]		= { .type = NLA_U32, },
 	[GTPA_O_TEI]		= { .type = NLA_U32, },
+	[GTPA_PEER_ADDR6]	= { .len = sizeof(struct in6_addr), },
+	[GTPA_MS_ADDR6]		= { .len = sizeof(struct in6_addr), },
+	[GTPA_FAMILY]		= { .type = NLA_U8, },
 };
 
 static const struct genl_small_ops gtp_genl_ops[] = {
diff --git a/include/uapi/linux/gtp.h b/include/uapi/linux/gtp.h
index 3dcdb9e33cba..40f5388d6de0 100644
--- a/include/uapi/linux/gtp.h
+++ b/include/uapi/linux/gtp.h
@@ -31,6 +31,9 @@ enum gtp_attrs {
 	GTPA_I_TEI,	/* for GTPv1 only */
 	GTPA_O_TEI,	/* for GTPv1 only */
 	GTPA_PAD,
+	GTPA_PEER_ADDR6,
+	GTPA_MS_ADDR6,
+	GTPA_FAMILY,
 	__GTPA_MAX,
 };
 #define GTPA_MAX (__GTPA_MAX - 1)
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index ffa637b38c93..c37cf994f4de 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1466,6 +1466,8 @@ enum {
 	IFLA_GTP_ROLE,
 	IFLA_GTP_CREATE_SOCKETS,
 	IFLA_GTP_RESTART_COUNT,
+	IFLA_GTP_LOCAL,
+	IFLA_GTP_LOCAL6,
 	__IFLA_GTP_MAX,
 };
 #define IFLA_GTP_MAX (__IFLA_GTP_MAX - 1)
-- 
2.30.2


