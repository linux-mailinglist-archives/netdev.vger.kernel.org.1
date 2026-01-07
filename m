Return-Path: <netdev+bounces-247726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F6DCFDD1A
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 14:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8977301029B
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 12:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F97315793;
	Wed,  7 Jan 2026 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOlBu6qN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7A8199931
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767790643; cv=none; b=oOPBTjfYFDPnAER3nF1zy/rQ4rDa3GN+vTGXIbXu9Aw/15DViZHCN2Rshfj6SwDMtvqjkPvdr1/Iq6mQ/XrgXXHhE4357427M1qHVXjRRLN3TNXO0Yz9/ETFo1WX21yxE4wm5SIXeHzhQmCymAl1KksIyOLCg+PvPRr9d88K19E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767790643; c=relaxed/simple;
	bh=mEETJasBND2XPwCJNStXzFgWWFgtcQyIC+hE17BKzRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=do6KMcyyFbXki/joniBAqa2kxjoHmt9Ola9V7Kj8wknyc1ks1bRMnJDaCiWKDfS5OV3D9XWKipdaWjAJmJ47Lvk1EngHLHTGDOjIUUKvi2Kfww0BNg0kVwFWRzlWoGFughakwUsHaUptIuR8Vj4I0OHTw/e5Ntvr4TBkV6e2+m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOlBu6qN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81382C19421;
	Wed,  7 Jan 2026 12:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767790643;
	bh=mEETJasBND2XPwCJNStXzFgWWFgtcQyIC+hE17BKzRg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HOlBu6qNquBfkJ2aT/LzBM061XuXQ9cqvkFvglYAbbVzrS18c6y+vzM8H224SMhsW
	 f/pZlDwe2/Uj+p2gJEQdLvGRzMSa3SM6hnk+MverTKOSgQ/qAqntP4adWcVLH5KfTn
	 VlcSFkGb9EQ/tmvZ2+squyE2HKIroI0sRk2RTOcUitM2wCKkuhzbdlGB0Lg5B8CK01
	 bhE/L0BfbC+x5YwYM3tIxMTi6W0VJ1g648MRBfuJcHHKAApNwlkk1APfg523pVQfqp
	 Ls9I5VdR/NCgWXLXHEgFDzhxmCj6ZVJ1et7W/qR1F33ApwBIeUBvXmL6BArFePlmM5
	 GvCf3bsHHAcdw==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 07 Jan 2026 13:57:14 +0100
Subject: [PATCH net-next 1/2] net: dsa: tag_ks8995: Add the KS8995 tag
 handling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-ks8995-dsa-tagging-v1-1-1a92832c1540@kernel.org>
References: <20260107-ks8995-dsa-tagging-v1-0-1a92832c1540@kernel.org>
In-Reply-To: <20260107-ks8995-dsa-tagging-v1-0-1a92832c1540@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

The KS8995 100Mbit switch can do proper DSA per-port tagging
with the proper set-up. This adds the code to handle ingress
and egress KS8995 tags.

The tag is a modified 0x8100 ethertype tag where a bit in the
last byte is set for each target port.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 include/net/dsa.h    |   2 +
 net/dsa/Kconfig      |   6 +++
 net/dsa/Makefile     |   1 +
 net/dsa/tag_ks8995.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 123 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index cced1a866757..b4c1ac14d051 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -57,6 +57,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_BRCM_LEGACY_FCS_VALUE	29
 #define DSA_TAG_PROTO_YT921X_VALUE		30
 #define DSA_TAG_PROTO_MXL_GSW1XX_VALUE		31
+#define DSA_TAG_PROTO_KS8995_VALUE		32
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -91,6 +92,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_VSC73XX_8021Q	= DSA_TAG_PROTO_VSC73XX_8021Q_VALUE,
 	DSA_TAG_PROTO_YT921X		= DSA_TAG_PROTO_YT921X_VALUE,
 	DSA_TAG_PROTO_MXL_GSW1XX	= DSA_TAG_PROTO_MXL_GSW1XX_VALUE,
+	DSA_TAG_PROTO_KS8995		= DSA_TAG_PROTO_KS8995_VALUE,
 };
 
 struct dsa_switch;
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index f86b30742122..c5272dc7af88 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -112,6 +112,12 @@ config NET_DSA_TAG_MXL_GSW1XX
 	  Say Y or M if you want to enable support for tagging frames for
 	  MaxLinear GSW1xx switches.
 
+config NET_DSA_TAG_KS8995
+	tristate "Tag driver for Micrel KS8995 switch"
+	help
+	  Say Y if you want to enable support for tagging frames for the
+	  Micrel KS8995 switch.
+
 config NET_DSA_TAG_KSZ
 	tristate "Tag driver for Microchip 8795/937x/9477/9893 families of switches"
 	help
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index 42d173f5a701..03eed7653a34 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_NET_DSA_TAG_BRCM_COMMON) += tag_brcm.o
 obj-$(CONFIG_NET_DSA_TAG_DSA_COMMON) += tag_dsa.o
 obj-$(CONFIG_NET_DSA_TAG_GSWIP) += tag_gswip.o
 obj-$(CONFIG_NET_DSA_TAG_HELLCREEK) += tag_hellcreek.o
+obj-$(CONFIG_NET_DSA_TAG_KS8995) += tag_ks8995.o
 obj-$(CONFIG_NET_DSA_TAG_KSZ) += tag_ksz.o
 obj-$(CONFIG_NET_DSA_TAG_LAN9303) += tag_lan9303.o
 obj-$(CONFIG_NET_DSA_TAG_MTK) += tag_mtk.o
diff --git a/net/dsa/tag_ks8995.c b/net/dsa/tag_ks8995.c
new file mode 100644
index 000000000000..a5adda4767a3
--- /dev/null
+++ b/net/dsa/tag_ks8995.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Linus Walleij <linusw@kernel.org>
+ */
+#include <linux/etherdevice.h>
+#include <linux/log2.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+
+#include "tag.h"
+
+/* The KS8995 Special Tag Packet ID (STPID)
+ * pushes its tag in a way similar to a VLAN tag
+ * -----------------------------------------------------------
+ * | MAC DA | MAC SA | 2 bytes tag | 2 bytes TCI | EtherType |
+ * -----------------------------------------------------------
+ * The tag is: 0x8100 |= BIT(port), ports 0,1,2,3
+ */
+
+#define KS8995_NAME "ks8995"
+
+#define KS8995_TAG_LEN 4
+
+static struct sk_buff *ks8995_xmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct dsa_port *dp = dsa_user_to_port(dev);
+	u16 ks8995_tag;
+	__be16 *p;
+	u16 port;
+	u16 tci;
+
+	/* Prepare the special KS8995 tags */
+	port = dsa_xmit_port_mask(skb, dev);
+	/* The manual says to set this to the CPU port if no port is indicated */
+	if (!port)
+		port = BIT(5);
+
+	ks8995_tag = ETH_P_8021Q | port;
+	tci = port & VLAN_VID_MASK;
+
+	/* Push in a tag between MAC and ethertype */
+	netdev_dbg(dev, "egress packet tag: add tag %04x %04x to port %d\n",
+		   ks8995_tag, tci, dp->index);
+
+	skb_push(skb, KS8995_TAG_LEN);
+	dsa_alloc_etype_header(skb, KS8995_TAG_LEN);
+
+	p = dsa_etype_header_pos_tx(skb);
+	p[0] = htons(ks8995_tag);
+	p[1] = htons(tci);
+
+	return skb;
+}
+
+static struct sk_buff *ks8995_rcv(struct sk_buff *skb, struct net_device *dev)
+{
+	unsigned int port;
+	__be16 *p;
+	u16 etype;
+	u16 tci;
+
+	if (unlikely(!pskb_may_pull(skb, KS8995_TAG_LEN))) {
+		netdev_err(dev, "dropping packet, cannot pull\n");
+		return NULL;
+	}
+
+	p = dsa_etype_header_pos_rx(skb);
+	etype = ntohs(p[0]);
+
+	if (etype == ETH_P_8021Q) {
+		/* That's just an ordinary VLAN tag, pass through */
+		return skb;
+	}
+
+	if ((etype & 0xFFF0U) != ETH_P_8021Q) {
+		/* Not custom, just pass through */
+		netdev_dbg(dev, "non-KS8995 ethertype 0x%04x\n", etype);
+		return skb;
+	}
+
+	port = ilog2(etype & 0xF);
+	tci = ntohs(p[1]);
+	netdev_dbg(dev, "ingress packet tag: %04x %04x, port %d\n",
+		   etype, tci, port);
+
+	skb->dev = dsa_conduit_find_user(dev, 0, port);
+	if (!skb->dev) {
+		netdev_err(dev, "could not find user for port %d\n", port);
+		return NULL;
+	}
+
+	/* Remove KS8995 tag and recalculate checksum */
+	skb_pull_rcsum(skb, KS8995_TAG_LEN);
+
+	dsa_strip_etype_header(skb, KS8995_TAG_LEN);
+
+	dsa_default_offload_fwd_mark(skb);
+
+	return skb;
+}
+
+static const struct dsa_device_ops ks8995_netdev_ops = {
+	.name = KS8995_NAME,
+	.proto	= DSA_TAG_PROTO_KS8995,
+	.xmit = ks8995_xmit,
+	.rcv = ks8995_rcv,
+	.needed_headroom = KS8995_TAG_LEN,
+};
+
+MODULE_DESCRIPTION("DSA tag driver for Micrel KS8995 family of switches");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KS8995, KS8995_NAME);
+
+module_dsa_tag_driver(ks8995_netdev_ops);

-- 
2.52.0


