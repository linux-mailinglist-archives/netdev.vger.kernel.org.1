Return-Path: <netdev+bounces-50117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED2F7F4A4C
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C869CB20D97
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 15:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4D754BEF;
	Wed, 22 Nov 2023 15:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="nqtahHUu"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD900199
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 07:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6SoyPmAzWtf/jj0NvOcVAhPVs5teCEyli/+pQdeuoiI=; b=nqtahHUuySIYk2mlez/E0BqjTo
	T8q8w00fgZVDUMFybJj4hkrPKMrncoKGgEjE3g6lyXsr9S1lYLMdGfvikNvzD+HpygR0JGrvVhkDj
	Z8sM2vQXNOBMMLMMYYZufDEc+wOAuGQGmvI1HWxJY4ebto5Vb8tJYJliqLgBBizeHVAHbtbnmbMgq
	W0B3nCgxseaj1QMh7hwGVH9vzfHY1aqWFIgZ/5y3Sk7GS1/peueZ9ftk1A6QietxX1naNVy4k++Pu
	iCA4wJqofE+qOMOD0u4bzDFDtyO+c3ByBIreBd+Z4nNC/lKpSotLndnjFJL8n+bqJSmV4ds5qOQbE
	8CUrC83A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:57796 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r5pCo-0000MR-0E;
	Wed, 22 Nov 2023 15:31:58 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r5pCq-00DAHh-1u; Wed, 22 Nov 2023 15:32:00 +0000
In-Reply-To: <ZV4eolj9AI0b37y6@shell.armlinux.org.uk>
References: <ZV4eolj9AI0b37y6@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH RFC net-next 09/10] net: phylink: split out PHY validation
 from phylink_bringup_phy()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r5pCq-00DAHh-1u@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 22 Nov 2023 15:32:00 +0000

When bringing up a PHY, we need to work out which ethtool link modes it
should support and advertise. Clause 22 PHYs operate in a single
interface mode, which can be easily dealt with. However, clause 45 PHYs
tend to switch interface mode depending on the media. We need more
flexible validation at this point, so this patch splits out that code
in preparation to changing it.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 56 ++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index ac48a1db9979..39d85e47422e 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1760,6 +1760,35 @@ static void phylink_phy_change(struct phy_device *phydev, bool up)
 		    phylink_pause_to_str(pl->phy_state.pause));
 }
 
+static int phylink_validate_phy(struct phylink *pl, struct phy_device *phy,
+				unsigned long *supported,
+				struct phylink_link_state *state)
+{
+	/* Check whether we would use rate matching for the proposed interface
+	 * mode.
+	 */
+	state->rate_matching = phy_get_rate_matching(phy, state->interface);
+
+	/* Clause 45 PHYs may switch their Serdes lane between, e.g. 10GBASE-R,
+	 * 5GBASE-R, 2500BASE-X and SGMII if they are not using rate matching.
+	 * For some interface modes (e.g. RXAUI, XAUI and USXGMII) switching
+	 * their Serdes is either unnecessary or not reasonable.
+	 *
+	 * For these which switch interface modes, we really need to know which
+	 * interface modes the PHY supports to properly work out which ethtool
+	 * linkmodes can be supported. For now, as a work-around, we validate
+	 * against all interface modes, which may lead to more ethtool link
+	 * modes being advertised than are actually supported.
+	 */
+	if (phy->is_c45 && state->rate_matching == RATE_MATCH_NONE &&
+	    state->interface != PHY_INTERFACE_MODE_RXAUI &&
+	    state->interface != PHY_INTERFACE_MODE_XAUI &&
+	    state->interface != PHY_INTERFACE_MODE_USXGMII)
+		state->interface = PHY_INTERFACE_MODE_NA;
+
+	return phylink_validate(pl, supported, state);
+}
+
 static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 			       phy_interface_t interface)
 {
@@ -1780,32 +1809,9 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 	memset(&config, 0, sizeof(config));
 	linkmode_copy(supported, phy->supported);
 	linkmode_copy(config.advertising, phy->advertising);
+	config.interface = interface;
 
-	/* Check whether we would use rate matching for the proposed interface
-	 * mode.
-	 */
-	config.rate_matching = phy_get_rate_matching(phy, interface);
-
-	/* Clause 45 PHYs may switch their Serdes lane between, e.g. 10GBASE-R,
-	 * 5GBASE-R, 2500BASE-X and SGMII if they are not using rate matching.
-	 * For some interface modes (e.g. RXAUI, XAUI and USXGMII) switching
-	 * their Serdes is either unnecessary or not reasonable.
-	 *
-	 * For these which switch interface modes, we really need to know which
-	 * interface modes the PHY supports to properly work out which ethtool
-	 * linkmodes can be supported. For now, as a work-around, we validate
-	 * against all interface modes, which may lead to more ethtool link
-	 * modes being advertised than are actually supported.
-	 */
-	if (phy->is_c45 && config.rate_matching == RATE_MATCH_NONE &&
-	    interface != PHY_INTERFACE_MODE_RXAUI &&
-	    interface != PHY_INTERFACE_MODE_XAUI &&
-	    interface != PHY_INTERFACE_MODE_USXGMII)
-		config.interface = PHY_INTERFACE_MODE_NA;
-	else
-		config.interface = interface;
-
-	ret = phylink_validate(pl, supported, &config);
+	ret = phylink_validate_phy(pl, phy, supported, &config);
 	if (ret) {
 		phylink_warn(pl, "validation of %s with support %*pb and advertisement %*pb failed: %pe\n",
 			     phy_modes(config.interface),
-- 
2.30.2


