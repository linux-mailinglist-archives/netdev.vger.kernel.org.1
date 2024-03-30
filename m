Return-Path: <netdev+bounces-83522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78597892C88
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 19:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168731F22D00
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 18:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2802AF01;
	Sat, 30 Mar 2024 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QfVgdyAj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E2D8475
	for <netdev@vger.kernel.org>; Sat, 30 Mar 2024 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711823558; cv=none; b=TAFThch+jrTmXYoCWxIcqBp4QKMfVJAGoSQGacmBH82eoT7mmJ4tzk908ycSS8hdaYXS2K4JSgrt99+zIHyXdnZTb+SC7qpGaaOgDz1BaQG7Zl+0YDkijJ/IVBkzMe5/5sbJNlbIASlSXwI5fhYc0TI4N9Z/4Z6lklql37PtRJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711823558; c=relaxed/simple;
	bh=jm8kJOwQFVJgL3xkL4fOmV6WCusotZmlid8T/BX4WCI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=opIjXzhNCYisyr/nnPcD8d4omorbOHK4LW20jDm34hvdHslSeDkIQ8x8pnH66Urmk+jJ49DSq7ni5XyRTM2/Iv3nIr8EUTYU5FwRr5UHlEzPB/ekmcHSjRLibilnEeQR0fNpTQMlcVdoZz7hdjNKiQJlpSMciXY51fxjULp2SiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QfVgdyAj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:From:Sender:Reply-To:Subject:Date:Message-ID:To:
	Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cduKxWraeVuUd3kDqGCl+qTU2SbqER1TOLyU2ai1hD4=; b=QfVgdyAj2puBh2c8mWi6IggO2f
	q0VA0An+FZ77Scs3aOg8S5+pYSAKZBDSNxKjGVeW4TiRkTmovNTQ+WpqPJD6pwcwD84qoxfLJSy0W
	b2bO6IfZhWbX0FtXdZD3ogvW9ClLKo+9lOmWB2R5jwF/nI/XD+OPq7pkEHc6w4hA+IGM=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rqdVC-00Bjfq-70; Sat, 30 Mar 2024 19:32:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v2 0/7] net: Add generic support for netdev LEDs
Date: Sat, 30 Mar 2024 13:31:57 -0500
Message-Id: <20240330-v6-8-0-net-next-mv88e6xxx-leds-v4-v2-0-fc5beb9febc5@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ1aCGYC/42NQQ7CIBREr9L8td9QQEBX3sN0geVrSSo1UAmm6
 d0lje5dzGLyMvMWSBQ9JTg1C0TKPvkp1MJ3DfSDDXdC72oHzrhkolWYFRpkGGiuKTM+sjGkSik
 4kkuYJdqr1k4Ld+BWQv15Rrr5sjku8NtBV8ng0zzF9ybP7ca/Hv2HJ7eVG2YlqV7xo6Dz+Aph3
 w/Qrev6AfgoyizaAAAA
To: Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Gregory Clement <gregory.clement@bootlin.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2806; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=jm8kJOwQFVJgL3xkL4fOmV6WCusotZmlid8T/BX4WCI=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBmCFq1Dw6YPhK6SO61fnVXIPLeYzX5aDd4qQgGh
 o+C88N3UgSJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZghatQAKCRDmvw3LpmlM
 hJgSD/wOF77l0Z5kMJltHlCaloO9MAWXZQVdxqE0nwIul9i/aBg6BhZboAPPmdFXx52RvGAWghj
 nyeSTg+nViJf5ijvfVKmp+gILOyr1f0o11CPLeeMWjKQcmt6LV25KoHcin51AbKbOB1buZV0adK
 NjQ7OwJOvEYn84h6Kx/x7mTNUC+nbHHxvsnqa7VaOkS2WZTn9CM8V76imis6kifDZM70Q2C7dqP
 Vw5L3+rWq9vBmPFn4Wjcm2p6uJTl7xllOYbne+fyQCc2ZUCzroxkR/6Gt0LxfJBr48f+z/doytv
 DZNsGdbxDdVkHtLgidqdADUVdVHjVgWGTqYKw3/PTP/TjTt4rx6wD0TWpDsCwRTNWHlRHyxndJz
 3CBjQn/EabEijUYTUtQZWBKx4nDtm5U0+3ugEdt3OCvuQ+HAsjICcXAx4I7gTm2+IUDGZQJI0oh
 yBdfXPJV/CE1/x1Af0fRdS033mGd1hygDXbviHYl87cV+yEx5cftPVnw7E3f3OleKKxcrCBiTO7
 ToosUr5o8EiehZMEt/AvpwZ+SKKuGHVqK3qBoNZw0M3w2VnILrvtv+3GnKbfgAb/SNtm5ydelgK
 3/d8gViEKwxP5nA30dXpGzRW/KvNzw8OZ85S4fdtxIKA1B9pXv4sGw+jSthJrvjmMkW5k+gHkLW
 qJimAcbez+oRzaQ==
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
base-commit: 537c2e91d3549e5d6020bb0576cf9b54a845255f
change-id: 20240316-v6-8-0-net-next-mv88e6xxx-leds-v4-ab77d73d52a4

Best regards,
-- 
Andrew Lunn <andrew@lunn.ch>


