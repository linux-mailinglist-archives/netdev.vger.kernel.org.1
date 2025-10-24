Return-Path: <netdev+bounces-232635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EA126C07748
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 19:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4449B35D25F
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 17:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13204343D91;
	Fri, 24 Oct 2025 17:04:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13184329C6A;
	Fri, 24 Oct 2025 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325483; cv=none; b=fwcfyX7F2x0rQ/+2+IwKK5STt9+ABnpdF2n/Yhr5395oTQaC7V6YfZRppd+eoH3YbG/56YXRu0KR8pDutDtkd7RR8TOMGjV19kl3OjW52Fo4N9A2kXUtmp63HoYF2vTX2G2uxVxY3ZijQFQ3p5XRDW+y9w17N9p6HnMY0fC/pAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325483; c=relaxed/simple;
	bh=CDtuSKFMk+D06z0L9yK8/mNWtAwyfJx5m5XZXsDEuVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuSFrbEUDG93Qt/4hEdS5wybg4PzXQoAfhVM8CGwvYagv73WAuIOo3KZ6HbGyolgcxTelp8uOh7C00UurJ3a7efM/Gz9mNCfGrIog7hR7eM4uWEtBQhAWHOBMWOojKQ+dyKdUjsnvtTXUKB/VO039nGWcGEydWumxlV5EeTwsPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vCLDR-000000006AG-1aBq;
	Fri, 24 Oct 2025 17:04:37 +0000
Date: Fri, 24 Oct 2025 18:04:26 +0100
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
Subject: [PATCH net-next 11/13] net: dsa: add tagging driver for MaxLinear
 GSW1xx switch family
Message-ID: <1211920a29d5633fb9d3a259f2147383f396688f.1761324950.git.daniel@makrotopia.org>
References: <cover.1761324950.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761324950.git.daniel@makrotopia.org>

Add support for a new DSA tagging protocol driver for the MaxLinear
GSW1xx switch family. The GSW1xx switches use a proprietary 8-byte
special tag inserted between the source MAC address and the EtherType
field to indicate the source and destination ports for frames
traversing the CPU port.

Implement the tag handling logic to insert the special tag on transmit
and parse it on receive.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
Changes since RFC:
 - use dsa etype header macros instead of open coding them
 - maintain alphabetic order in Kconfig and Makefile

 MAINTAINERS              |   3 +-
 include/net/dsa.h        |   2 +
 net/dsa/Kconfig          |   8 +++
 net/dsa/Makefile         |   1 +
 net/dsa/tag_mxl-gsw1xx.c | 138 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 151 insertions(+), 1 deletion(-)
 create mode 100644 net/dsa/tag_mxl-gsw1xx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3ed59823f7a4..1db770b7274d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14037,7 +14037,7 @@ F:	tools/testing/selftests/landlock/
 K:	landlock
 K:	LANDLOCK
 
-LANTIQ / INTEL Ethernet drivers
+LANTIQ / MAXLINEAR / INTEL Ethernet DSA drivers
 M:	Hauke Mehrtens <hauke@hauke-m.de>
 L:	netdev@vger.kernel.org
 S:	Maintained
@@ -14045,6 +14045,7 @@ F:	Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
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
index 000000000000..0aa4cc00ed33
--- /dev/null
+++ b/net/dsa/tag_mxl-gsw1xx.c
@@ -0,0 +1,138 @@
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
+	/* remove the GSW1xx special tag between MAC addresses and the current ethertype field. */
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
2.51.0

