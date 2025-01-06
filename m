Return-Path: <netdev+bounces-155437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED3DA0254A
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10AF13A556E
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4731DA309;
	Mon,  6 Jan 2025 12:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Kfu98Vwp"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3009F1DC04A
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736166323; cv=none; b=d6wmJjwAOZ5Mi4O2tLzl5aaLM6IVXtPWNFsPQQUIBNevvbW12FZfeH7CONPk00GK0IvHEyXko3uclIngYAT01pRMlgFg2JV8T6N6p1J2FQotiT/aXPs59IHSfPOZsGp5NRZ8p9JUs/2zpXZnHPgSH41wq38EBP+4ahRyfH2nFqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736166323; c=relaxed/simple;
	bh=DFMQuuP4JSzwI5pplLgR8Oj+7FqfQhC2oA/222QATK8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=GQXA3nwKpSFwq/NGAo9+/EdrEgTQNE1qZYAQzc0knM9QZmJOQafOz4kOVyMHWRx2MXVHupSiROOAOz2Yu3hp9tE7waLPuT92PxvbG8/b6YnfRbzZdKZtM1t6NYYZfoH/RElK7WHNoBPA/sEB+VVTrbKEH9oqLyYuar9EwaS5dx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Kfu98Vwp; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tH1Du5lBcy6uX8uHJ7Q3PvQHP4R+mjatSNiKbMVdnuE=; b=Kfu98VwpJzV+QVjV93z/2G0qk2
	BgSHqYG39zQGv0FxXJnGRUhPY3WDn7HHna0P//ngegEDqDNfmiGWi7z0FAh9J+KwUSx22Qh8vdxfK
	kEF4yMvKtXZZQraU4sogxtx+ThgsrSOHEKAQQC2HK58paujkDbRadKFLLqMqJIE+TYih2l0WN/lc/
	wNpMyxwgIXjAxeY7mDn5dJS85i8d8Org+L5T7KIAsGhQFgD5DI7+BjOs4JEiBE0wHi2bjlzf1wVQ5
	GtgIPlhMTo3nX+oMsyDLnfQocsVBS8DSXf4cP0YUNzIBgu3dTyiVAkqhoXOUzJ7Hd3aih4h0bsnHa
	vhk71jWg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55606 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tUmAS-0005rN-0k;
	Mon, 06 Jan 2025 12:25:12 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tUmAP-007VX7-5s; Mon, 06 Jan 2025 12:25:09 +0000
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
Subject: [PATCH net-next v2 05/17] net: stmmac: remove redundant code from
 ethtool EEE ops
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tUmAP-007VX7-5s@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 06 Jan 2025 12:25:09 +0000

Setting edata->tx_lpi_enabled in stmmac_ethtool_op_get_eee() gets
overwritten by phylib, so there's no point setting this.

In stmmac_ethtool_op_set_eee(), now that stmmac is using the result of
phylib's evaluation of EEE, there is no need to handle anything in the
ethtool EEE ops other than calling through to the appropriate phylink
function, which will pass on to phylib the users request.

As stmmac_disable_eee_mode() is now no longer called from outside
stmmac_main.c, make it static.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h         | 1 -
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 9 ---------
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c    | 2 +-
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 984e708d019f..2eee3c5c4d1e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -405,7 +405,6 @@ void stmmac_dvr_remove(struct device *dev);
 int stmmac_dvr_probe(struct device *device,
 		     struct plat_stmmacenet_data *plat_dat,
 		     struct stmmac_resources *res);
-void stmmac_disable_eee_mode(struct stmmac_priv *priv);
 int stmmac_reinit_queues(struct net_device *dev, u32 rx_cnt, u32 tx_cnt);
 int stmmac_reinit_ringparam(struct net_device *dev, u32 rx_size, u32 tx_size);
 int stmmac_bus_clks_config(struct stmmac_priv *priv, bool enabled);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 0429a99a8114..693f59c3c47a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -898,8 +898,6 @@ static int stmmac_ethtool_op_get_eee(struct net_device *dev,
 	if (!priv->dma_cap.eee)
 		return -EOPNOTSUPP;
 
-	edata->tx_lpi_enabled = priv->tx_lpi_enabled;
-
 	return phylink_ethtool_get_eee(priv->phylink, edata);
 }
 
@@ -911,13 +909,6 @@ static int stmmac_ethtool_op_set_eee(struct net_device *dev,
 	if (!priv->dma_cap.eee)
 		return -EOPNOTSUPP;
 
-	if (priv->tx_lpi_enabled != edata->tx_lpi_enabled)
-		netdev_warn(priv->dev,
-			    "Setting EEE tx-lpi is not supported\n");
-
-	if (!edata->eee_enabled)
-		stmmac_disable_eee_mode(priv);
-
 	return phylink_ethtool_set_eee(priv->phylink, edata);
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index dbee2de08583..f895bdd75678 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -434,7 +434,7 @@ static int stmmac_enable_eee_mode(struct stmmac_priv *priv)
  * Description: this function is to exit and disable EEE in case of
  * LPI state is true. This is called by the xmit.
  */
-void stmmac_disable_eee_mode(struct stmmac_priv *priv)
+static void stmmac_disable_eee_mode(struct stmmac_priv *priv)
 {
 	if (!priv->eee_sw_timer_en) {
 		stmmac_lpi_entry_timer_config(priv, 0);
-- 
2.30.2


