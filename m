Return-Path: <netdev+bounces-118066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AA895070E
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2A41C21F24
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F7619DF52;
	Tue, 13 Aug 2024 14:02:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1C2194C73;
	Tue, 13 Aug 2024 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723557764; cv=none; b=N61IfFXgza/P+FTn/bMdEHFfWOYtOw9lgBM+pKHZ5pTqG63CZio3gwVU9PoMsdJ9xiEHRLbBTM6cXCmrBqDdBP41XRD79GzroK9ozkUR8IHS8VfNrjkYQbT5Eb7QFvXCEMZm1rfETgY56vTY5OTgno1C4y78erFZkA2ihbLhB1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723557764; c=relaxed/simple;
	bh=B1bQBU+f0MIunlOo4+lnoMsG1FIMEwl/8iP1k5JlJsk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ex+7J5xy8ep6y08LetSPvYE7gwGEPTXUAbl98Uc0/Cm0jNyS8YTl39jsDs25x8rCclI2Q14BBpKz7RD+tWop0ZQGH++E1qIUylW2T9PI+rBgsjboQea0rHRfE05F8Ys5k1tmsfbY9j8VxOUPUAQqOCsPo3mZG8/xoPBNlccWOFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WjtHw1mmpz1j6Py;
	Tue, 13 Aug 2024 21:57:48 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id E9A2A140337;
	Tue, 13 Aug 2024 22:02:38 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 22:02:38 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <andrew@lunn.ch>,
	<jdamato@fastly.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH V2 net-next 05/11] net: hibmcge: Implement some .ndo functions
Date: Tue, 13 Aug 2024 21:56:34 +0800
Message-ID: <20240813135640.1694993-6-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240813135640.1694993-1-shaojijie@huawei.com>
References: <20240813135640.1694993-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)

Implement the .ndo_open .ndo_stop .ndo_set_mac_address
and .ndo_change_mtu functions.
And .ndo_validate_addr calls the eth_validate_addr function directly

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  4 +
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   | 40 +++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |  3 +
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c | 88 +++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  9 ++
 5 files changed, 144 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index f95080359f35..14aea265b71e 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -27,8 +27,12 @@ enum hbg_dir {
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
index 170aa57ca790..89a7b8aafbf7 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -69,6 +69,46 @@ int hbg_hw_dev_specs_init(struct hbg_priv *priv)
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
+	hbg_reg_write_field(priv, HBG_REG_PORT_ENABLE_ADDR,
+			    HBG_REG_PORT_ENABLE_TX_B, enable);
+	hbg_reg_write_field(priv, HBG_REG_PORT_ENABLE_ADDR,
+			    HBG_REG_PORT_ENABLE_RX_B, enable);
+}
+
 void hbg_hw_get_err_intr_status(struct hbg_priv *priv, struct hbg_intr_status *status)
 {
 	status->bits = hbg_reg_read(priv, HBG_REG_CF_INTRPT_STAT_ADDR);
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
index 06561c39c688..d481aa2d605c 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
@@ -28,6 +28,8 @@
 
 int hbg_hw_event_notify(struct hbg_priv *priv, enum hbg_hw_event_type event_type);
 int hbg_hw_dev_specs_init(struct hbg_priv *priv);
+void hbg_hw_mac_enable(struct hbg_priv *priv, u32 enable);
+void hbg_hw_set_uc_addr(struct hbg_priv *priv, u64 mac_addr);
 void hbg_hw_get_err_intr_status(struct hbg_priv *priv, struct hbg_intr_status *status);
 void hbg_hw_get_err_intr_mask(struct hbg_priv *priv, struct hbg_intr_mask *msk);
 void hbg_hw_set_err_intr_mask(struct hbg_priv *priv, const struct hbg_intr_mask *msk);
@@ -37,6 +39,7 @@ bool hbg_hw_txrx_intr_is_enabled(struct hbg_priv *priv, enum hbg_dir dir);
 void hbg_hw_set_txrx_intr_clear(struct hbg_priv *priv, enum hbg_dir dir);
 void hbg_hw_get_txrx_intr_status(struct hbg_priv *priv, struct hbg_intr_status *status);
 int hbg_hw_adjust_link(struct hbg_priv *priv, u32 speed, u32 duplex);
+void hbg_hw_set_mtu(struct hbg_priv *priv, u16 mtu);
 int hbg_hw_init(struct hbg_priv *pri);
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index f1663417d01f..d330ec1af711 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2024 Hisilicon Limited.
 
 #include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
 #include <linux/netdevice.h>
 #include <linux/pci.h>
 #include "hbg_common.h"
@@ -17,6 +18,88 @@ static const struct regmap_config hbg_regmap_config = {
 	.fast_io	= true,
 };
 
+static void hbg_all_irq_enable(struct hbg_priv *priv, bool enabled)
+{
+	u32 i;
+
+	for (i = 0; i < priv->vectors.info_array_len; i++)
+		hbg_irq_enable(priv, priv->vectors.info_array[i].mask,
+			       enabled);
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
+	hbg_all_irq_enable(priv, true);
+	hbg_hw_mac_enable(priv, HBG_STATUS_ENABLE);
+	netif_start_queue(dev);
+	hbg_phy_start(priv);
+
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
+	hbg_phy_stop(priv);
+	netif_stop_queue(dev);
+	hbg_hw_mac_enable(priv, HBG_STATUS_DISABLE);
+	hbg_all_irq_enable(priv, false);
+
+	return 0;
+}
+
+static int hbg_net_set_mac_address(struct net_device *dev, void *addr)
+{
+	struct hbg_priv *priv = netdev_priv(dev);
+	u8 *mac_addr;
+
+	mac_addr = ((struct sockaddr *)addr)->sa_data;
+	hbg_hw_set_uc_addr(priv, ether_addr_to_u64(mac_addr));
+	dev_addr_set(dev, mac_addr);
+
+	return 0;
+}
+
+static int hbg_net_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct hbg_priv *priv = netdev_priv(dev);
+	bool is_opened = hbg_nic_is_open(priv);
+	u32 frame_len;
+
+	hbg_net_stop(dev);
+
+	frame_len = new_mtu + VLAN_HLEN * priv->dev_specs.vlan_layers +
+		    ETH_HLEN + ETH_FCS_LEN;
+	hbg_hw_set_mtu(priv, frame_len);
+	WRITE_ONCE(dev->mtu, new_mtu);
+
+	dev_dbg(&priv->pdev->dev,
+		"change mtu from %u to %u\n", dev->mtu, new_mtu);
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
 static int hbg_init(struct hbg_priv *priv)
 {
 	struct device *dev = &priv->pdev->dev;
@@ -84,6 +167,7 @@ static int hbg_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	priv = netdev_priv(netdev);
 	priv->netdev = netdev;
 	priv->pdev = pdev;
+	netdev->netdev_ops = &hbg_netdev_ops;
 
 	ret = hbg_pci_init(pdev);
 	if (ret)
@@ -93,6 +177,10 @@ static int hbg_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		return ret;
 
+	netdev->max_mtu = priv->dev_specs.max_mtu;
+	netdev->min_mtu = priv->dev_specs.min_mtu;
+	hbg_net_change_mtu(netdev, HBG_DEFAULT_MTU_SIZE);
+	hbg_net_set_mac_address(priv->netdev, &priv->dev_specs.mac_addr);
 	ret = devm_register_netdev(dev, netdev);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to register netdev\n");
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index 603bfc612fde..ffbb0998a221 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -31,19 +31,27 @@
 #define HBG_REG_SGMII_BASE			0x10000
 #define HBG_REG_DUPLEX_TYPE_ADDR		(HBG_REG_SGMII_BASE + 0x0008)
 #define HBG_REG_DUPLEX_B			BIT(0)
+#define HBG_REG_MAX_FRAME_SIZE_ADDR		(HBG_REG_SGMII_BASE + 0x003C)
 #define HBG_REG_PORT_MODE_ADDR			(HBG_REG_SGMII_BASE + 0x0040)
 #define HBG_REG_PORT_MODE_M			GENMASK(3, 0)
+#define HBG_REG_PORT_ENABLE_ADDR		(HBG_REG_SGMII_BASE + 0x0044)
+#define HBG_REG_PORT_ENABLE_RX_B		BIT(1)
+#define HBG_REG_PORT_ENABLE_TX_B		BIT(2)
 #define HBG_REG_TRANSMIT_CONTROL_ADDR		(HBG_REG_SGMII_BASE + 0x0060)
 #define HBG_REG_CF_CRC_STRIP_ADDR		(HBG_REG_SGMII_BASE + 0x01B0)
 #define HBG_REG_CF_CRC_STRIP_B			BIT(1)
 #define HBG_REG_MODE_CHANGE_EN_ADDR		(HBG_REG_SGMII_BASE + 0x01B4)
 #define HBG_REG_MODE_CHANGE_EN_B		BIT(0)
 #define HBG_REG_RECV_CONTROL_ADDR		(HBG_REG_SGMII_BASE + 0x01E0)
+#define HBG_REG_STATION_ADDR_LOW_2_ADDR		(HBG_REG_SGMII_BASE + 0x0210)
+#define HBG_REG_STATION_ADDR_HIGH_2_ADDR	(HBG_REG_SGMII_BASE + 0x0214)
 
 /* PCU */
 #define HBG_REG_CF_INTRPT_MSK_ADDR		(HBG_REG_SGMII_BASE + 0x042C)
 #define HBG_REG_CF_INTRPT_STAT_ADDR		(HBG_REG_SGMII_BASE + 0x0434)
 #define HBG_REG_CF_INTRPT_CLR_ADDR		(HBG_REG_SGMII_BASE + 0x0438)
+#define HBG_REG_MAX_FRAME_LEN_ADDR		(HBG_REG_SGMII_BASE + 0x0444)
+#define HBG_REG_MAX_FRAME_LEN_M			GENMASK(15, 0)
 #define HBG_REG_RX_BUF_SIZE_ADDR		(HBG_REG_SGMII_BASE + 0x04E4)
 #define HBG_REG_RX_BUF_SIZE_M			GENMASK(15, 0)
 #define HBG_REG_BUS_CTRL_ADDR			(HBG_REG_SGMII_BASE + 0x04E8)
@@ -51,6 +59,7 @@
 #define HBG_REG_RX_CTRL_ADDR			(HBG_REG_SGMII_BASE + 0x04F0)
 #define HBG_REG_RX_PKT_MODE_ADDR		(HBG_REG_SGMII_BASE + 0x04F4)
 #define HBG_REG_CF_IND_TXINT_MSK_ADDR		(HBG_REG_SGMII_BASE + 0x0694)
+#define HBG_REG_IND_INTR_MASK_B			BIT(0)
 #define HBG_REG_CF_IND_TXINT_STAT_ADDR		(HBG_REG_SGMII_BASE + 0x0698)
 #define HBG_REG_CF_IND_TXINT_CLR_ADDR		(HBG_REG_SGMII_BASE + 0x069C)
 #define HBG_REG_CF_IND_RXINT_MSK_ADDR		(HBG_REG_SGMII_BASE + 0x06a0)
-- 
2.33.0


