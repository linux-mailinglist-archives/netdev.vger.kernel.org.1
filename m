Return-Path: <netdev+bounces-181254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2CEA8433D
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 14:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43BA64C1CDD
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8A72853FF;
	Thu, 10 Apr 2025 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ns/nFH0m"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30101E9B35;
	Thu, 10 Apr 2025 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744288439; cv=none; b=tvQTdwhu4ec3XhVq4wv1wwfi1uzKw8nAYM90X3+1Rk5AacA8x2X6Bwvd5da7VQjzpE7l6XUEaJI486k3eWY1pWRNuHbgsLl1EY4ubNW4suqv4SOf+4Jd1WC1LTkybx+9y1QjQmJEObgChvmxJrzU7JZGf4L/ZysleqS1KALImmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744288439; c=relaxed/simple;
	bh=7VY810eEngwLTSGYyZ7inTUJVOW7Hx2nDI5oKDu0g7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RF6yLMwC6tnSGrLwDS8K4ytin1vTwkTlQHU4N5aYJuCvb6wyVd+QY/aPby/ZwVvbKVmYBbvOsUPM9pPdzbg3DOmrEeND+nRRL0RHlZbbeRiuWY+Qo7M9vewfv+yXSN62ern3+7O/c3AdcQBFVjlJLU8mbTp6as/D/BwK1r5AnUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ns/nFH0m; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4C7F744338;
	Thu, 10 Apr 2025 12:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744288434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J0xfKWJdyD9XFTZn8w86QT52Zuy8b8gkwIkU+lw2+nc=;
	b=Ns/nFH0meYjUnfZ6aFnwUXXVjhbmQhnCcJzMpeYSb7SkfHQANZ7jPJ8qfS4EIcA+diHfk1
	mvBkfa9WZ9pxLNZnDNoT8bIcWJDJM0P4m+yL4ePHELl6SIHHiHQAwSoll1jMtViJhkfBXZ
	GT9C39c+yPje86a7+Wr1R1DrUwkQdRgpJqIBElVcxk6qghRXOPBPQgbGrSDbZp2XStYKM+
	May/3B2SpPslljc7nOZ3S6GqIK+jwxolIdKkVsypwZ61aqu1X5nzNAC68aDtjVz1HVmr44
	P6tCOWsp1wBo+gpTjD+yf3WUTBa8DjnJF5IeE9N5gMwSz6DFsz/Dutmum/l8Jw==
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
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
Subject: [PATCH net-next v5 0/4] net: ethtool: Introduce ethnl dump helpers
Date: Thu, 10 Apr 2025 14:33:45 +0200
Message-ID: <20250410123350.174105-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdekledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjefhleeihefgffeiffdtffeivdehfeetheekudekgfetffetveffueeujeeitdevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvuddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvl
 hdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi everyone,

Here's another approach to get a better handling for ethnl dump when we
have phy-targetting commands.

Previous versions of that series introduced new ethnl ops for DUMP, but
only useful for PHY dump.

This series takes a step back and implements new perphy ops at the genl
level :
 ->start()
 ->dumpit()
 ->done()

This avoids having to flag commands that use filtered DUMPs, as this is
handled directly in the custom ->start(), and we can use our own dump
context without using dynamic allocs.

The drawback though is that this duplicates some logic from the
ethnl_default_xxx dump ops.

Patch 2 reworks the whole net/ethtool/phy.c to fallback to ethnl ops,
while patches 3 and 4 convert pse-pd and plca to this new dump method.

Let me know what you think,

Maxime

Changes in V5:
 - Move to a less generic approach, focusing only on the PHY case.

Changes in V4:
 - Don't grab rcu_read_lock when we already have a refcounter netdev on
   the filtered dump path (Paolo)
 - Move the dump_all stuff in a dedicated helper (Paolo)
 - Added patch 1 to set the dev in ctx->req_info

Changes in V3:
 - Fixed some typos and xmas tree issues
 - Added a missing check for EOPNOTSUPP in patch 1
 - Added missing kdoc
 - Added missing comments in phy_reply_size

Changes in V2:
 - Rebased on the netdev_lock work by Stanislav and the fixes from Eric
 - Fixed a bissectability issue
 - Fixed kdoc for the new ethnl ops and fields

V1: https://lore.kernel.org/netdev/20250305141938.319282-1-maxime.chevallier@bootlin.com/
V2: https://lore.kernel.org/netdev/20250308155440.267782-1-maxime.chevallier@bootlin.com/
V3: https://lore.kernel.org/netdev/20250313182647.250007-1-maxime.chevallier@bootlin.com/
V4: https://lore.kernel.org/netdev/20250324104012.367366-1-maxime.chevallier@bootlin.com/

Maxime Chevallier (4):
  net: ethtool: Introduce per-PHY DUMP operations
  net: ethtool: phy: Convert the PHY_GET command to generic phy dump
  net: ethtool: plca: Use per-PHY DUMP operations
  net: ethtool: pse-pd: Use per-PHY DUMP operations

 net/ethtool/netlink.c | 189 +++++++++++++++++++++--
 net/ethtool/netlink.h |   4 -
 net/ethtool/phy.c     | 342 ++++++++++++------------------------------
 3 files changed, 272 insertions(+), 263 deletions(-)

-- 
2.49.0


