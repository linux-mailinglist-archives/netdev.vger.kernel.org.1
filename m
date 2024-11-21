Return-Path: <netdev+bounces-146653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3155E9D4ED1
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 15:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A50281213
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 14:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA81F1DA10A;
	Thu, 21 Nov 2024 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bR8dNz7D"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67B11D363F;
	Thu, 21 Nov 2024 14:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200222; cv=none; b=HYpl77So2EhzNtf97OYLbivG6JRy8TzGwbp+oioIVRS6xERl7cy0Nkeht4WHDd8O/qL4OJHh95eP/9/FDk+5P7EhytkUKoYtIrxW66f85ny0DrROakIWHgdX2sezIXigeuUi2cGWhGXe72ar81xeU4AXXt436o0wrG7B7CYZcRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200222; c=relaxed/simple;
	bh=wQ3Os+03CcRx0xVepGaQMA8S/8BrHZGa6BmF0yYWR08=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rebjWdgVHkTzbDRCYGUeTWp02ymlm0pd1lNjQhPdhBIbgKAc1Yb2jm5dwibB+Jr67h5oPu1Fdy1TKnKDXlWwHH2qjWLgF1QEh4bkO8YRMCRftDEV3TH3eMHkmHdypO3Yzytg0aX8kJyRU+Zmyhz9mrloUSZnMNGT7hc0qnr4lRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bR8dNz7D; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 63DFD40008;
	Thu, 21 Nov 2024 14:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732200211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x4b6/euJDp2S7lOWJckp9gGqdxtH6KO6DXDuQOcA8m0=;
	b=bR8dNz7DJkfbTVqrn9WGnrkunKJAYHrxoKdYuFN1j1YZhi4W+ukel4Bm7/P+yfRst6XEbF
	8jHYLV2C21Tiy9dTmQp35sQ4kBinXg3mMAPUFEbO6spYIy15k1huhUGVBBnwa1Ii7MHRF7
	+N9EFxdiN0h/3Dwz9y4Ynk7R8tHpjWU2Xe9/rhebUM6znGaTt3/a8h1jJ2oeUc0vR2QbDf
	toDI2Hr5oKaXhn69e+Ov6qFvT+TQiy9NZNHqD1bkt39hlvyVCryRJpL9cJxkEnvpB87/18
	LO0uVyjGCFE6eI5AtNeSaywXGuUJStULayuVa4vUwMEci/g2GjrY0w2wrfP+lQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH RFC net-next v3 00/27] Add support for PSE port priority
Date: Thu, 21 Nov 2024 15:42:26 +0100
Message-Id: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANNGP2cC/3XNTQrCMBAF4KuUrI3kpzHWlSB4ALciJbZTG9CkJ
 DFUSu9umpUuupjFY958MyEPToNHh2JCDqL22poU+KZATa/MA7BuU0aMsJJUlOMOVHg7qAe7jAv
 14LTFSlAFreScQYPS7eCg02N2r+hyPhUGAjYwBnRL2177YN0nP400dxafEsJW/EgxwXIviSg7W
 UIrjndrw1ObbWNf2Yzsx+FkzWHJqYSodowBlFL9O/M8fwGGENpdEgEAAA==
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This series brings support for port priority in the PSE subsystem.
PSE controllers can set priorities to decide which ports should be
turned off in case of special events like over-current.

I have added regulator maintainers to have their opinion on adding power
budget regulator constraint see patches 16 and 17.
There are also a few core regulator change along the way, patch 3 and 15.
Not sure if they have to be sent with the Fixes tag.
Also, I suppose I will need to merge them through the regulator tree.
Will it be possible to create an immutable tag to have this PSE series
based on them?

This patch series adds support for two mode port priority modes.
1. Static Method:

   This method involves distributing power based on PD classification.
   It’s straightforward and stable, the PSE core keeping track of the
   budget and subtracting the power requested by each PD’s class.

   Advantages: Every PD gets its promised power at any time, which
   guarantees reliability.

   Disadvantages: PD classification steps are large, meaning devices
   request much more power than they actually need. As a result, the power
   supply may only operate at, say, 50% capacity, which is inefficient and
   wastes money.

2. Dynamic Method:

   To address the inefficiencies of the static method, vendors like
   Microchip have introduced dynamic power budgeting, as seen in the
   PD692x0 firmware. This method monitors the current consumption per port
   and subtracts it from the available power budget. When the budget is
   exceeded, lower-priority ports are shut down.

   Advantages: This method optimizes resource utilization, saving costs.

   Disadvantages: Low-priority devices may experience instability.

The UAPI allows adding support for software port priority mode managed from
userspace later if needed.

This patch series is currently not fully tested. I would appreciate your
feedback on the current implementation of port priority in the PSE core.

Several Reviewed-by have been removed due to the changes.

Thanks Oleksij for your pointers.

Patches 1-7: Cosmetics.
Patch 8: Adds support for last supported features in the TPS23881 drivers.
Patches 9,10: Add support for PSE index in PSE core and ethtool.
Patches 11-13: Add support for interrupt event report in PSE core, ethtool
	     and ethtool specs.
Patch 14: Adds support for interrupt and event report in TPS23881 driver.
Patch 15: Fix regulator resolve supply
Patches 16,17: Add support for power budget in regulator framework.
Patch 18: Cosmetic.
Patches 19,20: Add support for PSE power domain in PSE core and ethtool.
Patches 21-23: Add support for port priority in PSE core, ethtool and
	       ethtool specs.
Patches 24,25: Add support for port priority in PD692x0 drivers.
Patches 26,27: Add support for port priority in TPS23881 drivers.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Changes in v3:
- Move power budget to regulator core.
- Add disconnection policies with PIs using the same priority.
- Several fixes on the TPS23881 drivers.
- Several new cosmetic patches.
- Link to v2: https://lore.kernel.org/r/20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com

Changes in v2:
- Rethink the port priority management.
- Add PSE id.
- Add support for PSE power domains.
- Add get power budget regulator constraint.
- Link to v1: https://lore.kernel.org/r/20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com

---
Kory Maincent (26):
      net: pse-pd: Remove unused pse_ethtool_get_pw_limit function declaration
      regulator: core: Ignore unset max_uA constraints in current limit check
      net: pse-pd: Avoid setting max_uA in regulator constraints
      net: pse-pd: Add power limit check
      net: pse-pd: tps23881: Simplify function returns by removing redundant checks
      net: pse-pd: tps23881: Add missing configuration register after disable
      net: pse-pd: tps23881: Add support for power limit and measurement features
      net: pse-pd: Add support for PSE device index
      net: ethtool: Add support for new PSE device index description
      net: ethtool: Add support for ethnl_info_init_ntf helper function
      net: pse-pd: Add support for reporting events
      netlink: specs: Add support for PSE netlink notifications
      net: pse-pd: tps23881: Add support for PSE events and interrupts
      regulator: core: Resolve supply using of_node from regulator_config
      regulator: Add support for power budget description
      regulator: dt-bindings: Add regulator-power-budget property
      net: pse-pd: Fix missing PI of_node description
      net: pse-pd: Add support for PSE power domains
      net: ethtool: Add support for new power domains index description
      net: pse-pd: Add support for getting and setting port priority
      net: ethtool: Add PSE new port priority support feature
      netlink: specs: Expand the PSE netlink command with newly supported features
      net: pse-pd: pd692x0: Add support for PSE PI priority feature
      dt-bindings: net: pse-pd: microchip,pd692x0: Add manager regulator supply
      net: pse-pd: tps23881: Add support for static port priority feature
      dt-bindings: net: pse-pd: ti,tps23881: Add interrupt description

Kory Maincent (Dent Project) (1):
      net: pse-pd: tps23881: Use helpers to calculate bit offset for a channel

 .../bindings/net/pse-pd/microchip,pd692x0.yaml     |  12 +-
 .../bindings/net/pse-pd/ti,tps23881.yaml           |   6 +
 .../devicetree/bindings/regulator/regulator.yaml   |   3 +
 Documentation/netlink/specs/ethtool.yaml           |  59 ++
 Documentation/networking/ethtool-netlink.rst       |  85 +++
 drivers/net/mdio/fwnode_mdio.c                     |  26 +-
 drivers/net/pse-pd/pd692x0.c                       | 183 +++++
 drivers/net/pse-pd/pse_core.c                      | 798 +++++++++++++++++++-
 drivers/net/pse-pd/tps23881.c                      | 833 +++++++++++++++++++--
 drivers/regulator/core.c                           | 134 +++-
 drivers/regulator/of_regulator.c                   |   3 +
 include/linux/ethtool_netlink.h                    |   9 +
 include/linux/pse-pd/pse.h                         |  91 ++-
 include/linux/regulator/consumer.h                 |  21 +
 include/linux/regulator/driver.h                   |   2 +
 include/linux/regulator/machine.h                  |   2 +
 include/uapi/linux/ethtool.h                       |  84 +++
 include/uapi/linux/ethtool_netlink.h               |  18 +
 net/ethtool/netlink.c                              |   5 +
 net/ethtool/netlink.h                              |   2 +
 net/ethtool/pse-pd.c                               | 123 +++
 21 files changed, 2391 insertions(+), 108 deletions(-)
---
base-commit: 057623b3f6568e5f5c23ae26f6bf3eb367597e03
change-id: 20240913-feature_poe_port_prio-a51aed7332ec

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


