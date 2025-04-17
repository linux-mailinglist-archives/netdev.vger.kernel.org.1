Return-Path: <netdev+bounces-183850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93035A923A2
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2157646102D
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3C02550C1;
	Thu, 17 Apr 2025 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="k3Va4fCp"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC8E186E2E
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910040; cv=none; b=ErzAipLGbKfylbTH0VBHhzSoijMSimrvR4xMdyrWSpr69sUfc7Ld02YjW5+DZ5pCY1DnksBUimgPLOTrctESSVNXRxL59z0n39N2+M7HwPBkPoPWOPs1h3g3yx41sb4JG66atOjFdCujlZLSeZMdeK6kjJYuxPpAo+cxyqA8lZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910040; c=relaxed/simple;
	bh=SqNLD2seLZpye58gORKXZH1fUKMkd249tBAXxnkOndc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=fjLjkuuTsXoOlRki59W0J/gFqNg7R4bDCkBQ5p+aqCrSM+iXejexvwPCV4kWHLpFEx61+Kk+ZO0faxHGaSG4eABGf/USJVHTC/ep+IXmwT779W/sLWBU/ELR4KbwG5zgdU6O3VHm9+sWnz5oaPxBOxAB+yQyNt9IHhuzM95q/V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=k3Va4fCp; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=z8hTSVnlcCC2WOnj66TO/Zt9nedPd+37sOl0zL+RseU=; b=k3Va4fCpTrOBQ7/3kVED2u3vGg
	foS8vDazWhX9tXhBFMBXt1xF79/7lJLt6adn0O2EoZjw6Eqzico3ptoSGSUH+/onSRYcbfVbZb2jS
	4AfjNaK8bDSBJIioOhVCvrWn3TppgQK4W4bq7e7Ne0u2ueX0AC4XiROEwfJqSiXJmnkyrJZ/sMQvq
	CgmonJA/4psjajUWspw3hEQoeLHL4E8FCHAYBAlASgp+DkZFEDdJwqrD6N4kBNfi09voQ1sWZEj7V
	YuUK39QJTyMtVE+PKGJ+IrjVQDzFA+L23PtjfMy7o7Dxl71oXnGgKmQRYfaSSSq+2qgtOQtngnxwk
	wrxe3dhA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48398 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u5So9-0007gS-2k;
	Thu, 17 Apr 2025 18:13:49 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u5SnY-001IJY-90; Thu, 17 Apr 2025 18:13:12 +0100
In-Reply-To: <aAE2tKlImhwKySq_@shell.armlinux.org.uk>
References: <aAE2tKlImhwKySq_@shell.armlinux.org.uk>
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
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v3 1/5] net: stmmac: socfpga: init dwmac->stmmac_rst
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
Message-Id: <E1u5SnY-001IJY-90@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 17 Apr 2025 18:13:12 +0100

Initialisation/setup after registration is a bug. This is the first of
two patches fixing this in socfpga.

dwmac->stmmac_rst is initialised from the stmmac plat_dat's stmmac_rst
member, which is itself initialised by devm_stmmac_probe_config_dt().
Therefore, this can be initialised before we call stmmac_dvr_probe().
Move it there.

dwmac->stmmac_rst is used by the set_phy_mode() method.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index 116855658559..bcdb25ee2a33 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -442,8 +442,6 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	struct device		*dev = &pdev->dev;
 	int			ret;
 	struct socfpga_dwmac	*dwmac;
-	struct net_device	*ndev;
-	struct stmmac_priv	*stpriv;
 	const struct socfpga_dwmac_ops *ops;
 
 	ops = device_get_match_data(&pdev->dev);
@@ -479,7 +477,13 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* The socfpga driver needs to control the stmmac reset to set the phy
+	 * mode. Create a copy of the core reset handle so it can be used by
+	 * the driver later.
+	 */
+	dwmac->stmmac_rst = plat_dat->stmmac_rst;
 	dwmac->ops = ops;
+
 	plat_dat->bsp_priv = dwmac;
 	plat_dat->fix_mac_speed = socfpga_dwmac_fix_mac_speed;
 	plat_dat->pcs_init = socfpga_dwmac_pcs_init;
@@ -493,15 +497,6 @@ static int socfpga_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ndev = platform_get_drvdata(pdev);
-	stpriv = netdev_priv(ndev);
-
-	/* The socfpga driver needs to control the stmmac reset to set the phy
-	 * mode. Create a copy of the core reset handle so it can be used by
-	 * the driver later.
-	 */
-	dwmac->stmmac_rst = stpriv->plat->stmmac_rst;
-
 	ret = ops->set_phy_mode(dwmac);
 	if (ret)
 		goto err_dvr_remove;
-- 
2.30.2


