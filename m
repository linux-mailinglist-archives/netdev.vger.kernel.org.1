Return-Path: <netdev+bounces-197053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3092AD76CD
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C0B166D17
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7B129AB02;
	Thu, 12 Jun 2025 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1TG4tLv2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F417529AB15
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742910; cv=none; b=q6B7/BU1Id6DYo9MSfI4uo2askXqfk6yZKdDRpFurI5IXz8TeIh9RzyCxYAn+VyocxzOpniRFsrhJ2Ci6MOld0BCJCGov7S23kIH4HFYOrM8XYKbMmieWRV+OBFYPrE5GUCmcUx5BzTMePXiUumMKLz5SPH56vIXfgy4NDpWqyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742910; c=relaxed/simple;
	bh=tWV1Yq0joqnU6aZpaWnfe/4XxgfVx+O51T8oCEVkKXU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=G8iawMFbqL6BlHLOsid6N9DjIx+G2QzBENtPLyKf23CVJUNfaAvc/KUBB03SY6ZfDjTmuGVoDvAZ2TcmvtT34dZNHqcZLCyuTNi7lZO6kSJKb4eU13TJ4WJs34/ef9nri+munHbSCVUyxfcMAxi/bCx27aEaVmQc40lsrMMucsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1TG4tLv2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yQLvAMlBoc+O8/PXh9aQdp3tD2l4mBUqyz4wkh6SGH4=; b=1TG4tLv2IRXe17/uJVDLMvSBbh
	en7Q/M3iwCvQcOF4N7M8DsrK7DfvopZjphMr0jZDMc63c3o2hGpIX/hmcDpB2xRSHsgHGmK6mvZAf
	qHtiCV0XSD8IwE1m1jNMuOZs5h5nF7Nm/ypkxBNY1igcPJNeuaeXb20zQtkLq+KkAaozEwzl08vRk
	DpWHWlxLBl4Tu90/+FuDbjvr7f1hP9CsF+SkQ6ir0hPKaixs0Gekuk+mRz/tbSkiDFW/jYiBpkqaG
	latDpVhE6AY/vDNhbcaBnp4SPZOTZYl5mbQPEzoyDLPf1XN5ZUIj7lRxikR7w443ysaKubpkqB0fw
	n9qcbmOQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58298 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uPk3i-00084L-1K;
	Thu, 12 Jun 2025 16:41:42 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uPk34-004CFZ-3y; Thu, 12 Jun 2025 16:41:02 +0100
In-Reply-To: <aEr1BhIoC6-UM2XV@shell.armlinux.org.uk>
References: <aEr1BhIoC6-UM2XV@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 5/9] net: stmmac: rk: combine clk_mac_speed rate
 setting functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uPk34-004CFZ-3y@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 12 Jun 2025 16:41:02 +0100

rk3568_set_gmac_speed() and rv1126_set_clk_mac_speed() are now
identical. Combine these so we have a single copy of this code.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 65 +++++++------------
 1 file changed, 23 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index c7b64f0a2931..eeef11b60566 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -153,6 +153,25 @@ static int rk_set_reg_speed_rmii(struct rk_priv_data *bsp_priv,
 				speed);
 }
 
+static void rk_set_clk_mac_speed(struct rk_priv_data *bsp_priv, int speed)
+{
+	struct clk *clk_mac_speed = bsp_priv->clks[RK_CLK_MAC_SPEED].clk;
+	struct device *dev = &bsp_priv->pdev->dev;
+	long rate;
+	int ret;
+
+	rate = rgmii_clock(speed);
+	if (rate < 0) {
+		dev_err(dev, "unknown speed value for GMAC speed=%d", speed);
+		return;
+	}
+
+	ret = clk_set_rate(clk_mac_speed, rate);
+	if (ret)
+		dev_err(dev, "%s: set clk_mac_speed rate %ld failed %d\n",
+			__func__, rate, ret);
+}
+
 #define HIWORD_UPDATE(val, mask, shift) \
 		((val) << (shift) | (mask) << ((shift) + 16))
 
@@ -1113,30 +1132,11 @@ static void rk3568_set_to_rmii(struct rk_priv_data *bsp_priv)
 	regmap_write(bsp_priv->grf, con1, RK3568_GMAC_PHY_INTF_SEL_RMII);
 }
 
-static void rk3568_set_gmac_speed(struct rk_priv_data *bsp_priv, int speed)
-{
-	struct clk *clk_mac_speed = bsp_priv->clks[RK_CLK_MAC_SPEED].clk;
-	struct device *dev = &bsp_priv->pdev->dev;
-	long rate;
-	int ret;
-
-	rate = rgmii_clock(speed);
-	if (rate < 0) {
-		dev_err(dev, "unknown speed value for GMAC speed=%d", speed);
-		return;
-	}
-
-	ret = clk_set_rate(clk_mac_speed, rate);
-	if (ret)
-		dev_err(dev, "%s: set clk_mac_speed rate %ld failed %d\n",
-			__func__, rate, ret);
-}
-
 static const struct rk_gmac_ops rk3568_ops = {
 	.set_to_rgmii = rk3568_set_to_rgmii,
 	.set_to_rmii = rk3568_set_to_rmii,
-	.set_rgmii_speed = rk3568_set_gmac_speed,
-	.set_rmii_speed = rk3568_set_gmac_speed,
+	.set_rgmii_speed = rk_set_clk_mac_speed,
+	.set_rmii_speed = rk_set_clk_mac_speed,
 	.regs_valid = true,
 	.regs = {
 		0xfe2a0000, /* gmac0 */
@@ -1496,30 +1496,11 @@ static void rv1126_set_to_rmii(struct rk_priv_data *bsp_priv)
 		     RV1126_GMAC_PHY_INTF_SEL_RMII);
 }
 
-static void rv1126_set_clk_mac_speed(struct rk_priv_data *bsp_priv, int speed)
-{
-	struct clk *clk_mac_speed = bsp_priv->clks[RK_CLK_MAC_SPEED].clk;
-	struct device *dev = &bsp_priv->pdev->dev;
-	long rate;
-	int ret;
-
-	rate = rgmii_clock(speed);
-	if (rate < 0) {
-		dev_err(dev, "unknown speed value for GMAC speed=%d", speed);
-		return;
-	}
-
-	ret = clk_set_rate(clk_mac_speed, rate);
-	if (ret)
-		dev_err(dev, "%s: set clk_mac_speed rate %ld failed %d\n",
-			__func__, rate, ret);
-}
-
 static const struct rk_gmac_ops rv1126_ops = {
 	.set_to_rgmii = rv1126_set_to_rgmii,
 	.set_to_rmii = rv1126_set_to_rmii,
-	.set_rgmii_speed = rv1126_set_clk_mac_speed,
-	.set_rmii_speed = rv1126_set_clk_mac_speed,
+	.set_rgmii_speed = rk_set_clk_mac_speed,
+	.set_rmii_speed = rk_set_clk_mac_speed,
 };
 
 static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
-- 
2.30.2


