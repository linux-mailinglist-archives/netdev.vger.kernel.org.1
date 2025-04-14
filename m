Return-Path: <netdev+bounces-182088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC00A87B7D
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 11:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048C4168D5C
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 09:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8273425C71C;
	Mon, 14 Apr 2025 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xcSBKWI5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFED25DCEF
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744621648; cv=none; b=dcPxUGSSJy930AOstZ/bpr7VHvczkvkfP3eVtELlxEuwY0UmhdHqP8PX66FPpeJNYULMlIeD74lCMun0aRKz/qC1a9V4sneXwebQCe48a9e5Q/WQSa+Zrb2Dh2T3PYPolXosaL7DtaojUPX4BRJBPU/NxahFGuQljVQgi5QvscY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744621648; c=relaxed/simple;
	bh=ZcbWImZBypCh0kuuSNE1lRrvhJFZbz3OtZ1UUwrbgMM=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=u2N2zrfsJg8aZ0Q8YzYcOLeqz3xrVQ/JveSfgTkYjBUjkKEUh+WVmaOGZr5AxhxOxM+oTC8CcFdlTcLdsGQSP7eiCSgGbCBkAxptQjsUc/8zFD8BVa+ZeQjsZFKCQlMP12x65LNyT/KYZaXtGIgf7QWtqHFeAui+xe3bNqkproE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xcSBKWI5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Px4QFGrKJWtbtdsi+c1vt/WEwND1NnX28cuVBKiVNEk=; b=xcSBKWI5TmOKz5Gxr4tNMhNkFJ
	ZhioFfRMcU/hVAvkR85LhHSFVEQCvlffVyrCyVtrSvPveuN6lqePKWqa8Qkd9tWVNpYsjUh0DzoLq
	9FXkDibIBeIXB+2QcCRDpZhWhWGtii2O2WpusvjsbMg13FLWSZt++7E2U+m3Ym6hNbinzhIy46dZP
	pmmkbyzsoVt81xYlkVeNpP3xpV2Z9dkyP5Q1a05Gzq/FAPT65pcFqqdrxH8LspqVgGAhsXv2DRLs3
	k99CQoicutHze6S4rlcZihKhweeoIKaLB1ncAsGnHqfLjbQLu314UVuM/8r9IhQmH0BfoYnXUovCI
	McJVv1iQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57824 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u4Fmc-0006Da-1k;
	Mon, 14 Apr 2025 10:07:14 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u4Flp-000XlM-Tb; Mon, 14 Apr 2025 10:06:25 +0100
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
Subject: [PATCH net-next v2] net: stmmac: imx: use stmmac_pltfr_probe()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u4Flp-000XlM-Tb@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 14 Apr 2025 10:06:25 +0100

Using stmmac_pltfr_probe() simplifies the probe function. This will not
only call plat_dat->init (imx_dwmac_init), but also plat_dat->exit
(imx_dwmac_exit) appropriately if stmmac_dvr_probe() fails. This
results in an overall simplification of the glue driver.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 5d279fa54b3e..889e2bb6f7f5 100644
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
+	ret = stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
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


