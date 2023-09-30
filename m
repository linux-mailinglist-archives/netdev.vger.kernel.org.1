Return-Path: <netdev+bounces-37183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E237B4182
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 17:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 1D3B31C209F8
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 15:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9362B168C1;
	Sat, 30 Sep 2023 15:14:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8551F9CF
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 15:14:18 +0000 (UTC)
X-Greylist: delayed 66 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 30 Sep 2023 08:14:16 PDT
Received: from mail.lac-coloc.fr (unknown [45.90.160.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C29E3
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 08:14:16 -0700 (PDT)
From: Alce Lafranque <alce@lafranque.net>
Date: Sat, 30 Sep 2023 09:28:19 -0500
Subject: [PATCH net-next] vxlan: add support for flowlabel inherit
To: "David S. Miller" <davem@davemloft.net>,Eric Dumazet <edumazet@google.com>,Jakub Kicinski <kuba@kernel.org>,Paolo Abeni <pabeni@redhat.com>,David Ahern <dsahern@kernel.org>,Ido Schimmel <idosch@nvidia.com>,netdev@vger.kernel.org
Cc: vincent@bernat.ch,alce@lafranque.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=lafranque.net; s=s20211111873;
	h=from:subject:date:to:cc;
	bh=Um5YkX03ehaVd/MfspYNlTkm6R9vB+H3y3t6QneUThI=;
	b=jwlWhAKCmIq1GY2r5H8OOHsHxR90IMAh5UvQfvW0GTm4jjpiTs4dc26DVEH3tydadSEGO2U6nJ
	v5bCi/OpGDCWAB3jonho6iH2ocxhCRCXnPXlWJOBDJOBqdkvLQw0IYsSGcU0do60GsX1tEXiNe1A
	tqF4UbtXGwJi4xTeNKX+o=
Received: from localhost (Unknown [127.0.0.1])
	by mail.lac-coloc.fr (Haraka/3.0.1) with ESMTP id 4444C5AE-FA5A-49A4-9700-7DD9D7916C0F.1
	envelope-from <alce@lafranque.net>;
	Sat, 30 Sep 2023 15:12:43 +0000
Message-Id: <4444C5AE-FA5A-49A4-9700-7DD9D7916C0F.1@mail.lac-coloc.fr>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

By default, VXLAN encapsulation over IPv6 sets the flow label to 0, with an
option for a fixed value. This commits add the ability to inherit the flow
label from the inner packet, like for other tunnel implementations.

```
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
 drivers/net/vxlan/vxlan_core.c | 20 ++++++++++++++++++--
 include/net/ip_tunnels.h       | 11 +++++++++++
 include/net/vxlan.h            |  2 ++
 include/uapi/linux/if_link.h   |  1 +
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 5b5597073b00..aa7fbfdd93b1 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2475,7 +2475,11 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		else
 			udp_sum = !(flags & VXLAN_F_UDP_ZERO_CSUM6_TX);
 #if IS_ENABLED(CONFIG_IPV6)
-		label = vxlan->cfg.label;
+		if (flags & VXLAN_F_LABEL_INHERIT) {
+			label = ip_tunnel_get_flowlabel(old_iph, skb);
+		} else {
+			label = vxlan->cfg.label;
+		}
 #endif
 	} else {
 		if (!info) {
@@ -3286,6 +3290,7 @@ static const struct nla_policy vxlan_policy[IFLA_VXLAN_MAX + 1] = {
 	[IFLA_VXLAN_DF]		= { .type = NLA_U8 },
 	[IFLA_VXLAN_VNIFILTER]	= { .type = NLA_U8 },
 	[IFLA_VXLAN_LOCALBYPASS]	= NLA_POLICY_MAX(NLA_U8, 1),
+	[IFLA_VXLAN_LABEL_INHERIT]	= { .type = NLA_FLAG },
 };

 static int vxlan_validate(struct nlattr *tb[], struct nlattr *data[],
@@ -4001,7 +4006,15 @@ static int vxlan_nl2conf(struct nlattr *tb[], struct nlattr *data[],

 	if (data[IFLA_VXLAN_LABEL])
 		conf->label = nla_get_be32(data[IFLA_VXLAN_LABEL]) &
-			     IPV6_FLOWLABEL_MASK;
+			      IPV6_FLOWLABEL_MASK;
+
+	if (data[IFLA_VXLAN_LABEL_INHERIT]) {
+		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_LABEL_INHERIT,
+				    VXLAN_F_LABEL_INHERIT, changelink, false,
+				    extack);
+		if (err)
+			return err;
+	}

 	if (data[IFLA_VXLAN_LEARNING]) {
 		err = vxlan_nl2flag(conf, data, IFLA_VXLAN_LEARNING,
@@ -4315,6 +4328,7 @@ static size_t vxlan_get_size(const struct net_device *dev)
 		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_TOS */
 		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_DF */
 		nla_total_size(sizeof(__be32)) + /* IFLA_VXLAN_LABEL */
+		nla_total_size(sizeof(__u8)) +  /* IFLA_VXLAN_LABEL_INHERIT */
 		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_LEARNING */
 		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_PROXY */
 		nla_total_size(sizeof(__u8)) +	/* IFLA_VXLAN_RSC */
@@ -4387,6 +4401,8 @@ static int vxlan_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	    nla_put_u8(skb, IFLA_VXLAN_TOS, vxlan->cfg.tos) ||
 	    nla_put_u8(skb, IFLA_VXLAN_DF, vxlan->cfg.df) ||
 	    nla_put_be32(skb, IFLA_VXLAN_LABEL, vxlan->cfg.label) ||
+	    nla_put_u8(skb, IFLA_VXLAN_LABEL_INHERIT,
+		       !!(vxlan->cfg.flags & VXLAN_F_LABEL_INHERIT)) ||
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
index 6a9f8a5f387c..f82ce013c8ff 100644
--- a/include/net/vxlan.h
+++ b/include/net/vxlan.h
@@ -329,6 +329,7 @@ struct vxlan_dev {
 #define VXLAN_F_VNIFILTER               0x20000
 #define VXLAN_F_MDB			0x40000
 #define VXLAN_F_LOCALBYPASS		0x80000
+#define VXLAN_F_LABEL_INHERIT		0x100000

 /* Flags that are used in the receive path. These flags must match in
  * order for a socket to be shareable
@@ -534,6 +535,7 @@ static inline void vxlan_flag_attr_error(int attrtype,
 		break
 	switch (attrtype) {
 	VXLAN_FLAG(TTL_INHERIT);
+	VXLAN_FLAG(LABEL_INHERIT);
 	VXLAN_FLAG(LEARNING);
 	VXLAN_FLAG(PROXY);
 	VXLAN_FLAG(RSC);
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index fac351a93aed..bd69af34feba 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -830,6 +830,7 @@ enum {
 	IFLA_VXLAN_DF,
 	IFLA_VXLAN_VNIFILTER, /* only applicable with COLLECT_METADATA mode */
 	IFLA_VXLAN_LOCALBYPASS,
+	IFLA_VXLAN_LABEL_INHERIT,
 	__IFLA_VXLAN_MAX
 };
 #define IFLA_VXLAN_MAX	(__IFLA_VXLAN_MAX - 1)
--
2.39.2

