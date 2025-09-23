Return-Path: <netdev+bounces-225578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF25B95A3F
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7A854E2CA4
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196C42DCF44;
	Tue, 23 Sep 2025 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="PNAy1DJi"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A45D3218CD
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 11:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626770; cv=none; b=fQgcMnaiIR8FPdHYhr+daI+JxIz4eCbwRxyJDsI0+KTgAHZj6W2Nv/H0GkBufmaEjhfzXMtYgVtg6be6R6SjSbOmqx4+8uLn50TBCE5e4+B2bqYOEkVwXmz0Prc+18cviHYvI6vIs4db/Dk3UysRFfTy7AV0fLhLeszCxQWpnes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626770; c=relaxed/simple;
	bh=16IMv3ZOoluQBMbzC+efh/Ubg0xmuI3hgrCdIvsIYnQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=gs2tEg41hVS+i2LwDxeYLSwJbdp4y6u7fLQv5Ps1GUmNd3ASxdycpFDSCC6OALGbsOTKPErSkaQohLQ1iaASXQCGidBhTqc4A0tJ9GEEQ1G3GQPzRmcPqeNF3Fm6psUWHXYeWc7H8MEzlwX6V5QrTYT2L2mXuhPQVZv6+uvMFS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=PNAy1DJi; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RlGoGEht7ZRuLU+Ywhrh7DNB0TyNx63riRsUGVVjf2s=; b=PNAy1DJiSOzjGYwtVAnDewa46v
	9AV04v8lddEsGD3QGpPPKPll7T6X+Y5qTMTRfSvt7orVeOxfgPiyzrcPB8punQphn7R8owD2ajo8C
	F8z2VzIk/wNRFEztHgng0Zf2lA/+Awq1hY4/SS48REejkFMUDbdR+bTNt80cmAX7xiL2KWPHWsJPh
	58ol3bWI/a4gUMyRlFqNVPF6WLYY1FPL12G2+rXbWuHiL+Gj81LSPpxz+wh73uGed+BgPgFsWZJIk
	VluYW8Mdfgu3ueQUkn17EagSlzuJ2GOHUNWb153xG45O2rYJlHfWEy+eqNQFJCQ5XSgnLBTC4mgzI
	UnMDCCuw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38064 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1v119k-00000000789-0PxJ;
	Tue, 23 Sep 2025 12:26:00 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1v119j-0000000773s-1R2v;
	Tue, 23 Sep 2025 12:25:59 +0100
In-Reply-To: <aNKDqqI7aLsuDD52@shell.armlinux.org.uk>
References: <aNKDqqI7aLsuDD52@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 1/6] net: stmmac: move stmmac_bus_clks_config() to
 stmmac_platform.c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1v119j-0000000773s-1R2v@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 23 Sep 2025 12:25:59 +0100

stmmac_bus_clks_config() is only used by stmmac_platform.c, so rather
than having it in stmmac_main.c and needing to export the symbol,
move it to where it's used.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 -
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 33 -------------------
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 32 ++++++++++++++++++
 3 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 151f08e5e85d..7ca5477be390 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -404,7 +404,6 @@ int stmmac_dvr_probe(struct device *device,
 		     struct stmmac_resources *res);
 int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt);
 int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size);
-int stmmac_bus_clks_config(struct stmmac_priv *priv, bool enabled);
 int stmmac_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
 			   phy_interface_t interface, int speed);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d17820d9e7f1..517b25b2bcae 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -147,39 +147,6 @@ static void stmmac_exit_fs(struct net_device *dev);
 
 #define STMMAC_COAL_TIMER(x) (ns_to_ktime((x) * NSEC_PER_USEC))
 
-int stmmac_bus_clks_config(struct stmmac_priv *priv, bool enabled)
-{
-	struct plat_stmmacenet_data *plat_dat = priv->plat;
-	int ret;
-
-	if (enabled) {
-		ret = clk_prepare_enable(plat_dat->stmmac_clk);
-		if (ret)
-			return ret;
-		ret = clk_prepare_enable(plat_dat->pclk);
-		if (ret) {
-			clk_disable_unprepare(plat_dat->stmmac_clk);
-			return ret;
-		}
-		if (plat_dat->clks_config) {
-			ret = plat_dat->clks_config(plat_dat->bsp_priv, enabled);
-			if (ret) {
-				clk_disable_unprepare(plat_dat->stmmac_clk);
-				clk_disable_unprepare(plat_dat->pclk);
-				return ret;
-			}
-		}
-	} else {
-		clk_disable_unprepare(plat_dat->stmmac_clk);
-		clk_disable_unprepare(plat_dat->pclk);
-		if (plat_dat->clks_config)
-			plat_dat->clks_config(plat_dat->bsp_priv, enabled);
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(stmmac_bus_clks_config);
-
 /**
  * stmmac_set_clk_tx_rate() - set the clock rate for the MAC transmit clock
  * @bsp_priv: BSP private data structure (unused)
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 712ef235f0f4..27bcaae07a7f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -911,6 +911,38 @@ void stmmac_pltfr_remove(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(stmmac_pltfr_remove);
 
+static int stmmac_bus_clks_config(struct stmmac_priv *priv, bool enabled)
+{
+	struct plat_stmmacenet_data *plat_dat = priv->plat;
+	int ret;
+
+	if (enabled) {
+		ret = clk_prepare_enable(plat_dat->stmmac_clk);
+		if (ret)
+			return ret;
+		ret = clk_prepare_enable(plat_dat->pclk);
+		if (ret) {
+			clk_disable_unprepare(plat_dat->stmmac_clk);
+			return ret;
+		}
+		if (plat_dat->clks_config) {
+			ret = plat_dat->clks_config(plat_dat->bsp_priv, enabled);
+			if (ret) {
+				clk_disable_unprepare(plat_dat->stmmac_clk);
+				clk_disable_unprepare(plat_dat->pclk);
+				return ret;
+			}
+		}
+	} else {
+		clk_disable_unprepare(plat_dat->stmmac_clk);
+		clk_disable_unprepare(plat_dat->pclk);
+		if (plat_dat->clks_config)
+			plat_dat->clks_config(plat_dat->bsp_priv, enabled);
+	}
+
+	return 0;
+}
+
 static int __maybe_unused stmmac_runtime_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
-- 
2.47.3


