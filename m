Return-Path: <netdev+bounces-43318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06327D2596
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 21:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB7328138D
	for <lists+netdev@lfdr.de>; Sun, 22 Oct 2023 19:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DC010A09;
	Sun, 22 Oct 2023 19:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lafranque.net header.i=@lafranque.net header.b="qVO3yFD8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3B9569E
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 19:15:34 +0000 (UTC)
Received: from mail.lac-coloc.fr (unknown [45.90.160.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB8ABE
	for <netdev@vger.kernel.org>; Sun, 22 Oct 2023 12:15:32 -0700 (PDT)
Authentication-Results: mail.lac-coloc.fr;
	auth=pass (plain)
From: Alce Lafranque <alce@lafranque.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	netdev@vger.kernel.org
Cc: Alce Lafranque <alce@lafranque.net>,
	Vincent Bernat <vincent@bernat.ch>
Subject: [PATCH net-next v6] vxlan: add support for flowlabel inherit
Date: Sun, 22 Oct 2023 14:14:44 -0500
Message-Id: <20231022191444.220695-1-alce@lafranque.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received: from localhost (Unknown [127.0.0.1])
	by mail.lac-coloc.fr (Haraka/3.0.1) with ESMTPSA id 9F4C4CA0-0DC2-48E7-9DAA-89489A144F57.1
	envelope-from <alce@lafranque.net>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Sun, 22 Oct 2023 19:15:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lafranque.net; s=s20211111873;
	h=from:subject:date:message-id:to:cc:mime-version;
	bh=D7C8m5DS3/wcC2omuaMt0mvi57MN2G/4wno0GJwSlpI=;
	b=qVO3yFD8LI+kq3pJTBInRUjHOLeXpbcqUAtG1nEi2CFEMXiNQnkoAUE2gtXULxT9Kz9I02QVKg
	POaafOXhTTTBPGJd4YqeZGsk0OnH4mC9mZV5ne1072rCKCKwsTpAj2kbzhFfjXNTSQrcL9MS6rds
	0/txrSqCb9NvB9nQK71F0=

By default, VXLAN encapsulation over IPv6 sets the flow label to 0, with
an option for a fixed value. This commits add the ability to inherit the
flow label from the inner packet, like for other tunnel implementations.
This enables devices using only L3 headers for ECMP to correctly balance
VXLAN-encapsulated IPv6 packets.

```
$ ./ip/ip link add dummy1 type dummy
$ ./ip/ip addr add 2001:db8::2/64 dev dummy1
$ ./ip/ip link set up dev dummy1
$ ./ip/ip link add vxlan1 type vxlan id 100 flowlabel inherit remote 2001:db8::1 local 2001:db8::2
$ ./ip/ip link set up dev vxlan1
$ ./ip/ip addr add 2001:db8:1::2/64 dev vxlan1
$ ./ip/ip link set arp off dev vxlan1
$ ping -q 2001:db8:1::1 &
$ tshark -d udp.port==8472,vxlan -Vpni dummy1 -c1
[...]
Internet Protocol Version 6, Src: 2001:db8::2, Dst: 2001:db8::1
    0110 .... = Version: 6
    .... 0000 0000 .... .... .... .... .... = Traffic Class: 0x00 (DSCP: CS0, ECN: Not-ECT)
        .... 0000 00.. .... .... .... .... .... = Differentiated Services Codepoint: Default (0)
        .... .... ..00 .... .... .... .... .... = Explicit Congestion Notification: Not ECN-Capable Transport (0)
    .... 1011 0001 1010 1111 1011 = Flow Label: 0xb1afb
[...]
Virtual eXtensible Local Area Network
    Flags: 0x0800, VXLAN Network ID (VNI)
    Group Policy ID: 0
    VXLAN Network Identifier (VNI): 100
[...]
Internet Protocol Version 6, Src: 2001:db8:1::2, Dst: 2001:db8:1::1
    0110 .... = Version: 6
    .... 0000 0000 .... .... .... .... .... = Traffic Class: 0x00 (DSCP: CS0, ECN: Not-ECT)
        .... 0000 00.. .... .... .... .... .... = Differentiated Services Codepoint: Default (0)
        .... .... ..00 .... .... .... .... .... = Explicit Congestion Notification: Not ECN-Capable Transport (0)
    .... 1011 0001 1010 1111 1011 = Flow Label: 0xb1afb
```

Signed-off-by: Alce Lafranque <alce@lafranque.net>
Co-developed-by: Vincent Bernat <vincent@bernat.ch>
Signed-off-by: Vincent Bernat <vincent@bernat.ch>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>

---
v6:
  - Rebase patch
v5: https://lore.kernel.org/netdev/20231019180417.210523-1-alce@lafranque.net/
  - Rollback policy label to fixed by default
v4: https://lore.kernel.org/all/20231014132102.54051-1-alce@lafranque.net/
  - Fix tabs
v3: https://lore.kernel.org/all/20231014131320.51810-1-alce@lafranque.net/
  - Adopt policy label inherit by default
  - Set policy to label fixed when flowlabel is set
  - Rename IFLA_VXLAN_LABEL_BEHAVIOR to IFLA_VXLAN_LABEL_POLICY
v2: https://lore.kernel.org/all/20231007142624.739192-1-alce@lafranque.net/
  - Use an enum instead of flag to define label behavior
v1: https://lore.kernel.org/all/4444C5AE-FA5A-49A4-9700-7DD9D7916C0F.1@mail.lac-coloc.fr/
---
 drivers/net/vxlan/vxlan_core.c | 23 ++++++++++++++++++++++-
 include/net/ip_tunnels.h       | 11 +++++++++++
 include/net/vxlan.h            | 33 +++++++++++++++++----------------
 include/uapi/linux/if_link.h   |  8 ++++++++
 4 files changed, 58 insertions(+), 17 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 6f7d45e3cfa2..341fd5eee9e1 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2443,7 +2443,17 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			udp_sum = !(flags & VXLAN_F_UDP_ZERO_CSUM6_TX);
 #if IS_ENABLED(CONFIG_IPV6)
 		local_ip = vxlan->cfg.saddr;
-		label = vxlan->cfg.label;
+		switch (vxlan->cfg.label_policy) {
+		case VXLAN_LABEL_FIXED:
+			label = vxlan->cfg.label;
+			break;
+		case VXLAN_LABEL_INHERIT:
+			label = ip_tunnel_get_flowlabel(old_iph, skb);
+			break;
+		default:
+			DEBUG_NET_WARN_ON_ONCE(1);
+			goto drop;
+		}
 #endif
 	} else {
 		if (!info) {
@@ -3441,6 +3451,7 @@ static const struct nla_policy vxlan_policy[IFLA_VXLAN_MAX + 1] = {
 	[IFLA_VXLAN_DF]		= { .type = NLA_U8 },
 	[IFLA_VXLAN_VNIFILTER]	= { .type = NLA_U8 },
 	[IFLA_VXLAN_LOCALBYPASS]	= NLA_POLICY_MAX(NLA_U8, 1),
+	[IFLA_VXLAN_LABEL_POLICY]	= NLA_POLICY_MAX(NLA_U8, VXLAN_LABEL_MAX),
 };
 
 static int vxlan_validate(struct nlattr *tb[], struct nlattr *data[],
@@ -3815,6 +3826,12 @@ static int vxlan_config_validate(struct net *src_net, struct vxlan_config *conf,
 		return -EINVAL;
 	}
 
+	if (conf->label_policy && !use_ipv6) {
+		NL_SET_ERR_MSG(extack,
+			       "Label policy only applies to IPv6 VXLAN devices");
+		return -EINVAL;
+	}
+
 	if (conf->remote_ifindex) {
 		struct net_device *lowerdev;
 
@@ -4157,6 +4174,8 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 	if (data[IFLA_VXLAN_LABEL])
 		conf->label = nla_get_be32(data[IFLA_VXLAN_LABEL]) &
 			     IPV6_FLOWLABEL_MASK;
+	if (data[IFLA_VXLAN_LABEL_POLICY])
+		conf->label_policy = nla_get_u8(data[IFLA_VXLAN_LABEL_POLICY]);
 
 	if (data[IFLA_VXLAN_LEARNING]) {
 		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_LEARNING,
@@ -4474,6 +4493,7 @@ static size_t vxlan_get_size(const struct net_device *dev)
 		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_TOS */
 		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_DF */
 		nla_total_size(sizeof(__be32)) + /* IFLA_VXLAN_LABEL */
+		nla_total_size(sizeof(__u8)) +  /* IFLA_VXLAN_LABEL_POLICY */
 		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_LEARNING */
 		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_PROXY */
 		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_RSC */
@@ -4546,6 +4566,7 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	    nla_put_u8(skb, IFLA_VXLAN_TOS, vxlan->cfg.tos) ||
 	    nla_put_u8(skb, IFLA_VXLAN_DF, vxlan->cfg.df) ||
 	    nla_put_be32(skb, IFLA_VXLAN_LABEL, vxlan->cfg.label) ||
+	    nla_put_u8(skb, IFLA_VXLAN_LABEL_POLICY, vxlan->cfg.label_policy) ||
 	    nla_put_u8(skb, IFLA_VXLAN_LEARNING,
 		       !!(vxlan->cfg.flags & VXLAN_F_LEARN)) ||
 	    nla_put_u8(skb, IFLA_VXLAN_PROXY,
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index f346b4efbc30..2d746f4c9a0a 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -416,6 +416,17 @@ static inline u8 ip_tunnel_get_dsfield(const struct iphdr *iph,
 		return 0;
 }
 
+static inline __be32 ip_tunnel_get_flowlabel(const struct iphdr *iph,
+					     const struct sk_buff *skb)
+{
+	__be16 payload_protocol = skb_protocol(skb, true);
+
+	if (payload_protocol == htons(ETH_P_IPV6))
+		return ip6_flowlabel((const struct ipv6hdr *)iph);
+	else
+		return 0;
+}
+
 static inline u8 ip_tunnel_get_ttl(const struct iphdr *iph,
 				       const struct sk_buff *skb)
 {
diff --git a/include/net/vxlan.h b/include/net/vxlan.h
index 6a9f8a5f387c..33ba6fc151cf 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -210,22 +210,23 @@ struct vxlan_rdst {
 };
 
 struct vxlan_config {
-	union vxlan_addr	remote_ip;
-	union vxlan_addr	saddr;
-	__be32			vni;
-	int			remote_ifindex;
-	int			mtu;
-	__be16			dst_port;
-	u16			port_min;
-	u16			port_max;
-	u8			tos;
-	u8			ttl;
-	__be32			label;
-	u32			flags;
-	unsigned long		age_interval;
-	unsigned int		addrmax;
-	bool			no_share;
-	enum ifla_vxlan_df	df;
+	union vxlan_addr		remote_ip;
+	union vxlan_addr		saddr;
+	__be32				vni;
+	int				remote_ifindex;
+	int				mtu;
+	__be16				dst_port;
+	u16				port_min;
+	u16				port_max;
+	u8				tos;
+	u8				ttl;
+	__be32				label;
+	enum ifla_vxlan_label_policy	label_policy;
+	u32				flags;
+	unsigned long			age_interval;
+	unsigned int			addrmax;
+	bool				no_share;
+	enum ifla_vxlan_df		df;
 };
 
 enum {
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 9f8a3da0f14f..f71c195b7abf 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -832,6 +832,7 @@ enum {
 	IFLA_VXLAN_DF,
 	IFLA_VXLAN_VNIFILTER, /* only applicable with COLLECT_METADATA mode */
 	IFLA_VXLAN_LOCALBYPASS,
+	IFLA_VXLAN_LABEL_POLICY,
 	__IFLA_VXLAN_MAX
 };
 #define IFLA_VXLAN_MAX	(__IFLA_VXLAN_MAX - 1)
@@ -849,6 +850,13 @@ enum ifla_vxlan_df {
 	VXLAN_DF_MAX = __VXLAN_DF_END - 1,
 };
 
+enum ifla_vxlan_label_policy {
+	VXLAN_LABEL_FIXED = 0,
+	VXLAN_LABEL_INHERIT = 1,
+	__VXLAN_LABEL_END,
+	VXLAN_LABEL_MAX = __VXLAN_LABEL_END - 1,
+};
+
 /* GENEVE section */
 enum {
 	IFLA_GENEVE_UNSPEC,
-- 
2.39.2


