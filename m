Return-Path: <netdev+bounces-139299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 880969B1578
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 08:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1717D1F2354C
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 06:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CA31C3055;
	Sat, 26 Oct 2024 06:36:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231AE1991D5
	for <netdev@vger.kernel.org>; Sat, 26 Oct 2024 06:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729924566; cv=none; b=I2KJVujzMs5A/mbtppo0JTyThdU4XOVvf1q1TgLpfLmm+g0DGU0EIEafOI3oZISf9som/+RDVD7eIuuaNagYRyJ9LV6kbfbTUg/lUTM4LNgGQVQfz31Li8NKGUlSINwoMdMhGquhpLt3b43O4k3no/glwDxO9j/q+Bw+aAFBkhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729924566; c=relaxed/simple;
	bh=DkhzQojUdHucqaY2ayRjdwzYLFQMrQzPbHSW2ueFK3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qicz8Am8aGOtD1415gsl82yrgjA9BFz62ihRHas/1xGB612oY17XkQKCHBsaIQXCI87MplX7kGK8KAu1dMa1Hx3FKSWQbw56qFXRq0R5rIh1AmcSh15pAu+8lvMRPw1M/QCG44yMXsvO8wCzrOCXAmuTGH+Zm9bVuZPI90b/YVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1t4aOj-0006kC-1n; Sat, 26 Oct 2024 08:35:41 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t4aOh-000UfN-0P;
	Sat, 26 Oct 2024 08:35:39 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t4aOh-00AVyd-0A;
	Sat, 26 Oct 2024 08:35:39 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v1 3/5] net: dsa: microchip: Refactor MDIO handling for side MDIO access
Date: Sat, 26 Oct 2024 08:35:36 +0200
Message-Id: <20241026063538.2506143-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241026063538.2506143-1-o.rempel@pengutronix.de>
References: <20241026063538.2506143-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Add support for accessing PHYs via a side MDIO interface in LAN937x
switches. The existing code already supports accessing PHYs via main
management interfaces, which can be SPI, I2C, or MDIO, depending on the
chip variant. This patch enables using a side MDIO bus, where SPI is
used for the main switch configuration and MDIO for managing the
integrated PHYs. On LAN937x, this is optional, allowing them to operate
in both configurations: SPI only, or SPI + MDIO. Typically, the SPI
interface is used for switch configuration, while MDIO handles PHY
management.

Additionally, update interrupt controller code to support non-linear
port to PHY address mapping, enabling correct interrupt handling for
configurations where PHY addresses do not directly correspond to port
indexes. This change ensures that the interrupt mechanism properly
aligns with the new, flexible PHY address mappings introduced by side
MDIO support.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz_common.c | 102 ++++++++++++++++++++++---
 drivers/net/dsa/microchip/ksz_common.h |   7 ++
 2 files changed, 99 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 5290f5ad98f39..bcd963191cb25 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2238,16 +2238,51 @@ static int ksz_sw_mdio_write(struct mii_bus *bus, int addr, int regnum,
 	return dev->dev_ops->w_phy(dev, addr, regnum, val);
 }
 
+static int ksz_parent_mdio_read(struct mii_bus *bus, int addr, int regnum)
+{
+	struct ksz_device *dev = bus->priv;
+
+	return mdiobus_read_nested(dev->parent_mdio_bus, addr, regnum);
+}
+
+static int ksz_parent_mdio_write(struct mii_bus *bus, int addr, int regnum,
+				 u16 val)
+{
+	struct ksz_device *dev = bus->priv;
+
+	return mdiobus_write_nested(dev->parent_mdio_bus, addr, regnum, val);
+}
+
+static int ksz_phy_addr_to_port(struct ksz_device *dev, int addr)
+{
+	struct dsa_switch *ds = dev->ds;
+	struct dsa_port *dp;
+
+	dsa_switch_for_each_user_port(dp, ds) {
+		if (dev->info->internal_phy[dp->index] &&
+		    dev->phy_addr_map[dp->index] == addr)
+			return dp->index;
+	}
+
+	return -EINVAL;
+}
+
 static int ksz_irq_phy_setup(struct ksz_device *dev)
 {
 	struct dsa_switch *ds = dev->ds;
-	int phy;
+	int phy, port;
 	int irq;
 	int ret;
 
-	for (phy = 0; phy < KSZ_MAX_NUM_PORTS; phy++) {
+	for (phy = 0; phy < PHY_MAX_ADDR; phy++) {
 		if (BIT(phy) & ds->phys_mii_mask) {
-			irq = irq_find_mapping(dev->ports[phy].pirq.domain,
+			port = ksz_phy_addr_to_port(dev, phy);
+			if (port < 0) {
+				ret = port;
+				goto out;
+			}
+
+			irq = irq_find_mapping(dev->ports[port].pirq.domain,
 					       PORT_SRC_PHY_INT);
 			if (irq < 0) {
 				ret = irq;
@@ -2270,35 +2305,81 @@ static void ksz_irq_phy_free(struct ksz_device *dev)
 	struct dsa_switch *ds = dev->ds;
 	int phy;
 
-	for (phy = 0; phy < KSZ_MAX_NUM_PORTS; phy++)
+	for (phy = 0; phy < PHY_MAX_ADDR; phy++)
 		if (BIT(phy) & ds->phys_mii_mask)
 			irq_dispose_mapping(ds->user_mii_bus->irq[phy]);
 }
 
 static int ksz_mdio_register(struct ksz_device *dev)
 {
+	struct device_node *parent_bus_node;
+	struct mii_bus *parent_bus = NULL;
 	struct dsa_switch *ds = dev->ds;
 	struct device_node *mdio_np;
 	struct mii_bus *bus;
-	int ret;
+	struct dsa_port *dp;
+	int ret, i;
 
 	mdio_np = of_get_child_by_name(dev->dev->of_node, "mdio");
 	if (!mdio_np)
 		return 0;
 
+	parent_bus_node = of_parse_phandle(mdio_np, "mdio-parent-bus", 0);
+	if (parent_bus_node && !dev->info->phy_side_mdio_supported) {
+		dev_warn(dev->dev, "Side MDIO bus is not supported for this HW, ignoring 'mdio-parent-bus' property.\n");
+	} else if (parent_bus_node) {
+		parent_bus = of_mdio_find_bus(parent_bus_node);
+		if (!parent_bus) {
+			of_node_put(parent_bus_node);
+			return -EPROBE_DEFER;
+		}
+
+		dev->parent_mdio_bus = parent_bus;
+	}
+
 	bus = devm_mdiobus_alloc(ds->dev);
 	if (!bus) {
 		of_node_put(mdio_np);
 		return -ENOMEM;
 	}
 
+	if (dev->dev_ops->mdio_bus_preinit) {
+		ret = dev->dev_ops->mdio_bus_preinit(dev, !!parent_bus);
+		if (ret)
+			goto put_mdio_node;
+	}
+
+	if (dev->dev_ops->create_phy_addr_map) {
+		ret = dev->dev_ops->create_phy_addr_map(dev, !!parent_bus);
+		if (ret)
+			goto put_mdio_node;
+	} else {
+		for (i = 0; i < dev->info->port_cnt; i++)
+			dev->phy_addr_map[i] = i;
+	}
+
 	bus->priv = dev;
-	bus->read = ksz_sw_mdio_read;
-	bus->write = ksz_sw_mdio_write;
-	bus->name = "ksz user smi";
-	snprintf(bus->id, MII_BUS_ID_SIZE, "SMI-%d", ds->index);
+	if (parent_bus) {
+		bus->read = ksz_parent_mdio_read;
+		bus->write = ksz_parent_mdio_write;
+		bus->name = "KSZ side MDIO";
+		snprintf(bus->id, MII_BUS_ID_SIZE, "ksz-side-mdio-%d",
+			 ds->index);
+	} else {
+		bus->read = ksz_sw_mdio_read;
+		bus->write = ksz_sw_mdio_write;
+		bus->name = "ksz user smi";
+		snprintf(bus->id, MII_BUS_ID_SIZE, "SMI-%d", ds->index);
+	}
+
+	dsa_switch_for_each_user_port(dp, dev->ds) {
+		if (dev->info->internal_phy[dp->index] &&
+		    dev->phy_addr_map[dp->index] < PHY_MAX_ADDR)
+			bus->phy_mask |= BIT(dev->phy_addr_map[dp->index]);
+	}
+
+	ds->phys_mii_mask = bus->phy_mask;
 	bus->parent = ds->dev;
-	bus->phy_mask = ~ds->phys_mii_mask;
 
 	ds->user_mii_bus = bus;
 
@@ -2318,6 +2399,7 @@ static int ksz_mdio_register(struct ksz_device *dev)
 			ksz_irq_phy_free(dev);
 	}
 
+put_mdio_node:
 	of_node_put(mdio_np);
 
 	return ret;
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index bec846e20682f..fdfb624d3ff6a 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -65,6 +65,8 @@ struct ksz_chip_data {
 	u8 num_tx_queues;
 	u8 num_ipms; /* number of Internal Priority Maps */
 	bool tc_cbs_supported;
+	/* PHYs can be accessed via side MDIO channel */
+	bool phy_side_mdio_supported;
 	const struct ksz_dev_ops *ops;
 	const struct phylink_mac_ops *phylink_mac_ops;
 	bool phy_errata_9477;
@@ -191,6 +193,9 @@ struct ksz_device {
 	struct ksz_switch_macaddr *switch_macaddr;
 	struct net_device *hsr_dev;     /* HSR */
 	u8 hsr_ports;
+
+	u8 phy_addr_map[KSZ_MAX_NUM_PORTS];
+	struct mii_bus *parent_mdio_bus;
 };
 
 /* List of supported models */
@@ -326,6 +331,8 @@ struct ksz_dev_ops {
 	void (*port_cleanup)(struct ksz_device *dev, int port);
 	void (*port_setup)(struct ksz_device *dev, int port, bool cpu_port);
 	int (*set_ageing_time)(struct ksz_device *dev, unsigned int msecs);
+	int (*mdio_bus_preinit)(struct ksz_device *dev, bool side_mdio);
+	int (*create_phy_addr_map)(struct ksz_device *dev, bool side_mdio);
 	int (*r_phy)(struct ksz_device *dev, u16 phy, u16 reg, u16 *val);
 	int (*w_phy)(struct ksz_device *dev, u16 phy, u16 reg, u16 val);
 	void (*r_mib_cnt)(struct ksz_device *dev, int port, u16 addr,
-- 
2.39.5


