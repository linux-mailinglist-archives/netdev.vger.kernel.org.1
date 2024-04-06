Return-Path: <netdev+bounces-85457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D15089ACCD
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 22:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821F228248E
	for <lists+netdev@lfdr.de>; Sat,  6 Apr 2024 20:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4384E1BA;
	Sat,  6 Apr 2024 20:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="sLkXrC34"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDBA487A5
	for <netdev@vger.kernel.org>; Sat,  6 Apr 2024 20:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712434445; cv=none; b=lri36xVYm/fSExZ8bytNVNQPx3B1An3VCgGfBEDJOUADL1b0yZvfC6zHO28Niu2QFuLPn+7NT9nmt1C1Hk3b0ku9PvKGdkSTCr4sAl2yhg5/d2wmhLHoJ8v6En7KmgCGnGX0LQHy+qKV4maApDGGh4gLyzb76MM1StQNco5WWNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712434445; c=relaxed/simple;
	bh=Pf5LyoZxsU9sxObpPdZ4DJZonu6jf2IHkGYm1nlUu28=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SLb+W7jhJhTLko0k07lHoXUo8Y/eSvptn4ne0nrJ24lDImfKOb+9HUWHmgCz2lnKiXzKriMooabJkiEZMQkcc40jpxxymumZ1/wHhG2y82c9GhWc5ynsPxj9FJiaZL2aZtF+9pK8xQNoYZ6anDVr6WbjRE7r8adkWDzngp/jZSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=sLkXrC34; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Content-Disposition:In-Reply-To:References;
	bh=n2zZi0XuqJxTXUjg4zSgaK3PyHr9X7T03PPrg21Nf20=; b=sLkXrC34WfgNxpsq2ij27Iwy/W
	CrriNK8SWxVJljcmbEVq81/6lmc9ycpEjAsUlIqqfZZSr6KFZfaismuWIn4sOG53inQoUfXtdeDON
	QQK5cB6RnW5WGwO44IUMAKvj/yxSMS+VAWgxOaWPxLDxZGvygU6SlNPZcznNMoDdB9Rk=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rtCQG-00COA7-7s; Sat, 06 Apr 2024 22:13:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v4 0/8] net: Add generic support for netdev LEDs
Date: Sat, 06 Apr 2024 15:13:27 -0500
Message-Id: <20240406-v6-8-0-net-next-mv88e6xxx-leds-v4-v4-0-eb97665e7f96@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOisEWYC/42NzW7CMBAGXwX53K38b8OJ90AcbGdNLFGD4mC5Q
 nn3WlEryi2HPXwa7cyTFJwSFnLYPcmENZV0y33Ijx0Jo8sXhDT0TTjlkgqmoWqwQCHj3K/N8FW
 tRd1agysOBaoE540ZjBgUd5J0z33CmNraOJG/P3LuZExlvk3fa7yylf92zIZOZZ1b6iTqoPle4
 PH6yPkzjKu78n8+Qbf4eOcxKI9+H9EH9e4TL5+kbItPdM458yI6paKxL9+yLD9eRf7xegEAAA=
 =
To: Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Gregory Clement <gregory.clement@bootlin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3357; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=Pf5LyoZxsU9sxObpPdZ4DJZonu6jf2IHkGYm1nlUu28=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBmEaz3E7vmT76DYK8r/CVgsh1Wvxaeju+RuoZ1Y
 /buvBkjC+WJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZhGs9wAKCRDmvw3LpmlM
 hNh+D/9gAIpek53/A6JIzzyLfZ5YhCvmQRTSSr63jnD4BeIgaqoau8j/6eJlxCdXhBiVON88TxD
 9mMDhZX+2gfUV3TyZNtIj7+PyF36FXLOw6Yf/uOVnFu1YJ2xS1Q0su5fgFDPchDB4xGx6ThsyMo
 3CUhyKrGSOZR78xw0MhZi1hfWb0Qu8OCjAu2mlOugoJFarQUIKjqopu9oBXuiCd/Y62yJwPuqO3
 TnWkH13wg0RVstchF/jpc9vNQH/vjSVZ61NLZ4hMeyRcYNgolDKxVzUwGublQlucqp6VWmuHx34
 AR2LiLOt6W09Vh68/8RXRzjLgdA/6sl1ygk+JbGM+CapI9Ro2NyruXpvMVvnYIoaqkX97hcM2QV
 KVxkZrfXjpykWCyzCGzzvBY7w9MUdD66QhmYe3LeYgJ/hltgdlhg+q4b2bIpfM3oUdwrRosYZde
 XOS+/jkBXetE4qdqjhR2e5xxrS1Czs3IFnXyrlzwj1N6WYFubuMD7MbjqWrz5NYK6xF/OJZyOay
 7mMZnpOzihvpP5VAkKVC9D1Fj7GUrx5+2qz3hrf0AeE9nTnbsxMtXLqnHZe92gGOOpTY/Pbo2mJ
 gJRIH1Yzks4ezkxUCYXnPQMuZ5jWk6s7RVpyLYgaRPJplNJuD0Au0FN1M4Q8hx2meumm7Kjjo2E
 F4FGgfPhPbw4wmw==
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
Changes in v4:
- Fix leak of OF nodes
- Switch -> switch
- Replace patch with Vladimirs 3 patches.
- Drop new helpers, use dsa_port_from_netdev()
- One list head per netdev/port, not shared
- Drop usage of devm_led_classdev_register_ext() which might be unsafe.
- Link to v3: https://lore.kernel.org/r/20240401-v6-8-0-net-next-mv88e6xxx-leds-v4-v3-0-221b3fa55f78@lunn.ch

Changes in v3:
- Change Internet port LED from LED_FUNCTION_LAN to LED_FUNCTION_WAN
- Another attempt to get Kconfig correct
- Link to v2: https://lore.kernel.org/r/20240330-v6-8-0-net-next-mv88e6xxx-leds-v4-v2-0-fc5beb9febc5@lunn.ch

Changes in v2:
- Validate maximum number of LEDs in core code
- Change Kconfig due to 0-day reports
- Link to v1: https://lore.kernel.org/r/20240317-v6-8-0-net-next-mv88e6xxx-leds-v4-v1-0-80a4e6c6293e@lunn.ch

---
Andrew Lunn (5):
      net: Add helpers for netdev LEDs
      net: dsa: mv88e6xxx: Add helpers for 6352 LED blink and brightness
      net: dsa: mv88e6xxx: Tie the low level LED functions to device ops
      dsa: mv88e6xxx: Create port/netdev LEDs
      arm: boot: dts: mvebu: linksys-mamba: Add Ethernet LEDs

Vladimir Oltean (3):
      net: dsa: consolidate setup and teardown for shared ports
      net: dsa: break out port setup and teardown code per port type
      net: dsa: move call to driver port_setup after creation of netdev

 .../boot/dts/marvell/armada-xp-linksys-mamba.dts   |  53 ++++++
 drivers/net/dsa/mv88e6xxx/Kconfig                  |   1 +
 drivers/net/dsa/mv88e6xxx/chip.c                   | 127 ++++++++++++-
 drivers/net/dsa/mv88e6xxx/chip.h                   |  20 +++
 drivers/net/dsa/mv88e6xxx/port.c                   |  93 ++++++++++
 drivers/net/dsa/mv88e6xxx/port.h                   |  76 +++++++-
 include/net/netdev_leds.h                          |  50 ++++++
 net/Kconfig                                        |  11 ++
 net/core/Makefile                                  |   1 +
 net/core/netdev-leds.c                             | 199 +++++++++++++++++++++
 net/dsa/devlink.c                                  |  17 +-
 net/dsa/dsa.c                                      | 177 ++++++++++++------
 12 files changed, 752 insertions(+), 73 deletions(-)
---
base-commit: 3b4cf29bdab08328dfab5bb7b41a62937ea5b379
change-id: 20240316-v6-8-0-net-next-mv88e6xxx-leds-v4-ab77d73d52a4

Best regards,
-- 
Andrew Lunn <andrew@lunn.ch>


