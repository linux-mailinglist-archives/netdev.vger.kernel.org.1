Return-Path: <netdev+bounces-51908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2977FCABD
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AB071C2106D
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F605B5B4;
	Tue, 28 Nov 2023 23:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EPEuQa87"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7788197
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 15:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	Content-Disposition:In-Reply-To:References;
	bh=WtOLoBBwzQ0ssbSLlbU44nkZv4ONajUcT8mIhC8nhK4=; b=EPEuQa874Yuf5Vpdm87O1uVeyu
	HqEiiJRKoj+JssjBrRI6nj7zlGqP5Hl5yD+F+vRO3h01aZsh9eafe9IkdXm7fmYrm5ILFEHxUPFBI
	Dsh5N+VmU2NZ/BvBfuBdcA7adaKRMS/rlQWbrmucK7qIQVBI4Pd7xJTJzrkKLRYl1NrI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r87Op-001VIp-Gi; Wed, 29 Nov 2023 00:21:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: netdev <netdev@vger.kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH RFC net-next 0/8] DSA LED infrastructure, mv88e6xxx and QCA8K
Date: Wed, 29 Nov 2023 00:21:27 +0100
Message-Id: <20231128232135.358638-1-andrew@lunn.ch>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset extends the DSA core to add support for port LEDs being
controlled via sys/class/leds, and offloading blinking via
ledtrig-netdev. The core parses the device tree binding, and registers
LEDs. The DSA switch ops structure is extended with the needed
functions.

The mv88e6xxx support is partially added. Support for setting the
brightness and blinking is provided, but offloading of blinking is not
yet available. To demonstrate this, the wrt1900ac device tree is
extended with LEDs.

The existing QCA8K code is refactored to make use of this shared code.

RFC:

Linus, can you rework your code into this for offloading blinking ?
And test with ports 5 & 6.

Christian: Please test QCA8K. I would not be surprised if there is an
off-by-one.

This code can also be found in

https://github.com/lunn/ v6.7-rc2-net-next-mv88e6xxx-leds

Andrew Lunn (8):
  net: dsa: mv88e6xxx: Add helpers for 6352 LED blink and brightness
  net: dsa: mv88e6xxx: Tie the low level LED functions to device ops
  net: dsa: Plumb LED brightnes and blink into switch API
  dsa: Create port LEDs based on DT binding
  dsa: Plumb in LED calls needed for hardware offload
  dsa: mv88e6xxx: Plumb in LED offload functions
  arm: boot: dts: mvebu: linksys-mamba: Add Ethernet LEDs
  dsa: qca8k: Use DSA common code for LEDs

 .../dts/marvell/armada-xp-linksys-mamba.dts   |  66 +++++
 drivers/net/dsa/mv88e6xxx/chip.c              | 103 +++++++
 drivers/net/dsa/mv88e6xxx/chip.h              |  14 +
 drivers/net/dsa/mv88e6xxx/port.c              |  99 +++++++
 drivers/net/dsa/mv88e6xxx/port.h              |  76 +++++-
 drivers/net/dsa/qca/qca8k-8xxx.c              |  11 +-
 drivers/net/dsa/qca/qca8k-leds.c              | 255 +++---------------
 drivers/net/dsa/qca/qca8k.h                   |   9 -
 drivers/net/dsa/qca/qca8k_leds.h              |  21 +-
 include/net/dsa.h                             |  17 ++
 net/dsa/dsa.c                                 | 190 +++++++++++++
 11 files changed, 620 insertions(+), 241 deletions(-)

-- 
2.42.0


