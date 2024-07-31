Return-Path: <netdev+bounces-114485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6509A942B2D
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82481F21DD3
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 09:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90221AD9C1;
	Wed, 31 Jul 2024 09:48:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099991AAE22;
	Wed, 31 Jul 2024 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722419308; cv=none; b=gVSUoDGYfG6hlqqKd7CreacChIhpE88podOJgM0FH5/4Z+B5eK2scoa0fhu1fR8Yd8LYUO0MmFvDqmjeYvz4cD9zXAn2s5dBTakC/cV9cfJOcAkroNIrK5T0qHRo/Y2eokx0KruNQ+sJ0YQcsyUJ3Q3TT0KPDyE/0ZOAG/6XMgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722419308; c=relaxed/simple;
	bh=B8udmSSgxCTm7uXMbq9+2P2ZhRDjJ04ETjqGbVNNFkE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=loaPRHEiHspcsQsRHvHCVKzIQxgqgQ+iVBZMZSIP17OWUllVHjDVJIf/jmuy472md1mzdVHRW2PxN7lLa8O5mJN/6NzTpvtNpvocrH9ujWFV2PVOoURo14XEYaZeO/ZXonTLJrpowOlsE7zqlwbad39BYFMp7MtHoE42iKw1TMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WYnL00zVCzgYkM;
	Wed, 31 Jul 2024 17:46:32 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 96B5818009B;
	Wed, 31 Jul 2024 17:48:22 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 17:48:21 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH net-next 05/10] net: hibmcge: Implement some .ndo functions
Date: Wed, 31 Jul 2024 17:42:40 +0800
Message-ID: <20240731094245.1967834-6-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240731094245.1967834-1-shaojijie@huawei.com>
References: <20240731094245.1967834-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)

Implement the .ndo_open .ndo_stop .ndo_set_mac_address
and .ndo_change_mtu functions.
And .ndo_validate_addr calls the eth_validate_addr function directly

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |   4 +
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   |  40 +++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |   3 +
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c | 105 ++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |   8 ++
 5 files changed, 160 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index 6a3e647cd27c..22d5ce310a3f 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -30,8 +30,12 @@ enum hbg_dir {
 enum hbg_nic_state {
 	HBG_NIC_STATE_INITED = 0,
 	HBG_NIC_STATE_EVENT_HANDLING,
+	HBG_NIC_STATE_OPEN,
 };
 
+#define hbg_nic_is_open(priv) test_bit(HBG_NIC_STATE_OPEN, &(priv)->state)
+#define hbg_nic_is_inited(priv) test_bit(HBG_NIC_STATE_INITED, &(priv)->state)
+
 enum hbg_hw_event_type {
 	HBG_HW_EVENT_NONE = 0,
 	HBG_HW_EVENT_INIT, /* driver is loading */
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
index d9bed7cc7790..f06c74d59c02 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -71,6 +71,46 @@ int hbg_hw_dev_specs_init(struct hbg_priv *priv)
 	return 0;
 }
 
+void hbg_hw_set_uc_addr(struct hbg_priv *priv, u64 mac_addr)
+{
+	hbg_reg_write64(priv, HBG_REG_STATION_ADDR_LOW_2_ADDR, mac_addr);
+}
+
+static void hbg_hw_set_pcu_max_frame_len(struct hbg_priv *priv,
+					 u16 max_frame_len)
+{
+#define HBG_PCU_FRAME_LEN_PLUS 4
+
+	max_frame_len = max_t(u32, max_frame_len, HBG_DEFAULT_MTU_SIZE);
+
+	/* lower two bits of value must be set to 0. Otherwise, the value is ignored */
+	max_frame_len = round_up(max_frame_len, HBG_PCU_FRAME_LEN_PLUS);
+
+	hbg_reg_write_field(priv, HBG_REG_MAX_FRAME_LEN_ADDR,
+			    HBG_REG_MAX_FRAME_LEN_M, max_frame_len);
+}
+
+static void hbg_hw_set_mac_max_frame_len(struct hbg_priv *priv,
+					 u16 max_frame_size)
+{
+	hbg_reg_write_field(priv, HBG_REG_MAX_FRAME_SIZE_ADDR,
+			    HBG_REG_MAX_FRAME_LEN_M, max_frame_size);
+}
+
+void hbg_hw_set_mtu(struct hbg_priv *priv, u16 mtu)
+{
+	hbg_hw_set_pcu_max_frame_len(priv, mtu);
+	hbg_hw_set_mac_max_frame_len(priv, mtu);
+}
+
+void hbg_hw_mac_enable(struct hbg_priv *priv, u32 enable)
+{
+	hbg_reg_write_bit(priv, HBG_REG_PORT_ENABLE_ADDR,
+			  HBG_REG_PORT_ENABLE_TX_B, enable);
+	hbg_reg_write_bit(priv, HBG_REG_PORT_ENABLE_ADDR,
+			  HBG_REG_PORT_ENABLE_RX_B, enable);
+}
+
 void hbg_hw_get_err_intr_status(struct hbg_priv *priv, struct hbg_intr_status *status)
 {
 	status->bits = hbg_reg_read(priv, HBG_REG_CF_INTRPT_STAT_ADDR);
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
index e2a08dc5d883..556f479bc094 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
@@ -57,6 +57,8 @@ static inline void hbg_reg_write64(struct hbg_priv *priv, u32 reg_addr,
 
 int hbg_hw_event_notify(struct hbg_priv *priv, enum hbg_hw_event_type event_type);
 int hbg_hw_dev_specs_init(struct hbg_priv *priv);
+void hbg_hw_mac_enable(struct hbg_priv *priv, u32 enable);
+void hbg_hw_set_uc_addr(struct hbg_priv *priv, u64 mac_addr);
 void hbg_hw_get_err_intr_status(struct hbg_priv *priv, struct hbg_intr_status *status);
 void hbg_hw_get_err_intr_mask(struct hbg_priv *priv, struct hbg_intr_mask *msk);
 void hbg_hw_set_err_intr_mask(struct hbg_priv *priv, const struct hbg_intr_mask *msk);
@@ -67,6 +69,7 @@ void hbg_hw_set_txrx_intr_clear(struct hbg_priv *priv, enum hbg_dir dir);
 void hbg_hw_get_txrx_intr_status(struct hbg_priv *priv, struct hbg_intr_status *status);
 int hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex);
 int hbg_hw_sgmii_autoneg(struct hbg_priv *priv);
+void hbg_hw_set_mtu(struct hbg_priv *priv, u16 mtu);
 int hbg_hw_init(struct hbg_priv *pri);
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 059ea155572f..0184ea5d563e 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2024 Hisilicon Limited.
 
 #include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include "hbg_common.h"
@@ -10,6 +11,105 @@
 #include "hbg_main.h"
 #include "hbg_mdio.h"
 
+static void hbg_enable_intr(struct hbg_priv *priv, bool enabled)
+{
+	u32 i;
+
+	for (i = 0; i < priv->vectors.info_array_len; i++)
+		hbg_irq_enable(priv, priv->vectors.info_array[i].mask,
+			       enabled);
+
+	for (i = 0; i < priv->vectors.irq_count; i++) {
+		if (enabled)
+			enable_irq(priv->vectors.irqs[i].id);
+		else
+			disable_irq(priv->vectors.irqs[i].id);
+	}
+}
+
+static int hbg_net_open(struct net_device *dev)
+{
+	struct hbg_priv *priv = netdev_priv(dev);
+
+	if (test_and_set_bit(HBG_NIC_STATE_OPEN, &priv->state))
+		return 0;
+
+	netif_carrier_off(dev);
+	hbg_enable_intr(priv, true);
+	hbg_hw_mac_enable(priv, HBG_STATUS_ENABLE);
+	netif_start_queue(dev);
+	hbg_phy_start(priv);
+	return 0;
+}
+
+static int hbg_net_stop(struct net_device *dev)
+{
+	struct hbg_priv *priv = netdev_priv(dev);
+
+	if (!hbg_nic_is_open(priv))
+		return 0;
+
+	clear_bit(HBG_NIC_STATE_OPEN, &priv->state);
+	netif_carrier_off(dev);
+	netif_stop_queue(dev);
+	hbg_hw_mac_enable(priv, HBG_STATUS_DISABLE);
+	hbg_enable_intr(priv, false);
+	hbg_phy_stop(priv);
+	return 0;
+}
+
+static int hbg_net_set_mac_address(struct net_device *dev, void *addr)
+{
+	struct hbg_priv *priv = netdev_priv(dev);
+	u8 *mac_addr;
+
+	mac_addr = ((struct sockaddr *)addr)->sa_data;
+	if (ether_addr_equal(dev->dev_addr, mac_addr))
+		return 0;
+
+	if (!is_valid_ether_addr(mac_addr))
+		return -EADDRNOTAVAIL;
+
+	hbg_hw_set_uc_addr(priv, ether_addr_to_u64(mac_addr));
+	dev_addr_set(dev, mac_addr);
+	return 0;
+}
+
+static int hbg_net_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct hbg_priv *priv = netdev_priv(dev);
+	bool is_opened = hbg_nic_is_open(priv);
+	u32 frame_len;
+
+	if (new_mtu == dev->mtu)
+		return 0;
+
+	if (new_mtu < priv->dev_specs.min_mtu || new_mtu > priv->dev_specs.max_mtu)
+		return -EINVAL;
+
+	hbg_net_stop(dev);
+
+	frame_len = new_mtu + VLAN_HLEN * priv->dev_specs.vlan_layers +
+		    ETH_HLEN + ETH_FCS_LEN;
+	hbg_hw_set_mtu(priv, frame_len);
+
+	dev_info(&priv->pdev->dev,
+		 "change mtu from %u to %u\n", dev->mtu, new_mtu);
+	WRITE_ONCE(dev->mtu, new_mtu);
+
+	if (is_opened)
+		hbg_net_open(dev);
+	return 0;
+}
+
+static const struct net_device_ops hbg_netdev_ops = {
+	.ndo_open		= hbg_net_open,
+	.ndo_stop		= hbg_net_stop,
+	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_set_mac_address	= hbg_net_set_mac_address,
+	.ndo_change_mtu		= hbg_net_change_mtu,
+};
+
 static const u32 hbg_mode_ability[] = {
 	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
 	ETHTOOL_LINK_MODE_100baseT_Full_BIT,
@@ -95,6 +195,7 @@ static int hbg_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	priv = netdev_priv(netdev);
 	priv->netdev = netdev;
 	priv->pdev = pdev;
+	netdev->netdev_ops = &hbg_netdev_ops;
 
 	ret = hbg_pci_init(pdev);
 	if (ret)
@@ -104,6 +205,10 @@ static int hbg_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		return ret;
 
+	netdev->max_mtu = priv->dev_specs.max_mtu;
+	netdev->min_mtu = priv->dev_specs.min_mtu;
+	hbg_net_change_mtu(netdev, HBG_DEFAULT_MTU_SIZE);
+	hbg_net_set_mac_address(priv->netdev, &priv->dev_specs.mac_addr);
 	ret = devm_register_netdev(&pdev->dev, netdev);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index b422fa990270..86f1157a2af2 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -29,7 +29,9 @@
 /* GMAC */
 #define HBG_REG_SGMII_BASE			0x10000
 #define HBG_REG_DUPLEX_TYPE_ADDR		(HBG_REG_SGMII_BASE + 0x0008)
+#define HBG_REG_MAX_FRAME_SIZE_ADDR		(HBG_REG_SGMII_BASE + 0x003C)
 #define HBG_REG_PORT_MODE_ADDR			(HBG_REG_SGMII_BASE + 0x0040)
+#define HBG_REG_PORT_ENABLE_ADDR		(HBG_REG_SGMII_BASE + 0x0044)
 #define HBG_REG_AN_NEG_STATE_ADDR		(HBG_REG_SGMII_BASE + 0x0058)
 #define HBG_REG_TX_LOCAL_PAGE_ADDR		(HBG_REG_SGMII_BASE + 0x005C)
 #define HBG_REG_TRANSMIT_CONTROL_ADDR		(HBG_REG_SGMII_BASE + 0x0060)
@@ -38,11 +40,14 @@
 #define HBG_REG_16_BIT_CNTR_ADDR		(HBG_REG_SGMII_BASE + 0x01CC)
 #define HBG_REG_LD_LINK_COUNTER_ADDR		(HBG_REG_SGMII_BASE + 0x01D0)
 #define HBG_REG_RECV_CONTROL_ADDR		(HBG_REG_SGMII_BASE + 0x01E0)
+#define HBG_REG_STATION_ADDR_LOW_2_ADDR		(HBG_REG_SGMII_BASE + 0x0210)
+#define HBG_REG_STATION_ADDR_HIGH_2_ADDR	(HBG_REG_SGMII_BASE + 0x0214)
 
 /* PCU */
 #define HBG_REG_CF_INTRPT_MSK_ADDR		(HBG_REG_SGMII_BASE + 0x042C)
 #define HBG_REG_CF_INTRPT_STAT_ADDR		(HBG_REG_SGMII_BASE + 0x0434)
 #define HBG_REG_CF_INTRPT_CLR_ADDR		(HBG_REG_SGMII_BASE + 0x0438)
+#define HBG_REG_MAX_FRAME_LEN_ADDR		(HBG_REG_SGMII_BASE + 0x0444)
 #define HBG_REG_RX_BUF_SIZE_ADDR		(HBG_REG_SGMII_BASE + 0x04E4)
 #define HBG_REG_BUS_CTRL_ADDR			(HBG_REG_SGMII_BASE + 0x04E8)
 #define HBG_REG_RX_CTRL_ADDR			(HBG_REG_SGMII_BASE + 0x04F0)
@@ -57,12 +62,15 @@
 /* mask */
 #define HBG_REG_PORT_MODE_M			GENMASK(3, 0)
 #define HBG_REG_MODE_CHANGE_EN_B		BIT(0)
+#define HBG_REG_MAX_FRAME_LEN_M			GENMASK(15, 0)
 #define HBG_REG_RX_BUF_SIZE_M			GENMASK(15, 0)
 #define HBG_REG_BUS_CTRL_ENDIAN_M		GENMASK(2, 1)
 #define HBG_REG_DUPLEX_B			BIT(0)
 #define HBG_REG_CF_CRC_STRIP_B			BIT(1)
 #define HBG_REG_MDIO_WDATA_M			GENMASK(15, 0)
 #define HBG_REG_IND_INTR_MASK_B			BIT(0)
+#define HBG_REG_PORT_ENABLE_RX_B		BIT(1)
+#define HBG_REG_PORT_ENABLE_TX_B		BIT(2)
 
 enum hbg_port_mode {
 	/* 0x0 ~ 0x5 are reserved */
-- 
2.33.0


