Return-Path: <netdev+bounces-142255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CEB9BDFEE
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E6A2855D7
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 08:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFC51D95A8;
	Wed,  6 Nov 2024 08:00:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DAA1D5AB5
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730880010; cv=none; b=ejZkLY8+/lvq8mDp/m2cH7MTEVuL5ui0mvGeZnTPI/DziMq6bJxrx3NuEF99rb6I66+tFOU4Xjehzf4s966M2KDtTUYQ6KRKmg8pdLEiVzHYDDnpChsLCgm/CfPXBJrYYpXMbhr0/j/mwdizg2QieXhZP2nTSUOr0H5oNfGIXlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730880010; c=relaxed/simple;
	bh=XfyTAQa+XSyqkdFh9qJ64RLPb4jY0ssbC51Qc3HzkRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qy7RKRbxcXv/HRhGstArsuUiXFZ+Cbo23zAaC5tprI4WJNfnBh8bui6rjvZvsOm5QOQyE+mgByGfCqLN3qm43/Pf3Z0HMx/uexURFmKxEL08YDQwvXYBdEy7pwE6GwC366MeRr+EqDwS8DSfEfdcH72qZd8s9WxNnRUdh2+xsPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1t8ax6-0000ng-AV; Wed, 06 Nov 2024 08:59:44 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t8ax5-002Gdi-03;
	Wed, 06 Nov 2024 08:59:43 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t8ax4-006rsB-2z;
	Wed, 06 Nov 2024 08:59:42 +0100
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
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org,
	Marek Vasut <marex@denx.de>
Subject: [PATCH net-next v4 3/6] net: dsa: microchip: Refactor MDIO handling for side MDIO access
Date: Wed,  6 Nov 2024 08:59:38 +0100
Message-Id: <20241106075942.1636998-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241106075942.1636998-1-o.rempel@pengutronix.de>
References: <20241106075942.1636998-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
changes v4:
- add Reviewed-by: Andrew Lunn <andrew@lunn.ch>
changes v2:
- fail on phy_side_mdio_supported
- add of_node_put(parent_bus_node)
- add comments
---
 drivers/net/dsa/microchip/ksz_common.c | 175 +++++++++++++++++++++++--
 drivers/net/dsa/microchip/ksz_common.h |  59 +++++++++
 2 files changed, 224 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index f73833e24622a..e9460650d46e0 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2236,16 +2236,100 @@ static int ksz_sw_mdio_write(struct mii_bus *bus, int addr, int regnum,
 	return dev->dev_ops->w_phy(dev, addr, regnum, val);
 }
 
+/**
+ * ksz_parent_mdio_read - Read data from a PHY register on the parent MDIO bus.
+ * @bus: MDIO bus structure.
+ * @addr: PHY address on the parent MDIO bus.
+ * @regnum: Register number to read.
+ *
+ * This function provides a direct read operation on the parent MDIO bus for
+ * accessing PHY registers. By bypassing SPI or I2C, it uses the parent MDIO bus
+ * to retrieve data from the PHY registers at the specified address and register
+ * number.
+ *
+ * Return: Value of the PHY register, or a negative error code on failure.
+ */
+static int ksz_parent_mdio_read(struct mii_bus *bus, int addr, int regnum)
+{
+	struct ksz_device *dev = bus->priv;
+
+	return mdiobus_read_nested(dev->parent_mdio_bus, addr, regnum);
+}
+
+/**
+ * ksz_parent_mdio_write - Write data to a PHY register on the parent MDIO bus.
+ * @bus: MDIO bus structure.
+ * @addr: PHY address on the parent MDIO bus.
+ * @regnum: Register number to write to.
+ * @val: Value to write to the PHY register.
+ *
+ * This function provides a direct write operation on the parent MDIO bus for
+ * accessing PHY registers. Bypassing SPI or I2C, it uses the parent MDIO bus
+ * to modify the PHY register values at the specified address.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int ksz_parent_mdio_write(struct mii_bus *bus, int addr, int regnum,
+				 u16 val)
+{
+	struct ksz_device *dev = bus->priv;
+
+	return mdiobus_write_nested(dev->parent_mdio_bus, addr, regnum, val);
+}
+
+/**
+ * ksz_phy_addr_to_port - Map a PHY address to the corresponding switch port.
+ * @dev: Pointer to device structure.
+ * @addr: PHY address to map to a port.
+ *
+ * This function finds the corresponding switch port for a given PHY address by
+ * iterating over all user ports on the device. It checks if a port's PHY
+ * address in `phy_addr_map` matches the specified address and if the port
+ * contains an internal PHY. If a match is found, the index of the port is
+ * returned.
+ *
+ * Return: Port index on success, or -EINVAL if no matching port is found.
+ */
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
+/**
+ * ksz_irq_phy_setup - Configure IRQs for PHYs in the KSZ device.
+ * @dev: Pointer to the KSZ device structure.
+ *
+ * Sets up IRQs for each active PHY connected to the KSZ switch by mapping the
+ * appropriate IRQs for each PHY and assigning them to the `user_mii_bus` in
+ * the DSA switch structure. Each IRQ is mapped based on the port's IRQ domain.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
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
@@ -2263,40 +2347,109 @@ static int ksz_irq_phy_setup(struct ksz_device *dev)
 	return ret;
 }
 
+/**
+ * ksz_irq_phy_free - Release IRQ mappings for PHYs in the KSZ device.
+ * @dev: Pointer to the KSZ device structure.
+ *
+ * Releases any IRQ mappings previously assigned to active PHYs in the KSZ
+ * switch by disposing of each mapped IRQ in the `user_mii_bus` structure.
+ */
 static void ksz_irq_phy_free(struct ksz_device *dev)
 {
 	struct dsa_switch *ds = dev->ds;
 	int phy;
 
-	for (phy = 0; phy < KSZ_MAX_NUM_PORTS; phy++)
+	for (phy = 0; phy < PHY_MAX_ADDR; phy++)
 		if (BIT(phy) & ds->phys_mii_mask)
 			irq_dispose_mapping(ds->user_mii_bus->irq[phy]);
 }
 
+/**
+ * ksz_mdio_register - Register and configure the MDIO bus for the KSZ device.
+ * @dev: Pointer to the KSZ device structure.
+ *
+ * This function sets up and registers an MDIO bus for the KSZ switch device,
+ * allowing access to its internal PHYs. If the device supports side MDIO,
+ * the function will configure the external MDIO controller specified by the
+ * "mdio-parent-bus" device tree property to directly manage internal PHYs.
+ * Otherwise, SPI or I2C access is set up for PHY access.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
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
+		dev_err(dev->dev, "Side MDIO bus is not supported for this HW, ignoring 'mdio-parent-bus' property.\n");
+		ret = -EINVAL;
+
+		goto put_mdio_node;
+	} else if (parent_bus_node) {
+		parent_bus = of_mdio_find_bus(parent_bus_node);
+		if (!parent_bus) {
+			ret = -EPROBE_DEFER;
+
+			goto put_mdio_node;
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
 
@@ -2316,7 +2469,9 @@ static int ksz_mdio_register(struct ksz_device *dev)
 			ksz_irq_phy_free(dev);
 	}
 
+put_mdio_node:
 	of_node_put(mdio_np);
+	of_node_put(parent_bus_node);
 
 	return ret;
 }
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index bec846e20682f..bbb548af201ef 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -65,6 +65,12 @@ struct ksz_chip_data {
 	u8 num_tx_queues;
 	u8 num_ipms; /* number of Internal Priority Maps */
 	bool tc_cbs_supported;
+
+	/**
+	 * @phy_side_mdio_supported: Indicates if the chip supports an additional
+	 * side MDIO channel for accessing integrated PHYs.
+	 */
+	bool phy_side_mdio_supported;
 	const struct ksz_dev_ops *ops;
 	const struct phylink_mac_ops *phylink_mac_ops;
 	bool phy_errata_9477;
@@ -191,6 +197,22 @@ struct ksz_device {
 	struct ksz_switch_macaddr *switch_macaddr;
 	struct net_device *hsr_dev;     /* HSR */
 	u8 hsr_ports;
+
+	/**
+	 * @phy_addr_map: Array mapping switch ports to their corresponding PHY
+	 * addresses.
+	 */
+	u8 phy_addr_map[KSZ_MAX_NUM_PORTS];
+
+	/**
+	 * @parent_mdio_bus: Pointer to the external MDIO bus controller.
+	 *
+	 * This points to an external MDIO bus controller that is used to access
+	 * the  PHYs integrated within the switch. Unlike an integrated MDIO
+	 * bus, this external controller provides a direct path for managing
+	 * the switch’s internal PHYs, bypassing the main SPI interface.
+	 */
+	struct mii_bus *parent_mdio_bus;
 };
 
 /* List of supported models */
@@ -326,6 +348,43 @@ struct ksz_dev_ops {
 	void (*port_cleanup)(struct ksz_device *dev, int port);
 	void (*port_setup)(struct ksz_device *dev, int port, bool cpu_port);
 	int (*set_ageing_time)(struct ksz_device *dev, unsigned int msecs);
+
+	/**
+	 * @mdio_bus_preinit: Function pointer to pre-initialize the MDIO bus
+	 *                    for accessing PHYs.
+	 * @dev: Pointer to device structure.
+	 * @side_mdio: Boolean indicating if the PHYs are accessed over a side
+	 *             MDIO bus.
+	 *
+	 * This function pointer is used to configure the MDIO bus for PHY
+	 * access before initiating regular PHY operations. It enables either
+	 * SPI/I2C or side MDIO access modes by unlocking necessary registers
+	 * and setting up access permissions for the selected mode.
+	 *
+	 * Return:
+	 *  - 0 on success.
+	 *  - Negative error code on failure.
+	 */
+	int (*mdio_bus_preinit)(struct ksz_device *dev, bool side_mdio);
+
+	/**
+	 * @create_phy_addr_map: Function pointer to create a port-to-PHY
+	 *                       address map.
+	 * @dev: Pointer to device structure.
+	 * @side_mdio: Boolean indicating if the PHYs are accessed over a side
+	 *             MDIO bus.
+	 *
+	 * This function pointer is responsible for mapping switch ports to PHY
+	 * addresses according to the configured access mode (SPI or side MDIO)
+	 * and the device’s strap configuration. The mapping setup may vary
+	 * depending on the chip variant and configuration. Ensures the correct
+	 * address mapping for PHY communication.
+	 *
+	 * Return:
+	 *  - 0 on success.
+	 *  - Negative error code on failure (e.g., invalid configuration).
+	 */
+	int (*create_phy_addr_map)(struct ksz_device *dev, bool side_mdio);
 	int (*r_phy)(struct ksz_device *dev, u16 phy, u16 reg, u16 *val);
 	int (*w_phy)(struct ksz_device *dev, u16 phy, u16 reg, u16 val);
 	void (*r_mib_cnt)(struct ksz_device *dev, int port, u16 addr,
-- 
2.39.5


