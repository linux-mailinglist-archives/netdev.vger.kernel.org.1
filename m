Return-Path: <netdev+bounces-147416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E839D9785
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 13:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7730C285DBF
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 12:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29941CD219;
	Tue, 26 Nov 2024 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="S9l0HvcP"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F311CCEDB
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625550; cv=none; b=N+MdlO9HB11he+fm+e2dGJfoiGAzKAKoGVLs5mtMKu6MWS1PBqYNYEJEcGzXEWQwOsU43de8Sovw8vVbr++XIWvb5oB3ZStTjETiu2y21uI7ClYzfJ0UGb0Qol/ZCgvsvZaA0DiVU1RqHxnOe/skPalUjVdp/VcmfxTbNXUnbGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625550; c=relaxed/simple;
	bh=K01WgapFgj3LkrmPgGFAAHBRveet/SM9yDFd17zQpmM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=p6TAuboaq+l284TbqaggC3lwKruNTuXPE2aS1pxudVho7tA2uM7+Fx+Vq9ZHViMV4D/DHbN5Kp6IrXS/ocrVOtcow6XOUNRFLwxVqAyES7yLqAp4zfWJQeSexvXMrk+RH6lh2Q642SVlaHVjF+mOG6yXbfDbPuA3jSLatZaooWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=S9l0HvcP; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ewcWKta31lG91xcQq92+On16j0uc/YUYtkOz+clhhTE=; b=S9l0HvcPZsCZSMq22SpifS8Mxr
	17I28VWmom3IYJatWLuJ65X1MVb6WxfJfy05hbEmXqYndZQ+ws6gsrVROz8Uif0AHfWSeqsXK3YLN
	VEzSzikqAMSJNLPNaEYUdQLACj1Hq9xLue5oVKEeGxk+l00rlMBYSesYELZTtf4fuF57Mp1nG9cB6
	Ams7aBScke1GucZr32o+lDys5SkTSopP4atJM7HmXNlNaTa+Zif5yfWAvhGC4OhWIZNGhdiJLqtV5
	13OxxQWe9IlYn5Qkn/K6MuE/3OuiUWkFyaRzIrUJw1FiJJciPrP2Zz1XqtdtuB79/5AmlLNqMQP9A
	RWC0PAbA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34402 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tFv3B-0006rS-0F;
	Tue, 26 Nov 2024 12:52:17 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tFv3A-005yhN-6R; Tue, 26 Nov 2024 12:52:16 +0000
In-Reply-To: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
References: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com
Subject: [PATCH RFC net-next 01/23] net: phy: ensure that
 genphy_c45_an_config_eee_aneg() sees new value of phydev->eee_cfg.eee_enabled
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tFv3A-005yhN-6R@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 26 Nov 2024 12:52:16 +0000

From: Heiner Kallweit <hkallweit1@gmail.com>

This is a follow-up to 41ffcd95015f ("net: phy: fix phylib's dual
eee_enabled") and resolves an issue with genphy_c45_an_config_eee_aneg()
(called from genphy_c45_ethtool_set_eee) not seeing the new value of
phydev->eee_cfg.eee_enabled.

Fixes: 49168d1980e2 ("net: phy: Add phy_support_eee() indicating MAC support EEE")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reported-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 4f3e742907cb..a660a80f34b7 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1672,7 +1672,7 @@ EXPORT_SYMBOL(phy_ethtool_get_eee);
  * phy_ethtool_set_eee_noneg - Adjusts MAC LPI configuration without PHY
  *			       renegotiation
  * @phydev: pointer to the target PHY device structure
- * @data: pointer to the ethtool_keee structure containing the new EEE settings
+ * @old_cfg: pointer to the eee_config structure containing the old EEE settings
  *
  * This function updates the Energy Efficient Ethernet (EEE) configuration
  * for cases where only the MAC's Low Power Idle (LPI) configuration changes,
@@ -1683,11 +1683,10 @@ EXPORT_SYMBOL(phy_ethtool_get_eee);
  * configuration.
  */
 static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
-				      struct ethtool_keee *data)
+				      const struct eee_config *old_cfg)
 {
-	if (phydev->eee_cfg.tx_lpi_enabled != data->tx_lpi_enabled ||
-	    phydev->eee_cfg.tx_lpi_timer != data->tx_lpi_timer) {
-		eee_to_eeecfg(&phydev->eee_cfg, data);
+	if (phydev->eee_cfg.tx_lpi_enabled != old_cfg->tx_lpi_enabled ||
+	    phydev->eee_cfg.tx_lpi_timer != old_cfg->tx_lpi_timer) {
 		phydev->enable_tx_lpi = eeecfg_mac_can_tx_lpi(&phydev->eee_cfg);
 		if (phydev->link) {
 			phydev->link = false;
@@ -1707,18 +1706,23 @@ static void phy_ethtool_set_eee_noneg(struct phy_device *phydev,
  */
 int phy_ethtool_set_eee(struct phy_device *phydev, struct ethtool_keee *data)
 {
+	struct eee_config old_cfg;
 	int ret;
 
 	if (!phydev->drv)
 		return -EIO;
 
 	mutex_lock(&phydev->lock);
+
+	old_cfg = phydev->eee_cfg;
+	eee_to_eeecfg(&phydev->eee_cfg, data);
+
 	ret = genphy_c45_ethtool_set_eee(phydev, data);
-	if (ret >= 0) {
-		if (ret == 0)
-			phy_ethtool_set_eee_noneg(phydev, data);
-		eee_to_eeecfg(&phydev->eee_cfg, data);
-	}
+	if (ret == 0)
+		phy_ethtool_set_eee_noneg(phydev, &old_cfg);
+	else if (ret < 0)
+		phydev->eee_cfg = old_cfg;
+
 	mutex_unlock(&phydev->lock);
 
 	return ret < 0 ? ret : 0;
-- 
2.30.2


