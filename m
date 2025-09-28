Return-Path: <netdev+bounces-226987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE35BA6C8F
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 11:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64F183C03B0
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 09:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0160C2C0F93;
	Sun, 28 Sep 2025 08:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sC/Ewk15"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893CC2C0F64;
	Sun, 28 Sep 2025 08:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759049971; cv=none; b=jg10W53kmIwJkyIFJiEDUznCB3E2dpL8yE6G7mJ20a/8nlUbVGnH4LJlXGW4l8iTQ/8QJbwSMLemD+5KmwaVFG3zfaAfKWRUMrdQKNR9LxEGAWs7UjTYY5XPRX70sU9ZeDvlX/y6NSZWgBJbVob2RBTBEzfcTR8c3jN/qSu8j7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759049971; c=relaxed/simple;
	bh=i1YOrtz3EopWLqXHOIZ06/rvP2jym7d3/PsSNaIgZ1M=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=csingBee0Tl2MVIWPz9jFwFB35VuzJzaoBs8p+V1cWaUCorC/HBF5scgtiF7Jxrnz/JupLh3nXGXCdtiSQEDJnVFJD9m6iJEd+obod1RGjBHggrLN7y6oSKDyB/A5H0DxO8kI+6jOAYTIC6KJ99t3OOg1TNUMBaJsY35jD2uuok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sC/Ewk15; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=C4UQo3+08xrxFnLlCDCPAotpduzq+WH7VjrKUHG4XAA=; b=sC/Ewk15B8wkmRqbgbzNxY56xo
	H29uXyjVQKt6LjnTJm7zJTTIOqvSwd7I7mnMmonXATPWvgkjsR6jQXbMtQbnBnJWtJFcL/JVAWWnN
	5JsdPAIlo+1O4b1bHFNzDpzcb1jTYlUONVEpj7uNiGNvkKuYcBPQx0FUA4TKAa6E54+608nnWaaGg
	zii/1VndDKctk9dIFDUwVtPd3a1abjNQFOId1s0K3pBHWACWaoJhJ3jX8hGb9Pve6MhPl0Nxnv2Tu
	TipsyohMqB1XtdXBDo3DwvYM7dGE62aoVwvq/64CD67CAnY0k9NtjLHj5baMn0tR5amsU2m/kQ5sV
	pejCINrQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54438 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1v2nFV-000000005BW-3bml;
	Sun, 28 Sep 2025 09:59:18 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1v2nFS-00000007jXh-2HC2;
	Sun, 28 Sep 2025 09:59:14 +0100
In-Reply-To: <aNj4HY_mk4JDsD_D@shell.armlinux.org.uk>
References: <aNj4HY_mk4JDsD_D@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	 Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Tristram Ha <Tristram.Ha@microchip.com>
Subject: [PATCH RFC net-next 5/6] net: stmmac: convert to phylink-managed
 Wake-on-Lan
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1v2nFS-00000007jXh-2HC2@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 28 Sep 2025 09:59:14 +0100

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  6 +---
 .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 34 ++++---------------
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 30 ++++++++++++++--
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  4 +--
 4 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 7ca5477be390..db4f82672d9a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -287,6 +287,7 @@ struct stmmac_priv {
 	int hw_cap_support;
 	int synopsys_id;
 	u32 msg_enable;
+	/* Our MAC Wake-on-Lan options */
 	int wolopts;
 	int wol_irq;
 	u32 gmii_address_bus_config;
@@ -375,11 +376,6 @@ enum stmmac_state {
 
 extern const struct dev_pm_ops stmmac_simple_pm_ops;
 
-static inline bool stmmac_wol_enabled_mac(struct stmmac_priv *priv)
-{
-	return priv->plat->pmt && device_may_wakeup(priv->device);
-}
-
 static inline bool stmmac_wol_enabled_phy(struct stmmac_priv *priv)
 {
 	return !priv->plat->pmt && device_may_wakeup(priv->device);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 39fa1ec92f82..fd29b551a082 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -787,41 +787,19 @@ static void stmmac_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
-	if (!priv->plat->pmt)
-		return phylink_ethtool_get_wol(priv->phylink, wol);
-
-	mutex_lock(&priv->lock);
-	if (device_can_wakeup(priv->device)) {
-		wol->supported = WAKE_MAGIC | WAKE_UCAST;
-		if (priv->hw_cap_support && !priv->dma_cap.pmt_magic_frame)
-			wol->supported &= ~WAKE_MAGIC;
-		wol->wolopts = priv->wolopts;
-	}
-	mutex_unlock(&priv->lock);
+	return phylink_ethtool_get_wol(priv->phylink, wol);
 }
 
 static int stmmac_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
+	int ret;
 
-	if (!device_can_wakeup(priv->device))
-		return -EOPNOTSUPP;
-
-	if (!priv->plat->pmt) {
-		int ret = phylink_ethtool_set_wol(priv->phylink, wol);
-
-		if (!ret)
-			device_set_wakeup_enable(priv->device, !!wol->wolopts);
-		return ret;
-	}
-
-	device_set_wakeup_enable(priv->device, !!wol->wolopts);
+	ret = phylink_ethtool_set_wol(priv->phylink, wol);
+	if (!ret)
+		device_set_wakeup_enable(priv->device, !!wol->wolopts);
 
-	mutex_lock(&priv->lock);
-	priv->wolopts = wol->wolopts;
-	mutex_unlock(&priv->lock);
-
-	return 0;
+	return ret;
 }
 
 static int stmmac_ethtool_op_get_eee(struct net_device *dev,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index cdc092e2ed9b..abe88b74239a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1065,6 +1065,20 @@ static int stmmac_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
 	return 0;
 }
 
+static int stmmac_mac_wol_set(struct phylink_config *config, u32 wolopts,
+			      const u8 *sopass)
+{
+	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
+
+	device_set_wakeup_enable(priv->device, !!wolopts);
+
+	mutex_lock(&priv->lock);
+	priv->wolopts = wolopts;
+	mutex_unlock(&priv->lock);
+
+	return 0;
+}
+
 static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
 	.mac_get_caps = stmmac_mac_get_caps,
 	.mac_select_pcs = stmmac_mac_select_pcs,
@@ -1074,6 +1088,7 @@ static const struct phylink_mac_ops stmmac_phylink_mac_ops = {
 	.mac_link_up = stmmac_mac_link_up,
 	.mac_disable_tx_lpi = stmmac_mac_disable_tx_lpi,
 	.mac_enable_tx_lpi = stmmac_mac_enable_tx_lpi,
+	.mac_wol_set = stmmac_mac_wol_set,
 };
 
 /**
@@ -1250,6 +1265,15 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 		config->eee_enabled_default = true;
 	}
 
+	if (priv->plat->flags & STMMAC_FLAG_USE_PHY_WOL) {
+		config->wol_phy_legacy = true;
+	} else {
+		if (priv->dma_cap.pmt_remote_wake_up)
+			config->wol_mac_support |= WAKE_UCAST;
+		if (priv->dma_cap.pmt_magic_frame)
+			config->wol_mac_support |= WAKE_MAGIC;
+	}
+
 	fwnode = priv->plat->port_node;
 	if (!fwnode)
 		fwnode = dev_fwnode(priv->device);
@@ -7760,7 +7784,7 @@ int stmmac_suspend(struct device *dev)
 		priv->plat->serdes_powerdown(ndev, priv->plat->bsp_priv);
 
 	/* Enable Power down mode by programming the PMT regs */
-	if (stmmac_wol_enabled_mac(priv)) {
+	if (priv->wolopts) {
 		stmmac_pmt(priv, priv->hw, priv->wolopts);
 		priv->irq_wake = 1;
 	} else {
@@ -7774,7 +7798,7 @@ int stmmac_suspend(struct device *dev)
 	if (stmmac_wol_enabled_phy(priv))
 		phylink_speed_down(priv->phylink, false);
 
-	phylink_suspend(priv->phylink, stmmac_wol_enabled_mac(priv));
+	phylink_suspend(priv->phylink, !!priv->wolopts);
 	rtnl_unlock();
 
 	if (stmmac_fpe_supported(priv))
@@ -7850,7 +7874,7 @@ int stmmac_resume(struct device *dev)
 	 * this bit because it can generate problems while resuming
 	 * from another devices (e.g. serial console).
 	 */
-	if (stmmac_wol_enabled_mac(priv)) {
+	if (priv->wolopts) {
 		mutex_lock(&priv->lock);
 		stmmac_pmt(priv, priv->hw, 0);
 		mutex_unlock(&priv->lock);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 27bcaae07a7f..ed38925eb6f6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -970,7 +970,7 @@ static int __maybe_unused stmmac_pltfr_noirq_suspend(struct device *dev)
 	if (!netif_running(ndev))
 		return 0;
 
-	if (!stmmac_wol_enabled_mac(priv)) {
+	if (!priv->wolopts) {
 		/* Disable clock in case of PWM is off */
 		clk_disable_unprepare(priv->plat->clk_ptp_ref);
 
@@ -991,7 +991,7 @@ static int __maybe_unused stmmac_pltfr_noirq_resume(struct device *dev)
 	if (!netif_running(ndev))
 		return 0;
 
-	if (!stmmac_wol_enabled_mac(priv)) {
+	if (!priv->wolopts) {
 		/* enable the clk previously disabled */
 		ret = pm_runtime_force_resume(dev);
 		if (ret)
-- 
2.47.3


