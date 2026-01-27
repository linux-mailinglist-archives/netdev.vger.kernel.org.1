Return-Path: <netdev+bounces-254009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOSzGnsweWlovwEAu9opvQ
	(envelope-from <netdev+bounces-254009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 22:39:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F449AC3F
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 22:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E15B302C322
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 21:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130072C0F97;
	Tue, 27 Jan 2026 21:38:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1007F2BD5A8;
	Tue, 27 Jan 2026 21:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769549886; cv=none; b=DGAzzOPJFRzzKhCuhdyfEHpCkCwNG6BekI8zLQCtWae0+cirW/AxgoA/iK1dOZhdzD8mIxTnMnZWrAyLJQmreq4taInHtL/rRpdWr0AzOHucg6LTXEXGT6AW8SKXdP0htgYnOoCvVa/99Po4YJllGM41FavTtLtTws94qBEC6fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769549886; c=relaxed/simple;
	bh=TCzAVTGliory+gtc0nOWp81UKtntKqS1LS0bano1t3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJUYPWO7Bh00sgKZfFt51X7tXKPeVE8BueDf105omOrd/hqTXpUkl+dd75UzoEx/OpQs2XXzqq8N41E2cyoHB7SQEM9/IXEdcUO+XdOxqvf1yXXJd2GsPp/QyB0CBwfGCOvPK/BdY9FgM8VhGzTZ4NBU/LczlMaweY0eZX0eTq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vkql6-000000002vc-3s4s;
	Tue, 27 Jan 2026 21:38:01 +0000
Date: Tue, 27 Jan 2026 21:37:57 +0000
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
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v9 2/4] net: dsa: add tag format for MxL862xx
 switches
Message-ID: <2dd6c3cec293578fe60b022356b518d94d831399.1769549559.git.daniel@makrotopia.org>
References: <cover.1769549559.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769549559.git.daniel@makrotopia.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254009-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[makrotopia.org:mid,makrotopia.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4F449AC3F
X-Rspamd-Action: no action

Add proprietary special tag format for the MaxLinear MXL862xx family of
switches. While using the same Ethertype as MaxLinear's GSW1xx switches,
the actual tag format differs significantly, hence we need a dedicated
tag driver for that.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
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
 net/dsa/tag_mxl862xx.c | 112 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 123 insertions(+)
 create mode 100644 net/dsa/tag_mxl862xx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a0cc2609a88..bd33de42604e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15624,6 +15624,7 @@ M:	Daniel Golle <daniel@makrotopia.org>
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
index f86b30742122..efc95759a10e 100644
--- a/net/dsa/Kconfig
+++ b/net/dsa/Kconfig
@@ -104,6 +104,13 @@ config NET_DSA_TAG_MTK
 	  Say Y or M if you want to enable support for tagging frames for
 	  Mediatek switches.
 
+config NET_DSA_TAG_MXL_862XX
+	tristate "Tag driver for MxL862xx switches"
+	help
+	  Say Y or M if you want to enable support for tagging frames for the
+	  Maxlinear MxL86252 and MxL86282 switches using their native 8-byte
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
index 000000000000..def7be0d5d15
--- /dev/null
+++ b/net/dsa/tag_mxl862xx.c
@@ -0,0 +1,112 @@
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
+	unsigned int cpu_port, usr_port, sub_interface;
+	struct dsa_port *dp = dsa_user_to_port(dev);
+	struct dsa_port *cpu_dp = dp->cpu_dp;
+	__be16 *mxl862_tag;
+
+	/* switch firmware expects ports to be counted starting from 1 */
+	cpu_port = cpu_dp->index + 1;
+	usr_port = dp->index + 1;
+
+	/* target port sub-interface ID relative to the CPU port */
+	sub_interface = usr_port + 16 - cpu_port;
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
+	/* special tag ingress */
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
+	port = FIELD_GET(MXL862_IGP_EGP, ntohs(mxl862_tag[3])) - 1;
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
+	.name = "mxl862",
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

