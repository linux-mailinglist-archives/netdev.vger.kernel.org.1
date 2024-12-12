Return-Path: <netdev+bounces-151395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D32D09EE8DB
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 15:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B809282B1C
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 14:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B91021D5A7;
	Thu, 12 Dec 2024 14:30:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A0A13BC26;
	Thu, 12 Dec 2024 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734013832; cv=none; b=oAyc59UHF/tZNOubvkiBcoMpbZuOh2DqnqSweiR3LbHtL4RsLdhBhYXPpv85U7t78ICmuR9uFSMgxgaDCTmx3UU+Og8Rq0tdcVy4XPHEZYX+EyWwzfR9XVwIk2Df9BNLnQYoKGaEt9sdKVIepZqunO6gIP5i5WNoStH6ji9ZdHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734013832; c=relaxed/simple;
	bh=DCR16VRn7X9E1Cwd7TSNyLpwoKlerSS4fAFxwp7TjRE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUnpYDBLlBCRQIMm6sJoMM+0azNb1qy16XgfjOt7LsJiXuM2uLAz6lpcBe7nYgbhEgdaZ+FJDMFiv474oYbooOTo/84NCkCer7uBVsgP86DedCESGtmTtNw6d7ssgrfJ9C81CHmGvXp07lHO6ogLZC84aXch4FJq5sioOeJg2+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Y8FFf6xgjzqTvP;
	Thu, 12 Dec 2024 22:28:38 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 05B3F140411;
	Thu, 12 Dec 2024 22:30:26 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Dec 2024 22:30:25 +0800
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
Subject: [PATCH V7 net-next 5/7] net: hibmcge: Add pauseparam supported in this module
Date: Thu, 12 Dec 2024 22:23:32 +0800
Message-ID: <20241212142334.1024136-6-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241212142334.1024136-1-shaojijie@huawei.com>
References: <20241212142334.1024136-1-shaojijie@huawei.com>
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
index 4841fed2a13b..fdd4d1bccef2 100644
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


