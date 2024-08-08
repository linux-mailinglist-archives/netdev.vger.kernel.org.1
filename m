Return-Path: <netdev+bounces-116790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4081994BBF5
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C63282B64
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7C718C324;
	Thu,  8 Aug 2024 11:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vnuxGi7V"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4453518B494;
	Thu,  8 Aug 2024 11:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723115308; cv=none; b=AcqYmuNepNXsh32dDKu/0JYXPkNKQ78rCOeN0IGJep4ACpDXIlYvhPSrCsjREiQYQ2c9YPgMQoxpQ/F5a1k7c7YZ7WkE3WucDvdMq5i86XR1QtN7GMOj1MElr62l/7hwu+W0yhDhxlCYs5W4ummurkc9ZWyoe+6fqeFkPf+d3Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723115308; c=relaxed/simple;
	bh=l2RE9yjlnSNBGafc9dJbO4yqBwVu1gDdfiQdfdrFXK4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BBbT6xDbEE6U1qq8UwQKFOjyU+n1Ji+foKkEVzJOuIAcLdTphBK+8nwrUaaItL23B49lkW3IP2e65QeVxPhRXCan22mao8KYG626WxlURmjgfrH753DonbDJqoDJsFfJj0oeH9h84AQ25yirKhPuMTPjuhN122GezU5CBG8arxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vnuxGi7V; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 478B87jQ048323;
	Thu, 8 Aug 2024 06:08:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723115287;
	bh=IymuzmF78e13s5t4zVBtMAkCr+MdrYCvYGS43tIShCA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=vnuxGi7VMREXGFxl9ixA3VnQP+V99KXNucsUdODOISQbWsXhhTpxfSiEVn2F2hEec
	 Y65uIpovaTKcc+4k52X/wmJP1NGjvjSGJjulrRR7J2ozG16ISQrpqxt0dUPrkcc3SV
	 hkRB4otwI3a+mph5oFqdM62zJcOgmYfHMMhZ+/ng=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 478B87Cp017894
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Aug 2024 06:08:07 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Aug 2024 06:08:07 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Aug 2024 06:08:07 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 478B87Qq087561;
	Thu, 8 Aug 2024 06:08:07 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 478B86Jd011995;
	Thu, 8 Aug 2024 06:08:06 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>, Vignesh Raghavendra
	<vigneshr@ti.com>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Diogo
 Ivo <diogo.ivo@siemens.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Simon
 Horman <horms@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo
 Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>
Subject: [PATCH net-next 2/6] net: ti: icssg-prueth: Add support for HSR frame forward offload
Date: Thu, 8 Aug 2024 16:37:56 +0530
Message-ID: <20240808110800.1281716-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808110800.1281716-1-danishanwar@ti.com>
References: <20240808110800.1281716-1-danishanwar@ti.com>
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

Similarly, when HSR interface is deleted, the PRU cores will be stopped
and dual EMAC firmware will be loaded to them.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 .../net/ethernet/ti/icssg/icssg_classifier.c  |   1 +
 drivers/net/ethernet/ti/icssg/icssg_config.c  |   6 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 122 +++++++++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   4 +
 4 files changed, 127 insertions(+), 6 deletions(-)

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
index dae52a83a378..2f485318c940 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
@@ -455,7 +455,7 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
 	struct icssg_flow_cfg __iomem *flow_cfg;
 	int ret;
 
-	if (prueth->is_switch_mode)
+	if (prueth->is_switch_mode || prueth->is_hsr_offload_mode)
 		icssg_init_switch_mode(prueth);
 	else
 		icssg_init_emac_mode(prueth);
@@ -472,7 +472,7 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
 	regmap_update_bits(prueth->miig_rt, ICSSG_CFG_OFFSET,
 			   ICSSG_CFG_DEFAULT, ICSSG_CFG_DEFAULT);
 	icssg_miig_set_interface_mode(prueth->miig_rt, slice, emac->phy_if);
-	if (prueth->is_switch_mode)
+	if (prueth->is_switch_mode || prueth->is_hsr_offload_mode)
 		icssg_config_mii_init_switch(emac);
 	else
 		icssg_config_mii_init(emac);
@@ -498,7 +498,7 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
 	writeb(0, config + SPL_PKT_DEFAULT_PRIORITY);
 	writeb(0, config + QUEUE_NUM_UNTAGGED);
 
-	if (prueth->is_switch_mode)
+	if (prueth->is_switch_mode || prueth->is_hsr_offload_mode)
 		ret = prueth_switch_buffer_setup(emac);
 	else
 		ret = prueth_emac_buffer_setup(emac);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index c61423118319..675a01658d17 100644
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
 
+#define NETIF_PRUETH_HSR_OFFLOAD	NETIF_F_HW_HSR_FWD
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
 
@@ -725,6 +743,19 @@ static void emac_ndo_set_rx_mode(struct net_device *ndev)
 	queue_work(emac->cmd_wq, &emac->rx_mode_work);
 }
 
+static int emac_ndo_set_features(struct net_device *ndev,
+				 netdev_features_t features)
+{
+	netdev_features_t hsr_feature_present = ndev->features & NETIF_PRUETH_HSR_OFFLOAD;
+	netdev_features_t hsr_feature_wanted = features & NETIF_PRUETH_HSR_OFFLOAD;
+	bool hsr_change_request = ((hsr_feature_wanted ^ hsr_feature_present) != 0);
+
+	if (hsr_change_request)
+		ndev->features = features;
+
+	return 0;
+}
+
 static const struct net_device_ops emac_netdev_ops = {
 	.ndo_open = emac_ndo_open,
 	.ndo_stop = emac_ndo_stop,
@@ -736,6 +767,7 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_eth_ioctl = icssg_ndo_ioctl,
 	.ndo_get_stats64 = icssg_ndo_get_stats64,
 	.ndo_get_phys_port_name = icssg_ndo_get_phys_port_name,
+	.ndo_set_features = emac_ndo_set_features,
 };
 
 static int prueth_netdev_init(struct prueth *prueth,
@@ -863,6 +895,7 @@ static int prueth_netdev_init(struct prueth *prueth,
 	ndev->ethtool_ops = &icssg_ethtool_ops;
 	ndev->hw_features = NETIF_F_SG;
 	ndev->features = ndev->hw_features;
+	ndev->hw_features |= NETIF_F_HW_HSR_FWD;
 
 	netif_napi_add(ndev, &emac->napi_rx, icssg_napi_rx_poll);
 	hrtimer_init(&emac->rx_hrtimer, CLOCK_MONOTONIC,
@@ -951,7 +984,7 @@ static void prueth_emac_restart(struct prueth *prueth)
 	netif_device_attach(emac1->ndev);
 }
 
-static void icssg_enable_switch_mode(struct prueth *prueth)
+static void icssg_change_mode(struct prueth *prueth)
 {
 	struct prueth_emac *emac;
 	int mac;
@@ -971,8 +1004,12 @@ static void icssg_enable_switch_mode(struct prueth *prueth)
 					  BIT(emac->port_id) | DEFAULT_PORT_MASK,
 					  BIT(emac->port_id) | DEFAULT_UNTAG_MASK,
 					  true);
+			if (prueth->is_hsr_offload_mode)
+				icssg_vtbl_modify(emac, DEFAULT_VID, DEFAULT_PORT_MASK,
+						  DEFAULT_UNTAG_MASK, true);
 			icssg_set_pvid(prueth, emac->port_vlan, emac->port_id);
-			icssg_set_port_state(emac, ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE);
+			if (prueth->is_switch_mode)
+				icssg_set_port_state(emac, ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE);
 		}
 	}
 }
@@ -1010,7 +1047,7 @@ static int prueth_netdevice_port_link(struct net_device *ndev,
 			prueth->is_switch_mode = true;
 			prueth->default_vlan = 1;
 			emac->port_vlan = prueth->default_vlan;
-			icssg_enable_switch_mode(prueth);
+			icssg_change_mode(prueth);
 		}
 	}
 
@@ -1038,6 +1075,63 @@ static void prueth_netdevice_port_unlink(struct net_device *ndev)
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
+	if (prueth->is_switch_mode) {
+		dev_err(prueth->dev, "Switching from bridge to HSR mode not allowed\n");
+		return -EINVAL;
+	}
+
+	prueth->hsr_members |= BIT(emac->port_id);
+	if (!prueth->is_switch_mode && !prueth->is_hsr_offload_mode) {
+		if (prueth->hsr_members & BIT(PRUETH_PORT_MII0) &&
+		    prueth->hsr_members & BIT(PRUETH_PORT_MII1)) {
+			if (!(emac0->ndev->features & NETIF_PRUETH_HSR_OFFLOAD) &&
+			    !(emac1->ndev->features & NETIF_PRUETH_HSR_OFFLOAD)) {
+				dev_err(prueth->dev, "Enable HSR offload on both interfaces\n");
+				return -EINVAL;
+			}
+			prueth->is_hsr_offload_mode = true;
+			prueth->default_vlan = 1;
+			emac0->port_vlan = prueth->default_vlan;
+			emac1->port_vlan = prueth->default_vlan;
+			icssg_change_mode(prueth);
+			dev_err(prueth->dev, "Enabling HSR offload mode\n");
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
+		dev_info(prueth->dev, "Enabling Dual EMAC mode\n");
+	}
+}
+
 /* netdev notifier */
 static int prueth_netdevice_event(struct notifier_block *unused,
 				  unsigned long event, void *ptr)
@@ -1045,6 +1139,8 @@ static int prueth_netdevice_event(struct notifier_block *unused,
 	struct netlink_ext_ack *extack = netdev_notifier_info_to_extack(ptr);
 	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
 	struct netdev_notifier_changeupper_info *info;
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
 	int ret = NOTIFY_DONE;
 
 	if (ndev->netdev_ops != &emac_netdev_ops)
@@ -1054,6 +1150,26 @@ static int prueth_netdevice_event(struct notifier_block *unused,
 	case NETDEV_CHANGEUPPER:
 		info = ptr;
 
+		if ((ndev->features & NETIF_PRUETH_HSR_OFFLOAD) &&
+		    is_hsr_master(info->upper_dev)) {
+			if (info->linking) {
+				if (!prueth->hsr_dev) {
+					prueth->hsr_dev = info->upper_dev;
+
+					icssg_class_set_host_mac_addr(prueth->miig_rt,
+								      prueth->hsr_dev->dev_addr);
+				} else {
+					if (prueth->hsr_dev != info->upper_dev) {
+						dev_err(prueth->dev, "Both interfaces must be linked to same upper device\n");
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
index f678d656a3ed..40bc3912b6ae 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -239,6 +239,7 @@ struct icssg_firmwares {
  * @iep1: pointer to IEP1 device
  * @vlan_tbl: VLAN-FID table pointer
  * @hw_bridge_dev: pointer to HW bridge net device
+ * @hsr_dev: pointer to the HSR net device
  * @br_members: bitmask of bridge member ports
  * @prueth_netdevice_nb: netdevice notifier block
  * @prueth_switchdev_nb: switchdev notifier block
@@ -274,11 +275,14 @@ struct prueth {
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


