Return-Path: <netdev+bounces-210569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66344B13F2F
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50193A5C2E
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D972727EC;
	Mon, 28 Jul 2025 15:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gD6is6on"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E052727EB
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717610; cv=none; b=YwuxmrQEw1TfZnzwzMP8tNP7jVgYinfzkRv3YywmFcPSADsAH4Q2tK7A6lTKJPCQtMnsw/fPIRkNlEV09o49lidGKO4qYTqf0AaYPOT82Ta44eq8KdgbuFyaK+MhvBhN2dSMIyRS4CglddYNoprebUT9bq6oZsAWJbvkoO1PRO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717610; c=relaxed/simple;
	bh=uTKdseZcPTlSi5SF3eLXaplUt2C7IGEij07FiI3ziEE=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=hmmtTfJBJpDMegGnljvNgjHvKYhJTNWQipkTX9wMBkPH9RDoViuFkjbMFT8hwolOgSqw4fShzg5iEizdBhppZR1vH5iF5GhjJJff/j8Uf8EDjkejpDVJxsHYF+3A3v8VS6X1PCCHM7LxGL+U3NJrIrjkyxYqsXnMeZutuvalbGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gD6is6on; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=h7p+MOlLweXe2Hm+XHQ5RfeFVChHqjBc73YEBAdhv8s=; b=gD6is6onBtRRFkuCtUmTqAbWbd
	nRYJZwBiIIHYby5y8n/ASqygGL6W9D3bfe4JzHu0zApAP0d/OcA1Q4tnDFpcAmeUNWZCN902XGgI5
	sfyOBRkCU0YlDmiHZc4ZtOW92KeDLmbZNjETNbdytjcqHhPfVO5zIht1mBUloE8glVqBcDoeTtjqh
	HALEc8zZ5NnQ0WbEItSIRq6Dr8slMFK7Fr5y2Hil5oN1Y3T1FAa6Yk2fqrmKzxd/svPWUVxxAHgrB
	LB/WMtrmLEM7HkYBp0QmtTIc4lgmHKN07CZhm63RRyyjih3xB2QOHVX0ew7LC6eXAjeId3cfqvZHD
	lRcpmE2w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54464 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1ugQ3l-0000V8-1D;
	Mon, 28 Jul 2025 16:46:41 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1ugQ33-006KDR-Nj; Mon, 28 Jul 2025 16:45:57 +0100
In-Reply-To: <aIebMKnQgzQxIY3j@shell.armlinux.org.uk>
References: <aIebMKnQgzQxIY3j@shell.armlinux.org.uk>
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
Subject: [PATCH RFC net-next 6/7] net: stmmac: add helpers to indicate WoL
 enable status
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ugQ33-006KDR-Nj@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 28 Jul 2025 16:45:57 +0100

Add two helpers to abstract the WoL enable status at the PHY and MAC to
make the code easier to read.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h          | 10 ++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c     | 11 +++++------
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c |  4 ++--
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index e1df59a643e3..2ae7174ec4b8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -373,6 +373,16 @@ enum stmmac_state {
 	STMMAC_SERVICE_SCHED,
 };
 
+static inline bool stmmac_wol_enabled_mac(struct stmmac_priv *priv)
+{
+	return priv->plat->pmt && device_may_wakeup(priv->device);
+}
+
+static inline bool stmmac_wol_enabled_phy(struct stmmac_priv *priv)
+{
+	return !priv->plat->pmt && device_may_wakeup(priv->device);
+}
+
 int stmmac_mdio_unregister(struct net_device *ndev);
 int stmmac_mdio_register(struct net_device *ndev);
 int stmmac_mdio_reset(struct mii_bus *mii);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7d467b494685..f44f8b1b0efa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7857,7 +7857,7 @@ int stmmac_suspend(struct device *dev)
 		priv->plat->serdes_powerdown(ndev, priv->plat->bsp_priv);
 
 	/* Enable Power down mode by programming the PMT regs */
-	if (device_may_wakeup(priv->device) && priv->plat->pmt) {
+	if (stmmac_wol_enabled_mac(priv)) {
 		stmmac_pmt(priv, priv->hw, priv->wolopts);
 		priv->irq_wake = 1;
 	} else {
@@ -7868,11 +7868,10 @@ int stmmac_suspend(struct device *dev)
 	mutex_unlock(&priv->lock);
 
 	rtnl_lock();
-	if (device_may_wakeup(priv->device) && !priv->plat->pmt)
+	if (stmmac_wol_enabled_phy(priv))
 		phylink_speed_down(priv->phylink, false);
 
-	phylink_suspend(priv->phylink,
-			device_may_wakeup(priv->device) && priv->plat->pmt);
+	phylink_suspend(priv->phylink, stmmac_wol_enabled_mac(priv));
 	rtnl_unlock();
 
 	if (stmmac_fpe_supported(priv))
@@ -7939,7 +7938,7 @@ int stmmac_resume(struct device *dev)
 	 * this bit because it can generate problems while resuming
 	 * from another devices (e.g. serial console).
 	 */
-	if (device_may_wakeup(priv->device) && priv->plat->pmt) {
+	if (stmmac_wol_enabled_mac(priv)) {
 		mutex_lock(&priv->lock);
 		stmmac_pmt(priv, priv->hw, 0);
 		mutex_unlock(&priv->lock);
@@ -7992,7 +7991,7 @@ int stmmac_resume(struct device *dev)
 	 * workqueue thread, which will race with initialisation.
 	 */
 	phylink_resume(priv->phylink);
-	if (device_may_wakeup(priv->device) && !priv->plat->pmt)
+	if (stmmac_wol_enabled_phy(priv))
 		phylink_speed_up(priv->phylink);
 
 	rtnl_unlock();
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 38b1c04c92a2..19f370bb934c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -954,7 +954,7 @@ static int __maybe_unused stmmac_pltfr_noirq_suspend(struct device *dev)
 	if (!netif_running(ndev))
 		return 0;
 
-	if (!device_may_wakeup(priv->device) || !priv->plat->pmt) {
+	if (!stmmac_wol_enabled_mac(priv)) {
 		/* Disable clock in case of PWM is off */
 		clk_disable_unprepare(priv->plat->clk_ptp_ref);
 
@@ -975,7 +975,7 @@ static int __maybe_unused stmmac_pltfr_noirq_resume(struct device *dev)
 	if (!netif_running(ndev))
 		return 0;
 
-	if (!device_may_wakeup(priv->device) || !priv->plat->pmt) {
+	if (!stmmac_wol_enabled_mac(priv)) {
 		/* enable the clk previously disabled */
 		ret = pm_runtime_force_resume(dev);
 		if (ret)
-- 
2.30.2


