Return-Path: <netdev+bounces-184694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07A7A96E54
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 16:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877151747BC
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 14:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2B72836A6;
	Tue, 22 Apr 2025 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Pz1Pef2m"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17B0284B49
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 14:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745331948; cv=none; b=A0EEnrjQuUB/RQ99AYv76WSUp5NO1eGMq7sIJord2oMFabwjwapG5VEeXwyVuoAeCaUJIWhQvW5ZT+K3SSwL9hZD8Vut4JORXF7qVt7/2X5CCZszCUmbbu2f6izIxREcdzoOMnyyg5Tqly8XKqgNBK/2Zcd+wEf3CrcrNbHgcqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745331948; c=relaxed/simple;
	bh=5gJixTPEf8w04D6a9DIYzik/nWy1z2LBagpR+Lm1WnA=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=DCMLwlj2e3qEkowiPWEEZ6b7zhfGienp0Jjdb5BgLmn986fkIpkPXNKszIBHE+4UGHwD1gSm+BjKUiylL69+wbXvfXh6m2vzl19qecEWI0DAzvHJMbUNL51g2oPnvQYt77vm6lPnIUdqN4dbgljOzzP//Gr+wJJPykpGPsXRe50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Pz1Pef2m; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UGzgge4Cct38yOd3/tCKvJ3b1vaJwT3ZIRj1lNpp1cE=; b=Pz1Pef2mUjNlncbUlh4coJX08W
	syEuOi4qCz9N+6w/3/C0Q2wH1XYMGHiKOgUslqVcaq68uujJmdmybQThAOKqPHirQ5k2XNBTDf5Qj
	ST7xWSIleEJX8ROMiyV3e+BAoLmG45LBY4qZkAUNOk+hcUSdlOSmy5Q/EJWvpemv7fjn4MpBnlK59
	LCcIlymVpdDXLyASzJW1jDCff4YLc/8SKSVU37eOB3DeIWvghUj7ybqvuSutMLvMYfKvszKm75jEb
	kjG7SjdMNfQEi92KAB1taIsfMsel4aqkxaRpDzX0YSqjseFXjICIALzo3IHU6J5iCOJrELUycaLAi
	XB00jkNw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:53204 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u7EZ3-0004WB-04;
	Tue, 22 Apr 2025 15:25:33 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u7EYR-001ZAS-Cr; Tue, 22 Apr 2025 15:24:55 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH net-next] net: stmmac: dwc-qos: calibrate tegra with mdio bus
 idle
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u7EYR-001ZAS-Cr@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 22 Apr 2025 15:24:55 +0100

Thierry states that there are prerequists for Tegra's calibration
that should be met before starting calibration - both the RGMII and
MDIO interfaces should be idle.

This commit adds the necessary MII bus locking to ensure that the MDIO
interface is idle during calibration.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c  | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index fa900b4991d0..09ae16e026eb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -136,10 +136,11 @@ static int dwc_qos_probe(struct platform_device *pdev,
 #define AUTO_CAL_STATUS 0x880c
 #define  AUTO_CAL_STATUS_ACTIVE BIT(31)
 
-static void tegra_eqos_fix_speed(void *priv, int speed, unsigned int mode)
+static void tegra_eqos_fix_speed(void *bsp_priv, int speed, unsigned int mode)
 {
-	struct tegra_eqos *eqos = priv;
+	struct tegra_eqos *eqos = bsp_priv;
 	bool needs_calibration = false;
+	struct stmmac_priv *priv;
 	u32 value;
 	int err;
 
@@ -158,6 +159,11 @@ static void tegra_eqos_fix_speed(void *priv, int speed, unsigned int mode)
 	}
 
 	if (needs_calibration) {
+		priv = netdev_priv(dev_get_drvdata(eqos->dev));
+
+		/* Calibration should be done with the MDIO bus idle */
+		mutex_lock(&priv->mii->mdio_lock);
+
 		/* calibrate */
 		value = readl(eqos->regs + SDMEMCOMPPADCTRL);
 		value |= SDMEMCOMPPADCTRL_PAD_E_INPUT_OR_E_PWRD;
@@ -191,6 +197,8 @@ static void tegra_eqos_fix_speed(void *priv, int speed, unsigned int mode)
 		value = readl(eqos->regs + SDMEMCOMPPADCTRL);
 		value &= ~SDMEMCOMPPADCTRL_PAD_E_INPUT_OR_E_PWRD;
 		writel(value, eqos->regs + SDMEMCOMPPADCTRL);
+
+		mutex_unlock(&priv->mii->mdio_lock);
 	} else {
 		value = readl(eqos->regs + AUTO_CAL_CONFIG);
 		value &= ~AUTO_CAL_CONFIG_ENABLE;
-- 
2.30.2


