Return-Path: <netdev+bounces-257711-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kANQJrmshml3PwQAu9opvQ
	(envelope-from <netdev+bounces-257711-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 04:08:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1F1104C2F
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 04:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E84E3023355
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 03:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FF7332EB5;
	Sat,  7 Feb 2026 03:07:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0B2332EA0;
	Sat,  7 Feb 2026 03:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770433638; cv=none; b=A4PSJvpOoa6j3vhdjwXI0lBxXpEQYe76I0SQZ7XcXbMhsHb2gvOyZ9/W2zps1v6kyGFfal8z/O4wqKVlygnQiLnOd1HgjExX5T7/tBK/qYtOusCXuxz/QhwfU+YcFrmTOARGlUeBUSDZbtprfQ3Q4wX8IfWmsiaDLf18mv++TJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770433638; c=relaxed/simple;
	bh=i6LOEZHX4QTBGxV+ZUEguJqWMtDQKc6l09Eg7ak1UgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q73lpkf2kYt+Rt7mn18gxUqgUnD9T+a+9xH4RNqrxcGwO8tWMIbFpUmaKS1ryA1p+hk1i660LuvkKvtA9w4gDRsWEkXKCj0j0DJy/4F2OqcCiMB09R2OdWcbVvWpSpuXBfinPd5KlVZN0HMVvE9J6iOTtoVL5FCL1JiL4doUvP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1voYfD-000000003Zg-0OIg;
	Sat, 07 Feb 2026 03:07:15 +0000
Date: Sat, 7 Feb 2026 03:07:11 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>, John Crispin <john@phrozen.org>
Subject: [PATCH net-next v14 2/4] net: dsa: add tag format for MxL862xx
 switches
Message-ID: <c64e6ddb6c93a4fac39f9ab9b2d8bf551a2b118d.1770433307.git.daniel@makrotopia.org>
References: <cover.1770433307.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770433307.git.daniel@makrotopia.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-257711-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.927];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:mid,makrotopia.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,baylibre.com:email]
X-Rspamd-Queue-Id: EF1F1104C2F
X-Rspamd-Action: no action

Add proprietary special tag format for the MaxLinear MXL862xx family of
switches. While using the same Ethertype as MaxLinear's GSW1xx switches,
the actual tag format differs significantly, hence we need a dedicated
tag driver for that.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v14:
 * Kconfig: fix Maxlinear -> MaxLinear, include vendor name in title
 * add comment clarifying perspective of term "ingress"
v13: no changes
v12: no changes
v11:
 * arrange local variables in reverse xmas tree order (again)
 * use MXL862_NAME as .name in struct dsa_device_ops

v10: count ports starting from 0
v9: no changes
v8: no changes
v7: no changes
v6:
 * remove unnecessary check for skb != NULL
 * merge consecutively printed warnings into single dev_warn_ratelimited

v5:
 * remove unused macro definitions

RFC v4:
 * describe fields and variables with comments
 * sub-interface is only 5 bits
 * harmonize Kconfig symbol name
 * maintain alphabetic order in Kconfig
 * fix typo s/beginnig/beginning/
 * fix typo s/swtiches/switches/
 * arrange local variables in reverse xmas tree order

RFC v3: no changes
RFC v2: make sure all tag fields are initialized
---
 MAINTAINERS            |   1 +
 include/net/dsa.h      |   2 +
 net/dsa/Kconfig        |   7 +++
 net/dsa/Makefile       |   1 +
 net/dsa/tag_mxl862xx.c | 110 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 121 insertions(+)
 create mode 100644 net/dsa/tag_mxl862xx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1a48bc339daf..f2f6369520b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15630,6 +15630,7 @@ M:	Daniel Golle <daniel@makrotopia.org>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/dsa/maxlinear,mxl862xx.yaml
+F:	net/dsa/tag_mxl862xx.c
 
 MCAN DEVICE DRIVER
 M:	Markus Schneider-Pargmann <msp@baylibre.com>
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 6b2b5ed64ea4..1e33242b6d94 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -57,6 +57,7 @@ struct tc_action;
 #define DSA_TAG_PROTO_BRCM_LEGACY_FCS_VALUE	29
 #define DSA_TAG_PROTO_YT921X_VALUE		30
 #define DSA_TAG_PROTO_MXL_GSW1XX_VALUE		31
+#define DSA_TAG_PROTO_MXL862_VALUE		32
 
 enum dsa_tag_protocol {
 	DSA_TAG_PROTO_NONE		= DSA_TAG_PROTO_NONE_VALUE,
@@ -91,6 +92,7 @@ enum dsa_tag_protocol {
 	DSA_TAG_PROTO_VSC73XX_8021Q	= DSA_TAG_PROTO_VSC73XX_8021Q_VALUE,
 	DSA_TAG_PROTO_YT921X		= DSA_TAG_PROTO_YT921X_VALUE,
 	DSA_TAG_PROTO_MXL_GSW1XX	= DSA_TAG_PROTO_MXL_GSW1XX_VALUE,
+	DSA_TAG_PROTO_MXL862		= DSA_TAG_PROTO_MXL862_VALUE,
 };
 
 struct dsa_switch;
diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
index f86b30742122..5ed8c704636d 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -104,6 +104,13 @@ config NET_DSA_TAG_MTK
 	  Say Y or M if you want to enable support for tagging frames for
 	  Mediatek switches.
 
+config NET_DSA_TAG_MXL_862XX
+	tristate "Tag driver for MaxLinear MxL862xx switches"
+	help
+	  Say Y or M if you want to enable support for tagging frames for the
+	  MaxLinear MxL86252 and MxL86282 switches using their native 8-byte
+	  tagging protocol.
+
 config NET_DSA_TAG_MXL_GSW1XX
 	tristate "Tag driver for MaxLinear GSW1xx switches"
 	help
diff --git a/net/dsa/Makefile b/net/dsa/Makefile
index 42d173f5a701..bf7247759a64 100644
--- a/net/dsa/Makefile
+++ b/net/dsa/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_NET_DSA_TAG_HELLCREEK) += tag_hellcreek.o
 obj-$(CONFIG_NET_DSA_TAG_KSZ) += tag_ksz.o
 obj-$(CONFIG_NET_DSA_TAG_LAN9303) += tag_lan9303.o
 obj-$(CONFIG_NET_DSA_TAG_MTK) += tag_mtk.o
+obj-$(CONFIG_NET_DSA_TAG_MXL_862XX) += tag_mxl862xx.o
 obj-$(CONFIG_NET_DSA_TAG_MXL_GSW1XX) += tag_mxl-gsw1xx.o
 obj-$(CONFIG_NET_DSA_TAG_NONE) += tag_none.o
 obj-$(CONFIG_NET_DSA_TAG_OCELOT) += tag_ocelot.o
diff --git a/net/dsa/tag_mxl862xx.c b/net/dsa/tag_mxl862xx.c
new file mode 100644
index 000000000000..01f215868271
--- /dev/null
+++ b/net/dsa/tag_mxl862xx.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * DSA Special Tag for MaxLinear 862xx switch chips
+ *
+ * Copyright (C) 2025 Daniel Golle <daniel@makrotopia.org>
+ * Copyright (C) 2024 MaxLinear Inc.
+ */
+
+#include <linux/bitops.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <net/dsa.h>
+#include "tag.h"
+
+#define MXL862_NAME	"mxl862xx"
+
+#define MXL862_HEADER_LEN	8
+
+/* Word 0 -> EtherType */
+
+/* Word 2 */
+#define MXL862_SUBIF_ID		GENMASK(4, 0)
+
+/* Word 3 */
+#define MXL862_IGP_EGP		GENMASK(3, 0)
+
+static struct sk_buff *mxl862_tag_xmit(struct sk_buff *skb,
+				       struct net_device *dev)
+{
+	struct dsa_port *dp = dsa_user_to_port(dev);
+	struct dsa_port *cpu_dp = dp->cpu_dp;
+	unsigned int cpu_port, sub_interface;
+	__be16 *mxl862_tag;
+
+	cpu_port = cpu_dp->index;
+
+	/* target port sub-interface ID relative to the CPU port */
+	sub_interface = dp->index + 16 - cpu_port;
+
+	/* provide additional space 'MXL862_HEADER_LEN' bytes */
+	skb_push(skb, MXL862_HEADER_LEN);
+
+	/* shift MAC address to the beginning of the enlarged buffer,
+	 * releasing the space required for DSA tag (between MAC address and
+	 * Ethertype)
+	 */
+	dsa_alloc_etype_header(skb, MXL862_HEADER_LEN);
+
+	/* special tag ingress (from the perspective of the switch) */
+	mxl862_tag = dsa_etype_header_pos_tx(skb);
+	mxl862_tag[0] = htons(ETH_P_MXLGSW);
+	mxl862_tag[1] = 0;
+	mxl862_tag[2] = htons(FIELD_PREP(MXL862_SUBIF_ID, sub_interface));
+	mxl862_tag[3] = htons(FIELD_PREP(MXL862_IGP_EGP, cpu_port));
+
+	return skb;
+}
+
+static struct sk_buff *mxl862_tag_rcv(struct sk_buff *skb,
+				      struct net_device *dev)
+{
+	__be16 *mxl862_tag;
+	int port;
+
+	if (unlikely(!pskb_may_pull(skb, MXL862_HEADER_LEN))) {
+		dev_warn_ratelimited(&dev->dev, "Cannot pull SKB, packet dropped\n");
+		return NULL;
+	}
+
+	mxl862_tag = dsa_etype_header_pos_rx(skb);
+
+	if (unlikely(mxl862_tag[0] != htons(ETH_P_MXLGSW))) {
+		dev_warn_ratelimited(&dev->dev,
+				     "Invalid special tag marker, packet dropped, tag: %8ph\n",
+				     mxl862_tag);
+		return NULL;
+	}
+
+	/* Get source port information */
+	port = FIELD_GET(MXL862_IGP_EGP, ntohs(mxl862_tag[3]));
+	skb->dev = dsa_conduit_find_user(dev, 0, port);
+	if (unlikely(!skb->dev)) {
+		dev_warn_ratelimited(&dev->dev,
+				     "Invalid source port, packet dropped, tag: %8ph\n",
+				     mxl862_tag);
+		return NULL;
+	}
+
+	/* remove the MxL862xx special tag between the MAC addresses and the
+	 * current ethertype field.
+	 */
+	skb_pull_rcsum(skb, MXL862_HEADER_LEN);
+	dsa_strip_etype_header(skb, MXL862_HEADER_LEN);
+
+	return skb;
+}
+
+static const struct dsa_device_ops mxl862_netdev_ops = {
+	.name = MXL862_NAME,
+	.proto = DSA_TAG_PROTO_MXL862,
+	.xmit = mxl862_tag_xmit,
+	.rcv = mxl862_tag_rcv,
+	.needed_headroom = MXL862_HEADER_LEN,
+};
+
+MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_MXL862, MXL862_NAME);
+MODULE_DESCRIPTION("DSA tag driver for MaxLinear MxL862xx switches");
+MODULE_LICENSE("GPL");
+
+module_dsa_tag_driver(mxl862_netdev_ops);
-- 
2.52.0

