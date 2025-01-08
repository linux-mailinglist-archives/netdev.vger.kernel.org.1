Return-Path: <netdev+bounces-156365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03A7A062A4
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8515E167831
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA681FF61A;
	Wed,  8 Jan 2025 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ba7qrwnE"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F7E17E900
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354961; cv=none; b=aOllzI6DDJfAB0/Cg9WhfaAr0efTxmud9JQPifB1JmnGMynLLFR3eb8BXgAb0OtadJ89M1sTqdloC1cf1EUnxwO5SeaqRST4+Az4mm8Og3pSBR+ACDhPqcnrP6qtZtoquVhW6IW38ZVz8KhamcTUJgs/DyB45NyA0YWOzqtdIHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354961; c=relaxed/simple;
	bh=6XLpcsA9M2bwt44/DXUUOi5WcMJEL4SKHg/DGuc8gls=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=fiRCDyX1QPLj68a1e0SSYv2Y3RSzF6jjpaTP/Az8AOlh3kBSTICO9nhpIlrsRYXefZ/e8Ne6L6+C2vcjEqiet/VBbHggcCXHYrlGtBy9CntQINAGc0GfTi0+2A10q9STD7gebvYpKdsmiKq1XIYZcIPTuQWbljNuPZGwEA70g9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ba7qrwnE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EoFHmxuk+u6QTKDz08iGDhs9TdaD1EKsFjfn3QavAxs=; b=ba7qrwnEMrA/fpU8LCklFzltLw
	jM44/Vngd536ICJY0BoRrJNE+JVvUqmMRYGpVsP2x1/h/QspWpsFLWPIB/PVEHzDqdw8bbV06yJFe
	3e6rH5kG7oezzcebWx24FhqBWE9UIyz42RsgvQG8bXKKGJgiOXUUj8kIHG6afIQgj7+Yh1Lf5Gm2H
	PVrv+nhh7DqzcgGdV2s44TlE/0agwF8XQG/PgQTS1tSiNbrfGaTiOpBIWpdPV0mLn2XHz37CL9/yf
	7mpNup4mP++YY2Cpq2vaGsFgTy5/clWyL3t7GbXDvWhaeFr2VrnbJOLBk0VKDDigKKmzIoysLtA7n
	nzcQM90A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59562 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tVZF0-0000yc-0u;
	Wed, 08 Jan 2025 16:49:10 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tVZEg-0002LE-HH; Wed, 08 Jan 2025 16:48:50 +0000
In-Reply-To: <Z36sHIlnExQBuFJE@shell.armlinux.org.uk>
References: <Z36sHIlnExQBuFJE@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v4 16/18] net: stmmac: remove unnecessary EEE
 handling in stmmac_release()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tVZEg-0002LE-HH@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 08 Jan 2025 16:48:50 +0000

phylink_stop() will cause phylink to call the mac_link_down() operation
before phylink_stop() returns. As mac_link_down() will call
stmmac_eee_init(false), this will set both priv->eee_active and
priv->eee_enabled to be false, deleting the eee_ctrl_timer if
priv->eee_enabled was previously set.

As stmmac_release() calls phylink_stop() before checking whether
priv->eee_enabled is true, this is a condition that can never be
satisfied, and thus the code within this if() block will never be
executed. Remove it.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 57338794695c..6d01dcafaf15 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4033,11 +4033,6 @@ static int stmmac_release(struct net_device *dev)
 	/* Free the IRQ lines */
 	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
 
-	if (priv->eee_enabled) {
-		priv->tx_path_in_lpi_mode = false;
-		del_timer_sync(&priv->eee_ctrl_timer);
-	}
-
 	/* Stop TX/RX DMA and clear the descriptors */
 	stmmac_stop_all_dma(priv);
 
-- 
2.30.2


