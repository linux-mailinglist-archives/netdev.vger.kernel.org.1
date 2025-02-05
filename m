Return-Path: <netdev+bounces-163014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A06A28C07
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 14:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51CF8160896
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B633C1369A8;
	Wed,  5 Feb 2025 13:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oR0F+Qr/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C06B13A88A
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762842; cv=none; b=K5LNwRefkag/gZwRF6IxbAoXG9CArUdLf/Pcf1zgD4eNzxvt2J+O4wUWxB+3g8TL834H6UJZA0XYgEmklYy4FJFoqsN3Shl8owuKW3ex0tCSpULoDJvGFWnEzU4n35TG0Q+cYumgkYXWl24l/zN6bsmj2zBFVvdtJpZXmHG+YhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762842; c=relaxed/simple;
	bh=cejsSp3DOMbH4O8CqGYzIRYxMLp9/Vdl6tkZXH5JmP0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=YwlcvfKBgRtBElrZ/skjCscrp63mdgF3Ndoilr1iXGp4F0i/mYEHTEqDFx/1eyuZTj9PeyY7gx0NHyWYmY5K2OWanVw6bi2wFmjQIyrJRGqrEzj5xrNi1hYdTy4HjU3vsNApUTPckKD/YDCOz/zJc78IThCCLpzy7zPtAgBv2i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=oR0F+Qr/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7wzqVEG4YmhcZfFsDxnn0J/g7QtnEP23oOLAdp01iVs=; b=oR0F+Qr/FX41EyBCkqh5BDGZQH
	pgJPnC55/0iaRAD0jkEnCBcQH8roQU7OmkVUXRRIQGiN5m6TuzIg86w1iFj9k2wqneP2AY2yMmSLQ
	G2imYbim+1lHJ0lmBB68B/jzPhEsGaYoBnwMiHRL5uXizfbTEjHDarK9jV4mFnNTEOpcZkBlm1Y/U
	7ITYstp/6X8YU+d3c42Hg4iW/GBmAIf1mX7eBI7SDfK0/JjaKAKxmmvJ/OQspITZWcui4hFtVT0Ro
	9gXihcjSnteIp7thSZnH4S7rvIcp6zZOWOJp9vgzlBe7KYMsuZ1rm8tCnm1jAfpbBNqqWd2ftRMDk
	ZNnMFhpg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60762 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tffdr-0007BR-1W;
	Wed, 05 Feb 2025 13:40:35 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tffdX-003ZI5-UV; Wed, 05 Feb 2025 13:40:15 +0000
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
Subject: [PATCH net-next 07/14] net: stmmac: remove unnecessary
 priv->eee_enabled tests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tffdX-003ZI5-UV@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 05 Feb 2025 13:40:15 +0000

Phylink will not call the mac_disable_tx_lpi() and mac_enable_tx_lpi()
methods randomly - the first method to be called will be the enable
method, and then after, the disable method will be called once between
subsequent enable calls. Thus there is a guaranteed ordering.

Therefore, we know the previous state of priv->eee_enabled, and can
remove it from both methods.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 37 +++++++++----------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 6c8685c30022..695e75de41b3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1046,18 +1046,17 @@ static void stmmac_mac_disable_tx_lpi(struct phylink_config *config)
 
 	mutex_lock(&priv->lock);
 
-	/* Check if it needs to be deactivated */
-	if (priv->eee_enabled) {
-		netdev_dbg(priv->dev, "disable EEE\n");
-		priv->eee_sw_timer_en = false;
-		del_timer_sync(&priv->eee_ctrl_timer);
-		stmmac_reset_eee_mode(priv, priv->hw);
-		stmmac_set_eee_timer(priv, priv->hw, 0, STMMAC_DEFAULT_TWT_LS);
-		if (priv->hw->xpcs)
-			xpcs_config_eee(priv->hw->xpcs,
-					priv->plat->mult_fact_100ns, false);
-	}
 	priv->eee_enabled = false;
+
+	netdev_dbg(priv->dev, "disable EEE\n");
+	priv->eee_sw_timer_en = false;
+	del_timer_sync(&priv->eee_ctrl_timer);
+	stmmac_reset_eee_mode(priv, priv->hw);
+	stmmac_set_eee_timer(priv, priv->hw, 0, STMMAC_DEFAULT_TWT_LS);
+	if (priv->hw->xpcs)
+		xpcs_config_eee(priv->hw->xpcs, priv->plat->mult_fact_100ns,
+				false);
+
 	mutex_unlock(&priv->lock);
 }
 
@@ -1071,13 +1070,13 @@ static int stmmac_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
 
 	mutex_lock(&priv->lock);
 
-	if (!priv->eee_enabled) {
-		stmmac_set_eee_timer(priv, priv->hw, STMMAC_DEFAULT_LIT_LS,
-				     STMMAC_DEFAULT_TWT_LS);
-		if (priv->hw->xpcs)
-			xpcs_config_eee(priv->hw->xpcs,
-					priv->plat->mult_fact_100ns, true);
-	}
+	priv->eee_enabled = true;
+
+	stmmac_set_eee_timer(priv, priv->hw, STMMAC_DEFAULT_LIT_LS,
+			     STMMAC_DEFAULT_TWT_LS);
+	if (priv->hw->xpcs)
+		xpcs_config_eee(priv->hw->xpcs, priv->plat->mult_fact_100ns,
+				true);
 
 	if (priv->plat->has_gmac4 && priv->tx_lpi_timer <= STMMAC_ET_MAX) {
 		/* Use hardware LPI mode */
@@ -1092,8 +1091,6 @@ static int stmmac_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
 		stmmac_restart_sw_lpi_timer(priv);
 	}
 
-	priv->eee_enabled = true;
-
 	mutex_unlock(&priv->lock);
 	netdev_dbg(priv->dev, "Energy-Efficient Ethernet initialized\n");
 
-- 
2.30.2


