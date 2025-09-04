Return-Path: <netdev+bounces-219924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D0BB43B3D
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 14:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA1C5A37A0
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A5C2F3616;
	Thu,  4 Sep 2025 12:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mSpzzCEx"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81E02DE70D
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 12:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987905; cv=none; b=Mf9XBt1l/vBFZLQvdoT5iNuPowDmBllx4COqRLIFnDrezIHF1XKCo0m+IK+ueWY8qt4/53dzLJnCMQj4F+rLiR8ehQr4UuDeW5RF/GC7EE16vfEdfyFZPI0ga9S4Cq1IrseiGas4qbd8BuSjGlhS42l0X7bF/bmqwz6zBrDcMkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987905; c=relaxed/simple;
	bh=pYfo8HaOxrAXrbYqs0QBpCxDM326ONdfYsAYGiXPI18=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=kAin0vBANPTyOu5i5N3GRqsgI9EQyfH2z1pMHf9gzoM64qs+izhbOOpo9CzXnSzY99MmfCoxFRWPZaQdxkgcFg6FkjO7lOW+Ao+ypVtqWuOzGarmYKyG+g6oBp7iQWj4VM1BfodLKJzsZq9h4BVHG045dgTXBmBLDEQSTDgs6G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mSpzzCEx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0QRGYobCv2NKVMfroOLyvFZaQo+/7GeE08xyPEuyLxk=; b=mSpzzCExBhFWOvJ5EAL7zgmNUa
	VkuEU/ewkjISy+hUA3dI7Mqma6zwdrNhnTK2goEOsR7tdj33wdcZzSG0hY56AR1MYTj6RRLk+LYLG
	wbPgXKEef0CyYOf4o/OmmcYtrmas9u1yvT/qujUckRN3pxnyIyWuFaTojbXbszw41oTu3XLFeFy64
	4jG3TRoBhe4vL0CmzWiCIFzBYYhFvp9E4vTJSPZwRTSQ6g3MpjSkIg4GQgXfE/LkmAl/e3Y7yUc7v
	Hx+Wi39z7pkKhVL2Q9am9wGprVEIv+bs8riq0NdqscqzaA3GpIZjbPw93qb6gg7S792kOpXCUUSpQ
	lrpQXtFw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:48244 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uu8oS-000000001yt-3NEV;
	Thu, 04 Sep 2025 13:11:36 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uu8oR-00000001vpB-3fbY;
	Thu, 04 Sep 2025 13:11:35 +0100
In-Reply-To: <aLmBwsMdW__XBv7g@shell.armlinux.org.uk>
References: <aLmBwsMdW__XBv7g@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v2 08/11] net: stmmac: mdio: move initialisation of
 priv->clk_csr to stmmac_mdio
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uu8oR-00000001vpB-3fbY@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 04 Sep 2025 13:11:35 +0100

The only user of priv->clk_csr is the MDIO code, so move its
initialisation to stmmac_mdio.c.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 82 -----------------
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 88 ++++++++++++++++++-
 2 files changed, 86 insertions(+), 84 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f0abd99fd137..419cb49ee5a2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -314,77 +314,6 @@ static void stmmac_global_err(struct stmmac_priv *priv)
 	stmmac_service_event_schedule(priv);
 }
 
-/**
- * stmmac_clk_csr_set - dynamically set the MDC clock
- * @priv: driver private structure
- * Description: this is to dynamically set the MDC clock according to the csr
- * clock input.
- * Note:
- *	If a specific clk_csr value is passed from the platform
- *	this means that the CSR Clock Range selection cannot be
- *	changed at run-time and it is fixed (as reported in the driver
- *	documentation). Viceversa the driver will try to set the MDC
- *	clock dynamically according to the actual clock input.
- */
-static void stmmac_clk_csr_set(struct stmmac_priv *priv)
-{
-	unsigned long clk_rate;
-
-	clk_rate = clk_get_rate(priv->plat->stmmac_clk);
-
-	/* Platform provided default clk_csr would be assumed valid
-	 * for all other cases except for the below mentioned ones.
-	 * For values higher than the IEEE 802.3 specified frequency
-	 * we can not estimate the proper divider as it is not known
-	 * the frequency of clk_csr_i. So we do not change the default
-	 * divider.
-	 */
-	if (!(priv->clk_csr & MAC_CSR_H_FRQ_MASK)) {
-		if (clk_rate < CSR_F_35M)
-			priv->clk_csr = STMMAC_CSR_20_35M;
-		else if ((clk_rate >= CSR_F_35M) && (clk_rate < CSR_F_60M))
-			priv->clk_csr = STMMAC_CSR_35_60M;
-		else if ((clk_rate >= CSR_F_60M) && (clk_rate < CSR_F_100M))
-			priv->clk_csr = STMMAC_CSR_60_100M;
-		else if ((clk_rate >= CSR_F_100M) && (clk_rate < CSR_F_150M))
-			priv->clk_csr = STMMAC_CSR_100_150M;
-		else if ((clk_rate >= CSR_F_150M) && (clk_rate < CSR_F_250M))
-			priv->clk_csr = STMMAC_CSR_150_250M;
-		else if ((clk_rate >= CSR_F_250M) && (clk_rate <= CSR_F_300M))
-			priv->clk_csr = STMMAC_CSR_250_300M;
-		else if ((clk_rate >= CSR_F_300M) && (clk_rate < CSR_F_500M))
-			priv->clk_csr = STMMAC_CSR_300_500M;
-		else if ((clk_rate >= CSR_F_500M) && (clk_rate < CSR_F_800M))
-			priv->clk_csr = STMMAC_CSR_500_800M;
-	}
-
-	if (priv->plat->flags & STMMAC_FLAG_HAS_SUN8I) {
-		if (clk_rate > 160000000)
-			priv->clk_csr = 0x03;
-		else if (clk_rate > 80000000)
-			priv->clk_csr = 0x02;
-		else if (clk_rate > 40000000)
-			priv->clk_csr = 0x01;
-		else
-			priv->clk_csr = 0;
-	}
-
-	if (priv->plat->has_xgmac) {
-		if (clk_rate > 400000000)
-			priv->clk_csr = 0x5;
-		else if (clk_rate > 350000000)
-			priv->clk_csr = 0x4;
-		else if (clk_rate > 300000000)
-			priv->clk_csr = 0x3;
-		else if (clk_rate > 250000000)
-			priv->clk_csr = 0x2;
-		else if (clk_rate > 150000000)
-			priv->clk_csr = 0x1;
-		else
-			priv->clk_csr = 0x0;
-	}
-}
-
 static void print_pkt(unsigned char *buf, int len)
 {
 	pr_debug("len = %d byte, buf addr: 0x%p\n", len, buf);
@@ -7718,17 +7647,6 @@ int stmmac_dvr_probe(struct device *device,
 
 	stmmac_fpe_init(priv);
 
-	/* If a specific clk_csr value is passed from the platform
-	 * this means that the CSR Clock Range selection cannot be
-	 * changed at run-time and it is fixed. Viceversa the driver'll try to
-	 * set the MDC clock dynamically according to the csr actual
-	 * clock input.
-	 */
-	if (priv->plat->clk_csr >= 0)
-		priv->clk_csr = priv->plat->clk_csr;
-	else
-		stmmac_clk_csr_set(priv);
-
 	stmmac_check_pcs_mode(priv);
 
 	pm_runtime_get_noresume(device);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index f2b4c1b70ef5..0b5282bf6d1e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -473,8 +473,92 @@ void stmmac_pcs_clean(struct net_device *ndev)
 	priv->hw->xpcs = NULL;
 }
 
-static void stmmac_mdio_bus_config(struct stmmac_priv *priv, u32 value)
+/**
+ * stmmac_clk_csr_set - dynamically set the MDC clock
+ * @priv: driver private structure
+ * Description: this is to dynamically set the MDC clock according to the csr
+ * clock input.
+ * Note:
+ *	If a specific clk_csr value is passed from the platform
+ *	this means that the CSR Clock Range selection cannot be
+ *	changed at run-time and it is fixed (as reported in the driver
+ *	documentation). Viceversa the driver will try to set the MDC
+ *	clock dynamically according to the actual clock input.
+ */
+static void stmmac_clk_csr_set(struct stmmac_priv *priv)
 {
+	unsigned long clk_rate;
+
+	clk_rate = clk_get_rate(priv->plat->stmmac_clk);
+
+	/* Platform provided default clk_csr would be assumed valid
+	 * for all other cases except for the below mentioned ones.
+	 * For values higher than the IEEE 802.3 specified frequency
+	 * we can not estimate the proper divider as it is not known
+	 * the frequency of clk_csr_i. So we do not change the default
+	 * divider.
+	 */
+	if (!(priv->clk_csr & MAC_CSR_H_FRQ_MASK)) {
+		if (clk_rate < CSR_F_35M)
+			priv->clk_csr = STMMAC_CSR_20_35M;
+		else if ((clk_rate >= CSR_F_35M) && (clk_rate < CSR_F_60M))
+			priv->clk_csr = STMMAC_CSR_35_60M;
+		else if ((clk_rate >= CSR_F_60M) && (clk_rate < CSR_F_100M))
+			priv->clk_csr = STMMAC_CSR_60_100M;
+		else if ((clk_rate >= CSR_F_100M) && (clk_rate < CSR_F_150M))
+			priv->clk_csr = STMMAC_CSR_100_150M;
+		else if ((clk_rate >= CSR_F_150M) && (clk_rate < CSR_F_250M))
+			priv->clk_csr = STMMAC_CSR_150_250M;
+		else if ((clk_rate >= CSR_F_250M) && (clk_rate <= CSR_F_300M))
+			priv->clk_csr = STMMAC_CSR_250_300M;
+		else if ((clk_rate >= CSR_F_300M) && (clk_rate < CSR_F_500M))
+			priv->clk_csr = STMMAC_CSR_300_500M;
+		else if ((clk_rate >= CSR_F_500M) && (clk_rate < CSR_F_800M))
+			priv->clk_csr = STMMAC_CSR_500_800M;
+	}
+
+	if (priv->plat->flags & STMMAC_FLAG_HAS_SUN8I) {
+		if (clk_rate > 160000000)
+			priv->clk_csr = 0x03;
+		else if (clk_rate > 80000000)
+			priv->clk_csr = 0x02;
+		else if (clk_rate > 40000000)
+			priv->clk_csr = 0x01;
+		else
+			priv->clk_csr = 0;
+	}
+
+	if (priv->plat->has_xgmac) {
+		if (clk_rate > 400000000)
+			priv->clk_csr = 0x5;
+		else if (clk_rate > 350000000)
+			priv->clk_csr = 0x4;
+		else if (clk_rate > 300000000)
+			priv->clk_csr = 0x3;
+		else if (clk_rate > 250000000)
+			priv->clk_csr = 0x2;
+		else if (clk_rate > 150000000)
+			priv->clk_csr = 0x1;
+		else
+			priv->clk_csr = 0x0;
+	}
+}
+
+static void stmmac_mdio_bus_config(struct stmmac_priv *priv)
+{
+	u32 value;
+
+	/* If a specific clk_csr value is passed from the platform, this means
+	 * that the CSR Clock Range value should not be computed from the CSR
+	 * clock.
+	 */
+	if (priv->plat->clk_csr >= 0) {
+		value = priv->plat->clk_csr;
+	} else {
+		stmmac_clk_csr_set(priv);
+		value = priv->clk_csr;
+	}
+
 	value <<= priv->hw->mii.clk_csr_shift;
 
 	if (value & ~priv->hw->mii.clk_csr_mask)
@@ -505,7 +589,7 @@ int stmmac_mdio_register(struct net_device *ndev)
 	if (!mdio_bus_data)
 		return 0;
 
-	stmmac_mdio_bus_config(priv, priv->clk_csr);
+	stmmac_mdio_bus_config(priv);
 
 	new_bus = mdiobus_alloc();
 	if (!new_bus)
-- 
2.47.2


