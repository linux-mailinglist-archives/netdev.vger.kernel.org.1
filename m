Return-Path: <netdev+bounces-234618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3C9C24B48
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 12:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 45CEC34D02F
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 11:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BA3343D9D;
	Fri, 31 Oct 2025 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="joABAYhG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8982FE053
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 11:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909042; cv=none; b=MPNrzRIZXNNcSuM+Si2ttUeFhU6W8iHwlIvg9wz7FiMH2xgY+euKjW/TknSW+Opt0FogUXkO/iIYdw5vLNp0SavdQK9h7QrA8bCUzqmQmEp28WeL0xxRz81UvqwPx1QJsHmBeTLuIK15uNbElmBdnzcvPJbuoLRCv5zEOvNocvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909042; c=relaxed/simple;
	bh=ewOE6YnT3j0Xu8woT0FrilxeSuCBz+Se1xNrBX55jeI=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=S4h9eOsiLDp4xwcs8jSH9Gn6whGCcDCYJakZrsxK1bihwtDDf01g2XJ9ZrGWSE5JTI/X9lTCBqt1qd0p0dhI94I9J7B02j5A3srSNggcDWRo5akGBEnDtm7f2Jt72pZu4+tAEETyiziQme0I4pnIBpzlvQkAQq4ncFdvSvRen1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=joABAYhG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=F9+uCkTTPZNitcXoasL3jxbNQG9cxbs2rnefJEzDKW0=; b=joABAYhGrqXg1LpCJ/57xmaHzs
	Joy9pfh00DUTWJrxapt5IQ8iU/TrR3I0S+p4RMyUwSRI27Nf/Sddz3PZkFJLMuww3lIuTL14iKaFE
	V6g/09pEEIq/s1Rl86FgEwnsWjvWhd7h+lqsghtMTAsqztSQBuiBIYp4RIlQ2wwPZ4ABkxSqJzU1z
	T7l4aMuhpDI/TP3n35qtkYnVosxfwUXg9p7b1rIA9Y/mys6xLnGXffOhaPrlXxGIY50UwpUORc2SF
	I35kWcofuGvmy/rCJNyNtRf/kqiogoDbWBCfmefc58OTUnIUxnKK2WTVNp4ilIKjIDqGPO5WiqD8I
	qqOlOtCQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35954 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vEn1X-000000006oz-1kl6;
	Fri, 31 Oct 2025 11:10:27 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vEn1W-0000000CHoi-2koP;
	Fri, 31 Oct 2025 11:10:26 +0000
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
Subject: [PATCH net-next] net: stmmac: imx: use phylink's interface mode for
 set_clk_tx_rate()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vEn1W-0000000CHoi-2koP@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 31 Oct 2025 11:10:26 +0000

imx_dwmac_set_clk_tx_rate() is passed the interface mode from phylink
which will be the same as plat_dat->phy_interface. Use the passed-in
interface mode rather than plat_dat->phy_interface.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 4268b9987237..147fa08d5b6e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -195,9 +195,6 @@ static void imx_dwmac_exit(struct platform_device *pdev, void *priv)
 static int imx_dwmac_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
 				     phy_interface_t interface, int speed)
 {
-	struct imx_priv_data *dwmac = bsp_priv;
-
-	interface = dwmac->plat_dat->phy_interface;
 	if (interface == PHY_INTERFACE_MODE_RMII ||
 	    interface == PHY_INTERFACE_MODE_MII)
 		return 0;
-- 
2.47.3


