Return-Path: <netdev+bounces-230476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92306BE8843
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 14:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA8A1AA3D44
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 12:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5D231A54C;
	Fri, 17 Oct 2025 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="k8t5dy3e"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7800D2E3703
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760702718; cv=none; b=l+UIFCMLmCocrc+9G93d+/GR9zuNOcAAUW1Jax3rfjHmKx4YPQWSkpRzJtTiFcSdvELE5D9mUGIB2y2qgE9n22f5zA++ucgaMdyL7lGM42+zB15XHz55xWI6LindXAxz5tkV3zxgPhadjbmJY8aaMLnwW7Ajssk6BFXDsT53zCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760702718; c=relaxed/simple;
	bh=fdL93DmxElklhlVWWwfffOYfAPM3jQapiHszf1pi3P4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=G6DLOgEfUegxjM+9ztb6m+eRA3qiwZuTstI015L2as9G4hkG2aWadZwgbeIDGGf9eZYIV1NAnjuCgqsNQpbvywjexg4bBJo3+C9dESwoRdkpDhaussWI0hhdslQ6SwqfDOpJPaU+xuSMiHLA+k9WWv55pP04yMHNVQZhUU4Cp7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=k8t5dy3e; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OVeV+IrXJ8udDN+U5jGslpXCLkKrBRG10dtlatjAyUY=; b=k8t5dy3e9Cg5CuTe04459tm7qP
	61MP0dVtuRJTCyC6E6aB+RWJ3A0ptisEe//wdHxSgxIXNEWyAcIqgMBDl2Okdrancpq8o+BIa1qHv
	uNWJdPEscN4pclWq1eZWouJzfrz5DWSUvCns/dZey39/AYrMdaZXUJK0TDhavptCQVFGLrIl+Rh8Y
	s7akLvJNiTOXcREndA+E5uQzufknjEOsuJp6T5dZI/f9IyoeFJ2itkWtByYAGUhjWU7eM+mnL5d9Q
	R1VvruQsat8BiLj31QEq4rY0/MBOTdFlekZ08+ocWztg51f/h7idukHARaA9J2PEJIJDfEkPntzpm
	NDN4lM7A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43538 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1v9jCl-000000007qu-0h0p;
	Fri, 17 Oct 2025 13:05:07 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1v9jCj-0000000B2R4-44QH;
	Fri, 17 Oct 2025 13:05:06 +0100
In-Reply-To: <aPIwqo9mCEOb7ZQu@shell.armlinux.org.uk>
References: <aPIwqo9mCEOb7ZQu@shell.armlinux.org.uk>
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
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 6/6] net: stmmac: convert to phylink managed WoL PHY
 speed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1v9jCj-0000000B2R4-44QH@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 17 Oct 2025 13:05:05 +0100

Convert stmmac to use phylink's management of the PHY speed when
Wake-on-Lan is enabled.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  5 -----
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c  |  7 +------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 15 +--------------
 3 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index f5628a6af7d3..aa8fa180c237 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -376,11 +376,6 @@ enum stmmac_state {
 
 extern const struct dev_pm_ops stmmac_simple_pm_ops;
 
-static inline bool stmmac_wol_enabled_phy(struct stmmac_priv *priv)
-{
-	return !priv->plat->pmt && device_may_wakeup(priv->device);
-}
-
 int stmmac_mdio_unregister(struct net_device *ndev);
 int stmmac_mdio_register(struct net_device *ndev);
 int stmmac_mdio_reset(struct mii_bus *mii);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index fd29b551a082..7ab736de308f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -793,13 +793,8 @@ static void stmmac_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 static int stmmac_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
-	int ret;
 
-	ret = phylink_ethtool_set_wol(priv->phylink, wol);
-	if (!ret)
-		device_set_wakeup_enable(priv->device, !!wol->wolopts);
-
-	return ret;
+	return phylink_ethtool_set_wol(priv->phylink, wol);
 }
 
 static int stmmac_ethtool_op_get_eee(struct net_device *dev,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a959a4949282..6d0b52d30ac8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1189,14 +1189,6 @@ static int stmmac_init_phy(struct net_device *dev)
 		phylink_ethtool_set_eee(priv->phylink, &eee);
 	}
 
-	if (!priv->plat->pmt) {
-		struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
-
-		phylink_ethtool_get_wol(priv->phylink, &wol);
-		device_set_wakeup_capable(priv->device, !!wol.supported);
-		device_set_wakeup_enable(priv->device, !!wol.wolopts);
-	}
-
 	return 0;
 }
 
@@ -1265,6 +1257,7 @@ static int stmmac_phylink_setup(struct stmmac_priv *priv)
 		config->eee_enabled_default = true;
 	}
 
+	config->wol_phy_speed_ctrl = true;
 	if (priv->plat->flags & STMMAC_FLAG_USE_PHY_WOL) {
 		config->wol_phy_legacy = true;
 	} else {
@@ -7795,9 +7788,6 @@ int stmmac_suspend(struct device *dev)
 	mutex_unlock(&priv->lock);
 
 	rtnl_lock();
-	if (stmmac_wol_enabled_phy(priv))
-		phylink_speed_down(priv->phylink, false);
-
 	phylink_suspend(priv->phylink, !!priv->wolopts);
 	rtnl_unlock();
 
@@ -7936,9 +7926,6 @@ int stmmac_resume(struct device *dev)
 	 * workqueue thread, which will race with initialisation.
 	 */
 	phylink_resume(priv->phylink);
-	if (stmmac_wol_enabled_phy(priv))
-		phylink_speed_up(priv->phylink);
-
 	rtnl_unlock();
 
 	netif_device_attach(ndev);
-- 
2.47.3


