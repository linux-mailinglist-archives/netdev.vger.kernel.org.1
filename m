Return-Path: <netdev+bounces-182085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 081A1A87B74
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 11:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2502188DD69
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 09:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0967825A622;
	Mon, 14 Apr 2025 09:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ud6F4mT5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6418325DCFF
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 09:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744621616; cv=none; b=MwetDEfcXfdkA+iOv6czJXx8STTY37PGZo0NsVTuVVrFXRmtsqSKElFUhmNR9/sHnL1Uk9jGA0apkMP5NB3aQN5W12YvzU+m1XhV1cnTy6qcVJM/XLSWLPg2Yhmbc/5U8bUAne/wh/TrnA4Hwe0Hk0HjhaVnxwrkZYQs3CmCsGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744621616; c=relaxed/simple;
	bh=iBhaeDDwdtFtGUkwcNaJeL3jnUzPSY6Wyon52OA0Z20=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=b0mKbj59bMvX+fZdxuirW8WQ7R5vblNRtoE8pfAr2MfqPtR3GrTCpfnNevSLwLGrx0YqEQnLJb9FW4qs2NGcLOJ0cjd+wgzeccUNpDlYtMeLJsk9bCVOLpqfQsg3M7CtXpEoiBpyabvxEaH3KJLrAbvTNgsfnbrCGBf1k5+49ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ud6F4mT5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wOqlWtFSPV7O6xwum69lDdpSmcDreIi287vOPBtUK1g=; b=ud6F4mT5ycwwzMR0SWj57hOdK0
	eJrhqgZZR0WcP7CX1KTr0T44rMI875/x5gmuu+UXquOYe7nSF+wTH/+j8ka4v47mN92CTgY/UJ+Kf
	S9DF/5zXIZlyjJYNHgIk4Ov01r01aZbIW+LnUcsHp+Hi9lEuaWz5HzG6N2vdCw1qDfx1HvoOZuV/y
	vsvrZGwcGZuImWPKlfLoKHksUL6PBE5o6oyox8baN8O/Zjkifh94J+S4fN7PcYeJz/4xdWTMa5jNQ
	k63oTHVgWbhBpbTWkgT7j2kW1PAGXp/UPyPuPBoC60MiWPk04/TpRScnU2Zn4vBKnbVGLS3+imZqe
	CRMruvSQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41504 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u4Fm6-0006Cb-1r;
	Mon, 14 Apr 2025 10:06:42 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u4FlV-000XjG-83; Mon, 14 Apr 2025 10:06:05 +0100
In-Reply-To: <Z_zP9BvZlqeq3Ssl@shell.armlinux.org.uk>
References: <Z_zP9BvZlqeq3Ssl@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v2 2/4] net: stmmac: anarion: clean up interface
 parsing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u4FlV-000XjG-83@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 14 Apr 2025 10:06:05 +0100

anarion_config_dt() used a switch statement to check for the RGMII
modes, complete with an unnecessary "fallthrough", and also printed
the numerical value of the PHY interface mode on error. Clean this
up using the phy_interface_mode_is_rgmii() helper, and print the
English version of the PHY interface mode on error.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-anarion.c    | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
index 232aae752690..941ea724c643 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
@@ -79,17 +79,11 @@ anarion_config_dt(struct platform_device *pdev,
 
 	gmac->ctl_block = ctl_block;
 
-	switch (plat_dat->phy_interface) {
-	case PHY_INTERFACE_MODE_RGMII:
-		fallthrough;
-	case PHY_INTERFACE_MODE_RGMII_ID:
-	case PHY_INTERFACE_MODE_RGMII_RXID:
-	case PHY_INTERFACE_MODE_RGMII_TXID:
+	if (phy_interface_mode_is_rgmii(plat_dat->phy_interface)) {
 		gmac->phy_intf_sel = GMAC_CONFIG_INTF_RGMII;
-		break;
-	default:
-		dev_err(&pdev->dev, "Unsupported phy-mode (%d)\n",
-			plat_dat->phy_interface);
+	} else {
+		dev_err(&pdev->dev, "Unsupported phy-mode (%s)\n",
+			phy_modes(plat_dat->phy_interface));
 		return ERR_PTR(-ENOTSUPP);
 	}
 
-- 
2.30.2


