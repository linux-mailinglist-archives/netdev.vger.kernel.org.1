Return-Path: <netdev+bounces-249965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2FAD21B05
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 00:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FBCB303135A
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 22:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778E83939B2;
	Wed, 14 Jan 2026 22:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ejeddw9K"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EB53921D8
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 22:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768431485; cv=none; b=IUahM+WFeixR1sNjMFFUI9NsuAb0btz/yW81Tquk3Asdm9yTxGSWY+gp9Gxb5GhAZvC98q7seX8c/RL5epDKClONHVvPHou+sXlEh/aohereBdtHXS0KmqBZVxuEe9Y5uWbcUZ0zz3+vyfGshAxk+5fjsUWTB3DS+SJLHPMbsQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768431485; c=relaxed/simple;
	bh=UZFF7EGigj87tKtghH3PWskqYcKPnK8/xYSbYkt24Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPsYWD9opzlyT/k0wS5Ya55n+SUb1YTlu0lfErYk1ouxqjjDVKpbeBzpp9iUn9UTRQIelkIzUqWCQjawyCeqju5lUCoYK77LFBGp97azvGxkgvD7ISi1PaTk7v5bKbT8dMzYRjEj7ZRGsheowS6raBbg6KKcDz0nLMd+dmrn5GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ejeddw9K; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CF25A1A286B;
	Wed, 14 Jan 2026 22:57:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A56756074A;
	Wed, 14 Jan 2026 22:57:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 942CD10B6844D;
	Wed, 14 Jan 2026 23:57:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768431477; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=WG7VCGaZSEoU/lQqsDROfaKQGjsZRjDe86EKvqK3pMw=;
	b=ejeddw9KqV5IZSGnRaayg/QWKIoUc4XZA6OKXqqwzmqz6PDwKxfevINCcSEQoS80SXVKAl
	Mtcq6sUIJvRYVR0AO66EWAKHn1aU5uGT2Iayd17bngJIYdzteBwC//CQTAQWdtn039sG1h
	H1fYI9Ozf8nauI8aJUKHIrQtXKlntGF9h9EjtbZ33B14y6op/F2h1IEEipoC4IT2M7+xSa
	V72l5OtojjdmJBuT6puoAxpHmFh9CbhI2OfqWRnh4AOkzW/YhKfqGtQwvDb0GOMBYgUH4V
	Impl+r1SjBfVhbURHGPK/c25Os/K7diL2My2ni94+Yr8knAPXS6olXBlFR0rmA==
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
Subject: [PATCH net-next 6/6] net: sfp: Add support for some BCM5461-based SGMII to 100FX modules
Date: Wed, 14 Jan 2026 23:57:28 +0100
Message-ID: <20260114225731.811993-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260114225731.811993-1-maxime.chevallier@bootlin.com>
References: <20260114225731.811993-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The Prolabs GLC-GE-100FX-C SFP module is a 100BaseFX module that plugs
into a Cisco SGMII capable cage, thus allowing to use 100M fiber on ports
that would usually only support SGMII and 1000BaseX.

This module contains a Broadcom BCM5461 PHY, but fails to properly indicate
support for e.100_fx mode.

The FS SFP-GE-100FX-C is a similar module, but this one does have the
e.100_fx bit set.

Add a quirk and fixup for these modules, to have a consistent linkmode
set, and make sure we use SGMII as the PHY interface.

The Prolabs module absolutely needs single-byte mdio accesses, otherwise
it freezes the i2c bus.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/sfp.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index bff91735f681..fb12616a67c1 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -481,6 +481,23 @@ static void sfp_quirk_ubnt_uf_instant(const struct sfp_eeprom_id *id,
 			 caps->link_modes);
 }
 
+static void sfp_fixup_sgmii_100fx(struct sfp *sfp)
+{
+	sfp->mdio_protocol = MDIO_I2C_SINGLE_BYTE_C22;
+	sfp->module_t_wait = msecs_to_jiffies(500);
+}
+
+static void sfp_quirk_sgmii_100fx(const struct sfp_eeprom_id *id,
+				  struct sfp_module_caps *caps)
+{
+	/* Prolabs GLC-GE-100FX-C SGMII to 100FX module doesn't set the
+	 * base.e100_base_fx bit.
+	 */
+	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseFX_Full_BIT,
+			 caps->link_modes);
+	__set_bit(PHY_INTERFACE_MODE_SGMII, caps->interfaces);
+}
+
 #define SFP_QUIRK(_v, _p, _s, _f) \
 	{ .vendor = _v, .part = _p, .support = _s, .fixup = _f, }
 #define SFP_QUIRK_S(_v, _p, _s) SFP_QUIRK(_v, _p, _s, NULL)
@@ -553,6 +570,11 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10", sfp_fixup_rollball),
 	SFP_QUIRK_F("Turris", "RTSFP-10G", sfp_fixup_rollball),
+
+	SFP_QUIRK("CISCO-PROLABS", "GLC-GE-100FX-C",
+		  sfp_quirk_sgmii_100fx, sfp_fixup_sgmii_100fx),
+	SFP_QUIRK("FS", "SFP-GE-100FX",
+		  sfp_quirk_sgmii_100fx, sfp_fixup_sgmii_100fx),
 };
 
 static size_t sfp_strlen(const char *str, size_t maxlen)
-- 
2.49.0


