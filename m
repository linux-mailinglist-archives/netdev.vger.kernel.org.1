Return-Path: <netdev+bounces-152061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AEF9F292F
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 05:13:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52CF1886012
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 04:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0CE17A5BD;
	Mon, 16 Dec 2024 04:13:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08012AD18;
	Mon, 16 Dec 2024 04:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734322425; cv=none; b=vAlg91FTSc2ZkAIfBR/RRn9xU/tdVRS+cmU+JoRomcWCc0+6X4NcuVkaA9sFi2yHlZqHEIvjEgb+Ri9j79pAVDUp8Ptj9qodXPOabMqRUZa95d78lSrKAiaOAb8Jo+1n0J0/B2hFl4hshCxGCW6rix1MOE7JR7vi2DOf4W9xFGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734322425; c=relaxed/simple;
	bh=7airDTSTaEgRguni6+UaCNnuNTq5+I5LbGXHXAK2oYU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c281q92NDT64GAlMNUC1AZUZkukse5O6DqZ6GWh7HD9HmbwquABnvFTRADWeO7TpXtx/Bs9GHNPmOMLmGgSj9ssD6ohUnFzMNqo1vbuhDLQl1H6mgRPnjDz+CRda1l15vHL3m00hUp9N2zWAQfT+PwLwjOd6BpLtAt0Zqse9oko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4YBRMJ08JBz1T7Bt;
	Mon, 16 Dec 2024 12:11:08 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 6659B1400D5;
	Mon, 16 Dec 2024 12:13:40 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 16 Dec 2024 12:13:39 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<gregkh@linuxfoundation.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>, <hkelam@marvell.com>
Subject: [PATCH V8 net-next 5/7] net: hibmcge: Add pauseparam supported in this module
Date: Mon, 16 Dec 2024 12:05:30 +0800
Message-ID: <20241216040532.1566229-6-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241216040532.1566229-1-shaojijie@huawei.com>
References: <20241216040532.1566229-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)

The MAC can automatically send or respond to pause frames.
This patch supports the function of enabling pause frames
by using ethtool.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  1 +
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.c  | 25 +++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.c   | 21 ++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_hw.h   |  3 +++
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |  1 +
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c | 15 +++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  2 ++
 7 files changed, 68 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index 9bb3abe88377..cc143a536713 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -115,6 +115,7 @@ struct hbg_mac {
 	u32 duplex;
 	u32 autoneg;
 	u32 link_status;
+	u32 pause_autoneg;
 };
 
 struct hbg_mac_table_entry {
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
index e7f169d2abb7..a821a92db43d 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
@@ -143,12 +143,37 @@ static void hbg_ethtool_get_regs(struct net_device *netdev,
 	}
 }
 
+static void hbg_ethtool_get_pauseparam(struct net_device *net_dev,
+				       struct ethtool_pauseparam *param)
+{
+	struct hbg_priv *priv = netdev_priv(net_dev);
+
+	param->autoneg = priv->mac.pause_autoneg;
+	hbg_hw_get_pause_enable(priv, &param->tx_pause, &param->rx_pause);
+}
+
+static int hbg_ethtool_set_pauseparam(struct net_device *net_dev,
+				      struct ethtool_pauseparam *param)
+{
+	struct hbg_priv *priv = netdev_priv(net_dev);
+
+	priv->mac.pause_autoneg = param->autoneg;
+	phy_set_asym_pause(priv->mac.phydev, param->rx_pause, param->tx_pause);
+
+	if (!param->autoneg)
+		hbg_hw_set_pause_enable(priv, param->tx_pause, param->rx_pause);
+
+	return 0;
+}
+
 static const struct ethtool_ops hbg_ethtool_ops = {
 	.get_link		= ethtool_op_get_link,
 	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
 	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
 	.get_regs_len		= hbg_ethtool_get_regs_len,
 	.get_regs		= hbg_ethtool_get_regs,
+	.get_pauseparam         = hbg_ethtool_get_pauseparam,
+	.set_pauseparam         = hbg_ethtool_set_pauseparam,
 };
 
 void hbg_ethtool_set_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
index 29d66a0ea0a6..0cbe9f7229b3 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -220,6 +220,27 @@ void hbg_hw_set_mac_filter_enable(struct hbg_priv *priv, u32 enable)
 			    HBG_REG_REC_FILT_CTRL_UC_MATCH_EN_B, enable);
 }
 
+void hbg_hw_set_pause_enable(struct hbg_priv *priv, u32 tx_en, u32 rx_en)
+{
+	hbg_reg_write_field(priv, HBG_REG_PAUSE_ENABLE_ADDR,
+			    HBG_REG_PAUSE_ENABLE_TX_B, tx_en);
+	hbg_reg_write_field(priv, HBG_REG_PAUSE_ENABLE_ADDR,
+			    HBG_REG_PAUSE_ENABLE_RX_B, rx_en);
+}
+
+void hbg_hw_get_pause_enable(struct hbg_priv *priv, u32 *tx_en, u32 *rx_en)
+{
+	*tx_en = hbg_reg_read_field(priv, HBG_REG_PAUSE_ENABLE_ADDR,
+				    HBG_REG_PAUSE_ENABLE_TX_B);
+	*rx_en = hbg_reg_read_field(priv, HBG_REG_PAUSE_ENABLE_ADDR,
+				    HBG_REG_PAUSE_ENABLE_RX_B);
+}
+
+void hbg_hw_set_rx_pause_mac_addr(struct hbg_priv *priv, u64 mac_addr)
+{
+	hbg_reg_write64(priv, HBG_REG_FD_FC_ADDR_LOW_ADDR, mac_addr);
+}
+
 static void hbg_hw_init_transmit_ctrl(struct hbg_priv *priv)
 {
 	u32 ctrl = 0;
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
index 6eb4b7d2cba8..a4a049b5121d 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.h
@@ -56,5 +56,8 @@ u32 hbg_hw_get_fifo_used_num(struct hbg_priv *priv, enum hbg_dir dir);
 void hbg_hw_set_tx_desc(struct hbg_priv *priv, struct hbg_tx_desc *tx_desc);
 void hbg_hw_fill_buffer(struct hbg_priv *priv, u32 buffer_dma_addr);
 void hbg_hw_set_mac_filter_enable(struct hbg_priv *priv, u32 enable);
+void hbg_hw_set_pause_enable(struct hbg_priv *priv, u32 tx_en, u32 rx_en);
+void hbg_hw_get_pause_enable(struct hbg_priv *priv, u32 *tx_en, u32 *rx_en);
+void hbg_hw_set_rx_pause_mac_addr(struct hbg_priv *priv, u64 mac_addr);
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 578ba8ee409b..8a2d63c0c196 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -191,6 +191,7 @@ static int hbg_net_set_mac_address(struct net_device *netdev, void *addr)
 	if (exists)
 		hbg_set_mac_to_mac_table(priv, index, NULL);
 
+	hbg_hw_set_rx_pause_mac_addr(priv, ether_addr_to_u64(mac_addr));
 	dev_addr_set(netdev, mac_addr);
 	return 0;
 }
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
index a3479fba8501..db6bc4cfb971 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
@@ -114,6 +114,19 @@ static void hbg_mdio_init_hw(struct hbg_priv *priv)
 	hbg_mdio_set_command(mac, cmd);
 }
 
+static void hbg_flowctrl_cfg(struct hbg_priv *priv)
+{
+	struct phy_device *phydev = priv->mac.phydev;
+	bool rx_pause;
+	bool tx_pause;
+
+	if (!priv->mac.pause_autoneg)
+		return;
+
+	phy_get_pause(phydev, &tx_pause, &rx_pause);
+	hbg_hw_set_pause_enable(priv, tx_pause, rx_pause);
+}
+
 static void hbg_phy_adjust_link(struct net_device *netdev)
 {
 	struct hbg_priv *priv = netdev_priv(netdev);
@@ -140,6 +153,7 @@ static void hbg_phy_adjust_link(struct net_device *netdev)
 			priv->mac.duplex = phydev->duplex;
 			priv->mac.autoneg = phydev->autoneg;
 			hbg_hw_adjust_link(priv, speed, phydev->duplex);
+			hbg_flowctrl_cfg(priv);
 		}
 
 		priv->mac.link_status = phydev->link;
@@ -168,6 +182,7 @@ static int hbg_phy_connect(struct hbg_priv *priv)
 		return ret;
 
 	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
+	phy_support_asym_pause(phydev);
 	phy_attached_info(phydev);
 
 	return 0;
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index 665666712c7c..f12efc12f3c5 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -51,6 +51,8 @@
 #define HBG_REG_PORT_ENABLE_RX_B		BIT(1)
 #define HBG_REG_PORT_ENABLE_TX_B		BIT(2)
 #define HBG_REG_PAUSE_ENABLE_ADDR		(HBG_REG_SGMII_BASE + 0x0048)
+#define HBG_REG_PAUSE_ENABLE_RX_B		BIT(0)
+#define HBG_REG_PAUSE_ENABLE_TX_B		BIT(1)
 #define HBG_REG_AN_NEG_STATE_ADDR		(HBG_REG_SGMII_BASE + 0x0058)
 #define HBG_REG_TRANSMIT_CTRL_ADDR		(HBG_REG_SGMII_BASE + 0x0060)
 #define HBG_REG_TRANSMIT_CTRL_PAD_EN_B		BIT(7)
-- 
2.33.0


