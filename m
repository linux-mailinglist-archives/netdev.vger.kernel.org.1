Return-Path: <netdev+bounces-183851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C400A923A1
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578AE3BB6EF
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAEE25524A;
	Thu, 17 Apr 2025 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NoEUGe70"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABB3186E2E
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910044; cv=none; b=V6XD/otzzd2aMkc37XIe+NUmAq8fVJ2NWweZB4iEjlPWCtrxDgITrRKeW+/Dn+1QMWQYF+Fzi+lrCCv43RJCzhf1oE0G/9CqbmIteJ2eA5qTAXssLq5DTw2GohJ4uxnQKk0BLaJ7SWHAXSRDzdOkC3uwkJZkWZ/LA66cYoxbd2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910044; c=relaxed/simple;
	bh=ImAI5aReWwkoFmXunvw3JCdINoYff2ciZz1AjsDHOD4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=WeNgAgNbx6RMgEeaT95jgd1EF0pdYRAjJ/AqkL+kBt6/7M85Sqa5xOkldCkkHruaSehFrjSJmlcpVrYjfZLZHOC4BQrHzHQ1hp4ABqLwPpXwcte0UaPHOS28K7UFxxn8O7rlQZdKiDXHyAIomU8Quqakq4ZcEiX4pttUslQPi/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NoEUGe70; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Qs3bhE6uUgMBinRJFnKVkihDTKmcBoybWogUQr0C6RM=; b=NoEUGe70RGA9XXGB8WOyb+PB7P
	ts5AUJttVBh5m5nLbni3h0BvuiDSANV54/dPm/h0R9EK5tFjWHAEaIOUGhfjdcZR2rkF+RYo62z50
	MIMAbBKp0UavvuqbSN28aipbqzHfiSf3GKYnGkwiRkYxCH7EF6aKqpmO638Yi6+Sgi0IBs1tgOK9q
	hdfqP0qO0oebZwnGkj3wEH4npo4/PbF6y7UUcaxvrMeaYiXcqfDhvPkg9wTUB7EaaW+hL28TcauA/
	aiC71/0mii/t1CmEh1UnfwCqP0OiMYcsJvOXTvgttCo4gfwR5gBII7/PIJa4prHQ/tvTcUqT2TOmH
	pvcWYkbg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48402 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u5SoE-0007gf-3D;
	Thu, 17 Apr 2025 18:13:55 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u5Snd-001IJe-Cx; Thu, 17 Apr 2025 18:13:17 +0100
In-Reply-To: <aAE2tKlImhwKySq_@shell.armlinux.org.uk>
References: <aAE2tKlImhwKySq_@shell.armlinux.org.uk>
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
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v3 2/5] net: stmmac: socfpga: provide init function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u5Snd-001IJe-Cx@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 17 Apr 2025 18:13:17 +0100

Both the resume and probe path needs to configure the phy mode, so
provide a common function to do this which can later be hooked into
plat_dat->init.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index bcdb25ee2a33..c333ec07d15f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -435,6 +435,13 @@ static struct phylink_pcs *socfpga_dwmac_select_pcs(struct stmmac_priv *priv,
 	return priv->hw->phylink_pcs;
 }
 
+static int socfpga_dwmac_init(struct platform_device *pdev, void *bsp_priv)
+{
+	struct socfpga_dwmac *dwmac = bsp_priv;
+
+	return dwmac->ops->set_phy_mode(dwmac);
+}
+
 static int socfpga_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
@@ -497,7 +504,7 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = ops->set_phy_mode(dwmac);
+	ret = socfpga_dwmac_init(pdev, dwmac);
 	if (ret)
 		goto err_dvr_remove;
 
@@ -512,11 +519,9 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int socfpga_dwmac_resume(struct device *dev)
 {
-	struct net_device *ndev = dev_get_drvdata(dev);
-	struct stmmac_priv *priv = netdev_priv(ndev);
 	struct socfpga_dwmac *dwmac_priv = get_stmmac_bsp_priv(dev);
 
-	dwmac_priv->ops->set_phy_mode(priv->plat->bsp_priv);
+	socfpga_dwmac_init(to_platform_device(dev), dwmac_priv);
 
 	return stmmac_resume(dev);
 }
-- 
2.30.2


