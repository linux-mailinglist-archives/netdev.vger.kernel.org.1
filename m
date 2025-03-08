Return-Path: <netdev+bounces-173176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FE9A57BAE
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 16:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1957F16EDEB
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 15:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629EA1E3DD7;
	Sat,  8 Mar 2025 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZWqrBJ5w"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC371C84B7;
	Sat,  8 Mar 2025 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741449295; cv=none; b=t6Vas3xcLtL7NuoKeqmEFmgOOFlsmaICeYSRvTNATU/7aiLyoo4lYorJJCgbOVJZMhoZeYjV+nWPCZPVpprQSqSloDubP670fQgSW3jxFbyXI2kMy9jiqSBiw+D2orZ8X64eVfwMJuS+s9iztCo5HvxLZ2RVV34qOFjH63pjdNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741449295; c=relaxed/simple;
	bh=/rVkdfP+9iDulVQA2wk/PUBdOR0ylVp5tF/APG9jz7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TJcPQQBsyYhahBgW0PD40EBaSd5p6Wfc7ie67kBKeoJabCawJYavtwfwazefm8XLBfJFdNAef5euwqB6Pgit/ke9V9vi4uRPwvpzvX7FTPr/vBMNylLvNA9R1wGgKNzn4/K0pLzR97xm0Xvf/kpghYjbXBFtl7Hs/EPj5dNFAak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZWqrBJ5w; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C75B120457;
	Sat,  8 Mar 2025 15:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741449284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kexZQrMIpEE9IN4eQEzAttyVP9Nr79fTq/+KRV6gDuQ=;
	b=ZWqrBJ5wl8fIPZJ8s24rmk+Lc8BcNkhWk/zxay2V/CyQD8Fh8KHKQAm9jg8X0bDfbrjMMW
	jbQ8IXcEqxKv3/O1Qxpvh4LdHDv3Sg/IwbFKafmIsl8BN0LOrlEeKg2OLcDTtoQ/INpfUv
	ucDmxBf5+pT8r1OTc5JQl2QHIGRuyAUEeqRlc+8GTBRv7/TgY89bNzaKduT5WPwdQSnEsF
	baIcyMEyFTPdhwvjyT7oR5VMAAcGPaswoQaQFFLSo8ywp8fKG5t4MsCPx68EB/gtl3MwJI
	2G/7Jn4ojtY88A9wDOK7wkZ7fY6uF8VGNo7zd7lD66udwb1io3JkGvYi1vTQ3A==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next v2 0/7] net: ethtool: Introduce ethnl dump helpers
Date: Sat,  8 Mar 2025 16:54:32 +0100
Message-ID: <20250308155440.267782-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudefleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjefhleeihefgffeiffdtffeivdehfeetheekudekgfetffetveffueeujeeitdevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvvddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvl
 hdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi everyone,

This is V2 for the ethnl dump support, allowing better handling of
per-phy dump but also any other dump operation that needs to dump more
than one message per netdev.

Changes in V2:
 - Rebased on the netdev_lock work by Stanislav and the fixes from Eric
 - Fixed a bissectability issue
 - Fixed kdoc for the new ethnl ops and fields

V1: https://lore.kernel.org/netdev/20250305141938.319282-1-maxime.chevallier@bootlin.com/

As of today when using ethnl's default ops, the DUMP requests will
simply perform a GET for each netdev.

That hits limitations for commands that may return multiple messages for
a single netdev, such as :

 - RSS (listing contexts)
 - All PHY-specific commands (PLCA, PSE-PD, phy)
 - tsinfo (one item for the netdev +  one per phy)

 Commands that need a non-default DUMP support have to re-implement
 ->dumpit() themselves, which prevents using most of ethnl's internal
 circuitry.

This series therefore introduces a better support for dump operations in
ethnl.

The patches 1 and 2 introduce the support for filtered DUMPs, where an
ifindex/ifname can be passed in the request header for the DUMP
operation. This is for when we want to dump everything a netdev
supports, but without doing so for every single netdev. ethtool's
"--show-phys ethX" option for example performs a filtered dump.

Patch 3 introduces 3 new ethnl ops : 
 ->dump_start() to initialize a dump context
 ->dump_one_dev(), that can be implemented per-command to dump
 everything on a given netdev
 ->dump_done() to release the context

The default behaviour for dumps remains the same, calling the whole
->doit() path for each netdev.

Patch 4 introduces a set of ->dump_start(), ->dump_one_dev() and
->dump_done() callback implementations that can simply be plugged into
the existing commands that list objects per-phy, making the 
phy-targeting command behaviour more coherent.

Patch 5 uses that new set of helpers to rewrite the phy.c support, which
now uses the regulat ethnl_ops instead of fully custom genl ops. This
one is the hardest to review, sorry about that, I couldn't really manage
to incrementally rework that file :(

Patches 6 and 7 are where the new dump infra shines, adding per-netdev
per-phy dump support for PLCA and PSE-PD.

We could also consider converting tsinfo/tsconfig, rss and tunnels to
these new ->dump_***() operations as well, but that's out of this
series' scope.

Maxime Chevallier (7):
  net: ethtool: netlink: Allow per-netdevice DUMP operations
  net: ethtool: netlink: Rename ethnl_default_dump_one
  net: ethtool: netlink: Introduce command-specific dump_one_dev
  net: ethtool: netlink: Introduce per-phy DUMP helpers
  net: ethtool: phy: Convert the PHY_GET command to generic phy dump
  net: ethtool: plca: Use per-PHY DUMP operations
  net: ethtool: pse-pd: Use per-PHY DUMP operations

 net/ethtool/netlink.c | 165 ++++++++++++++------
 net/ethtool/netlink.h |  47 +++++-
 net/ethtool/phy.c     | 343 ++++++++++++------------------------------
 net/ethtool/plca.c    |  12 ++
 net/ethtool/pse-pd.c  |   6 +
 5 files changed, 280 insertions(+), 293 deletions(-)

-- 
2.48.1


