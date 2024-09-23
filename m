Return-Path: <netdev+bounces-129315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6B197ECC0
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 16:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24BC0281E15
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 14:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F8F19CC16;
	Mon, 23 Sep 2024 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IBSY+qcv"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C0019CC0E
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727100115; cv=none; b=RNPKf+mlo38Zw7K5gtMKfXXm7k/LPPUzl2ES+rarMInReFa+fMRn+pCTcq0U7DHRAGkgu8UXlt1G1Zd6VR4KGpyx2ExL2MxzWXkSLgjtPH9pamo+D9uI6kUScayI58vksgqdvJkPaGiASl0/lg87y1V3Xp4K72xQ/tSVeKmTgxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727100115; c=relaxed/simple;
	bh=oVG/aKmcT9azx4MLAl7YVecvEokP0ArYFDIHeIZ3TI4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=bODNYFr9DTnkkZ82sBncdIoNaHqOgt62ECrMYmrTNrYxJhiO24yO4ImyuIIl2Qdfxa6d+qS6/yDHO9I5228iZNfiVCnTMVZlkrmGmgZ47AKepFIqsttjlfvUz7hBWe6vsx4S2Hgcow05B/ZxHLUYlkVq3aSmwmPZp9l0qBnjwN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IBSY+qcv; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=w84AsLmKTeCPVN/sLUEBYoHJEA4fMyM16ViIJcGM9Bw=; b=IBSY+qcv8JCkI3/3H4IGmySZTp
	WLZtzmxXqLAEgJvaq1OVC1WH5mqk1YBFX+pDyMwEvO3SIFQbittkicrTOv9melt5l1OmNiVHfcQTl
	W4VjynIFvqG4C3N+6SWdcbFRBsQTbrv6WK/DkzaIXRf4c8yaYTqWPprVI21txSZxc+kr2MR4c2MWA
	VimaYv+6QaCBkpGBta509uIJ+GHMua67ZuCIiUn8HrD0Zgj/Vj1pGoGE04uZ1el2DsYbFFdLcZPA/
	2/IxUjbP6z+7pYp/UQzcB3bBLK4QudZo7tnOSGIDE48jVM0pMTzjcsNgREr2+cGiHg4eNqHihgyHV
	LAlu46gA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42216 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1ssjdC-0004J1-1B;
	Mon, 23 Sep 2024 15:01:38 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1ssjd9-005NsL-K7; Mon, 23 Sep 2024 15:01:35 +0100
In-Reply-To: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
References: <ZvF0er+vyciwy3Nx@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH RFC net-next 08/10] net: dsa: sja1105: use phylink_pcs
 internally
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ssjd9-005NsL-K7@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 23 Sep 2024 15:01:35 +0100

Use xpcs_create_pcs_mdiodev() to create the XPCS instance, storing
and using the phylink_pcs pointer internally, rather than dw_xpcs.
Use xpcs_destroy_pcs() to destroy the XPCS instance when we've
finished with it.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/sja1105/sja1105.h      |  2 +-
 drivers/net/dsa/sja1105/sja1105_main.c | 16 ++++-----------
 drivers/net/dsa/sja1105/sja1105_mdio.c | 28 ++++++++++++--------------
 3 files changed, 18 insertions(+), 28 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
index 8c66d3bf61f0..dceb96ae9c83 100644
--- a/drivers/net/dsa/sja1105/sja1105.h
+++ b/drivers/net/dsa/sja1105/sja1105.h
@@ -278,7 +278,7 @@ struct sja1105_private {
 	struct mii_bus *mdio_base_t1;
 	struct mii_bus *mdio_base_tx;
 	struct mii_bus *mdio_pcs;
-	struct dw_xpcs *xpcs[SJA1105_MAX_NUM_PORTS];
+	struct phylink_pcs *pcs[SJA1105_MAX_NUM_PORTS];
 	struct sja1105_ptp_data ptp_data;
 	struct sja1105_tas_data tas_data;
 };
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 8ef1a1931a33..c86905c94765 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -15,7 +15,6 @@
 #include <linux/of.h>
 #include <linux/of_net.h>
 #include <linux/of_mdio.h>
-#include <linux/pcs/pcs-xpcs.h>
 #include <linux/netdev_features.h>
 #include <linux/netdevice.h>
 #include <linux/if_bridge.h>
@@ -1356,12 +1355,8 @@ sja1105_mac_select_pcs(struct phylink_config *config, phy_interface_t iface)
 {
 	struct dsa_port *dp = dsa_phylink_to_port(config);
 	struct sja1105_private *priv = dp->ds->priv;
-	struct dw_xpcs *xpcs = priv->xpcs[dp->index];
 
-	if (xpcs)
-		return &xpcs->pcs;
-
-	return NULL;
+	return priv->pcs[dp->index];
 }
 
 static void sja1105_mac_config(struct phylink_config *config,
@@ -2317,7 +2312,7 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 		mac_speed[i] = mac[i].speed;
 		mac[i].speed = priv->info->port_speed[SJA1105_SPEED_AUTO];
 
-		if (priv->xpcs[i])
+		if (priv->pcs[i])
 			bmcr[i] = mdiobus_c45_read(priv->mdio_pcs, i,
 						   MDIO_MMD_VEND2, MDIO_CTRL1);
 	}
@@ -2374,8 +2369,7 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 	}
 
 	for (i = 0; i < ds->num_ports; i++) {
-		struct dw_xpcs *xpcs = priv->xpcs[i];
-		struct phylink_pcs *pcs;
+		struct phylink_pcs *pcs = priv->pcs[i];
 		unsigned int neg_mode;
 
 		mac[i].speed = mac_speed[i];
@@ -2383,11 +2377,9 @@ int sja1105_static_config_reload(struct sja1105_private *priv,
 		if (rc < 0)
 			goto out;
 
-		if (!xpcs)
+		if (!pcs)
 			continue;
 
-		pcs = &xpcs->pcs;
-
 		if (bmcr[i] & BMCR_ANENABLE)
 			neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
 		else
diff --git a/drivers/net/dsa/sja1105/sja1105_mdio.c b/drivers/net/dsa/sja1105/sja1105_mdio.c
index 52ddb4ef259e..84b7169f2974 100644
--- a/drivers/net/dsa/sja1105/sja1105_mdio.c
+++ b/drivers/net/dsa/sja1105/sja1105_mdio.c
@@ -400,7 +400,7 @@ static int sja1105_mdiobus_pcs_register(struct sja1105_private *priv)
 	}
 
 	for (port = 0; port < ds->num_ports; port++) {
-		struct dw_xpcs *xpcs;
+		struct phylink_pcs *pcs;
 
 		if (dsa_is_unused_port(ds, port))
 			continue;
@@ -409,13 +409,13 @@ static int sja1105_mdiobus_pcs_register(struct sja1105_private *priv)
 		    priv->phy_mode[port] != PHY_INTERFACE_MODE_2500BASEX)
 			continue;
 
-		xpcs = xpcs_create_mdiodev(bus, port, priv->phy_mode[port]);
-		if (IS_ERR(xpcs)) {
-			rc = PTR_ERR(xpcs);
+		pcs = xpcs_create_pcs_mdiodev(bus, port);
+		if (IS_ERR(pcs)) {
+			rc = PTR_ERR(pcs);
 			goto out_pcs_free;
 		}
 
-		priv->xpcs[port] = xpcs;
+		priv->pcs[port] = pcs;
 	}
 
 	priv->mdio_pcs = bus;
@@ -424,11 +424,10 @@ static int sja1105_mdiobus_pcs_register(struct sja1105_private *priv)
 
 out_pcs_free:
 	for (port = 0; port < ds->num_ports; port++) {
-		if (!priv->xpcs[port])
-			continue;
-
-		xpcs_destroy(priv->xpcs[port]);
-		priv->xpcs[port] = NULL;
+		if (priv->pcs[port]) {
+			xpcs_destroy_pcs(priv->pcs[port]);
+			priv->pcs[port] = NULL;
+		}
 	}
 
 	mdiobus_unregister(bus);
@@ -446,11 +445,10 @@ static void sja1105_mdiobus_pcs_unregister(struct sja1105_private *priv)
 		return;
 
 	for (port = 0; port < ds->num_ports; port++) {
-		if (!priv->xpcs[port])
-			continue;
-
-		xpcs_destroy(priv->xpcs[port]);
-		priv->xpcs[port] = NULL;
+		if (priv->pcs[port]) {
+			xpcs_destroy_pcs(priv->pcs[port]);
+			priv->pcs[port] = NULL;
+		}
 	}
 
 	mdiobus_unregister(priv->mdio_pcs);
-- 
2.30.2


