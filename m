Return-Path: <netdev+bounces-182878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40C0A8A428
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1571443AE1
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B15E27466A;
	Tue, 15 Apr 2025 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="p705deL3"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACBC2185A0
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744734598; cv=none; b=Uj9VKGch7Q+I3HEDcIO68PMQ/XDtJugr3kFb6NO/6fnBP9xly4L/yqoQh7OELFeT1V3JxspXVF8hTzQL3w9Ztf1awVCS3GCk62wAnhrpG8p6UaYLUPBgviwtYz9RXhr4Bj/Df0tIazU1Cp6+jFCI530WJ/vokjCsilTkS4AMPMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744734598; c=relaxed/simple;
	bh=zxiJnA8tlAJAnS/8xOJ8x1QBjQOzcLW7VRfzF5h5AyM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=oh7aqx5Rma4HVaqFFuvqyWIvP+lhDBL2zbHH6bYiW3D+S2wrIRBYFXrDolInGBeKoOkQwqO+JJvG4B0PXpHKSYx0mkkwKrLWRe7g4yKLmUog08BvCnjZQMFnm7M7Mjv0pFFsoxFeoej0WcvG1wJrQZWJ3G3nktGyqobiCPH4/k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=p705deL3; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9n7bu2qX7LooirHoLY1Va5iaADryPdv8WBdIxT2RDo8=; b=p705deL34FQCm0Dclxwms3LDyK
	YS2H1rGQQW5Tf1PNWCX2n5xv1Aatv06GcMnWcMdBmXHkn/rfCsn06vkbVcAjPHPzEwbIEHNo1syiw
	RP3J6xDW/5rFlF2Y/tEfRB/fIn9/RmcA3kZvZWwDaJIwXAaWbc2zZj/LnaPj37zc8itbmBuREAwiD
	FzvVk2h9yjuNlPvzILySyNXiiWjlm25Zyu4NjEp5GC1dMVudNqF5dXprT3UXR8UDyVeAlQ2fSZqsd
	Nl7ym3YzNj+LEZ5ZzUajhDBHlLrqYmpKUeAEnnAmR49YBrz6j4Hxt5EK/3dpBHOIip9NLyO23JYB4
	mL2HuuyA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47222 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u4jAT-0008TY-0T;
	Tue, 15 Apr 2025 17:29:49 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u4j9r-000r1P-Ra; Tue, 15 Apr 2025 17:29:11 +0100
In-Reply-To: <Z_6JaPBiGu_RB4xN@shell.armlinux.org.uk>
References: <Z_6JaPBiGu_RB4xN@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 2/5] net: stmmac: socfpga: provide init function
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u4j9r-000r1P-Ra@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 15 Apr 2025 17:29:11 +0100

Both the resume and probe path needs to configure the phy mode, so
provide a common function to do this which can later be hooked into
plat_dat->init.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index bcdb25ee2a33..000d349a6d4c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -435,6 +435,13 @@ static struct phylink_pcs *socfpga_dwmac_select_pcs(struct stmmac_priv *priv,
 	return priv->hw->phylink_pcs;
 }
 
+static int socfpga_dwmac_init(struct platform_device *pdev, void *bsp_priv)
+{
+	struct socfpga_dwmac *dwmac = bsp_priv;
+
+	return dwmac->ops->set_phy_mode(dwmac);
+}
+
 static int socfpga_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
@@ -497,7 +504,7 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = ops->set_phy_mode(dwmac);
+	ret = socfpga_dwmac_init(pdev, dwmac);
 	if (ret)
 		goto err_dvr_remove;
 
@@ -516,7 +523,7 @@ static int socfpga_dwmac_resume(struct device *dev)
 	struct stmmac_priv *priv = netdev_priv(ndev);
 	struct socfpga_dwmac *dwmac_priv = get_stmmac_bsp_priv(dev);
 
-	dwmac_priv->ops->set_phy_mode(priv->plat->bsp_priv);
+	socfpga_dwmac_init(to_platform_device(dev), dwmac_priv);
 
 	return stmmac_resume(dev);
 }
-- 
2.30.2


