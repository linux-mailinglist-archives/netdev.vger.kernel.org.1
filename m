Return-Path: <netdev+bounces-249961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A61D21AFD
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 23:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7B3B30303B6
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 22:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD3438F93F;
	Wed, 14 Jan 2026 22:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="krrboD/U"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF1338F244;
	Wed, 14 Jan 2026 22:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768431481; cv=none; b=YlHLWMuftkrt/vxFCMYObQqPRKM0cQzd+EHxF3OXwQ1hUHB323XQFy4cywnP32YPEj4u7tUFfAipip4pobLmgJ4ZWuo11LykvqXjBQnI8LS9xsevUzvAq+UWeN3E4Y7wckzoisQ8WSIJRK4uErcW6iIpAKb0u7j3ExYDEwjjrOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768431481; c=relaxed/simple;
	bh=vRRIhHFPxtzThZZQkWphkJSxIn6V0oCyMNSakYsx6Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpnsFLHx+XnBPZyXTZTL2hqyphM/cnybn+e27btIfx6ZfvXBQqRCR4bhYdcnLKYsH5gWOPPLaKdNHlZfBpjAumezrMnukciT3qD5dLIrgqJ/u3jdKEWuVAhOYT+A5/Xwx9kTq11hOJLB1uadovuuGLcLipzscCt/+H7Zcy/Z0W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=krrboD/U; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B8F081A286C;
	Wed, 14 Jan 2026 22:57:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8DF536074A;
	Wed, 14 Jan 2026 22:57:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 63EBE10B68428;
	Wed, 14 Jan 2026 23:57:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768431468; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=vGkT6kUPV4XCoAV2sMfIa4glGoO0PPY84FW31CL588M=;
	b=krrboD/U0c0msIeHbPyU/Q1VZnhGftw7G9KU3HY/JcJtST9GXoGxRNrOrcXzdCz7XUKLnR
	h7D7z9DnvM4IinXd9rf+5iGd9bPLHxw+oWEDuUiiAW0Hw6v+J7muWODIeSik+fCws6OI4V
	6Ulegra5k2Xw4BrTPq2Um8ems14miJZPdxv52H6qD+POXiW9DWfEV/L6h4Nnxlsbe3JL7F
	bPn2wEMvf+skrEK0jl7552pCvPWk9ikGZKOdWPG8RSkrGsTgiFX37zNfm16vG/1T9cwJk+
	/f10LJVGwom20uhHJO6uPerckXZOMcArJLV/nu9nndvJqmpXYqUXfSvBbrtIJg==
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
Subject: [PATCH net-next 1/6] net: sfp: Add support for SGMII to 100FX modules
Date: Wed, 14 Jan 2026 23:57:23 +0100
Message-ID: <20260114225731.811993-2-maxime.chevallier@bootlin.com>
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

There exist some SFP modules that rely on a built-in PHY (usually a
Broadcom BCM5461) to output 100baseFX, using SGMII as the
phy_interface.

This is relevant as there are devices that support SGMII and 1000BaseX,
but not 100FX natively on their SFP cages.

SGMII can be used to convey 100Mbps links with symbol repetition, but the
serdes lane stays clocked at 1.25GHz. We therefore absolutely need a
media-converter to adapt this to 100BaseFX, that runs at 125MHz.

What this means for the sfp-bus infrastructure is that we may have a PHY
to probe when dealing with a 100FX (and possibly a 100LX) module, and if
this PHY exist it will use SGMII.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/sfp-bus.c | 11 +++++++++++
 drivers/net/phy/sfp.c     |  3 ++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index b945d75966d5..85c9f21af69b 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -105,6 +105,14 @@ static void sfp_module_parse_may_have_phy(struct sfp_bus *bus,
 		return;
 	}
 
+	/* Some 100M fiber modules have a PHY, acting as an SGMII to 100FX
+	 * media converter.
+	 */
+	if (id->base.e100_base_fx || id->base.e100_base_lx) {
+		bus->caps.may_have_phy = true;
+		return;
+	}
+
 	if (id->base.phys_id != SFF8024_ID_DWDM_SFP) {
 		switch (id->base.extended_cc) {
 		case SFF8024_ECC_10GBASE_T_SFI:
@@ -188,6 +196,9 @@ static void sfp_module_parse_support(struct sfp_bus *bus,
 	if (id->base.e100_base_fx || id->base.e100_base_lx) {
 		phylink_set(modes, 100baseFX_Full);
 		__set_bit(PHY_INTERFACE_MODE_100BASEX, interfaces);
+
+		/* SGMII to 100Base-FX modules with internal PHY */
+		__set_bit(PHY_INTERFACE_MODE_SGMII, interfaces);
 	}
 	if ((id->base.e_base_px || id->base.e_base_bx10) && br_nom == 100) {
 		phylink_set(modes, 100baseFX_Full);
diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 84bef5099dda..5b42af1cf6aa 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -2446,7 +2446,8 @@ static int sfp_sm_mod_probe(struct sfp *sfp, bool report)
 	    sfp->id.base.extended_cc == SFF8024_ECC_5GBASE_T ||
 	    sfp->id.base.extended_cc == SFF8024_ECC_2_5GBASE_T)
 		sfp->mdio_protocol = MDIO_I2C_C45;
-	else if (sfp->id.base.e1000_base_t)
+	else if (sfp->id.base.e1000_base_t || sfp->id.base.e100_base_fx ||
+		 sfp->id.base.e100_base_lx)
 		sfp->mdio_protocol = MDIO_I2C_MARVELL_C22;
 	else
 		sfp->mdio_protocol = MDIO_I2C_NONE;
-- 
2.49.0


