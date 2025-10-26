Return-Path: <netdev+bounces-233039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C2CC0B7F5
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 00:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFA73BBDD0
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 23:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0133F302760;
	Sun, 26 Oct 2025 23:48:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2509B2BE7AD;
	Sun, 26 Oct 2025 23:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761522515; cv=none; b=itP9I/9p8UuE/MSAeM81dxib7jyHpy4KOhRlPtOIBLAY3YFuFbWe8A4En3DsIaSIaPXfOhMGIHti4as9UiepOHeWDvvlp5OM8MW9AhE+kpFg7tpJ0sNqN3rW2s4SAhaUZuh2wGMfbvnx3w+xn1mkUjbv2olQJl8bQOFPQAIpIhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761522515; c=relaxed/simple;
	bh=+orWBZD2XHRiA/SUdy3p2xIt6KqDYSsUc/3O4zcX7CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sk2RhiQPNN8eljqj+QoyB+NbDSrLnX5BCOo37R3DBgkhOFjQ/N3ECQ3Hnne7MRiTA5KSQtch1KRcpUiovNB5Rymw4VBcxYJUxQf6ODg/GozXu/OgsEs6EOaU9f0KYqQjxGgiQ1/m6ttdMoI075Pbtla7KlVr+LC/Qht1e47ftgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vDATL-000000007h1-1A0Q;
	Sun, 26 Oct 2025 23:48:27 +0000
Date: Sun, 26 Oct 2025 23:48:23 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v3 11/12] net: dsa: add tagging driver for MaxLinear
 GSW1xx switch family
Message-ID: <81815f0c5616d8b1fe47ec9e292755b38c42e491.1761521845.git.daniel@makrotopia.org>
References: <cover.1761521845.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761521845.git.daniel@makrotopia.org>

Add support for a new DSA tagging protocol driver for the MaxLinear
GSW1xx switch family. The GSW1xx switches use a proprietary 8-byte
special tag inserted between the source MAC address and the EtherType
field to indicate the source and destination ports for frames
traversing the CPU port.

Implement the tag handling logic to insert the special tag on transmit
and parse it on receive.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
since RFC:
 * use dsa etype header macros instead of open coding them
 * maintain alphabetic order in Kconfig and Makefile

 MAINTAINERS              |   3 +-
 include/net/dsa.h        |   2 +
 net/dsa/Kconfig          |   8 +++
 net/dsa/Makefile         |   1 +
 net/dsa/tag_mxl-gsw1xx.c | 141 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 154 insertions(+), 1 deletion(-)
 create mode 100644 net/dsa/tag_mxl-gsw1xx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d652f4f27756..4ddff0b0a547 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14038,7 +14038,7 @@ F:	tools/testing/selftests/landlock/
 K:	landlock
 K:	LANDLOCK
 
-LANTIQ / INTEL Ethernet drivers
+LANTIQ / MAXLINEAR / INTEL Ethernet DSA drivers
 M:	Hauke Mehrtens <hauke@hauke-m.de>
 L:	netdev@vger.kernel.org
 S:	Maintained
@@ -14046,6 +14046,7 @@ F:	Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
 F:	drivers/net/dsa/lantiq/*
 F:	drivers/net/ethernet/lantiq_xrx200.c
 F:	net/dsa/tag_gswip.c
+F:	net/dsa/tag_mxl-gsw1xx.c
 
 LANTIQ MIPS ARCHITECTURE
 M:	John Crispin <john@phrozen.org>
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 67762fdaf3c7..2df2e2ead9a8 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -56,6 +56,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_VSC73XX_8021Q_VALUE	28
 #define DSA_TAG_PROTO_BRCM_LEGACY_FCS_VALUE	29
 #define DSA_TAG_PROTO_YT921X_VALUE		30
+#define DSA_TAG_PROTO_MXL_GSW1XX_VALUE		31
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -89,6 +90,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_LAN937X		= DSA_TAG_PROTO_LAN937X_VALUE,
 	DSA_TAG_PROTO_VSC73XX_8021Q	= DSA_TAG_PROTO_VSC73XX_8021Q_VALUE,
 	DSA_TAG_PROTO_YT921X		= DSA_TAG_PROTO_YT921X_VALUE,
+	DSA_TAG_PROTO_MXL_GSW1XX	= DSA_TAG_PROTO_MXL_GSW1XX_VALUE,
 };
 
 struct dsa_switch;
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 6b94028b1fcc..f86b30742122 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -104,6 +104,14 @@ config NET_DSA_TAG_MTK
 	  Say Y or M if you want to enable support for tagging frames for
 	  Mediatek switches.
 
+config NET_DSA_TAG_MXL_GSW1XX
+	tristate "Tag driver for MaxLinear GSW1xx switches"
+	help
+	  The GSW1xx family of switches supports an 8-byte special tag which
+	  can be used on the CPU port of the switch.
+	  Say Y or M if you want to enable support for tagging frames for
+	  MaxLinear GSW1xx switches.
+
 config NET_DSA_TAG_KSZ
 	tristate "Tag driver for Microchip 8795/937x/9477/9893 families of switches"
 	help
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index 4b011a1d5c87..42d173f5a701 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_NET_DSA_TAG_HELLCREEK) += tag_hellcreek.o
 obj-$(CONFIG_NET_DSA_TAG_KSZ) += tag_ksz.o
 obj-$(CONFIG_NET_DSA_TAG_LAN9303) += tag_lan9303.o
 obj-$(CONFIG_NET_DSA_TAG_MTK) += tag_mtk.o
+obj-$(CONFIG_NET_DSA_TAG_MXL_GSW1XX) += tag_mxl-gsw1xx.o
 obj-$(CONFIG_NET_DSA_TAG_NONE) += tag_none.o
 obj-$(CONFIG_NET_DSA_TAG_OCELOT) += tag_ocelot.o
 obj-$(CONFIG_NET_DSA_TAG_OCELOT_8021Q) += tag_ocelot_8021q.o
diff --git a/net/dsa/tag_mxl-gsw1xx.c b/net/dsa/tag_mxl-gsw1xx.c
new file mode 100644
index 000000000000..9efec6deb494
--- /dev/null
+++ b/net/dsa/tag_mxl-gsw1xx.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * DSA driver Special Tag support for MaxLinear GSW1xx switch chips
+ *
+ * Copyright (C) 2025 Daniel Golle <daniel@makrotopia.org>
+ * Copyright (C) 2023 - 2024 MaxLinear Inc.
+ */
+
+#include <linux/bitops.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <net/dsa.h>
+
+#include "tag.h"
+
+/* To define the outgoing port and to discover the incoming port a special
+ * tag is used by the GSW1xx.
+ *
+ *       Dest MAC       Src MAC    special TAG        EtherType
+ * ...| 1 2 3 4 5 6 | 1 2 3 4 5 6 | 1 2 3 4 5 6 7 8 | 1 2 |...
+ *                                |<--------------->|
+ */
+
+#define GSW1XX_TAG_NAME		"gsw1xx"
+
+/* special tag in TX path header */
+#define GSW1XX_TX_HEADER_LEN	8
+
+/* Byte 0 = Ethertype byte 1 -> 0x88 */
+/* Byte 1 = Ethertype byte 2 -> 0xC3*/
+
+/* Byte 2 */
+#define GSW1XX_TX_PORT_MAP_EN		BIT(7)
+#define GSW1XX_TX_CLASS_EN		BIT(6)
+#define GSW1XX_TX_TIME_STAMP_EN		BIT(5)
+#define GSW1XX_TX_LRN_DIS		BIT(4)
+#define GSW1XX_TX_CLASS_SHIFT		0
+#define GSW1XX_TX_CLASS_MASK		GENMASK(3, 0)
+
+/* Byte 3 */
+#define GSW1XX_TX_PORT_MAP_LOW_SHIFT	0
+#define GSW1XX_TX_PORT_MAP_LOW_MASK	GENMASK(7, 0)
+
+/* Byte 4 */
+#define GSW1XX_TX_PORT_MAP_HIGH_SHIFT	0
+#define GSW1XX_TX_PORT_MAP_HIGH_MASK	GENMASK(7, 0)
+
+#define GSW1XX_RX_HEADER_LEN		8
+
+/* special tag in RX path header */
+/* Byte 4 */
+#define GSW1XX_RX_PORT_MAP_LOW_SHIFT	0
+#define GSW1XX_RX_PORT_MAP_LOW_MASK	GENMASK(7, 0)
+
+/* Byte 5 */
+#define GSW1XX_RX_PORT_MAP_HIGH_SHIFT	0
+#define GSW1XX_RX_PORT_MAP_HIGH_MASK	GENMASK(7, 0)
+
+static struct sk_buff *gsw1xx_tag_xmit(struct sk_buff *skb,
+				       struct net_device *dev)
+{
+	struct dsa_port *dp = dsa_user_to_port(dev);
+	u8 *gsw1xx_tag;
+
+	/* provide additional space 'GSW1XX_TX_HEADER_LEN' bytes */
+	skb_push(skb, GSW1XX_TX_HEADER_LEN);
+
+	/* add space between MAC address and Ethertype */
+	dsa_alloc_etype_header(skb, GSW1XX_TX_HEADER_LEN);
+
+	/* special tag ingress */
+	gsw1xx_tag = dsa_etype_header_pos_tx(skb);
+	gsw1xx_tag[0] = 0x88;
+	gsw1xx_tag[1] = 0xc3;
+	gsw1xx_tag[2] = GSW1XX_TX_PORT_MAP_EN | GSW1XX_TX_LRN_DIS;
+	gsw1xx_tag[3] = BIT(dp->index + GSW1XX_TX_PORT_MAP_LOW_SHIFT) &
+			GSW1XX_TX_PORT_MAP_LOW_MASK;
+	gsw1xx_tag[4] = 0;
+	gsw1xx_tag[5] = 0;
+	gsw1xx_tag[6] = 0;
+	gsw1xx_tag[7] = 0;
+
+	return skb;
+}
+
+static struct sk_buff *gsw1xx_tag_rcv(struct sk_buff *skb,
+				      struct net_device *dev)
+{
+	int port;
+	u8 *gsw1xx_tag;
+
+	if (unlikely(!pskb_may_pull(skb, GSW1XX_RX_HEADER_LEN))) {
+		dev_warn_ratelimited(&dev->dev, "Dropping packet, cannot pull SKB\n");
+		return NULL;
+	}
+
+	gsw1xx_tag = dsa_etype_header_pos_rx(skb);
+
+	if (gsw1xx_tag[0] != 0x88 && gsw1xx_tag[1] != 0xc3) {
+		dev_warn_ratelimited(&dev->dev, "Dropping packet due to invalid special tag\n");
+		dev_warn_ratelimited(&dev->dev,
+				     "Tag: 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x\n",
+				     gsw1xx_tag[0], gsw1xx_tag[1], gsw1xx_tag[2], gsw1xx_tag[3],
+				     gsw1xx_tag[4], gsw1xx_tag[5], gsw1xx_tag[6], gsw1xx_tag[7]);
+		return NULL;
+	}
+
+	/* Get source port information */
+	port = (gsw1xx_tag[2] & GSW1XX_RX_PORT_MAP_LOW_MASK) >> GSW1XX_RX_PORT_MAP_LOW_SHIFT;
+	skb->dev = dsa_conduit_find_user(dev, 0, port);
+	if (!skb->dev) {
+		dev_warn_ratelimited(&dev->dev, "Dropping packet due to invalid source port\n");
+		dev_warn_ratelimited(&dev->dev,
+				     "Tag: 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x\n",
+				     gsw1xx_tag[0], gsw1xx_tag[1], gsw1xx_tag[2], gsw1xx_tag[3],
+				     gsw1xx_tag[4], gsw1xx_tag[5], gsw1xx_tag[6], gsw1xx_tag[7]);
+		return NULL;
+	}
+
+	/* remove the GSW1xx special tag between MAC addresses and the current
+	 * ethertype field.
+	 */
+	skb_pull_rcsum(skb, GSW1XX_RX_HEADER_LEN);
+	dsa_strip_etype_header(skb, GSW1XX_RX_HEADER_LEN);
+
+	return skb;
+}
+
+static const struct dsa_device_ops gsw1xx_netdev_ops = {
+	.name = GSW1XX_TAG_NAME,
+	.proto	= DSA_TAG_PROTO_MXL_GSW1XX,
+	.xmit = gsw1xx_tag_xmit,
+	.rcv = gsw1xx_tag_rcv,
+	.needed_headroom = GSW1XX_RX_HEADER_LEN,
+};
+
+MODULE_DESCRIPTION("DSA tag driver for MaxLinear GSW1xx 8 byte protocol");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_MXL_GSW1XX, GSW1XX_TAG_NAME);
+
+module_dsa_tag_driver(gsw1xx_netdev_ops);
-- 
2.51.1

