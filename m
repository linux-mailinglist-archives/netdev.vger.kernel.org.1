Return-Path: <netdev+bounces-120641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4919C95A104
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 17:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F702831D7
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4917213BAF1;
	Wed, 21 Aug 2024 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="irN2ze3r"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C045C139D1E;
	Wed, 21 Aug 2024 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724253026; cv=none; b=gKAJsQZF+zxcu/6pH/tVmKOFumog/5bM50aCtqRIDhmEYIT3xOeAm9W0lYu3gkO0qrvue2o+IkL+15/x3/mdcJLj0xS22eBQ6C9cHJIQTJ5AUZOGXVSJ5hC2e+o2cqVd//ufEiDPHOeUdboC+7fuoDSxty3xNNgkAEHq/Nu8JkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724253026; c=relaxed/simple;
	bh=5tHOmgKf7i1uO29wrxhz0NWK1c1/vHXC1MI0liIkna8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CiTmaci/qPzISOSE6kChOyB/75e6XqzPRWQ20lTyTu5g7bffjwCCmqZKrCRiuab7DolEYROgEJfEf1LSMORAThShpKQz3AT2NO/VD/GdRmjH7tE+attNZ+8cU+VyEiYT99W1rH7kAcxFJicWNW+R6+jQxipQ5tFqtMIRDa4bDHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=irN2ze3r; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4920340004;
	Wed, 21 Aug 2024 15:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724253015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AToNTO8xYFLGG7Mhqo9PQIDjjcAX6MVbCZPK+rg6NpM=;
	b=irN2ze3rAD+uxFxi8NwRq3LV7IY1dNJvfzUwmYGbNsYfS5zWvRH33QzpxKQs73enxwC4SV
	Sqt9oYzhR2MGWecg4EKbh4zUJ0S3AsrNV+PnFbXQEV7xjTiUvQGLGr2Ci9T5WSzOhsLEFc
	VSFMGH3S1V5F+4097NecEuyRs5DqW1YEub0lm8NQitOzRWOuBjvEZ3+xZr7F+NTOefvZyS
	dD0uG/kTNJbzSZgNKn6HKzl5iqscJHea4RjIvpVcHiUFKwPKQhjMcKY9ZM4aJg7XRb8KC2
	Uc43bgn9r4cVasdqo/ASIMu2N0XxCk77LxjPY2l9+Sh1pnA+jrheyMT+IhPEYw==
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
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Nathan Chancellor <nathan@kernel.org>,
	Antoine Tenart <atenart@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next v18 00/13] Introduce PHY listing and link_topology tracking
Date: Wed, 21 Aug 2024 17:09:54 +0200
Message-ID: <20240821151009.1681151-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello everyone,

This is V18 of the phy_link_topology series, aiming at improving support
for multiple PHYs being attached to the same MAC.

V18 is a simple rebase of the V17 on top of net-next, gathering the
tested-by and reviewed-by tags from Christophe (thanks !).

This iteration is also one patch shorter than V17 (patch 12/14 in V17 is gone),
as one of the patches used to fix an issue that has now been resolved by
Simon Horman in 

743ff02152bc ethtool: Don't check for NULL info in prepare_data callbacks

As a remainder, here's what the PHY listings would look like :
 - eth0 has a 88x3310 acting as media converter, and an SFP module with
   an embedded 88e1111 PHY
 - eth2 has a 88e1510 PHY

# ethtool --show-phys *

PHY for eth0:
PHY index: 1
Driver name: mv88x3310
PHY device name: f212a600.mdio-mii:00
Downstream SFP bus name: sfp-eth0
Upstream type: MAC

PHY for eth0:
PHY index: 2
Driver name: Marvell 88E1111
PHY device name: i2c:sfp-eth0:16
Upstream type: PHY
Upstream PHY index: 1
Upstream SFP name: sfp-eth0

PHY for eth2:
PHY index: 1
Driver name: Marvell 88E1510
PHY device name: f212a200.mdio-mii:00
Upstream type: MAC

Ethtool patches : https://github.com/minimaxwell/ethtool/tree/mc/topo-v16
(this branch is compatible with this V18 series)

Link to V17: https://lore.kernel.org/netdev/20240709063039.2909536-1-maxime.chevallier@bootlin.com/
Link to V16: https://lore.kernel.org/netdev/20240705132706.13588-1-maxime.chevallier@bootlin.com/
Link to V15: https://lore.kernel.org/netdev/20240703140806.271938-1-maxime.chevallier@bootlin.com/
Link to V14: https://lore.kernel.org/netdev/20240701131801.1227740-1-maxime.chevallier@bootlin.com/
Link to V13: https://lore.kernel.org/netdev/20240607071836.911403-1-maxime.chevallier@bootlin.com/
Link to v12: https://lore.kernel.org/netdev/20240605124920.720690-1-maxime.chevallier@bootlin.com/
Link to v11: https://lore.kernel.org/netdev/20240404093004.2552221-1-maxime.chevallier@bootlin.com/
Link to V10: https://lore.kernel.org/netdev/20240304151011.1610175-1-maxime.chevallier@bootlin.com/
Link to V9: https://lore.kernel.org/netdev/20240228114728.51861-1-maxime.chevallier@bootlin.com/
Link to V8: https://lore.kernel.org/netdev/20240220184217.3689988-1-maxime.chevallier@bootlin.com/
Link to V7: https://lore.kernel.org/netdev/20240213150431.1796171-1-maxime.chevallier@bootlin.com/
Link to V6: https://lore.kernel.org/netdev/20240126183851.2081418-1-maxime.chevallier@bootlin.com/
Link to V5: https://lore.kernel.org/netdev/20231221180047.1924733-1-maxime.chevallier@bootlin.com/
Link to V4: https://lore.kernel.org/netdev/20231215171237.1152563-1-maxime.chevallier@bootlin.com/
Link to V3: https://lore.kernel.org/netdev/20231201163704.1306431-1-maxime.chevallier@bootlin.com/
Link to V2: https://lore.kernel.org/netdev/20231117162323.626979-1-maxime.chevallier@bootlin.com/
Link to V1: https://lore.kernel.org/netdev/20230907092407.647139-1-maxime.chevallier@bootlin.com/

More discussions on specific issues that happened in 6.9-rc:

https://lore.kernel.org/netdev/20240412104615.3779632-1-maxime.chevallier@bootlin.com/
https://lore.kernel.org/netdev/20240429131008.439231-1-maxime.chevallier@bootlin.com/
https://lore.kernel.org/netdev/20240507102822.2023826-1-maxime.chevallier@bootlin.com/

Thanks,

Maxime

Maxime Chevallier (13):
  net: phy: Introduce ethernet link topology representation
  net: sfp: pass the phy_device when disconnecting an sfp module's PHY
  net: phy: add helpers to handle sfp phy connect/disconnect
  net: sfp: Add helper to return the SFP bus name
  net: ethtool: Allow passing a phy index for some commands
  netlink: specs: add phy-index as a header parameter
  net: ethtool: Introduce a command to list PHYs on an interface
  netlink: specs: add ethnl PHY_GET command set
  net: ethtool: plca: Target the command to the requested PHY
  net: ethtool: pse-pd: Target the command to the requested PHY
  net: ethtool: cable-test: Target the command to the requested PHY
  net: ethtool: strset: Allow querying phy stats by index
  Documentation: networking: document phy_link_topology

 Documentation/netlink/specs/ethtool.yaml      |  58 ++++
 Documentation/networking/ethtool-netlink.rst  |  51 +++
 Documentation/networking/index.rst            |   1 +
 .../networking/phy-link-topology.rst          | 121 +++++++
 MAINTAINERS                                   |   1 +
 drivers/net/phy/Makefile                      |   2 +-
 drivers/net/phy/marvell-88x2222.c             |   2 +
 drivers/net/phy/marvell.c                     |   2 +
 drivers/net/phy/marvell10g.c                  |   2 +
 drivers/net/phy/phy_device.c                  |  48 +++
 drivers/net/phy/phy_link_topology.c           | 105 ++++++
 drivers/net/phy/phylink.c                     |   3 +-
 drivers/net/phy/qcom/at803x.c                 |   2 +
 drivers/net/phy/qcom/qca807x.c                |   2 +
 drivers/net/phy/sfp-bus.c                     |  26 +-
 include/linux/netdevice.h                     |   4 +-
 include/linux/phy.h                           |   6 +
 include/linux/phy_link_topology.h             |  82 +++++
 include/linux/sfp.h                           |   8 +-
 include/uapi/linux/ethtool.h                  |  16 +
 include/uapi/linux/ethtool_netlink.h          |  20 ++
 net/core/dev.c                                |  15 +
 net/ethtool/Makefile                          |   3 +-
 net/ethtool/cabletest.c                       |  35 +-
 net/ethtool/netlink.c                         |  66 +++-
 net/ethtool/netlink.h                         |  33 ++
 net/ethtool/phy.c                             | 308 ++++++++++++++++++
 net/ethtool/plca.c                            |  30 +-
 net/ethtool/pse-pd.c                          |  31 +-
 net/ethtool/strset.c                          |  24 +-
 30 files changed, 1056 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/networking/phy-link-topology.rst
 create mode 100644 drivers/net/phy/phy_link_topology.c
 create mode 100644 include/linux/phy_link_topology.h
 create mode 100644 net/ethtool/phy.c

-- 
2.45.2


