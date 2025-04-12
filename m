Return-Path: <netdev+bounces-181879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 469FAA86BCD
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 10:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA59D1B67319
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 08:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DAF19B586;
	Sat, 12 Apr 2025 08:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XBA4nphc"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09CB199238
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 08:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744445368; cv=none; b=VMeqDDh/NMhmGx9PfXG3xR3Ps25BFqeYgb0tMoVM/D7mKpbch+/hoGVScYMDq4b4fjtueKGAJ1PdPseiq/hfN2Zykq9wS2DbzS0L4ddYzBW4GvhJ57KQHsKEd0eLeNgeSeJL94qbvaLI6AYlCF+zXr6PdlwokB3oOIJ5QvkWjbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744445368; c=relaxed/simple;
	bh=CKE6Te7RSCVf4Om8ITWks4FxihpUKdN3eoV8GgfyKqc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Nh6Ef2VkH02uA/3VX0okOWifYyjBuw5edgfdNrvAoovDe/9X+4npZ5VgL9QvlbVcEKZ8xve3ZKko3a0fk8An9fVbXj+kTCiCpSTmviofwZJknhZklfyyuGng3T7fDTCl86AH6m0KwYAL8Qf/LnaWDOIHPtM286mbFHpEHb4sdRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=XBA4nphc; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XQd32sdl+fRSmh8Brlhe3sM7lTnHOxR88TKi6LoNcBY=; b=XBA4nphcVi0vDEM8VQlVZsSdNy
	qeU9eE/20ys3vrLwYFoPkTFzAneVQLJKkNj8ihpugQ3fMRNWvCfhCXyOO6lgJN71jujHKHkcC8evB
	pME2Jb14yY66oryPThM4GBYbF6fUhmgYLLpQLvCCol16gtvBmxg5YVbbiY+OvfdJ+MVdVPlGgzv8D
	oWOCq8mjoZaPmdPRZ7b+fYeuc59YZi2F7NLhAUCo8uHtUCAlXOtBBunKQaVBybfw6aTE3wdw2f+Tj
	CS7U77c7TjC/pHl0T6TpFLy1tLJTT+MYSTtxqR+OmR+G+/FnvBAdkZM9UzBZI4rFqmyJrbaxiL78d
	YctzxBdw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42092 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u3VvR-0004MK-1A;
	Sat, 12 Apr 2025 09:09:17 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u3Vuq-000E7s-5Y; Sat, 12 Apr 2025 09:08:40 +0100
In-Reply-To: <Z_oe0U5E0i3uZbop@shell.armlinux.org.uk>
References: <Z_oe0U5E0i3uZbop@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v2 3/5] net: stmmac: intel-plat: remove
 eee_usecs_rate and hardware write
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u3Vuq-000E7s-5Y@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 12 Apr 2025 09:08:40 +0100

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

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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


