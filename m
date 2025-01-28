Return-Path: <netdev+bounces-161375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5716CA20D8E
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F7D3A8FED
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BB71D5ADA;
	Tue, 28 Jan 2025 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="X/7G3ku2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D121D47B4
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079300; cv=none; b=j8oKrpoxEd5nl5jtPn9DF7TYdb6wd6SfsEqOn3y5RXE/J2eiGxdF0U5PLz24X1akZnnknFldv/LolicdzzNX0FoWefcByyIauBJkHLlt0HKzb7h1rjlUrrEMtKZcfvDBrJ7A6Dkb4wQn+Av4a2u9c0QfjpbRYjOo2oqEAhb5hRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079300; c=relaxed/simple;
	bh=Sz+v0KIS0xejJ8s+pO17deHQGwg7ZoRS5a5YW/z/gSI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=OSama2n73hmetgw1mXQdm/jZDsqITHbe/BvzRy7yIhvmCgi3LB7/1kF4BrqSPiCQBEZUC3dux22fe8+Az6dzJNtdFZMta+dC8TB0wakhtt1sN/tWVBaHaVWith+Bm6LlAxDFwoylA5LEVceBSVkjyLCsqHROTYz45laP2T0soUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=X/7G3ku2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TiDJSvJNzK27YwKwilomGm2u5RweY/NCsbPGAL9OV2I=; b=X/7G3ku2yXh8QSbbTwmW+wYkcp
	UPyJnO9Xj1Hkbq82GIq4vdZkqgwOH56Y2+Q4UjSp2EwHuLvfnEvuSf17f9c33TqiHPVCIU01sLn4o
	HsCyZMCXAE/ovdye2juvZvowFaN8m8BnHMPSfBjtB7DY6EDvV7pzTIWzWzUmIjcGGOj7cGAfQiu0I
	+y2rHotrK+Ub/8cyRWmb8e7qyVpoTebEg1uwOjiGFQ+uUl6dMC5owdeli8ws1PUThlNDIwgfMgelx
	jgxBVLqWiGpFU7RYOTBOFd8VDksHUeWhMS8seEw5zT21yETbhxjHfRBtS3a327DI91d5pGS4aYnN6
	OXKgEGIA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50184 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tcnow-0007WB-2K;
	Tue, 28 Jan 2025 15:48:10 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tcnod-0037HK-Di; Tue, 28 Jan 2025 15:47:51 +0000
In-Reply-To: <Z5j7yCYSsQ7beznD@shell.armlinux.org.uk>
References: <Z5j7yCYSsQ7beznD@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	 Vladimir Oltean <olteanv@gmail.com>,
	 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH RFC net-next 13/22] net: stmmac: use stmmac_set_lpi_mode()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tcnod-0037HK-Di@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 Jan 2025 15:47:51 +0000

Use the new stmmac_set_lpi_mode() API to configure the parameters of
the desired LPI mode rather than the older methods.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 29 ++++++++++---------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index aafd9cee304e..5b47b2ad6b49 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -390,11 +390,6 @@ static inline u32 stmmac_rx_dirty(struct stmmac_priv *priv, u32 queue)
 	return dirty;
 }
 
-static void stmmac_enable_hw_lpi_timer(struct stmmac_priv *priv)
-{
-	stmmac_set_eee_lpi_timer(priv, priv->hw, priv->tx_lpi_timer);
-}
-
 static bool stmmac_eee_tx_busy(struct stmmac_priv *priv)
 {
 	u32 tx_cnt = priv->plat->tx_queues_to_use;
@@ -431,8 +426,9 @@ static void stmmac_try_to_start_sw_lpi(struct stmmac_priv *priv)
 
 	/* Check and enter in LPI mode */
 	if (!priv->tx_path_in_lpi_mode)
-		stmmac_set_eee_mode(priv, priv->hw,
-			priv->plat->flags & STMMAC_FLAG_EN_TX_LPI_CLOCKGATING);
+		stmmac_set_lpi_mode(priv, priv->hw, STMMAC_LPI_FORCED,
+			priv->plat->flags & STMMAC_FLAG_EN_TX_LPI_CLOCKGATING,
+			0);
 }
 
 /**
@@ -443,7 +439,7 @@ static void stmmac_try_to_start_sw_lpi(struct stmmac_priv *priv)
 static void stmmac_stop_sw_lpi(struct stmmac_priv *priv)
 {
 	del_timer_sync(&priv->eee_ctrl_timer);
-	stmmac_reset_eee_mode(priv, priv->hw);
+	stmmac_set_lpi_mode(priv, priv->hw, STMMAC_LPI_DISABLE, false, 0);
 	priv->tx_path_in_lpi_mode = false;
 }
 
@@ -1046,7 +1042,7 @@ static void stmmac_mac_disable_tx_lpi(struct phylink_config *config)
 	netdev_dbg(priv->dev, "disable EEE\n");
 	priv->eee_sw_timer_en = false;
 	del_timer_sync(&priv->eee_ctrl_timer);
-	stmmac_reset_eee_mode(priv, priv->hw);
+	stmmac_set_lpi_mode(priv, priv->hw, STMMAC_LPI_DISABLE, false, 0);
 	priv->tx_path_in_lpi_mode = false;
 
 	stmmac_set_eee_timer(priv, priv->hw, 0, STMMAC_DEFAULT_TWT_LS);
@@ -1061,6 +1057,7 @@ static int stmmac_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
 				    bool tx_clk_stop)
 {
 	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
+	int ret;
 
 	priv->tx_lpi_timer = timer;
 	priv->eee_active = true;
@@ -1075,11 +1072,15 @@ static int stmmac_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
 		xpcs_config_eee(priv->hw->xpcs, priv->plat->mult_fact_100ns,
 				true);
 
-	if (priv->plat->has_gmac4 && priv->tx_lpi_timer <= STMMAC_ET_MAX) {
-		/* Use hardware LPI mode */
-		stmmac_enable_hw_lpi_timer(priv);
-	} else {
-		/* Use software LPI mode */
+	/* Try to cnfigure the hardware timer. */
+	ret = stmmac_set_lpi_mode(priv, priv->hw, STMMAC_LPI_TIMER,
+				  priv->plat->flags & STMMAC_FLAG_EN_TX_LPI_CLOCKGATING,
+				  priv->tx_lpi_timer);
+
+	if (ret) {
+		/* Hardware timer mode not supported, or value out of range.
+		 * Fall back to using software LPI mode
+		 */
 		priv->eee_sw_timer_en = true;
 		stmmac_restart_sw_lpi_timer(priv);
 	}
-- 
2.30.2


