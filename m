Return-Path: <netdev+bounces-155442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B617A02554
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B6003A55CC
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D856A1DDA2E;
	Mon,  6 Jan 2025 12:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="V/ZmxwXD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17781DC9AF
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 12:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736166346; cv=none; b=eNGLV5WYG+gP0ryxU/KZZF1XWtqEbrQyOHs1+gSnidRUyp44IMSOBFWykvXnNXut9UYkpW8gthfTsNpc7Lkz8t2+3iuYBA4hHezCl/p38Yzz22SewEc2UId61WuSjJW2o6TfGztoQIe052JjIdDDDcQ10Vnc1fhZP/MzpgDMWw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736166346; c=relaxed/simple;
	bh=F3U/siixhTWw9Y5Fs6+VbnUG31bqGeCpc03aJcgU1/g=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=lHs8r/fHUhP/oS0jJGvk1wUOj8rI6Hf341JHNexwaDfvSOcv6K0QaguQ0/EgQrDP+3jn79H+9zRVYalAG9Uwu1LRB9wJlGRkuraGQPLv7Yvx3z3d8RK6NbTVhIjNh9kJGiaKhiaN65a90ECw9kM6rlxq6Jjq3kh5XG64A4xFGCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=V/ZmxwXD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6gI78ITBgr5u8YVqy0tbvTfgVY6l4zQzaJ81AYLIoMY=; b=V/ZmxwXDi1xF14+Akhuih89uOh
	RZzuGN5+3ocWSNv0k2fqzUB3F/x1SjCXKTt9sNKw1s6E1g5h18geA3i8BqO3MyL7DjM5UXIyWmnXu
	010n0hTB2hVJlUxN7ZKRPD7wji3qFGUkdmk75C0tj7fSXfKbZfbDIh3VOlgO5Vlp7kOdxH/erMCcN
	cOzEtDTB4R0XgPfsI7zk7m0o5glCnzhyAB0Zajx/RpbryqKr7eZ/Xdsq/VUmWG1ot0PfwvXcVDLGp
	HXox0RWGJubC9hmvplSrqNbm/NFOKkpUIBK3t5IfEUuBXLpJzYb3gY9jxFFEy8I48wL8ORMn6AQgi
	N4BExLfA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42818 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tUmAr-0005sl-2W;
	Mon, 06 Jan 2025 12:25:37 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tUmAo-007VXb-Pg; Mon, 06 Jan 2025 12:25:34 +0000
In-Reply-To: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
References: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v2 10/17] net: stmmac: remove priv->eee_tw_timer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tUmAo-007VXb-Pg@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 06 Jan 2025 12:25:34 +0000

priv->eee_tw_timer is only assigned during initialisation to a
constant value (STMMAC_DEFAULT_TWT_LS) and then never changed.

Remove priv->eee_tw_timer, and instead use STMMAC_DEFAULT_TWT_LS
for both uses in stmmac_eee_init().

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
index 6b66a25716b0..7cce2eb3d82e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -466,8 +466,6 @@ static void stmmac_eee_ctrl_timer(struct timer_list *t)
  */
 static bool stmmac_eee_init(struct stmmac_priv *priv)
 {
-	int eee_tw_timer = priv->eee_tw_timer;
-
 	/* Check if MAC core supports the EEE feature. */
 	if (!priv->dma_cap.eee)
 		return false;
@@ -480,7 +478,8 @@ static bool stmmac_eee_init(struct stmmac_priv *priv)
 			netdev_dbg(priv->dev, "disable EEE\n");
 			stmmac_lpi_entry_timer_config(priv, 0);
 			del_timer_sync(&priv->eee_ctrl_timer);
-			stmmac_set_eee_timer(priv, priv->hw, 0, eee_tw_timer);
+			stmmac_set_eee_timer(priv, priv->hw, 0,
+					     STMMAC_DEFAULT_TWT_LS);
 			if (priv->hw->xpcs)
 				xpcs_config_eee(priv->hw->xpcs,
 						priv->plat->mult_fact_100ns,
@@ -493,7 +492,7 @@ static bool stmmac_eee_init(struct stmmac_priv *priv)
 	if (priv->eee_active && !priv->eee_enabled) {
 		timer_setup(&priv->eee_ctrl_timer, stmmac_eee_ctrl_timer, 0);
 		stmmac_set_eee_timer(priv, priv->hw, STMMAC_DEFAULT_LIT_LS,
-				     eee_tw_timer);
+				     STMMAC_DEFAULT_TWT_LS);
 		if (priv->hw->xpcs)
 			xpcs_config_eee(priv->hw->xpcs,
 					priv->plat->mult_fact_100ns,
@@ -3441,8 +3440,6 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 	else if (ptp_register)
 		stmmac_ptp_register(priv);
 
-	priv->eee_tw_timer = STMMAC_DEFAULT_TWT_LS;
-
 	if (priv->use_riwt) {
 		u32 queue;
 
-- 
2.30.2


