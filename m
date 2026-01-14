Return-Path: <netdev+bounces-249960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E9CD21AEE
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 23:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7495030388BD
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 22:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD026350293;
	Wed, 14 Jan 2026 22:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W2GEwpcF"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E9E30BF6B
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 22:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768431476; cv=none; b=gwf9oWt5AXFlR1xgpJHkN+mWyTdBIZtuEfx7u3+G2TPGIIykAyKgzMYDj1rEsjkkzkqUPvhFhApQ3xnGsAGKmw4o/D9cnk7SED3NY+6oIPQzBFnNHaCtumm3Zf1v93fBMQEMA9m6u8W91gwuwOhqydkZGdSzNEzhmZH3IVsjN4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768431476; c=relaxed/simple;
	bh=dRiwU05WXtoUOO2sLFeCNKsTvdpMMT11OuK+cN9JM9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cX39Kd0m/l4fDxFdiKlQZzF9BR1YSjzaLnd1U+HBQSreI3YImYC0JAXxSk5WmD3MJOgzfPztFcHLOHaXs3zGluT/c9OCXxzYIBQJje/KdDDJWZoV1u3+TO1WTOWprXlTaqy50ZdOe/dgtKyJdr02iGd4+pxTCgqRo4gqWTeTC0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W2GEwpcF; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 9C89DC1F1D3;
	Wed, 14 Jan 2026 22:57:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 229E96074A;
	Wed, 14 Jan 2026 22:57:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D0E910B68410;
	Wed, 14 Jan 2026 23:57:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768431467; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=VDfSbPYAg10o0+hHwcLXFBZaneLM220SZTxze+B/sFw=;
	b=W2GEwpcFsWW0R60v2IFCuHLnSJXBmIgC+VFvq9WO4b/AIRYg8mfS496y5Syt3zlsITGn2R
	dqNetWx1VYQV2PSiJE+6OuCJZjVV294YLQxodhhWdBfUcpQpjFV1qXxU5GIrxVr2s17fxU
	sFH7OVTAZpMeOIvtG8dUTIVZShBOksSdeCiwmyF+NDWu8oYjPlnJf+O2exHuLrj2cZQEeD
	A4JvtlB0YHa+nQKW438QcBQ9ZuE3HdlRRX/e1tkTbM2g9H+NGDd3epqRyydVll2kkmQ+FX
	vWKRGPEA7aSOS8VYvNRb2I1xAQYAJwRUfGNDnbINGn/JmcrCRLD/pu9exj70dA==
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
Subject: [PATCH net-next 0/6] net: sfp: Add support for SGMII to 100FX modules
Date: Wed, 14 Jan 2026 23:57:22 +0100
Message-ID: <20260114225731.811993-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi everyone,

This series is an attempt to add support for _some_ SGMII to 100BaseFX
SFP modules. Getting these to work was a bit challenging, and none of that
could have been done without the precious help from Florian [1].

[1] : https://lore.kernel.org/netdev/20250624233922.45089b95@fedora.home/

Thanks again :)

These modules are quite useful, as some MACs can output SGMII and 1000BaseX,
but can't do 100BaseFX. Should anyone want to connect such a device to a
100FX link-partner, they need to either use an external media-converter,
or an SFP module that has a built-in PHY for that.

SGMII can convey 100M link, but the clock speed stays at 1.25GHz. A
100FX link is clocked at 125MHz, hence the media-converter in the
middle.

As this is something I had to get working, I got my hands on 4 such SFP
modules :

 - A "Cisco-compatible" Prolabs module : "CISCO-PROLABS GLC-GE-100FX-C"
 - A "Generic" Prolabs module : "PROLABS SFP-GE-100FX-C"
 - A FS module : "FS SFP-GE-100FX"
 - A Phoenix Contact module : "PHOENIX CONTACT 2891081"

Out of these, the 2 Prolabs and the FS module contain a Broadcom BCM5461
PHY. Out-of-the-box, they don't work, but thanks to Florian's help I was
able to get the Cisco-Prolabs and the FS one to work.

I couldn't get the Generic Prolabs to work, even though the PHY is
detected and accessible. As for the Phoenix Contact one, I don't know
which PHY it contains, and I couldn't get anything out of it.

This series therefore brings support for the "Cisco-compatible" Prolabs, and the
FS one.

Some oddities were discovered along the way. Some modules are missing
the 100_fx bit in their EEPROM. Even stranger, trying to access the
BCM5461 PHY with regular mdio-i2c accesses causes the PHY to freeze and
get the i2c bus in an unrecoverable stuck state. However, accessing them
in single-byte mdio-i2c accesses does work !

Another thing that needed to be addressed is the SFP interface
selection, that expected that 100FX modules would be using the
PHY_INTERFACE_MODE_100BASEX mode. That's addressed by patch 2, and I'd
really like some feedback from Russell there, I may be breaking things
:(

All in all, this series contains a lot of hacks, but for such peculiar
modules one could expect that this wouldn't fit the current model.

This was tested on 3 different MACs :
 - The KSZ9477's SGMII port (old version of xpcs)
 - The Macchiatobin's eth3 port (mvpp2 + Marvell PCS)
 - A Cyclone V Socfpga device (stmmac + Lynx PCS)

Thank you,

Maxime

Maxime Chevallier (6):
  net: sfp: Add support for SGMII to 100FX modules
  net: phylink: Allow more interfaces in SFP interface selection
  net: phy: Store module caps for PHYs embedded in SFP
  net: phy: broadcom: Support SGMII to 100FX on BCM5461
  net: mdio: mdio-i2c: Add single-byte C22 MDIO protocol
  net: sfp: Add support for some BCM5461-based SGMII to 100FX modules

 drivers/net/mdio/mdio-i2c.c   | 12 +++--
 drivers/net/phy/broadcom.c    | 94 +++++++++++++++++++++++++++++++++++
 drivers/net/phy/phy-caps.h    |  5 ++
 drivers/net/phy/phy_caps.c    | 47 ++++++++++++++++++
 drivers/net/phy/phylink.c     | 24 +++------
 drivers/net/phy/sfp-bus.c     | 11 ++++
 drivers/net/phy/sfp.c         | 31 +++++++++++-
 include/linux/mdio/mdio-i2c.h |  1 +
 include/linux/phy.h           |  4 ++
 9 files changed, 207 insertions(+), 22 deletions(-)

-- 
2.49.0


