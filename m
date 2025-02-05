Return-Path: <netdev+bounces-163011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222EAA28C16
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 14:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 863417A4BEC
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2677C14884C;
	Wed,  5 Feb 2025 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hXSDb5Rz"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627A913D24D
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762828; cv=none; b=ivaoV6a2JV80q0SKwwlgoi7lKqcF7y1Z2q8zfdks78xR1cnPjbzBVTyrOcktRtFYN1WXPlj2j9LynppvvbnIuFe6n6CemFKV2NBY/ThJvjwZpSy6YDs4idrCSptqCMKIfSOKY6GB4xdccNNAhe+71a1BHMfKltpGhSNYpPFGAfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762828; c=relaxed/simple;
	bh=/M6/FWrdyBuEfmmfM1K8GlGoHEFIk/DpdVyL4NQP5Zg=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=HwNA4eaxPP6E26jotnDanffODu/VOLYKy7jGWI8lO+T2b82L9DPnibOMhbdrxUfX2hpDwHolrkpt4NCj6oeWyGv6OamrC6so9A4jEuSh/4ljdprGkcVFxQnPpxVWoz1Chxg2PVy96jsb2ARFJ0pBnR8TWfit8GKnzM3WNoqkTMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hXSDb5Rz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vaDFuiHoKMcPrOZiBb6rulduVuXzLC4QmK70UITNdZQ=; b=hXSDb5RzVOMORA7oA3m7Gk9yoJ
	sdnvxU1ei9G8Rc+Jk3gFM+WeLRJSD3PB2apF5WZNZphSfDoXImvadOtqQXEJxR6apNv4ylcZcgukB
	EcDa06geEagbKtYLCT59qxUu+O7WmsT3Iq6hdY0uMp6usEWS7+Bjhg+C2p0jqSghVFWrhUoujh3ii
	C44eXvFgnrRBycBdFMberHj+sKOntbTL3hqVF04VyGsb02xlmvlKOUo8C+VNoviBIRYHyKbHqXzGh
	DOUmu+6K/ToeVajL3XHAIl8N8DUsrdWsb9xmkGMPfnB8mvbzkF7EvkgYBYt8m8jkAsEzRGxi3bxhs
	MUJ2FmDQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58650 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tffdc-0007Ab-0X;
	Wed, 05 Feb 2025 13:40:20 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tffdI-003ZHn-Iz; Wed, 05 Feb 2025 13:40:00 +0000
In-Reply-To: <Z6NqGnM2yL7Ayo-T@shell.armlinux.org.uk>
References: <Z6NqGnM2yL7Ayo-T@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 04/14] net: stmmac: split stmmac_init_eee() and move
 to phylink methods
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tffdI-003ZHn-Iz@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 05 Feb 2025 13:40:00 +0000

Move the appropriate parts of stmmac_init_eee() into the phylink
mac_enable_tx_lpi() and mac_disable_tx_lpi() methods.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 133 +++++++++---------
 1 file changed, 63 insertions(+), 70 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index c0472738bc76..8f2624de592d 100644
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


