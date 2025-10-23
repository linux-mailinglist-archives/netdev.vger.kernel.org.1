Return-Path: <netdev+bounces-232027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2871BC00334
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5543ADCAF
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 09:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F212FDC23;
	Thu, 23 Oct 2025 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Y38kwf1Z"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71242FD7A5;
	Thu, 23 Oct 2025 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761211033; cv=none; b=Yk50/IgFo7gaMZ7zuoa4yg/zTpjKD6we4TSuzZHGM0Lh0UZAc3kNCik6HocFLB26qWMbyztJnMKfa+WdaVt93A0KeuJy1Cb9Ej0rCkrRQn41iuP9CWpCphMqqMVah5hceKPLX8jFzTgf0od5uxG81GJSLkayLTeYilyihMqmxeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761211033; c=relaxed/simple;
	bh=BaB/XZhFu753IVYghIbyLEqXUpXhWf2fgCL2JKj5xmY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=cqm1XD0brn9mf8ck+oPO1LFJkYdOlUswdogtu0xazXH90mIniNLjxO1E+2O3QOAGAUuicPl/pkBoiQWcfFWYDJmRLVikLxsclgaEnFO5RjZl2SVqj/N67G9g4VDxFXTw4gqBUh9mOQTF0MvmanfMjBlRC7xTVCkHFz3TdwsS/ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Y38kwf1Z; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=p8nGj97eGYTfPod9ayjRGJmFdOdrPYx1iYFTpsb7YyU=; b=Y38kwf1ZcEXlS3x3iHyV8S9EUn
	Mn6lT0Gc0MdsX2vyeLM2xfZs+2vdCxZElGOxiRYVIV8yTOu57NspfkHM/CfMjBAvqRITlYVZBYHYy
	COeqHWFzoSjrZlJtmWsJOzlD/oaJN16CVZTs8/DJDb0ADuB6i785Rn+iXWysOPYxjk0L3XiyYnczf
	uN5XsMXKru+QoLsK1W1rOst8zs+6pYRfeTOacZlyECYzlxuODxDzBC+vAXGonKYbcvfyeS59e5i6n
	3e9cSVBdBqIbuh0tSSwPvuZ1OYVwgzCn2WlL97KiHdj5K2QhUHGds+518uzbPboMBHsUVa1H5RLGB
	S8aQNZSQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57406 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vBrRM-0000000062N-0xrQ;
	Thu, 23 Oct 2025 10:17:00 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vBrRH-0000000BLzm-3JjF;
	Thu, 23 Oct 2025 10:16:55 +0100
In-Reply-To: <aPnyW54J80h9DmhB@shell.armlinux.org.uk>
References: <aPnyW54J80h9DmhB@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
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
Subject: [PATCH net-next v2 6/6] net: stmmac: convert to phylink managed WoL
 PHY speed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vBrRH-0000000BLzm-3JjF@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 23 Oct 2025 10:16:55 +0100

Convert stmmac to use phylink's management of the PHY speed when
Wake-on-Lan is enabled.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  5 -----
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c  |  7 +------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 15 +--------------
 3 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index f128d25346a9..d5af9344dfb0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -380,11 +380,6 @@ enum stmmac_state {
 
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
index 08b570bc60c7..b155e71aac51 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -730,13 +730,8 @@ static void stmmac_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
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
index af4eb94f0f4f..fd5106880192 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1205,14 +1205,6 @@ static int stmmac_init_phy(struct net_device *dev)
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
 
@@ -1281,6 +1273,7 @@ static int stmmac_phylink_setup(struct stmmac_priv *priv)
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


