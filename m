Return-Path: <netdev+bounces-161371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A79FDA20D83
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11D70165C2F
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4494E1D63C8;
	Tue, 28 Jan 2025 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Xobegc1R"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD5E1D5AAD
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079278; cv=none; b=pOnP4iHBjk3kuHXTjlaY3SmIMZFInKMJN2Gba6nEYFZmsmKea+N872K6WSY1kDrQ8tsvBBPk804gCROFa6gFDAaehQ1p46M4YZ97FK0CEnXi1//MoCz7BI7gNfHDu/aGe0uXSb7imWKgJGcM8QwBLVsFiwHezKDFiKZX/Be3Ims=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079278; c=relaxed/simple;
	bh=MY64WJXoUa4NS8o6jFRbvqxULTqhnaYrjJjewbV4CmM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=YINMXc/h1zdfC22YknFfvnegkzXZA0BEw9I27CSuuDYKAFwXv9A2fCE+YlSSK8/yhTSlcYj7eG0tPK+oNpCHEQveVFi8DGfpWna91398G5j5fNVIXot6Vw+fNe+jRMipI0bIlxnl+o7YatiPQb1vi0IH3ymFqrweLhKq05xGihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Xobegc1R; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RC2pmzmWH4CgIBdJHLFPft8uDI2Dakt08wcW9mTokec=; b=Xobegc1RU6kQEofhgts4nN2yIP
	/XloiGBM64YCtWkJc2tMPyGBDaWfJ6c5WBa9mL+9wnpmtmkk9zsbzJv/LBh9z8mHKf8TVTygHjNvc
	eBUHp8hDdw00deaNjknn6CEaMUkmZZlfMuszQhrtiGpMVfvixga6ETSSCyeZ5gyuBaLeCGMIskQVW
	saBlOphZqyD1YSsAERYHDxT7UP3Q/tyZxKnF0m52UcN+PDAuFlbg604Et4n/K/RaOgVePqs8RxfAH
	NBKi7jphRw71PfgKkGIVREqzTOfPg1FEsoIk7SCan/pHVxW5uogiYixng9dfCgkrDifIzxo8XEY8l
	XgklHl2Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39314 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tcnoc-0007V3-0m;
	Tue, 28 Jan 2025 15:47:50 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tcnoI-0037Gu-UM; Tue, 28 Jan 2025 15:47:30 +0000
In-Reply-To: <Z5j7yCYSsQ7beznD@shell.armlinux.org.uk>
References: <Z5j7yCYSsQ7beznD@shell.armlinux.org.uk>
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
	Paolo Abeni <pabeni@redhat.com>,
	 Vladimir Oltean <olteanv@gmail.com>,
	 Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH RFC net-next 09/22] net: stmmac: remove unnecessary LPI
 disable when enabling LPI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tcnoI-0037Gu-UM@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 Jan 2025 15:47:30 +0000

Remove the unnecessary LPI disable when enabling LPI - as noted in
previous commits, there will never be two consecutive calls to
stmmac_mac_enable_tx_lpi() without an intervening
stmmac_mac_disable_tx_lpi.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 40b9e387446e..aafd9cee304e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -390,11 +390,6 @@ static inline u32 stmmac_rx_dirty(struct stmmac_priv *priv, u32 queue)
 	return dirty;
 }
 
-static void stmmac_disable_hw_lpi_timer(struct stmmac_priv *priv)
-{
-	stmmac_set_eee_lpi_timer(priv, priv->hw, 0);
-}
-
 static void stmmac_enable_hw_lpi_timer(struct stmmac_priv *priv)
 {
 	stmmac_set_eee_lpi_timer(priv, priv->hw, priv->tx_lpi_timer);
@@ -1082,14 +1077,10 @@ static int stmmac_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
 
 	if (priv->plat->has_gmac4 && priv->tx_lpi_timer <= STMMAC_ET_MAX) {
 		/* Use hardware LPI mode */
-		del_timer_sync(&priv->eee_ctrl_timer);
-		priv->tx_path_in_lpi_mode = false;
-		priv->eee_sw_timer_en = false;
 		stmmac_enable_hw_lpi_timer(priv);
 	} else {
 		/* Use software LPI mode */
 		priv->eee_sw_timer_en = true;
-		stmmac_disable_hw_lpi_timer(priv);
 		stmmac_restart_sw_lpi_timer(priv);
 	}
 
-- 
2.30.2


