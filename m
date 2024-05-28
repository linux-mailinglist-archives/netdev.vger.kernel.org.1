Return-Path: <netdev+bounces-98575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209B28D1CCF
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1A07B23CB4
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42AC171099;
	Tue, 28 May 2024 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dIMbbRup"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7622D17109B
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902446; cv=none; b=PA13i9MC/nI4LvlBqrWSAm4ZWPT30iO9tQOSUxhV2OSMsB6fQeAMH0lAJ3lkQ8EyrzFbxnZPZizotPNNeAdDsLuviYJ+/vuuv/UCDS645z76vYto92eJ0IQwRt6FHs7YkYZG2mlR4/VjZRG0ajEt+MceVyGAVroA59LwDE+fPV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902446; c=relaxed/simple;
	bh=KSEkdhcfktbJqKWDN8+HGN5nPrdvJN/lK1UCd5sZ4L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lc0aDVXe1JCa5KHdPJNQVF5zNH44P3FlxRFXiRUXJsB/syWgO/x2bgySIfpGEQ3djUKclSyA7oqdQ+F637lIhOfBV6CMbkJy7QBA+fdP+fGSRQwP0jXX0lxGCZC37q2ZE2QWktzFT5chQCYXuROa8zGkQCT1Wspy4Dy8vaw4Uxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dIMbbRup; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3cBJopQz7aRMcYAfwYYEG94ongaKop7HA/gNzxT33Cs=; b=dIMbbRupZ8Aoe065U5CpBAf+yG
	oaz/YzbyujTeslSgdwM/emUZA5730NXFZdw7jMSaUz5o+7c8k0hOJW1udsBqWAV3RBE71azGxjxHz
	BjHT0zqybmBzDRTZOYdX8z/ED4uNcxwoVbZibi1+8wzpK0d1PPGOJSSA801SedeWhDjKDEJ24akFA
	xuUjaQ5tb5Wsy0vSJZIf2LeNwGJ8vboDIRsohvY4S2RYYQqFlsssmxXNN4sE8UYE6TazNb5hoE494
	O6TKCFLcUIGtL8+PIsrQ6cGX5rHxZaqRCylb9eJcNcMRLrTnNcc36JTywxRU3tERKT2on3ioeyXA/
	pptAk6EQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45384)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sBwke-0004qp-00;
	Tue, 28 May 2024 14:20:28 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sBwkd-0003I6-Ef; Tue, 28 May 2024 14:20:27 +0100
Date: Tue, 28 May 2024 14:20:27 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 1/5] net: stmmac: Drop TBI/RTBI PCS flags
Message-ID: <ZlXaGye/39hk4iuw@shell.armlinux.org.uk>
References: <ZlXEgl7tgdWMNvoB@shell.armlinux.org.uk>
 <E1sBvJl-00EHyQ-QG@rmk-PC.armlinux.org.uk>
 <66lbyxnuhqhng2j2bmnw4ke6bqeknpeb476b2wjhr3xdstr5jw@vlgbxf3ni7nt>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66lbyxnuhqhng2j2bmnw4ke6bqeknpeb476b2wjhr3xdstr5jw@vlgbxf3ni7nt>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, May 28, 2024 at 03:26:10PM +0300, Serge Semin wrote:
> On Tue, May 28, 2024 at 12:48:37PM +0100, Russell King wrote:
> > From: Serge Semin <fancer.lancer@gmail.com>
> > 
> > First of all the flags are never set by any of the driver parts. If nobody
> > have them set then the respective statements will always have the same
> > result. Thus the statements can be simplified or even dropped with no risk
> > to break things.
> > 
> > Secondly shall any of the TBI or RTBI flag is set the MDIO-bus
> > registration will be bypassed. Why? It really seems weird. It's perfectly
> > fine to have a TBI/RTBI-capable PHY configured over the MDIO bus
> > interface.
> > 
> > Based on the notes above the TBI/RTBI PCS flags can be freely dropped thus
> > simplifying the driver code.
> 
> Likely by mistake the vast majority of the original patch content has
> been missing here:
> https://lore.kernel.org/netdev/20240524210304.9164-3-fancer.lancer@gmail.com/

I really can't explain this, other than git doing something weird. There
is no reason that just one hunk that conflicted from a patch would've
appeared. Should've been as per the below, which it will be when I post
v2. Thanks for spotting!

8<===
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH net-next] net: stmmac: Drop TBI/RTBI PCS flags

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


-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

