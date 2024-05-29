Return-Path: <netdev+bounces-98897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7FD8D31B8
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139BC1F28583
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 08:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAB8168C1A;
	Wed, 29 May 2024 08:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xM6l/+Eo"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CF915DBC6
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716972047; cv=none; b=sHcPJG7dYSwXBmO9NYfmu2h0n2tV/uj9cONk33JYL1S92b9em3ljjOWCDFdijq2vTnJ/KdC8C+IEzN3Z8b1e5DMlRLuyPwOoXYVv3knCIbMnI2AvPbiOvozy9A1Ru2MZRoo2AiemV62dVQRoVZHRbxzn8xS4MycrT4E4xS3bpt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716972047; c=relaxed/simple;
	bh=i6a5mwBV6siZjVKtQQi+eU1SN9IVx9kvWAxt9p/uUh8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=PRXzuL7/29uZ8Zyp6SUo+mTjUqnZO/arF+YmwvMJ6dVoEpbtQPPcWzF0QlyZcOMIhDZ584iiSadIgcqGj5Pygp970yyww5Ij2PIyvzi08q7Ix7YGYSlMDHzwQZDmQWjZeTAET6K7gLxR/PzBQ5i4ga1FE3zgDIzpKhrxnq2aleY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xM6l/+Eo; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Qk2np4GvykEUiruv1QXUbfXjY8rb++HSHg0fFK/aByk=; b=xM6l/+EoO+EstRAuOSqxz/ehya
	IY05SYzq+OW5GQFqlETDsJanH83/uoBaiXdJewJza4w++LlDdjxaJ1QP9HiTGvgwKwmDHQG3WQDVk
	j/nBz0HoTBIYjhTfyyVGI0UdE249hUAJ+QXM6i8rVo/xL8G1XP/gFtrseCKi1ov7Q7h7r3XcHdCER
	+0sqgC/SlSfJieeefeD2XkLo4fxgYeppcw5D9KZ4CNteujtvhc0x46BCY7hvDgj9s8CJZnX7t3ecE
	S5kUbSTm8Iv0zCMdEh12iU8gycFmLuk5zQNogR3QBykF+6PWM4oYxMYP1VK0RfiaEWfjGpUn3W24Z
	R9BMTV7Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51688 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sCErH-0005lY-2M;
	Wed, 29 May 2024 09:40:31 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sCErK-00EOPf-EP; Wed, 29 May 2024 09:40:34 +0100
In-Reply-To: <Zlbp7xdUZAXblOZJ@shell.armlinux.org.uk>
References: <Zlbp7xdUZAXblOZJ@shell.armlinux.org.uk>
From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Andrew Halaney <ahalaney@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v2 1/6] net: stmmac: Drop TBI/RTBI PCS flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sCErK-00EOPf-EP@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 29 May 2024 09:40:34 +0100

From: Serge Semin <fancer.lancer@gmail.com>

First of all the flags are never set by any of the driver parts. If nobody
have them set then the respective statements will always have the same
result. Thus the statements can be simplified or even dropped with no risk
to break things.

Secondly shall any of the TBI or RTBI flag is set the MDIO-bus
registration will be bypassed. Why? It really seems weird. It's perfectly
fine to have a TBI/RTBI-capable PHY configured over the MDIO bus
interface.

Based on the notes above the TBI/RTBI PCS flags can be freely dropped thus
simplifying the driver code.

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  |  2 --
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 35 +++++--------------
 2 files changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 9cd62b2110a1..cd36ff4da68c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -271,8 +271,6 @@ struct stmmac_safety_stats {
 /* PCS defines */
 #define STMMAC_PCS_RGMII	(1 << 0)
 #define STMMAC_PCS_SGMII	(1 << 1)
-#define STMMAC_PCS_TBI		(1 << 2)
-#define STMMAC_PCS_RTBI		(1 << 3)
 
 #define SF_DMA_MODE 1		/* DMA STORE-AND-FORWARD Operation Mode */
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b3afc7cb7d72..3ab93f89be90 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -471,13 +471,6 @@ bool stmmac_eee_init(struct stmmac_priv *priv)
 {
 	int eee_tw_timer = priv->eee_tw_timer;
 
-	/* Using PCS we cannot dial with the phy registers at this stage
-	 * so we do not support extra feature like EEE.
-	 */
-	if (priv->hw->pcs == STMMAC_PCS_TBI ||
-	    priv->hw->pcs == STMMAC_PCS_RTBI)
-		return false;
-
 	/* Check if MAC core supports the EEE feature. */
 	if (!priv->dma_cap.eee)
 		return false;
@@ -3953,9 +3946,7 @@ static int __stmmac_open(struct net_device *dev,
 	if (ret < 0)
 		return ret;
 
-	if (priv->hw->pcs != STMMAC_PCS_TBI &&
-	    priv->hw->pcs != STMMAC_PCS_RTBI &&
-	    (!priv->hw->xpcs ||
+	if ((!priv->hw->xpcs ||
 	     xpcs_get_an_mode(priv->hw->xpcs, mode) != DW_AN_C73)) {
 		ret = stmmac_init_phy(dev);
 		if (ret) {
@@ -7739,16 +7730,12 @@ int stmmac_dvr_probe(struct device *device,
 	if (!pm_runtime_enabled(device))
 		pm_runtime_enable(device);
 
-	if (priv->hw->pcs != STMMAC_PCS_TBI &&
-	    priv->hw->pcs != STMMAC_PCS_RTBI) {
-		/* MDIO bus Registration */
-		ret = stmmac_mdio_register(ndev);
-		if (ret < 0) {
-			dev_err_probe(priv->device, ret,
-				      "%s: MDIO bus (id: %d) registration failed\n",
-				      __func__, priv->plat->bus_id);
-			goto error_mdio_register;
-		}
+	ret = stmmac_mdio_register(ndev);
+	if (ret < 0) {
+		dev_err_probe(priv->device, ret,
+			      "MDIO bus (id: %d) registration failed\n",
+			      priv->plat->bus_id);
+		goto error_mdio_register;
 	}
 
 	if (priv->plat->speed_mode_2500)
@@ -7790,9 +7777,7 @@ int stmmac_dvr_probe(struct device *device,
 error_phy_setup:
 	stmmac_pcs_clean(ndev);
 error_pcs_setup:
-	if (priv->hw->pcs != STMMAC_PCS_TBI &&
-	    priv->hw->pcs != STMMAC_PCS_RTBI)
-		stmmac_mdio_unregister(ndev);
+	stmmac_mdio_unregister(ndev);
 error_mdio_register:
 	stmmac_napi_del(ndev);
 error_hw_init:
@@ -7833,10 +7818,8 @@ void stmmac_dvr_remove(struct device *dev)
 	reset_control_assert(priv->plat->stmmac_ahb_rst);
 
 	stmmac_pcs_clean(ndev);
+	stmmac_mdio_unregister(ndev);
 
-	if (priv->hw->pcs != STMMAC_PCS_TBI &&
-	    priv->hw->pcs != STMMAC_PCS_RTBI)
-		stmmac_mdio_unregister(ndev);
 	destroy_workqueue(priv->wq);
 	mutex_destroy(&priv->lock);
 	bitmap_free(priv->af_xdp_zc_qps);
-- 
2.30.2


