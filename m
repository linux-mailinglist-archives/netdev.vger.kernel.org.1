Return-Path: <netdev+bounces-232939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAC6C09FE4
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 22:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300761AA22BF
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 20:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DEC2FFDEB;
	Sat, 25 Oct 2025 20:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="veMqvYHa"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCEC2D0635
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761425352; cv=none; b=DIzH29ZlumFHq0/x42hlv5YIaIlvV4WsjBbeJ9XT/haQnl/KV/K37J04osoSXeHd2HB9qb0bYkzSkahYQXkAG/AepmBXrhOquV3yGezvURG7vHokRshPW+hQnLDHn+25uWyiC3/UdCoOMj4NhWsFqlEXEAkPBF6U7kRCbuNh1Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761425352; c=relaxed/simple;
	bh=YgN4hzWJa2zI9fXP+KUofHp52+XQtD22oj7uLDZy5hc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=AFRP+ahbWn6W5e74zocGc9acvk4BPq5Ri2Tv+PimWqt7/y2/Y+JUAvhOt/5IoDipmvl4FvZKoJ5XQXrrA+g3816RzZyxc2ZJIrGa/n1GfNpQEyEyx81qpC7hPO6lFVfcyCRgJgunu3jZ7AxqGZno+CgwI5gEQgEQavkBZAUNkEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=veMqvYHa; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tsa26LUtnB+yfGPkqGfu37+Ohz48A6hBpNafuHU0e9c=; b=veMqvYHad03NP3Dqj+M2Hv/Stb
	sUo32dJSq4xNEpP3YM9TGRHlEOIHIVyZEjBjrXe1eO2T3DexrkpUNXOPI7Ta9YEwjs1tfmHx73j5I
	L3DkXYJq6vsLMlJepWVo2nLd6Q9/4hLzElYUUlaL/YYYBw7y0cWHqoI+zRqZLjuNwn1euO90UvSVv
	IpHaQbQIMcPbYV9stiXyiwqRVlMWGXZqXMsg2vRdp6g8NmtSS4eCgezSr2wf3ud/a2yUfLV5VX/GU
	ShvmvwomOea46erNRMb9iPK4hnD0S6rztUWf1o6K/I1qAi6zAlI1aQIaPIeLc+g8+ZGHNUCJjvEtS
	+9CpcL3Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41848 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vClC6-000000000QG-23At;
	Sat, 25 Oct 2025 21:48:58 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vClC5-0000000Bcbb-1WUk;
	Sat, 25 Oct 2025 21:48:57 +0100
In-Reply-To: <aP03aQLADMg-J_4W@shell.armlinux.org.uk>
References: <aP03aQLADMg-J_4W@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Alexis Lothor__" <alexis.lothore@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Furong Xu <0x1207@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: [PATCH net-next 3/3] net: stmmac: add support specifying PCS
 supported interfaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vClC5-0000000Bcbb-1WUk@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 25 Oct 2025 21:48:57 +0100

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c | 7 ++++++-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c    | 7 ++++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c     | 6 ++++--
 drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h     | 3 ++-
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index a2ae136d2c0e..0d85902bafd0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -24,12 +24,17 @@
 
 static int dwmac1000_pcs_init(struct stmmac_priv *priv)
 {
+	phy_interface_t mode;
+
 	if (!priv->dma_cap.pcs)
 		return 0;
 
+	mode = PHY_INTERFACE_MODE_SGMII;
+
 	return stmmac_integrated_pcs_init(priv, GMAC_PCS_BASE,
 					  GMAC_INT_DISABLE_PCSLINK |
-					  GMAC_INT_DISABLE_PCSAN);
+					  GMAC_INT_DISABLE_PCSAN,
+					  &mode, 1);
 }
 
 static void dwmac1000_core_init(struct mac_device_info *hw,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index a4282fd7c3c7..af9a336a32e6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -24,11 +24,16 @@
 
 static int dwmac4_pcs_init(struct stmmac_priv *priv)
 {
+	phy_interface_t mode;
+
 	if (!priv->dma_cap.pcs)
 		return 0;
 
+	mode = PHY_INTERFACE_MODE_SGMII;
+
 	return stmmac_integrated_pcs_init(priv, GMAC_PCS_BASE,
-					  GMAC_INT_PCS_LINK | GMAC_INT_PCS_ANE);
+					  GMAC_INT_PCS_LINK | GMAC_INT_PCS_ANE,
+					  &mode, 1);
 }
 
 static void dwmac4_core_init(struct mac_device_info *hw,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
index 77d38936d898..5293c52cf7af 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
@@ -65,7 +65,8 @@ static const struct phylink_pcs_ops dwmac_integrated_pcs_ops = {
 };
 
 int stmmac_integrated_pcs_init(struct stmmac_priv *priv, unsigned int offset,
-			       u32 int_mask)
+			       u32 int_mask, const phy_interface_t *modes,
+			       int num)
 {
 	struct stmmac_pcs *spcs;
 
@@ -78,7 +79,8 @@ int stmmac_integrated_pcs_init(struct stmmac_priv *priv, unsigned int offset,
 	spcs->int_mask = int_mask;
 	spcs->pcs.ops = &dwmac_integrated_pcs_ops;
 
-	__set_bit(PHY_INTERFACE_MODE_SGMII, spcs->pcs.supported_interfaces);
+	while (num--)
+		__set_bit(*modes++, spcs->pcs.supported_interfaces);
 
 	priv->integrated_pcs = spcs;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
index e42a98162c2b..36da4dab4f8f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
@@ -63,7 +63,8 @@ phylink_pcs_to_stmmac_pcs(struct phylink_pcs *pcs)
 }
 
 int stmmac_integrated_pcs_init(struct stmmac_priv *priv, unsigned int offset,
-			       u32 int_mask);
+			       u32 int_mask, const phy_interface_t *modes,
+			       int num);
 
 /**
  * dwmac_pcs_isr - TBI, RTBI, or SGMII PHY ISR
-- 
2.47.3


