Return-Path: <netdev+bounces-167302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C43A39A7D
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 12:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122C81748F1
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 11:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786D2242917;
	Tue, 18 Feb 2025 11:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pv4grxLO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C525B241CA3
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 11:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739877338; cv=none; b=f0wt2VR8ZnK/u+8l9N1bZQwIw0LB8TXVpydfAg2YDQ/nW7+P0ursE0p7iJ3m1oW9gDHKkcRh9s/uAuSjufn3zdGszyFMM7uRFo8Kx1bLT0LhRW/NAWCzicRuqTbtjmEGeiBu8CRiNJyQ/A7WVcMqVPRXlui+CeTt+zl9nR5sjfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739877338; c=relaxed/simple;
	bh=iNB+KHUG8/IXey7G32odoqDgG8va+ldPSM/jV2TMBWc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=kEyQ+EsKCqSVO7cfMYE/2L3456slSmhGAO5T1Z3ZpZuFSDmIQX5/hAAukfBlAo1t+7PKFSIp1i/dZVi1QhRBBRgPgD04jDZiaxXUZNtmulAfYjewY/xAAiGFvrvG90cvI6BC90lZuivJBvi1Q7c/eCYxFjBA0TGnRsWk1JW5pBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=pv4grxLO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KSe0c69jHaZowf9s+caWtXk4sDZG6Bn7YtQiiu7h0+0=; b=pv4grxLOfAy1HTamSWjhCAJhnd
	vDFC0rhwnWlZcDfja5x8XaQsRi/2wTZYbHddAcMYqYvgT0GTl8g5vdyX3PASsLLan5wpnyrbLJ9Zj
	qtTcQzKGb4+nMCB5j8uC+3V3Jp+8u5bgJ2PvnykzggWLcbnzSX/d2xW3pSQ26APCp+buv83oT2w3g
	ZbZuLTNK0ZyUz4Cm5LLbzCassiQLRKhlmDifBsCyLTxCFd0PNz5F1qDSoFWFVhPgZ3dV83psZFDMm
	ltndkBeMLWG5DqDZpKJE0l59sUtvQjLEAQtJmVPRqCLKkflVWDFqYe/cHSSUIa/h1fnwvTN7hT33O
	O++gP5yg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51256 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tkLZQ-0001jR-2t;
	Tue, 18 Feb 2025 11:15:21 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tkLZ6-004RZO-0H; Tue, 18 Feb 2025 11:15:00 +0000
In-Reply-To: <Z7RrnyER5ewy0f3T@shell.armlinux.org.uk>
References: <Z7RrnyER5ewy0f3T@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev,
	Inochi Amaoto <inochiama@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	netdev@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH RFC net-next 5/7] net: stmmac: s32: use generic
 stmmac_set_clk_tx_rate()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tkLZ6-004RZO-0H@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 18 Feb 2025 11:15:00 +0000

Use the generic stmmac_set_clk_tx_rate() to configure the MAC transmit
clock.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-s32.c   | 22 +++----------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
index 6a498833b8ed..b76bfa41af82 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32.c
@@ -100,24 +100,6 @@ static void s32_gmac_exit(struct platform_device *pdev, void *priv)
 	clk_disable_unprepare(gmac->rx_clk);
 }
 
-static void s32_fix_mac_speed(void *priv, int speed, unsigned int mode)
-{
-	struct s32_priv_data *gmac = priv;
-	long tx_clk_rate;
-	int ret;
-
-	tx_clk_rate = rgmii_clock(speed);
-	if (tx_clk_rate < 0) {
-		dev_err(gmac->dev, "Unsupported/Invalid speed: %d\n", speed);
-		return;
-	}
-
-	dev_dbg(gmac->dev, "Set tx clock to %ld Hz\n", tx_clk_rate);
-	ret = clk_set_rate(gmac->tx_clk, tx_clk_rate);
-	if (ret)
-		dev_err(gmac->dev, "Can't set tx clock\n");
-}
-
 static int s32_dwmac_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat;
@@ -172,7 +154,9 @@ static int s32_dwmac_probe(struct platform_device *pdev)
 
 	plat->init = s32_gmac_init;
 	plat->exit = s32_gmac_exit;
-	plat->fix_mac_speed = s32_fix_mac_speed;
+
+	plat->clk_tx_i = dmac->tx_clk;
+	plat->set_clk_tx_rate = stmmac_set_clk_tx_rate;
 
 	plat->bsp_priv = gmac;
 
-- 
2.30.2


