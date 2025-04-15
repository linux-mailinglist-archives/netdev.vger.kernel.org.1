Return-Path: <netdev+bounces-182800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 054EBA89ED3
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E5D1901F4A
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A996228E61D;
	Tue, 15 Apr 2025 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fKQ78xpx"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0C92973CE
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744721932; cv=none; b=ems33qZIfLaPnJKtK4O2FPQRnEaUmCjrte0ANB/jIxDFYKnDUrIJZzghAHGXAeeHgvF/t7maraaCqYJ7VOKi3M6PMPFdebLblp3thCCPkRpLBI8s8NwcBSCDFyRYP1krCsyhI6FqTMxBJ97u6MNwB8UTDGQpsPmuhx/mMTlSfU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744721932; c=relaxed/simple;
	bh=ITmQAG9x6l8XkHyjnRSvJ3v+GB6dENyqVdHPuelx8d4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=LtZHoqzF9Ux13tmM2NmWsHiJ5+o8D7SbPl+b+yKmEQZLrT6sbd8rLPpqmGZaT+Xsc2wR/5iepXUjcxUSoHTJGxC9By2vcqqJ1IHoZbThgBOKvm9JKQUJoeObtGCu6bkZ/T40TPlIWNZv9U+0sGfdzxQfHLSilG52tXsbtLqTMgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fKQ78xpx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nU1RZQP3gz6BlF36zUXcqwdullSwX6wrYvV0mrqTuc0=; b=fKQ78xpxpsbtfLUAyH0907v9/W
	SjC6gfxtB7ABm1y8VhvvfOKLHzDG0adiq4IiUXgFQVf6xiGAi7bxEOi/jQmakocEL6Kfex0myvUeG
	IbbmuuashVUfdjwRu2Y1hpwifWt+eHTf6XWJnDviVSrUVxsLvqlioSArtpcK0kv9XEi28EvzIbcP6
	6166vYLtwm3tb8AYH98sj4vlNS4d2c9bOeyB+szlt2uFKad2xMmdP6erGyqdOin3V6jTUeYQI0HCy
	R508EWlyF6IsxnRTvoeJCPArg9kTxpvDmYA3e7xqKpGXiUiQkTXyAG0EVslSPA7wlV0VolbdRLpph
	lAo3DzMw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55886 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u4fsA-0008C8-2P;
	Tue, 15 Apr 2025 13:58:42 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u4frZ-000nMl-BB; Tue, 15 Apr 2025 13:58:05 +0100
In-Reply-To: <Z_5WT_jOBgubjWQg@shell.armlinux.org.uk>
References: <Z_5WT_jOBgubjWQg@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chen-Yu Tsai <wens@csie.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Samuel Holland <samuel@sholland.org>
Subject: [PATCH net-next 2/3] net: stmmac: sunxi: use stmmac_pltfr_probe()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u4frZ-000nMl-BB@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 15 Apr 2025 13:58:05 +0100

Rather than open-coding the calls to sun7i_gmac_init() and
sun7i_gmac_exit() in the probe function, use stmmac_pltfr_probe()
which will automatically call the plat_dat->init() and plat_dat->exit()
methods appropriately. This simplifies the code.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
index a245c223a18f..665eab1d3409 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
@@ -144,20 +144,7 @@ static int sun7i_gmac_probe(struct platform_device *pdev)
 	plat_dat->tx_fifo_size = 4096;
 	plat_dat->rx_fifo_size = 16384;
 
-	ret = sun7i_gmac_init(pdev, plat_dat->bsp_priv);
-	if (ret)
-		return ret;
-
-	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
-	if (ret)
-		goto err_gmac_exit;
-
-	return 0;
-
-err_gmac_exit:
-	sun7i_gmac_exit(pdev, plat_dat->bsp_priv);
-
-	return ret;
+	return stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 }
 
 static const struct of_device_id sun7i_dwmac_match[] = {
-- 
2.30.2


