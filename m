Return-Path: <netdev+bounces-167402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBE1A3A274
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 17:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 112667A175D
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 16:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D384E26B0A1;
	Tue, 18 Feb 2025 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZhG8Hg58"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45EF198E60;
	Tue, 18 Feb 2025 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895563; cv=none; b=leoX1xJvbR6WD4C0F8S1+BIJDLMNH0vt9XjlRFu8KUlzh+oUsJ2vifNgYbVFFhcctkPX2R3HwUacgpLnU46ekKB2OAhJq9Naz+nHaNMETtCDBbZH9dWsUSnMXWAIxv/eB7NRjApI3mYtvZC7kkeViL1q+sl4q8IPWrQyghcz+0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895563; c=relaxed/simple;
	bh=P3/hlFGBUKN2E6uNsjPu4wXSGA9mNXfBrD6OO244ki4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Jcp+jNWpi0NUmbxnH8zTd0+7iUVrs2mTyrd2TQlmCLROFB5+qBpG/JaChEHYp1yqbXj1+IYPd1uhyAmEhi22egX6beNMRbZ58v71ra5+yVPA4GNjhjvVyvz0wcQQKxvPPgbakmBlRXUDCdfbzh9ht0vpfKmDc/kATk9bdpuYGHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZhG8Hg58; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 428C444310;
	Tue, 18 Feb 2025 16:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739895553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+/0HrgwbqBg1tqYj90mQpDYOO09Zph7T3utWKyj8VQg=;
	b=ZhG8Hg58RjxOlm8/JF87g82qAe53grlcq/fyTkS9LwRW3X4bwc5H0ZGRCgpjE9V3mxPp37
	byAZbqMrlmFOALxWhnoIVMVPEgbfBOfVktFNBZXrvRbXD43q7t+qBFHMpvBJDqpLa6dQJB
	9RgxhT+cakzWyLW+cFBYcEMeNDt3hl3yKKVpomW3BodEBlD1vVbYBJuuA1EHrpMubV4Vyz
	ovnTo4uNsF8vCTxkEKy3Qt2BTMGWjdy+4MP6QxasCRC3HQ7KRMguDMtmWxbUl5fldS0O0A
	rqAh5C06cLgh3GI185fD+6aUxUqNNkrb7v4Cweeo8YL2XRZ8S/LKxB4l29s/bQ==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v5 00/12] Add support for PSE budget evaluation
 strategy
Date: Tue, 18 Feb 2025 17:19:04 +0100
Message-Id: <20250218-feature_poe_port_prio-v5-0-3da486e5fd64@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPiytGcC/3XOwWrDMAwG4FcpPs9Dku047mnvMUbxHGU1bHZwv
 NBR8u5zA2MbJQcdfn70SVcxc4k8i+PhKgovcY45tWAeDiKcfXpjGYeWBQFpcKjkyL5+Fj5N+Ta
 lnqYSs/QGPQ9WKeIg2u5UeIyXzX0WiatMfKnipTXnONdcvraDC279zUYA2rEXlCBtb8Ho0Woez
 NNrzvU9pseQPzZzoT+Ogj2HmuOMcR0Rs7b+3lG/DhLuOao5vSLnRt+5zoZ7R/84BtpDe45uzhA
 cehUgYG//O+u6fgPAr0WMngEAAA==
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.15-dev-8cb71
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudejjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtkeertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudfhveduteffgfekvdfhveehgeehtdelgefhffduiefffedvheefgeeiiedvkeetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdtudemfedtheefmegrvdeiieemlegviegvmeeliegsudemvggsugelmehftdgrgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggstddumeeftdehfeemrgdvieeimeelvgeivgemleeisgdumegvsgguleemfhdtrgegpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvhedprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepuggvnhhtphhrohhjvggttheslhhinhhugihfohhunhgurghtihhonhdrohhrg
 hdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlsehpvghnghhuthhrohhnihigrdguvg
X-GND-Sasl: kory.maincent@bootlin.com

From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>

This series brings support for budget evaluation strategy in the PSE
subsystem. PSE controllers can set priorities to decide which ports should
be turned off in case of special events like over-current.

This patch series adds support for two budget evaluation strategy.
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

Patches 1-2: Add support for interrupt event report in PSE core, ethtool
	     and ethtool specs.
Patch 3: Adds support for interrupt and event report in TPS23881 driver.
Patches 4,5: Add support for PSE power domain in PSE core and ethtool.
Patches 6,7: Add support for budget evaluation strategy in PSE core,
	     ethtool and ethtool specs.
Patches 8-10: Add support for port priority and power supplies in PD692x0
	      drivers.
Patches 11,12: Add support for port priority in TPS23881 drivers.

Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
---
Changes in v5:
- Remove the first part of the patch series which tackled PSE
  improvement and already gets merged:
  https://lore.kernel.org/netdev/20250110-b4-feature_poe_arrange-v3-0-142279aedb94@bootlin.com/
- Remove the PSE index support which is useless for now. The PSE power
  domain ID is sufficient.
- Add support for PD692x0 power supplies other than Vmain which was already
  in the patch series.
- Few other small fixes.
- Link to v4: https://lore.kernel.org/r/20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com

Changes in v4:
- Remove disconnection policy.
- Rename port priority mode to budget evaluation strategy.
- Add cosmetic changes in PSE core.
- Add support for port priority in PD692x0 driver.
- Link to v3: https://lore.kernel.org/r/20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com

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
Kory Maincent (12):
      net: ethtool: Add support for ethnl_info_init_ntf helper function
      net: pse-pd: Add support for reporting events
      net: pse-pd: tps23881: Add support for PSE events and interrupts
      net: pse-pd: Add support for PSE power domains
      net: ethtool: Add support for new power domains index description
      net: pse-pd: Add support for budget evaluation strategies
      net: ethtool: Add PSE new budget evaluation strategy support feature
      net: pse-pd: pd692x0: Add support for PSE PI priority feature
      net: pse-pd: pd692x0: Add support for controller and manager power supplies
      dt-bindings: net: pse-pd: microchip,pd692x0: Add manager regulator supply
      net: pse-pd: tps23881: Add support for static port priority feature
      dt-bindings: net: pse-pd: ti,tps23881: Add interrupt description

 .../bindings/net/pse-pd/microchip,pd692x0.yaml     |  22 +-
 .../bindings/net/pse-pd/ti,tps23881.yaml           |   8 +
 Documentation/netlink/specs/ethtool.yaml           |  47 ++
 Documentation/networking/ethtool-netlink.rst       |  90 +++
 drivers/net/mdio/fwnode_mdio.c                     |  26 +-
 drivers/net/pse-pd/pd692x0.c                       | 225 ++++++
 drivers/net/pse-pd/pse_core.c                      | 865 ++++++++++++++++++++-
 drivers/net/pse-pd/tps23881.c                      | 364 ++++++++-
 include/linux/ethtool_netlink.h                    |   9 +
 include/linux/pse-pd/pse.h                         |  74 +-
 include/uapi/linux/ethtool.h                       |  54 ++
 include/uapi/linux/ethtool_netlink_generated.h     |  14 +
 net/ethtool/common.c                               |  12 +
 net/ethtool/common.h                               |   2 +
 net/ethtool/netlink.c                              |   7 +-
 net/ethtool/netlink.h                              |   2 +
 net/ethtool/pse-pd.c                               |  86 ++
 net/ethtool/strset.c                               |   5 +
 18 files changed, 1860 insertions(+), 52 deletions(-)
---
base-commit: 5791c4c734f26b933e6272a88bbf3753b85292ef
change-id: 20240913-feature_poe_port_prio-a51aed7332ec

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


