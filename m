Return-Path: <netdev+bounces-212166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9E4B1E82F
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 14:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DC437A5FBA
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 12:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB8C27700C;
	Fri,  8 Aug 2025 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zhtgFgOT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC39273816
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754655454; cv=none; b=Ql7WlM9WAjNxK1sqXe+7R2vNloUAkOPMamzxCP5oCtUmgdhPmc8nQWN5DMfAdYW/C75u5Yx3PLGVuGZ7lycM7blSREWOC5CdgEBcG4EaUuax2QqckQDjVXN6yPqckkbILQi8ic/Ih7nBOC67pub9QJlR1jfqsJ+5N/2qbhMHjOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754655454; c=relaxed/simple;
	bh=Ziu9F2qt4pjNMGS4o9LpfdxpIEPcr2MEUYffRY2BkwM=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=tUrz32hXtML9m8pKr3SQNyx47pneRz/MEY46tJzwSgkVmk/XmnH1ZQwVvUdDS8pnSg9QWw+pKUWkil5Ya2fJvvmUM3PJmIHi1SasVzrPhJLyqKbAB0PCziSyAAHjDIbJW3gHnmQU4AWxPL51T5ex4JS4/PHsiL5nu4T6BIgS1IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zhtgFgOT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2FzBoXIxcZVkbVHJFLWQcEdWdrkGqtJVfXXxBAhEpkU=; b=zhtgFgOTmNI0iXvJmndtzAHEfz
	JP1V5GKLViXtZAOPj5hiniBuJPdLs7vRYITMXoXN0nOAOsP91CyOiWZ/Y53vFoX8gY/hDMxuEm2k1
	Bcu4H1tYP3jBZjACeZxXmCkrc6HccX6SQAfJ3oTk4eLC06xEE4lvq6cTejMAaQbQbegCwA4cvxKfh
	WS7EDZ/Qk5s/1E6PwF2LYi2rvS5Gts9O4KU1ULN0dMup4vElCcCHqZMKZez2FpCwdj0TGtjRqr58d
	rexwQQsLSrii+Ctb2XWMC79E4+7ObgXNpxCxpzgwhDmfaNpDDYMXbn46I/V/f8aB6OPRMEd7aLM21
	M9qh50GA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41686 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1ukM2G-0007Zg-0D;
	Fri, 08 Aug 2025 13:17:24 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1ukM1X-0086qu-Td; Fri, 08 Aug 2025 13:16:39 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>
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
Subject: [PATCH net] net: stmmac: dwc-qos: fix clk prepare/enable leak on
 probe failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ukM1X-0086qu-Td@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 08 Aug 2025 13:16:39 +0100

dwc_eth_dwmac_probe() gets bulk clocks, and then prepares and enables
them. Unfortunately, if dwc_eth_dwmac_config_dt() or stmmac_dvr_probe()
fail, we leave the clocks prepared and enabled. Fix this by using
devm_clk_bulk_get_all_enabled() to combine the steps and provide devm
based release of the prepare and enable state.

This also fixes a similar leakin dwc_eth_dwmac_remove() which wasn't
correctly retrieving the struct plat_stmmacenet_data. This becomes
unnecessary.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index 09ae16e026eb..6c363f9b0ce2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -330,15 +330,11 @@ static int dwc_eth_dwmac_probe(struct platform_device *pdev)
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
-	ret = devm_clk_bulk_get_all(&pdev->dev, &plat_dat->clks);
+	ret = devm_clk_bulk_get_all_enabled(&pdev->dev, &plat_dat->clks);
 	if (ret < 0)
-		return dev_err_probe(&pdev->dev, ret, "Failed to retrieve all required clocks\n");
+		return dev_err_probe(&pdev->dev, ret, "Failed to retrieve and enable all required clocks\n");
 	plat_dat->num_clks = ret;
 
-	ret = clk_bulk_prepare_enable(plat_dat->num_clks, plat_dat->clks);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "Failed to enable clocks\n");
-
 	plat_dat->stmmac_clk = stmmac_pltfr_find_clk(plat_dat,
 						     data->stmmac_clk_name);
 
@@ -346,7 +342,6 @@ static int dwc_eth_dwmac_probe(struct platform_device *pdev)
 		ret = data->probe(pdev, plat_dat, &stmmac_res);
 	if (ret < 0) {
 		dev_err_probe(&pdev->dev, ret, "failed to probe subdriver\n");
-		clk_bulk_disable_unprepare(plat_dat->num_clks, plat_dat->clks);
 		return ret;
 	}
 
@@ -370,15 +365,11 @@ static int dwc_eth_dwmac_probe(struct platform_device *pdev)
 static void dwc_eth_dwmac_remove(struct platform_device *pdev)
 {
 	const struct dwc_eth_dwmac_data *data = device_get_match_data(&pdev->dev);
-	struct plat_stmmacenet_data *plat_dat = dev_get_platdata(&pdev->dev);
 
 	stmmac_dvr_remove(&pdev->dev);
 
 	if (data->remove)
 		data->remove(pdev);
-
-	if (plat_dat)
-		clk_bulk_disable_unprepare(plat_dat->num_clks, plat_dat->clks);
 }
 
 static const struct of_device_id dwc_eth_dwmac_match[] = {
-- 
2.30.2


