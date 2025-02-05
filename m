Return-Path: <netdev+bounces-163012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022B0A28C0A
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 14:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854FC3A88A2
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C648613D26B;
	Wed,  5 Feb 2025 13:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MES8Zqi5"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B0813B298
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738762832; cv=none; b=FIm1CxMwrP1NQXlbpiVzJCvWKU6arU9aLaTAw1IMhEbcxAoe1xaB55SFA5OdC1dOQMzaHAgXf1dlLjI2vNCbJj4XgtJpSzr4C6Lf+MvkpTI42WK+YTz4yeKD1xrJkxQQU1gPsYVybKOiP3pWYhL1zGKDBTSEEUT5SIfnDcn63zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738762832; c=relaxed/simple;
	bh=hXpB16N6K/1lg6BvTSjfVvPl0FdTJ/cxds1tXi8qxNo=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=W5FEHcJ14BLp9kzlXaz340Uk7SDkDxapcuQD3b0yo3kNljGD23sPkOXDmq5eFAmf00Gh6NWekgSRo0Fvg6/PG3ksZ13skGbQwsjY6Pt+gu0PizeSkx68pp+zJuLogIXGf0yg8Bym3c6ayJE2dg1K/Ga3kXp4itkyxmot/459ltw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MES8Zqi5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ilRCh6+tBajH2EHe/j7VXA163CYcQs54iiHX9cjVYLY=; b=MES8Zqi5z2HKfEJWWHPTdMDsx4
	mGKWiRq+No2Gr8dpLRFR3NWGSiUmZQn/RH9uusChGv0viuEw/XsVX68cL/WjQm5iOrsCoImVY1G1W
	mZPpKVMTb5LLYmlG/4SRqdklsllXVBvGttuPleA1XkenH3eiXd6nCXgRhBnc1GZpCsubBbDSOPixT
	MXjhPlT8QL8GixIyqb4TB+rlTpgAgmvDuJv6+zKF6nR+nz2OI7E6HFOmsVm1byZYcesX7hC2e6XAO
	bD/9ipXL6V/jS1tYrDmCwznXz+Fc+XShEixCRQzVD2qkHtmMas+EvHbS2epdcRPEpt7i3lZ5xuH3H
	t9kEk7Zw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50866 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tffdh-0007At-14;
	Wed, 05 Feb 2025 13:40:25 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tffdN-003ZHt-Mq; Wed, 05 Feb 2025 13:40:05 +0000
In-Reply-To: <Z6NqGnM2yL7Ayo-T@shell.armlinux.org.uk>
References: <Z6NqGnM2yL7Ayo-T@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 05/14] net: stmmac: remove priv->dma_cap.eee test in
 tx_lpi methods
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tffdN-003ZHt-Mq@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 05 Feb 2025 13:40:05 +0000

The tests for priv->dma_cap.eee in stmmac_mac_{en,dis}able_tx_lpi()
is useless as these methods will only be called when using phylink
managed EEE, and that will only be enabled if the LPI capabilities
in phylink_config have been populated during initialisation. This
only occurs when priv->dma_cap.eee was true.

As priv->dma_cap.eee remains constant during the lifetime of the driver
instance, there is no need to re-check it in these methods.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 8f2624de592d..ce527d4ae11f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1044,12 +1044,6 @@ static void stmmac_mac_disable_tx_lpi(struct phylink_config *config)
 
 	priv->eee_active = false;
 
-	/* Check if MAC core supports the EEE feature. */
-	if (!priv->dma_cap.eee) {
-		priv->eee_enabled = false;
-		return;
-	}
-
 	mutex_lock(&priv->lock);
 
 	/* Check if it needs to be deactivated */
@@ -1079,12 +1073,6 @@ static int stmmac_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
 	priv->tx_lpi_timer = timer;
 	priv->eee_active = true;
 
-	/* Check if MAC core supports the EEE feature. */
-	if (!priv->dma_cap.eee) {
-		priv->eee_enabled = false;
-		return 0;
-	}
-
 	mutex_lock(&priv->lock);
 
 	if (priv->eee_active && !priv->eee_enabled) {
-- 
2.30.2


