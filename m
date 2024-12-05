Return-Path: <netdev+bounces-149338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B289E52CE
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 11:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7F47188330F
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496BC1DB522;
	Thu,  5 Dec 2024 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eBRC8yQI"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5431DACB4
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395339; cv=none; b=Y79geJY5wVECenb13k54eOkdEf1PxzNXERgoL6h0Qb8+46UEglmSnpoD/PAn1nE7iSrSaOzL++rqnTkKd/o1wJ+JIUxcRnvUS+YvwGuN7SiYfcP8HQ5UcEDIMHI40XGSGKJa513vt4bopuOwRUqO7pG9mYfvZqLAgCmRA6laRtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395339; c=relaxed/simple;
	bh=Z8dVb7PQh+/j9vqPHeU3QvbZP9RM1sHPxW7C7kAitQE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=lX87vcXOKYKgVOfvjGQbHXhLBgMwHJL8JdsX7trrYNcKNtxGXwcq9AQUONAyeOSKB+MzZfHtk8YRLmTr5AsU5YMMz5DuAnmbp5CaBWU2afHIosTVLe1+KdsMMA1hGP4BZXeI+Bnunub/ire4IjyolM2cWsNjBR4piTyzGVTf6lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eBRC8yQI; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=c2LJfvkzD/VnijV/Xs/l2poh37UqryOMbSV3oj4cHwo=; b=eBRC8yQIqnlY2eenL2QYS8TT2v
	hdeknWCbE52K9C4LctSE1rCumT/57QEld8jhpj0vWAcsbgBXvcMgW8+pLIGjzmZQYKEHrSMQ3N7XV
	cFpLtNNk2RjVNftI6eJJiAg/Tmbk5BZy2QhILGempbZ0ViZrSdg03O0/3zdH7Y9On75cvQZxVGOZw
	90mZ9Ykgf09VTrhCNmaKVkh1seiW/9aGSTzW/aAkTdFtHQlM5UmtorOgkfxI0FRont+AOiW52MUQt
	3mEU5XotkEao70C9xm6oF6H0nEKV+2BFQBd5XmTkP8dw/2qG3b0QGK1crIMmxjVhDjyjh55ByFYeU
	bLmzVlsw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57666 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tJ9JD-0004Zx-2w;
	Thu, 05 Dec 2024 10:42:12 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tJ9JC-006LIt-Ne; Thu, 05 Dec 2024 10:42:10 +0000
In-Reply-To: <Z1GDZlFyF2fsFa3S@shell.armlinux.org.uk>
References: <Z1GDZlFyF2fsFa3S@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 3/4] net: phy: remove genphy_c45_eee_is_active()'s
 is_enabled arg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tJ9JC-006LIt-Ne@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 05 Dec 2024 10:42:10 +0000

All callers to genphy_c45_eee_is_active() now pass NULL as the
is_enabled argument, which means we never use the value computed
in this function. Remove the argument and clean up this function.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phy-c45.c | 12 ++++--------
 drivers/net/phy/phy.c     |  5 ++---
 include/linux/phy.h       |  2 +-
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index d162f78bc68d..0dac08e85304 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1469,18 +1469,17 @@ EXPORT_SYMBOL_GPL(genphy_c45_plca_get_status);
  * @phydev: target phy_device struct
  * @adv: variable to store advertised linkmodes
  * @lp: variable to store LP advertised linkmodes
- * @is_enabled: variable to store EEE enabled/disabled configuration value
  *
  * Description: this function will read local and link partner PHY
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
@@ -1491,9 +1490,8 @@ int genphy_c45_eee_is_active(struct phy_device *phydev, unsigned long *adv,
 	if (ret)
 		return ret;
 
-	eee_enabled = !linkmode_empty(tmp_adv);
 	linkmode_and(common, tmp_adv, tmp_lp);
-	if (eee_enabled && !linkmode_empty(common))
+	if (!linkmode_empty(tmp_adv) && !linkmode_empty(common))
 		eee_active = phy_check_valid(phydev->speed, phydev->duplex,
 					     common);
 	else
@@ -1503,8 +1501,6 @@ int genphy_c45_eee_is_active(struct phy_device *phydev, unsigned long *adv,
 		linkmode_copy(adv, tmp_adv);
 	if (lp)
 		linkmode_copy(lp, tmp_lp);
-	if (is_enabled)
-		*is_enabled = eee_enabled;
 
 	return eee_active;
 }
@@ -1524,7 +1520,7 @@ int genphy_c45_ethtool_get_eee(struct phy_device *phydev,
 	int ret;
 
 	ret = genphy_c45_eee_is_active(phydev, data->advertised,
-				       data->lp_advertised, NULL);
+				       data->lp_advertised);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 0c228aa18019..4cf344254237 100644
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
@@ -1658,7 +1657,7 @@ int phy_init_eee(struct phy_device *phydev, bool clk_stop_enable)
 	if (!phydev->drv)
 		return -EIO;
 
-	ret = genphy_c45_eee_is_active(phydev, NULL, NULL, NULL);
+	ret = genphy_c45_eee_is_active(phydev, NULL, NULL);
 	if (ret < 0)
 		return ret;
 	if (!ret)
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 61a1bc81f597..bb157136351e 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1991,7 +1991,7 @@ int genphy_c45_plca_set_cfg(struct phy_device *phydev,
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


