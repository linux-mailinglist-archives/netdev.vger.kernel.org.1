Return-Path: <netdev+bounces-238698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F00C5E407
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 17:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2AACF3A05FB
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 15:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8268B32D7F4;
	Fri, 14 Nov 2025 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YY8rm/oa"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D98632E738
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 15:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134116; cv=none; b=RZRk2VaAzexJTx3ZhQMtXH/U70OeHDwA5ibBYUmNpllEOkM8Qfzn37RGzOb1SbMDO+8F4lSBSk4GZ645KlwoAbfuRB+cVSxm3fGtD4NeComb9fsn7jUnwYLG6ER80BqoZ/EwAPRfeVjldbsSHs4FUB6zFVnM5sL8qjtC2IFIJ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134116; c=relaxed/simple;
	bh=vOjmnKymj7DfYs74yGz5ABtUS6AqnE9aHo8BjG5NZMI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=GLVVDd2gnmbW7yQylQpYOAmFuwUftg+RDhVZkZxYxQ4M+eK0TTPpNMPLy9JX/ChWPg6nAC592rTRp5+bn5CIW2Pw4/RrNt2PBpoGTdJPgJLXceURMtHMf7+PiWxHnBm1XhCzX+XPfIWi0u8LLezeLdza1r7eIA6gLGnWAlEMkWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YY8rm/oa; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tnhXWAcMimUpwXmvKx8hT4Dy4PiOWSon3MerZPv5kn0=; b=YY8rm/oaYXBnXd2leCDRbECgMy
	w4qF7TLhLdC99TuXYsaNrJHZWWrJS7j+R8yeFS5y69vEPzlv18lpQihGWM3kOrjiLKhWoNmamT89R
	pjlr3QIdJEeEVyqm0lRD5TAmGBs5GwR5DwStiUKJTopopLOggRCJiUBlWjuveLJwm6XJnhAxC5t0/
	mw8lJRa1Grr565dj1WX/O/jFzOzqY2NK0LydLFpIcUJXAqvlWqfkZITJaFxUz1pSI+GEQEOAzqlzq
	A64XSocyD4YAKiHJsLclaDXf7Yit682UKoZ5/+MSW7cAYyywPfKrS8NGqQlPbiWjsTiz5fTq5Ey1o
	1dc8p6Mg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43774 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vJviq-00000000762-47yd;
	Fri, 14 Nov 2025 15:28:25 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vJviq-0000000EVjP-0c0l;
	Fri, 14 Nov 2025 15:28:24 +0000
In-Reply-To: <aRdKVMPHXlIn457m@shell.armlinux.org.uk>
References: <aRdKVMPHXlIn457m@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chen Wang <unicorn_wang@outlook.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	sophgo@lists.linux.dev
Subject: [PATCH net-next 01/11] net: stmmac: add stmmac_plat_dat_alloc()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vJviq-0000000EVjP-0c0l@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 14 Nov 2025 15:28:24 +0000

Add a function to allocate and initialise the plat_stmmacenet_data
structure with default values.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c    |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h         |  2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    | 12 ++++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c     |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c    |  2 +-
 6 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index b2194e414ec1..7e56fbc3e141 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -1286,7 +1286,7 @@ static int intel_eth_pci_probe(struct pci_dev *pdev,
 	if (!intel_priv)
 		return -ENOMEM;
 
-	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
+	plat = stmmac_plat_dat_alloc(&pdev->dev);
 	if (!plat)
 		return -ENOMEM;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index dd2fc39ec3e2..2d803fa37e21 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -559,7 +559,7 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	struct loongson_data *ld;
 	int ret;
 
-	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
+	plat = stmmac_plat_dat_alloc(&pdev->dev);
 	if (!plat)
 		return -ENOMEM;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 0ea74c88a779..e9ed5086c049 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -408,6 +408,8 @@ int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size);
 int stmmac_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
 			   phy_interface_t interface, int speed);
 
+struct plat_stmmacenet_data *stmmac_plat_dat_alloc(struct device *dev);
+
 static inline bool stmmac_xdp_is_enabled(struct stmmac_priv *priv)
 {
 	return !!priv->xdp_prog;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d202f604161e..400b4b955820 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7555,6 +7555,18 @@ static void stmmac_unregister_devlink(struct stmmac_priv *priv)
 	devlink_free(priv->devlink);
 }
 
+struct plat_stmmacenet_data *stmmac_plat_dat_alloc(struct device *dev)
+{
+	struct plat_stmmacenet_data *plat_dat;
+
+	plat_dat = devm_kzalloc(dev, sizeof(*plat_dat), GFP_KERNEL);
+	if (!plat_dat)
+		return NULL;
+
+	return plat_dat;
+}
+EXPORT_SYMBOL_GPL(stmmac_plat_dat_alloc);
+
 /**
  * stmmac_dvr_probe
  * @device: device pointer
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index 94b3a3b27270..622cdbeca20f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -191,7 +191,7 @@ static int stmmac_pci_probe(struct pci_dev *pdev,
 	int ret;
 	int i;
 
-	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
+	plat = stmmac_plat_dat_alloc(&pdev->dev);
 	if (!plat)
 		return -ENOMEM;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 6483d52b4c0f..38d574907a04 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -436,7 +436,7 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	void *ret;
 	int rc;
 
-	plat = devm_kzalloc(&pdev->dev, sizeof(*plat), GFP_KERNEL);
+	plat = stmmac_plat_dat_alloc(&pdev->dev);
 	if (!plat)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.47.3


