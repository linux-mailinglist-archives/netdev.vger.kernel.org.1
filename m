Return-Path: <netdev+bounces-249964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A92DED21AE2
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 23:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3EF8302B508
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 22:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27FE3A7DFB;
	Wed, 14 Jan 2026 22:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kPDQCcKv"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC4838F233;
	Wed, 14 Jan 2026 22:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768431484; cv=none; b=pXvSLx9IEzBF6DKitLK/nvVKuL3YfotIY1Xp9gGZHzBt2pEZXdkKY1y2wjEvzIUAwRzEXa2lfzUoTpuoCqDNdr0i2ahHbPVg3GmRROvllYX0MZ534828wF0vWLbdQalHI+jpCMnAFyjIfp6VCFyl/Xfpe8gIZOEH1mHkXdyYiKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768431484; c=relaxed/simple;
	bh=zjE11OdrpdIYORzL7p98BWkcLHYUKy4ikScJetEeEbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KNqDWffQ+FvXba9nA7eU4golR11bl9/9s8FqnE5o1COCzRfM+z+lay7AUfJnrmkA08m+ranKmYpKtfPr/vvQPGHrHbD9y/3OlgMluwubJHGLBcfti+M8iae9AAP6gg6k4+Nw92V0y0Et97i6/5R4sPfW+aHnViX0IelkMX/+/n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kPDQCcKv; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5A0724E420E4;
	Wed, 14 Jan 2026 22:57:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F1A46074A;
	Wed, 14 Jan 2026 22:57:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D766210B68428;
	Wed, 14 Jan 2026 23:57:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768431474; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=R0IomDMS8ECUCELWItPyizADN17LB+B8jCYycdfWEZ4=;
	b=kPDQCcKvv6t7spx9O1C7GxmsJqQIH/ru/XwhuG6+wI52g9AdcMY0Ar5c/klP/3wNSjS4LE
	EtQ/2ryqdrKgbsOmOFHHvdGl7XeIySonsoCd/cDzixiGq1tXQKtCTQQhaELWLZZXE3WQjW
	goW+Q3AE7A3ub9xdLX03ZTxFAbUAFSSOaCIkGKFGgTZkMkfslgbmEIURnBrJ6i/L5Ijzfz
	IAeTi76lEyqRO0ffuFa5IkXZOpKL2SG8fXh7bWsGeXB7aUX1hMDXRlVdRew1+CpP5hVnSF
	7Aq08kQsKpR91bviYxC918bygqspsso2kAhG1Ns6nAw2i+qBHiHFnentJq5xPw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH net-next 4/6] net: phy: broadcom: Support SGMII to 100FX on BCM5461
Date: Wed, 14 Jan 2026 23:57:26 +0100
Message-ID: <20260114225731.811993-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260114225731.811993-1-maxime.chevallier@bootlin.com>
References: <20260114225731.811993-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Multiple SFP modules of the type "SGMII to 100BaseFX" appear to be using
a Broadcom BCM5461 PHY as a media converter inside the module. This is
the case for at least the Prolabs GLC-GE-100FX-C, and the FS
SFP-GE-100FX modules.

Out of the box, these modules don't work, and need the PHY to be
configured. Florian Fainelli has helped a lot, and provided some
programming instructions to use this mode in the PHY.

Implement support for that mode, based on Florian's instructions and some
more tweaks found by trial and error.

There's no register we can read from the PHY to know that the PHY is
operating in SGMII to 100FX, so we also add a .get_features() callback
that populates the PHY's supported linkmodes according to the module
caps parsed from the eeprom.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/broadcom.c | 94 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index cb306f9e80cc..bcdd6ed70b6b 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/phy.h>
+#include <linux/sfp.h>
 #include <linux/device.h>
 #include <linux/brcmphy.h>
 #include <linux/of.h>
@@ -455,6 +456,78 @@ static int bcm54811_config_init(struct phy_device *phydev)
 	return bcm5481x_set_brrmode(phydev, priv->brr_mode);
 }
 
+static int bcm5461_config_init(struct phy_device *phydev)
+{
+	int rc, val;
+
+	/* We don't have any special steps to follow for anything other than
+	 * SGMII to 100BaseFX
+	 */
+	if (phydev->interface != PHY_INTERFACE_MODE_SGMII ||
+	    !linkmode_test_bit(ETHTOOL_LINK_MODE_100baseFX_Full_BIT,
+			       phydev->supported))
+		return 0;
+
+	/* Select 1000BASE-X register set (primary SerDes) */
+	val = bcm_phy_read_shadow(phydev, BCM54XX_SHD_MODE);
+	if (val < 0)
+		return val;
+	val |= BCM54XX_SHD_MODE_1000BX;
+	rc = bcm_phy_write_shadow(phydev, BCM54XX_SHD_MODE, val);
+	if (rc < 0)
+		return rc;
+
+	/* Power down SerDes interface */
+	rc = phy_set_bits(phydev, MII_BMCR, BMCR_PDOWN);
+	if (rc < 0)
+		return rc;
+
+	/* Select proper interface mode */
+	val &= ~BCM54XX_SHD_INTF_SEL_MASK;
+	val |= phydev->interface == PHY_INTERFACE_MODE_SGMII ?
+		BCM54XX_SHD_INTF_SEL_SGMII :
+		BCM54XX_SHD_INTF_SEL_GBIC;
+	rc = bcm_phy_write_shadow(phydev, BCM54XX_SHD_MODE, val);
+	if (rc < 0)
+		return rc;
+
+	/* Power up SerDes interface */
+	rc = phy_clear_bits(phydev, MII_BMCR, BMCR_PDOWN);
+	if (rc < 0)
+		return rc;
+
+	/* For 100BaseFX, the signal detection is configured in bit 5 of the shadow
+	 * 0b01100 in the 0x1C register.
+	 *
+	 * 0 to use EN_10B/SD as CMOS/TTL signal detect (default)
+	 * 1 to use SD_100FX± as PECL signal detect
+	 */
+	rc = bcm_phy_write_shadow(phydev, 0xC, BIT(5));
+	if (rc < 0)
+		return rc;
+
+	/* You can use either copper or SGMII interface for 100BaseFX and that will
+	 * be configured this way:
+	 *
+	 * - in register 0x1C, shadow 0b10 (1000Base-T/100Base-TX/10Base-T Spare
+	 * Control 1), set bit 4 to 1 to enable 100BaseFX
+	 */
+	rc = bcm_phy_write_shadow(phydev, 0x2, BIT(4));
+	if (rc < 0)
+		return rc;
+
+	/* disable auto-negotiation with register 0x00 = 0x2100 */
+	phy_write(phydev, MII_BMCR, 0x2100);
+
+	/* set register 0x18 to 0x430 (bit 10 -> normal mode, bits 5:4 control
+	 * the edge rate. 0b00 -> 4ns, 0b01 -> 5ns, 0b10 -> 3ns, 0b11 -> 0ns. This
+	 * is the auxiliary control register (MII_BCM54XX_AUXCTL_SHDWSEL_AUXCTL).
+	 */
+	phy_write(phydev, 0x18, 0x430);
+
+	return 0;
+}
+
 static int bcm54xx_config_init(struct phy_device *phydev)
 {
 	int reg, err, val;
@@ -492,6 +565,9 @@ static int bcm54xx_config_init(struct phy_device *phydev)
 	case PHY_ID_BCM54210E:
 		err = bcm54210e_config_init(phydev);
 		break;
+	case PHY_ID_BCM5461:
+		err = bcm5461_config_init(phydev);
+		break;
 	case PHY_ID_BCM54612E:
 		err = bcm54612e_config_init(phydev);
 		break;
@@ -1255,6 +1331,23 @@ static void bcm54xx_link_change_notify(struct phy_device *phydev)
 	bcm_phy_write_exp(phydev, MII_BCM54XX_EXP_EXP08, ret);
 }
 
+static int bcm5461_get_features(struct phy_device *phydev)
+{
+	if (!phy_on_sfp(phydev))
+		return genphy_read_abilities(phydev);
+
+	if (!phydev->parent_sfp_caps)
+		return -EINVAL;
+
+	/* For SGMII to 100FX modules, the reported linkmodes from
+	 * genphy_read_abilities() are incorrect. Let's repy on the SFP module
+	 * caps
+	 */
+	linkmode_copy(phydev->supported, phydev->parent_sfp_caps->link_modes);
+
+	return 0;
+}
+
 static int lre_read_master_slave(struct phy_device *phydev)
 {
 	int cfg = MASTER_SLAVE_CFG_UNKNOWN, state;
@@ -1505,6 +1598,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.probe		= bcm54xx_phy_probe,
 	.config_init	= bcm54xx_config_init,
 	.config_intr	= bcm_phy_config_intr,
+	.get_features	= bcm5461_get_features,
 	.handle_interrupt = bcm_phy_handle_interrupt,
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
-- 
2.49.0


