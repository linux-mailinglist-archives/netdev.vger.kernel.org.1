Return-Path: <netdev+bounces-127574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 899E3975C62
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 23:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC39AB214B3
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 21:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D511B14EF;
	Wed, 11 Sep 2024 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gaHkeb+X"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E635A154BEA;
	Wed, 11 Sep 2024 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726090048; cv=none; b=ppEGiVLLIpL0wfvYChSr0HuCQJ+izLzbCZCmGxqpK4ICBFNkocQujvB3xqkexTqOdEF3yNg6D16cxIPUsk8P/VBpd19B1NJtxT/zI/cZmd6OcJmVm3EIfG/krPL6UZctfC1KYZg9wUIu5B+Cu3ZhwEXU1C4laxLtD8tgWy/0gbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726090048; c=relaxed/simple;
	bh=ihls58iod8nG9VXs3DEc2Eys4zWPBkGLmJdZieaxOhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyMB7ui5AlOJBk2v2FUN97BIu1djafhAYVhYoFMm8xuW8NIWPQw5xrYnUqquQhXXmDyiLBYAOrQrSqeOoixow+prUsr6OYBCfcWuHQlHY5OSESdaX3kieqZQT8Mg/OSloHOwOBDE2SKMP7o1xjDtO+0yK939Svx2DslzsM93qrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gaHkeb+X; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 279D81C0005;
	Wed, 11 Sep 2024 21:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726090038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rqeH8IixeEEWajyVevr1Htj2CPvSE4kTjgluMfWNRM=;
	b=gaHkeb+X0hYdtP+OMqx1viofufMrfCd8Zbtxg2hs15VCuqSBbdVlcZUnJBFYEHHUSy6HhT
	88zFlZlTAw12gpqc676LuBGIBYvyrSehYZ11M7cDOuq44xrS7vKkcbqgTtUG1KjqOqIsN0
	EiUP5OxaDSmA40hH/HGcSjlbnACW8nwqM7sBqrGN0anoXIEJXVfE4VGQUDoACNAAWH1hOn
	FwCriRIENAxX7OHMqA8610qLX/ZL5cHFGZKp3EiOOF5vZXbmmPe09ft9JkN38WWkFqoF9j
	WA8+8Hb3XqnJPHrtrpLRqfBz/5rMmwoebV2lSiUQ86xpMZ7clEbcazqulxAMSA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH net-next 1/7] net: phy: allow isolating PHY devices
Date: Wed, 11 Sep 2024 23:27:05 +0200
Message-ID: <20240911212713.2178943-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911212713.2178943-1-maxime.chevallier@bootlin.com>
References: <20240911212713.2178943-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

The 802.3 specifications describes the isolation mode as setting the
PHY's MII interface in high-impedance mode, thus isolating the PHY from
that bus. This effectively breaks the link between the MAC and the PHY,
but without necessarily disrupting the link between the PHY and the LP.

This mode can be useful for testing purposes, but also when there are
multiple PHYs on the same MII bus (a case that the 802.3 specification
refers to).

In Isolation mode, the PHY will still continue to respond to MDIO
commands.

Introduce a helper to set the phy in an isolated mode.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_device.c | 76 +++++++++++++++++++++++++++++++++---
 include/linux/phy.h          |  4 ++
 2 files changed, 74 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 560e338b307a..c468e72bef4b 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2127,6 +2127,38 @@ int phy_loopback(struct phy_device *phydev, bool enable)
 }
 EXPORT_SYMBOL(phy_loopback);
 
+int phy_isolate(struct phy_device *phydev, bool enable)
+{
+	int ret = 0;
+
+	if (!phydev->drv)
+		return -EIO;
+
+	mutex_lock(&phydev->lock);
+
+	if (enable && phydev->isolated) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (!enable && !phydev->isolated) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = genphy_isolate(phydev, enable);
+
+	if (ret)
+		goto out;
+
+	phydev->isolated = enable;
+
+out:
+	mutex_unlock(&phydev->lock);
+	return ret;
+}
+EXPORT_SYMBOL(phy_isolate);
+
 /**
  * phy_reset_after_clk_enable - perform a PHY reset if needed
  * @phydev: target phy_device struct
@@ -2280,7 +2312,7 @@ int genphy_setup_forced(struct phy_device *phydev)
 	ctl = mii_bmcr_encode_fixed(phydev->speed, phydev->duplex);
 
 	return phy_modify(phydev, MII_BMCR,
-			  ~(BMCR_LOOPBACK | BMCR_ISOLATE | BMCR_PDOWN), ctl);
+			  ~(BMCR_LOOPBACK | BMCR_PDOWN), ctl);
 }
 EXPORT_SYMBOL(genphy_setup_forced);
 
@@ -2369,8 +2401,11 @@ EXPORT_SYMBOL(genphy_read_master_slave);
  */
 int genphy_restart_aneg(struct phy_device *phydev)
 {
-	/* Don't isolate the PHY if we're negotiating */
-	return phy_modify(phydev, MII_BMCR, BMCR_ISOLATE,
+	u16 mask = phydev->isolated ? 0 : BMCR_ISOLATE;
+	/* Don't isolate the PHY if we're negotiating, unless the PHY is
+	 * explicitly isolated
+	 */
+	return phy_modify(phydev, MII_BMCR, mask,
 			  BMCR_ANENABLE | BMCR_ANRESTART);
 }
 EXPORT_SYMBOL(genphy_restart_aneg);
@@ -2394,7 +2429,8 @@ int genphy_check_and_restart_aneg(struct phy_device *phydev, bool restart)
 		if (ret < 0)
 			return ret;
 
-		if (!(ret & BMCR_ANENABLE) || (ret & BMCR_ISOLATE))
+		if (!(ret & BMCR_ANENABLE) ||
+		    ((ret & BMCR_ISOLATE) && !phydev->isolated))
 			restart = true;
 	}
 
@@ -2495,7 +2531,8 @@ int genphy_c37_config_aneg(struct phy_device *phydev)
 		if (ctl < 0)
 			return ctl;
 
-		if (!(ctl & BMCR_ANENABLE) || (ctl & BMCR_ISOLATE))
+		if (!(ctl & BMCR_ANENABLE) ||
+		    ((ctl & BMCR_ISOLATE) && !phydev->isolated))
 			changed = 1; /* do restart aneg */
 	}
 
@@ -2782,12 +2819,18 @@ EXPORT_SYMBOL(genphy_c37_read_status);
 int genphy_soft_reset(struct phy_device *phydev)
 {
 	u16 res = BMCR_RESET;
+	u16 mask = 0;
 	int ret;
 
 	if (phydev->autoneg == AUTONEG_ENABLE)
 		res |= BMCR_ANRESTART;
 
-	ret = phy_modify(phydev, MII_BMCR, BMCR_ISOLATE, res);
+	if (phydev->isolated)
+		res |= BMCR_ISOLATE;
+	else
+		mask |= BMCR_ISOLATE;
+
+	ret = phy_modify(phydev, MII_BMCR, mask, res);
 	if (ret < 0)
 		return ret;
 
@@ -2912,6 +2955,12 @@ int genphy_loopback(struct phy_device *phydev, bool enable)
 		u16 ctl = BMCR_LOOPBACK;
 		int ret, val;
 
+		/* Isolating and looping-back the MII interface doesn't really
+		 * make sense
+		 */
+		if (phydev->isolated)
+			return -EINVAL;
+
 		ctl |= mii_bmcr_encode_fixed(phydev->speed, phydev->duplex);
 
 		phy_modify(phydev, MII_BMCR, ~0, ctl);
@@ -2924,6 +2973,8 @@ int genphy_loopback(struct phy_device *phydev, bool enable)
 	} else {
 		phy_modify(phydev, MII_BMCR, BMCR_LOOPBACK, 0);
 
+		genphy_isolate(phydev, phydev->isolated);
+
 		phy_config_aneg(phydev);
 	}
 
@@ -2931,6 +2982,19 @@ int genphy_loopback(struct phy_device *phydev, bool enable)
 }
 EXPORT_SYMBOL(genphy_loopback);
 
+int genphy_isolate(struct phy_device *phydev, bool enable)
+{
+	u16 val = 0;
+
+	if (enable)
+		val = BMCR_ISOLATE;
+
+	phy_modify(phydev, MII_BMCR, BMCR_ISOLATE, val);
+
+	return 0;
+}
+EXPORT_SYMBOL(genphy_isolate);
+
 /**
  * phy_remove_link_mode - Remove a supported link mode
  * @phydev: phy_device structure to remove link mode from
diff --git a/include/linux/phy.h b/include/linux/phy.h
index a98bc91a0cde..ae33919aa0f5 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -573,6 +573,7 @@ struct macsec_ops;
  * @mac_managed_pm: Set true if MAC driver takes of suspending/resuming PHY
  * @wol_enabled: Set to true if the PHY or the attached MAC have Wake-on-LAN
  * 		 enabled.
+ * @isolated: Set to true if the PHY's MII has been isolated.
  * @state: State of the PHY for management purposes
  * @dev_flags: Device-specific flags used by the PHY driver.
  *
@@ -676,6 +677,7 @@ struct phy_device {
 	unsigned is_on_sfp_module:1;
 	unsigned mac_managed_pm:1;
 	unsigned wol_enabled:1;
+	unsigned isolated:1;
 
 	unsigned autoneg:1;
 	/* The most recently read link state */
@@ -1781,6 +1783,7 @@ int phy_suspend(struct phy_device *phydev);
 int phy_resume(struct phy_device *phydev);
 int __phy_resume(struct phy_device *phydev);
 int phy_loopback(struct phy_device *phydev, bool enable);
+int phy_isolate(struct phy_device *phydev, bool enable);
 int phy_sfp_connect_phy(void *upstream, struct phy_device *phy);
 void phy_sfp_disconnect_phy(void *upstream, struct phy_device *phy);
 void phy_sfp_attach(void *upstream, struct sfp_bus *bus);
@@ -1894,6 +1897,7 @@ int genphy_read_master_slave(struct phy_device *phydev);
 int genphy_suspend(struct phy_device *phydev);
 int genphy_resume(struct phy_device *phydev);
 int genphy_loopback(struct phy_device *phydev, bool enable);
+int genphy_isolate(struct phy_device *phydev, bool enable);
 int genphy_soft_reset(struct phy_device *phydev);
 irqreturn_t genphy_handle_interrupt_no_ack(struct phy_device *phydev);
 
-- 
2.46.0


