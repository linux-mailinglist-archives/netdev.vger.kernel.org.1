Return-Path: <netdev+bounces-200120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90938AE3414
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 05:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E4063AD778
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 03:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521141D63C0;
	Mon, 23 Jun 2025 03:48:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D301C5F2C;
	Mon, 23 Jun 2025 03:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750650506; cv=none; b=gSaKFUmeMd+dEKc9IlB4BHwt129dD4Iiyqc9tqG5Z24GvrKP3/Xqwr3kkX4mNt6ZAV4mwrOmdU0SoRF42zQJLSxXcmHwqw5QU6pjAWEYb+a/7WvX3+m7hXi+cthwti3Z6KuBUpYMj2izUKCAcWKMpJvmzAEdLDRcSHqbq6dopAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750650506; c=relaxed/simple;
	bh=xQBcAkwuSzR6QZNT3FSDMMVc1r4JHsB/lqhLuQluE2E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TG0Czt9J0scyZlyUhoQOpoFUwt17+qnzA8WD2ZZ0l06kRRRkSmP/I46180ZMwIYNIMjbRE49NE/j8ytRjxZfVzsvEsD84MEnJxQyxsmAy92LkmfKiN+nMnIeMw/Nk3RJouvDo7lGYUbKQ05YPKhsf7hdWj/APz/2oJu9JbIIW2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bQYs21q1Lz13MTN;
	Mon, 23 Jun 2025 11:45:58 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 03A72180489;
	Mon, 23 Jun 2025 11:48:16 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 23 Jun 2025 11:48:15 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH v2 net-next 1/3] net: hibmcge: support scenario without PHY.
Date: Mon, 23 Jun 2025 11:41:27 +0800
Message-ID: <20250623034129.838246-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250623034129.838246-1-shaojijie@huawei.com>
References: <20250623034129.838246-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk100013.china.huawei.com (7.202.194.61)

Currently, the driver uses phylib to operate PHY by default.

On some boards, the PHY device is separated from the MAC device.
As a result, the hibmcge driver cannot operate the PHY device.

In this patch, the driver determines whether a PHY is available
based on register configuration. If no PHY is available,
the driver intercepts phylib operations and operates only MAC device.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hibmcge/hbg_diagnose.c |   6 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_err.c  |   3 +
 .../ethernet/hisilicon/hibmcge/hbg_ethtool.c  | 100 +++++++++++++++++-
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |  41 ++++++-
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.c |  76 ++++++++++---
 .../net/ethernet/hisilicon/hibmcge/hbg_mdio.h |   3 +
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |   1 +
 7 files changed, 209 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.c
index f23fb5920c3c..c38ab7c0a69a 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.c
@@ -274,7 +274,11 @@ static int hbg_push_link_status(struct hbg_priv *priv)
 	u32 link_status[2];
 
 	/* phy link status */
-	link_status[0] = priv->mac.phydev->link;
+	if (priv->mac.phydev)
+		link_status[0] = priv->mac.phydev->link;
+	else
+		link_status[0] = 0;
+
 	/* mac link status */
 	link_status[1] = hbg_reg_read_field(priv, HBG_REG_AN_NEG_STATE_ADDR,
 					    HBG_REG_AN_NEG_STATE_NP_LINK_OK_B);
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
index ff3295b60a69..2d08f1891cba 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_err.c
@@ -35,6 +35,9 @@ static void hbg_restore_user_def_settings(struct hbg_priv *priv)
 	hbg_hw_set_pause_enable(priv, pause_param->tx_pause,
 				pause_param->rx_pause);
 	hbg_hw_set_rx_pause_mac_addr(priv, rx_pause_addr);
+
+	if (!priv->mac.phydev)
+		hbg_hw_adjust_link(priv, priv->mac.speed, priv->mac.duplex);
 }
 
 int hbg_rebuild(struct hbg_priv *priv)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
index 55520053270a..27121bb53315 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_ethtool.c
@@ -8,6 +8,7 @@
 #include "hbg_err.h"
 #include "hbg_ethtool.h"
 #include "hbg_hw.h"
+#include "hbg_mdio.h"
 
 struct hbg_ethtool_stats {
 	char name[ETH_GSTRING_LEN];
@@ -290,7 +291,10 @@ static int hbg_ethtool_set_pauseparam(struct net_device *net_dev,
 	struct hbg_priv *priv = netdev_priv(net_dev);
 
 	priv->mac.pause_autoneg = param->autoneg;
-	phy_set_asym_pause(priv->mac.phydev, param->rx_pause, param->tx_pause);
+
+	if (priv->mac.phydev)
+		phy_set_asym_pause(priv->mac.phydev,
+				   param->rx_pause, param->tx_pause);
 
 	if (!param->autoneg)
 		hbg_hw_set_pause_enable(priv, param->tx_pause, param->rx_pause);
@@ -474,16 +478,102 @@ hbg_ethtool_get_rmon_stats(struct net_device *netdev,
 	*ranges = hbg_rmon_ranges;
 }
 
+static int
+hbg_ethtool_get_link_ksettings_no_phy(struct hbg_priv *priv,
+				      struct ethtool_link_ksettings *cmd)
+{
+	u32 supported;
+
+	supported = (SUPPORTED_10baseT_Half | SUPPORTED_10baseT_Full |
+		     SUPPORTED_100baseT_Half | SUPPORTED_100baseT_Full |
+		     SUPPORTED_1000baseT_Full | SUPPORTED_TP);
+
+	cmd->base.speed = hbg_convert_mac_speed_to_phy(priv->mac.speed);
+	cmd->base.duplex = priv->mac.duplex;
+	cmd->base.autoneg = priv->mac.autoneg;
+	cmd->base.phy_address = priv->mac.phy_addr;
+	cmd->base.port = PORT_TP;
+	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
+						supported);
+	return 0;
+}
+
+static int hbg_ethtool_get_link_ksettings(struct net_device *netdev,
+					  struct ethtool_link_ksettings *cmd)
+{
+	struct hbg_priv *priv = netdev_priv(netdev);
+
+	if (priv->mac.phydev)
+		return phy_ethtool_get_link_ksettings(netdev, cmd);
+	else
+		return hbg_ethtool_get_link_ksettings_no_phy(priv, cmd);
+}
+
+static int
+hbg_ethtool_set_link_ksettings_no_phy(struct hbg_priv *priv,
+				      const struct ethtool_link_ksettings *cmd)
+{
+	u32 speed;
+
+	if (cmd->base.autoneg) {
+		netdev_err(priv->netdev, "cannot set autoneg without phy\n");
+		return -EINVAL;
+	}
+
+	speed = hbg_convert_phy_speed_to_mac(cmd->base.speed);
+	if (speed == HBG_PORT_MODE_SGMII_UNKNOWN ||
+	    (speed == HBG_PORT_MODE_SGMII_1000M &&
+	     cmd->base.duplex != DUPLEX_FULL))
+		return -EINVAL;
+
+	priv->mac.speed = speed;
+	priv->mac.duplex = cmd->base.duplex;
+	hbg_hw_adjust_link(priv, priv->mac.speed, priv->mac.duplex);
+	return 0;
+}
+
+static int
+hbg_ethtool_set_link_ksettings(struct net_device *netdev,
+			       const struct ethtool_link_ksettings *cmd)
+{
+	struct hbg_priv *priv = netdev_priv(netdev);
+
+	if (priv->mac.phydev)
+		return phy_ethtool_set_link_ksettings(netdev, cmd);
+	else
+		return hbg_ethtool_set_link_ksettings_no_phy(priv, cmd);
+}
+
+static u32 hbg_ethtool_get_link(struct net_device *netdev)
+{
+	struct hbg_priv *priv = netdev_priv(netdev);
+
+	if (priv->mac.phydev)
+		return ethtool_op_get_link(netdev);
+
+	return priv->mac.link_status;
+}
+
+static int hbg_ethtool_nway_reset(struct net_device *netdev)
+{
+	struct hbg_priv *priv = netdev_priv(netdev);
+
+	if (!priv->mac.phydev)
+		return -EOPNOTSUPP;
+
+	return phy_ethtool_nway_reset(netdev);
+}
+
 static const struct ethtool_ops hbg_ethtool_ops = {
-	.get_link		= ethtool_op_get_link,
-	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
-	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
+	.get_link		= hbg_ethtool_get_link,
+	.get_link_ksettings	= hbg_ethtool_get_link_ksettings,
+	.set_link_ksettings	= hbg_ethtool_set_link_ksettings,
 	.get_regs_len		= hbg_ethtool_get_regs_len,
 	.get_regs		= hbg_ethtool_get_regs,
 	.get_pauseparam         = hbg_ethtool_get_pauseparam,
 	.set_pauseparam         = hbg_ethtool_set_pauseparam,
 	.reset			= hbg_ethtool_reset,
-	.nway_reset		= phy_ethtool_nway_reset,
+	.nway_reset		= hbg_ethtool_nway_reset,
 	.get_sset_count		= hbg_ethtool_get_sset_count,
 	.get_strings		= hbg_ethtool_get_strings,
 	.get_ethtool_stats	= hbg_ethtool_get_stats,
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 2e64dc1ab355..93b7cdfbf54e 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -19,6 +19,8 @@
 #define HBG_SUPPORT_FEATURES (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | \
 			     NETIF_F_RXCSUM)
 
+static void hbg_update_link_status(struct hbg_priv *priv);
+
 static void hbg_all_irq_enable(struct hbg_priv *priv, bool enabled)
 {
 	const struct hbg_irq_info *info;
@@ -42,7 +44,11 @@ static int hbg_net_open(struct net_device *netdev)
 	hbg_all_irq_enable(priv, true);
 	hbg_hw_mac_enable(priv, HBG_STATUS_ENABLE);
 	netif_start_queue(netdev);
-	hbg_phy_start(priv);
+
+	if (priv->mac.phydev)
+		hbg_phy_start(priv);
+	else
+		hbg_hw_adjust_link(priv, priv->mac.speed, priv->mac.duplex);
 
 	return 0;
 }
@@ -67,11 +73,15 @@ static int hbg_net_stop(struct net_device *netdev)
 {
 	struct hbg_priv *priv = netdev_priv(netdev);
 
-	hbg_phy_stop(priv);
+	if (priv->mac.phydev)
+		hbg_phy_stop(priv);
+
 	netif_stop_queue(netdev);
 	hbg_hw_mac_enable(priv, HBG_STATUS_DISABLE);
 	hbg_all_irq_enable(priv, false);
 	hbg_txrx_uninit(priv);
+
+	hbg_update_link_status(priv);
 	return hbg_hw_txrx_clear(priv);
 }
 
@@ -281,6 +291,32 @@ static const struct net_device_ops hbg_netdev_ops = {
 	.ndo_eth_ioctl		= phy_do_ioctl_running,
 };
 
+static void hbg_update_link_status(struct hbg_priv *priv)
+{
+	u8 link = 0;
+
+	/* if have phy, use phylib to update link status */
+	if (priv->mac.phydev)
+		return;
+
+	if (netif_running(priv->netdev))
+		link = hbg_reg_read_field(priv, HBG_REG_AN_NEG_STATE_ADDR,
+					  HBG_REG_AN_NEG_STATE_NP_LINK_OK_B);
+	if (link == priv->mac.link_status)
+		return;
+
+	if (link) {
+		netif_tx_wake_all_queues(priv->netdev);
+		netif_carrier_on(priv->netdev);
+	} else {
+		netif_carrier_off(priv->netdev);
+		netif_tx_stop_all_queues(priv->netdev);
+	}
+
+	priv->mac.link_status = link;
+	hbg_print_link_status(priv);
+}
+
 static void hbg_service_task(struct work_struct *work)
 {
 	struct hbg_priv *priv = container_of(work, struct hbg_priv,
@@ -292,6 +328,7 @@ static void hbg_service_task(struct work_struct *work)
 	if (test_and_clear_bit(HBG_NIC_STATE_NP_LINK_FAIL, &priv->state))
 		hbg_fix_np_link_fail(priv);
 
+	hbg_update_link_status(priv);
 	hbg_diagnose_message_push(priv);
 
 	/* The type of statistics register is u32,
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
index 42b0083c9193..5f27b530bd81 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
@@ -20,6 +20,8 @@
 
 #define HBG_NP_LINK_FAIL_RETRY_TIMES	5
 
+#define HBG_UNUSE_PHY	0xFF
+
 static void hbg_mdio_set_command(struct hbg_mac *mac, u32 cmd)
 {
 	hbg_reg_write(HBG_MAC_GET_PRIV(mac), HBG_REG_MDIO_COMMAND_ADDR, cmd);
@@ -134,6 +136,11 @@ void hbg_fix_np_link_fail(struct hbg_priv *priv)
 {
 	struct device *dev = &priv->pdev->dev;
 
+	if (!priv->mac.phydev) {
+		dev_err(dev, "failed to link between MAC and PHY\n");
+		return;
+	}
+
 	rtnl_lock();
 
 	if (priv->stats.np_link_fail_cnt >= HBG_NP_LINK_FAIL_RETRY_TIMES) {
@@ -158,6 +165,53 @@ void hbg_fix_np_link_fail(struct hbg_priv *priv)
 	rtnl_unlock();
 }
 
+int hbg_convert_mac_speed_to_phy(u32 mac_speed)
+{
+	switch (mac_speed) {
+	case HBG_PORT_MODE_SGMII_10M:
+		return SPEED_10;
+	case HBG_PORT_MODE_SGMII_100M:
+		return SPEED_100;
+	case HBG_PORT_MODE_SGMII_1000M:
+		return SPEED_1000;
+	default:
+		return SPEED_UNKNOWN;
+	}
+}
+
+u32 hbg_convert_phy_speed_to_mac(int phy_speed)
+{
+	switch (phy_speed) {
+	case SPEED_10:
+		return HBG_PORT_MODE_SGMII_10M;
+	case SPEED_100:
+		return HBG_PORT_MODE_SGMII_100M;
+	case SPEED_1000:
+		return HBG_PORT_MODE_SGMII_1000M;
+	default:
+		return HBG_PORT_MODE_SGMII_UNKNOWN;
+	}
+}
+
+void hbg_print_link_status(struct hbg_priv *priv)
+{
+	u32 speed;
+
+	if (priv->mac.phydev) {
+		phy_print_status(priv->mac.phydev);
+		return;
+	}
+
+	if (priv->mac.link_status) {
+		speed = hbg_convert_mac_speed_to_phy(priv->mac.speed);
+		netdev_info(priv->netdev, "Link is Up - %s/%s\n",
+			    phy_speed_to_str(speed),
+			    phy_duplex_to_str(priv->mac.duplex));
+	} else {
+		netdev_info(priv->netdev, "Link is Down\n");
+	}
+}
+
 static void hbg_phy_adjust_link(struct net_device *netdev)
 {
 	struct hbg_priv *priv = netdev_priv(netdev);
@@ -166,19 +220,9 @@ static void hbg_phy_adjust_link(struct net_device *netdev)
 
 	if (phydev->link != priv->mac.link_status) {
 		if (phydev->link) {
-			switch (phydev->speed) {
-			case SPEED_10:
-				speed = HBG_PORT_MODE_SGMII_10M;
-				break;
-			case SPEED_100:
-				speed = HBG_PORT_MODE_SGMII_100M;
-				break;
-			case SPEED_1000:
-				speed = HBG_PORT_MODE_SGMII_1000M;
-				break;
-			default:
+			speed = hbg_convert_phy_speed_to_mac(phydev->speed);
+			if (speed == HBG_PORT_MODE_SGMII_UNKNOWN)
 				return;
-			}
 
 			priv->mac.speed = speed;
 			priv->mac.duplex = phydev->duplex;
@@ -188,7 +232,7 @@ static void hbg_phy_adjust_link(struct net_device *netdev)
 		}
 
 		priv->mac.link_status = phydev->link;
-		phy_print_status(phydev);
+		hbg_print_link_status(priv);
 	}
 }
 
@@ -238,6 +282,12 @@ int hbg_mdio_init(struct hbg_priv *priv)
 	int ret;
 
 	mac->phy_addr = priv->dev_specs.phy_addr;
+	if (mac->phy_addr == HBG_UNUSE_PHY) {
+		mac->duplex = 1;
+		mac->speed = HBG_PORT_MODE_SGMII_1000M;
+		return 0;
+	}
+
 	mdio_bus = devm_mdiobus_alloc(dev);
 	if (!mdio_bus)
 		return dev_err_probe(dev, -ENOMEM,
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.h
index f3771c1bbd34..64c1f79b434c 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.h
@@ -10,5 +10,8 @@ int hbg_mdio_init(struct hbg_priv *priv);
 void hbg_phy_start(struct hbg_priv *priv);
 void hbg_phy_stop(struct hbg_priv *priv);
 void hbg_fix_np_link_fail(struct hbg_priv *priv);
+int hbg_convert_mac_speed_to_phy(u32 mac_speed);
+u32 hbg_convert_phy_speed_to_mac(int phy_speed);
+void hbg_print_link_status(struct hbg_priv *priv);
 
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index a6e7f5e62b48..eb50b202ca3a 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -218,6 +218,7 @@ enum hbg_port_mode {
 	HBG_PORT_MODE_SGMII_10M = 0x6,
 	HBG_PORT_MODE_SGMII_100M = 0x7,
 	HBG_PORT_MODE_SGMII_1000M = 0x8,
+	HBG_PORT_MODE_SGMII_UNKNOWN = 0x9,
 };
 
 struct hbg_tx_desc {
-- 
2.33.0


