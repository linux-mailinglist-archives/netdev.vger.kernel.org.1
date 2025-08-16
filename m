Return-Path: <netdev+bounces-214346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9178DB29073
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 21:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC3917BC385
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 19:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C780B22A4E1;
	Sat, 16 Aug 2025 19:57:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B0F21FF5D;
	Sat, 16 Aug 2025 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755374225; cv=none; b=J+87vx8md/STj0RSgJUeufuIN49sJgxFmo7YzPUkGkCnZbjTyiQqhTIU1KMMCVSRdH1WUQ2uDUVctd3KuQftGuKRkvuHgTF6xuNqMpYc6k5dciKqVoVOX0VNcj9Ww0ReGHIb9qJ7PLV4cTI9hT7rEZnO6Eod+BHZsSg63zfZKmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755374225; c=relaxed/simple;
	bh=80qSlyIEwMOpRahsm7kdAlGxnMZLncJ5x2I9+Q2J6po=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oMoFQcQh6wVB7reaPcKt+5OsFPP8hm7DPesje57dewlcnO+HgnaSDUC0SOiOvR5Y87hIZ1bid+4Bf5E6tiUQGgCvWiabpJadPrCnpWIB78IjWwJrZ22MD5Orz8p01p2Q/JDcBSlpmvvOZRhulNZPeA4MTuYUbfVaYF12QLnURwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1unN1N-0000000078g-0EXc;
	Sat, 16 Aug 2025 19:56:57 +0000
Date: Sat, 16 Aug 2025 20:56:53 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
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
Subject: [PATCH RFC net-next 21/23] net: dsa: add tagging driver for
 MaxLinear GSW1xx switch family
Message-ID: <aKDihWrDtVpm0TfV@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add support for a new DSA tagging protocol driver for the MaxLinear
GSW1xx switch family. The GSW1xx switches use a proprietary 8-byte
special tag inserted between the source MAC address and the EtherType
field to indicate the source and destination ports for frames
traversing the CPU port.

Implement the tag handling logic to insert the special tag on transmit
and parse it on receive.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 include/net/dsa.h        |   2 +
 net/dsa/Kconfig          |   8 +++
 net/dsa/Makefile         |   1 +
 net/dsa/tag_mxl-gsw1xx.c | 141 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 152 insertions(+)
 create mode 100644 net/dsa/tag_mxl-gsw1xx.c

diff --git a/include/net/dsa.h b/include/net/dsa.h
index d73ea0880066..8c7bad3fdfc2 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -55,6 +55,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_LAN937X_VALUE		27
 #define DSA_TAG_PROTO_VSC73XX_8021Q_VALUE	28
 #define DSA_TAG_PROTO_BRCM_LEGACY_FCS_VALUE	29
+#define DSA_TAG_PROTO_MXL_GSW1XX_VALUE		30
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -87,6 +88,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_RZN1_A5PSW	= DSA_TAG_PROTO_RZN1_A5PSW_VALUE,
 	DSA_TAG_PROTO_LAN937X		= DSA_TAG_PROTO_LAN937X_VALUE,
 	DSA_TAG_PROTO_VSC73XX_8021Q	= DSA_TAG_PROTO_VSC73XX_8021Q_VALUE,
+	DSA_TAG_PROTO_MXL_GSW1XX	= DSA_TAG_PROTO_MXL_GSW1XX_VALUE,
 };
 
 struct dsa_switch;
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index 869cbe57162f..e7d826b47cb3 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -98,6 +98,14 @@ config NET_DSA_TAG_EDSA
 	  Say Y or M if you want to enable support for tagging frames for the
 	  Marvell switches which use EtherType DSA headers.
 
+config NET_DSA_TAG_MXL_GSW1XX
+	tristate "Tag driver for MaxLinear GSW1xx switches"
+	help
+	  The GSW1xx family of switches supports an 8-byte special tag which
+	  can be used on the CPU port of the switch.
+	  Say Y or M if you want to enable support for tagging frames for
+	  MaxLinear GSW1xx switches.
+
 config NET_DSA_TAG_MTK
 	tristate "Tag driver for Mediatek switches"
 	help
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index 555c07cfeb71..3a73fbeee684 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_NET_DSA_TAG_GSWIP) += tag_gswip.o
 obj-$(CONFIG_NET_DSA_TAG_HELLCREEK) += tag_hellcreek.o
 obj-$(CONFIG_NET_DSA_TAG_KSZ) += tag_ksz.o
 obj-$(CONFIG_NET_DSA_TAG_LAN9303) += tag_lan9303.o
+obj-$(CONFIG_NET_DSA_TAG_MXL_GSW1XX) += tag_mxl-gsw1xx.o
 obj-$(CONFIG_NET_DSA_TAG_MTK) += tag_mtk.o
 obj-$(CONFIG_NET_DSA_TAG_NONE) += tag_none.o
 obj-$(CONFIG_NET_DSA_TAG_OCELOT) += tag_ocelot.o
diff --git a/net/dsa/tag_mxl-gsw1xx.c b/net/dsa/tag_mxl-gsw1xx.c
new file mode 100644
index 000000000000..7095496db7b6
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
+	if (!skb)
+		return skb;
+
+	/* provide additional space 'GSW1XX_TX_HEADER_LEN' bytes */
+	skb_push(skb, GSW1XX_TX_HEADER_LEN);
+
+	/* add space between MAC address and Ethertype */
+	memmove(skb->data, skb->data + GSW1XX_TX_HEADER_LEN, 2 * ETH_ALEN);
+
+	/* special tag ingress */
+	gsw1xx_tag = skb->data + 2 * ETH_ALEN;
+	gsw1xx_tag[0] = 0x88;
+	gsw1xx_tag[1] = 0xc3;
+	gsw1xx_tag[2] = GSW1XX_TX_PORT_MAP_EN | GSW1XX_TX_LRN_DIS;
+	gsw1xx_tag[3] = BIT(dp->index + GSW1XX_TX_PORT_MAP_LOW_SHIFT) & GSW1XX_TX_PORT_MAP_LOW_MASK;
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
+	gsw1xx_tag = skb->data - 2;
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
+	/* remove the GSW1xx special tag between MAC addresses and the current ethertype field. */
+	skb_pull_rcsum(skb, GSW1XX_RX_HEADER_LEN);
+	memmove(skb->data - ETH_HLEN, skb->data - (ETH_HLEN + GSW1XX_RX_HEADER_LEN), 2 * ETH_ALEN);
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
2.50.1

