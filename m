Return-Path: <netdev+bounces-188288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9ACDAABFE1
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 11:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4DBB1C21C9B
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 09:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB232638BA;
	Tue,  6 May 2025 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VBIhv31d"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E4422B8C1;
	Tue,  6 May 2025 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746524347; cv=none; b=QIlv6P+j2v6LlWtq8+jUsrkow0YuaJWrKqTJqcTRdX3Qn4pPjFvkWWymtVZtkYuFZoJldkM07nJCACfgxm5M90Ka7ZxT4dfk96TMYg4JAy8z+rNcBSod/sPbGSZASDpq4BOhrUO02jphGyCV65tMrCoCQodhTr/1e9Vf05xzPlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746524347; c=relaxed/simple;
	bh=QDM1bqICPQYf7DpQoqPRRjApTtkwGcGs861cisFqjrY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Scw9v/jqF8uaGtazmmwwzJx5AFVKu0nhXitrxRXNeNWUu9BGbp8s/E1ltKvgjO0cic/KKwxzMKuKUuQ6bQsNezs/WtK+20hsjefhl3Q9g3V0M88tNVRybbLZ4+aI9Rs8uJ+X0hSKcQxzSXXp+5J0RcdzmwSbBvO7bfnNbAmINCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VBIhv31d; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 77DE24330F;
	Tue,  6 May 2025 09:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746524342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fbqQiBVtDVItrZyVGcqryiKo8QlnEusljy5DonbWuOc=;
	b=VBIhv31dKQhx5Y9V/dmw1DvJa/KOac/DrYH/xeqoa2G2qplC9bSa0QU9lRmT4UA/kKYsx7
	L2sq+4qesleLcU/9OPF2rPgi8b5GD3izDyEcE04gJcZ3FhF64mgYg6lab+MiLk5NkB+hRO
	c0MeNILzPYVyH0aj6ObY6vZqes7mFEkyeMSPfo3oZIYmar4muwtTRxxNfeAGlqQ22f/ocC
	9pyKKWh+DvASdrByn0QwItqMRgLJ8L/sdj9Eq7Rg0C4FLsaWELa5je9d6C3OSX5pM3cBzD
	LnaxxntHtBQ8qVBMDbBBgHbsZF5Yqk9Ulr1F2ci5J2+dq0RAKPpf9C7qLkN5Fw==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH net-next v10 00/13] Add support for PSE budget evaluation
 strategy
Date: Tue, 06 May 2025 11:38:32 +0200
Message-Id: <20250506-feature_poe_port_prio-v10-0-55679a4895f9@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJjYGWgC/3XRzWrDMAwA4FcZPi/Dkv932nuMUTxbXg1bXJwsd
 JS++5zAaFnwQQdL+LMsXdhENdPEnh8urNKSp1zGdgD++MDC0Y8fNOTYEgw5Su5ADIn8/F3pcCp
 r1PlwqrkMXoGnaIRACqzdPVVK+bzBr2ykeRjpPLO3VjnmaS71Z3txga2+2sA5duwFBj4Ya7iSy
 UiK6uW9lPkzj0+hfG3mgneO4D0Hm+OUchqRSBq/d8TNAYSeI5pjBTqXvHbahL0j/xzFW0M9RzY
 nBgdeBB7Amr2jbg6C7TmqOSJ6aTWpFLXcO+bmSN51zDqfpFJw1H4X4t6xdw7onmObI6UOwsUgj
 LB7x9052N27Wx0wKXBulMF//Vyv11+j9BmYvwIAAA==
To: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, 
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, 
 Dent Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev-8cb71
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefieegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgvfevofesthekredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeduhfevudetfffgkedvhfevheeghedtleeghfffudeiffefvdehfeegieeivdekteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdekpdhrtghpthhtoheplhhgihhrugifohhougesghhmrghilhdrtghomhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghnthhprhhojhgvtghtsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrt
 ghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
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
Patches 6-8: Add support for budget evaluation strategy in PSE core,
	     ethtool and ethtool specs.
Patches 9-11: Add support for port priority and power supplies in PD692x0
	      drivers.
Patches 12,13: Add support for port priority in TPS23881 drivers.

Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
---
Changes in v10:
- Change patch 2 and 7 due to possible used after free scenario or
  deadlock scenario. Move the PSE notification send management to a
  workqueue to protect it from the deadlock scenario.
- Link to v9: https://lore.kernel.org/r/20250422-feature_poe_port_prio-v9-0-417fc007572d@bootlin.com

Changes in v9:
- Add a missing check after skb creation.
- Link to v8: https://lore.kernel.org/r/20250416-feature_poe_port_prio-v8-0-446c39dc3738@bootlin.com

Changes in v8:
- Rename a few functions for better clarity.
- Add missing kref_init in PSE power domain support and a wrong error
  check condition.
- Link to v7: https://lore.kernel.org/r/20250408-feature_poe_port_prio-v7-0-9f5fc9e329cd@bootlin.com

Changes in v7:
- Add reference count and mutex lock for PSE power domain.
- Add support to retry enabling port that failed to be powered in case of
  port disconnection or priority change.
- Use flags definition for pse events in ethtool specs.
- Small changes in the TPS23881 driver.
- Link to v6: https://lore.kernel.org/r/20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com

Changes in v6:
- Few typos.
- Use uint instead of bitset for PSE_EVENT.
- Remove report of budget evaluation strategy in the uAPI.
- Link to v5: https://lore.kernel.org/r/20250218-feature_poe_port_prio-v5-0-3da486e5fd64@bootlin.com

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
Kory Maincent (13):
      net: ethtool: Add support for ethnl_info_init_ntf helper function
      net: pse-pd: Add support for reporting events
      net: pse-pd: tps23881: Add support for PSE events and interrupts
      net: pse-pd: Add support for PSE power domains
      net: ethtool: Add support for new power domains index description
      net: pse-pd: Add helper to report hardware enable status of the PI
      net: pse-pd: Add support for budget evaluation strategies
      net: ethtool: Add PSE port priority support feature
      net: pse-pd: pd692x0: Add support for PSE PI priority feature
      net: pse-pd: pd692x0: Add support for controller and manager power supplies
      dt-bindings: net: pse-pd: microchip,pd692x0: Add manager regulator supply
      net: pse-pd: tps23881: Add support for static port priority feature
      dt-bindings: net: pse-pd: ti,tps23881: Add interrupt description

 .../bindings/net/pse-pd/microchip,pd692x0.yaml     |   22 +-
 .../bindings/net/pse-pd/ti,tps23881.yaml           |    8 +
 Documentation/netlink/specs/ethtool.yaml           |   47 +
 Documentation/networking/ethtool-netlink.rst       |   49 +
 drivers/net/mdio/fwnode_mdio.c                     |   26 +-
 drivers/net/pse-pd/pd692x0.c                       |  225 +++++
 drivers/net/pse-pd/pse_core.c                      | 1043 +++++++++++++++++++-
 drivers/net/pse-pd/tps23881.c                      |  404 +++++++-
 include/linux/ethtool_netlink.h                    |    9 +
 include/linux/pse-pd/pse.h                         |  107 +-
 include/uapi/linux/ethtool.h                       |   34 +
 include/uapi/linux/ethtool_netlink_generated.h     |   12 +
 net/ethtool/netlink.c                              |    7 +-
 net/ethtool/netlink.h                              |    2 +
 net/ethtool/pse-pd.c                               |   69 ++
 15 files changed, 2009 insertions(+), 55 deletions(-)
---
base-commit: bcf543098a79710257e5c1ee8d7f7dd1865c6b02
change-id: 20240913-feature_poe_port_prio-a51aed7332ec

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com


