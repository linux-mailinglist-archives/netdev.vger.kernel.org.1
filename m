Return-Path: <netdev+bounces-122842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 226A8962C3A
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 17:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27771F238BF
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 15:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D10187FF1;
	Wed, 28 Aug 2024 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MKV1fib3"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E8513BC1E;
	Wed, 28 Aug 2024 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858721; cv=none; b=hkc8lgTZv/Ngw4mvdXCbw+7/CuXHu77T70+M2mZhnx9T2xJttIjtf7FCQt7KV9OtkE0zBBrTUORETVN/c1G68bn+kOz5tuoyzUYywO4rlzMGEEPZd6voljPze2XdUj1/ndVGIFEozQmsmNhDHsqWw9ynWIuBxnBmFDEJpUDqkAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858721; c=relaxed/simple;
	bh=SLGhcth1PadWNi7Y3lsoKOJUzfSlOaIJQn2gbhwhjdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o+//+r/zhkaUNhd0GdYbeS/cRpA/XMtkW1B0JWMhERBEYlyAVSYmJDctqzl76qnBOfsDrOCEjmiac9VYUypuf6MTtZtQQMclJ0rT346B0v9UlIOZ5FJCFRa95Og2l3bSy/g6KeUbGkYbeZ3FHSz4MukrZXQpV0BS4ujqnRhfImE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MKV1fib3; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 02C75FF809;
	Wed, 28 Aug 2024 15:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724858717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HP9gBOgloyHUCtotR6aa5DRFGN171osS+fbsGuOzKLg=;
	b=MKV1fib3Xd5628A0RZUR0cH3FcIpw+sUM8zfFfj8YGVh1GRnZ5Ddapz4iH73DVIYdrBRw1
	4VkabVC6l4xaGuY5oZloH3Vw7sfP44gV+/pa2b4wVEVUd5g0NGrBZ8/9NZ8orFvl4k7c1a
	O+5CG9i9xnV9ZBNoe/tnUG44Gz/oFBMQ3Ho77teu4ivEKzlGmaCQ5qVkCT4x/umowAtCTj
	dp11+ECeTrMLajVkAWSpSK+zfbBUKFkMb7wm4zxx8mAEwUyAHxtkdiPmPEZsqv1P7LmRhK
	0D5NgngE0U0AASRxs8kTrBQVP/VyZ7Lob181HMjmcwgdaq32Q6p/MRQMe6QLyw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Michal Kubecek <mkubecek@suse.cz>
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
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH ethtool-next v2 0/3] Introduce PHY listing and targeting
Date: Wed, 28 Aug 2024 17:25:07 +0200
Message-ID: <20240828152511.194453-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello,

This series adds the ethtool-side support to list PHYs associated to a
netdevice, as well as allowing to target PHYs for some commands :
 - PSE-PD commands
 - Cable testing commands
 - PLCA commands

This V2 uses the uAPI that got applied on the associated kernel-side
series [1], cleans a few lose-ends from the first version, and adds the
manpage modifications that was missing from V1.

The PHY-targetting commands look like this:

ethtool --phy 1 --cable-test eth0

Note that the --phy parameter gets passed at the beginning of the
command-line. This allows getting a generic command-line parsing code,
easy to write, but at the expense of maybe being a bit counter intuitive.

Another option could be to add a "phy" parameter to all the supported
commands, let me know if you think this looks too bad.

Patch 1 deals with the ability to pass a PHY index to the relevant
commands.

Patch 2 implements the --show-phys command. This command uses a netlink
DUMP request to list the PHYs, and introduces the ability to perform
filtered DUMP request, where the netdev index gets passed in the DUMP
request header.

Thanks,

Maxime

[1]: https://lore.kernel.org/netdev/20240821151009.1681151-1-maxime.chevallier@bootlin.com/

Link to V1: https://lore.kernel.org/netdev/20240103142950.235888-1-maxime.chevallier@bootlin.com/

Maxime Chevallier (3):
  update UAPI header copies
  ethtool: Allow passing a PHY index for phy-targetting commands
  ethtool: Introduce a command to list PHYs

 Makefile.am                  |   1 +
 ethtool.8.in                 |  56 +++++++++++++++++
 ethtool.c                    |  30 ++++++++-
 internal.h                   |   1 +
 netlink/cable_test.c         |   4 +-
 netlink/extapi.h             |   1 +
 netlink/msgbuff.c            |  52 ++++++++++++----
 netlink/msgbuff.h            |   3 +
 netlink/nlsock.c             |  38 ++++++++++++
 netlink/nlsock.h             |   2 +
 netlink/phy.c                | 116 +++++++++++++++++++++++++++++++++++
 netlink/plca.c               |   4 +-
 netlink/pse-pd.c             |   4 +-
 uapi/linux/ethtool.h         |  16 +++++
 uapi/linux/ethtool_netlink.h |  25 ++++++++
 15 files changed, 334 insertions(+), 19 deletions(-)
 create mode 100644 netlink/phy.c

-- 
2.45.2


