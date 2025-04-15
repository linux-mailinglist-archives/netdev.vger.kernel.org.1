Return-Path: <netdev+bounces-182670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC000A8999A
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 12:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77BB43B823F
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 10:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E561E2750EA;
	Tue, 15 Apr 2025 10:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pBFYel6Z"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204AC1CAA6D
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 10:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744712203; cv=none; b=HK9czcnnFHzkZjBagsY9nH4ADWOzBedFHdyM47N86r8Q5evQ3JSlioIgaqemXa0TTh1VSOXJVyZva6Ze1z4gjqBXsGvcM6+z3frWwemCJZM7A6IDHPjJL/OCW/rMwgsZ9u2A4n/TlLSiY/r21extHTJz8mVT/ybTWD2s63NHIfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744712203; c=relaxed/simple;
	bh=6UgR8EYxjI9b7ZbVJhG4JlxzUH+2P8uAlh0p81YuDP0=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=bjygsu5iM1JWj6EpnPs9VGqhHDDq5IA66MA4N28E1xdlIjajzTH3cvIGkrIEih5VX0UeXang3RV7JEtroedBTnBYIRsg3XvqXDivljaPqxu4ebsjOhB7Cdh+JhOoEM91gHSqWtweMM0QV3fwdRp07gFUPoFh+YTk8nv1pm57Lzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pBFYel6Z; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GSBt2MJMjAhzFPApeUUI2g2BMUd4P0q8zYxmPlvwJ4o=; b=pBFYel6ZhGCVZlhKkN/xfHKsko
	tfy1jP7AXZCpn+Fv0iO3J+QH9y+fdv9ae4eyH3wZvouaDR0Q4rjtII3jx8b677GlXq0aQNvGe211F
	jVo/Nxzpjkrj2sKzknLp358emVznhbUzkGmsG31BW7nQsrPEp3idj2VJtAt1YDKhRbLKu4Pu72WtC
	o9aoZ9MOLjriuUdcfKgr39maOzwwWmvg4Q4GII5/ZpZ55MQ/nTOxe/WpgZ/CCmArF90EzKkqoua+k
	stER9Yr1gqsBEbI4ujJWByZxkFbeTVelpbwTYNbCcFzXD+ObzhCSigsKRjCVi+UwMlHgJ+X9IoVsX
	aGcvGTqw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36516 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u4dLC-0007w1-1L;
	Tue, 15 Apr 2025 11:16:30 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u4dKb-000dV7-3B; Tue, 15 Apr 2025 11:15:53 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chen-Yu Tsai <wens@csie.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Samuel Holland <samuel@sholland.org>
Subject: [PATCH net-next] net: stmmac: sun8i: use stmmac_pltfr_probe()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u4dKb-000dV7-3B@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 15 Apr 2025 11:15:53 +0100

Using stmmac_pltfr_probe() simplifies the probe function. This will not
only call plat_dat->init (sun8i_dwmac_init), but also plat_dat->exit
(sun8i_dwmac_exit) appropriately if stmmac_dvr_probe() fails. This
results in an overall simplification of the glue driver.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 85723a78793a..fd6518e252e3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -1239,14 +1239,10 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = sun8i_dwmac_init(pdev, plat_dat->bsp_priv);
+	ret = stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 	if (ret)
 		goto dwmac_syscon;
 
-	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
-	if (ret)
-		goto dwmac_exit;
-
 	ndev = dev_get_drvdata(&pdev->dev);
 	priv = netdev_priv(ndev);
 
@@ -1283,9 +1279,7 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
 	clk_put(gmac->ephy_clk);
 dwmac_remove:
 	pm_runtime_put_noidle(&pdev->dev);
-	stmmac_dvr_remove(&pdev->dev);
-dwmac_exit:
-	sun8i_dwmac_exit(pdev, gmac);
+	stmmac_pltfr_remove(pdev);
 dwmac_syscon:
 	sun8i_dwmac_unset_syscon(gmac);
 
-- 
2.30.2


