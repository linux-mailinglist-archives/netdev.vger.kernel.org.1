Return-Path: <netdev+bounces-252192-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCZkGq2icWmgKQAAu9opvQ
	(envelope-from <netdev+bounces-252192-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:08:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1485F619B8
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA04F367310
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C217443C05F;
	Thu, 22 Jan 2026 04:01:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5C93D3CF6;
	Thu, 22 Jan 2026 04:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769054465; cv=none; b=tMnXZgruKK1lnXZnPvhit5UD2YBQ8bWwBjMg0va1eTo5i8Yk9c8KDmNZvh+VpGg1jAvB2oxXZOvR/QBMKPzHeWxi4ogoS24tNgD5Lpa4R0DEjvMeB3huysuDcojl0feKMV8SWyOqSo3rD68qtmX7RgUnxwJOcWBsCCEDvntunPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769054465; c=relaxed/simple;
	bh=ZyE++B4oqly07y3CuY37Z7iz6qXLs3tGlrukQP6ecHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZWBuWgPRolrYbk6xarHqnyoi64zBpmGkxAQmsFAIXQeWLjFggqf2lwbfhvkUitsxIlgnpRmKs5l9ObJ18C0dm2N5LqGeZJY6RaG9XQCix9aQwogHw6mZnPjDHP+KDuXOiKFx9rl2FC56xYXJc8OYr9F203i1jnMVzLLTtjypmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vilsR-000000006S5-0Eiz;
	Thu, 22 Jan 2026 04:00:59 +0000
Date: Thu, 22 Jan 2026 04:00:56 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jonas Jelonek <jelonek.jonas@gmail.com>,
	Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [RFC PATCH v2 2/2] net: mdio: rtl9300: setup PHY polling registers
Message-ID: <680696024a8648535ce6dee771fe4de67802e0e8.1769053496.git.daniel@makrotopia.org>
References: <cover.1769053496.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1769053496.git.daniel@makrotopia.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.24 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-252192-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1485F619B8
X-Rspamd-Action: no action

The mdio-realtek-rtl9300 driver currently relies on the bootloader to
correctly setup polling registers depending on the PHY type. On quite a
lot of switches the bootloader only does this in case the user
interrupts the boot process and loads firmware via TFTP, otherwise
Ethernet remains uninitialized. On some devices the U-Boot environment
can be customized so they always initialize the switch and MDIO
controller before launching Linux, and rarely vendors decide to just
always do it.

Setup the polling registers based on the PHYs detected on the bus, and
setup registers for non-standard Clause-45 registers used in polling in
case the PHY vendor is known and commonly used in those switches.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/mdio/mdio-realtek-rtl9300.c | 82 +++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/mdio-realtek-rtl9300.c
index 405a07075dd11..9e030be497ab3 100644
--- a/drivers/net/mdio/mdio-realtek-rtl9300.c
+++ b/drivers/net/mdio/mdio-realtek-rtl9300.c
@@ -24,6 +24,9 @@
 
 #define SMI_GLB_CTRL			0xca00
 #define   GLB_CTRL_INTF_SEL(intf)	BIT(16 + (intf))
+#define SMI_MAC_TYPE_CTRL		0xca04
+#define   SMI_MAC_TYPE_CTRL_1G		3
+#define   SMI_MAC_TYPE_CTRL_2G_PLUS	1
 #define SMI_PORT0_15_POLLING_SEL	0xca08
 #define SMI_ACCESS_PHY_CTRL_0		0xcb70
 #define SMI_ACCESS_PHY_CTRL_1		0xcb74
@@ -43,6 +46,13 @@
 #define   PHY_CTRL_MMD_DEVAD		GENMASK(20, 16)
 #define   PHY_CTRL_MMD_REG		GENMASK(15, 0)
 #define SMI_PORT0_5_ADDR_CTRL		0xcb80
+#define SMI_PRVTE_POLLING_CTRL		0xca10
+#define SMI_10G_POLLING_REG0_CFG	0xcbb4
+#define SMI_10G_POLLING_REG9_CFG	0xcbb8
+#define SMI_10G_POLLING_REG10_CFG	0xcbbc
+
+#define RTMDIO_PHY_POLL_MMD(dev, reg, bit) \
+	(((bit) << 21) | ((dev) << 16) | (reg))
 
 #define MAX_PORTS       28
 #define MAX_SMI_BUSSES  4
@@ -56,6 +66,7 @@ struct rtl9300_mdio_priv {
 	u8 smi_addr[MAX_PORTS];
 	bool smi_bus_is_c45[MAX_SMI_BUSSES];
 	struct mii_bus *bus[MAX_SMI_BUSSES];
+	bool c45_polling_is_setup;
 };
 
 struct rtl9300_mdio_chan {
@@ -350,6 +361,74 @@ static int rtl9300_mdiobus_init(struct rtl9300_mdio_priv *priv)
 	return 0;
 }
 
+static int rtl9300_register_phy(struct phy_device *phydev)
+{
+	u32 mask, val, poll_duplex, poll_adv_1000, poll_lpa_1000;
+	struct mii_bus *bus = phydev->mdio.bus;
+	struct rtl9300_mdio_chan *chan;
+	struct rtl9300_mdio_priv *priv;
+	struct regmap *regmap;
+	int port, ret;
+	u8 mac_type;
+
+	chan = bus->priv;
+	priv = chan->priv;
+	regmap = priv->regmap;
+	port = rtl9300_mdio_phy_to_port(bus, phydev->mdio.addr);
+
+	/* Detect if PHY has 2.5G/5G/10G capabilities */
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported) ||
+	    linkmode_test_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, phydev->supported) ||
+	    linkmode_test_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, phydev->supported))
+		mac_type = SMI_MAC_TYPE_CTRL_2G_PLUS;
+	else
+		mac_type = SMI_MAC_TYPE_CTRL_1G;
+
+	mask = port > 23 ? 0x7 << ((port - 24) * 3 + 12) : 0x3 << ((port / 4) * 2);
+	val = mac_type << (ffs(mask) - 1);
+	ret = regmap_update_bits(regmap, SMI_MAC_TYPE_CTRL, mask, val);
+	if (ret < 0)
+		return ret;
+
+	/* Setup Clause-45 registers to be polled for the first >1G PHY.
+	 * All >1G PHYs connected to the switch SoC have to be of the same type.
+	 */
+	if (mac_type == SMI_MAC_TYPE_CTRL_1G || priv->c45_polling_is_setup)
+		return 0;
+
+	priv->c45_polling_is_setup = true;
+
+	switch (phydev->phy_id & PHY_ID_MATCH_VENDOR_MASK) {
+	case 0x001cc800: /* RealTek */
+		poll_duplex = RTMDIO_PHY_POLL_MMD(MDIO_MMD_VEND2, 0xa400, 8);
+		poll_adv_1000 = RTMDIO_PHY_POLL_MMD(MDIO_MMD_VEND2, 0xa412, 9);
+		poll_lpa_1000 = RTMDIO_PHY_POLL_MMD(MDIO_MMD_VEND2, 0xa414, 11);
+		break;
+	case 0x03a1b400: /* Aquantia */
+	case 0x31c31c00:
+		poll_duplex = RTMDIO_PHY_POLL_MMD(MDIO_MMD_PMAPMD, MDIO_CTRL1, 8);
+		poll_adv_1000 = RTMDIO_PHY_POLL_MMD(MDIO_MMD_AN, 0xc400, 15);
+		poll_lpa_1000 = RTMDIO_PHY_POLL_MMD(MDIO_MMD_AN, 0xe820, 15);
+		break;
+	default:
+		dev_warn(&phydev->mdio.dev,
+			 "Unknown register layout, relying on bootloader network setup.\n");
+		return 0;
+	};
+
+	ret = regmap_write(regmap, SMI_10G_POLLING_REG0_CFG, poll_duplex);
+	if (ret < 0)
+		return ret;
+	ret = regmap_write(regmap, SMI_10G_POLLING_REG9_CFG, poll_adv_1000);
+	if (ret < 0)
+		return ret;
+	ret = regmap_write(regmap, SMI_10G_POLLING_REG10_CFG, poll_lpa_1000);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int rtl9300_mdiobus_probe_one(struct device *dev, struct rtl9300_mdio_priv *priv,
 				     struct fwnode_handle *node)
 {
@@ -387,6 +466,7 @@ static int rtl9300_mdiobus_probe_one(struct device *dev, struct rtl9300_mdio_pri
 		bus->write = rtl9300_mdio_write_c22;
 	}
 	bus->parent = dev;
+	bus->register_phy = rtl9300_register_phy;
 	chan = bus->priv;
 	chan->mdio_bus = mdio_bus;
 	chan->priv = priv;
@@ -481,6 +561,8 @@ static int rtl9300_mdiobus_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
 
+	priv->c45_polling_is_setup = false;
+
 	platform_set_drvdata(pdev, priv);
 
 	err = rtl9300_mdiobus_map_ports(dev);
-- 
2.52.0

