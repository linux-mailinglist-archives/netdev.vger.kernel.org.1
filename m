Return-Path: <netdev+bounces-127572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C812975C5C
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 23:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8117283CEB
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 21:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF52158DB1;
	Wed, 11 Sep 2024 21:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V5rihcsw"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B071547C6;
	Wed, 11 Sep 2024 21:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726090047; cv=none; b=XUvnTtzhdatb5VhLzvmm+EAyyoIXfxtXtLVF4DlTnHOi+qqnAjukqs6SvicYVWhE36R/oqPrn04D01rv6OyAPNDPiLQ7WzUurIWZIzVkwb8kWrutcGiMl+18XnBEItwwCWV6gm411IRnz3M/3JUtp8SVLD/FL8kX5uW1owLZ/FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726090047; c=relaxed/simple;
	bh=89blPC3dZuKgy5q8no/pKywqZp4n4DCqCipntkVeVPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HJ1/SvcwLHZjIK1uj4g82PTCrRozI9MFhcF6yOGNZeeowuNp1SOLz2mpsRwkO5UiMOVIic/wYHWAfwjoReoMfk8ZGkIpR9Td4fidVt1FV0Wfr+TIvVTdWVBU7mBBgJTx/MX/L6Q8G6pwTDQzp5B+V+Iq4/fzYVm0LRvyyQSQWt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V5rihcsw; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F9841C0002;
	Wed, 11 Sep 2024 21:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726090037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=101PaTxq6DmgGCqwL9QuDGATpVsTFmA7gnEaLtO+Q/w=;
	b=V5rihcswJGwKhyg7kJXY+O9CZpOtxKu2YMrmJucei5k9Ln3S74adlXQCjr8+SWT8WeFKFH
	VH9VowshvxNByKpto/sCCS1pMAQf+VesZGDyf8RE33/7nYM/cMVaShrHmcLYk8ileXbDvB
	NaQlB70zPkJWjPSi2THJri3umjzLvjV9BE2ZkDXBk5SuyWwavMyF22TOGTO9y1QhQlMlcq
	KvL/8fYiUfS6NXDsg1xk3DUS29W+Jj5adlqWY1+c43HRisgOKfLUWPHIA18MDLIr1ZPKDG
	Qhr5/uBWqlAiqqGCb/5PVQH7vSNeAqVskt3E3JxxkvlpBNSnYXI4fTJQcNJ0xw==
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
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH net-next 0/7] Allow controlling PHY loopback and isolate modes
Date: Wed, 11 Sep 2024 23:27:04 +0200
Message-ID: <20240911212713.2178943-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello everyone,

This series brings support for controlling the isolation and loopback
modes for PHY devices, through a netlink interface.

The isolation support work is made in preparation for the support of
interfaces that posesses multiple PHYs attached to the same MAC, on the
same MII bus. In this configuration, the isolation mode for the PHY is
used to avoid interferences on the MII bus, which doesn't support
multidrop topologies.

This mode is part of the 802.3 spec, however rarely used. It was
discovered that some PHYs don't implement that mode correctly, and will
continue being active on the MII interface when isolated. This series
supports that case, and flags the LXT973 as having such a broken
isolation mode. The Marvell 88x3310/3340 PHYs also don't support this
mdoe, and are also flagged accordingly.

The main part needed for the upcomping multi-PHY support really is the
internal kernel API to support this.

The second part of the series (patches 5, 6 and 7) focus on allowing
userspace to control that mode. The only real benefit of controlling this
from userspace is to make it easier to find out if this mode really
works or not on the PHY being used.

This relies on a new set of ethtool_phy_ops, set_config and get_config,
to toggle these modes.

The loopback control from that API is added as it fits the API
well, and having the ability to easily set the PHY in MII-loopback
mode is a helpful tool to have when bringing-up a new device and
troubleshooting the link setup.

The netlink API is an extension of the existing PHY_GET, reporting 2 new
attributes (one for isolate, one for loopback). A PHY_SET command is
introduced as well, allowing to configure the loopback and isolation.

All in all, the userspace part is a bonus here, let me know if you think
is just doesn't make sense, although the loopback feature can be useful
and sent as a standalone series. In such case, I'll include the kernel-only
support for isolation (so, patches 1 to 5) as part of the multi-PHY
support series when it comes out.

Thanks,

Maxime

Maxime Chevallier (7):
  net: phy: allow isolating PHY devices
  net: phy: Allow flagging PHY devices that can't isolate their MII
  net: phy: lxt: Mark LXT973 PHYs as having a broken isolate mode
  net: phy: marvell10g: 88x3310 and 88x3340 don't support isolate mode
  net: phy: introduce ethtool_phy_ops to get and set phy configuration
  net: ethtool: phy: allow reporting and setting the phy isolate status
  netlink: specs: introduce phy-set command along with configurable
    attributes

 Documentation/netlink/specs/ethtool.yaml     | 20 +++++
 Documentation/networking/ethtool-netlink.rst |  2 +
 drivers/net/phy/lxt.c                        |  2 +
 drivers/net/phy/marvell10g.c                 |  2 +
 drivers/net/phy/phy.c                        | 59 +++++++++++++
 drivers/net/phy/phy_device.c                 | 89 ++++++++++++++++++--
 include/linux/ethtool.h                      |  8 ++
 include/linux/phy.h                          | 26 ++++++
 include/uapi/linux/ethtool_netlink.h         |  3 +
 net/ethtool/netlink.c                        |  8 ++
 net/ethtool/netlink.h                        |  1 +
 net/ethtool/phy.c                            | 75 +++++++++++++++++
 12 files changed, 289 insertions(+), 6 deletions(-)

-- 
2.46.0


