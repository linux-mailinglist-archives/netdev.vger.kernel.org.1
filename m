Return-Path: <netdev+bounces-156359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B35BA06296
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82D137A1CC6
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182251FF5EF;
	Wed,  8 Jan 2025 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pR9IZX7L"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841221FF1DB
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354928; cv=none; b=Xxt8MXF6/qhhN0FoZHq/dIGpUjCgOnOdGMs8gSotOmwzrXQCrWjqwJXJOtFATmCAProOiOuDT1lMwD9AL517uHgKdZ+p+908XGTU5jyBda/E8X99tRwnHVa8GdurQpv9CCnbCRd//dMyu/pmJpsjrW3vyCtxpGz/UaWwHuuDkuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354928; c=relaxed/simple;
	bh=cw7b9HVl5ZQLuPRuVGYbs3mQS5RtCYWc6JuBHqGmBas=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=a/VFU1SHpWZQpNcN1RoR6Eo70GmFcgIXgZgQwm2g99gILDq8jUcuXiDPbigwi83t8AugvL8IWlDfGlQwVPenQD3XFPSINHk7jUtzBVqBftkIdjcsK4W/QI1bXFNvKGrlnMlvq4eYsusC9HOo4gouMDZbrX7C3VezZj7vf1MeCOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pR9IZX7L; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TxomoAD9vFL3aVX1yAWGRcv8yG1Kn2x7q86Ya4Gi194=; b=pR9IZX7Lc89cSyR8ivmTGWVuwF
	TontVXDwGHvZbED3gPaiZ4/eaT8QPuSpHIBOklqraKnbydHxf3bVceBokbTr8slYaz6HTcJtHI+ZR
	XBARrJfi+/e0FPsM+qd4q4h8ogFb9eVyBSpdrzQ1p+7NMuWpJ+xRvg6o/n6IpQvGdUGAc22elFyID
	+cpOlpYI77g9BlxH3FyF/w/CTlz9k0nWtnZXxZWbv2ozw1vcLSI07LLCUbtMlTF3QisO2+PqUyPYt
	AQMgAHGr5auQ84ZOhqd9tZi4IX5z7vxgWZqkAGLE0VTId//YVTaLB2/CW3I/blFKZC1/JiVh2KIwf
	b5IIXOXA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46342 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tVZEU-0000wp-2a;
	Wed, 08 Jan 2025 16:48:38 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tVZEB-0002Ke-RZ; Wed, 08 Jan 2025 16:48:19 +0000
In-Reply-To: <Z36sHIlnExQBuFJE@shell.armlinux.org.uk>
References: <Z36sHIlnExQBuFJE@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v4 10/18] net: stmmac: convert to use
 phy_eee_rx_clock_stop()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tVZEB-0002Ke-RZ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 08 Jan 2025 16:48:19 +0000

Convert stmmac to use phy_eee_rx_clock_stop() to set the PHY receive
clock stop in LPI setting, rather than calling the legacy
phy_init_eee() function.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b6ac089bfec9..04477f1a5504 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1077,10 +1077,10 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 
 	stmmac_mac_set(priv, priv->ioaddr, true);
 	if (phy && priv->dma_cap.eee) {
-		priv->eee_active = phy->enable_tx_lpi &&
-			phy_init_eee(phy, !(priv->plat->flags &
-				STMMAC_FLAG_RX_CLK_RUNS_IN_LPI)) >= 0;
+		phy_eee_rx_clock_stop(phy, !(priv->plat->flags &
+					     STMMAC_FLAG_RX_CLK_RUNS_IN_LPI));
 		priv->tx_lpi_timer = phy->eee_cfg.tx_lpi_timer;
+		priv->eee_active = phy->enable_tx_lpi;
 		priv->eee_enabled = stmmac_eee_init(priv);
 		stmmac_set_eee_pls(priv, priv->hw, true);
 	}
-- 
2.30.2


