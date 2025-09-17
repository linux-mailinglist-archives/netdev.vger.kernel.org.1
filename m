Return-Path: <netdev+bounces-224074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C41AB8073C
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 17:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2083B77D5
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DF2330D57;
	Wed, 17 Sep 2025 15:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="oBVhKLo1"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D5F306B3C
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758121953; cv=none; b=RuYSE02HA5QqN6W39aDLZZCgY4kanopwzo7uXmZjh6EGJs8AkYQXnECM/dU3Fqxe/csK1KK3XjBIWzniFEYyQ0bDWGSKEdX8xhZtAQGvZtnjEXeathsM4veDD/HO6kx5Y6tPLgO3ULxkZXOBwsxlBbwsRWjWsxh91Z4RXKUH8Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758121953; c=relaxed/simple;
	bh=75IN9DWyAZKsFuhari5isHjZ50sYYIagGHQX8OAte8E=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Bf8CANSy+ouhmpb8rNSYXYZZzJy/KtaEHJOPy2WmButQPvHqeNZ36Z6rKBwPsNi/LkfH2XpxCDFNXonPeEM2Iu1p2aYJMgg+EhKimXpMvEs7aDllYvh1XnZ62bIgL+1aPc0x9jWtfDfzTIQeDg20v3gEaNsgCixFiMKFcHsE1+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=oBVhKLo1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7ph+6qPy2QNKs5BgX9sm2D+uM01/NCEd/eq2joeWRxo=; b=oBVhKLo1YaiyOxQi76g8GribMm
	EGCqGO6VkHYVszdRnJfnCifHuXV8F/PMqtHwZ9WvGNTdxV6DJP/kx1zx7s1JGzcQVoeid9N3M5ZQH
	juhcaDg86+s3KL+8Fk5yKQ+sRbqTLFFOz/wxzxzXGvCv+DsPgtHr59usBcKwMNZI0WHKo9is5VznN
	KtUCfT5pB0iVwXaa3b/rX+ybQbx/Ar1SlNyLyJ4wOQv1PnjuNdcbw0L4Yi8qwlwJWb7yeuaaCVQCE
	KjRqjH5Stj1Cfods5ZDr1lFa2x2oQEqK2x1+DVhLB9tZxRLA9YhuRGEEBK0COxTssNO75lpee7fyV
	KyFNaVLA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:36642 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uytpH-000000004k7-1Ja2;
	Wed, 17 Sep 2025 16:12:07 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uytpG-00000006H29-1Ltk;
	Wed, 17 Sep 2025 16:12:06 +0100
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
Subject: [PATCH net-next 02/10] net: stmmac: use phy_interface in
 stmmac_check_pcs_mode()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uytpG-00000006H29-1Ltk@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 17 Sep 2025 16:12:06 +0100

In the majority, if not all cases, mac_interface and phy_interface
are the same with the exception of some drivers that I have suggested
only use phy_interface and set mac_interface to PHY_INTERFACE_MODE_NA.

The only two that currently set mac_interface to PHY_INTERFACE_MODE_NA
are dwmac-loongson and dwmac-lpc18xx, neither of which use RGMII nor
SGMII.

In order to phase out the use of mac_interface, we need to have a path
for existing drivers so they can update to only using phy_interface
without causing regressions.

Therefore, in order to keep the "pcs" code working, we need to choose
the STMMAC integrated PCS mode based on phy_interface if mac_interface
is PHY_INTERFACE_MODE_NA.

This will allow more drivers to set mac_interface to
PHY_INTERFACE_MODE_NA without risking regressions.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 8c8ca5999bd8..a23017a886f3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1120,6 +1120,9 @@ static void stmmac_check_pcs_mode(struct stmmac_priv *priv)
 {
 	int interface = priv->plat->mac_interface;
 
+	if (interface == PHY_INTERFACE_MODE_NA)
+		interface = priv->plat->phy_interface;
+
 	if (priv->dma_cap.pcs) {
 		if ((interface == PHY_INTERFACE_MODE_RGMII) ||
 		    (interface == PHY_INTERFACE_MODE_RGMII_ID) ||
-- 
2.47.3


