Return-Path: <netdev+bounces-41837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19ACC7CBFCA
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C34EE28167C
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B235405E8;
	Tue, 17 Oct 2023 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ySpEhj4Z"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0232381D8
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:44:14 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF97103;
	Tue, 17 Oct 2023 02:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1697535852; x=1729071852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4rShQaN0BjuypQNXY38PzlhzE5ck98tJjN4aVyfvIoQ=;
  b=ySpEhj4Z5KlYEJBEZeUW3SOerPUtIx4QrqUhlFvlsKJWpkIiDDxAh+Lm
   K5ICk1cnBuDltpmJS11EGXhvKgY0kasPYDgkr0S8K/zugG4vgpISSJZtK
   wCS58TjRHrpSIRpN3uZPBYKC4IhTPEAoIn1jAbk5FBfDyqEWr496GCkYz
   sUBMaGZbpNpOAiTBdID0Q38IDBRE5rxCC/lQ1UynDACPo+zYyGgsQzudB
   5gxPgIk1NbPlUJt2LsLvx/21nfzuotkTYEwL0+2119GqwvpXtM2MCVPkz
   4ED8Mt+tiboAg2J5PScwlzUUdqg92ZB3RdbcPjcvUf1ZbmM6VkwOLa376
   w==;
X-CSE-ConnectionGUID: dgJ6hSiqT7yzYdbZnQNEqQ==
X-CSE-MsgGUID: TZFbQwDpS0qzX8aym//nrg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="10336290"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2023 02:44:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 17 Oct 2023 02:43:42 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 17 Oct 2023 02:43:39 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <Bryan.Whitehead@microchip.com>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V1 7/7] net: lan743x: Add support to ethtool phylink get and set settings
Date: Tue, 17 Oct 2023 15:12:08 +0530
Message-ID: <20231017094208.4956-8-Raju.Lakkaraju@microchip.com>
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

Add support to ethtool phylink functions:
  - get/set settings like speed, duplex etc.
  - get/set the wake-on-lan (WOL)
  - get/set the energy-efficient ethernet (EEE)
  - get/set the pause

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
Change Log:                                                                     
===========                                                                     
V0 -> V1:                                                                       
  - Remove the phylib ethtool functions and support the phylink ethtool 

 .../net/ethernet/microchip/lan743x_ethtool.c  | 85 ++++++++-----------
 1 file changed, 34 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index 9f825d0c6dec..349630baa29a 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -1055,19 +1055,10 @@ static int lan743x_ethtool_get_eee(struct net_device *netdev,
 				   struct ethtool_eee *eee)
 {
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
-	struct phy_device *phydev = netdev->phydev;
 	u32 buf;
 	int ret;
 
-	if (!phydev)
-		return -EIO;
-	if (!phydev->drv) {
-		netif_err(adapter, drv, adapter->netdev,
-			  "Missing PHY Driver\n");
-		return -EIO;
-	}
-
-	ret = phy_ethtool_get_eee(phydev, eee);
+	ret = phylink_ethtool_get_eee(adapter->phylink, eee);
 	if (ret < 0)
 		return ret;
 
@@ -1093,32 +1084,15 @@ static int lan743x_ethtool_set_eee(struct net_device *netdev,
 				   struct ethtool_eee *eee)
 {
 	struct lan743x_adapter *adapter;
-	struct phy_device *phydev;
 	u32 buf = 0;
-	int ret = 0;
 
 	if (!netdev)
 		return -EINVAL;
 	adapter = netdev_priv(netdev);
 	if (!adapter)
 		return -EINVAL;
-	phydev = netdev->phydev;
-	if (!phydev)
-		return -EIO;
-	if (!phydev->drv) {
-		netif_err(adapter, drv, adapter->netdev,
-			  "Missing PHY Driver\n");
-		return -EIO;
-	}
 
 	if (eee->eee_enabled) {
-		ret = phy_init_eee(phydev, false);
-		if (ret) {
-			netif_err(adapter, drv, adapter->netdev,
-				  "EEE initialization failed\n");
-			return ret;
-		}
-
 		buf = (u32)eee->tx_lpi_timer;
 		lan743x_csr_write(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT, buf);
 
@@ -1131,7 +1105,23 @@ static int lan743x_ethtool_set_eee(struct net_device *netdev,
 		lan743x_csr_write(adapter, MAC_CR, buf);
 	}
 
-	return phy_ethtool_set_eee(phydev, eee);
+	return phylink_ethtool_set_eee(adapter->phylink, eee);
+}
+
+static int lan743x_ethtool_set_link_ksettings(struct net_device *netdev,
+					      const struct ethtool_link_ksettings *cmd)
+{
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+
+	return phylink_ethtool_ksettings_set(adapter->phylink, cmd);
+}
+
+static int lan743x_ethtool_get_link_ksettings(struct net_device *netdev,
+					      struct ethtool_link_ksettings *cmd)
+{
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+
+	return phylink_ethtool_ksettings_get(adapter->phylink, cmd);
 }
 
 #ifdef CONFIG_PM
@@ -1143,8 +1133,7 @@ static void lan743x_ethtool_get_wol(struct net_device *netdev,
 	wol->supported = 0;
 	wol->wolopts = 0;
 
-	if (netdev->phydev)
-		phy_ethtool_get_wol(netdev->phydev, wol);
+	phylink_ethtool_get_wol(adapter->phylink, wol);
 
 	wol->supported |= WAKE_BCAST | WAKE_UCAST | WAKE_MCAST |
 		WAKE_MAGIC | WAKE_PHY | WAKE_ARP;
@@ -1161,8 +1150,18 @@ static int lan743x_ethtool_set_wol(struct net_device *netdev,
 				   struct ethtool_wolinfo *wol)
 {
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
+	int ret;
 
 	adapter->wolopts = 0;
+
+	/* Pass the order to phylink layer */
+	ret = phylink_ethtool_set_wol(adapter->phylink, wol);
+	/* Don't manage WoL on MAC if handled by the PHY
+	 * or if there's a failure in talking to the PHY
+	 */
+	if (!ret || ret != -EOPNOTSUPP)
+		return ret;
+
 	if (wol->wolopts & WAKE_UCAST)
 		adapter->wolopts |= WAKE_UCAST;
 	if (wol->wolopts & WAKE_MCAST)
@@ -1185,8 +1184,7 @@ static int lan743x_ethtool_set_wol(struct net_device *netdev,
 
 	device_set_wakeup_enable(&adapter->pdev->dev, (bool)wol->wolopts);
 
-	return netdev->phydev ? phy_ethtool_set_wol(netdev->phydev, wol)
-			: -ENETDOWN;
+	return 0;
 }
 #endif /* CONFIG_PM */
 
@@ -1342,28 +1340,16 @@ static void lan743x_get_pauseparam(struct net_device *dev,
 				   struct ethtool_pauseparam *pause)
 {
 	struct lan743x_adapter *adapter = netdev_priv(dev);
-	struct lan743x_phy *phy = &adapter->phy;
 
-	if (phy->fc_request_control & FLOW_CTRL_TX)
-		pause->tx_pause = 1;
-	if (phy->fc_request_control & FLOW_CTRL_RX)
-		pause->rx_pause = 1;
-	pause->autoneg = phy->fc_autoneg;
+	phylink_ethtool_get_pauseparam(adapter->phylink, pause);
 }
 
 static int lan743x_set_pauseparam(struct net_device *dev,
 				  struct ethtool_pauseparam *pause)
 {
 	struct lan743x_adapter *adapter = netdev_priv(dev);
-	struct phy_device *phydev = dev->phydev;
 	struct lan743x_phy *phy = &adapter->phy;
 
-	if (!phydev)
-		return -ENODEV;
-
-	if (!phy_validate_pause(phydev, pause))
-		return -EINVAL;
-
 	phy->fc_request_control = 0;
 	if (pause->rx_pause)
 		phy->fc_request_control |= FLOW_CTRL_RX;
@@ -1376,10 +1362,7 @@ static int lan743x_set_pauseparam(struct net_device *dev,
 	if (pause->autoneg == AUTONEG_DISABLE)
 		lan743x_mac_flow_ctrl_set_enables(adapter, pause->tx_pause,
 						  pause->rx_pause);
-	else
-		phy_set_asym_pause(phydev, pause->rx_pause,  pause->tx_pause);
-
-	return 0;
+	return phylink_ethtool_set_pauseparam(adapter->phylink, pause);
 }
 
 const struct ethtool_ops lan743x_ethtool_ops = {
@@ -1404,8 +1387,8 @@ const struct ethtool_ops lan743x_ethtool_ops = {
 	.get_ts_info = lan743x_ethtool_get_ts_info,
 	.get_eee = lan743x_ethtool_get_eee,
 	.set_eee = lan743x_ethtool_set_eee,
-	.get_link_ksettings = phy_ethtool_get_link_ksettings,
-	.set_link_ksettings = phy_ethtool_set_link_ksettings,
+	.get_link_ksettings = lan743x_ethtool_get_link_ksettings,
+	.set_link_ksettings = lan743x_ethtool_set_link_ksettings,
 	.get_regs_len = lan743x_get_regs_len,
 	.get_regs = lan743x_get_regs,
 	.get_pauseparam = lan743x_get_pauseparam,
-- 
2.34.1


