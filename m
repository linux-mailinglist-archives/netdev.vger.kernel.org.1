Return-Path: <netdev+bounces-127254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 847B7974C52
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 10:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4875D2864E0
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 08:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F8216DEA7;
	Wed, 11 Sep 2024 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KSW5Ah9O"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAD0155738;
	Wed, 11 Sep 2024 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726042597; cv=none; b=oWtt0gjVV25niCyG8Gj4/Jr670VvsGhA8XLKfnBABZDzm6RArmHPk/0nUNndDUqyhueDG0K0nBD9YYtA4dDC0Xsn+J4VWPOup1FtckgiaGXIcyWTkULqMYNHas2iK98OHeojw+0FYPF/buQnLX0q7V/hLC/aSRbLuVPua5wddRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726042597; c=relaxed/simple;
	bh=5PVC8MmTUbpKF6nkyD+CD0/8TD1nkFetaGVQMs+C2rU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jMfj1rHZw9l4CCHZRtHdU12BBDP8TjNYHwIebibTGu8KoNW5TQTGEUbAFhM55vvUwkInBGbs1x9kSMzLCreKoVqp5fdIwkLdECSQSE8tjvz8tXBTaZZ+GMwI/AezI2BVcBeT26Rk3V7KaH7f9XdBVQIBzocSRxpmCvw2XTsjoAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KSW5Ah9O; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48B8GBVe118244;
	Wed, 11 Sep 2024 03:16:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726042571;
	bh=o7A5D20LM93+6zrhzEVAjPpi9zIBnLznhgTvwwbRzVY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=KSW5Ah9OqlgiYRk/VKiutzfMfWm2H4Lj/6ZGDGDYQJIVWPWxBqHVDQnjrNaT1bPKf
	 XDyo1oPIk/zUyK8F+ZCVDBeZioxaTsDrtNKcTWuxI3kDMpkt0PwSEXpMrsGIVqOVWS
	 Z4EBdH4m9Ej+3MTEB+5QtryRWPK0k7XCZXjGjeSI=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48B8GBZX092161;
	Wed, 11 Sep 2024 03:16:11 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 11
 Sep 2024 03:16:11 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 11 Sep 2024 03:16:11 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48B8GBEJ066362;
	Wed, 11 Sep 2024 03:16:11 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 48B8GAPq032135;
	Wed, 11 Sep 2024 03:16:11 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: <robh@kernel.org>, <jan.kiszka@siemens.com>, <dan.carpenter@linaro.org>,
        <r-gunasekaran@ti.com>, <saikrishnag@marvell.com>, <andrew@lunn.ch>,
        <javier.carrasco.cruz@gmail.com>, <jacob.e.keller@intel.com>,
        <diogo.ivo@siemens.com>, <horms@kernel.org>,
        <richardcochran@gmail.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v6 3/5] net: ti: icssg-prueth: Add support for HSR frame forward offload
Date: Wed, 11 Sep 2024 13:46:01 +0530
Message-ID: <20240911081603.2521729-4-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911081603.2521729-1-danishanwar@ti.com>
References: <20240911081603.2521729-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add support for offloading HSR port-to-port frame forward to hardware.
When the slave interfaces are added to the HSR interface, the PRU cores
will be stopped and ICSSG HSR firmwares will be loaded to them.

Similarly, when HSR interface is deleted, the PRU cores will be
restarted and the last used firmwares will be reloaded. PRUeth
interfaces will be back to the last used mode.

This commit also renames some APIs that are common between switch and
hsr mode with '_fw_offload' suffix.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 .../net/ethernet/ti/icssg/icssg_classifier.c  |   1 +
 drivers/net/ethernet/ti/icssg/icssg_config.c  |  18 +--
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 106 +++++++++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   6 +
 4 files changed, 119 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_classifier.c b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
index 9ec504d976d6..833ca86d0b71 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_classifier.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
@@ -290,6 +290,7 @@ void icssg_class_set_host_mac_addr(struct regmap *miig_rt, const u8 *mac)
 		     mac[2] << 16 | mac[3] << 24));
 	regmap_write(miig_rt, MAC_INTERFACE_1, (u32)(mac[4] | mac[5] << 8));
 }
+EXPORT_SYMBOL_GPL(icssg_class_set_host_mac_addr);
 
 void icssg_class_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac)
 {
diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
index dae52a83a378..7b2e6c192ff3 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
@@ -107,7 +107,7 @@ static const struct map hwq_map[2][ICSSG_NUM_OTHER_QUEUES] = {
 	},
 };
 
-static void icssg_config_mii_init_switch(struct prueth_emac *emac)
+static void icssg_config_mii_init_fw_offload(struct prueth_emac *emac)
 {
 	struct prueth *prueth = emac->prueth;
 	int mii = prueth_emac_slice(emac);
@@ -278,7 +278,7 @@ static int emac_r30_is_done(struct prueth_emac *emac)
 	return 1;
 }
 
-static int prueth_switch_buffer_setup(struct prueth_emac *emac)
+static int prueth_fw_offload_buffer_setup(struct prueth_emac *emac)
 {
 	struct icssg_buffer_pool_cfg __iomem *bpool_cfg;
 	struct icssg_rxq_ctx __iomem *rxq_ctx;
@@ -424,7 +424,7 @@ static void icssg_init_emac_mode(struct prueth *prueth)
 	icssg_class_set_host_mac_addr(prueth->miig_rt, mac);
 }
 
-static void icssg_init_switch_mode(struct prueth *prueth)
+static void icssg_init_fw_offload_mode(struct prueth *prueth)
 {
 	u32 addr = prueth->shram.pa + EMAC_ICSSG_SWITCH_DEFAULT_VLAN_TABLE_OFFSET;
 	int i;
@@ -455,8 +455,8 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
 	struct icssg_flow_cfg __iomem *flow_cfg;
 	int ret;
 
-	if (prueth->is_switch_mode)
-		icssg_init_switch_mode(prueth);
+	if (prueth->is_switch_mode || prueth->is_hsr_offload_mode)
+		icssg_init_fw_offload_mode(prueth);
 	else
 		icssg_init_emac_mode(prueth);
 
@@ -472,8 +472,8 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
 	regmap_update_bits(prueth->miig_rt, ICSSG_CFG_OFFSET,
 			   ICSSG_CFG_DEFAULT, ICSSG_CFG_DEFAULT);
 	icssg_miig_set_interface_mode(prueth->miig_rt, slice, emac->phy_if);
-	if (prueth->is_switch_mode)
-		icssg_config_mii_init_switch(emac);
+	if (prueth->is_switch_mode || prueth->is_hsr_offload_mode)
+		icssg_config_mii_init_fw_offload(emac);
 	else
 		icssg_config_mii_init(emac);
 	icssg_config_ipg(emac);
@@ -498,8 +498,8 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
 	writeb(0, config + SPL_PKT_DEFAULT_PRIORITY);
 	writeb(0, config + QUEUE_NUM_UNTAGGED);
 
-	if (prueth->is_switch_mode)
-		ret = prueth_switch_buffer_setup(emac);
+	if (prueth->is_switch_mode || prueth->is_hsr_offload_mode)
+		ret = prueth_fw_offload_buffer_setup(emac);
 	else
 		ret = prueth_emac_buffer_setup(emac);
 	if (ret)
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 5343d8754edd..b38a4a6072c4 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -13,6 +13,7 @@
 #include <linux/dma/ti-cppi5.h>
 #include <linux/etherdevice.h>
 #include <linux/genalloc.h>
+#include <linux/if_hsr.h>
 #include <linux/if_vlan.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -40,6 +41,8 @@
 #define DEFAULT_PORT_MASK	1
 #define DEFAULT_UNTAG_MASK	1
 
+#define NETIF_PRUETH_HSR_OFFLOAD_FEATURES	NETIF_F_HW_HSR_FWD
+
 /* CTRLMMR_ICSSG_RGMII_CTRL register bits */
 #define ICSSG_CTRL_RGMII_ID_MODE                BIT(24)
 
@@ -118,6 +121,19 @@ static irqreturn_t prueth_tx_ts_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static struct icssg_firmwares icssg_hsr_firmwares[] = {
+	{
+		.pru = "ti-pruss/am65x-sr2-pru0-pruhsr-fw.elf",
+		.rtu = "ti-pruss/am65x-sr2-rtu0-pruhsr-fw.elf",
+		.txpru = "ti-pruss/am65x-sr2-txpru0-pruhsr-fw.elf",
+	},
+	{
+		.pru = "ti-pruss/am65x-sr2-pru1-pruhsr-fw.elf",
+		.rtu = "ti-pruss/am65x-sr2-rtu1-pruhsr-fw.elf",
+		.txpru = "ti-pruss/am65x-sr2-txpru1-pruhsr-fw.elf",
+	}
+};
+
 static struct icssg_firmwares icssg_switch_firmwares[] = {
 	{
 		.pru = "ti-pruss/am65x-sr2-pru0-prusw-fw.elf",
@@ -152,6 +168,8 @@ static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
 
 	if (prueth->is_switch_mode)
 		firmwares = icssg_switch_firmwares;
+	else if (prueth->is_hsr_offload_mode)
+		firmwares = icssg_hsr_firmwares;
 	else
 		firmwares = icssg_emac_firmwares;
 
@@ -865,6 +883,7 @@ static int prueth_netdev_init(struct prueth *prueth,
 	ndev->ethtool_ops = &icssg_ethtool_ops;
 	ndev->hw_features = NETIF_F_SG;
 	ndev->features = ndev->hw_features;
+	ndev->hw_features |= NETIF_PRUETH_HSR_OFFLOAD_FEATURES;
 
 	netif_napi_add(ndev, &emac->napi_rx, icssg_napi_rx_poll);
 	hrtimer_init(&emac->rx_hrtimer, CLOCK_MONOTONIC,
@@ -953,7 +972,7 @@ static void prueth_emac_restart(struct prueth *prueth)
 	netif_device_attach(emac1->ndev);
 }
 
-static void icssg_enable_switch_mode(struct prueth *prueth)
+static void icssg_change_mode(struct prueth *prueth)
 {
 	struct prueth_emac *emac;
 	int mac;
@@ -973,8 +992,13 @@ static void icssg_enable_switch_mode(struct prueth *prueth)
 					  BIT(emac->port_id) | DEFAULT_PORT_MASK,
 					  BIT(emac->port_id) | DEFAULT_UNTAG_MASK,
 					  true);
+			if (prueth->is_hsr_offload_mode)
+				icssg_vtbl_modify(emac, DEFAULT_VID,
+						  DEFAULT_PORT_MASK,
+						  DEFAULT_UNTAG_MASK, true);
 			icssg_set_pvid(prueth, emac->port_vlan, emac->port_id);
-			icssg_set_port_state(emac, ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE);
+			if (prueth->is_switch_mode)
+				icssg_set_port_state(emac, ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE);
 		}
 	}
 }
@@ -1012,7 +1036,7 @@ static int prueth_netdevice_port_link(struct net_device *ndev,
 			prueth->is_switch_mode = true;
 			prueth->default_vlan = 1;
 			emac->port_vlan = prueth->default_vlan;
-			icssg_enable_switch_mode(prueth);
+			icssg_change_mode(prueth);
 		}
 	}
 
@@ -1040,6 +1064,61 @@ static void prueth_netdevice_port_unlink(struct net_device *ndev)
 		prueth->hw_bridge_dev = NULL;
 }
 
+static int prueth_hsr_port_link(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
+	struct prueth_emac *emac0;
+	struct prueth_emac *emac1;
+
+	emac0 = prueth->emac[PRUETH_MAC0];
+	emac1 = prueth->emac[PRUETH_MAC1];
+
+	if (prueth->is_switch_mode)
+		return -EOPNOTSUPP;
+
+	prueth->hsr_members |= BIT(emac->port_id);
+	if (!prueth->is_hsr_offload_mode) {
+		if (prueth->hsr_members & BIT(PRUETH_PORT_MII0) &&
+		    prueth->hsr_members & BIT(PRUETH_PORT_MII1)) {
+			if (!(emac0->ndev->features &
+			      NETIF_PRUETH_HSR_OFFLOAD_FEATURES) &&
+			    !(emac1->ndev->features &
+			      NETIF_PRUETH_HSR_OFFLOAD_FEATURES))
+				return -EOPNOTSUPP;
+			prueth->is_hsr_offload_mode = true;
+			prueth->default_vlan = 1;
+			emac0->port_vlan = prueth->default_vlan;
+			emac1->port_vlan = prueth->default_vlan;
+			icssg_change_mode(prueth);
+			netdev_dbg(ndev, "Enabling HSR offload mode\n");
+		}
+	}
+
+	return 0;
+}
+
+static void prueth_hsr_port_unlink(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
+	struct prueth_emac *emac0;
+	struct prueth_emac *emac1;
+
+	emac0 = prueth->emac[PRUETH_MAC0];
+	emac1 = prueth->emac[PRUETH_MAC1];
+
+	prueth->hsr_members &= ~BIT(emac->port_id);
+	if (prueth->is_hsr_offload_mode) {
+		prueth->is_hsr_offload_mode = false;
+		emac0->port_vlan = 0;
+		emac1->port_vlan = 0;
+		prueth->hsr_dev = NULL;
+		prueth_emac_restart(prueth);
+		netdev_dbg(ndev, "Disabling HSR Offload mode\n");
+	}
+}
+
 /* netdev notifier */
 static int prueth_netdevice_event(struct notifier_block *unused,
 				  unsigned long event, void *ptr)
@@ -1047,6 +1126,8 @@ static int prueth_netdevice_event(struct notifier_block *unused,
 	struct netlink_ext_ack *extack = netdev_notifier_info_to_extack(ptr);
 	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
 	struct netdev_notifier_changeupper_info *info;
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
 	int ret = NOTIFY_DONE;
 
 	if (ndev->netdev_ops != &emac_netdev_ops)
@@ -1056,6 +1137,25 @@ static int prueth_netdevice_event(struct notifier_block *unused,
 	case NETDEV_CHANGEUPPER:
 		info = ptr;
 
+		if ((ndev->features & NETIF_PRUETH_HSR_OFFLOAD_FEATURES) &&
+		    is_hsr_master(info->upper_dev)) {
+			if (info->linking) {
+				if (!prueth->hsr_dev) {
+					prueth->hsr_dev = info->upper_dev;
+					icssg_class_set_host_mac_addr(prueth->miig_rt,
+								      prueth->hsr_dev->dev_addr);
+				} else {
+					if (prueth->hsr_dev != info->upper_dev) {
+						netdev_dbg(ndev, "Both interfaces must be linked to same upper device\n");
+						return -EOPNOTSUPP;
+					}
+				}
+				prueth_hsr_port_link(ndev);
+			} else {
+				prueth_hsr_port_unlink(ndev);
+			}
+		}
+
 		if (netif_is_bridge_master(info->upper_dev)) {
 			if (info->linking)
 				ret = prueth_netdevice_port_link(ndev, info->upper_dev, extack);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 786bd1ba34ab..a4b025fae797 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -243,11 +243,14 @@ struct icssg_firmwares {
  * @iep1: pointer to IEP1 device
  * @vlan_tbl: VLAN-FID table pointer
  * @hw_bridge_dev: pointer to HW bridge net device
+ * @hsr_dev: pointer to the HSR net device
  * @br_members: bitmask of bridge member ports
+ * @hsr_members: bitmask of hsr member ports
  * @prueth_netdevice_nb: netdevice notifier block
  * @prueth_switchdev_nb: switchdev notifier block
  * @prueth_switchdev_bl_nb: switchdev blocking notifier block
  * @is_switch_mode: flag to indicate if device is in Switch mode
+ * @is_hsr_offload_mode: flag to indicate if device is in hsr offload mode
  * @is_switchmode_supported: indicates platform support for switch mode
  * @switch_id: ID for mapping switch ports to bridge
  * @default_vlan: Default VLAN for host
@@ -279,11 +282,14 @@ struct prueth {
 	struct prueth_vlan_tbl *vlan_tbl;
 
 	struct net_device *hw_bridge_dev;
+	struct net_device *hsr_dev;
 	u8 br_members;
+	u8 hsr_members;
 	struct notifier_block prueth_netdevice_nb;
 	struct notifier_block prueth_switchdev_nb;
 	struct notifier_block prueth_switchdev_bl_nb;
 	bool is_switch_mode;
+	bool is_hsr_offload_mode;
 	bool is_switchmode_supported;
 	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
 	int default_vlan;
-- 
2.34.1


