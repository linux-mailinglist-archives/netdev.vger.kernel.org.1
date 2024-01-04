Return-Path: <netdev+bounces-61467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C31823EE5
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 10:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC10E287646
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 09:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4A720B0D;
	Thu,  4 Jan 2024 09:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wcbXJYtO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EC420B00
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ojq5x5LJ3RUshz6W3EcxhcMmPWB9jEfCGI5sO2Xe+Y0=; b=wcbXJYtOg8UZ7+FEuX9MttBMtQ
	vXWQ5SXK6JDMA0C/cDkE4Ytc5VbT4/PNADtw9Wp1fzl7wOdINUwB630odeY6NjKo1pkVs/KTznl3h
	FJZousKpM8+cThPrRzNCmmeOg9TughKtsvzUNhrQk2ZP+2e8GRiOzoKlYKqOfGc9btUKOUoASKEv1
	3xumDsU+tp2YMt7cHjB9FNpGhrU4ScKcZ3TAQrw+9v4IcbTyeCpspj4CSHji3tCGphOXS1U1HVcxX
	i6Isk0W34P+9wYc6iONO3I7vtkS9yaNvaL67ziNIL7wHeEDk4HjZozCrFadjeqMrpUiL+avhCD7Pd
	YBe7F3vw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45882 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rLKK5-0008K5-3A;
	Thu, 04 Jan 2024 09:47:34 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rLKK8-00EtVI-MV; Thu, 04 Jan 2024 09:47:36 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2] net: phylink: move phylink_pcs_neg_mode() into
 phylink.c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rLKK8-00EtVI-MV@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 04 Jan 2024 09:47:36 +0000

Move phylink_pcs_neg_mode() from the header file into the .c file since
nothing should be using it.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
While it is true that there have been no users of this outside phylink.c
since shortly after it was merged, leaving it in phylink.h provides a
way to migrate code in e.g. OpenWRT. Since 6.6 was a LTS, let's now move
the function for 6.8.
---
 drivers/net/phy/phylink.c | 66 +++++++++++++++++++++++++++++++++++++++
 include/linux/phylink.h   | 66 ---------------------------------------
 2 files changed, 66 insertions(+), 66 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 3d25a4a6212b..a816391add12 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1074,6 +1074,72 @@ static void phylink_pcs_an_restart(struct phylink *pl)
 		pl->pcs->ops->pcs_an_restart(pl->pcs);
 }
 
+/**
+ * phylink_pcs_neg_mode() - helper to determine PCS inband mode
+ * @mode: one of %MLO_AN_FIXED, %MLO_AN_PHY, %MLO_AN_INBAND.
+ * @interface: interface mode to be used
+ * @advertising: adertisement ethtool link mode mask
+ *
+ * Determines the negotiation mode to be used by the PCS, and returns
+ * one of:
+ *
+ * - %PHYLINK_PCS_NEG_NONE: interface mode does not support inband
+ * - %PHYLINK_PCS_NEG_OUTBAND: an out of band mode (e.g. reading the PHY)
+ *   will be used.
+ * - %PHYLINK_PCS_NEG_INBAND_DISABLED: inband mode selected but autoneg
+ *   disabled
+ * - %PHYLINK_PCS_NEG_INBAND_ENABLED: inband mode selected and autoneg enabled
+ *
+ * Note: this is for cases where the PCS itself is involved in negotiation
+ * (e.g. Clause 37, SGMII and similar) not Clause 73.
+ */
+static unsigned int phylink_pcs_neg_mode(unsigned int mode,
+					 phy_interface_t interface,
+					 const unsigned long *advertising)
+{
+	unsigned int neg_mode;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_QSGMII:
+	case PHY_INTERFACE_MODE_QUSGMII:
+	case PHY_INTERFACE_MODE_USXGMII:
+		/* These protocols are designed for use with a PHY which
+		 * communicates its negotiation result back to the MAC via
+		 * inband communication. Note: there exist PHYs that run
+		 * with SGMII but do not send the inband data.
+		 */
+		if (!phylink_autoneg_inband(mode))
+			neg_mode = PHYLINK_PCS_NEG_OUTBAND;
+		else
+			neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
+		break;
+
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
+		/* 1000base-X is designed for use media-side for Fibre
+		 * connections, and thus the Autoneg bit needs to be
+		 * taken into account. We also do this for 2500base-X
+		 * as well, but drivers may not support this, so may
+		 * need to override this.
+		 */
+		if (!phylink_autoneg_inband(mode))
+			neg_mode = PHYLINK_PCS_NEG_OUTBAND;
+		else if (linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+					   advertising))
+			neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
+		else
+			neg_mode = PHYLINK_PCS_NEG_INBAND_DISABLED;
+		break;
+
+	default:
+		neg_mode = PHYLINK_PCS_NEG_NONE;
+		break;
+	}
+
+	return neg_mode;
+}
+
 static void phylink_major_config(struct phylink *pl, bool restart,
 				  const struct phylink_link_state *state)
 {
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 875439ab45de..d589f89c612c 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -98,72 +98,6 @@ static inline bool phylink_autoneg_inband(unsigned int mode)
 	return mode == MLO_AN_INBAND;
 }
 
-/**
- * phylink_pcs_neg_mode() - helper to determine PCS inband mode
- * @mode: one of %MLO_AN_FIXED, %MLO_AN_PHY, %MLO_AN_INBAND.
- * @interface: interface mode to be used
- * @advertising: adertisement ethtool link mode mask
- *
- * Determines the negotiation mode to be used by the PCS, and returns
- * one of:
- *
- * - %PHYLINK_PCS_NEG_NONE: interface mode does not support inband
- * - %PHYLINK_PCS_NEG_OUTBAND: an out of band mode (e.g. reading the PHY)
- *   will be used.
- * - %PHYLINK_PCS_NEG_INBAND_DISABLED: inband mode selected but autoneg
- *   disabled
- * - %PHYLINK_PCS_NEG_INBAND_ENABLED: inband mode selected and autoneg enabled
- *
- * Note: this is for cases where the PCS itself is involved in negotiation
- * (e.g. Clause 37, SGMII and similar) not Clause 73.
- */
-static inline unsigned int phylink_pcs_neg_mode(unsigned int mode,
-						phy_interface_t interface,
-						const unsigned long *advertising)
-{
-	unsigned int neg_mode;
-
-	switch (interface) {
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_QSGMII:
-	case PHY_INTERFACE_MODE_QUSGMII:
-	case PHY_INTERFACE_MODE_USXGMII:
-		/* These protocols are designed for use with a PHY which
-		 * communicates its negotiation result back to the MAC via
-		 * inband communication. Note: there exist PHYs that run
-		 * with SGMII but do not send the inband data.
-		 */
-		if (!phylink_autoneg_inband(mode))
-			neg_mode = PHYLINK_PCS_NEG_OUTBAND;
-		else
-			neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
-		break;
-
-	case PHY_INTERFACE_MODE_1000BASEX:
-	case PHY_INTERFACE_MODE_2500BASEX:
-		/* 1000base-X is designed for use media-side for Fibre
-		 * connections, and thus the Autoneg bit needs to be
-		 * taken into account. We also do this for 2500base-X
-		 * as well, but drivers may not support this, so may
-		 * need to override this.
-		 */
-		if (!phylink_autoneg_inband(mode))
-			neg_mode = PHYLINK_PCS_NEG_OUTBAND;
-		else if (linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
-					   advertising))
-			neg_mode = PHYLINK_PCS_NEG_INBAND_ENABLED;
-		else
-			neg_mode = PHYLINK_PCS_NEG_INBAND_DISABLED;
-		break;
-
-	default:
-		neg_mode = PHYLINK_PCS_NEG_NONE;
-		break;
-	}
-
-	return neg_mode;
-}
-
 /**
  * struct phylink_link_state - link state structure
  * @advertising: ethtool bitmask containing advertised link modes
-- 
2.30.2


