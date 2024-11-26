Return-Path: <netdev+bounces-147420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8C19D978B
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 13:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189F9285C24
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 12:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B131CEE8A;
	Tue, 26 Nov 2024 12:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sS4Cxvnm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A07194A66
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625570; cv=none; b=c26KMHnuFRyj67Dl1056qPVA/KpbfBaIyaZif4eG4gEVpXwkSZ0cFTvv9H79/zMtHojC2pLlyf0q3GhJXtRKUbtsdannEmQRQ76XiZM/a60oipJs2gXeIVt0eSI6cMe+39AFUyhaC5Mv1kMWOWGwCVwxN7FPvV+nAZ8UTeNJsOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625570; c=relaxed/simple;
	bh=xx2/lZSpGp5KSyJg+JHeX5N079amRK2k5eqgYvjGN1E=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=qPCcURm3/EUDs+v0xaPtF6b+bidVYYXptGkG294N5hIKN3jCaHX0VvodLZf3UN6bLNyotFI8IdS3wI3Gsv7AFag7EcFy+hZGb3JYXhXZNv8tF5AgBowFRE7vZehhHraczBmILyFNxjAjz58Q1swX+Mmvf9w53kCC1A6kWzBjrp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sS4Cxvnm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=htkUNxRy+25yNpYiExb+h1KBfZkYV1BFcj9vQ1NwO6o=; b=sS4CxvnmgCKMXA/9TSdqwrWcXp
	AH8lOWJXE1MM19qvFPLvNEfe3olq5sByFlFqR/Xy2M9ZrixCDc29ZJ3nZThexzZZHwiKsIlzyNa2y
	PX9jHlPGkJWyKyFod+qvKeB4Hfx+f4gD8miw0bDGmu/JL9dRTKDvyKQ5XnjEnvIHivMrr5dUqsnGD
	gxbDORMzI4m2JUD45JVunXirIvBnfoj7g6z7NLHGsGpkh2mJE83WuH8dE8DGtoKpfmWiW5AYmVdNy
	PVyY5fkfeYEXLuk12JTECuDG22W1RSrwon+YyYjofU0fH578O3tEu2Itc+MSLUVtTBY2m1pqtjS2D
	8p4n+Rqw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34380 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tFv3V-0006sb-2o;
	Tue, 26 Nov 2024 12:52:38 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tFv3U-005yhl-LJ; Tue, 26 Nov 2024 12:52:36 +0000
In-Reply-To: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
References: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
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
Subject: [PATCH RFC net-next 05/23] net: phy: remove
 genphy_c45_eee_is_active()'s is_enabled arg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tFv3U-005yhl-LJ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 26 Nov 2024 12:52:36 +0000

All callers to genphy_c45_eee_is_active() now pass NULL as the
is_enabled argument, which means we never use the value computed
in this function. Remove the argument and clean up this function.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy-c45.c | 11 ++++-------
 drivers/net/phy/phy.c     |  5 ++---
 include/linux/phy.h       |  2 +-
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index d162f78bc68d..e799e7ddd6fb 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1475,12 +1475,12 @@ EXPORT_SYMBOL_GPL(genphy_c45_plca_get_status);
  * advertisements. Compare them return current EEE state.
  */
 int genphy_c45_eee_is_active(struct phy_device *phydev, unsigned long *adv,
-			     unsigned long *lp, bool *is_enabled)
+			     unsigned long *lp)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp_adv) = {};
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp_lp) = {};
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
-	bool eee_enabled, eee_active;
+	bool eee_active;
 	int ret;
 
 	ret = genphy_c45_read_eee_adv(phydev, tmp_adv);
@@ -1491,9 +1491,8 @@ int genphy_c45_eee_is_active(struct phy_device *phydev, unsigned long *adv,
 	if (ret)
 		return ret;
 
-	eee_enabled = !linkmode_empty(tmp_adv);
 	linkmode_and(common, tmp_adv, tmp_lp);
-	if (eee_enabled && !linkmode_empty(common))
+	if (!linkmode_empty(tmp_adv) && !linkmode_empty(common))
 		eee_active = phy_check_valid(phydev->speed, phydev->duplex,
 					     common);
 	else
@@ -1503,8 +1502,6 @@ int genphy_c45_eee_is_active(struct phy_device *phydev, unsigned long *adv,
 		linkmode_copy(adv, tmp_adv);
 	if (lp)
 		linkmode_copy(lp, tmp_lp);
-	if (is_enabled)
-		*is_enabled = eee_enabled;
 
 	return eee_active;
 }
@@ -1524,7 +1521,7 @@ int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
 	int ret;
 
 	ret = genphy_c45_eee_is_active(phydev, data->advertised,
-				       data->lp_advertised, NULL);
+				       data->lp_advertised);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 0d20b534122b..18109f843e39 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -988,8 +988,7 @@ static int phy_check_link_status(struct phy_device *phydev)
 	if (phydev->link && phydev->state != PHY_RUNNING) {
 		phy_check_downshift(phydev);
 		phydev->state = PHY_RUNNING;
-		err = genphy_c45_eee_is_active(phydev,
-					       NULL, NULL, NULL);
+		err = genphy_c45_eee_is_active(phydev, NULL, NULL);
 		phydev->eee_active = err > 0;
 		phydev->enable_tx_lpi = phydev->eee_cfg.tx_lpi_enabled &&
 					phydev->eee_active;
@@ -1605,7 +1604,7 @@ int phy_init_eee(struct phy_device *phydev, bool clk_stop_enable)
 	if (!phydev->drv)
 		return -EIO;
 
-	ret = genphy_c45_eee_is_active(phydev, NULL, NULL, NULL);
+	ret = genphy_c45_eee_is_active(phydev, NULL, NULL);
 	if (ret < 0)
 		return ret;
 	if (!ret)
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 563c46205685..09a47116994c 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1957,7 +1957,7 @@ int genphy_c45_plca_set_cfg(struct phy_device *phydev,
 int genphy_c45_plca_get_status(struct phy_device *phydev,
 			       struct phy_plca_status *plca_st);
 int genphy_c45_eee_is_active(struct phy_device *phydev, unsigned long *adv,
-			     unsigned long *lp, bool *is_enabled);
+			     unsigned long *lp);
 int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
 			       struct ethtool_keee *data);
 int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
-- 
2.30.2


