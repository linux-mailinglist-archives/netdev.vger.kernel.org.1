Return-Path: <netdev+bounces-132137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2670F9908CC
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 18:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59C51F2125D
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A971C3049;
	Fri,  4 Oct 2024 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AoPWYq1c"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228551E376A;
	Fri,  4 Oct 2024 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728058575; cv=none; b=lckG/ChMjz7zKkBufbJ7asHPdRWPkWHB0nwRIV4K2aTO8pgeYQ4bYG2Ko5abX0sFewIVIt6trRiaQERiUbeXhfBeaxIoIyBkDh0+GNKKB9WnsCR2IE9Lq0eWUEofpdT3FEhrdYQf+5adwMWVsRXmxgPzhllvOiq7UhMeUJ6098E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728058575; c=relaxed/simple;
	bh=ejn1GFPR9W2TdEKB5c75qRHxLwfHpl+FmEBD4TY8kBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AStxCSwb9GIeOLeQeKmepruynzZ4EX4OJzLbb7msGxVarW8dVyHlTdb3mzl9u/C2VkBFVWyvLLWZ5bduSnUkkV8khelMZR+vK3yExA/4NJu56jkJGu8CUCT1SLoqN+ZNSBwWBZ8eg4xuLalrvTU9hXF0IrSopAKjkgLJbR4B43w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AoPWYq1c; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B271720002;
	Fri,  4 Oct 2024 16:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728058565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fSauzY14BbY+ha02xCBSKfLVVZxWv4ZQivu2DAFFQho=;
	b=AoPWYq1coI1dPPv7LOHsQpWy/qOiZeIDAjusnCcyjRbpP+s1KsbGZbnZX20u/LH9YRH4kJ
	4f6U2QhZuu86MtyVLNbY5nSl4sPhX2OXssC9mE9nnVToc3alwhuFIL7BZ1Wdw58TGirBjB
	x4jJLcBg6qq70hG+fcYfKkn1C7V1WyvUQ70gsio2pZyFmqsX7fZ1RvFBb2oXpzOnKDtDLJ
	MEvLj0nqQTwsNU9bxq6dGRMqrQLYdlxpHDZg1l8oUVby4RZ1kh4XICk6+QP7aSKOLZ98VU
	IPAS5M/hhZd5FgW60u7BBf85+BnRFUqYeJwHdvCZitcXjVMRZ0tW9ek9fIipvg==
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
Subject: [PATCH net-next v2 0/9] Allow isolating PHY devices
Date: Fri,  4 Oct 2024 18:15:50 +0200
Message-ID: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello,

This is the V2 of a series to add isolation support for PHY devices.

As a remainder, this mode allows a PHY to set its MII lines in
high-impedance mode to avoid interferences on this bus.

So far, I've identified that :

 - Marvell 88e1512 isolation works fine
 - LXT973 claims to support isolation, but it's actually broken
 - Marvell 88x3310 doesn't support isolation, by design
 - Marvell 88e1111 claims to support isolation in GMII, RGMII, TBI
   (untested) but doesn't in SGMII (tested).

Changes in V2 :

 - Removed the loopback mode that was included in the first iteration
 - Added phy_shutdown, to make sure we de-isolate the PHY when rebooting
 - Changes the "PHY_NO_ISOLATE" flag to a phy driver ops. Testing showed
   that some PHYs may or may not support isolation based on the
   interface that's being used.
 - Added isolation support reporting for the Marvell 88e1111 PHY.

V1 : https://lore.kernel.org/netdev/20240911212713.2178943-1-maxime.chevallier@bootlin.com/

Maxime Chevallier (9):
  net: phy: allow isolating PHY devices
  net: phy: Introduce phy_shutdown for device quiescence.
  net: phy: Allow PHY drivers to report isolation support
  net: phy: lxt: Mark LXT973 PHYs as having a broken isolate mode
  net: phy: marvell10g: 88x3310 and 88x3340 don't support isolate mode
  net: phy: marvell: mv88e1111 doesn't support isolate in SGMII mode
  net: phy: introduce ethtool_phy_ops to get and set phy configuration
  net: ethtool: phy: allow reporting and setting the phy isolate status
  netlink: specs: introduce phy-set command along with configurable
    attributes

 Documentation/netlink/specs/ethtool.yaml     |  15 +++
 Documentation/networking/ethtool-netlink.rst |   1 +
 drivers/net/phy/lxt.c                        |   2 +
 drivers/net/phy/marvell.c                    |   9 ++
 drivers/net/phy/marvell10g.c                 |   2 +
 drivers/net/phy/phy.c                        |  44 ++++++++
 drivers/net/phy/phy_device.c                 | 101 +++++++++++++++++--
 include/linux/ethtool.h                      |   8 ++
 include/linux/phy.h                          |  42 ++++++++
 include/uapi/linux/ethtool_netlink.h         |   2 +
 net/ethtool/netlink.c                        |   8 ++
 net/ethtool/netlink.h                        |   1 +
 net/ethtool/phy.c                            |  68 +++++++++++++
 13 files changed, 297 insertions(+), 6 deletions(-)

-- 
2.46.1


