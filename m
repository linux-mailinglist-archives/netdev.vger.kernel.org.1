Return-Path: <netdev+bounces-80274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AA387E077
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 22:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04082B209B6
	for <lists+netdev@lfdr.de>; Sun, 17 Mar 2024 21:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5200208B6;
	Sun, 17 Mar 2024 21:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jlQgc0pK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D18B1DFF9
	for <netdev@vger.kernel.org>; Sun, 17 Mar 2024 21:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710711950; cv=none; b=qLsgcvXnTpur9xO5vqj69uQG0u32FGJoUrtB7Ct/3pDVJ+H3XaA+ymWS6zxd4b7gIhpE7iZYpy+9DHYTjaMnMYULMRsCU5Ds94dNd5b9Hfe+nDTDEe7Cd/+8no7fNoYGpEVS7V0oM3zjawYK6T7vAyKoFbDCEoy+rjyIm9z+DJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710711950; c=relaxed/simple;
	bh=kCuM5P3oST0o7QGj75vD48UgRaWAZ+vnWkha8JWbwds=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mraLUvvXjPZ05yOjqEyC0nP8ZRPi7bVNBCP7e1Q3LUosHuGfRvR3vX/K7cFr4iJdWYB4BH1eUuc7KUQLEYzgxomdAL28RezqhDghAHhrTWdP6LhMLClTRQpfreaJNGcSVpqVXc878Lqsf4ebdtWS6qUrmWOZlrpbOnRyvkV/154=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jlQgc0pK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Content-Disposition:In-Reply-To:References;
	bh=F73lDjsoFDtNnARRlXf2fQHDZzctXvRd3BawGMUqvjk=; b=jlQgc0pK6XPH2lVWZQXzW5EaaJ
	GVUCwpadjyuiDvr0ZYDmEnSkqo1cJrMxJn+jmlt2e6B+Qi+2xD5/MMG/cQuCCqnMKXqIKOPUPhJ/+
	UrVbsbXhSDrsERmpQAhFo5SIFLZpNuuYZf3t0LTaBN2TxsnlwiuYB1Qh0Po/V79Uz4gk=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rlyK5-00AYv5-R1; Sun, 17 Mar 2024 22:45:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH RFC 0/7] net: Add generic support for netdev LEDs
Date: Sun, 17 Mar 2024 16:45:13 -0500
Message-Id: <20240317-v6-8-0-net-next-mv88e6xxx-leds-v4-v1-0-80a4e6c6293e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGlk92UC/x2NQQrCMBAAv1L27EKapknwKvgAr+IhNtu6oKkkJ
 SyU/t3gYQ5zmdmhUGYqcO52yFS58Jqa9KcOpldICyHH5qCVNmroLVaLHhUm2hqy4ad6T1ZE8E2
 xYDUYns5FN8RRBwOt8800s/wfd7hdL/A4jh/N4bV+eAAAAA==
To: Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Gregory Clement <gregory.clement@bootlin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3165; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=kCuM5P3oST0o7QGj75vD48UgRaWAZ+vnWkha8JWbwds=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBl92R5dASAllw1P0KZmKPtRDHYQ+tVzPySjN9vT
 qWNGLh4LXOJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZfdkeQAKCRDmvw3LpmlM
 hMQND/wMw1mzZYtWRUvXEeB7/OeaZIJNJOX2d4rcw9aD9/eJl2/EuAx8I35GYlgS9mA3GmajgX2
 CxV4OlwGzJkMun/tg9nLL1oLrnar5ehmvM8/zrVbLBi3Tc4biFRyImWrPKl6pXf82/5vilgK4e+
 s7yqw+sSjArnAmMSolAknGQwcRMDdPpefnBWRLdV1Xu7aQ6NhFnH/3uXfbQFSPP+qPEcqIG+MZI
 bbCD9qaFSnns3f0wYYxnmf0n96nQ9GBmD8yYtYp4od30AjjTLnfCSIEU4xFplgunLBngF/bpIfE
 qr2E1HDDZYk0CUzmBvKN6d+TeXgDfyL0m92k+eBHTP/lgsR3KxKU6rahcV6i3lZ1KImEb3fFfl7
 VAklx8e8WsEFeaNwKgUDx9QVluUGHagzGl5ibzUea4Twp+cpXgCVJFvdMjcuQMMV7MHNDmPDKpi
 7TqMRnibhjojNmxK6TwTtvkZn7BXnqlp5Y1Z5cKuQMEkaY9baMRqdXU5pw9xQVRTtNscWyeXB1/
 ZL5b8BB8amqYSwCFsi3ih5sPDhwBx+XKbHppIygcBSQOzvZFxuXH7RLil0rQF4E9NGG9u8u+uU5
 P8K8gI228fjcRVWb67k0u8GvqSFYB/RIBtdSXBCOKMn1w3jHTjqifsd720zupsmzFdKuTmHJawV
 LntFkxatJYX3EMg==
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

RFC:

netdev is closed at the moment.

A previous version of this patchset was specific to DSA. Vladimir
objected to that and suggested the code should be more generic. Hence
now the shared code is moved into net/core and a struct net_device is
used, rather than struct dsa_switch. As a result, there is a bit more
boilerplate needed in DSA drivers.

If this code is accepted, it would be good to convert the qca8k DSA
driver to also use this framework.

Given how hard it is to get kconfig connect for LEDs, i would not be
surprised if this is also broken :-(

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
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
 drivers/net/dsa/mv88e6xxx/port.c                   |  99 +++++++++++
 drivers/net/dsa/mv88e6xxx/port.h                   |  76 +++++++-
 include/net/dsa.h                                  |  17 ++
 include/net/netdev_leds.h                          |  44 +++++
 net/Kconfig                                        |  10 ++
 net/core/Makefile                                  |   1 +
 net/core/netdev-leds.c                             | 197 +++++++++++++++++++++
 net/dsa/devlink.c                                  |  17 +-
 net/dsa/dsa.c                                      |   3 +
 net/dsa/user.c                                     |   8 +
 net/dsa/user.h                                     |   7 -
 15 files changed, 665 insertions(+), 25 deletions(-)
---
base-commit: 237bb5f7f7f55ec5f773469a974c61a49c298625
change-id: 20240316-v6-8-0-net-next-mv88e6xxx-leds-v4-ab77d73d52a4

Best regards,
-- 
Andrew Lunn <andrew@lunn.ch>


