Return-Path: <netdev+bounces-235042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F88C2B8C1
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 12:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF78E4FB280
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 11:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113723054F8;
	Mon,  3 Nov 2025 11:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gYh3Se3M"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2C72FCC04
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 11:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170614; cv=none; b=Y5Lc5NF25yCLb+yq71P6DkKs4unkp4tbdydDwJ0S4yLIFAM6//IRdo4tFNy+wc1QI4hMNlQYVrtNb/x6dObKMk04GN2tHb92fLszZBo/qKIrDZa8Nb1/hcsa9bi4rfjYLHj5HnQy1F6RcXH7ZTmzq6NPLCRV4wVI5nsnAPBSu3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170614; c=relaxed/simple;
	bh=WzYM3bdvnpTvS5yPjLm9IJCA5FScmFAXaYJiDM1Oe58=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=mb7QbmECYaJWDjPWxecWzY0jw7y0fdIuBxjf5VS6YKVy0dkouJJuMkkLeHfqrHJa5z6pMp1zyL83xOuZ2akxVGP/ZeyXj3+8XdQ9y/8IpxKtKldRpGpwmZe3ZDs7GFPVSBC03xKGtcOQfvXoc1ACWUKfP7Du9UNbaYNPIXRErfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gYh3Se3M; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6W0DkUMzifwuDMlc9DiSUqRLpgMXFIVqdSysIfR+dbQ=; b=gYh3Se3MQRjmnvmEL8hRKs1HC6
	EHX/zY77CnBzHwWKNZbz6WznbHtCMypMvDNyQFMsffbLDiOomjpAe+TyiqHSPswFC/zccbnX8Ek0K
	t0VwQ3Z7/d5V0QYBYDPDdy1l+xmSuwke8rdmLABJnZdjUcjmiOxtF0A4oD09lHC7T38iildrHsTTq
	f3sQqOm8ERg+JfB/xVWi0Aq1pUyYIOkIOyo6lwc21daWSOz4OgGFvXD9EHTpyHZ8gQzAUJcdO/lDu
	0eVL8bsL5BQmIYLUAKy3HySTgtBhIJzWoaEvyUwFmr9nxtJJBG9ytrdju8NXvoifDzCxCvLzo2P5/
	JMZu3J5A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39006 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vFt4T-000000000fS-26LA;
	Mon, 03 Nov 2025 11:50:01 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vFt4S-0000000ChoS-2Ahi;
	Mon, 03 Nov 2025 11:50:00 +0000
In-Reply-To: <aQiWzyrXU_2hGJ4j@shell.armlinux.org.uk>
References: <aQiWzyrXU_2hGJ4j@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	s32@nxp.com,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH net-next 02/11] net: stmmac: s32: move PHY_INTF_SEL_x
 definitions out of the way
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vFt4S-0000000ChoS-2Ahi@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 03 Nov 2025 11:50:00 +0000

S32's PHY_INTF_SEL_x definitions conflict with those for the dwmac
cores as they use a different bitmapping. Add a S32 prefix so that
they are unique.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
index ee095ac13203..2b7ad64bfdf7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
@@ -24,10 +24,10 @@
 #define GMAC_INTF_RATE_125M	125000000	/* 125MHz */
 
 /* SoC PHY interface control register */
-#define PHY_INTF_SEL_MII	0x00
-#define PHY_INTF_SEL_SGMII	0x01
-#define PHY_INTF_SEL_RGMII	0x02
-#define PHY_INTF_SEL_RMII	0x08
+#define S32_PHY_INTF_SEL_MII	0x00
+#define S32_PHY_INTF_SEL_SGMII	0x01
+#define S32_PHY_INTF_SEL_RGMII	0x02
+#define S32_PHY_INTF_SEL_RMII	0x08
 
 struct s32_priv_data {
 	void __iomem *ioaddr;
@@ -40,7 +40,7 @@ struct s32_priv_data {
 
 static int s32_gmac_write_phy_intf_select(struct s32_priv_data *gmac)
 {
-	writel(PHY_INTF_SEL_RGMII, gmac->ctrl_sts);
+	writel(S32_PHY_INTF_SEL_RGMII, gmac->ctrl_sts);
 
 	dev_dbg(gmac->dev, "PHY mode set to %s\n", phy_modes(*gmac->intf_mode));
 
-- 
2.47.3


