Return-Path: <netdev+bounces-150239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E50CB9E98B0
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 15:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A715D1886B04
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE8D1B040A;
	Mon,  9 Dec 2024 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="EfDHCf4d"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5D735946
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 14:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754240; cv=none; b=cL3FXjDC7TusrSuJZQuoKHKPjbfUbp1nCkIUQhXtTqRMon3gT0qtxTkApmtNmGRf+oudsrCnyfDd645OY1qMZuaB2SviZi0wLPYOMIgNXVNY+Sw8Og9RGvu5SCPLwAbTzb4jlDJ28H7MZfRAOt3jBJk2Tqv6L3rqqSRCwvHgMeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754240; c=relaxed/simple;
	bh=Ut+MLWeVVX3Tqn7k7kH8xDJedxquIquKyUy3HJ4NCRU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=mD3es7aOr/CLZdk6gbNfCCS1TdH1FGKyFvIVvYHFazX0oBxWQuZr0mqRdoOLYCmt6Fng7kfC+XMeRQWfwFRNj1c0N5e8kUDg0T5Mz7eOwn+xPcLGfAAS0848H819Vu3dpi9tYgg2ofTUvBqigbjpmJFSnhSLH+wDJqbZw/hQMrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=EfDHCf4d; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PzYT7uDGh6+XxHUfd7PRftdRV2iZfucndhng4hsZqTo=; b=EfDHCf4dII9PTtHLnWcU9A7xkN
	oKRIlUnGa+C68W4EDH7s3ZWSbIcAMkooDlvpewRDBohD1Lx8Gy9oMNzfR8ob36k+yFEoAFRjnaH8e
	qjdkqa4JEfbcRERYZ/4nG0Go5gbyexpo0kGXijFVCFR6vPJHNioTGG5QJtdejIxMZJYuVPw1D/8i3
	mZNKCWDlq8oy/xL293r1wMmgVaaYWiB5Ajh1a9tW0qBGAFrXRo04+mHdAYqdtn21lUs/KOHRJvZM/
	Aa1Q6NNor67MJczAoo8cGb4F9n31XT1Y8GJQYPwnTiqgzBh4b5yQT3PS3NNpAFO4XXnqJWucMBS2X
	Y/cKRPUA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59058 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tKefv-0000xk-1H;
	Mon, 09 Dec 2024 14:23:52 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tKefs-006SN1-PG; Mon, 09 Dec 2024 14:23:48 +0000
In-Reply-To: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
References: <Z1b9J-FihzJ4A6aQ@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next 07/10] net: mvneta: convert to phylink EEE
 implementation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tKefs-006SN1-PG@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 09 Dec 2024 14:23:48 +0000

Convert mvneta to use phylink's EEE implementation, which means we just
need to implement the two methods for LPI control, and adding the
initial configuration.

Disabling LPI requires clearing a single bit. Enabling LPI needs a full
configuration of several values, as the timer values are dependent on
the MAC operating speed.

As Armada 388 states that EEE is only supported in "SGMII" modes, mark
this in lpi_interfaces. Testing with RGMII on the Clearfog platform
indicates that the receive path fails to detect LPI over RGMII.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/marvell/mvneta.c | 127 ++++++++++++++++----------
 1 file changed, 79 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index fe6261b81540..2b0758c11664 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -284,8 +284,12 @@
 					  MVNETA_TXQ_BUCKET_REFILL_PERIOD))
 
 #define MVNETA_LPI_CTRL_0                        0x2cc0
+#define      MVNETA_LPI_CTRL_0_TS                (0xff << 8)
 #define MVNETA_LPI_CTRL_1                        0x2cc4
-#define      MVNETA_LPI_REQUEST_ENABLE           BIT(0)
+#define      MVNETA_LPI_CTRL_1_REQUEST_ENABLE    BIT(0)
+#define      MVNETA_LPI_CTRL_1_REQUEST_FORCE     BIT(1)
+#define      MVNETA_LPI_CTRL_1_MANUAL_MODE       BIT(2)
+#define      MVNETA_LPI_CTRL_1_TW                (0xfff << 4)
 #define MVNETA_LPI_CTRL_2                        0x2cc8
 #define MVNETA_LPI_STATUS                        0x2ccc
 
@@ -541,10 +545,6 @@ struct mvneta_port {
 	struct mvneta_bm_pool *pool_short;
 	int bm_win_id;
 
-	bool eee_enabled;
-	bool eee_active;
-	bool tx_lpi_enabled;
-
 	u64 ethtool_stats[ARRAY_SIZE(mvneta_statistics)];
 
 	u32 indir[MVNETA_RSS_LU_TABLE_SIZE];
@@ -1354,6 +1354,13 @@ static void mvneta_port_enable(struct mvneta_port *pp)
 	val = mvreg_read(pp, MVNETA_GMAC_CTRL_0);
 	val |= MVNETA_GMAC0_PORT_ENABLE;
 	mvreg_write(pp, MVNETA_GMAC_CTRL_0, val);
+
+	/* Ensure LPI is disabled */
+	val = mvreg_read(pp, MVNETA_LPI_CTRL_1);
+	val &= ~(MVNETA_LPI_CTRL_1_REQUEST_ENABLE |
+		 MVNETA_LPI_CTRL_1_REQUEST_FORCE |
+		 MVNETA_LPI_CTRL_1_MANUAL_MODE);
+	mvreg_write(pp, MVNETA_LPI_CTRL_1, val);
 }
 
 /* Disable the port and wait for about 200 usec before retuning */
@@ -4213,18 +4220,6 @@ static int mvneta_mac_finish(struct phylink_config *config, unsigned int mode,
 	return 0;
 }
 
-static void mvneta_set_eee(struct mvneta_port *pp, bool enable)
-{
-	u32 lpi_ctl1;
-
-	lpi_ctl1 = mvreg_read(pp, MVNETA_LPI_CTRL_1);
-	if (enable)
-		lpi_ctl1 |= MVNETA_LPI_REQUEST_ENABLE;
-	else
-		lpi_ctl1 &= ~MVNETA_LPI_REQUEST_ENABLE;
-	mvreg_write(pp, MVNETA_LPI_CTRL_1, lpi_ctl1);
-}
-
 static void mvneta_mac_link_down(struct phylink_config *config,
 				 unsigned int mode, phy_interface_t interface)
 {
@@ -4240,9 +4235,6 @@ static void mvneta_mac_link_down(struct phylink_config *config,
 		val |= MVNETA_GMAC_FORCE_LINK_DOWN;
 		mvreg_write(pp, MVNETA_GMAC_AUTONEG_CONFIG, val);
 	}
-
-	pp->eee_active = false;
-	mvneta_set_eee(pp, false);
 }
 
 static void mvneta_mac_link_up(struct phylink_config *config,
@@ -4291,11 +4283,61 @@ static void mvneta_mac_link_up(struct phylink_config *config,
 	}
 
 	mvneta_port_up(pp);
+}
+
+static int mvneta_mac_validate_tx_lpi(struct phylink_config *config,
+				      struct ethtool_keee *eee)
+{
+	if (eee->tx_lpi_timer > 255)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void mvneta_mac_disable_tx_lpi(struct phylink_config *config)
+{
+	struct mvneta_port *pp = netdev_priv(to_net_dev(config->dev));
+	u32 lpi1;
+
+	lpi1 = mvreg_read(pp, MVNETA_LPI_CTRL_1);
+	lpi1 &= ~MVNETA_LPI_CTRL_1_REQUEST_ENABLE;
+	mvreg_write(pp, MVNETA_LPI_CTRL_1, lpi1);
+}
 
-	if (phy && pp->eee_enabled) {
-		pp->eee_active = phy_init_eee(phy, false) >= 0;
-		mvneta_set_eee(pp, pp->eee_active && pp->tx_lpi_enabled);
+static void mvneta_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
+				     bool tx_clk_stop)
+{
+	struct mvneta_port *pp = netdev_priv(to_net_dev(config->dev));
+	u32 ts, tw, lpi0, lpi1, status;
+
+	status = mvreg_read(pp, MVNETA_GMAC_STATUS);
+	if (status & MVNETA_GMAC_SPEED_1000) {
+		/* At 1G speeds, the timer resolution are 1us, and
+		 * 802.3 says tw is 16.5us. Round up to 17us.
+		 */
+		tw = 17;
+		ts = timer;
+	} else {
+		/* At 100M speeds, the timer resolutions are 10us, and
+		 * 802.3 says tw is 30us.
+		 */
+		tw = 3;
+		ts = DIV_ROUND_UP(timer, 10);
 	}
+
+	if (ts > 255)
+		ts = 255;
+
+	/* Configure ts */
+	lpi0 = mvreg_read(pp, MVNETA_LPI_CTRL_0);
+	lpi0 = u32_replace_bits(lpi0, MVNETA_LPI_CTRL_0_TS, ts);
+	mvreg_write(pp, MVNETA_LPI_CTRL_0, lpi0);
+
+	/* Configure tw and enable LPI generation */
+	lpi1 = mvreg_read(pp, MVNETA_LPI_CTRL_1);
+	lpi1 = u32_replace_bits(lpi1, MVNETA_LPI_CTRL_1_TW, tw);
+	lpi1 |= MVNETA_LPI_CTRL_1_REQUEST_ENABLE;
+	mvreg_write(pp, MVNETA_LPI_CTRL_1, lpi1);
 }
 
 static const struct phylink_mac_ops mvneta_phylink_ops = {
@@ -4305,6 +4347,9 @@ static const struct phylink_mac_ops mvneta_phylink_ops = {
 	.mac_finish = mvneta_mac_finish,
 	.mac_link_down = mvneta_mac_link_down,
 	.mac_link_up = mvneta_mac_link_up,
+	.mac_validate_tx_lpi = mvneta_mac_validate_tx_lpi,
+	.mac_disable_tx_lpi = mvneta_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = mvneta_mac_enable_tx_lpi,
 };
 
 static int mvneta_mdio_probe(struct mvneta_port *pp)
@@ -5106,14 +5151,6 @@ static int mvneta_ethtool_get_eee(struct net_device *dev,
 				  struct ethtool_keee *eee)
 {
 	struct mvneta_port *pp = netdev_priv(dev);
-	u32 lpi_ctl0;
-
-	lpi_ctl0 = mvreg_read(pp, MVNETA_LPI_CTRL_0);
-
-	eee->eee_enabled = pp->eee_enabled;
-	eee->eee_active = pp->eee_active;
-	eee->tx_lpi_enabled = pp->tx_lpi_enabled;
-	eee->tx_lpi_timer = (lpi_ctl0) >> 8; // * scale;
 
 	return phylink_ethtool_get_eee(pp->phylink, eee);
 }
@@ -5122,23 +5159,6 @@ static int mvneta_ethtool_set_eee(struct net_device *dev,
 				  struct ethtool_keee *eee)
 {
 	struct mvneta_port *pp = netdev_priv(dev);
-	u32 lpi_ctl0;
-
-	/* The Armada 37x documents do not give limits for this other than
-	 * it being an 8-bit register.
-	 */
-	if (eee->tx_lpi_enabled && eee->tx_lpi_timer > 255)
-		return -EINVAL;
-
-	lpi_ctl0 = mvreg_read(pp, MVNETA_LPI_CTRL_0);
-	lpi_ctl0 &= ~(0xff << 8);
-	lpi_ctl0 |= eee->tx_lpi_timer << 8;
-	mvreg_write(pp, MVNETA_LPI_CTRL_0, lpi_ctl0);
-
-	pp->eee_enabled = eee->eee_enabled;
-	pp->tx_lpi_enabled = eee->tx_lpi_enabled;
-
-	mvneta_set_eee(pp, eee->tx_lpi_enabled && eee->eee_enabled);
 
 	return phylink_ethtool_set_eee(pp->phylink, eee);
 }
@@ -5453,6 +5473,9 @@ static int mvneta_port_power_up(struct mvneta_port *pp, int phy_mode)
 	    !phy_interface_mode_is_rgmii(phy_mode))
 		return -EINVAL;
 
+	/* Ensure LPI is disabled */
+	mvneta_mac_disable_tx_lpi(&pp->phylink_config);
+
 	return 0;
 }
 
@@ -5544,6 +5567,14 @@ static int mvneta_probe(struct platform_device *pdev)
 	pp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_10 |
 		MAC_100 | MAC_1000FD | MAC_2500FD;
 
+	/* Setup EEE. Choose 250us idle. Only supported in SGMII modes. */
+	__set_bit(PHY_INTERFACE_MODE_QSGMII, pp->phylink_config.lpi_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_SGMII, pp->phylink_config.lpi_interfaces);
+	pp->phylink_config.lpi_capabilities = MAC_100FD | MAC_1000FD;
+	pp->phylink_config.lpi_timer_limit_us = 255;
+	pp->phylink_config.lpi_timer_default = 250;
+	pp->phylink_config.eee_enabled_default = true;
+
 	phy_interface_set_rgmii(pp->phylink_config.supported_interfaces);
 	__set_bit(PHY_INTERFACE_MODE_QSGMII,
 		  pp->phylink_config.supported_interfaces);
-- 
2.30.2


