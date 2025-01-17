Return-Path: <netdev+bounces-159192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4505A14B60
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 09:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF59168E6D
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 08:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0951F8ADF;
	Fri, 17 Jan 2025 08:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Z6wYYyWs"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16781F7909
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 08:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737103496; cv=none; b=oXaMsiCnzPCCAl1CfBIk12c9uf4IpgvzTha3dB5jp9FVJiiviq9cOSQJJGP+dEgG2BnDduNDsW21d+HIz3Y5vTsSPe62fBA61edsDkd52x4MBZCA6tsu8jBCsAolUrWo5NyAhXZ2c6ymOzCnO2DmtkoXfLQHY1FDiJrTFXpo1/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737103496; c=relaxed/simple;
	bh=Z484xkyxYcSI61TkuYQBBLEqgYBK50pl3CT1AB8Rgpg=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=rszZyENp3x+Tg0QItj2M/gbWznQZ2eOTfURJIC4VIVh8fS/PcWyM9kcnkLAsyaCjL5jBvga7pEwV/t+ko6FTBc99EZCHtD78/20Dy7KCddQz54480IvR7flq+0CTj7pE6slYfUqfq4IO9tAaXd8rIB8HnIJED3GFfmNgEjBjUVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Z6wYYyWs; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=i4Yfty4BlHVy0fxTNfin1Lk2Mqnf2dUlMcpNONE97cA=; b=Z6wYYyWsTJAJuacHl+hKqtMhOv
	cHQSRfxwDEIR7pi6k5juo7egzMbHrzOPga49FWMe39K/u9G8SHlYU1tOQNQjwsXTxfgxjZ604Ean3
	oQhbqPNj2GvkwdIaDWwo2lLXXDUao7k9aMfCopHFU+Aco/CZwSkMfqX/leYlUJebsY1nZl8oxBXRp
	CXMmkxp5o36H8Fo2scoQqEhGOILCfmdfMNTaA75QUHxWu7ms1pVMxCsFSgkVAhmEIheemwXFhea/r
	viJOhBkg+E06MyPDint0ux4mYrJNi9ju157peGhn8XQbpu6scjrXzVXW+zecYwF4o3i6kax919BWb
	LdKMgQYw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38704 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tYhy8-0003T5-0y;
	Fri, 17 Jan 2025 08:44:44 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tYhxp-001FHf-Ac; Fri, 17 Jan 2025 08:44:25 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: phylink: always do a major config when
 attaching a SFP PHY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tYhxp-001FHf-Ac@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 17 Jan 2025 08:44:25 +0000

Background: https://lore.kernel.org/r/20250107123615.161095-1-ericwouds@gmail.com

Since adding negotiation of in-band capabilities, it is no longer
sufficient to just look at the MLO_AN_xxx mode and PHY interface to
decide whether to do a major configuration, since the result now
depends on the capabilities of the attaching PHY.

Always trigger a major configuration in this case.

Testing log: https://lore.kernel.org/r/f20c9744-3953-40e7-a9c9-5534b25d2e2a@gmail.com

Reported-by: Eric Woudstra <ericwouds@gmail.com>
Tested-by: Eric Woudstra <ericwouds@gmail.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 66eea3f963d3..d130634d3bc7 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3541,12 +3541,11 @@ static phy_interface_t phylink_choose_sfp_interface(struct phylink *pl,
 	return interface;
 }
 
-static void phylink_sfp_set_config(struct phylink *pl,
-				   unsigned long *supported,
-				   struct phylink_link_state *state)
+static void phylink_sfp_set_config(struct phylink *pl, unsigned long *supported,
+				   struct phylink_link_state *state,
+				   bool changed)
 {
 	u8 mode = MLO_AN_INBAND;
-	bool changed = false;
 
 	phylink_dbg(pl, "requesting link mode %s/%s with support %*pb\n",
 		    phylink_an_mode_str(mode), phy_modes(state->interface),
@@ -3623,7 +3622,7 @@ static int phylink_sfp_config_phy(struct phylink *pl, struct phy_device *phy)
 
 	pl->link_port = pl->sfp_port;
 
-	phylink_sfp_set_config(pl, support, &config);
+	phylink_sfp_set_config(pl, support, &config, true);
 
 	return 0;
 }
@@ -3698,7 +3697,7 @@ static int phylink_sfp_config_optical(struct phylink *pl)
 
 	pl->link_port = pl->sfp_port;
 
-	phylink_sfp_set_config(pl, pl->sfp_support, &config);
+	phylink_sfp_set_config(pl, pl->sfp_support, &config, false);
 
 	return 0;
 }
-- 
2.30.2


