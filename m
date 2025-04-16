Return-Path: <netdev+bounces-183199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DACDA8B570
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5762E5A1A1C
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 09:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5C8220693;
	Wed, 16 Apr 2025 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="V76LVS4F"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CE4233739
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744795947; cv=none; b=lvkuRJrguYNex694ayVCa4fVA6JO4XOEbSVIWL03RLb19qr1DfLvkd1xYfOoofDKFRFa6ewIsR+zAeybWhxFP+35fgZsE5/PiUFKPt9zO24SdZ14O61saW3j/kh5EJmp1oFtP6pSBvbFkLnxoBGmgDgMxnBicIBYp/V1XNgubSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744795947; c=relaxed/simple;
	bh=mdqs8OxwO8itkkWs2+lhXvn9hsTewtpGV/UfOb30WAQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=nbnHEumPiRSFavm1hpLg+vFvtkarhXYRyxOGDDK0zJ91ufybm+m8Hw6Xx24fxN98qtdbo/phutjrHPa0PdaLf4cjpW4rqsHdLGMK/gawVNUykdxjNrrPbp9RYFK7c6t+ioR3L27JjYVqgVYGH7nXJIgC2/zM8Z0EGJ3QUip9TLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=V76LVS4F; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jIkX0gP+PNuwun86Ur3bCb3SB1wHpFzUd5pZCiudByo=; b=V76LVS4FiNC0BL2aJOkDY0jDau
	DSAiacGHiECEANA4bwI/oTYtNgXHrlLMEF5WjVTgMk0DIPByR187M6MTfpWPoiiduTrPlRWjkA3BD
	q1M3hcsh8u0E/oIYUyvPvH1D91ZgSvEyzjZpOG6LqXzUQgSXhm4KCQdHrqDGrxwBpAUK1/BTuRP2E
	MJ6XvDhBRy693KxEbFMHj0sfpsKaXq2+5XHC17mSUNSJoQ6WHRRckPEVR1xTImmmjnoQBodNe1mUr
	TEqx27YCQGoD9FizPZoRX+muDT2DUpynTu8qFRsdpUGgQD/By16xgDgQwSskeCdgNdvJwGluV5gyu
	PTvkU2zw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38780 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u4z7w-0000zJ-13;
	Wed, 16 Apr 2025 10:32:16 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u4z7K-000xBu-5e; Wed, 16 Apr 2025 10:31:38 +0100
In-Reply-To: <Z_95AM64tt_4ri1j@shell.armlinux.org.uk>
References: <Z_95AM64tt_4ri1j@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v2 4/5] net: stmmac: socfpga: call set_phy_mode()
 before registration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u4z7K-000xBu-5e@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 16 Apr 2025 10:31:38 +0100

Initialisation/setup after registration is a bug. This is the second
of two patches fixing this in socfpga.

The set_phy_mode() functions do various hardware setup that would
interfere with a netdev that has been published, and thus available to
be opened by the kernel/userspace.

However, set_phy_mode() relies upon the netdev having been initialised
to get at the plat_stmmacenet_data structure, which is probably why it
was placed after stmmac_drv_probe(). We can remove that need by storing
a pointer to struct plat_stmmacenet_data in struct socfpga_dwmac.

Move the call to set_phy_mode() before calling stmmac_dvr_probe().
This also simplifies the probe function as there is no need to
unregister the netdev if set_phy_mode() fails.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   | 20 +++++--------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 69ffc52c0275..c7c120e30297 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -50,6 +50,7 @@ struct socfpga_dwmac {
 	u32	reg_offset;
 	u32	reg_shift;
 	struct	device *dev;
+	struct plat_stmmacenet_data *plat_dat;
 	struct regmap *sys_mgr_base_addr;
 	struct reset_control *stmmac_rst;
 	struct reset_control *stmmac_ocp_rst;
@@ -233,10 +234,7 @@ static int socfpga_dwmac_parse_data(struct socfpga_dwmac *dwmac, struct device *
 
 static int socfpga_get_plat_phymode(struct socfpga_dwmac *dwmac)
 {
-	struct net_device *ndev = dev_get_drvdata(dwmac->dev);
-	struct stmmac_priv *priv = netdev_priv(ndev);
-
-	return priv->plat->mac_interface;
+	return dwmac->plat_dat->mac_interface;
 }
 
 static void socfpga_sgmii_config(struct socfpga_dwmac *dwmac, bool enable)
@@ -490,6 +488,7 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	 */
 	dwmac->stmmac_rst = plat_dat->stmmac_rst;
 	dwmac->ops = ops;
+	dwmac->plat_dat = plat_dat;
 
 	plat_dat->bsp_priv = dwmac;
 	plat_dat->fix_mac_speed = socfpga_dwmac_fix_mac_speed;
@@ -501,20 +500,11 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 
 	plat_dat->riwt_off = 1;
 
-	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
-	if (ret)
-		return ret;
-
 	ret = socfpga_dwmac_init(pdev, dwmac);
 	if (ret)
-		goto err_dvr_remove;
-
-	return 0;
-
-err_dvr_remove:
-	stmmac_dvr_remove(&pdev->dev);
+		return ret;
 
-	return ret;
+	return stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 }
 
 static const struct socfpga_dwmac_ops socfpga_gen5_ops = {
-- 
2.30.2


