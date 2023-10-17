Return-Path: <netdev+bounces-41834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 121107CBFC4
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35A0C1C20AC7
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64598405E1;
	Tue, 17 Oct 2023 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QHglIiNL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C03381D8
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:43:55 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8539810E;
	Tue, 17 Oct 2023 02:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1697535832; x=1729071832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0/AkaBug76lUhOexNUXDImbASVXMh6f+eKlgxkydYlQ=;
  b=QHglIiNL2IMk2Nxa/+5YDrV6+RovvXoemHqPQ+RLuNQPDdFi7JL2LBZv
   OlmgnYRPLh/dsa+IurTr9p8Sq3KHRKYTXBUOkX98vlPB2jnKAjVNiwMZ+
   vTVh2LV4RgxIqdVNarDmpcE8SqpsjQj+YQzrBpl+wVvwWHNAUPMMvED3g
   Yv5DTr0VbMIB73pC6BqkaZnMl0G8Fz7Xs1E9yMPRzrIn8KCV32hZOsdqg
   yUTUfIqgWL1LYHN43JAQxAbcbbH4ymVgpawv/8F/H1j4WShddfuUAMMiB
   LWHWiAPJgWCE82/2NaFZajEPwXJ+4TCWLxC5cXp73xiVyhJCK+/T2vaQO
   w==;
X-CSE-ConnectionGUID: kBNkPMf2TJiKgY0/gLa5lw==
X-CSE-MsgGUID: 6hzqNTiMTKCetqZaKUiq/g==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="10101622"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2023 02:43:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 17 Oct 2023 02:43:32 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 17 Oct 2023 02:43:29 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <Bryan.Whitehead@microchip.com>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V1 4/7] net: lan743x: Add support to software-nodes for sfp and phylink
Date: Tue, 17 Oct 2023 15:12:05 +0530
Message-ID: <20231017094208.4956-5-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017094208.4956-1-Raju.Lakkaraju@microchip.com>
References: <20231017094208.4956-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Register software nodes and define the device properties.
software-node contains following properties.
  - gpio pin details
  - i2c bus information
  - sfp signals
  - phylink mode

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
 drivers/net/ethernet/microchip/Kconfig        |   5 +-
 drivers/net/ethernet/microchip/lan743x_main.c | 235 +++++++++++++++++-
 drivers/net/ethernet/microchip/lan743x_main.h |  36 +++
 3 files changed, 272 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
index 43ba71e82260..c50970705e88 100644
--- a/drivers/net/ethernet/microchip/Kconfig
+++ b/drivers/net/ethernet/microchip/Kconfig
@@ -50,8 +50,11 @@ config LAN743X
 	select FIXED_PHY
 	select CRC16
 	select CRC32
+	select I2C_PCI1XXXX
+	select GP_PCI1XXXX
 	help
-	  Support for the Microchip LAN743x PCI Express Gigabit Ethernet chip
+	  Support for the Microchip LAN743x and PCI11x1x families of PCI
+	  Express Ethernet devices
 
 	  To compile this driver as a module, choose M here. The module will be
 	  called lan743x.
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index eee3fe7e0c66..71cce7722a21 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -15,6 +15,9 @@
 #include <linux/rtnetlink.h>
 #include <linux/iopoll.h>
 #include <linux/crc16.h>
+#include <linux/i2c.h>
+#include <linux/gpio/machine.h>
+#include <linux/auxiliary_bus.h>
 #include "lan743x_main.h"
 #include "lan743x_ethtool.h"
 
@@ -24,6 +27,46 @@
 #define MMD_ACCESS_READ_INC	3
 #define PCS_POWER_STATE_DOWN	0x6
 #define PCS_POWER_STATE_UP	0x4
+#define PCI1XXXX_VENDOR_ID	0x1055
+#define PCI1XXXX_BR_PERIF_ID	0xA00C
+#define PCI1XXXX_PERIF_I2C_ID	0xA003
+#define PCI1XXXX_PERIF_GPIO_ID	0xA005
+#define PCI1XXXX_DEV_MASK	GENMASK(7, 4)
+#define PCI11X1X_TX_FAULT_GPIO	46
+#define PCI11X1X_TX_DIS_GPIO	47
+#define PCI11X1X_RATE_SEL0_GPIO	48
+#define PCI11X1X_LOS_GPIO	49
+#define PCI11X1X_MOD_DEF0_GPIO	51
+
+#define NODE_PROP(_NAME, _PROP)          \
+	((const struct software_node) {  \
+		.name = _NAME,           \
+		.properties = _PROP,     \
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
 
 static int pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 {
@@ -105,6 +148,91 @@ static void lan743x_pci_cleanup(struct lan743x_adapter *adapter)
 	pci_disable_device(adapter->pdev);
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
 static int lan743x_pci_init(struct lan743x_adapter *adapter,
 			    struct pci_dev *pdev)
 {
@@ -3045,6 +3173,90 @@ static int lan743x_rx_open(struct lan743x_rx *rx)
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
+							 PCI11X1X_TX_FAULT_GPIO,
+							 GPIO_ACTIVE_HIGH);
+	nodes->tx_disable_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_GPIO],
+							   PCI11X1X_TX_DIS_GPIO,
+							   GPIO_ACTIVE_HIGH);
+	nodes->mod_def0_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_GPIO],
+							 PCI11X1X_MOD_DEF0_GPIO,
+							 GPIO_ACTIVE_LOW);
+	nodes->los_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_GPIO],
+						    PCI11X1X_LOS_GPIO,
+						    GPIO_ACTIVE_HIGH);
+	nodes->rate_sel0_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_GPIO],
+							  PCI11X1X_RATE_SEL0_GPIO,
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
 static int lan743x_netdev_close(struct net_device *netdev)
 {
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
@@ -3260,6 +3472,14 @@ static void lan743x_full_cleanup(struct lan743x_adapter *adapter)
 {
 	unregister_netdev(adapter->netdev);
 
+	if (adapter->i2c_adap)
+		adapter->i2c_adap = NULL;
+
+	if (adapter->nodes)
+		software_node_unregister_node_group(adapter->nodes->group);
+
+	kfree(adapter->nodes);
+
 	lan743x_mdiobus_cleanup(adapter);
 	lan743x_hardware_cleanup(adapter);
 	lan743x_pci_cleanup(adapter);
@@ -3299,9 +3519,18 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 	if (ret)
 		return ret;
 
-	ret = lan743x_phy_init(adapter);
-	if (ret)
-		return ret;
+	if (adapter->is_sfp_support_en) {
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
index 6a3a45b98140..450d8984cdb5 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -5,6 +5,7 @@
 #define _LAN743X_H
 
 #include <linux/phy.h>
+#include <linux/property.h>
 #include "lan743x_ptp.h"
 
 #define DRIVER_AUTHOR   "Bryan Whitehead <Bryan.Whitehead@microchip.com>"
@@ -1008,6 +1009,39 @@ enum lan743x_sgmii_lsd {
 	LINK_2500_SLAVE
 };
 
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
@@ -1046,6 +1080,8 @@ struct lan743x_adapter {
 	u32			flags;
 	u32			hw_cfg;
 	phy_interface_t		phy_interface;
+	struct lan743x_sw_nodes	*nodes;
+	struct i2c_adapter	*i2c_adap;
 };
 
 #define LAN743X_COMPONENT_FLAG_RX(channel)  BIT(20 + (channel))
-- 
2.34.1


