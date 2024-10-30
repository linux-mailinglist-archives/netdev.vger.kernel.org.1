Return-Path: <netdev+bounces-140472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9AEE9B69BE
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89737282B73
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 16:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6C2219C82;
	Wed, 30 Oct 2024 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KgLcdbaY"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1CF218D8B;
	Wed, 30 Oct 2024 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307243; cv=none; b=snfMiZdBFfUSMWcdXxOJFrRqT8jyHrLvClajxYJRMVg+Row5IlZbOaXP1d033by/e5VIC0HWVjQB39kLgpkhwCHz4uq9qo5kwf+1KGEWgC4VJ7Ah3GSCsW91lN48PKZ43MnLGIK7EXKVY9C/W1PAM53RkwGvsb9iJA0HxicGTSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307243; c=relaxed/simple;
	bh=3XsbbW4sr4SJSBoaNnKi5Q9cIfnZzEuphOmXvS46jww=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N2N3Wtp7IhJRaRX1OARJCcuznF7i57m1qSb/t7GaugROWCura/YYLt4ZPKOHyt0dN4guWuoVKOK6gr9/kDHrGKl+u+xRu9L1JA5o9Ns7o7W4Xpu+EsR/GMPEZzoesAh/93nuvIbFmnkBhGBSVm5PkEAI/KR8uZMbcYawlo3NRXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KgLcdbaY; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5EE15C0008;
	Wed, 30 Oct 2024 16:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730307232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7j2sBWY5RXFhC8oixeSMD8lLx9ABilvNsg/ZOsTJzYM=;
	b=KgLcdbaY0O9EDEA0St6+bMizfFt2hty/9KKyDKFKvm1D7mttcpsmHb4W1jhqDFI/ApcrPd
	Z6/i1SgYiEpN/i2JIzftPn5McUDpyWP7RUByh7ffkyNAvc+1/mkv6SGbJ/TdE2hE7H6I88
	Wr25Ds1fKT9dDeB9BOa7TwSVek5j2OA9IaYsNkMmg0vyTBEKFXPufCWc805rSLKNAsIJQE
	UYGIzrguAOKspgYKnlvgR0IqiSOslCR7fPQn5lk4Izq0C0qs0xKHghvIiHLl/lf4c5LO6D
	4D40hjVx7fKCXvRogyUapYgSdkMFxMTX7bEWGLBbfFxhOp+Om86raqUBF53S4Q==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH RFC net-next v2 00/18] Add support for PSE port priority
Date: Wed, 30 Oct 2024 17:53:02 +0100
Message-Id: <20241030-feature_poe_port_prio-v2-0-9559622ee47a@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAG9kImcC/3WNwQrCMBBEf6Xs2UiStkQ9CYIf4FVKie3WLmi2J
 LFUSv/dtHcPcxhm5s0MAT1hgFM2g8eRArFLRu8yaHrrniioTR601IU8qlx0aOPHYz3wKh/rwRM
 LWyqLrclzjQ2k7eCxo2nj3uF2vWQOo3A4RahS2lOI7L/b6ai2zspXUuo//FEJKczByLLoTIFte
 X4wxxe5fcNvqJZl+QEZBxdzygAAAA==
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
budget regulator constraint see patches 11 and 12.

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

This patch series is currently untested and still lacks driver-level
support for port priority. I would appreciate your feedback on the current
implementation of port priority in the PSE core before proceeding further.

Several Reviewed-by have been removed due to the changes.

Thanks Oleksij for your pointers.

Patches 1-3: Cosmetics.
Patch 4: Adds support for last supported features in the TPS23881 drivers.
Patches 5,6: Add support for PSE index in PSE core and ethtool.
Patches 7-9: Add support for interrupt event report in PSE core, ethtool
	     and ethtool specs.
Patch 10: Adds support for interrupt and event report in TPS23881 driver.
Patches 11,12: Add support for power budget in regulator framework.
Patches 13,14: Add support for PSE power domain in PSE core and ethtool.
Patches 15-17: Add support for port priority in PSE core, ethtool and
	       ethtool specs.
Patches 18: Add support for port priority in PD692x0 drivers.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Changes in v2:
- Rethink the port priority management.
- Add PSE id.
- Add support for PSE power domains.
- Add get power budget regulator constraint.
- Link to v1: https://lore.kernel.org/r/20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com

---
Kory Maincent (18):
      net: pse-pd: Remove unused pse_ethtool_get_pw_limit function declaration
      net: pse-pd: tps23881: Simplify function returns by removing redundant checks
      net: pse-pd: tps23881: Use helpers to calculate bit offset for a channel
      net: pse-pd: tps23881: Add support for power limit and measurement features
      net: pse-pd: Add support for PSE device index
      net: ethtool: Add support for new PSE device index description
      net: ethtool: Add support for ethnl_info_init_ntf helper function
      net: pse-pd: Add support for reporting events
      netlink: specs: Add support for PSE netlink notifications
      net: pse-pd: tps23881: Add support for PSE events and interrupts
      regulator: Add support for power budget description
      regulator: dt-bindings: Add regulator-power-budget property
      net: pse-pd: Add support for PSE power domains
      net: ethtool: Add support for new power domains index description
      net: pse-pd: Add support for getting and setting port priority
      net: ethtool: Add PSE new port priority support feature
      netlink: specs: Expand the PSE netlink command with newly supported features
      net: pse-pd: pd692x0: Add support for PSE PI priority feature

 .../devicetree/bindings/regulator/regulator.yaml   |   3 +
 Documentation/netlink/specs/ethtool.yaml           |  53 ++
 Documentation/networking/ethtool-netlink.rst       |  71 +++
 drivers/net/mdio/fwnode_mdio.c                     |  26 +-
 drivers/net/pse-pd/pd692x0.c                       |  24 +
 drivers/net/pse-pd/pse_core.c                      | 568 ++++++++++++++++++++-
 drivers/net/pse-pd/tps23881.c                      | 529 ++++++++++++++++---
 drivers/regulator/core.c                           |  11 +
 drivers/regulator/of_regulator.c                   |   3 +
 include/linux/ethtool_netlink.h                    |   9 +
 include/linux/pse-pd/pse.h                         |  75 ++-
 include/linux/regulator/consumer.h                 |   6 +
 include/linux/regulator/machine.h                  |   2 +
 include/uapi/linux/ethtool.h                       |  35 ++
 include/uapi/linux/ethtool_netlink.h               |  17 +
 net/ethtool/netlink.c                              |   5 +
 net/ethtool/netlink.h                              |   2 +
 net/ethtool/pse-pd.c                               |  93 ++++
 18 files changed, 1442 insertions(+), 90 deletions(-)
---
base-commit: 982a5437362e09def6c3152a9ec1392b9da16ece
change-id: 20240913-feature_poe_port_prio-a51aed7332ec

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


