Return-Path: <netdev+bounces-182799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C15A89ED4
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 14:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60193AC840
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B092F2973A2;
	Tue, 15 Apr 2025 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vMSvp3kf"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB25F27B51D
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744721929; cv=none; b=XcvhWrNs+PnmHXFimBtdWmjztGXF9JDUUCuNWkw8b/B6Pw/LstT1SoXJHB3z+2tQVhTS10Q9wYM3WCEFIhjfW40VMFSkZFAmI9IyVKaN1LqaQHbfnBr7CjpIgDEwRE+krBeLPFxK+333/DBNKoLPZTjA9mEoEOoVL/5rzmJnAmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744721929; c=relaxed/simple;
	bh=pN9nldC3K3CU35BgEMV427S0t04Jyo8q+4oiAAoZZls=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=JI34eaUewrP5eSQAYnjdLJ+iqExp65LJpGQacMFjK4ms/o3F8p9gvxIREsCtoOi6N4cL2IzJz1uZrDWb5eW1CUX+tuaUVkWkCaT1HNbVUd2AMwRw3hhYxh1uRaNJBX9MZAQR8nnJHeiWZZF9T8HoEzWixzpW/5wVCG1q9hnM7so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vMSvp3kf; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NEfpJshR6Sfriowq4GQ0FM8g/G2gger1/qz9A6JvWeQ=; b=vMSvp3kfcZkZz1BBI1ZLsx2tfT
	7koMQYU6EWjS/2Dmh8m1EgqGu64fQqFBJcNy/6JZGVAjtx7Io4xHV51WYbtrj6JbnBYDHRzH8n7Vh
	F6jouX8VpsmmvUQiRJjwraVipM6+fkU1/UpmS6mLxee9XvGmPWcm2+47B7lpsPoYDQynkf0E81g3K
	0HDbnLm1Q4Hf4LnLygsQrUDRWGFIkqKsu9dL2yGacKvx9yI+jZbzGTGUksdnahEXkairEk3FGHtKc
	k4awzckzgPy2T75Y/B5YcGxhTHnRUEBEaCftXaarDf16IYw0uzfuSyqTQrb2Ef3qyQ7ySRJbFOIh8
	au1KZ/SQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52848 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u4fs5-0008Bw-1i;
	Tue, 15 Apr 2025 13:58:37 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u4frU-000nMf-6o; Tue, 15 Apr 2025 13:58:00 +0100
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
Subject: [PATCH net-next 1/3] net: stmmac: sunxi: convert to set_clk_tx_rate()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u4frU-000nMf-6o@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 15 Apr 2025 13:58:00 +0100

Convert sunxi to use the set_clk_tx_rate() callback rather than the
fix_mac_speed() callback.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-sunxi.c | 42 +++++++++----------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
index 9f098ff0ff05..a245c223a18f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c
@@ -72,28 +72,28 @@ static void sun7i_gmac_exit(struct platform_device *pdev, void *priv)
 		regulator_disable(gmac->regulator);
 }
 
-static void sun7i_fix_speed(void *priv, int speed, unsigned int mode)
+static int sun7i_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
+				 phy_interface_t interface, int speed)
 {
-	struct sunxi_priv_data *gmac = priv;
-
-	/* only GMII mode requires us to reconfigure the clock lines */
-	if (gmac->interface != PHY_INTERFACE_MODE_GMII)
-		return;
-
-	if (gmac->clk_enabled) {
-		clk_disable(gmac->tx_clk);
-		gmac->clk_enabled = 0;
-	}
-	clk_unprepare(gmac->tx_clk);
-
-	if (speed == 1000) {
-		clk_set_rate(gmac->tx_clk, SUN7I_GMAC_GMII_RGMII_RATE);
-		clk_prepare_enable(gmac->tx_clk);
-		gmac->clk_enabled = 1;
-	} else {
-		clk_set_rate(gmac->tx_clk, SUN7I_GMAC_MII_RATE);
-		clk_prepare(gmac->tx_clk);
+	struct sunxi_priv_data *gmac = bsp_priv;
+
+	if (interface == PHY_INTERFACE_MODE_GMII) {
+		if (gmac->clk_enabled) {
+			clk_disable(gmac->tx_clk);
+			gmac->clk_enabled = 0;
+		}
+		clk_unprepare(gmac->tx_clk);
+
+		if (speed == 1000) {
+			clk_set_rate(gmac->tx_clk, SUN7I_GMAC_GMII_RGMII_RATE);
+			clk_prepare_enable(gmac->tx_clk);
+			gmac->clk_enabled = 1;
+		} else {
+			clk_set_rate(gmac->tx_clk, SUN7I_GMAC_MII_RATE);
+			clk_prepare(gmac->tx_clk);
+		}
 	}
+	return 0;
 }
 
 static int sun7i_gmac_probe(struct platform_device *pdev)
@@ -140,7 +140,7 @@ static int sun7i_gmac_probe(struct platform_device *pdev)
 	plat_dat->bsp_priv = gmac;
 	plat_dat->init = sun7i_gmac_init;
 	plat_dat->exit = sun7i_gmac_exit;
-	plat_dat->fix_mac_speed = sun7i_fix_speed;
+	plat_dat->set_clk_tx_rate = sun7i_set_clk_tx_rate;
 	plat_dat->tx_fifo_size = 4096;
 	plat_dat->rx_fifo_size = 16384;
 
-- 
2.30.2


