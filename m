Return-Path: <netdev+bounces-196582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 210CFAD57B6
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 15:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8B31897EF5
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 13:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2523E2951CA;
	Wed, 11 Jun 2025 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IAm7fp5H"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA5C288CB4
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650229; cv=none; b=DEq6LcCoe/mVTYxHC7CxVrEntO0eZuW5FLsAj7Fn9GwEhTHgezGT1hdwZzHywBoC+beVVHBj1peUEK13jyC/IYGvvTJo602kj9S/e8MFEipOMUbKiMG+szHtD0Ot0JvB5m5FYzMTvRKJk703mE4X8CwcVluYKIsZ5MQ7QkTIeE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650229; c=relaxed/simple;
	bh=ArL6TJsa1OmGRURDWNq95JG3YFOlqXC1T2Fo93PchkI=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=WIX/l8/hAQKSjbl/h2nCUf25wZctASGvU2EUMlDmoNHTXXJB3aj7YqgppX38WQd+2IFGRxUMkes7O24abBLNLxcqo0nJ5dTm/5YhARH1lEcjzIuefxsbQyMtwlep4tAITtm8HMJIR9YhBVz5qF/WDTWHODRqqWwT4rTywvoS6Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IAm7fp5H; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=InU7kZnMvH+2htqE80SbtGYz6ogr7Y4Y2dAboclJyug=; b=IAm7fp5HNoIdadPiFUpZm+Um/P
	R1hRp8upfWS+kB16FBhqScSMQOazm6rwCl7Bb3ui9OaITPFo9Wjr8g5Org3lFm1E215ipPAT73OWU
	vutu8lSVqFnCJxA3rSsyCctKFqRoFqXlOnEEmwFnOOKQ6Se70nssKVlNDHnsmwZpHu7pdkLfFQMQu
	CnDgpJQ91d/voRaCprOUOC+ymoM0J0eE4sYXLXRSi+6H3veVa4fzvVCCnAYLh3kvftpVzktxidp73
	/oFxouKCmlYFWSTISNLS8PoJ+o+BD4FEDTYx1UZxKaPXYj92ldJByRpmEmKMxN59tD0GraMD7fVG3
	eRAYRlrg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33120 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uPLwp-00064V-0W;
	Wed, 11 Jun 2025 14:56:59 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uPLwB-003VzR-4C; Wed, 11 Jun 2025 14:56:19 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: phy: simplify phy_get_internal_delay()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uPLwB-003VzR-4C@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 11 Jun 2025 14:56:19 +0100

Simplify the arguments passed to phy_get_internal_delay() - the "dev"
argument is always &phydev->mdio.dev, and as the phydev is passed in,
there's no need to also pass in the struct device, especially when this
function is the only reason for the caller to have a local "dev"
variable.

Remove the redundant "dev" argument, and update the callers.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/dp83822.c        | 7 ++-----
 drivers/net/phy/dp83869.c        | 7 +++----
 drivers/net/phy/intel-xway.c     | 7 ++-----
 drivers/net/phy/mscc/mscc_main.c | 5 ++---
 drivers/net/phy/phy_device.c     | 6 +++---
 include/linux/phy.h              | 4 ++--
 6 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 01255dada600..33db21251f2e 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -516,7 +516,6 @@ static int dp83822_config_init_leds(struct phy_device *phydev)
 static int dp83822_config_init(struct phy_device *phydev)
 {
 	struct dp83822_private *dp83822 = phydev->priv;
-	struct device *dev = &phydev->mdio.dev;
 	int rgmii_delay = 0;
 	s32 rx_int_delay;
 	s32 tx_int_delay;
@@ -549,15 +548,13 @@ static int dp83822_config_init(struct phy_device *phydev)
 		return err;
 
 	if (phy_interface_is_rgmii(phydev)) {
-		rx_int_delay = phy_get_internal_delay(phydev, dev, NULL, 0,
-						      true);
+		rx_int_delay = phy_get_internal_delay(phydev, NULL, 0, true);
 
 		/* Set DP83822_RX_CLK_SHIFT to enable rx clk internal delay */
 		if (rx_int_delay > 0)
 			rgmii_delay |= DP83822_RX_CLK_SHIFT;
 
-		tx_int_delay = phy_get_internal_delay(phydev, dev, NULL, 0,
-						      false);
+		tx_int_delay = phy_get_internal_delay(phydev, NULL, 0, false);
 
 		/* Set DP83822_TX_CLK_SHIFT to disable tx clk internal delay */
 		if (tx_int_delay <= 0)
diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index a62cd838a9ea..a2cd1cc35cde 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -540,9 +540,8 @@ static const int dp83869_internal_delay[] = {250, 500, 750, 1000, 1250, 1500,
 
 static int dp83869_of_init(struct phy_device *phydev)
 {
+	struct device_node *of_node = phydev->mdio.dev.of_node;
 	struct dp83869_private *dp83869 = phydev->priv;
-	struct device *dev = &phydev->mdio.dev;
-	struct device_node *of_node = dev->of_node;
 	int delay_size = ARRAY_SIZE(dp83869_internal_delay);
 	int ret;
 
@@ -597,13 +596,13 @@ static int dp83869_of_init(struct phy_device *phydev)
 				 &dp83869->tx_fifo_depth))
 		dp83869->tx_fifo_depth = DP83869_PHYCR_FIFO_DEPTH_4_B_NIB;
 
-	dp83869->rx_int_delay = phy_get_internal_delay(phydev, dev,
+	dp83869->rx_int_delay = phy_get_internal_delay(phydev,
 						       &dp83869_internal_delay[0],
 						       delay_size, true);
 	if (dp83869->rx_int_delay < 0)
 		dp83869->rx_int_delay = DP83869_CLK_DELAY_DEF;
 
-	dp83869->tx_int_delay = phy_get_internal_delay(phydev, dev,
+	dp83869->tx_int_delay = phy_get_internal_delay(phydev,
 						       &dp83869_internal_delay[0],
 						       delay_size, false);
 	if (dp83869->tx_int_delay < 0)
diff --git a/drivers/net/phy/intel-xway.c b/drivers/net/phy/intel-xway.c
index a44771e8acdc..9766dd99afaa 100644
--- a/drivers/net/phy/intel-xway.c
+++ b/drivers/net/phy/intel-xway.c
@@ -174,7 +174,6 @@ static const int xway_internal_delay[] = {0, 500, 1000, 1500, 2000, 2500,
 
 static int xway_gphy_rgmii_init(struct phy_device *phydev)
 {
-	struct device *dev = &phydev->mdio.dev;
 	unsigned int delay_size = ARRAY_SIZE(xway_internal_delay);
 	s32 int_delay;
 	int val = 0;
@@ -207,8 +206,7 @@ static int xway_gphy_rgmii_init(struct phy_device *phydev)
 
 	if (phydev->interface == PHY_INTERFACE_MODE_RGMII_ID ||
 	    phydev->interface == PHY_INTERFACE_MODE_RGMII_RXID) {
-		int_delay = phy_get_internal_delay(phydev, dev,
-						   xway_internal_delay,
+		int_delay = phy_get_internal_delay(phydev, xway_internal_delay,
 						   delay_size, true);
 
 		/* if rx-internal-delay-ps is missing, use default of 2.0 ns */
@@ -220,8 +218,7 @@ static int xway_gphy_rgmii_init(struct phy_device *phydev)
 
 	if (phydev->interface == PHY_INTERFACE_MODE_RGMII_ID ||
 	    phydev->interface == PHY_INTERFACE_MODE_RGMII_TXID) {
-		int_delay = phy_get_internal_delay(phydev, dev,
-						   xway_internal_delay,
+		int_delay = phy_get_internal_delay(phydev, xway_internal_delay,
 						   delay_size, false);
 
 		/* if tx-internal-delay-ps is missing, use default of 2.0 ns */
diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 7ff975efd8e7..7ed6522fb0ef 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -530,7 +530,6 @@ static int vsc85xx_update_rgmii_cntl(struct phy_device *phydev, u32 rgmii_cntl,
 	u16 rgmii_rx_delay_pos = ffs(rgmii_rx_delay_mask) - 1;
 	u16 rgmii_tx_delay_pos = ffs(rgmii_tx_delay_mask) - 1;
 	int delay_size = ARRAY_SIZE(vsc85xx_internal_delay);
-	struct device *dev = &phydev->mdio.dev;
 	u16 reg_val = 0;
 	u16 mask = 0;
 	s32 rx_delay;
@@ -549,7 +548,7 @@ static int vsc85xx_update_rgmii_cntl(struct phy_device *phydev, u32 rgmii_cntl,
 	if (phy_interface_is_rgmii(phydev))
 		mask |= rgmii_rx_delay_mask | rgmii_tx_delay_mask;
 
-	rx_delay = phy_get_internal_delay(phydev, dev, vsc85xx_internal_delay,
+	rx_delay = phy_get_internal_delay(phydev, vsc85xx_internal_delay,
 					  delay_size, true);
 	if (rx_delay < 0) {
 		if (phydev->interface == PHY_INTERFACE_MODE_RGMII_RXID ||
@@ -559,7 +558,7 @@ static int vsc85xx_update_rgmii_cntl(struct phy_device *phydev, u32 rgmii_cntl,
 			rx_delay = RGMII_CLK_DELAY_0_2_NS;
 	}
 
-	tx_delay = phy_get_internal_delay(phydev, dev, vsc85xx_internal_delay,
+	tx_delay = phy_get_internal_delay(phydev, vsc85xx_internal_delay,
 					  delay_size, false);
 	if (tx_delay < 0) {
 		if (phydev->interface == PHY_INTERFACE_MODE_RGMII_TXID ||
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 73f9cb2e2844..ebcfd80032fa 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2899,7 +2899,6 @@ static int phy_get_u32_property(struct device *dev, const char *name, u32 *val)
 /**
  * phy_get_internal_delay - returns the index of the internal delay
  * @phydev: phy_device struct
- * @dev: pointer to the devices device struct
  * @delay_values: array of delays the PHY supports
  * @size: the size of the delay array
  * @is_rx: boolean to indicate to get the rx internal delay
@@ -2912,9 +2911,10 @@ static int phy_get_u32_property(struct device *dev, const char *name, u32 *val)
  * array then size = 0 and the value of the delay property is returned.
  * Return -EINVAL if the delay is invalid or cannot be found.
  */
-s32 phy_get_internal_delay(struct phy_device *phydev, struct device *dev,
-			   const int *delay_values, int size, bool is_rx)
+s32 phy_get_internal_delay(struct phy_device *phydev, const int *delay_values,
+			   int size, bool is_rx)
 {
+	struct device *dev = &phydev->mdio.dev;
 	int i, ret;
 	u32 delay;
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index e194dad1623d..b95e3b8eba26 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1997,8 +1997,8 @@ bool phy_validate_pause(struct phy_device *phydev,
 			struct ethtool_pauseparam *pp);
 void phy_get_pause(struct phy_device *phydev, bool *tx_pause, bool *rx_pause);
 
-s32 phy_get_internal_delay(struct phy_device *phydev, struct device *dev,
-			   const int *delay_values, int size, bool is_rx);
+s32 phy_get_internal_delay(struct phy_device *phydev, const int *delay_values,
+			   int size, bool is_rx);
 
 int phy_get_tx_amplitude_gain(struct phy_device *phydev, struct device *dev,
 			      enum ethtool_link_mode_bit_indices linkmode,
-- 
2.30.2


