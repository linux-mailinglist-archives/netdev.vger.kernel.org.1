Return-Path: <netdev+bounces-161366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51104A20D76
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27EF47A274B
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B4C1D63EE;
	Tue, 28 Jan 2025 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="k5YO3aGZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE731D5ABF
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079254; cv=none; b=SGVg0h3T6J5UbLhpWuPIitk8PT53VIVBU4r73URLX5WIWi8YQ3lYpzVhbIJO+Ce1plSwbt7Bz6e7ZBfr5ZOWvIe8BVqYrJRubv+VuBYW11qt38sex/LrFF78Kf5UKtGpiVdzIagoWL5BykhcjgFCvXJZHjmfIKjP2NQzMQFQ5EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079254; c=relaxed/simple;
	bh=9aDK12uVpD9nLVH3wKJNwmFuy6LplT73i8Ct0ttTEh0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=hniKD+ER1SiEwQeLPcctSV6rTUkCFJgBcbUnivdmAtu0rfJKx5NWy7869p2dovmEP/s2OCMiJ+x9Vs7OwNgaDrL67MPT83XB0t8RLOWfy2wr7RQ9L2Sv6QUwApUei2lqPfl1K5ihzZT9v0yaGe4RSm4QOxOylkhMyofBCirz2Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=k5YO3aGZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LgK/r5nGV4DprNay2NXmi2Nhjdf4AdIUiVGgxoFQbKs=; b=k5YO3aGZ8PjsfbnHRZrIDIu+wY
	do+UB2/szY3EgTFPxe/cJaanODaSbwqz4aFpFpA1TR8j98+yn3ncCZBdYqDcJzhKb65Tc126j+9o1
	yKWqGCX17T8FflV6WIcGuPv6DvVNtGOuLjHDDnLvQY91TXs9uDqZbI1Z+2F79g7q+XX+keaXssC0R
	HCZMpkG2DnOt+h6/f7jTDVfj13zWfVkUdPY+Qsh+0V3Kh7NmUt8ErY2Xc3c1MGOe9/UhO5z+VmHdV
	gg6auK9/DBkq0pN0vBwZmytE4tQXixA0X5anfm7WBI3gz3HfCQUZ9Gt87oGMAbB0LptZaKBVTI/Bn
	dNTXdPoQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41974 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tcnoC-0007Te-32;
	Tue, 28 Jan 2025 15:47:25 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tcnnt-0037GQ-Ay; Tue, 28 Jan 2025 15:47:05 +0000
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
Subject: [PATCH RFC net-next 04/22] net: stmmac: split stmmac_init_eee() and
 move to phylink methods
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tcnnt-0037GQ-Ay@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 Jan 2025 15:47:05 +0000

Move the appropriate parts of stmmac_init_eee() into the phylink
mac_enable_tx_lpi() and mac_disable_tx_lpi() methods.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 133 +++++++++---------
 1 file changed, 63 insertions(+), 70 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index e6a6aaa74185..3a0f1003f7a8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -466,74 +466,6 @@ static void stmmac_eee_ctrl_timer(struct timer_list *t)
 	stmmac_try_to_start_sw_lpi(priv);
 }
 
-/**
- * stmmac_eee_init - init EEE
- * @priv: driver private structure
- * @active: indicates whether EEE should be enabled.
- * Description:
- *  if the GMAC supports the EEE (from the HW cap reg) and the phy device
- *  can also manage EEE, this function enable the LPI state and start related
- *  timer.
- */
-static void stmmac_eee_init(struct stmmac_priv *priv, bool active)
-{
-	priv->eee_active = active;
-
-	/* Check if MAC core supports the EEE feature. */
-	if (!priv->dma_cap.eee) {
-		priv->eee_enabled = false;
-		return;
-	}
-
-	mutex_lock(&priv->lock);
-
-	/* Check if it needs to be deactivated */
-	if (!priv->eee_active) {
-		if (priv->eee_enabled) {
-			netdev_dbg(priv->dev, "disable EEE\n");
-			priv->eee_sw_timer_en = false;
-			del_timer_sync(&priv->eee_ctrl_timer);
-			stmmac_reset_eee_mode(priv, priv->hw);
-			stmmac_set_eee_timer(priv, priv->hw, 0,
-					     STMMAC_DEFAULT_TWT_LS);
-			if (priv->hw->xpcs)
-				xpcs_config_eee(priv->hw->xpcs,
-						priv->plat->mult_fact_100ns,
-						false);
-		}
-		priv->eee_enabled = false;
-		mutex_unlock(&priv->lock);
-		return;
-	}
-
-	if (priv->eee_active && !priv->eee_enabled) {
-		stmmac_set_eee_timer(priv, priv->hw, STMMAC_DEFAULT_LIT_LS,
-				     STMMAC_DEFAULT_TWT_LS);
-		if (priv->hw->xpcs)
-			xpcs_config_eee(priv->hw->xpcs,
-					priv->plat->mult_fact_100ns,
-					true);
-	}
-
-	if (priv->plat->has_gmac4 && priv->tx_lpi_timer <= STMMAC_ET_MAX) {
-		/* Use hardware LPI mode */
-		del_timer_sync(&priv->eee_ctrl_timer);
-		priv->tx_path_in_lpi_mode = false;
-		priv->eee_sw_timer_en = false;
-		stmmac_enable_hw_lpi_timer(priv);
-	} else {
-		/* Use software LPI mode */
-		priv->eee_sw_timer_en = true;
-		stmmac_disable_hw_lpi_timer(priv);
-		stmmac_restart_sw_lpi_timer(priv);
-	}
-
-	priv->eee_enabled = true;
-
-	mutex_unlock(&priv->lock);
-	netdev_dbg(priv->dev, "Energy-Efficient Ethernet initialized\n");
-}
-
 /* stmmac_get_tx_hwtstamp - get HW TX timestamps
  * @priv: driver private structure
  * @p : descriptor pointer
@@ -1110,7 +1042,33 @@ static void stmmac_mac_disable_tx_lpi(struct phylink_config *config)
 {
 	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
 
-	stmmac_eee_init(priv, false);
+	priv->eee_active = false;
+
+	/* Check if MAC core supports the EEE feature. */
+	if (!priv->dma_cap.eee) {
+		priv->eee_enabled = false;
+		return;
+	}
+
+	mutex_lock(&priv->lock);
+
+	/* Check if it needs to be deactivated */
+	if (!priv->eee_active) {
+		if (priv->eee_enabled) {
+			netdev_dbg(priv->dev, "disable EEE\n");
+			priv->eee_sw_timer_en = false;
+			del_timer_sync(&priv->eee_ctrl_timer);
+			stmmac_reset_eee_mode(priv, priv->hw);
+			stmmac_set_eee_timer(priv, priv->hw, 0,
+					     STMMAC_DEFAULT_TWT_LS);
+			if (priv->hw->xpcs)
+				xpcs_config_eee(priv->hw->xpcs,
+						priv->plat->mult_fact_100ns,
+						false);
+		}
+		priv->eee_enabled = false;
+	}
+	mutex_unlock(&priv->lock);
 }
 
 static int stmmac_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
@@ -1119,7 +1077,42 @@ static int stmmac_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
 	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
 
 	priv->tx_lpi_timer = timer;
-	stmmac_eee_init(priv, true);
+	priv->eee_active = true;
+
+	/* Check if MAC core supports the EEE feature. */
+	if (!priv->dma_cap.eee) {
+		priv->eee_enabled = false;
+		return 0;
+	}
+
+	mutex_lock(&priv->lock);
+
+	if (priv->eee_active && !priv->eee_enabled) {
+		stmmac_set_eee_timer(priv, priv->hw, STMMAC_DEFAULT_LIT_LS,
+				     STMMAC_DEFAULT_TWT_LS);
+		if (priv->hw->xpcs)
+			xpcs_config_eee(priv->hw->xpcs,
+					priv->plat->mult_fact_100ns,
+					true);
+	}
+
+	if (priv->plat->has_gmac4 && priv->tx_lpi_timer <= STMMAC_ET_MAX) {
+		/* Use hardware LPI mode */
+		del_timer_sync(&priv->eee_ctrl_timer);
+		priv->tx_path_in_lpi_mode = false;
+		priv->eee_sw_timer_en = false;
+		stmmac_enable_hw_lpi_timer(priv);
+	} else {
+		/* Use software LPI mode */
+		priv->eee_sw_timer_en = true;
+		stmmac_disable_hw_lpi_timer(priv);
+		stmmac_restart_sw_lpi_timer(priv);
+	}
+
+	priv->eee_enabled = true;
+
+	mutex_unlock(&priv->lock);
+	netdev_dbg(priv->dev, "Energy-Efficient Ethernet initialized\n");
 
 	return 0;
 }
-- 
2.30.2


