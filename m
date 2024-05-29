Return-Path: <netdev+bounces-99035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6E88D37A2
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 15:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3794D28811D
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F36F12B95;
	Wed, 29 May 2024 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mDTJgtoK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F2D1643A
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716989391; cv=none; b=uCsIrqf1CueZ/74JzOzW1MaYG6rsOro+uZxgVF+y7104jT8KqUpfplTUp/tkblh+EYnNxdoAU4Z/zcT+cJnV5OQdXPXZJ/9hrFvrIckOsj4GlewDEEGFuI7DLdmVReS6FAbqE1y5CK19TYLAzDYE3DIqw0iBuqP/Unhpln1q8GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716989391; c=relaxed/simple;
	bh=FT5CxuChzJtt06dJ/XX1M4n1Iq2flU5JHB42HrqXqM4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=kHk25d9QwW89L7Di3zvTaO+CzF4zRScUYGYacq8mwokxyuTzU6dOpeoLo/C0+PBw2IE8G7++EmVUrccRi/acKbzNtmdZc91VlIqFax3lpz8s9R4y4gPoB1Pnb5vfYJdgn1L6wxRJ+MNaV7HfYPFPcBRp6UTZrAECwfv2r9Pw8EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mDTJgtoK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BYvO95PpEcMgA0q270dluXDRCbFClCEyBXdlLNYYlFI=; b=mDTJgtoKsm6r/eWRMv1Rnumsm/
	KZs0wqYzrpBzm30CFWHTdUQFlUp0xg8GhDXKHFu8h/U/noXD/jcfJB/zXcXPTJVSeFQfSS9zEEYUm
	cmmtk8syO2XxnrPXnw2cIlOQuT+QykirkGNKDg/LsrMqs8VZyDDBeXiukQIdu4UCD9R/91hjfY0jF
	qhT2oRxoMLcoz3CDqb/DhlRis2Q0pWBIPzUG3gAEbwtkey3kqE6i7nT35SoL/qnwe2WDp7nOEK/R5
	xkVxbxy3z75NjsUM6qhigatMlba9OyxDWBhzAJ+tfF5GHBs9KeNE3Qo+NPuq3TG+CmeRTaytaV3dZ
	D6Sil+5g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44826 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sCJN3-0006Ak-1x;
	Wed, 29 May 2024 14:29:37 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sCJN6-00EcrD-43; Wed, 29 May 2024 14:29:40 +0100
In-Reply-To: <ZlctinnTT8Xhemsm@shell.armlinux.org.uk>
References: <ZlctinnTT8Xhemsm@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	 Serge Semin <fancer.lancer@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 5/6] net: stmmac: rename xpcs_an_inband to
 default_an_inband
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sCJN6-00EcrD-43@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 29 May 2024 14:29:40 +0100

Rename xpcs_an_inband to default_an_inband to reflect the change in
phylink and its changed functionality.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 8 ++++----
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 include/linux/stmmac.h                            | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 60283543ffc8..5e96146b8bd9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -248,7 +248,7 @@ static void intel_speed_mode_2500(struct net_device *ndev, void *intel_data)
 		dev_info(priv->device, "Link Speed Mode: 2.5Gbps\n");
 		priv->plat->max_speed = 2500;
 		priv->plat->phy_interface = PHY_INTERFACE_MODE_2500BASEX;
-		priv->plat->mdio_bus_data->xpcs_an_inband = false;
+		priv->plat->mdio_bus_data->default_an_inband = false;
 	} else {
 		priv->plat->max_speed = 1000;
 	}
@@ -586,16 +586,16 @@ static int intel_mgbe_common_data(struct pci_dev *pdev,
 	if (plat->phy_interface == PHY_INTERFACE_MODE_SGMII ||
 	    plat->phy_interface == PHY_INTERFACE_MODE_1000BASEX) {
 		plat->mdio_bus_data->has_xpcs = true;
-		plat->mdio_bus_data->xpcs_an_inband = true;
+		plat->mdio_bus_data->default_an_inband = true;
 	}
 
-	/* For fixed-link setup, we clear xpcs_an_inband */
+	/* For fixed-link setup, we clear default_an_inband */
 	if (fwnode) {
 		struct fwnode_handle *fixed_node;
 
 		fixed_node = fwnode_get_named_child_node(fwnode, "fixed-link");
 		if (fixed_node)
-			plat->mdio_bus_data->xpcs_an_inband = false;
+			plat->mdio_bus_data->default_an_inband = false;
 
 		fwnode_handle_put(fixed_node);
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 488b2fd2349c..bbedf2a8c60f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1222,7 +1222,7 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 	mdio_bus_data = priv->plat->mdio_bus_data;
 	if (mdio_bus_data)
 		priv->phylink_config.default_an_inband =
-			mdio_bus_data->xpcs_an_inband;
+			mdio_bus_data->default_an_inband;
 
 	/* Set the platform/firmware specified interface mode. Note, phylink
 	 * deals with the PHY interface mode, not the MAC interface mode.
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index f92c195c76ed..8f0f156d50d3 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -83,7 +83,7 @@ struct stmmac_priv;
 struct stmmac_mdio_bus_data {
 	unsigned int phy_mask;
 	unsigned int has_xpcs;
-	unsigned int xpcs_an_inband;
+	unsigned int default_an_inband;
 	int *irqs;
 	int probed_phy_irq;
 	bool needs_reset;
-- 
2.30.2


