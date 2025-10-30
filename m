Return-Path: <netdev+bounces-234376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593F2C1FD47
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 12:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5577A402CCB
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 11:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEBF357702;
	Thu, 30 Oct 2025 11:30:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CE93559EB;
	Thu, 30 Oct 2025 11:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823808; cv=none; b=Rg8Se8UUtwVeYt/L1+HK6Rghz91UD6mO9F3spm93aCNZDNxo239QOXyW8Y04p6tbLnCzB0ItzyV1OX1DHDlc3JulIqgmLFtCw5Q48aqnv17Ug3XW3XXFi55YCMZQorjelEadzwf1lIsA9uqmfg9opVLjWaLMt1jW7N1Ebbhr+Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823808; c=relaxed/simple;
	bh=U+bWBq93yNICBUgvPIXE7DMi2TiVNXT/QWwXZfxBw6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aix0Z0394meADnju1pAD18YPmVdTmm5rmNXa0aoHR0ExnXtPlTE0S2h9h8jh1J+/rlU/XmmbWtSWHWbW9jr1z1vWraRycl++Uq4MvKfmRaImvKLVGcMoEuMYkhTLetfzU2AofzWU47+AnQFTHKePgd1aylcxFLU7KGSwF0pI34I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vEQqv-000000005G4-3lJT;
	Thu, 30 Oct 2025 11:30:01 +0000
Date: Thu, 30 Oct 2025 11:29:58 +0000
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
Subject: [PATCH net-next v5 11/12] net: dsa: add tagging driver for MaxLinear
 GSW1xx switch family
Message-ID: <06d39cfa7052a4f5140d9cdd91f1beaf65bf89f8.1761823194.git.daniel@makrotopia.org>
References: <cover.1761823194.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761823194.git.daniel@makrotopia.org>

Add support for a new DSA tagging protocol driver for the MaxLinear
GSW1xx switch family. The GSW1xx switches use a proprietary 8-byte
special tag inserted between the source MAC address and the EtherType
field to indicate the source and destination ports for frames
traversing the CPU port.

Implement the tag handling logic to insert the special tag on transmit
and parse it on receive.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Tested-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
v5:
 * reduce length of overly long line

v4:
 * use __be16 to access tag fields
 * define ETH_P_MXLGSW in if_ether.h
 * drop *_SHIFT macros, get rid of _MASK suffix, use FIELD helpers
 * print tag using %8ph

since RFC:
 * use dsa etype header macros instead of open coding them
 * maintain alphabetic order in Kconfig and Makefile

 MAINTAINERS                   |   3 +-
 include/net/dsa.h             |   2 +
 include/uapi/linux/if_ether.h |   1 +
 net/dsa/Kconfig               |   8 +++
 net/dsa/Makefile              |   1 +
 net/dsa/tag_mxl-gsw1xx.c      | 116 ++++++++++++++++++++++++++++++++++
 6 files changed, 130 insertions(+), 1 deletion(-)
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
diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_ether.h
index cfd200c87e5e..2c93b7b731c8 100644
--- a/include/uapi/linux/if_ether.h
+++ b/include/uapi/linux/if_ether.h
@@ -92,6 +92,7 @@
 #define ETH_P_ETHERCAT	0x88A4		/* EtherCAT			*/
 #define ETH_P_8021AD	0x88A8          /* 802.1ad Service VLAN		*/
 #define ETH_P_802_EX1	0x88B5		/* 802.1 Local Experimental 1.  */
+#define ETH_P_MXLGSW	0x88C3		/* MaxLinear GSW DSA [ NOT AN OFFICIALLY REGISTERED ID ] */
 #define ETH_P_PREAUTH	0x88C7		/* 802.11 Preauthentication */
 #define ETH_P_TIPC	0x88CA		/* TIPC 			*/
 #define ETH_P_LLDP	0x88CC		/* Link Layer Discovery Protocol */
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
index 000000000000..701a079955f2
--- /dev/null
+++ b/net/dsa/tag_mxl-gsw1xx.c
@@ -0,0 +1,116 @@
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
+/* special tag header length (RX and TX) */
+#define GSW1XX_HEADER_LEN		8
+
+/* Word 0 = Ethertype -> 0x88C3 */
+
+/* Word 1 */
+#define GSW1XX_TX_PORT_MAP		GENMASK(7, 0)
+#define GSW1XX_TX_PORT_MAP_EN		BIT(15)
+#define GSW1XX_TX_CLASS_EN		BIT(14)
+#define GSW1XX_TX_TIME_STAMP_EN		BIT(13)
+#define GSW1XX_TX_LRN_DIS		BIT(12)
+#define GSW1XX_TX_CLASS			GENMASK(11, 8)
+
+/* special tag in RX path header */
+/* Word 2 */
+#define GSW1XX_RX_PORT_MAP		GENMASK(15, 8)
+
+static struct sk_buff *gsw1xx_tag_xmit(struct sk_buff *skb,
+				       struct net_device *dev)
+{
+	struct dsa_port *dp = dsa_user_to_port(dev);
+	__be16 *gsw1xx_tag;
+
+	/* provide additional space 'GSW1XX_HEADER_LEN' bytes */
+	skb_push(skb, GSW1XX_HEADER_LEN);
+
+	/* add space between MAC address and Ethertype */
+	dsa_alloc_etype_header(skb, GSW1XX_HEADER_LEN);
+
+	/* special tag ingress */
+	gsw1xx_tag = dsa_etype_header_pos_tx(skb);
+	gsw1xx_tag[0] = htons(ETH_P_MXLGSW);
+	gsw1xx_tag[1] = htons(GSW1XX_TX_PORT_MAP_EN | GSW1XX_TX_LRN_DIS |
+			FIELD_PREP(GSW1XX_TX_PORT_MAP, BIT(dp->index)));
+
+	gsw1xx_tag[2] = 0;
+	gsw1xx_tag[3] = 0;
+
+	return skb;
+}
+
+static struct sk_buff *gsw1xx_tag_rcv(struct sk_buff *skb,
+				      struct net_device *dev)
+{
+	int port;
+	__be16 *gsw1xx_tag;
+
+	if (unlikely(!pskb_may_pull(skb, GSW1XX_HEADER_LEN))) {
+		dev_warn_ratelimited(&dev->dev, "Dropping packet, cannot pull SKB\n");
+		return NULL;
+	}
+
+	gsw1xx_tag = dsa_etype_header_pos_rx(skb);
+
+	if (unlikely(ntohs(gsw1xx_tag[0]) != ETH_P_MXLGSW)) {
+		dev_warn_ratelimited(&dev->dev, "Dropping packet due to invalid special tag\n");
+		dev_warn_ratelimited(&dev->dev, "Tag: %8ph\n", gsw1xx_tag);
+		return NULL;
+	}
+
+	/* Get source port information */
+	port = FIELD_GET(GSW1XX_RX_PORT_MAP, ntohs(gsw1xx_tag[1]));
+	skb->dev = dsa_conduit_find_user(dev, 0, port);
+	if (!skb->dev) {
+		dev_warn_ratelimited(&dev->dev, "Dropping packet due to invalid source port\n");
+		dev_warn_ratelimited(&dev->dev, "Tag: %8ph\n", gsw1xx_tag);
+		return NULL;
+	}
+
+	/* remove the GSW1xx special tag between MAC addresses and the current
+	 * ethertype field.
+	 */
+	skb_pull_rcsum(skb, GSW1XX_HEADER_LEN);
+	dsa_strip_etype_header(skb, GSW1XX_HEADER_LEN);
+
+	return skb;
+}
+
+static const struct dsa_device_ops gsw1xx_netdev_ops = {
+	.name			= GSW1XX_TAG_NAME,
+	.proto			= DSA_TAG_PROTO_MXL_GSW1XX,
+	.xmit			= gsw1xx_tag_xmit,
+	.rcv			= gsw1xx_tag_rcv,
+	.needed_headroom	= GSW1XX_HEADER_LEN,
+};
+
+MODULE_DESCRIPTION("DSA tag driver for MaxLinear GSW1xx 8 byte protocol");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_MXL_GSW1XX, GSW1XX_TAG_NAME);
+
+module_dsa_tag_driver(gsw1xx_netdev_ops);
-- 
2.51.2

