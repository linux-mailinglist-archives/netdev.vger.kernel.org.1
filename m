Return-Path: <netdev+bounces-225581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA77B95A5A
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED133BE089
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F55321F2F;
	Tue, 23 Sep 2025 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="L0r8APsq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24041145B3F
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626787; cv=none; b=aYMoJHyMqL0wkvHCbO2NM3lqDN3SjXs8fITrWi1byNHpzicHpbJ8uPPvNX6lsPE2JVNf6ufeJQsn9txXxyyfswieQWIfwESTUj3JadH2RcHOdU+gEIPExTnni2Q1676A99dvZ1AfJsOktfJJTozyhOs7uVbzVIcYRTWEaYeUjU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626787; c=relaxed/simple;
	bh=mM24kXtFNrQ8ju2yuGJeDWedves92ZSjiCObmGrNhEk=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=gwIv8yDT81NcSUowD0HYbOSFZN7sdXkmHSYiY8RakhDGOYB3LsPvbAC8gE7IMec2OoL13Cp2a6qgiNvS1cMmIDNwC5Hag3I5CjrRD6TUwuorLHzGMyMUzPH4XRtf/TQHeAB4hPqn5KYxDTq7Xpn4Pu7jDJYE5dcK8i4JgSwKDHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=L0r8APsq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uYEjz++G5/cXKTF/bymuRT79xSFx8FdTgAMO+/ffl/Y=; b=L0r8APsqmz+z9q7xkmussplrMc
	mXOOlpPVZggHS1aSgD084Z4e//32EoCM34aipprAJVS2to827lHGkWYAd36pDzuNezF/keFcNhVIw
	dlo8gIoTsJXu3HV9eZrXTeeK+1bPtElTjmNqUPbTND1EWS0KGQ+ri0bRuHxLFKT14QXtDCHyDSb/b
	EjQD4PIk6QbtJla108LPypVD5gbvajV+zUJdEearCvZbmLNF2WlJQapLMIRWynGlq8L3jtNfglw0b
	hRP0gtvCFJqkE5KME0GLHXhrck+gKR7vi3sJ0Cerh2M6Tlnze2vmDgWQ6zbF5Bzhu9T/qfoKMRgQm
	nXa/SASw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50760 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1v119z-0000000078v-2J1Z;
	Tue, 23 Sep 2025 12:26:15 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1v119y-0000000774A-2vvl;
	Tue, 23 Sep 2025 12:26:14 +0100
In-Reply-To: <aNKDqqI7aLsuDD52@shell.armlinux.org.uk>
References: <aNKDqqI7aLsuDD52@shell.armlinux.org.uk>
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
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 4/6] net: stmmac: move initialisation of
 priv->tx_lpi_timer to stmmac_open()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1v119y-0000000774A-2vvl@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 23 Sep 2025 12:26:14 +0100

The initialisation of priv->tx_lpi_timer only happens once during the
lifetime of the driver, which is during the initial administrative
open of the device. Move this initialisation out of __stmmac_open()
into stmmac_open().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 8831bbda964c..4acd180d2da8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3937,10 +3937,6 @@ static int __stmmac_open(struct net_device *dev,
 	u32 chan;
 	int ret;
 
-	/* Initialise the tx lpi timer, converting from msec to usec */
-	if (!priv->tx_lpi_timer)
-		priv->tx_lpi_timer = eee_timer * 1000;
-
 	ret = stmmac_init_phy(dev);
 	if (ret)
 		return ret;
@@ -4004,6 +4000,10 @@ static int stmmac_open(struct net_device *dev)
 	struct stmmac_dma_conf *dma_conf;
 	int ret;
 
+	/* Initialise the tx lpi timer, converting from msec to usec */
+	if (!priv->tx_lpi_timer)
+		priv->tx_lpi_timer = eee_timer * 1000;
+
 	dma_conf = stmmac_setup_dma_desc(priv, dev->mtu);
 	if (IS_ERR(dma_conf))
 		return PTR_ERR(dma_conf);
-- 
2.47.3


