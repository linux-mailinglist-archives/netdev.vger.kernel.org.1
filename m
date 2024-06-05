Return-Path: <netdev+bounces-100929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4F78FC8CD
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 12:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACCCF1F215F2
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 10:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF8F19146F;
	Wed,  5 Jun 2024 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wkxjHc7g"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9318F190464;
	Wed,  5 Jun 2024 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717582773; cv=none; b=aSsvAJpTBcjsxIByTCt0bk3VQMJYMMDeGwvt871DO7HytOn3ynVEbr5y35xTi6AWJEI6UpaEqmKIQvfQS5uChlFslsfuae0+yxRBZaKcL+W0pKZzWRItsyqPTz5tUBG08DwXcySvyzqFqr6LyBUz8HsvodU63B1wDeOyZuWYKkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717582773; c=relaxed/simple;
	bh=C39gtNMTn79dOx57wjtduJHkJKhqY/HbCZ4cGdNxOOc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eiBshlDV8Y7eZnLGjgqOoNZZOJ1Qm6gYs+CT1bUpLZPeRE3BqM6qHpc2mgqhf5DJcrWg5fK7WTqNEzjhmRexUafr4CeIRQQBILG0Fd1L4zgazCeX6Fkyd4XSVi16+5L8zLUOZICU+3zGA6G2Py03opSi22P5RVl2daj30qeQjOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wkxjHc7g; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717582771; x=1749118771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C39gtNMTn79dOx57wjtduJHkJKhqY/HbCZ4cGdNxOOc=;
  b=wkxjHc7gqCCz/nJq/W367AUbSfDn4SxrxO86fZBmpEuW6JoB2eUmR3oP
   TorD4HPTh1NmhAj1jDhxe91JEwbxozaoEZV45dZ041bjBn6SUO7fur3Iz
   YZTRhueJaYB89V1qcynSxKp4Q8XOAQt+MwLYdPBK4vrRKxMEWKaml2L4O
   DBv5HIRjJUf3oDOtqoBXoGBepfMoCXmOdPoYYoFHAPZ9nbYVgTquPodGI
   MYtIh0TeittW/2+e8tkJUFa0oTWlHmjrCLwhJ5jG5ov1Ec0/ujb6AkyMT
   5eQiD7IMyc4k8CveOqV4QH9Ks0ddiQ3i7powdhdyp7oYwblYr6hEWz0WJ
   A==;
X-CSE-ConnectionGUID: rkT7QjcKSauc7tHXRkZszA==
X-CSE-MsgGUID: IBFId4JuTNyKGAeeZ7UEjg==
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="27005376"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jun 2024 03:19:29 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 5 Jun 2024 03:19:11 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 5 Jun 2024 03:19:06 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<bryan.whitehead@microchip.com>, <andrew@lunn.ch>, <linux@armlinux.org.uk>,
	<sbauer@blackbox.su>, <hmehrtens@maxlinear.com>, <lxu@maxlinear.com>,
	<hkallweit1@gmail.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>
Subject: [PATCH net V3 2/3] net: lan743x: Support WOL at both the PHY and MAC appropriately
Date: Wed, 5 Jun 2024 15:46:10 +0530
Message-ID: <20240605101611.18791-3-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605101611.18791-1-Raju.Lakkaraju@microchip.com>
References: <20240605101611.18791-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Prevent options not supported by the PHY from being requested to it by the MAC
Whenever a WOL option is supported by both, the PHY is given priority
since that usually leads to better power savings

Fixes: e9e13b6adc338 ("lan743x: fix for potential NULL pointer dereference with bare card")
Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
Change List:
------------
V2 -> V3:
  - Remove the "phy does not support WOL" debug message which is not required
  - Remove WAKE_PHY support option from Ethernet MAC (LAN743x/PCI11x1x) driver
  - Add "phy_wol_supported" and "phy_wolopts" variables to hold PHY's WOL config
V1 -> V2:
  - Repost - No change
V0 -> V1:
  - Change the "phy does not support WOL" print from netif_info() to
    netif_dbg()

 .../net/ethernet/microchip/lan743x_ethtool.c  | 44 +++++++++++++++++--
 drivers/net/ethernet/microchip/lan743x_main.c | 16 +++++--
 drivers/net/ethernet/microchip/lan743x_main.h |  4 ++
 3 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index d0f4ff4ee075..0d1740d64676 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -1127,8 +1127,12 @@ static void lan743x_ethtool_get_wol(struct net_device *netdev,
 	if (netdev->phydev)
 		phy_ethtool_get_wol(netdev->phydev, wol);
 
-	wol->supported |= WAKE_BCAST | WAKE_UCAST | WAKE_MCAST |
-		WAKE_MAGIC | WAKE_PHY | WAKE_ARP;
+	if (wol->supported != adapter->phy_wol_supported)
+		netif_warn(adapter, drv, adapter->netdev,
+			   "PHY changed its supported WOL! old=%x, new=%x\n",
+			   adapter->phy_wol_supported, wol->supported);
+
+	wol->supported |= MAC_SUPPORTED_WAKES;
 
 	if (adapter->is_pci11x1x)
 		wol->supported |= WAKE_MAGICSECURE;
@@ -1143,7 +1147,39 @@ static int lan743x_ethtool_set_wol(struct net_device *netdev,
 {
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
 
+	/* WAKE_MAGICSEGURE is a modifier of and only valid together with
+	 * WAKE_MAGIC
+	 */
+	if ((wol->wolopts & WAKE_MAGICSECURE) && !(wol->wolopts & WAKE_MAGIC))
+		return -EINVAL;
+
+	if (netdev->phydev) {
+		struct ethtool_wolinfo phy_wol;
+		int ret;
+
+		phy_wol.wolopts = wol->wolopts & adapter->phy_wol_supported;
+
+		/* If WAKE_MAGICSECURE was requested, filter out WAKE_MAGIC
+		 * for PHYs that do not support WAKE_MAGICSECURE
+		 */
+		if (wol->wolopts & WAKE_MAGICSECURE &&
+		    !(adapter->phy_wol_supported & WAKE_MAGICSECURE))
+			phy_wol.wolopts &= ~WAKE_MAGIC;
+
+		ret = phy_ethtool_set_wol(netdev->phydev, &phy_wol);
+		if (ret && (ret != -EOPNOTSUPP))
+			return ret;
+
+		if (ret == -EOPNOTSUPP)
+			adapter->phy_wolopts = 0;
+		else
+			adapter->phy_wolopts = phy_wol.wolopts;
+	} else {
+		adapter->phy_wolopts = 0;
+	}
+
 	adapter->wolopts = 0;
+	wol->wolopts &= ~adapter->phy_wolopts;
 	if (wol->wolopts & WAKE_UCAST)
 		adapter->wolopts |= WAKE_UCAST;
 	if (wol->wolopts & WAKE_MCAST)
@@ -1164,10 +1200,10 @@ static int lan743x_ethtool_set_wol(struct net_device *netdev,
 		memset(adapter->sopass, 0, sizeof(u8) * SOPASS_MAX);
 	}
 
+	wol->wolopts = adapter->wolopts | adapter->phy_wolopts;
 	device_set_wakeup_enable(&adapter->pdev->dev, (bool)wol->wolopts);
 
-	return netdev->phydev ? phy_ethtool_set_wol(netdev->phydev, wol)
-			: -ENETDOWN;
+	return 0;
 }
 #endif /* CONFIG_PM */
 
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 6a40b961fafb..b6810840bc61 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -3118,6 +3118,15 @@ static int lan743x_netdev_open(struct net_device *netdev)
 		if (ret)
 			goto close_tx;
 	}
+
+	if (adapter->netdev->phydev) {
+		struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
+
+		phy_ethtool_get_wol(netdev->phydev, &wol);
+		adapter->phy_wol_supported = wol.supported;
+		adapter->phy_wolopts = wol.wolopts;
+	}
+
 	return 0;
 
 close_tx:
@@ -3587,10 +3596,9 @@ static void lan743x_pm_set_wol(struct lan743x_adapter *adapter)
 
 	pmtctl |= PMT_CTL_ETH_PHY_D3_COLD_OVR_ | PMT_CTL_ETH_PHY_D3_OVR_;
 
-	if (adapter->wolopts & WAKE_PHY) {
-		pmtctl |= PMT_CTL_ETH_PHY_EDPD_PLL_CTL_;
+	if (adapter->phy_wolopts)
 		pmtctl |= PMT_CTL_ETH_PHY_WAKE_EN_;
-	}
+
 	if (adapter->wolopts & WAKE_MAGIC) {
 		wucsr |= MAC_WUCSR_MPEN_;
 		macrx |= MAC_RX_RXEN_;
@@ -3686,7 +3694,7 @@ static int lan743x_pm_suspend(struct device *dev)
 	lan743x_csr_write(adapter, MAC_WUCSR2, 0);
 	lan743x_csr_write(adapter, MAC_WK_SRC, 0xFFFFFFFF);
 
-	if (adapter->wolopts)
+	if (adapter->wolopts || adapter->phy_wolopts)
 		lan743x_pm_set_wol(adapter);
 
 	if (adapter->is_pci11x1x) {
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index fac0f33d10b2..3b2585a384e2 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -1042,6 +1042,8 @@ enum lan743x_sgmii_lsd {
 	LINK_2500_SLAVE
 };
 
+#define MAC_SUPPORTED_WAKES  (WAKE_BCAST | WAKE_UCAST | WAKE_MCAST | \
+			      WAKE_MAGIC | WAKE_ARP)
 struct lan743x_adapter {
 	struct net_device       *netdev;
 	struct mii_bus		*mdiobus;
@@ -1049,6 +1051,8 @@ struct lan743x_adapter {
 #ifdef CONFIG_PM
 	u32			wolopts;
 	u8			sopass[SOPASS_MAX];
+	u32			phy_wolopts;
+	u32			phy_wol_supported;
 #endif
 	struct pci_dev		*pdev;
 	struct lan743x_csr      csr;
-- 
2.34.1


