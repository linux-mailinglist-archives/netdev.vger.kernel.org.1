Return-Path: <netdev+bounces-198016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F41ADAD2A
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 12:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7448C166CDB
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 10:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA453275864;
	Mon, 16 Jun 2025 10:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fllwzxba"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FE927F000
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 10:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750069006; cv=none; b=BCLrw42+6FSIWYM1kLSCjQoiNgQJh2s0xrzFQU1Iw7l4SeINHnqIIpp9Wx/ooi1orLE40vn1nHJw3C9vcC9reHHHEX1DDbgscl+5h0IeL9g8hh2MC9Ff8zp9+wZX34K2sHvDniRMZbMT3xGPQts1T+hidK8+03huZr4yPCmIBys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750069006; c=relaxed/simple;
	bh=LY0/YPkigRGDeuX/OUp1vu33vv/e7lQknO/0cM2lLBY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=NBfGp9evbYaE/vCrMtBOzE78loC5k/zpOiTeKiZCDyMWMiQVxDIhJu2hGJv8f7HHCDpxxkIcqCGU72Goazf5eZSLPWtHN5CMwYyEpQRk+A0dSdWOoXGGrQGN0h/PBoPLI4sxqSknCvTg+M6vvoOZJUkOnU9Deo7sDfvPlHn99EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fllwzxba; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MpJ8ObVv/RACQZyToryrE4J8IiEvS1R3HdcT2AEL8uE=; b=fllwzxba+JH15SSlAVUaCvg/CT
	kATe/ukLMkMJAgEy7tcakxpuS7/03SM6ZLAmOeoCq+Fbbp9shFxhRnHYpYtI7wOF3dlgbZ+wpgXZr
	cn47N43pHszFFl6d+eqDQyOCgpPf+8m0JIldFsWQ/474NjQ2dmytrvqsmWBOj6TjHkMNXwjrYvmw9
	KiivsZvmhuhSu21BABxoERi3Oe6ttgAiHBJDdyIvzzR/VVQXJwdJbehGm/rV5dmdKWh4q+ad+BG33
	okm1mqmOngsZNZjkfiM1n4OSTtlKdrWnvCChJFZZQ/c1Nk+ffJZ1+BjP1s35Iq3GqP+T8pgXWWXtp
	EBoZfIIA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52686 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uR6tI-0003ah-2w;
	Mon, 16 Jun 2025 11:16:36 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uR6se-004Ktz-Dx; Mon, 16 Jun 2025 11:15:56 +0100
In-Reply-To: <aE_u8mCkUXEWTzJe@shell.armlinux.org.uk>
References: <aE_u8mCkUXEWTzJe@shell.armlinux.org.uk>
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
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 2/3] net: stmmac: rk: use device rather than platform
 device in rk_priv_data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uR6se-004Ktz-Dx@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 16 Jun 2025 11:15:56 +0100

All the code in dwmac-rk uses &bsp_priv->pdev->dev, nothing uses
bsp_priv->pdev directly. Store the struct device rather than the
struct platform_device in struct rk_priv_data, and simplifying the
code.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 5865a17d5fe8..7ee101a6cfcf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -67,7 +67,7 @@ enum rk_clocks_index {
 };
 
 struct rk_priv_data {
-	struct platform_device *pdev;
+	struct device *dev;
 	phy_interface_t phy_iface;
 	int id;
 	struct regulator *regulator;
@@ -248,7 +248,7 @@ static int px30_set_speed(struct rk_priv_data *bsp_priv,
 			  phy_interface_t interface, int speed)
 {
 	struct clk *clk_mac_speed = bsp_priv->clks[RK_CLK_MAC_SPEED].clk;
-	struct device *dev = &bsp_priv->pdev->dev;
+	struct device *dev = bsp_priv->dev;
 	unsigned int con1;
 	long rate;
 
@@ -1380,8 +1380,8 @@ static const struct rk_gmac_ops rv1126_ops = {
 static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
 {
 	struct rk_priv_data *bsp_priv = plat->bsp_priv;
-	struct device *dev = &bsp_priv->pdev->dev;
 	int phy_iface = bsp_priv->phy_iface;
+	struct device *dev = bsp_priv->dev;
 	int i, j, ret;
 
 	bsp_priv->clk_enabled = false;
@@ -1473,8 +1473,8 @@ static int gmac_clk_enable(struct rk_priv_data *bsp_priv, bool enable)
 static int phy_power_on(struct rk_priv_data *bsp_priv, bool enable)
 {
 	struct regulator *ldo = bsp_priv->regulator;
+	struct device *dev = bsp_priv->dev;
 	int ret;
-	struct device *dev = &bsp_priv->pdev->dev;
 
 	if (enable) {
 		ret = regulator_enable(ldo);
@@ -1598,7 +1598,7 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
 	dev_info(dev, "integrated PHY? (%s).\n",
 		 bsp_priv->integrated_phy ? "yes" : "no");
 
-	bsp_priv->pdev = pdev;
+	bsp_priv->dev = dev;
 
 	return bsp_priv;
 }
@@ -1618,7 +1618,7 @@ static int rk_gmac_check_ops(struct rk_priv_data *bsp_priv)
 			return -EINVAL;
 		break;
 	default:
-		dev_err(&bsp_priv->pdev->dev,
+		dev_err(bsp_priv->dev,
 			"unsupported interface %d", bsp_priv->phy_iface);
 	}
 	return 0;
@@ -1626,8 +1626,8 @@ static int rk_gmac_check_ops(struct rk_priv_data *bsp_priv)
 
 static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
 {
+	struct device *dev = bsp_priv->dev;
 	int ret;
-	struct device *dev = &bsp_priv->pdev->dev;
 
 	ret = rk_gmac_check_ops(bsp_priv);
 	if (ret)
@@ -1683,7 +1683,7 @@ static void rk_gmac_powerdown(struct rk_priv_data *gmac)
 	if (gmac->integrated_phy && gmac->ops->integrated_phy_powerdown)
 		gmac->ops->integrated_phy_powerdown(gmac);
 
-	pm_runtime_put_sync(&gmac->pdev->dev);
+	pm_runtime_put_sync(gmac->dev);
 
 	phy_power_on(gmac, false);
 	gmac_clk_enable(gmac, false);
-- 
2.30.2


