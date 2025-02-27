Return-Path: <netdev+bounces-170172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4650A478E0
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 10:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88411705C2
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 09:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331132248BD;
	Thu, 27 Feb 2025 09:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xikXrqHk"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A47225762
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740647860; cv=none; b=OosJsJw09sLgl9Quh9AyJ6PDHU0GRQn0pZv2EaVuAAnt4Ie8dmCMPTXYp7SxFJzY2Nev4ddumLo2NFHZVyO86VqvyqUbUd8mdyU/LrsNJJS0Ub5xgDqFUdiV48lnOs26dPZqtUTJZi3Ob9tywpg3SQT2Qtb2BDGWfHmw7DQ9pC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740647860; c=relaxed/simple;
	bh=HIEsCit4jBgx/5e8SWB+lna/b22zNEqk1ku8pob8K74=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=btwcaaQFsv5COU6/40DHJNvu7pDHg9reLTSalfu235/gYvOqwuu1BUb8qSGmpRcQ2e4WPnWNy2m+ziAyS/jMxYNmCIW/tToGxgLnjjPb4QXhQGfCcYST/qWzvI0C0r2Hxv6rJKj3xUsovQ83U8CUvSYdnbBB+qHghFcABi4nLrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xikXrqHk; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iWnPECP85hSj80bfwjHgzvvanWg0iFIEd3mo6R2Ssbs=; b=xikXrqHkwfP9GNCfi+BVPe4Nwb
	et0s7E0VCYJN5fG5eKUAMEBzd8HRWpsJWXrejf7FZcFOlaKtEZLJyOZS+U2/bgVFWk3NAQjm8/MSW
	54rMdQbA2MxWIyuyFfMHqwWwXeUI+l3WblBMxYoSqhkWdQ0DUQIoTzZEX+kxOyGOWVojGo+5cqrrl
	6JixAOyo2xnOSx0GGBCY85hdzpsxDGGXHnjczs5SIbxTLziNXdhmC0smmLucsyqu7dYigWX7FmX/n
	41lEkpEbCTnga4KiuigfVyZ3zs7oH6nX25Dhmvnqhppy/NOZKaKUN16AitEd5o9OmvOYkBts1/cRP
	xSsOsYLQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38326 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tna1J-0006e3-2Q;
	Thu, 27 Feb 2025 09:17:29 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tna0z-0052tN-O1; Thu, 27 Feb 2025 09:17:09 +0000
In-Reply-To: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
References: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 10/11] net: stmmac: meson: switch to use
 set_clk_tx_rate() hook
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tna0z-0052tN-O1@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 27 Feb 2025 09:17:09 +0000

Switch from using the fix_mac_speed() hook to set_clk_tx_rate() to
manage the transmit clock.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
index b115b7873cef..07c504d07604 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c
@@ -22,9 +22,10 @@ struct meson_dwmac {
 	void __iomem	*reg;
 };
 
-static void meson6_dwmac_fix_mac_speed(void *priv, int speed, unsigned int mode)
+static int meson6_dwmac_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
+					phy_interface_t interface, int speed)
 {
-	struct meson_dwmac *dwmac = priv;
+	struct meson_dwmac *dwmac = bsp_priv;
 	unsigned int val;
 
 	val = readl(dwmac->reg);
@@ -39,6 +40,8 @@ static void meson6_dwmac_fix_mac_speed(void *priv, int speed, unsigned int mode)
 	}
 
 	writel(val, dwmac->reg);
+
+	return 0;
 }
 
 static int meson6_dwmac_probe(struct platform_device *pdev)
@@ -65,7 +68,7 @@ static int meson6_dwmac_probe(struct platform_device *pdev)
 		return PTR_ERR(dwmac->reg);
 
 	plat_dat->bsp_priv = dwmac;
-	plat_dat->fix_mac_speed = meson6_dwmac_fix_mac_speed;
+	plat_dat->set_clk_tx_rate = meson6_dwmac_set_clk_tx_rate;
 
 	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 }
-- 
2.30.2


