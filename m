Return-Path: <netdev+bounces-150644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B28599EB0FE
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 13:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D38616A359
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 12:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16441A76CB;
	Tue, 10 Dec 2024 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZeN111Ek"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8DF1A4F09
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 12:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733834318; cv=none; b=R8m0qEfO8RD5lxFHPIlRIGfNF330jeGryE/y4k0ALCHVBtVy3DsXUo7HOyGzbk8iVagkvQZhbSe4FUVtAofHA1Pg+kPGlSRay5i+Z7IifBHOOysoHs4ms/i7BEEJDTcvBvLmd+eyTchkYoPS32sfRS26x+hJSXnpN9AMKmhg5rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733834318; c=relaxed/simple;
	bh=Uuz811M0/qDsLOzgHRs8omjHnPq8hQuLqzFbZQ14Pck=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=SrEP3jSkeXvw/mPI1MiPx2vkN/IxVApKM9DJOzwUbL4mVYhkRO20jq3VU7oR/z/oHxEK4F+zm2Yr66A2kWHjJrT05qUARgqmLWCyW1WeB+kysc6q8TxQPaIAItllZ0/n0l+3LQQQPE0t+bEEAFitKIsYF0f9UikoqCq3cA53co8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ZeN111Ek; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=F8APTLvIZ5T5NZkTRbLqEB+7gpe8x238BTmGpTJt3oo=; b=ZeN111Ek1fBCI2X1oXYlS/vu0U
	QGmr0Y5mn1IlhWBQ2MyLCgH/yoAbmbl1T5io4+sXIptEDoSsNvdJCKKSiJ5sUvAm38uIIT7iHujn3
	qoZtPclF88Qy/mhcJ4rdSE0sU/GZlAxTXPjlGFl5xH49m5ReTpa9zx8HiHKWfSmDvbrO4YLORcqX5
	mD6QEUTW0uNMyIEYzJtjd9Qdwh6r0gLEMnDYQyu+DPDfRWUkUsMGg8QZPC39xdRjbvXno/dvYy3tH
	nVr187kuRmxJmVPiH7n3d/EmwvIayBqgK8O5HduBFXyq8WJ9VBlLMMjD5sOSQCqhKIQAho5lagXlT
	YZ6P9btg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41454 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tKzVT-0002Ix-39;
	Tue, 10 Dec 2024 12:38:28 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tKzVS-006c67-IJ; Tue, 10 Dec 2024 12:38:26 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: fec: use phydev->eee_cfg.tx_lpi_timer
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tKzVS-006c67-IJ@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 10 Dec 2024 12:38:26 +0000

Rather than maintaining a private copy of the LPI timer, make use of
the LPI timer maintained by phylib. In any case, phylib overwrites the
value of tx_lpi_timer set by the driver in phy_ethtool_get_eee().

Note that feb->eee.tx_lpi_timer is initialised to zero, which is just
the same with phylib's copy, so there should be no functional change.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/freescale/fec.h      |  2 --
 drivers/net/ethernet/freescale/fec_main.c | 16 ++++++----------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 1cca0425d493..c81f2ea588f2 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -671,8 +671,6 @@ struct fec_enet_private {
 	unsigned int tx_time_itr;
 	unsigned int itr_clk_rate;
 
-	/* tx lpi eee mode */
-	struct ethtool_keee eee;
 	unsigned int clk_ref_rate;
 
 	/* ptp clock period in ns*/
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 1b55047c0237..b2daed55bf6c 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -2045,14 +2045,14 @@ static int fec_enet_us_to_tx_cycle(struct net_device *ndev, int us)
 	return us * (fep->clk_ref_rate / 1000) / 1000;
 }
 
-static int fec_enet_eee_mode_set(struct net_device *ndev, bool enable)
+static int fec_enet_eee_mode_set(struct net_device *ndev, u32 lpi_timer,
+				 bool enable)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct ethtool_keee *p = &fep->eee;
 	unsigned int sleep_cycle, wake_cycle;
 
 	if (enable) {
-		sleep_cycle = fec_enet_us_to_tx_cycle(ndev, p->tx_lpi_timer);
+		sleep_cycle = fec_enet_us_to_tx_cycle(ndev, lpi_timer);
 		wake_cycle = sleep_cycle;
 	} else {
 		sleep_cycle = 0;
@@ -2105,7 +2105,9 @@ static void fec_enet_adjust_link(struct net_device *ndev)
 			napi_enable(&fep->napi);
 		}
 		if (fep->quirks & FEC_QUIRK_HAS_EEE)
-			fec_enet_eee_mode_set(ndev, phy_dev->enable_tx_lpi);
+			fec_enet_eee_mode_set(ndev,
+					      phy_dev->eee_cfg.tx_lpi_timer,
+					      phy_dev->enable_tx_lpi);
 	} else {
 		if (fep->link) {
 			netif_stop_queue(ndev);
@@ -3181,7 +3183,6 @@ static int
 fec_enet_get_eee(struct net_device *ndev, struct ethtool_keee *edata)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct ethtool_keee *p = &fep->eee;
 
 	if (!(fep->quirks & FEC_QUIRK_HAS_EEE))
 		return -EOPNOTSUPP;
@@ -3189,8 +3190,6 @@ fec_enet_get_eee(struct net_device *ndev, struct ethtool_keee *edata)
 	if (!netif_running(ndev))
 		return -ENETDOWN;
 
-	edata->tx_lpi_timer = p->tx_lpi_timer;
-
 	return phy_ethtool_get_eee(ndev->phydev, edata);
 }
 
@@ -3198,7 +3197,6 @@ static int
 fec_enet_set_eee(struct net_device *ndev, struct ethtool_keee *edata)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	struct ethtool_keee *p = &fep->eee;
 
 	if (!(fep->quirks & FEC_QUIRK_HAS_EEE))
 		return -EOPNOTSUPP;
@@ -3206,8 +3204,6 @@ fec_enet_set_eee(struct net_device *ndev, struct ethtool_keee *edata)
 	if (!netif_running(ndev))
 		return -ENETDOWN;
 
-	p->tx_lpi_timer = edata->tx_lpi_timer;
-
 	return phy_ethtool_set_eee(ndev->phydev, edata);
 }
 
-- 
2.30.2


