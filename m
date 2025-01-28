Return-Path: <netdev+bounces-161381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B588FA20D96
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A803A98DB
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACCA1D63CC;
	Tue, 28 Jan 2025 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="G1Sp+FFr"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971FD1D63C3
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 15:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738079330; cv=none; b=iuRTF+IqWQeQBAFJFDZZG6MGfu/Uiwblm3M0cmcaSsR9jrTM/hpI3oATl88JC+KBu76OK7Gk11uKdXObDyK5YTnLjnySG7VUAaQmAVO3wm0ns1s1MGh3ThL8gY/GsaSdxMaxs1c0uQBeamLXURcz2M2kiotiMlE5YmGGYVUBLT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738079330; c=relaxed/simple;
	bh=RSAUIm2FWuLK8gT1Q8q5b/UQFRLwytZmEWaCDOoT+mY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=T7SpsrcAU+BmCZxhs4sCSkWLZaln0Yp1KebmN/NpyymDypktreXgiutVT7mpf042JGWkFNf98y9PDwxXwQIOY5CyopI77g/cGx655xk7eEwMuNEtXxpNNkf/NgdEDTWFiAOx/03xWSaqP6Qcllpk/c+gMjkE7JiK16hPeetkTS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=G1Sp+FFr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=palMyM3mPY1asetOxby02+XjoraJnT8MIMUwZ6ft2jE=; b=G1Sp+FFrkgvasjMfr9sgaWfSSp
	UftYD+hqZqyy+fWOJndCV6ytedOzRdRVqyezZMgW2V8ugR5pErOD0K5nuQArQAixYIVZuCUVATuNs
	m2VW6c/OLmtZXMCqazy+Hjol3GK/vugbq3AGJ9d7dMuPjfhI3mr7dnp0p9qex/rvzuljppiKK1iwb
	FdHhRO+m5KfxbyfPZ3SYmmb0X5rYpN0oB5x66jmPhHIr/PcZuHtT99SPcMmdMwdFyQaytQafhyKkL
	J0Q9+zTGC3TFyoq9TC/9zijZ5bWTLvk5fQz1hrEg3FXc42AygCUj0l+RGxIiIe1PJDPIIFQ40gA+v
	Nm3UyJpQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50678 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tcnpR-0007Xw-1f;
	Tue, 28 Jan 2025 15:48:41 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tcnp8-0037Hu-4Y; Tue, 28 Jan 2025 15:48:22 +0000
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
Subject: [PATCH RFC net-next 19/22] net: stmmac: remove calls to
 xpcs_config_eee()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tcnp8-0037Hu-4Y@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 Jan 2025 15:48:22 +0000

Remove the explicit calls to xpcs_config_eee() from the stmmac driver,
preferring instead for phylink to manage the EEE configuration at the
PCS.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 5b47b2ad6b49..03d3042c12a3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1046,10 +1046,6 @@ static void stmmac_mac_disable_tx_lpi(struct phylink_config *config)
 	priv->tx_path_in_lpi_mode = false;
 
 	stmmac_set_eee_timer(priv, priv->hw, 0, STMMAC_DEFAULT_TWT_LS);
-	if (priv->hw->xpcs)
-		xpcs_config_eee(priv->hw->xpcs, priv->plat->mult_fact_100ns,
-				false);
-
 	mutex_unlock(&priv->lock);
 }
 
@@ -1068,9 +1064,6 @@ static int stmmac_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
 
 	stmmac_set_eee_timer(priv, priv->hw, STMMAC_DEFAULT_LIT_LS,
 			     STMMAC_DEFAULT_TWT_LS);
-	if (priv->hw->xpcs)
-		xpcs_config_eee(priv->hw->xpcs, priv->plat->mult_fact_100ns,
-				true);
 
 	/* Try to cnfigure the hardware timer. */
 	ret = stmmac_set_lpi_mode(priv, priv->hw, STMMAC_LPI_TIMER,
-- 
2.30.2


