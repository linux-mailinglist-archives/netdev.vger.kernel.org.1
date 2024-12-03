Return-Path: <netdev+bounces-148577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 557309E2372
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 16:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3A416790A
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A6B1F76B7;
	Tue,  3 Dec 2024 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zwBSZ2JD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1681F75B3
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239910; cv=none; b=SlgaAtydHsNL18EF7xFAIFH3fJHKdPCKFFQ2HAS9iooHChk6j0B76bpJM4fr+VxCF4tun/rx3XvDcazv+HMR6uwMphQt18MwcejPVRzaTjeFnu7v15O1o1wUHo5KhBCBOps0LUgDBhhWJqgZLBmgPUAFIhvJlvljtOJFeyVFVrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239910; c=relaxed/simple;
	bh=wa/QUkknYDZ1lqh3h5zfoCJ3rZhJbIFz5iXwRAptjf4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=lnYF92o2ZDkgWR6J/BVCr+m02paYxj5Q2189qrzN8pDJBQtZKJt/RSlGAu2zX6ijr/X+H+MAdznRTJsol1TEroSD0xZTB08nMcgiZZHR2bOwRT2tE904ewFSHgCAO2m7pMrLfHOtd1oEZlmFAdyEmztQ22ItdSEZsIfBdanCKDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zwBSZ2JD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WwO8LzIPuaK3cG3nJS/R99LC8SW/aCfhUEaOtDfuXoc=; b=zwBSZ2JD52c674rA/DmrfDAndc
	6rzH7lq2xEtwiGznXCbtJVFaMTrxMGIE4urE/hutvMbFiIOSID4hW8brqv4iX+PlvW0Z/59dLN4ZI
	n2PsFEa3zoNSPO76sGnd0wUhE8t0CIG6Xfz0wA9YxF10m1ezcSIXLIVmXxnKQbuK1i/dNLj91asxA
	MgxGtRc7NiPkuEt8W26EL+WtAAzCnt+C7Y0LWsAjqFYB+YHvHIuzjjtyYzO4qyJlSHOMBLhJC4JYW
	j3v5C229HawxpdVdJrdwG4XS9OKxwgZ9sr6V34tISyjqqzkxsmJkcx+tksCTwPV0Ida20ffvDyXII
	l5qe9s5Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44310 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tIUsK-00029p-1t;
	Tue, 03 Dec 2024 15:31:45 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tIUsJ-006IUn-H3; Tue, 03 Dec 2024 15:31:43 +0000
In-Reply-To: <Z08kCwxdkU4n2V6x@shell.armlinux.org.uk>
References: <Z08kCwxdkU4n2V6x@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 12/13] net: phylink: add negotiation of in-band
 capabilities
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tIUsJ-006IUn-H3@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 03 Dec 2024 15:31:43 +0000

Support for in-band signalling with Serdes links is uncertain. Some
PHYs do not support in-band for e.g. SGMII. Some PCS do not support
in-band for 2500Base-X. Some PCS require in-band for Base-X protocols.

Simply using what is in DT is insufficient when we have hot-pluggable
PHYs e.g. in the form of SFP modules, which may not provide the
in-band signalling.

In order to address this, we have introduced phy_inband_caps() and
pcs_inband_caps() functions to allow phylink to retrieve the
capabilities from each end of the PCS/PHY link. This commit adds code
to resolve whether in-band will be used in the various scenarios that
we have: In-band not being used, PHY present using SGMII or Base-X,
PHY not present. We also deal with no capabilties provided.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 154 +++++++++++++++++++++++++++++++++++---
 1 file changed, 144 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 42f3c7ccbf38..b0881fa9c72e 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -75,6 +75,7 @@ struct phylink {
 
 	struct mutex state_mutex;
 	struct phylink_link_state phy_state;
+	unsigned int phy_ib_mode;
 	struct work_struct resolve;
 	unsigned int pcs_neg_mode;
 	unsigned int pcs_state;
@@ -1153,10 +1154,18 @@ static void phylink_pcs_neg_mode(struct phylink *pl, struct phylink_pcs *pcs,
 				 phy_interface_t interface,
 				 const unsigned long *advertising)
 {
+	unsigned int pcs_ib_caps = 0;
+	unsigned int phy_ib_caps = 0;
 	unsigned int neg_mode, mode;
+	enum {
+		INBAND_CISCO_SGMII,
+		INBAND_BASEX,
+	} type;
 
 	mode = pl->req_link_an_mode;
 
+	pl->phy_ib_mode = 0;
+
 	switch (interface) {
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_QSGMII:
@@ -1168,10 +1177,7 @@ static void phylink_pcs_neg_mode(struct phylink *pl, struct phylink_pcs *pcs,
 		 * inband communication. Note: there exist PHYs that run
 		 * with SGMII but do not send the inband data.
 		 */
-		if (!phylink_autoneg_inband(mode))
-			neg_mode = PHYLINK_PCS_NEG_OUTBAND;
-		else
-			neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
+		type = INBAND_CISCO_SGMII;
 		break;
 
 	case PHY_INTERFACE_MODE_1000BASEX:
@@ -1182,18 +1188,139 @@ static void phylink_pcs_neg_mode(struct phylink *pl, struct phylink_pcs *pcs,
 		 * as well, but drivers may not support this, so may
 		 * need to override this.
 		 */
-		if (!phylink_autoneg_inband(mode))
+		type = INBAND_BASEX;
+		break;
+
+	default:
+		pl->pcs_neg_mode = PHYLINK_PCS_NEG_NONE;
+		pl->act_link_an_mode = mode;
+		return;
+	}
+
+	if (pcs)
+		pcs_ib_caps = phylink_pcs_inband_caps(pcs, interface);
+
+	if (pl->phydev)
+		phy_ib_caps = phy_inband_caps(pl->phydev, interface);
+
+	phylink_dbg(pl, "interface %s inband modes: pcs=%02x phy=%02x\n",
+		    phy_modes(interface), pcs_ib_caps, phy_ib_caps);
+
+	if (!phylink_autoneg_inband(mode)) {
+		bool pcs_ib_only = false;
+		bool phy_ib_only = false;
+
+		if (pcs_ib_caps && pcs_ib_caps != LINK_INBAND_DISABLE) {
+			/* PCS supports reporting in-band capabilities, and
+			 * supports more than disable mode.
+			 */
+			if (pcs_ib_caps & LINK_INBAND_DISABLE)
+				neg_mode = PHYLINK_PCS_NEG_OUTBAND;
+			else if (pcs_ib_caps & LINK_INBAND_ENABLE)
+				pcs_ib_only = true;
+		}
+
+		if (phy_ib_caps && phy_ib_caps != LINK_INBAND_DISABLE) {
+			/* PHY supports in-band capabilities, and supports
+			 * more than disable mode.
+			 */
+			if (phy_ib_caps & LINK_INBAND_DISABLE)
+				pl->phy_ib_mode = LINK_INBAND_DISABLE;
+			else if (phy_ib_caps & LINK_INBAND_BYPASS)
+				pl->phy_ib_mode = LINK_INBAND_BYPASS;
+			else if (phy_ib_caps & LINK_INBAND_ENABLE)
+				phy_ib_only = true;
+		}
+
+		/* If either the PCS or PHY requires inband to be enabled,
+		 * this is an invalid configuration. Provide a diagnostic
+		 * message for this case, but don't try to force the issue.
+		 */
+		if (pcs_ib_only || phy_ib_only)
+			phylink_warn(pl,
+				     "firmware wants %s mode, but %s%s%s requires inband\n",
+				     phylink_an_mode_str(mode),
+				     pcs_ib_only ? "PCS" : "",
+				     pcs_ib_only && phy_ib_only ? " and " : "",
+				     phy_ib_only ? "PHY" : "");
+
+		neg_mode = PHYLINK_PCS_NEG_OUTBAND;
+	} else if (type == INBAND_CISCO_SGMII || pl->phydev) {
+		/* For SGMII modes which are designed to be used with PHYs, or
+		 * Base-X with a PHY, we try to use in-band mode where-ever
+		 * possible. However, there are some PHYs e.g. BCM84881 which
+		 * do not support in-band.
+		 */
+		const unsigned int inband_ok = LINK_INBAND_ENABLE |
+					       LINK_INBAND_BYPASS;
+		const unsigned int outband_ok = LINK_INBAND_DISABLE |
+						LINK_INBAND_BYPASS;
+		/* PCS	PHY
+		 * D E	D E
+		 * 0 0  0 0	no information			inband enabled
+		 * 1 0  0 0	pcs doesn't support		outband
+		 * 0 1  0 0	pcs required			inband enabled
+		 * 1 1  0 0	pcs optional			inband enabled
+		 * 0 0  1 0	phy doesn't support		outband
+		 * 1 0  1 0	pcs+phy doesn't support		outband
+		 * 0 1  1 0	pcs required, phy doesn't support, invalid
+		 * 1 1  1 0	pcs optional, phy doesn't support, outband
+		 * 0 0  0 1	phy required			inband enabled
+		 * 1 0  0 1	pcs doesn't support, phy required, invalid
+		 * 0 1  0 1	pcs+phy required		inband enabled
+		 * 1 1  0 1	pcs optional, phy required	inband enabled
+		 * 0 0  1 1	phy optional			inband enabled
+		 * 1 0  1 1	pcs doesn't support, phy optional, outband
+		 * 0 1  1 1	pcs required, phy optional	inband enabled
+		 * 1 1  1 1	pcs+phy optional		inband enabled
+		 */
+		if ((!pcs_ib_caps || pcs_ib_caps & inband_ok) &&
+		    (!phy_ib_caps || phy_ib_caps & inband_ok)) {
+			/* In-band supported or unknown at both ends. Enable
+			 * in-band mode with or without bypass at the PHY.
+			 */
+			if (phy_ib_caps & LINK_INBAND_ENABLE)
+				pl->phy_ib_mode = LINK_INBAND_ENABLE;
+			else if (phy_ib_caps & LINK_INBAND_BYPASS)
+				pl->phy_ib_mode = LINK_INBAND_BYPASS;
+
+			neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
+		} else if ((!pcs_ib_caps || pcs_ib_caps & outband_ok) &&
+			   (!phy_ib_caps || phy_ib_caps & outband_ok)) {
+			/* Either in-band not supported at at least one end.
+			 * In-band bypass at the other end is possible.
+			 */
+			if (phy_ib_caps & LINK_INBAND_DISABLE)
+				pl->phy_ib_mode = LINK_INBAND_DISABLE;
+			else if (phy_ib_caps & LINK_INBAND_BYPASS)
+				pl->phy_ib_mode = LINK_INBAND_BYPASS;
+
 			neg_mode = PHYLINK_PCS_NEG_OUTBAND;
+			if (pl->phydev)
+				mode = MLO_AN_PHY;
+		} else {
+			/* invalid */
+			phylink_warn(pl, "%s: incompatible in-band capabilities, trying in-band",
+				     phy_modes(interface));
+			neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
+		}
+	} else {
+		/* For Base-X without a PHY */
+		if (pcs_ib_caps == LINK_INBAND_DISABLE)
+			/* If the PCS doesn't support inband, then inband must
+			 * be disabled.
+			 */
+			neg_mode = PHYLINK_PCS_NEG_INBAND_DISABLED;
+		else if (pcs_ib_caps == LINK_INBAND_ENABLE)
+			/* If the PCS requires inband, then inband must always
+			 * be enabled.
+			 */
+			neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
 		else if (linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
 					   advertising))
 			neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
 		else
 			neg_mode = PHYLINK_PCS_NEG_INBAND_DISABLED;
-		break;
-
-	default:
-		neg_mode = PHYLINK_PCS_NEG_NONE;
-		break;
 	}
 
 	pl->pcs_neg_mode = neg_mode;
@@ -1292,6 +1419,13 @@ static void phylink_major_config(struct phylink *pl, bool restart,
 				    ERR_PTR(err));
 	}
 
+	if (pl->phydev && pl->phy_ib_mode) {
+		err = phy_config_inband(pl->phydev, pl->phy_ib_mode);
+		if (err < 0)
+			phylink_err(pl, "phy_config_inband: %pe\n",
+				    ERR_PTR(err));
+	}
+
 	if (pl->sfp_bus) {
 		rate_kbd = phylink_interface_signal_rate(state->interface);
 		if (rate_kbd)
-- 
2.30.2


