Return-Path: <netdev+bounces-171601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1A7A4DC69
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 12:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1EA178643
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 11:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D2A1FECBA;
	Tue,  4 Mar 2025 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SkAybfOk"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F451FCCF7
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087316; cv=none; b=CKLFi773Wpj65mOg/ux2fTLv5RoBdnXVN7ldtN/CHhq1IQJXJfqpG3d6AHD3xXZbCyBAlHCWPFePkkxOxp7iRDz2sOer/KBMHHTkzMln43I0SBJKWX1hAeHcpglZF+ZaaT2UHYEFeo3BgrkaubLbSI7p7aPqPgYyqJ0YyKlVPPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087316; c=relaxed/simple;
	bh=cN8fYwsoL2uEV6YHLGlVTke6/XDbYTD3g7U/AOyN1gU=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=QfSm54uG7ZcpswiIvVINrg+EVBbiqTCFebdziGzhPmSUJ7XMvKs/RIT7T/cw7HAirX6bBRp9kDI/ps3IUjl897Btu1SELOQoqmBadzTFw+7LlLX8MAMu3UuWk8AeXO2h70ou9fk6Gm9rZ1b83LBEn4wdUsNa0vgwNDlYjwbuCCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SkAybfOk; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dbjvadws0kRCNhxtI35nxdB/KtxozDHnbrbbu+M7kRA=; b=SkAybfOkr4oApk1guBPlQyrxVd
	HSuqX+0VFCNYPELvpBdZsDqVSw0tKAo8HkCGDMDkl7wPXXtb8Vscvz4At7CAS9ro7HsPrhTlEhWB7
	nNHlhafnMosLEA/pBOcjd6ngzyjiQUlFLP0Dpb1a90XFo7gVsCD7K3RJy5RazFT8JuKjpps7t4v6L
	u0+RaesHR4UmshqkRfEVW8c350bxz88rWMFi+99db9QN+UZv8FXPLFD/LaEyWf8KF1tx3Z4n2GBXO
	K6KkqATP+Gt5XrABSGgdGp+2fE3KVvFjCkPUREXhnEckO3sDebUzWoaTNWtujBmh7/e0WOEFLWqpd
	C7QYLKDg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42422 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tpQLL-0002YY-1v;
	Tue, 04 Mar 2025 11:21:47 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tpQL1-005St4-Hn; Tue, 04 Mar 2025 11:21:27 +0000
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
Subject: [PATCH net-next] net: stmmac: simplify phylink_suspend() and
 phylink_resume() calls
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tpQL1-005St4-Hn@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 04 Mar 2025 11:21:27 +0000

Currently, the calls to phylink's suspend and resume functions are
inside overly complex tests, and boil down to:

	if (device_may_wakeup(priv->device) && priv->plat->pmt) {
		call phylink
	} else {
		call phylink and
		if (device_may_wakeup(priv->device))
			do something else
	}

This results in phylink always being called, possibly with differing
arguments for phylink_suspend().

Simplify this code, noting that each site is slightly different due to
the order in which phylink is called and the "something else".

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 22 +++++++------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index aec230353ac4..fbcba6c71f12 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7831,13 +7831,11 @@ int stmmac_suspend(struct device *dev)
 	mutex_unlock(&priv->lock);
 
 	rtnl_lock();
-	if (device_may_wakeup(priv->device) && priv->plat->pmt) {
-		phylink_suspend(priv->phylink, true);
-	} else {
-		if (device_may_wakeup(priv->device))
-			phylink_speed_down(priv->phylink, false);
-		phylink_suspend(priv->phylink, false);
-	}
+	if (device_may_wakeup(priv->device) && !priv->plat->pmt)
+		phylink_speed_down(priv->phylink, false);
+
+	phylink_suspend(priv->phylink,
+			device_may_wakeup(priv->device) && priv->plat->pmt);
 	rtnl_unlock();
 
 	if (stmmac_fpe_supported(priv))
@@ -7927,13 +7925,9 @@ int stmmac_resume(struct device *dev)
 	}
 
 	rtnl_lock();
-	if (device_may_wakeup(priv->device) && priv->plat->pmt) {
-		phylink_resume(priv->phylink);
-	} else {
-		phylink_resume(priv->phylink);
-		if (device_may_wakeup(priv->device))
-			phylink_speed_up(priv->phylink);
-	}
+	phylink_resume(priv->phylink);
+	if (device_may_wakeup(priv->device) && !priv->plat->pmt)
+		phylink_speed_up(priv->phylink);
 	rtnl_unlock();
 
 	rtnl_lock();
-- 
2.30.2


