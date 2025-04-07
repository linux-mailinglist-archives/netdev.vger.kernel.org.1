Return-Path: <netdev+bounces-179871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49962A7ECA3
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94689189DC28
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBB22222DC;
	Mon,  7 Apr 2025 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hidQfRU5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC0B217F5D
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744052382; cv=none; b=QpKYTO+aicG+i7vBAL+oW5/9UN1Anh+Ixrjgu+XEL19HHUUzaGfQIr4o6/Kw/SXpXC1fSHSrDTj+tNXBHsuX6t8MoEyYR31b7HPLlvVGs3fxhciMiBHeTuPU4W42QTDfiBAz5ygQTsMy8Nx6W7xsH+pWuMMkYmyfu4Mb6NWc4n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744052382; c=relaxed/simple;
	bh=o9O+qBAEezw9fQExdSlnXB9+tj0ZdO3/qsc/pYlu2kI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=rCZ5Ch1jdQr3oUUSsxGFyhzI2zrKhVf5Y5y7cGBFjIWi6WdTYKGt+QzMtG9y2LQIrzrupAw0DHRpf9GJ5iBu8gl/DLVnLB/f1HZ1EQSyBt9UL8c5edevfo8scOlKWJustdbPUHMgstDttmVZqsdU0YztG++xrSF7Z7BLIZWMBw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hidQfRU5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xTONaCMGO+N+NO9JMd3j9lruIEiRtelFCdK2KAx5w+M=; b=hidQfRU5Rh4JiHeynMmBEAIf+H
	gzkvRXc9w95+J87NeqpP4x6NPTNpx+Q3uXkguxSQ11KGk5UGbqaoL98obnOMRMutn2185KmavdbPv
	0YM45uW+cMvN8vfoCoeQWb6hOEEcRD2wL6LO4FvNpGx+OVfYdy20KHXY2LXbVxzane4Q5WZffWTGK
	NKfeCOci9TDgP+7oL8YTmvwSoVSGMzeYDG7+mE16BWaUfLvj8TUH/eg/WdFqUaxp90K/Q1H6PEj/N
	a+hsin3gVpPrUDpbMCc851uNyZ9OWoq58ia+NVZGpTA7wOuRjmPJzHkl916SsTpOHJ0yahzwBPWy7
	1+BOv8bA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44378 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u1rgz-00069s-0v;
	Mon, 07 Apr 2025 19:59:33 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u1rgT-0013gp-97; Mon, 07 Apr 2025 19:59:01 +0100
In-Reply-To: <Z_QgOTC1hOSkIdur@shell.armlinux.org.uk>
References: <Z_QgOTC1hOSkIdur@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Richard Cochran <richardcochran@gmail.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH net-next 3/5] net: stmmac: intel-plat: remove eee_usecs_rate
 and hardware write
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u1rgT-0013gp-97@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 07 Apr 2025 19:59:01 +0100

Remove the write to GMAC_1US_TIC_COUNTER for two reasons:

1. during initialisation or reinitialisation of the DWMAC core, the
   core is reset, which sets this register back to its default value.
   Writing it prior to stmmac_dvr_probe() has no effect.

2. Since commit 8efbdbfa9938 ("net: stmmac: Initialize
   MAC_ONEUS_TIC_COUNTER register"), GMAC4/5 core code will set
   this register based on the rate of plat->stmmac_clk. This clock
   is fetched by devm_stmmac_probe_config_dt(), and plat->clk_ptp_rate
   will be set to its rate profided a "ptp_ref" clock is not provided.
   In any case, Marek's commit will set the effectual value of this
   register.

Therefore, dwmac-intel-plat.c writing GMAC_1US_TIC_COUNTER serves no
useful purpose and can be removed.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
index 599def7b3a64..4ea7b0a803d7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
@@ -113,16 +113,7 @@ static int intel_eth_plat_probe(struct platform_device *pdev)
 
 	plat_dat->clk_tx_i = dwmac->tx_clk;
 	plat_dat->set_clk_tx_rate = stmmac_set_clk_tx_rate;
-
 	plat_dat->bsp_priv = dwmac;
-	plat_dat->eee_usecs_rate = plat_dat->clk_ptp_rate;
-
-	if (plat_dat->eee_usecs_rate > 0) {
-		u32 tx_lpi_usec;
-
-		tx_lpi_usec = (plat_dat->eee_usecs_rate / 1000000) - 1;
-		writel(tx_lpi_usec, stmmac_res.addr + GMAC_1US_TIC_COUNTER);
-	}
 
 	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 	if (ret)
-- 
2.30.2


