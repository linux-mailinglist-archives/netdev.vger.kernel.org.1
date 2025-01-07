Return-Path: <netdev+bounces-155957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D20DA04662
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE57D7A2DB8
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F701F755B;
	Tue,  7 Jan 2025 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TRs/wFrb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21EA1F76A1
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267377; cv=none; b=Exvd2mqsB8ktmsD/ebKUip+K0cp9r8bwhBWwXyfDopc/lg5t76iE4YFghlfRMPnLz/SxQ8CmxRsomSa+V4po5zD/2jmCBPCwsiJMooXRCMpLPc+TAS3YdrGlwVop6ZnE77pyHgxhwKilp0NWcA1jXERtWR5I2hNBl/uujQXd/EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267377; c=relaxed/simple;
	bh=/ZTCQwc+7lcByQBBAiIBM6tAWqPwN9xnOOBBW8DkLtw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=T3OpasXFkPgUF6D73LZ7WAUwM93eQAh/cDzaMLW1ZrhbcMnlNGUVvm0yhF4iLF9YZupVukkHZ5GiMdRcBJ91uHNKSn+7DhxDFAgNej6MNNaiQENPSyu+XA2dY8FLLAu8taEmPvjbXwgQMEkBOgqvFIvKYkA3rgl+Q2+KmLmPhEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TRs/wFrb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Mt9PshpQqw68RFtJuRwMKIvYJt4mlpJLQSaP3lR5Qzk=; b=TRs/wFrbefMQBevnRZ11L1ROMJ
	PPEdgGHgV78aTWt7DstbuheA/huYsrue2LTMKnN++rLniEzjyuQ25PAZn2EJr39BeXzkW1cR6hrYB
	gcSf+qxIFKYVWR/SNaeiUrjiDQo2mdnKEwAsWWzvcgflkGlxyh1vM35lIhub0J60NT7SgXk8DuudI
	hG0d7PvN77PnmHDyeaxfSUkR8rZt4O+0EQTuYAzDaU6LMCc/jSsOchRpK97DcTOHHNneFV2+9lk4R
	VkNc+LvjuAgkzF1G3TbLV/dvVCMxAxbTBMJYykgPzznqYKvSvvRKg1/NeUVpKarK9Nn5I8uP4oXmz
	Htqn8dKw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43532 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tVCSM-0007nf-1F;
	Tue, 07 Jan 2025 16:29:26 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tVCSJ-007Y3x-C0; Tue, 07 Jan 2025 16:29:23 +0000
In-Reply-To: <Z31V9O8SATRbu2L3@shell.armlinux.org.uk>
References: <Z31V9O8SATRbu2L3@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v3 11/18] net: stmmac: remove priv->eee_tw_timer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tVCSJ-007Y3x-C0@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 07 Jan 2025 16:29:23 +0000

priv->eee_tw_timer is only assigned during initialisation to a
constant value (STMMAC_DEFAULT_TWT_LS) and then never changed.

Remove priv->eee_tw_timer, and instead use STMMAC_DEFAULT_TWT_LS
for both uses in stmmac_eee_init().

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      | 1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 9 +++------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 507b6ac14289..1556804cca38 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -308,7 +308,6 @@ struct stmmac_priv {
 	int eee_enabled;
 	int eee_active;
 	u32 tx_lpi_timer;
-	int eee_tw_timer;
 	bool eee_sw_timer_en;
 	unsigned int mode;
 	unsigned int chain_mode;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index adc51087f2ba..94bb6b07f96f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -464,8 +464,6 @@ static void stmmac_eee_ctrl_timer(struct timer_list *t)
  */
 static bool stmmac_eee_init(struct stmmac_priv *priv)
 {
-	int eee_tw_timer = priv->eee_tw_timer;
-
 	/* Check if MAC core supports the EEE feature. */
 	if (!priv->dma_cap.eee)
 		return false;
@@ -478,7 +476,8 @@ static bool stmmac_eee_init(struct stmmac_priv *priv)
 			netdev_dbg(priv->dev, "disable EEE\n");
 			stmmac_lpi_entry_timer_config(priv, 0);
 			del_timer_sync(&priv->eee_ctrl_timer);
-			stmmac_set_eee_timer(priv, priv->hw, 0, eee_tw_timer);
+			stmmac_set_eee_timer(priv, priv->hw, 0,
+					     STMMAC_DEFAULT_TWT_LS);
 			if (priv->hw->xpcs)
 				xpcs_config_eee(priv->hw->xpcs,
 						priv->plat->mult_fact_100ns,
@@ -491,7 +490,7 @@ static bool stmmac_eee_init(struct stmmac_priv *priv)
 	if (priv->eee_active && !priv->eee_enabled) {
 		timer_setup(&priv->eee_ctrl_timer, stmmac_eee_ctrl_timer, 0);
 		stmmac_set_eee_timer(priv, priv->hw, STMMAC_DEFAULT_LIT_LS,
-				     eee_tw_timer);
+				     STMMAC_DEFAULT_TWT_LS);
 		if (priv->hw->xpcs)
 			xpcs_config_eee(priv->hw->xpcs,
 					priv->plat->mult_fact_100ns,
@@ -3446,8 +3445,6 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 	else if (ptp_register)
 		stmmac_ptp_register(priv);
 
-	priv->eee_tw_timer = STMMAC_DEFAULT_TWT_LS;
-
 	if (priv->use_riwt) {
 		u32 queue;
 
-- 
2.30.2


