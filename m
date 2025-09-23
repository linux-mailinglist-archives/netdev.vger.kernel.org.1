Return-Path: <netdev+bounces-225582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 024E4B95A60
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F96218A7852
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD056321F35;
	Tue, 23 Sep 2025 11:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0iFrA0cK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDEF145B3F
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 11:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626794; cv=none; b=e8oIUIRTQhMpbf8ImMRKwtWjypqizEc8m34wl8dzV8IgNbJE+mUQYfpdgOy1Iwp7tT+RmhWWg07gZtUYnjegF33jzoTmEPvIVKme9uh+6WYvJ43LJWOdfkZmneTdLHjq+7VlQElwcjW8/uyZ7bb13lZ8EqA8CXwpskFvMfXBTqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626794; c=relaxed/simple;
	bh=VZUJDNi4ZxBcPjCcDPly3MXDSjrr55q5KUGGiNo+Mtw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=nwnG9hLocUcWT7v6eHnKlWxTsK91IAnBKkfyPFIUjOHYmapBMb7wAKQJkcYgdmUzJvP+Xx2/B+nNAmoS0Uajp4yMh2UeBxpYZ5Mq+ht0M7Ri69ct/GDAmxE2SUZkwOERM5Gf3ovNsJyYsivQBTl7KoU6FC8lcoVH2t7330lMYNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0iFrA0cK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iMApgIyGL71JhjcL22dLhUAJuwZE2xcyZ4Sw+gpguC0=; b=0iFrA0cKwsRt1uEBWCM/LVTfp2
	2Y1HbFYhaxFUu5+A4cmGSIL+e/pWhYr+qKSaCb1W3xGfqZzCBuc4F+bvtDgQwh6p51myo8bIHBxsm
	2cuzyw99Xk2ASeXdPUB5nxmzfwC+Px27/QITgoQtK5bbhL89W9mnAuhsBTlvTDrmF8tJwqphshmQl
	erfAYw3KwJJ0q5tkHAo+IhaGWmarj8gL1oKqs6QORVW2HaEYBYkpjTjzguq/GCIjTOSAmWD5szATv
	bVPNpvFmxR/j3v+XlafggW3z3nsZkUlOQVbaZ/rN8uJF3eHMA21Vpyr6UPrhog98gAob8TOjzv4HD
	WHg0oW5w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39566 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1v11A5-0000000079F-2j99;
	Tue, 23 Sep 2025 12:26:21 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1v11A3-0000000774G-3PKY;
	Tue, 23 Sep 2025 12:26:19 +0100
In-Reply-To: <aNKDqqI7aLsuDD52@shell.armlinux.org.uk>
References: <aNKDqqI7aLsuDD52@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 5/6] net: stmmac: move PHY handling out of
 __stmmac_open()/release()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1v11A3-0000000774G-3PKY@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 23 Sep 2025 12:26:19 +0100

Move the PHY attachment/detachment from the network driver out of
__stmmac_open() and __stmmac_release() into stmmac_open() and
stmmac_release() where these actions will only happen when the
interface is administratively brought up or down. It does not make
sense to detach and re-attach the PHY during a change of MTU.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 29 +++++++++++--------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 4acd180d2da8..4844d563e291 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3937,10 +3937,6 @@ static int __stmmac_open(struct net_device *dev,
 	u32 chan;
 	int ret;
 
-	ret = stmmac_init_phy(dev);
-	if (ret)
-		return ret;
-
 	for (int i = 0; i < MTL_MAX_TX_QUEUES; i++)
 		if (priv->dma_conf.tx_queue[i].tbs & STMMAC_TBS_EN)
 			dma_conf->tx_queue[i].tbs = priv->dma_conf.tx_queue[i].tbs;
@@ -3990,7 +3986,6 @@ static int __stmmac_open(struct net_device *dev,
 
 	stmmac_release_ptp(priv);
 init_error:
-	phylink_disconnect_phy(priv->phylink);
 	return ret;
 }
 
@@ -4010,18 +4005,28 @@ static int stmmac_open(struct net_device *dev)
 
 	ret = pm_runtime_resume_and_get(priv->device);
 	if (ret < 0)
-		goto err;
+		goto err_dma_resources;
+
+	ret = stmmac_init_phy(dev);
+	if (ret)
+		goto err_runtime_pm;
 
 	ret = __stmmac_open(dev, dma_conf);
-	if (ret) {
-		pm_runtime_put(priv->device);
-err:
-		free_dma_desc_resources(priv, dma_conf);
-	}
+	if (ret)
+		goto err_disconnect_phy;
 
 	kfree(dma_conf);
 
 	return ret;
+
+err_disconnect_phy:
+	phylink_disconnect_phy(priv->phylink);
+err_runtime_pm:
+	pm_runtime_put(priv->device);
+err_dma_resources:
+	free_dma_desc_resources(priv, dma_conf);
+	kfree(dma_conf);
+	return ret;
 }
 
 static void __stmmac_release(struct net_device *dev)
@@ -4038,7 +4043,6 @@ static void __stmmac_release(struct net_device *dev)
 
 	/* Stop and disconnect the PHY */
 	phylink_stop(priv->phylink);
-	phylink_disconnect_phy(priv->phylink);
 
 	stmmac_disable_all_queues(priv);
 
@@ -4078,6 +4082,7 @@ static int stmmac_release(struct net_device *dev)
 
 	__stmmac_release(dev);
 
+	phylink_disconnect_phy(priv->phylink);
 	pm_runtime_put(priv->device);
 
 	return 0;
-- 
2.47.3


