Return-Path: <netdev+bounces-155959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C181A04665
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6EF77A22E2
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E321F8AC7;
	Tue,  7 Jan 2025 16:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NehBVLUz"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FD21F708B
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736267388; cv=none; b=H/X9/yGU5Q4f7Cw4/rLaujGuW+uFYgCWPfHj78tIrSTqfXKsv60Wkzs/X9GQzHsbR2Sb8mHZ3jQo5IeLqx3eTnoHSc64ssx+LCSayXXtDMNAO8aEaqQFhkr1biDKoWIK3OTUKKmSb5W4MeSk880j7HKzC/qdg3XkTMmJtbCCXAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736267388; c=relaxed/simple;
	bh=5zoNMm/muoicMU0Nc8p1Fm+E9Nzsn10YLobO/fLH5lM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=PZZLktHUK/UQ5zdagMOU8NomsOGVHcPwU9ngketeHdR95Be7rAQ3k54DXa7lSFjr7DLXoirSoJmGttQU5yi1qBu8psA+S2c0Mwolehi6uXsklLyUIG3KS6JUpFxHFgr5QLMuYEbsI/K8afJR9+9kZcVn28Ovv5xxVKIb197qODY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NehBVLUz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=j7GTEfja/07m/dxB/a0CmEMLPjybqsk6izUSl+b/tGQ=; b=NehBVLUzKnsWVryZjHikpQFsFc
	SP4CIefwSQ7PZaqxSlnyZI+mGSaYqNjOLu0MMub8lkZAKpvZcBZZuolgCtQBGGbOxEW1WfFLrnrCv
	KKpZSF3yQEtViR/VZka8uwtJ3Izj/zbg854NgsBgzOyOP9mG19PTGf4INZcks8QRYHYsP7sh5f0fc
	ihhkcVnU8NlbWX7LfUthgvqf14V05TCjgNClIVz9v0WdlsJhfn/nMMhyAxu4GpgkhbKD5R6jwGW1l
	Tr6an33e/hrWFtnM/fnFcVtmxP1ioD2qlbRFPXZI1GNpHGKJDEZfn56rByFkhLxBBajkIiZL0N0Ma
	0pjrDNig==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59408 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tVCSW-0007oH-1t;
	Tue, 07 Jan 2025 16:29:36 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tVCST-007Y49-In; Tue, 07 Jan 2025 16:29:33 +0000
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
Subject: [PATCH net-next v3 13/18] net: stmmac: move priv->eee_active into
 stmmac_eee_init()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tVCST-007Y49-In@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 07 Jan 2025 16:29:33 +0000

Since all call sites of stmmac_eee_init() assign priv->eee_active
immediately before, pass this state into stmmac_eee_init() and
assign priv->eee_active within this function.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b7e0026c271b..7c1dbc5fa84b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -457,13 +457,16 @@ static void stmmac_eee_ctrl_timer(struct timer_list *t)
 /**
  * stmmac_eee_init - init EEE
  * @priv: driver private structure
+ * @active: indicates whether EEE should be enabled.
  * Description:
  *  if the GMAC supports the EEE (from the HW cap reg) and the phy device
  *  can also manage EEE, this function enable the LPI state and start related
  *  timer.
  */
-static void stmmac_eee_init(struct stmmac_priv *priv)
+static void stmmac_eee_init(struct stmmac_priv *priv, bool active)
 {
+	priv->eee_active = active;
+
 	/* Check if MAC core supports the EEE feature. */
 	if (!priv->dma_cap.eee) {
 		priv->eee_enabled = false;
@@ -970,8 +973,7 @@ static void stmmac_mac_link_down(struct phylink_config *config,
 	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
 
 	stmmac_mac_set(priv, priv->ioaddr, false);
-	priv->eee_active = false;
-	stmmac_eee_init(priv);
+	stmmac_eee_init(priv, false);
 	stmmac_set_eee_pls(priv, priv->hw, false);
 
 	if (stmmac_fpe_supported(priv))
@@ -1083,8 +1085,7 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 		phy_eee_rx_clock_stop(phy, !(priv->plat->flags &
 					     STMMAC_FLAG_RX_CLK_RUNS_IN_LPI));
 		priv->tx_lpi_timer = phy->eee_cfg.tx_lpi_timer;
-		priv->eee_active = phy->enable_tx_lpi;
-		stmmac_eee_init(priv);
+		stmmac_eee_init(priv, phy->enable_tx_lpi);
 		stmmac_set_eee_pls(priv, priv->hw, true);
 	}
 
-- 
2.30.2


