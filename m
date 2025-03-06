Return-Path: <netdev+bounces-172610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B45A55865
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C99E57A9DD3
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 21:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B1D20E6FC;
	Thu,  6 Mar 2025 21:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="Tn39R7w2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3182063DD
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295414; cv=none; b=gtjKUelwnPue4FeBUfSh0mLUqN1cri0/dD72hg0v/gwCXKo5cgfjX+06jVzpGxaLZO+C0JbS47XJoY1tQbYuztJC3HRd3OW9S9Mui4GCNQhvIGhOAQkNiSFCO30BsOHA+7XrjB5tdIW2eSq8f8Xjh+GrqK95YEH2SFf/vPN3+/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295414; c=relaxed/simple;
	bh=9fSDn2xBVtnb2jfndnpuNIHpSc0xeeNrT3Qb50ApzPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QwsZY8aYENQcVIc0LqkHm5fYKgJKbHp6eO0JoA3pRKN+WFmGWWA2kL++cM7hoLzD66cu+x3gej2S88uuPzXQkU5FkC4A7WmB74T2VnLlrD8ijmf+hSkK0+rrQDUgSDyRuqDhf5ZiorS6fPv3i9EgzHYw9eBbDjkVlS38FMxt5Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=Tn39R7w2; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1741295412; bh=tqXzHpdb6Olp1PANz4c+wlUcYsphsIvloySoU21/Xn4=;
 b=Tn39R7w2XxUXwSofCZgHb9CWrh4j8MVoYYh6jPXXlb884itOb/i5o16DliIzKUQWaHVRXATFd
 FmXkxDZIyVjn+ZbXA0GdmrdPuOoGV+VXTTo8K7rsP5AxpM2SfQMWUtYbqNMkSMQfB2NqwRKtI7Y
 ZcvJiEE/yzuqrH9XQmD+odlMwuhIIl4TNblN/scE2oMrU940+z/QpQ1thuDIuBDVXUln40TSlQF
 EZzrRc4053Vu51MIffILNBT3MO3ifGikG/wYVeXPjLvzakbddMsbND2xWe9RRlmlHXcNwrVXZ04
 Ua+0ZHXK4jlCNLtc06fdDAtQMNtNDp08T6/v5ipXN1cw==
X-Forward-Email-ID: 67ca0f2ead3e70e1cd99d838
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 2/2] net: stmmac: dwmac-rk: Validate rockchip,grf and php-grf during probe
Date: Thu,  6 Mar 2025 21:09:46 +0000
Message-ID: <20250306210950.1686713-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306210950.1686713-1-jonas@kwiboo.se>
References: <20250306210950.1686713-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All Rockchip GMAC variants require writing to GRF to configure e.g.
interface mode and MAC rx/tx delay. The GRF syscon regmap is located
with help of a rockchip,grf and rockchip,php-grf phandle.

However, validating the rockchip,grf and rockchip,php-grf syscon regmap
is deferred until e.g. interface mode or speed is configured, inside the
indivitual SoC specific operations.

Change to validate the rockchip,grf and rockchip,php-grf syscon regmap
at probe time to simplify all SoC specific operations.

Prior to this, use of a device tree without a rockchip,grf would fail
when interface mode or speed is configured, with this use of such device
tree would instead result in failure at probe time.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 269 ++----------------
 1 file changed, 18 insertions(+), 251 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 79db81d68afd..ba1cd079adf2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -105,13 +105,6 @@ struct rk_priv_data {
 
 static void px30_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, PX30_GRF_GMAC_CON1,
 		     PX30_GMAC_PHY_INTF_SEL_RMII);
 }
@@ -185,13 +178,6 @@ static const struct rk_gmac_ops px30_ops = {
 static void rk3128_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RK3128_GRF_MAC_CON1,
 		     RK3128_GMAC_PHY_INTF_SEL_RGMII |
 		     RK3128_GMAC_RMII_MODE_CLR);
@@ -203,13 +189,6 @@ static void rk3128_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3128_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RK3128_GRF_MAC_CON1,
 		     RK3128_GMAC_PHY_INTF_SEL_RMII | RK3128_GMAC_RMII_MODE);
 }
@@ -218,11 +197,6 @@ static void rk3128_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	if (speed == 10)
 		regmap_write(bsp_priv->grf, RK3128_GRF_MAC_CON1,
 			     RK3128_GMAC_CLK_2_5M);
@@ -240,11 +214,6 @@ static void rk3128_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	if (speed == 10) {
 		regmap_write(bsp_priv->grf, RK3128_GRF_MAC_CON1,
 			     RK3128_GMAC_RMII_CLK_2_5M |
@@ -301,13 +270,6 @@ static const struct rk_gmac_ops rk3128_ops = {
 static void rk3228_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1,
 		     RK3228_GMAC_PHY_INTF_SEL_RGMII |
 		     RK3228_GMAC_RMII_MODE_CLR |
@@ -320,13 +282,6 @@ static void rk3228_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3228_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1,
 		     RK3228_GMAC_PHY_INTF_SEL_RMII |
 		     RK3228_GMAC_RMII_MODE);
@@ -339,11 +294,6 @@ static void rk3228_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	if (speed == 10)
 		regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1,
 			     RK3228_GMAC_CLK_2_5M);
@@ -361,11 +311,6 @@ static void rk3228_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	if (speed == 10)
 		regmap_write(bsp_priv->grf, RK3228_GRF_MAC_CON1,
 			     RK3228_GMAC_RMII_CLK_2_5M |
@@ -423,13 +368,6 @@ static const struct rk_gmac_ops rk3228_ops = {
 static void rk3288_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RK3288_GRF_SOC_CON1,
 		     RK3288_GMAC_PHY_INTF_SEL_RGMII |
 		     RK3288_GMAC_RMII_MODE_CLR);
@@ -441,13 +379,6 @@ static void rk3288_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3288_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RK3288_GRF_SOC_CON1,
 		     RK3288_GMAC_PHY_INTF_SEL_RMII | RK3288_GMAC_RMII_MODE);
 }
@@ -456,11 +387,6 @@ static void rk3288_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	if (speed == 10)
 		regmap_write(bsp_priv->grf, RK3288_GRF_SOC_CON1,
 			     RK3288_GMAC_CLK_2_5M);
@@ -478,11 +404,6 @@ static void rk3288_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	if (speed == 10) {
 		regmap_write(bsp_priv->grf, RK3288_GRF_SOC_CON1,
 			     RK3288_GMAC_RMII_CLK_2_5M |
@@ -515,13 +436,6 @@ static const struct rk_gmac_ops rk3288_ops = {
 
 static void rk3308_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RK3308_GRF_MAC_CON0,
 		     RK3308_GMAC_PHY_INTF_SEL_RMII);
 }
@@ -530,11 +444,6 @@ static void rk3308_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	if (speed == 10) {
 		regmap_write(bsp_priv->grf, RK3308_GRF_MAC_CON0,
 			     RK3308_GMAC_SPEED_10M);
@@ -587,13 +496,6 @@ static const struct rk_gmac_ops rk3308_ops = {
 static void rk3328_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RK3328_GRF_MAC_CON1,
 		     RK3328_GMAC_PHY_INTF_SEL_RGMII |
 		     RK3328_GMAC_RMII_MODE_CLR |
@@ -606,14 +508,8 @@ static void rk3328_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3328_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
 	unsigned int reg;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	reg = bsp_priv->integrated_phy ? RK3328_GRF_MAC_CON2 :
 		  RK3328_GRF_MAC_CON1;
 
@@ -626,11 +522,6 @@ static void rk3328_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	if (speed == 10)
 		regmap_write(bsp_priv->grf, RK3328_GRF_MAC_CON1,
 			     RK3328_GMAC_CLK_2_5M);
@@ -649,11 +540,6 @@ static void rk3328_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 	struct device *dev = &bsp_priv->pdev->dev;
 	unsigned int reg;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	reg = bsp_priv->integrated_phy ? RK3328_GRF_MAC_CON2 :
 		  RK3328_GRF_MAC_CON1;
 
@@ -714,13 +600,6 @@ static const struct rk_gmac_ops rk3328_ops = {
 static void rk3366_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RK3366_GRF_SOC_CON6,
 		     RK3366_GMAC_PHY_INTF_SEL_RGMII |
 		     RK3366_GMAC_RMII_MODE_CLR);
@@ -732,13 +611,6 @@ static void rk3366_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3366_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RK3366_GRF_SOC_CON6,
 		     RK3366_GMAC_PHY_INTF_SEL_RMII | RK3366_GMAC_RMII_MODE);
 }
@@ -747,11 +619,6 @@ static void rk3366_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	if (speed == 10)
 		regmap_write(bsp_priv->grf, RK3366_GRF_SOC_CON6,
 			     RK3366_GMAC_CLK_2_5M);
@@ -769,11 +636,6 @@ static void rk3366_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	if (speed == 10) {
 		regmap_write(bsp_priv->grf, RK3366_GRF_SOC_CON6,
 			     RK3366_GMAC_RMII_CLK_2_5M |
@@ -825,13 +687,6 @@ static const struct rk_gmac_ops rk3366_ops = {
 static void rk3368_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RK3368_GRF_SOC_CON15,
 		     RK3368_GMAC_PHY_INTF_SEL_RGMII |
 		     RK3368_GMAC_RMII_MODE_CLR);
@@ -843,13 +698,6 @@ static void rk3368_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3368_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RK3368_GRF_SOC_CON15,
 		     RK3368_GMAC_PHY_INTF_SEL_RMII | RK3368_GMAC_RMII_MODE);
 }
@@ -858,11 +706,6 @@ static void rk3368_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	if (speed == 10)
 		regmap_write(bsp_priv->grf, RK3368_GRF_SOC_CON15,
 			     RK3368_GMAC_CLK_2_5M);
@@ -880,11 +723,6 @@ static void rk3368_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	if (speed == 10) {
 		regmap_write(bsp_priv->grf, RK3368_GRF_SOC_CON15,
 			     RK3368_GMAC_RMII_CLK_2_5M |
@@ -936,13 +774,6 @@ static const struct rk_gmac_ops rk3368_ops = {
 static void rk3399_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RK3399_GRF_SOC_CON5,
 		     RK3399_GMAC_PHY_INTF_SEL_RGMII |
 		     RK3399_GMAC_RMII_MODE_CLR);
@@ -954,13 +785,6 @@ static void rk3399_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3399_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RK3399_GRF_SOC_CON5,
 		     RK3399_GMAC_PHY_INTF_SEL_RMII | RK3399_GMAC_RMII_MODE);
 }
@@ -969,11 +793,6 @@ static void rk3399_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	if (speed == 10)
 		regmap_write(bsp_priv->grf, RK3399_GRF_SOC_CON5,
 			     RK3399_GMAC_CLK_2_5M);
@@ -991,11 +810,6 @@ static void rk3399_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	if (speed == 10) {
 		regmap_write(bsp_priv->grf, RK3399_GRF_SOC_CON5,
 			     RK3399_GMAC_RMII_CLK_2_5M |
@@ -1040,14 +854,8 @@ static const struct rk_gmac_ops rk3399_ops = {
 static void rk3568_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
 	u32 con0, con1;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	con0 = (bsp_priv->id == 1) ? RK3568_GRF_GMAC1_CON0 :
 				     RK3568_GRF_GMAC0_CON0;
 	con1 = (bsp_priv->id == 1) ? RK3568_GRF_GMAC1_CON1 :
@@ -1064,14 +872,8 @@ static void rk3568_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3568_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
 	u32 con1;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	con1 = (bsp_priv->id == 1) ? RK3568_GRF_GMAC1_CON1 :
 				     RK3568_GRF_GMAC0_CON1;
 	regmap_write(bsp_priv->grf, con1, RK3568_GMAC_PHY_INTF_SEL_RMII);
@@ -1149,14 +951,8 @@ static const struct rk_gmac_ops rk3568_ops = {
 static void rk3576_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
 	unsigned int offset_con;
 
-	if (IS_ERR(bsp_priv->grf) || IS_ERR(bsp_priv->php_grf)) {
-		dev_err(dev, "Missing rockchip,grf or rockchip,php-grf property\n");
-		return;
-	}
-
 	offset_con = bsp_priv->id == 1 ? RK3576_GRF_GMAC_CON1 :
 					 RK3576_GRF_GMAC_CON0;
 
@@ -1182,14 +978,8 @@ static void rk3576_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3576_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
 	unsigned int offset_con;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	offset_con = bsp_priv->id == 1 ? RK3576_GRF_GMAC_CON1 :
 					 RK3576_GRF_GMAC_CON0;
 
@@ -1308,14 +1098,8 @@ static const struct rk_gmac_ops rk3576_ops = {
 static void rk3588_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
 	u32 offset_con, id = bsp_priv->id;
 
-	if (IS_ERR(bsp_priv->grf) || IS_ERR(bsp_priv->php_grf)) {
-		dev_err(dev, "Missing rockchip,grf or rockchip,php_grf property\n");
-		return;
-	}
-
 	offset_con = bsp_priv->id == 1 ? RK3588_GRF_GMAC_CON9 :
 					 RK3588_GRF_GMAC_CON8;
 
@@ -1335,13 +1119,6 @@ static void rk3588_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rk3588_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->php_grf)) {
-		dev_err(dev, "%s: Missing rockchip,php_grf property\n", __func__);
-		return;
-	}
-
 	regmap_write(bsp_priv->php_grf, RK3588_GRF_GMAC_CON0,
 		     RK3588_GMAC_PHY_INTF_SEL_RMII(bsp_priv->id));
 
@@ -1424,13 +1201,6 @@ static const struct rk_gmac_ops rk3588_ops = {
 
 static void rv1108_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RV1108_GRF_GMAC_CON0,
 		     RV1108_GMAC_PHY_INTF_SEL_RMII);
 }
@@ -1439,11 +1209,6 @@ static void rv1108_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
 	struct device *dev = &bsp_priv->pdev->dev;
 
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	if (speed == 10) {
 		regmap_write(bsp_priv->grf, RV1108_GRF_GMAC_CON0,
 			     RV1108_GMAC_RMII_CLK_2_5M |
@@ -1492,13 +1257,6 @@ static const struct rk_gmac_ops rv1108_ops = {
 static void rv1126_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "Missing rockchip,grf property\n");
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RV1126_GRF_GMAC_CON0,
 		     RV1126_GMAC_PHY_INTF_SEL_RGMII |
 		     RV1126_GMAC_M0_RXCLK_DLY_ENABLE |
@@ -1517,13 +1275,6 @@ static void rv1126_set_to_rgmii(struct rk_priv_data *bsp_priv,
 
 static void rv1126_set_to_rmii(struct rk_priv_data *bsp_priv)
 {
-	struct device *dev = &bsp_priv->pdev->dev;
-
-	if (IS_ERR(bsp_priv->grf)) {
-		dev_err(dev, "%s: Missing rockchip,grf property\n", __func__);
-		return;
-	}
-
 	regmap_write(bsp_priv->grf, RV1126_GRF_GMAC_CON0,
 		     RV1126_GMAC_PHY_INTF_SEL_RMII);
 }
@@ -1813,8 +1564,24 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
 
 	bsp_priv->grf = syscon_regmap_lookup_by_phandle(dev->of_node,
 							"rockchip,grf");
-	bsp_priv->php_grf = syscon_regmap_lookup_by_phandle(dev->of_node,
-							    "rockchip,php-grf");
+	if (IS_ERR(bsp_priv->grf)) {
+		ret = PTR_ERR(bsp_priv->grf);
+		dev_err_probe(dev, ret, "failed to lookup rockchip,grf\n");
+		return ERR_PTR(ret);
+	}
+
+	bsp_priv->php_grf =
+		syscon_regmap_lookup_by_phandle_optional(dev->of_node,
+							 "rockchip,php-grf");
+	if ((of_device_is_compatible(dev->of_node, "rockchip,rk3588-gmac") ||
+	     of_device_is_compatible(dev->of_node, "rockchip,rk3576-gmac")) &&
+	    !bsp_priv->php_grf)
+		bsp_priv->php_grf = ERR_PTR(-ENODEV);
+	if (IS_ERR(bsp_priv->php_grf)) {
+		ret = PTR_ERR(bsp_priv->php_grf);
+		dev_err_probe(dev, ret, "failed to lookup rockchip,php-grf\n");
+		return ERR_PTR(ret);
+	}
 
 	if (plat->phy_node) {
 		bsp_priv->integrated_phy = of_property_read_bool(plat->phy_node,
-- 
2.48.1


