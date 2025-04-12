Return-Path: <netdev+bounces-181911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8966A86DA0
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 16:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E988E7A518B
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 14:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2F81C3BEB;
	Sat, 12 Apr 2025 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Ry9twFid"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96345186E54
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744467497; cv=none; b=pSfszRuTWOi7S1a9r2Q50ziGlyCGhjv+Noq/mg9m5b6Gt2BGlBurAJXhl06WQGLOwhLPxuAPLEkBJs0X56nmTjthHS9bwQPisX4ISQkA+a4ZEgMXWXCKNa18uySrq5Ef0sJ4BogkLpxygfBezuyiQd5Sa6hGkTH7UigAk8hh5kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744467497; c=relaxed/simple;
	bh=JR6tyXY1gvpl41cRWbqroRS7xCj4V4ElwNXBpV0ykRg=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=rTuIWS/ZmY1MqbaI4NH739FhrLVMAaR3uGfqmHD5w0xMXnwVkf98WZqay8WhdB2TGQCNR16dWvMPA6iQSvw5HNPGU/Gy1n1pDSQWwu/iMnI36ryxpeRX6snVtdPgfgKfYnDBXjTN+T6SckGEAyiS+x1+8I1Q+J/L2QHsfyUtwUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Ry9twFid; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+J4kgIiOlyNlscSmyi+M0ndzlA6RBERVMIHPWwh9j+o=; b=Ry9twFidwSXnbS6fXWRxRsLBZB
	PUPEgc0BboLgzsr6LszdT47ZcKA9kQqcK3YA6nhBDBDaBQb5D0WUNVgnNCb1dCO8XE1MITHTuQtVa
	mLrnFaWh2NU7DTLo6htzPaiNd56p/HPjRqT7H1brXYrO4ZznO61ton3ZBwFbE/KmvWU0NFbk5A4YI
	QyTOjmYoH3K64IpH1JdwUywLJk6e/MrHgtvxos9qABZ7RMZ4TgQLZHaNBvoHwVUUrUV9JRnwX+RFL
	7pIx6i8Z5B8jDZixdEKmzTM1BeFkXxBdzYtR26u+MWIs+sqVAj3kLy7es1NjAAHtPCaVQGSoN/85c
	ISHIv8fg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41112 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u3bgN-0004d8-30;
	Sat, 12 Apr 2025 15:18:07 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u3bfm-000Enq-MC; Sat, 12 Apr 2025 15:17:30 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH net-next] net: stmmac: imx: use stmmac_pltfr_probe()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u3bfm-000Enq-MC@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 12 Apr 2025 15:17:30 +0100

Using stmmac_pltfr_probe() simplifies the probe function. This will not
only call plat_dat->init (imx_dwmac_init), but also plat_dat->exit
(imx_dwmac_exit) appropriately if stmmac_dvr_probe() fails. This
results in an overall simplification of the glue driver.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 5d279fa54b3e..b07d6f85ea90 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -379,10 +379,6 @@ static int imx_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = imx_dwmac_init(pdev, dwmac);
-	if (ret)
-		goto err_dwmac_init;
-
 	if (dwmac->ops->fix_mac_speed) {
 		plat_dat->fix_mac_speed = dwmac->ops->fix_mac_speed;
 	} else if (!dwmac->ops->mac_rgmii_txclk_auto_adj) {
@@ -392,16 +388,10 @@ static int imx_dwmac_probe(struct platform_device *pdev)
 
 	dwmac->plat_dat->fix_soc_reset = dwmac->ops->fix_soc_reset;
 
-	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
+	ret = stmmac_pltfr_probe(&pdev->dev, plat_dat, &stmmac_res);
 	if (ret)
-		goto err_drv_probe;
-
-	return 0;
+		imx_dwmac_clks_config(dwmac, false);
 
-err_drv_probe:
-	imx_dwmac_exit(pdev, plat_dat->bsp_priv);
-err_dwmac_init:
-	imx_dwmac_clks_config(dwmac, false);
 	return ret;
 }
 
-- 
2.30.2


