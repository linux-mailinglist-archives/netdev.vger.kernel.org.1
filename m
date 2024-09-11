Return-Path: <netdev+bounces-127465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8522C975803
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 18:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 462B428265D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762781A3043;
	Wed, 11 Sep 2024 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="hniAZTJs"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F8F1ABEBA;
	Wed, 11 Sep 2024 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071315; cv=none; b=EHNTTRuhmq9f/v9hUg2cKD30F80abXylb+dtE6uNY1Kz3Thxh8EvHVlu2Frllqtbsk9eMB5dBzFM8myk/xKB1QCONlPzHdQDS8hKyH32mXGJBjB3/8tUjmgZ/etMZHZLn9QYwvgVKBSILtouRWx7c3o365OioiUVTI6fg7qwRyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071315; c=relaxed/simple;
	bh=KTKOhBVaRC9Y4aEDAHvhxydRKStYcMQJHFGLeIh2EUE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YtnQ6O2AIBCJzS/TSqvnO/VkhrHIJKiYTmlLTTW9I+kcddkMHmLQWRF3KoFZK/sbfNbHfQLlQUEHzFQYwabNwZgGEZDFWbx6Waou9Z55xaPZBc75xiMTJzRBkyvo6Y46Qpth28SIVNFbfP24Okp+uCEndlTY/BsqHbBnEUtCXVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=hniAZTJs; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726071313; x=1757607313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KTKOhBVaRC9Y4aEDAHvhxydRKStYcMQJHFGLeIh2EUE=;
  b=hniAZTJsrnaFXcpW6SLUxxftHkASmkqrkCvFEzxaMZvmLos394f9+ug3
   6F+l0RYZZBsBaEWcJ+0/gclYjNLFMtaqUS7Xbo+hWFOKsi/USuCCCDK9P
   D2BnPwG8wsHQJGudpiLVj3cJhFOarXPXFfhzqQBbIX/ZugAPYvuFCwlYk
   rlbP/bn0dBqMVecvn7wBaBT2vHRfrbJYB/hjf6Pg4j5GH0HoS4mIoXahq
   RKdZQLS9WMn6BiCP2+fg08Drl5Xw1uUhs6cNjjwDx30FGTnQW0eR746oW
   Fljk7mciC0RfQ9uevhpJGw29xz3WFY1wz5NLC1EV21PG9JXjRSZL4PGDQ
   A==;
X-CSE-ConnectionGUID: I+zUQG3KSiiiwGtN22Ixjw==
X-CSE-MsgGUID: RrGUA+tSQM6vKfXV7qU2WA==
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="32280146"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2024 09:15:11 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 11 Sep 2024 09:15:00 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 11 Sep 2024 09:14:55 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <rdunlap@infradead.org>, <andrew@lunn.ch>,
	<Steen.Hegelund@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next V2 2/5] net: lan743x: Add support to software-nodes for sfp
Date: Wed, 11 Sep 2024 21:40:51 +0530
Message-ID: <20240911161054.4494-3-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Register software nodes and define the device properties.
software-node contains following properties.
  - gpio pin details
  - i2c bus information
  - sfp signals
  - phylink mode

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
Change List:
============
V1 -> V2:
  - SFP GPIO definitions and other macros move from lan743x_main.c to
    lan743x_main.h file
  - Change from "PCI11X1X_" to "PCI11X1X_EVB_PCI11010_" strings for GPIO macros
V0 -> V1:                                                                       
  - No changes

 drivers/net/ethernet/microchip/Kconfig        |   2 +
 drivers/net/ethernet/microchip/lan743x_main.c | 198 +++++++++++++++++-
 drivers/net/ethernet/microchip/lan743x_main.h |  82 ++++++++
 3 files changed, 278 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
index 2e3eb37a45cd..9c08a4af257a 100644
--- a/drivers/net/ethernet/microchip/Kconfig
+++ b/drivers/net/ethernet/microchip/Kconfig
@@ -50,6 +50,8 @@ config LAN743X
 	select CRC16
 	select CRC32
 	select PHYLINK
+	select I2C_PCI1XXXX
+	select GP_PCI1XXXX
 	help
 	  Support for the Microchip LAN743x and PCI11x1x families of PCI
 	  Express Ethernet devices
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 20a42a2c7b0e..dc571020ae1b 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -100,8 +100,98 @@ static bool is_pci11x1x_chip(struct lan743x_adapter *adapter)
 	return false;
 }
 
+static void *pci1xxxx_perif_drvdata_get(struct lan743x_adapter *adapter,
+					u16 perif_id)
+{
+	struct pci_dev *pdev = adapter->pdev;
+	struct pci_bus *perif_bus;
+	struct pci_dev *perif_dev;
+	struct pci_dev *br_dev;
+	struct pci_bus *br_bus;
+	struct pci_dev *dev;
+
+	/* PCI11x1x devices' PCIe topology consists of a top level pcie
+	 * switch with up to four downstream ports, some of which have
+	 * integrated endpoints connected to them. One of the downstream ports
+	 * has an embedded single function pcie ethernet controller which is
+	 * handled by this driver. Another downstream port has an
+	 * embedded multifunction pcie endpoint, with four pcie functions
+	 * (the "peripheral controllers": I2C controller, GPIO controller,
+	 * UART controllers, SPIcontrollers)
+	 * The code below navigates the PCI11x1x topology
+	 * to find (by matching its PCI device ID) the peripheral controller
+	 * that should be paired to the embedded ethernet controller.
+	 */
+	br_dev = pci_upstream_bridge(pdev);
+	if (!br_dev) {
+		netif_err(adapter, drv, adapter->netdev,
+			  "upstream bridge not found\n");
+		return br_dev;
+	}
+
+	br_bus = br_dev->bus;
+	list_for_each_entry(dev, &br_bus->devices, bus_list) {
+		if (dev->vendor == PCI1XXXX_VENDOR_ID &&
+		    (dev->device & ~PCI1XXXX_DEV_MASK) ==
+		     PCI1XXXX_BR_PERIF_ID) {
+			perif_bus = dev->subordinate;
+			list_for_each_entry(perif_dev, &perif_bus->devices,
+					    bus_list) {
+				if (perif_dev->vendor == PCI1XXXX_VENDOR_ID &&
+				    (perif_dev->device & ~PCI1XXXX_DEV_MASK) ==
+				     perif_id)
+					return pci_get_drvdata(perif_dev);
+			}
+		}
+	}
+
+	netif_err(adapter, drv, adapter->netdev,
+		  "pci1xxxx peripheral (0x%X) device not found\n", perif_id);
+
+	return NULL;
+}
+
+static int pci1xxxx_i2c_adapter_get(struct lan743x_adapter *adapter)
+{
+	struct pci1xxxx_i2c *i2c_drvdata;
+
+	i2c_drvdata = pci1xxxx_perif_drvdata_get(adapter, PCI1XXXX_PERIF_I2C_ID);
+	if (!i2c_drvdata)
+		return -EPROBE_DEFER;
+
+	adapter->i2c_adap = &i2c_drvdata->adap;
+	snprintf(adapter->nodes->i2c_name, sizeof(adapter->nodes->i2c_name),
+		 adapter->i2c_adap->name);
+	netif_dbg(adapter, drv, adapter->netdev, "Found %s\n",
+		  adapter->i2c_adap->name);
+
+	return 0;
+}
+
+static int pci1xxxx_gpio_dev_get(struct lan743x_adapter *adapter)
+{
+	struct aux_bus_device *aux_bus;
+	struct device *gpio_dev;
+
+	aux_bus = pci1xxxx_perif_drvdata_get(adapter, PCI1XXXX_PERIF_GPIO_ID);
+	if (!aux_bus)
+		return -EPROBE_DEFER;
+
+	gpio_dev = &aux_bus->aux_device_wrapper[1]->aux_dev.dev;
+	snprintf(adapter->nodes->gpio_name, sizeof(adapter->nodes->gpio_name),
+		 dev_name(gpio_dev));
+	netif_dbg(adapter, drv, adapter->netdev, "Found %s\n",
+		  adapter->nodes->gpio_name);
+	return 0;
+}
+
 static void lan743x_pci_cleanup(struct lan743x_adapter *adapter)
 {
+	if (adapter->nodes) {
+		software_node_unregister_node_group(adapter->nodes->group);
+		kfree(adapter->nodes);
+	}
+
 	pci_release_selected_regions(adapter->pdev,
 				     pci_select_bars(adapter->pdev,
 						     IORESOURCE_MEM));
@@ -2888,6 +2978,90 @@ static int lan743x_rx_open(struct lan743x_rx *rx)
 	return ret;
 }
 
+static int lan743x_swnodes_register(struct lan743x_adapter *adapter)
+{
+	struct pci_dev *pdev = adapter->pdev;
+	struct lan743x_sw_nodes *nodes;
+	struct software_node *swnodes;
+	int ret;
+	u32 id;
+
+	nodes = kzalloc(sizeof(*nodes), GFP_KERNEL);
+	if (!nodes)
+		return -ENOMEM;
+
+	adapter->nodes = nodes;
+
+	ret = pci1xxxx_gpio_dev_get(adapter);
+	if (ret < 0)
+		return ret;
+
+	ret = pci1xxxx_i2c_adapter_get(adapter);
+	if (ret < 0)
+		return ret;
+
+	id = (pdev->bus->number << 8) | pdev->devfn;
+	snprintf(nodes->sfp_name, sizeof(nodes->sfp_name),
+		 "sfp-%d", id);
+	snprintf(nodes->phylink_name, sizeof(nodes->phylink_name),
+		 "mchp-pci1xxxx-phylink-%d", id);
+
+	swnodes = nodes->swnodes;
+
+	nodes->gpio_props[0] = PROPERTY_ENTRY_STRING("pinctrl-names",
+						     "default");
+	swnodes[SWNODE_GPIO] = NODE_PROP(nodes->gpio_name, nodes->gpio_props);
+
+	nodes->tx_fault_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_GPIO],
+							 PCI11X1X_EVB_PCI11010_TX_FAULT_GPIO,
+							 GPIO_ACTIVE_HIGH);
+	nodes->tx_disable_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_GPIO],
+							   PCI11X1X_EVB_PCI11010_TX_DIS_GPIO,
+							   GPIO_ACTIVE_HIGH);
+	nodes->mod_def0_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_GPIO],
+							 PCI11X1X_EVB_PCI11010_MOD_DEF0_GPIO,
+							 GPIO_ACTIVE_LOW);
+	nodes->los_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_GPIO],
+						    PCI11X1X_EVB_PCI11010_LOS_GPIO,
+						    GPIO_ACTIVE_HIGH);
+	nodes->rate_sel0_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_GPIO],
+							  PCI11X1X_EVB_PCI11010_RATE_SEL0_GPIO,
+							  GPIO_ACTIVE_HIGH);
+
+	nodes->i2c_props[0] = PROPERTY_ENTRY_STRING("pinctrl-names", "default");
+	swnodes[SWNODE_I2C] = NODE_PROP(nodes->i2c_name, nodes->i2c_props);
+	nodes->i2c_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_I2C]);
+
+	nodes->sfp_props[0] = PROPERTY_ENTRY_STRING("compatible", "sff,sfp");
+	nodes->sfp_props[1] = PROPERTY_ENTRY_REF_ARRAY("i2c-bus",
+						       nodes->i2c_ref);
+	nodes->sfp_props[2] = PROPERTY_ENTRY_REF_ARRAY("tx-fault-gpios",
+						       nodes->tx_fault_ref);
+	nodes->sfp_props[3] = PROPERTY_ENTRY_REF_ARRAY("tx-disable-gpios",
+						       nodes->tx_disable_ref);
+	nodes->sfp_props[4] = PROPERTY_ENTRY_REF_ARRAY("mod-def0-gpios",
+						       nodes->mod_def0_ref);
+	nodes->sfp_props[5] = PROPERTY_ENTRY_REF_ARRAY("los-gpios",
+						       nodes->los_ref);
+	nodes->sfp_props[6] = PROPERTY_ENTRY_REF_ARRAY("rate-select0-gpios",
+						       nodes->rate_sel0_ref);
+	swnodes[SWNODE_SFP] = NODE_PROP(nodes->sfp_name, nodes->sfp_props);
+	nodes->sfp_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_SFP]);
+	nodes->phylink_props[0] = PROPERTY_ENTRY_STRING("managed",
+							"in-band-status");
+	nodes->phylink_props[1] = PROPERTY_ENTRY_REF_ARRAY("sfp",
+							   nodes->sfp_ref);
+	swnodes[SWNODE_PHYLINK] = NODE_PROP(nodes->phylink_name,
+					    nodes->phylink_props);
+
+	nodes->group[SWNODE_GPIO] = &swnodes[SWNODE_GPIO];
+	nodes->group[SWNODE_I2C] = &swnodes[SWNODE_I2C];
+	nodes->group[SWNODE_SFP] = &swnodes[SWNODE_SFP];
+	nodes->group[SWNODE_PHYLINK] = &swnodes[SWNODE_PHYLINK];
+
+	return software_node_register_node_group(nodes->group);
+}
+
 static int lan743x_phylink_sgmii_config(struct lan743x_adapter *adapter)
 {
 	u32 sgmii_ctl;
@@ -3105,6 +3279,7 @@ static const struct phylink_mac_ops lan743x_phylink_mac_ops = {
 static int lan743x_phylink_create(struct lan743x_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
+	struct fwnode_handle *fwnode = NULL;
 	struct phylink *pl;
 
 	adapter->phylink_config.dev = &netdev->dev;
@@ -3138,7 +3313,13 @@ static int lan743x_phylink_create(struct lan743x_adapter *adapter)
 		phy_interface_set_rgmii(adapter->phylink_config.supported_interfaces);
 	}
 
-	pl = phylink_create(&adapter->phylink_config, NULL,
+	if (adapter->nodes) {
+		fwnode = software_node_fwnode(adapter->nodes->group[SWNODE_PHYLINK]);
+		if (!fwnode)
+			return -ENODEV;
+	}
+
+	pl = phylink_create(&adapter->phylink_config, fwnode,
 			    adapter->phy_interface, &lan743x_phylink_mac_ops);
 
 	if (IS_ERR(pl)) {
@@ -3511,9 +3692,18 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 	if (ret)
 		return ret;
 
-	ret = lan743x_phy_init(adapter);
-	if (ret)
-		return ret;
+	if (adapter->is_sfp_support_en && !adapter->nodes) {
+		ret = lan743x_swnodes_register(adapter);
+		if (ret) {
+			netdev_err(adapter->netdev,
+				   "failed to register software nodes\n");
+			return ret;
+		}
+	} else {
+		ret = lan743x_phy_init(adapter);
+		if (ret)
+			return ret;
+	}
 
 	ret = lan743x_ptp_init(adapter);
 	if (ret)
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index f7e96496600b..bf0d0f285e39 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -6,6 +6,10 @@
 
 #include <linux/phy.h>
 #include <linux/phylink.h>
+#include <linux/property.h>
+#include <linux/i2c.h>
+#include <linux/gpio/machine.h>
+#include <linux/auxiliary_bus.h>
 #include "lan743x_ptp.h"
 
 #define DRIVER_AUTHOR   "Bryan Whitehead <Bryan.Whitehead@microchip.com>"
@@ -1047,6 +1051,40 @@ enum lan743x_sgmii_lsd {
 
 #define MAC_SUPPORTED_WAKES  (WAKE_BCAST | WAKE_UCAST | WAKE_MCAST | \
 			      WAKE_MAGIC | WAKE_ARP)
+
+enum lan743x_swnodes {
+	SWNODE_GPIO = 0,
+	SWNODE_I2C,
+	SWNODE_SFP,
+	SWNODE_PHYLINK,
+	SWNODE_MAX
+};
+
+#define I2C_DRV_NAME		48
+#define GPIO_DRV_NAME		32
+#define SFP_NODE_NAME		32
+#define PHYLINK_NODE_NAME	32
+
+struct lan743x_sw_nodes {
+	char gpio_name[GPIO_DRV_NAME];
+	char i2c_name[I2C_DRV_NAME];
+	char sfp_name[SFP_NODE_NAME];
+	char phylink_name[PHYLINK_NODE_NAME];
+	struct property_entry gpio_props[1];
+	struct property_entry i2c_props[1];
+	struct property_entry sfp_props[8];
+	struct property_entry phylink_props[2];
+	struct software_node_ref_args i2c_ref[1];
+	struct software_node_ref_args tx_fault_ref[1];
+	struct software_node_ref_args tx_disable_ref[1];
+	struct software_node_ref_args mod_def0_ref[1];
+	struct software_node_ref_args los_ref[1];
+	struct software_node_ref_args rate_sel0_ref[1];
+	struct software_node_ref_args sfp_ref[1];
+	struct software_node swnodes[SWNODE_MAX];
+	const struct software_node *group[SWNODE_MAX + 1];
+};
+
 struct lan743x_adapter {
 	struct net_device       *netdev;
 	struct mii_bus		*mdiobus;
@@ -1089,6 +1127,8 @@ struct lan743x_adapter {
 	phy_interface_t		phy_interface;
 	struct phylink		*phylink;
 	struct phylink_config	phylink_config;
+	struct lan743x_sw_nodes	*nodes;
+	struct i2c_adapter	*i2c_adap;
 };
 
 #define LAN743X_COMPONENT_FLAG_RX(channel)  BIT(20 + (channel))
@@ -1202,6 +1242,48 @@ struct lan743x_rx_buffer_info {
 #define RX_PROCESS_RESULT_NOTHING_TO_DO     (0)
 #define RX_PROCESS_RESULT_BUFFER_RECEIVED   (1)
 
+#define PCI1XXXX_VENDOR_ID      0x1055
+#define PCI1XXXX_BR_PERIF_ID    0xA00C
+#define PCI1XXXX_PERIF_I2C_ID   0xA003
+#define PCI1XXXX_PERIF_GPIO_ID  0xA005
+#define PCI1XXXX_DEV_MASK       GENMASK(7, 4)
+
+#define PCI11X1X_EVB_PCI11010_TX_FAULT_GPIO  46
+#define PCI11X1X_EVB_PCI11010_TX_DIS_GPIO    47
+#define PCI11X1X_EVB_PCI11010_RATE_SEL0_GPIO 48
+#define PCI11X1X_EVB_PCI11010_LOS_GPIO       49
+#define PCI11X1X_EVB_PCI11010_MOD_DEF0_GPIO  51
+
+#define NODE_PROP(_NAME, _PROP)         \
+	((const struct software_node) { \
+		.name = _NAME,          \
+		.properties = _PROP,    \
+	})
+
+struct pci1xxxx_i2c {
+	struct completion i2c_xfer_done;
+	bool i2c_xfer_in_progress;
+	struct i2c_adapter adap;
+	void __iomem *i2c_base;
+	u32 freq;
+	u32 flags;
+};
+
+struct gp_aux_data_type {
+	int irq_num;
+	resource_size_t region_start;
+	resource_size_t region_length;
+};
+
+struct auxiliary_device_wrapper {
+	struct auxiliary_device aux_dev;
+	struct gp_aux_data_type gp_aux_data;
+};
+
+struct aux_bus_device {
+	struct auxiliary_device_wrapper *aux_device_wrapper[2];
+};
+
 u32 lan743x_csr_read(struct lan743x_adapter *adapter, int offset);
 void lan743x_csr_write(struct lan743x_adapter *adapter, int offset, u32 data);
 int lan743x_hs_syslock_acquire(struct lan743x_adapter *adapter, u16 timeout);
-- 
2.34.1


