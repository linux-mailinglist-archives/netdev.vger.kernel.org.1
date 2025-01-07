Return-Path: <netdev+bounces-155950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76A2A0465A
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9622B166E1B
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2942E1F63F0;
	Tue,  7 Jan 2025 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xg9kxxd0"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5651F4729
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267348; cv=none; b=QZZmeqkJqcfFxb68FrAqRFJJMDkTsTOohx+ytoUiPcw+eh4Rw7yphVkB45n4TvMQkOcx7L4CdUwwHDZTSscslvItSRLictm8EA6yMGpDj5mt97hX0WLgZVpH5SWG4kQ8cqRyE4H7W/RqRmTAXgYU4aCVSq5tMxO9f1qw2U1kc2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267348; c=relaxed/simple;
	bh=20y3Qodfmy8KmZTq02mN8MXq9rQEQ8sLOnnOrTkNRe4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=BO93LcI1EroUH1qH1kNlLsDY+BbuTDt/ad11EKCjnghKX765dUQ1F+1XpshAgBNWAusnu/DmhKpYHya3njbM8SocaArMN/i/0hPIt1jvq+tWd9QIOyX4XyLpYajGEBJu2zh/7HSeRz9mzxM4CDodWPduyF+Rzje7cn51xTpekHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xg9kxxd0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m7sRj8MyoTLWqspxEn08rVS2H9QlJQS/1BnosoK5uUE=; b=xg9kxxd0sospqxYjcrJa2w6E/X
	5y/Nwj/KkPQ/2OFt7FuwkYzuqvvKOLFKPu4ha2jEFOdz0ckKVwN8aNDauUlbaeMArbUmEIjl62hDO
	sXYM+SlKJKoY8zT0KPfa0EQY64AATcNOSeDK3SyqPMAnAj3HHceR/qmYrNyqAShQRZCNOFbBRFdoz
	8XApR5tkq4MOh69sEtRXz0hG6K2Jf1J+TQzBfRMXRYwy28lkdmfUMvfosqEq91sIO3p6R58IbQ1nJ
	gUPKDkZttQ5m6McsfD+bOrpQ64rzVggOnMH4KIOnaI4zi0YvWB47n1gpJikpxnwFEx6nqRXE5MPeA
	gSg5B7cQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:58284 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tVCRr-0007lz-1x;
	Tue, 07 Jan 2025 16:28:55 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tVCRo-007Y3N-Kl; Tue, 07 Jan 2025 16:28:52 +0000
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
Subject: [PATCH net-next v3 05/18] net: stmmac: make EEE depend on
 phy->enable_tx_lpi
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tVCRo-007Y3N-Kl@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 07 Jan 2025 16:28:52 +0000

Make stmmac EEE depend on phylib's evaluation of user settings and PHY
negotiation, as indicated by phy->enable_tx_lpi. This will ensure when
phylib has evaluated that the user has disabled LPI, phy_init_eee()
will not be called, and priv->eee_active will be false, causing LPI/EEE
to be disabled.

This is an interim measure - phy_init_eee() will be removed in a later
patch.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 96393e6feda0..3135bfdbee3c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1083,7 +1083,7 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 
 	stmmac_mac_set(priv, priv->ioaddr, true);
 	if (phy && priv->dma_cap.eee) {
-		priv->eee_active =
+		priv->eee_active = phy->enable_tx_lpi &&
 			phy_init_eee(phy, !(priv->plat->flags &
 				STMMAC_FLAG_RX_CLK_RUNS_IN_LPI)) >= 0;
 		priv->tx_lpi_timer = phy->eee_cfg.tx_lpi_timer;
-- 
2.30.2


