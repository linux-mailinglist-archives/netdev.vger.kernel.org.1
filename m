Return-Path: <netdev+bounces-92009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D138B4C46
	for <lists+netdev@lfdr.de>; Sun, 28 Apr 2024 16:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84FE01F21109
	for <lists+netdev@lfdr.de>; Sun, 28 Apr 2024 14:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B124A6BFAA;
	Sun, 28 Apr 2024 14:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="X4x6PMMV"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C7257898
	for <netdev@vger.kernel.org>; Sun, 28 Apr 2024 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714315874; cv=none; b=KMW6z3xLJd/bz6FQRVEwBvRZh2iHhfXNZU+2tp1Tk+XMYcWvb9jK1cyelVWKdle08q2FVG1EpGKAgs9qZ05mVEhU2JaMHfzIeQBxSzDywqFyJ80zf7brmlL66QeC/6NBgAghkpNJeH7IkO817hYoF2PG02H3sk8r04D2Vtr86WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714315874; c=relaxed/simple;
	bh=8OH0s9wBtrDPxnaDieT+IoLVQz6+4BFifbcNbmXfN7k=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=BVCWSFoAbvTx42FdKE+8COoBsMRtAjfjCMj6WnQZK5xxE4QTXrJozLBT79j/a0RF8E/YmdXQCwHdZ0WRpF0EUngy4jAoG2wrOB+Qtl65Kagii/Pn/tGt/1Pz3H7VYVv+BsbmicYnrrX7/7RwuigRm7DwmlFkF+PsTsLT2HiGYs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=X4x6PMMV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VbTi1RyRVle57I2mLl3xMkCrNbSwVHEjBvyAp5fkD1A=; b=X4x6PMMVRYBWNPHAc17M/tM/HU
	uFgtd3KoXlNdpAa/xLGpPOJN0RX/QRUhM7L+9lIqZE6UbccLyWasES2wgGDjUa6yOVDH4iXcgEcgz
	uaDOmOOI3OifoKkMDsyZVQmOV9Auoshu/SEHZgd6vKlEP4D73Dog5LBO81TP8a1IhNBTCXXNd9eV5
	oJRmjMzrwMTB/Ked9WtBwD1W9mwggSefPyTClBIHC4Al356s6vuiRkdpXarJiaRlBa8R6xpAyePFJ
	uth+U+W0+f8zd9dMyozjyOU0aQ4VbgCzcDF3hMn5Zzhcx3gHJHpuq/4QvvStidJClopYN9JJJMOT/
	P4ymEpUQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:47954 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1s15rt-0002FZ-2S;
	Sun, 28 Apr 2024 15:51:05 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1s15rv-00AHyk-5S; Sun, 28 Apr 2024 15:51:07 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: sfp: allow use 2500base-X for 2500base-T
 modules
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1s15rv-00AHyk-5S@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 28 Apr 2024 15:51:07 +0100

Allow use of 2500base-X interface mode for PHY modules that support
2500base-T.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/sfp-bus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index 413021619afe..c6e3baf00f23 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -373,7 +373,8 @@ phy_interface_t sfp_select_interface(struct sfp_bus *bus,
 	if (phylink_test(link_modes, 5000baseT_Full))
 		return PHY_INTERFACE_MODE_5GBASER;
 
-	if (phylink_test(link_modes, 2500baseX_Full))
+	if (phylink_test(link_modes, 2500baseX_Full) ||
+	    phylink_test(link_modes, 2500baseT_Full))
 		return PHY_INTERFACE_MODE_2500BASEX;
 
 	if (phylink_test(link_modes, 1000baseT_Half) ||
-- 
2.30.2


