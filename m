Return-Path: <netdev+bounces-212585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D7FB214F3
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 20:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07CC7460CFC
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACF42E2DC4;
	Mon, 11 Aug 2025 18:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="t0rlPxPG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9540B2E2DDF
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754938345; cv=none; b=drUZT89A595EBx0HS443EHhZ9AyRUt1R5nmJe5ZtqeKFGB+HcSloG8KVk12joQ/czHAiZeCsbPZMcVT/mHOtDOjVeYy/W3o8zUq1cXHRBa65R0beTJGdS0J0YD56LkszQ/HRvPcG672eW60taKlSPOJ8OUoJTJoyMdGCODNYkz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754938345; c=relaxed/simple;
	bh=u1/POVrV5dvYov5jr1v2rC7ceqeWgK1N1jo1mRMFOxU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=bx1za8QS9T0qENBRiig3POFpey11GUSN22iHUweeN+EohbUYXofCvv/U6Vs3sbAdG0dcCWIgRs31bCsR8npvUel0KKhc3tDkRhtCowSzwSsJBmAIml2fMcSborULH70LOBMEH4YEdW1FMQuvaRr1lKJPW7F/rzZEqvgqDBF+aTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=t0rlPxPG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=M/S0cJbJg5QrypEk+l+ONw5GMA5PTBkjJDdcSmQljP8=; b=t0rlPxPGDH5hefPQCFywuhyeMV
	3u4/KinXn1lXtGJzStGXo0GOzimLzSy82f8lXcrSc5tVYFymIhKAd34+OJpjJQ4FWOTlmurw+RRY8
	19BELTfMZ+RNlXQfwfhMeIyv7zkD+zO/FlSYsKjcKypS1I7usZgMm0mIJzzqS3AXngMYn+NmwZpnI
	V5ius7P0Aff0wDeAXQaeEfkw/Ern8maQTVhqPKw7TwxqlpbjvKnvsBqcutBNx3t0u6cOlyt9V1w16
	+zboN9a7GeydNKBTtJ8GbEkS8ufMyswDWjMkoJkNzasmWLVpHWPC/dFYSqmkhJRu05vBQFpTqc4TY
	Y50M6npQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36320 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1ulXcw-0003cQ-1b;
	Mon, 11 Aug 2025 19:52:10 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1ulXcC-008grN-Hc; Mon, 11 Aug 2025 19:51:24 +0100
In-Reply-To: <aJo7kvoub5voHOUQ@shell.armlinux.org.uk>
References: <aJo7kvoub5voHOUQ@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 9/9] net: stmmac: mediatek: convert to resume()
 method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ulXcC-008grN-Hc@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 11 Aug 2025 19:51:24 +0100

Convert mediatek to use the resume() platform method rather than the
init() platform method as mediatek_dwmac_init() is only called from
the resume paths.

This will ensure that in a future commit, mediatek_dwmac_init() won't
be called when probing the main part of the stmmac driver.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
index 39421d6a34e4..f1b36f0a401d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -523,7 +523,7 @@ static int mediatek_dwmac_clk_init(struct mediatek_dwmac_plat_data *plat)
 	return ret;
 }
 
-static int mediatek_dwmac_init(struct platform_device *pdev, void *priv)
+static int mediatek_dwmac_init(struct device *dev, void *priv)
 {
 	struct mediatek_dwmac_plat_data *plat = priv;
 	const struct mediatek_dwmac_variant *variant = plat->variant;
@@ -532,7 +532,7 @@ static int mediatek_dwmac_init(struct platform_device *pdev, void *priv)
 	if (variant->dwmac_set_phy_interface) {
 		ret = variant->dwmac_set_phy_interface(plat);
 		if (ret) {
-			dev_err(plat->dev, "failed to set phy interface, err = %d\n", ret);
+			dev_err(dev, "failed to set phy interface, err = %d\n", ret);
 			return ret;
 		}
 	}
@@ -540,7 +540,7 @@ static int mediatek_dwmac_init(struct platform_device *pdev, void *priv)
 	if (variant->dwmac_set_delay) {
 		ret = variant->dwmac_set_delay(plat);
 		if (ret) {
-			dev_err(plat->dev, "failed to set delay value, err = %d\n", ret);
+			dev_err(dev, "failed to set delay value, err = %d\n", ret);
 			return ret;
 		}
 	}
@@ -589,7 +589,7 @@ static int mediatek_dwmac_common_data(struct platform_device *pdev,
 	plat->maxmtu = ETH_DATA_LEN;
 	plat->host_dma_width = priv_plat->variant->dma_bit_mask;
 	plat->bsp_priv = priv_plat;
-	plat->init = mediatek_dwmac_init;
+	plat->resume = mediatek_dwmac_init;
 	plat->clks_config = mediatek_dwmac_clks_config;
 
 	plat->safety_feat_cfg = devm_kzalloc(&pdev->dev,
@@ -654,7 +654,7 @@ static int mediatek_dwmac_probe(struct platform_device *pdev)
 		return PTR_ERR(plat_dat);
 
 	mediatek_dwmac_common_data(pdev, plat_dat, priv_plat);
-	mediatek_dwmac_init(pdev, priv_plat);
+	mediatek_dwmac_init(&pdev->dev, priv_plat);
 
 	ret = mediatek_dwmac_clks_config(priv_plat, true);
 	if (ret)
-- 
2.30.2


