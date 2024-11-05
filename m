Return-Path: <netdev+bounces-141853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229819BC8B3
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 10:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AABAD283C02
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 09:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926F31D14F3;
	Tue,  5 Nov 2024 09:10:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF95A1CF5EE
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730797809; cv=none; b=AW6Pr6wQB1SHNs6BvL3knKp1VAl/wuopAWg+1V+A+3oAzv5GuJQccDfhCQdlCvQqBgyvQDcRHfIxGfsgd1s25lgMvXAAVIvxjttVD+dgwpN0m1D4kRJGNp8o7mQYrGVfeh5NINQ6j5RWZgfNnihmIOnAaElW/Uz46QMEh9xvsZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730797809; c=relaxed/simple;
	bh=UGvGBoQjhb5/qwftI5v5FRQl/ddwR/37BXspqE1zSDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t2WE+MnxdsrZkqn2N6h1I1j/jKY2ghv4tpF69v23JzPL0kFouCeT9y5uPusmrdjcCs4S7iYv3DOUILyViFRb0V0ta6Rwu9ExzU/K3Sfyvby55Xk/D9nSSZYs8JDCa/1rXeeTuT5H8CnQmnwyh33GJgDNR7n5+GL2dUJ8bHRUv3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1t8FZL-0003oR-Rq; Tue, 05 Nov 2024 10:09:47 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t8FZK-0027Yb-1g;
	Tue, 05 Nov 2024 10:09:46 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1t8FZK-002ogQ-1M;
	Tue, 05 Nov 2024 10:09:46 +0100
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
Subject: [PATCH net-next v3 6/6] net: dsa: microchip: parse PHY config from device tree
Date: Tue,  5 Nov 2024 10:09:44 +0100
Message-Id: <20241105090944.671379-7-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241105090944.671379-1-o.rempel@pengutronix.de>
References: <20241105090944.671379-1-o.rempel@pengutronix.de>
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

Introduce ksz_parse_dt_phy_config() to validate and parse PHY
configuration from the device tree for KSZ switches. This function
ensures proper setup of internal PHYs by checking `phy-handle`
properties, verifying expected PHY IDs, and handling parent node
mismatches. Sets the PHY mask on the MII bus if validation is
successful. Returns -EINVAL on configuration errors.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz_common.c | 80 ++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 3909b55857430..cd1a466504180 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2373,6 +2373,77 @@ static void ksz_irq_phy_free(struct ksz_device *dev)
 			irq_dispose_mapping(ds->user_mii_bus->irq[phy]);
 }

+/**
+ * ksz_parse_dt_phy_config - Parse and validate PHY configuration from DT
+ * @dev: pointer to the KSZ device structure
+ * @bus: pointer to the MII bus structure
+ * @mdio_np: pointer to the MDIO node in the device tree
+ *
+ * This function parses and validates PHY configurations for each user port
+ * defined in the device tree for a KSZ switch device. It verifies that the
+ * `phy-handle` properties are correctly set and that the internal PHYs match
+ * expected IDs and parent nodes. Sets up the PHY mask in the MII bus if all
+ * validations pass. Logs error messages for any mismatches or missing data.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+static int ksz_parse_dt_phy_config(struct ksz_device *dev, struct mii_bus *bus,
+				   struct device_node *mdio_np)
+{
+	struct device_node *phy_node, *phy_parent_node;
+	bool phys_are_valid = true;
+	struct dsa_port *dp;
+	u32 phy_id;
+	int ret;
+
+	dsa_switch_for_each_user_port(dp, dev->ds) {
+		if (!dev->info->internal_phy[dp->index])
+			continue;
+
+		phy_node = of_parse_phandle(dp->dn, "phy-handle", 0);
+		if (!phy_node) {
+			dev_err(dev->dev, "failed to parse phy-handle for port %d.\n",
+				dp->index);
+			phys_are_valid = false;
+			continue;
+		}
+
+		phy_parent_node = of_get_parent(phy_node);
+		if (!phy_parent_node) {
+			dev_err(dev->dev, "failed to get PHY-parent node for port %d\n",
+				dp->index);
+			phys_are_valid = false;
+		} else if (dev->info->internal_phy[dp->index] &&
+			   phy_parent_node != mdio_np) {
+			dev_err(dev->dev, "PHY-parent node mismatch for port %d, expected %pOF, got %pOF\n",
+				dp->index, mdio_np, phy_parent_node);
+			phys_are_valid = false;
+		} else {
+			ret = of_property_read_u32(phy_node, "reg", &phy_id);
+			if (ret < 0) {
+				dev_err(dev->dev, "failed to read PHY ID for port %d. Error %d\n",
+					dp->index, ret);
+				phys_are_valid = false;
+			} else if (phy_id != dev->phy_addr_map[dp->index]) {
+				dev_err(dev->dev, "PHY ID mismatch for port %d, expected 0x%x, got 0x%x\n",
+					dp->index, dev->phy_addr_map[dp->index],
+					phy_id);
+				phys_are_valid = false;
+			} else {
+				bus->phy_mask |= BIT(phy_id);
+			}
+		}
+
+		of_node_put(phy_node);
+		of_node_put(phy_parent_node);
+	}
+
+	if (!phys_are_valid)
+		return -EINVAL;
+
+	return 0;
+}
+
 /**
  * ksz_mdio_register - Register and configure the MDIO bus for the KSZ device.
  * @dev: Pointer to the KSZ device structure.
@@ -2392,7 +2463,6 @@ static int ksz_mdio_register(struct ksz_device *dev)
 	struct dsa_switch *ds = dev->ds;
 	struct device_node *mdio_np;
 	struct mii_bus *bus;
-	struct dsa_port *dp;
 	int ret, i;

 	mdio_np = of_get_child_by_name(dev->dev->of_node, "mdio");
@@ -2451,11 +2521,9 @@ static int ksz_mdio_register(struct ksz_device *dev)
 		snprintf(bus->id, MII_BUS_ID_SIZE, "SMI-%d", ds->index);
 	}

-	dsa_switch_for_each_user_port(dp, dev->ds) {
-		if (dev->info->internal_phy[dp->index] &&
-		    dev->phy_addr_map[dp->index] < PHY_MAX_ADDR)
-			bus->phy_mask |= BIT(dev->phy_addr_map[dp->index]);
-	}
+	ret = ksz_parse_dt_phy_config(dev, bus, mdio_np);
+	if (ret)
+		goto put_mdio_node;

 	ds->phys_mii_mask = bus->phy_mask;
 	bus->parent = ds->dev;
--
2.39.5


