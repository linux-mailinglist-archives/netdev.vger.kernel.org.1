Return-Path: <netdev+bounces-183852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C33CA923A3
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A468A02EF
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8D22550DA;
	Thu, 17 Apr 2025 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nUZQyTok"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC95186E2E
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910050; cv=none; b=KpLtjGE45xg2K9Ygl6klwQY+Tc8QqBFA3mj9XotLN9kLCgi2LGtcU+30hVEmjCB/yHSFCL/sjEhDh8VNmYJJ9YzBorH+maNEVlB7lcW2bl3UwNxROnv5+pZXIOifEm1sAwidHuUw9pO/qEbvMa6vMpz4MQVNsv1qYhL1yGpCmaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910050; c=relaxed/simple;
	bh=kjOilEaugiKxUEhb1azbBx2ceqItlDAPc5CN643Z1a0=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=cTLo7vKJIMUkseuL5y2IEE1oOoD/BLeG3CGCzbP2tgPwWsChNPFr5q/Xw8pUeJkxXtF++alfqRTy3NwBGKoqszplAnDFdbeLT1uEfIwZGEHVMErwhXijbw6JZkH/J4zoCLeMchUnN3Rt2xs6kBiX27v2/6qQ/H1dHbKf6q2XNWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=nUZQyTok; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aTp3apWKdtVXSepo83cIFV0LN+laPuM1G8F4Zxr1ELk=; b=nUZQyTokrg0CL2fzLiTm6Tm+sB
	gGoSVwKKHRQb4N3nJMxV6JCJOzfVMpmOv6dpE2NeI40pUo3QDvfXO+yauheknpVSnKFtkMYwAY9Ao
	10Zru9d8v2rN7wGXYbPlHhXLVWA4Njn9xEYfLlI2nlE9pd8k0oCiNOd6LccoEGFdxCffNMtfunUDE
	pRD0LwV0GnA9vfaOn4c5VuNa9eRKnUiDNgwahRO0j/C6IXzsKa8DecUjYEsh+AtyDtpgDaI2il8yv
	8x91NJ/hTF2bkwzE9wuQ4hDN8zxm02Ff38RGBVkvviENKdy8x7oXJDLpToRKFBdmzMx9n5lcF8FLe
	UAVVY/Eg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53518 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u5SoK-0007gx-0o;
	Thu, 17 Apr 2025 18:14:00 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u5Sni-001IJk-Gi; Thu, 17 Apr 2025 18:13:22 +0100
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
Subject: [PATCH net-next v3 3/5] net: stmmac: socfpga: convert to
 stmmac_pltfr_pm_ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u5Sni-001IJk-Gi@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 17 Apr 2025 18:13:22 +0100

Convert socfpga to use the generic stmmac_pltfr_pm_ops, which can be
achieved by adding an appropriate plat_dat->init function to do the
setup.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 37 +------------------
 1 file changed, 2 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index c333ec07d15f..69ffc52c0275 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -493,6 +493,7 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 
 	plat_dat->bsp_priv = dwmac;
 	plat_dat->fix_mac_speed = socfpga_dwmac_fix_mac_speed;
+	plat_dat->init = socfpga_dwmac_init;
 	plat_dat->pcs_init = socfpga_dwmac_pcs_init;
 	plat_dat->pcs_exit = socfpga_dwmac_pcs_exit;
 	plat_dat->select_pcs = socfpga_dwmac_select_pcs;
@@ -516,40 +517,6 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	return ret;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int socfpga_dwmac_resume(struct device *dev)
-{
-	struct socfpga_dwmac *dwmac_priv = get_stmmac_bsp_priv(dev);
-
-	socfpga_dwmac_init(to_platform_device(dev), dwmac_priv);
-
-	return stmmac_resume(dev);
-}
-#endif /* CONFIG_PM_SLEEP */
-
-static int __maybe_unused socfpga_dwmac_runtime_suspend(struct device *dev)
-{
-	struct net_device *ndev = dev_get_drvdata(dev);
-	struct stmmac_priv *priv = netdev_priv(ndev);
-
-	stmmac_bus_clks_config(priv, false);
-
-	return 0;
-}
-
-static int __maybe_unused socfpga_dwmac_runtime_resume(struct device *dev)
-{
-	struct net_device *ndev = dev_get_drvdata(dev);
-	struct stmmac_priv *priv = netdev_priv(ndev);
-
-	return stmmac_bus_clks_config(priv, true);
-}
-
-static const struct dev_pm_ops socfpga_dwmac_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(stmmac_suspend, socfpga_dwmac_resume)
-	SET_RUNTIME_PM_OPS(socfpga_dwmac_runtime_suspend, socfpga_dwmac_runtime_resume, NULL)
-};
-
 static const struct socfpga_dwmac_ops socfpga_gen5_ops = {
 	.set_phy_mode = socfpga_gen5_set_phy_mode,
 };
@@ -570,7 +537,7 @@ static struct platform_driver socfpga_dwmac_driver = {
 	.remove = stmmac_pltfr_remove,
 	.driver = {
 		.name           = "socfpga-dwmac",
-		.pm		= &socfpga_dwmac_pm_ops,
+		.pm		= &stmmac_pltfr_pm_ops,
 		.of_match_table = socfpga_dwmac_match,
 	},
 };
-- 
2.30.2


