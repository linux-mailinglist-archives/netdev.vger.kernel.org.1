Return-Path: <netdev+bounces-169087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AD6A42868
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 17:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 233FA3A9FA8
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 16:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8A72627F2;
	Mon, 24 Feb 2025 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PlY6BO7c"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9077157465
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416018; cv=none; b=sHbNQKC86+GvslheBJgSJ3uhAP/BMKTfAp2RQf+NESA7vZcKxyb3295Re9s53I2ZGMTTWzvcavMxzCMo6CLEGit01ydwOIUvbauG3MbE9mDwDoUmiDR3fyAtWGjcrnyEoJHwPkGdCSiEz7WEv68upC3vsCvkR5Aq0WJehvDoZ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416018; c=relaxed/simple;
	bh=NM4HRYCbj5a8EDj9Jnosgzlu12vjIrcHW6LGNyLCJSY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=gNrJIuAkhWIEofNhC9Mt2ZdjpV+0A58AYZETm72VM7Ea/O4QRqCIvRq2wlJf95JLXb9ei6ja0MJjJCEa+f37Eoy4fWPveQNYnf9GN+CFCzQcjzVsXghBvEgBBElb5YtGLLGPqdR0aNM/0J7nEKc18E08xu4O+pAHIBfAWsMC8dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PlY6BO7c; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mi3v7W3xohiNhzfx1zdXOCiB1GcuHJ50d4F7oExM8oE=; b=PlY6BO7crp/CZKUaGmHlIcU8en
	ioX7bfvMnCkvS5XEuvmmDGRHjuoP9oH9XSwYaIs+nyAzPDd5DNpHP82tDDs6xd83R7Pq2REXOF/5O
	e9KipfXeAjrNc+q860CGchJp9iH/TKHZ0T4VMUqpY8lFDra5WJpv0t4NpdaXfrRUdzuGj5JFk7wJd
	WJZQZNZmfC5OmgMmnG9sXWpujU/jCXY+5YuRQD5CS009/SRnOCWbsZ17Pq+tVfxnpYZZt3swEQoVG
	ydreNd4H9HjI8tK2E78e9OaPyEMS+PlLBGsr+lBZMZ/YHaiR584Wli5rSGN/mexibwYZGY4m6oJSv
	t1/eJSig==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41598 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tmbhy-00070I-1v;
	Mon, 24 Feb 2025 16:53:30 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tmbhe-004vSt-M3; Mon, 24 Feb 2025 16:53:10 +0000
In-Reply-To: <Z7yj_BZa6yG02KcI@shell.armlinux.org.uk>
References: <Z7yj_BZa6yG02KcI@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v3 1/2] net: stmmac: dwc-qos: name struct
 plat_stmmacenet_data consistently
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tmbhe-004vSt-M3@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 24 Feb 2025 16:53:10 +0000

Most of the stmmac driver uses "plat_dat" to name the platform data,
and "data" is used for the glue driver data. make dwc-qos follow
this pattern to avoid silly mistakes.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../stmicro/stmmac/dwmac-dwc-qos-eth.c        | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index 392574bdd4a4..acb0a2e1664f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -224,7 +224,7 @@ static int tegra_eqos_init(struct platform_device *pdev, void *priv)
 }
 
 static int tegra_eqos_probe(struct platform_device *pdev,
-			    struct plat_stmmacenet_data *data,
+			    struct plat_stmmacenet_data *plat_dat,
 			    struct stmmac_resources *res)
 {
 	struct device *dev = &pdev->dev;
@@ -241,12 +241,12 @@ static int tegra_eqos_probe(struct platform_device *pdev,
 	if (!is_of_node(dev->fwnode))
 		goto bypass_clk_reset_gpio;
 
-	for (int i = 0; i < data->num_clks; i++) {
-		if (strcmp(data->clks[i].id, "slave_bus") == 0) {
-			eqos->clk_slave = data->clks[i].clk;
-			data->stmmac_clk = eqos->clk_slave;
-		} else if (strcmp(data->clks[i].id, "tx") == 0) {
-			eqos->clk_tx = data->clks[i].clk;
+	for (int i = 0; i < plat_dat->num_clks; i++) {
+		if (strcmp(plat_dat->clks[i].id, "slave_bus") == 0) {
+			eqos->clk_slave = plat_dat->clks[i].clk;
+			plat_dat->stmmac_clk = eqos->clk_slave;
+		} else if (strcmp(plat_dat->clks[i].id, "tx") == 0) {
+			eqos->clk_tx = plat_dat->clks[i].clk;
 		}
 	}
 
@@ -260,7 +260,7 @@ static int tegra_eqos_probe(struct platform_device *pdev,
 	gpiod_set_value(eqos->reset, 0);
 
 	/* MDIO bus was already reset just above */
-	data->mdio_bus_data->needs_reset = false;
+	plat_dat->mdio_bus_data->needs_reset = false;
 
 	eqos->rst = devm_reset_control_get(&pdev->dev, "eqos");
 	if (IS_ERR(eqos->rst)) {
@@ -281,10 +281,10 @@ static int tegra_eqos_probe(struct platform_device *pdev,
 	usleep_range(2000, 4000);
 
 bypass_clk_reset_gpio:
-	data->fix_mac_speed = tegra_eqos_fix_speed;
-	data->init = tegra_eqos_init;
-	data->bsp_priv = eqos;
-	data->flags |= STMMAC_FLAG_SPH_DISABLE;
+	plat_dat->fix_mac_speed = tegra_eqos_fix_speed;
+	plat_dat->init = tegra_eqos_init;
+	plat_dat->bsp_priv = eqos;
+	plat_dat->flags |= STMMAC_FLAG_SPH_DISABLE;
 
 	err = tegra_eqos_init(pdev, eqos);
 	if (err < 0)
@@ -309,7 +309,7 @@ static void tegra_eqos_remove(struct platform_device *pdev)
 
 struct dwc_eth_dwmac_data {
 	int (*probe)(struct platform_device *pdev,
-		     struct plat_stmmacenet_data *data,
+		     struct plat_stmmacenet_data *plat_dat,
 		     struct stmmac_resources *res);
 	void (*remove)(struct platform_device *pdev);
 };
@@ -387,15 +387,15 @@ static int dwc_eth_dwmac_probe(struct platform_device *pdev)
 static void dwc_eth_dwmac_remove(struct platform_device *pdev)
 {
 	const struct dwc_eth_dwmac_data *data = device_get_match_data(&pdev->dev);
-	struct plat_stmmacenet_data *plat_data = dev_get_platdata(&pdev->dev);
+	struct plat_stmmacenet_data *plat_dat = dev_get_platdata(&pdev->dev);
 
 	stmmac_dvr_remove(&pdev->dev);
 
 	if (data->remove)
 		data->remove(pdev);
 
-	if (plat_data)
-		clk_bulk_disable_unprepare(plat_data->num_clks, plat_data->clks);
+	if (plat_dat)
+		clk_bulk_disable_unprepare(plat_dat->num_clks, plat_dat->clks);
 }
 
 static const struct of_device_id dwc_eth_dwmac_match[] = {
-- 
2.30.2


