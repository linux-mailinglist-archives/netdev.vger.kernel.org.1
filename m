Return-Path: <netdev+bounces-224080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4B7B80751
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14CF53A5B2C
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4CA332A48;
	Wed, 17 Sep 2025 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mvFAhoOs"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886B1330D52
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121993; cv=none; b=PueBsUD8oIYfMTZuDHj76MqzdEp3X4pFbrdlv/jMqHnkfuXrG4T9GepuOZbz8uzgrhLGdErD5xJFOpYR5lJlMA2I82guUQgRUgimQFBJad4Q94FchJFV7yuRwkH1JqD7YAtlklcrF2upxI6O0yXvAAZKGP2l4C0sH56Wr3Ym+P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121993; c=relaxed/simple;
	bh=pjIGeCc4Qbd7UvvngP0+aYr2C++x0mYR7wKm134A4wM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ZVUdkYRyFCLQMRTIxd23t9tAPotIuvgs/K1uqd0hDg5so3t8y9wfkPNL6+0zIq3gKg2UUAbHWNkCOeHb9UlXaHBhtE89ppJqnCjh8S+fTmBx2lOaJAUa2zewcQ7PQ1EqmIdoEiQsGMavAlCtXDLzXNKZKuwPu1qA8xJU823V6YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mvFAhoOs; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ChcytkVLrz+IKUJS3Cck/qqHKiLa2YGrU2v03wuGGrM=; b=mvFAhoOslfMXI6PpLYMlk+frsP
	A5cengYY0t6QZcdChxdPgmGo+ipcwiIcPyi2US5P9uC3kBocp2y9pf2sPs6KqkmRVXIzzhNG87Mkb
	iugRGz6jqqB9LyxbZEtthJlUPBsl/NIVom9Ks0mvfrrbh53EJqOpQzmb5/u4lMvIow8qD57kP4XIZ
	x6xOYDqMRZGdfqtRANEiOpqoNx9UtoRESXyAffLyBt6F5kjpc9mfmbLwnfkvrwOk9s/QeklW+0Kj3
	BQyLhO7rQezSrusw4pBk7Yg8+mKrLMNPa7mHN+9WbaUcHqkhsk3kx8TchCH4mPCGtiypxU0a6suV6
	brzJOU8w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:32780 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uytpq-000000004mN-0A9j;
	Wed, 17 Sep 2025 16:12:42 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uytpl-00000006H2k-08pH;
	Wed, 17 Sep 2025 16:12:37 +0100
In-Reply-To: <aMrPpc8oRxqGtVPJ@shell.armlinux.org.uk>
References: <aMrPpc8oRxqGtVPJ@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chen-Yu Tsai <wens@csie.org>,
	"David S. Miller" <davem@davemloft.net>,
	Drew Fustini <fustini@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Fu Wei <wefu@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Samuel Holland <samuel@sholland.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH net-next 08/10] net: stmmac: sun8i: convert to use
 phy_interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uytpl-00000006H2k-08pH@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 17 Sep 2025 16:12:37 +0100

dwmac-sun8i supports MII, RMII and RGMII interface modes only. It
is unclear whether the dwmac core interface is different from the
one presented to the outside world.

However, as none of the DTS files set "mac-mode", mac_interface will
be identical to phy_interface.

Convert dwmac-sun8i to use phy_interface when determining the
interface mode rather than mac_interface.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 690f3650f84e..5d871b2cd111 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -974,7 +974,7 @@ static int sun8i_dwmac_set_syscon(struct device *dev,
 		}
 	}
 
-	switch (plat->mac_interface) {
+	switch (plat->phy_interface) {
 	case PHY_INTERFACE_MODE_MII:
 		/* default */
 		break;
@@ -989,7 +989,7 @@ static int sun8i_dwmac_set_syscon(struct device *dev,
 		break;
 	default:
 		dev_err(dev, "Unsupported interface mode: %s",
-			phy_modes(plat->mac_interface));
+			phy_modes(plat->phy_interface));
 		return -EINVAL;
 	}
 
-- 
2.47.3


