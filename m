Return-Path: <netdev+bounces-50827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22607F73CE
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 13:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 585EB281C95
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 12:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D312574A;
	Fri, 24 Nov 2023 12:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="z92+RBIp"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DDCD71
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 04:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KVasJ/WJpG6w2C84Mh10tZPoK1ZpBmdTFjjfJgavzlc=; b=z92+RBIpG9P6Bnsx5oMD4FhfbO
	FXcPwQe9elR7eRuyzm7GeSsoHNmAxRMJvQhkSPKmlAyFnLvZaWz7KhOExww3rOg8yChPEoVDmD2e3
	vLmeJUoghxXcX6HhjWViAbySYzJjnSbtQo8MyJ0ODu2bU5/hhALTAXLst/LqLOJMPQjPnn6ZA352T
	eabxGGNKiwCXec397ZXdlvK2LLBICzl2zx5ZR7WO23WE+gLwoAwDv7CyjhFrz2qT4k1ePV3RfDlOA
	T+XAB8AVV8J71BF6sEhVkOIJa7tcD0BhdE8LrpQOH0eZiiZoYC+bM6FU48/JRT+Nx1cq7+5Oiao68
	dmh0N9nw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:59310 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r6VIO-0002uC-1y;
	Fri, 24 Nov 2023 12:28:32 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r6VIQ-00DDM9-LK; Fri, 24 Nov 2023 12:28:34 +0000
In-Reply-To: <ZWCWn+uNkVLPaQhn@shell.armlinux.org.uk>
References: <ZWCWn+uNkVLPaQhn@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 09/10] net: phylink: split out PHY validation from
 phylink_bringup_phy()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r6VIQ-00DDM9-LK@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 24 Nov 2023 12:28:34 +0000

When bringing up a PHY, we need to work out which ethtool link modes it
should support and advertise. Clause 22 PHYs operate in a single
interface mode, which can be easily dealt with. However, clause 45 PHYs
tend to switch interface mode depending on the media. We need more
flexible validation at this point, so this patch splits out that code
in preparation to changing it.

Tested-by: Luo Jie <quic_luoj@quicinc.com>
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


