Return-Path: <netdev+bounces-83751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0988F893B82
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 15:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE601C213C6
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 13:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE963F9C1;
	Mon,  1 Apr 2024 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="W+PvOM2n"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9355A3FB29
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 13:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711978573; cv=none; b=sLGgxORWBK8rsgPaCtsiyYJFt84irdqE6+bZ/D7tuGveQaHBUve6LHwr3lp+nSoXTBZxJ652UfGjlTezqSBwww3ydWeyIf8tvijtIe7Y6gczeCivadyEGUklwjeHomHLBXk4yXua4aiozblFDFKCCdImyXORTGzrnxQSj9ORCyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711978573; c=relaxed/simple;
	bh=mYbuQUeH+lPyJOXPMzRW3G6j0A56FmGE36w1b1Y60No=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n60GpmFga7Lf4KKCOrAfU76nR7KMFueTBUf4TRJatZ1mSmBNRWu/acZF6qShZMj7HuVPBFWbfh94LMJhnofP08EAg6jpFOEDeRgondfumxsJiRzY2hQaiJOGN2RW0H85isasijjnTJKyzrYHgD8MH7CMbeGurR2v7zInQOdFjcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=W+PvOM2n; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YgQemtD8P9XGaCMTQPf5+967fImee2KBzCljkp51IZI=; b=W+PvOM2nb3MBhEgmrNp1tQXMLm
	bfEgkY/W+PI1UvMnWTAUsXTkGbBg5YSLzaeBWbvUz0p8L1RIrSTalEZ5TsMf1+pJFiSqBXN0lNo3w
	e8rVNpV/673U5I+eihAuNI115lmKPJDsQNBxHaQPO+dtxd/BglAiJcgx7g/ibwk/KCqA=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rrHpV-00BrFx-Ck; Mon, 01 Apr 2024 15:36:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v3 0/7] net: Add generic support for netdev LEDs
Date: Mon, 01 Apr 2024 08:35:45 -0500
Message-Id: <20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-0-221b3fa55f78@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADG4CmYC/42NQQ6CMBBFr0K6dkxpoQVX3sO4oO0gTbCYFpsaw
 t1tiEaXLGbx8zLvLSSgtxjIqViIx2iDnVwe/FAQPXTuhmBN3oRRVlFeCogCGqDgcM6XZrjHpkG
 RUoIRTYBYQaekNJKbmnUVyZ6Hx96mrXEh3z9yzWSwYZ78a4vHcuOfjtzRiWXmDe0qFFqwluN5f
 Dp31MPmjuzPx+keH8u817VC1faodP3zrev6Bgr3jN0qAQAA
To: Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Gregory Clement <gregory.clement@bootlin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3046; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=mYbuQUeH+lPyJOXPMzRW3G6j0A56FmGE36w1b1Y60No=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBmCrg45sMwP9/j1khwSlrjXU5nYXghbUffWBPxt
 EW5ZTbyz5iJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZgq4OAAKCRDmvw3LpmlM
 hNuMEACsNN+OGpJAgVww+GfEExuOi0t7gosZ75Df6cAv0O6GyHNDtBe/LhHYsruMdcWT0zPw5Lm
 Pelxhxpk57rZx/7P3MpVk3m4Jko2FPrASL+3KMZdbCSWu+NZSQmTBAsNBVdzE11Cn2ix10cXSan
 d/KJKdLGcQM7ehE/xe/g9kiDrxkc5w76jwWFnjqk69gcMAX4IzkTWdBCqcX3FiKYel8ig2Yobzi
 aK7fsk12oDzFZ5CKbQp0H5b4y3hCLnTynqqloXq3GaYlnm9GyJS+72T/4k3MrfzP2fsC8Ry5dNe
 SMfXdZOXJJTKpB7ok6xWT0lIj+HNXbJS1aHEHd8LNF9IoTN7bFeVxzlAcvFlgM93haVIQgnx+rh
 ubWWY2oYYOcjh5+7G+OfHLB+tdTIkYbp3qeEv/G0JjnaFKHPJfPr8lYuI3I0BGjmel7NOSO/iJp
 xkI3nWWwrvH/W9o4pG9xr5/QF8vm7qDfzN9eNCpnfMHGIpw4e4zHKl/tVomp6yNSVS9GN2lQ6Lk
 Lm6uRCMx2nRvuKBdx/BBZbN4LlZ4LRhG2WNLjXVomPL2iU0djWEZ0hvwvVM0kKz5iQA7XzzYa2I
 mAcaCTwJNDtppnqrDV/zV0DML1ZJcznjKDCBXSQfnLkj8JVgaQuVzaIqw03kXO7cVGUdsgtXRC3
 J8SD1tV4Ys1k21w==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

For some devices, the MAC controls the LEDs in the RJ45 connector, not
the PHY. This patchset provides generic support for such LEDs, and
adds the first user, mv88e6xxx.

The common code netdev_leds_setup() is passed a DT node containing the
LEDs and a structure of operations to act on the LEDs. The core will
then create an cdev LED for each LED found in the device tree node.

The callbacks are passed the netdev, and the index of the LED. In
order to make use of this within DSA, helpers are added to convert a
netdev to a ds and port.

The mv88e6xxx has been extended to add basic support for the 6352
LEDs. Only software control is added, but the API supports hardware
offload which can be added to the mv88e6xxx driver later.

For testing and demonstration, the Linksys Mamba aka. wrt1900ac has
the needed DT nodes added to describe its LEDs.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
Changes in v3:
- Change Internet port LED from LED_FUNCTION_LAN to LED_FUNCTION_WAN
- Another attempt to get Kconfig correct
- Link to v2: https://lore.kernel.org/r/20240330-v6-8-0-net-next-mv88e6xxx-leds-v4-v2-0-fc5beb9febc5@lunn.ch

Changes in v2:
- Validate maximum number of LEDs in core code
- Change Kconfig due to 0-day reports
- Link to v1: https://lore.kernel.org/r/20240317-v6-8-0-net-next-mv88e6xxx-leds-v4-v1-0-80a4e6c6293e@lunn.ch

---
Andrew Lunn (7):
      dsa: move call to driver port_setup after creation of netdev.
      net: Add helpers for netdev LEDs
      net: dsa: mv88e6xxx: Add helpers for 6352 LED blink and brightness
      net: dsa: mv88e6xxx: Tie the low level LED functions to device ops
      net: dsa: Add helpers to convert netdev to ds or port index
      dsa: mv88e6xxx: Create port/netdev LEDs
      arm: boot: dts: mvebu: linksys-mamba: Add Ethernet LEDs

 .../boot/dts/marvell/armada-xp-linksys-mamba.dts   |  66 +++++++
 drivers/net/dsa/mv88e6xxx/Kconfig                  |   1 +
 drivers/net/dsa/mv88e6xxx/chip.c                   | 125 ++++++++++++-
 drivers/net/dsa/mv88e6xxx/chip.h                   |  19 ++
 drivers/net/dsa/mv88e6xxx/port.c                   |  93 ++++++++++
 drivers/net/dsa/mv88e6xxx/port.h                   |  76 +++++++-
 include/net/dsa.h                                  |  17 ++
 include/net/netdev_leds.h                          |  45 +++++
 net/Kconfig                                        |  11 ++
 net/core/Makefile                                  |   1 +
 net/core/netdev-leds.c                             | 201 +++++++++++++++++++++
 net/dsa/devlink.c                                  |  17 +-
 net/dsa/dsa.c                                      |   3 +
 net/dsa/user.c                                     |   8 +
 net/dsa/user.h                                     |   7 -
 15 files changed, 665 insertions(+), 25 deletions(-)
---
base-commit: 3b4cf29bdab08328dfab5bb7b41a62937ea5b379
change-id: 20240316-v6-8-0-net-next-mv88e6xxx-leds-v4-ab77d73d52a4

Best regards,
-- 
Andrew Lunn <andrew@lunn.ch>


