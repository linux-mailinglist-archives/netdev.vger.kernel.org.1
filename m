Return-Path: <netdev+bounces-40995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5AF7C94B4
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 15:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19F4FB20B50
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 13:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE08125B8;
	Sat, 14 Oct 2023 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lafranque.net header.i=@lafranque.net header.b="ikTjFgDP"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FAC53B9
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 13:21:44 +0000 (UTC)
Received: from mail.lac-coloc.fr (unknown [45.90.160.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BAEB7
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 06:21:41 -0700 (PDT)
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
Subject: [PATCH net-next v4] vxlan: add support for flowlabel inherit
Date: Sat, 14 Oct 2023 08:21:02 -0500
Message-Id: <20231014132102.54051-1-alce@lafranque.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received: from localhost (Unknown [127.0.0.1])
	by mail.lac-coloc.fr (Haraka/3.0.1) with ESMTPSA id 3A4207B6-6CB3-42C6-8E43-95C7F46EBFD6.1
	envelope-from <alce@lafranque.net>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Sat, 14 Oct 2023 13:21:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lafranque.net; s=s20211111873;
	h=from:subject:date:message-id:to:cc:mime-version;
	bh=BEO9SaI9W2YVQxHVTM006+i0nnIFVYvZHcNw4AV/roM=;
	b=ikTjFgDP0fNaGQbp22+Inm81U177+bixhecRAQpzIzzJIw4tFYr92WVPhpjJW3DkutXh0y8sQI
	dLy9ifqOGRnbXKXsudvNj5qSkESCR/kbrytMmhiXxeK5ftlykkCMf0lNyO295L6bQUVWdBPuqu5E
	di7qOEMBZifaSAUotsgNQ=
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MSGID_FROM_MTA_HEADER,RDNS_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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

---
v4:
  - Fix tabs
v3: https://lore.kernel.org/all/20231014131320.51810-1-alce@lafranque.net/
  - Adopt policy label inherit by default
  - Set policy to label fixed when flowlabel is set
  - Rename IFLA_VXLAN_LABEL_BEHAVIOR to IFLA_VXLAN_LABEL_POLICY
v2: https://lore.kernel.org/all/20231007142624.739192-1-alce@lafranque.net/
  - Use an enum instead of flag to define label behavior
v1: https://lore.kernel.org/all/4444C5AE-FA5A-49A4-9700-7DD9D7916C0F.1@mail.lac-coloc.fr/
---
 drivers/net/vxlan/vxlan_core.c | 30 ++++++++++++++++++++++++++----
 include/net/ip_tunnels.h       | 11 +++++++++++
 include/net/vxlan.h            | 33 +++++++++++++++++----------------
 include/uapi/linux/if_link.h   |  8 ++++++++
 4 files changed, 62 insertions(+), 20 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 5b5597073b00..48ebbd4563f0 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2475,7 +2475,17 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		else
 			udp_sum = !(flags & VXLAN_F_UDP_ZERO_CSUM6_TX);
 #if IS_ENABLED(CONFIG_IPV6)
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
@@ -3286,6 +3296,7 @@ static const struct nla_policy vxlan_policy[IFLA_VXLAN_MAX + 1] = {
 	[IFLA_VXLAN_DF]		= { .type = NLA_U8 },
 	[IFLA_VXLAN_VNIFILTER]	= { .type = NLA_U8 },
 	[IFLA_VXLAN_LOCALBYPASS]	= NLA_POLICY_MAX(NLA_U8, 1),
+	[IFLA_VXLAN_LABEL_POLICY]	= NLA_POLICY_MAX(NLA_U8, VXLAN_LABEL_MAX),
 };
 
 static int vxlan_validate(struct nlattr *tb[], struct nlattr *data[],
@@ -3653,13 +3664,18 @@ static int vxlan_config_validate(struct net *src_net, struct vxlan_config *conf,
 			}
 		}
 	}
-
 	if (conf->label && !use_ipv6) {
 		NL_SET_ERR_MSG(extack,
 			       "Label attribute only applies to IPv6 VXLAN devices");
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
 
@@ -3999,9 +4015,13 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],
 
 	}
 
-	if (data[IFLA_VXLAN_LABEL])
+	if (data[IFLA_VXLAN_LABEL]) {
 		conf->label = nla_get_be32(data[IFLA_VXLAN_LABEL]) &
-			     IPV6_FLOWLABEL_MASK;
+			      IPV6_FLOWLABEL_MASK;
+		conf->label_policy = VXLAN_LABEL_FIXED;
+	}
+	if (data[IFLA_VXLAN_LABEL_POLICY])
+		conf->label_policy = nla_get_u8(data[IFLA_VXLAN_LABEL_POLICY]);
 
 	if (data[IFLA_VXLAN_LEARNING]) {
 		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_LEARNING,
@@ -4315,6 +4335,7 @@ static size_t vxlan_get_size(const struct net_device *dev)
 		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_TOS */
 		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_DF */
 		nla_total_size(sizeof(__be32)) + /* IFLA_VXLAN_LABEL */
+		nla_total_size(sizeof(__u8)) +  /* IFLA_VXLAN_LABEL_POLICY */
 		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_LEARNING */
 		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_PROXY */
 		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_RSC */
@@ -4387,6 +4408,7 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
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
index fac351a93aed..d2f7760174ca 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -830,6 +830,7 @@ enum {
 	IFLA_VXLAN_DF,
 	IFLA_VXLAN_VNIFILTER, /* only applicable with COLLECT_METADATA mode */
 	IFLA_VXLAN_LOCALBYPASS,
+	IFLA_VXLAN_LABEL_POLICY,
 	__IFLA_VXLAN_MAX
 };
 #define IFLA_VXLAN_MAX	(__IFLA_VXLAN_MAX - 1)
@@ -847,6 +848,13 @@ enum ifla_vxlan_df {
 	VXLAN_DF_MAX = __VXLAN_DF_END - 1,
 };
 
+enum ifla_vxlan_label_policy {
+	VXLAN_LABEL_INHERIT = 0,
+	VXLAN_LABEL_FIXED = 1,
+	__VXLAN_LABEL_END,
+	VXLAN_LABEL_MAX = __VXLAN_LABEL_END - 1,
+};
+
 /* GENEVE section */
 enum {
 	IFLA_GENEVE_UNSPEC,
-- 
2.39.2


