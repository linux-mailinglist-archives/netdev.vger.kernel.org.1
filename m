Return-Path: <netdev+bounces-187394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E368AA6D0E
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 10:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD789C2B97
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 08:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FDA233738;
	Fri,  2 May 2025 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XhGrtpnK"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3224622C324;
	Fri,  2 May 2025 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175980; cv=none; b=hOZCQPjvRSP+Jt7hvaju3dRr0wcq3/fi2G4AgvUfHKP+3x+SbZ3Mo16reeOMiFvUvjk/HQY+1JkjnN4hNIxvhu4aOw53TM+V8b+hNYs5YtwGj377odFhAVztF5RrTsQV4uVZ3nVe949t77yGR5ITIXn39Wb2xpbVON4bORWKwyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175980; c=relaxed/simple;
	bh=WXYP5Tdu9SrTsq8wmucAw2zldN32RxrLecfUWUylJxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EMCvc3zNyBQW5qQ/lEO0Eu63FiL7Ag/LRan4mWAi2dHZ6YP+wYlJ23a+ae/Rxenvvbmuk8Bq830AVkjjbVWdx3tkGC+qjm0SsgpnFo02fLf9kQWZbXathygrOSOMqtW3tQJbVXBbg7DgZOsJ5ioVDsjkTVxGs84oQA7fRyX+uNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XhGrtpnK; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9108243217;
	Fri,  2 May 2025 08:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746175966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VJ6s6tfNaYWPwppog4/wxkqhHZfGi0e9BsGRU7e1/pM=;
	b=XhGrtpnK5cI75qeqWiGb6lKr3qobv0vvvmLSHwFSGVH7CmS8CaDAtsAQUmy/b2RMJ1gcx2
	HEmuyLA5mHNX7P84jPT4ob8yAwlJsq00dgnZ0MchbwxL9Jabv8lRf+xDq4H6zCzStZ38Jn
	XQkj3vIQfw4xeOkIL5c+tk9MeeY6pg95LLgMlFmERd1ogt5wL+GKwSvzlanbumPhLU/4DH
	Hlq2u30yg5htGNMugLeKuSj5sep3wDLtOvrQhg2roZTkqR6mQ3MUQTdsVQaJ7vzflYRGGl
	M6ZtlKAzNyq/feWCTZdRVlnCdJ+Um5/D7JyaTYT1YdDv3hjO+pqSX/RavasM6w==
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
Subject: [PATCH net-next v8 0/3] net: ethtool: Introduce ethnl dump helpers
Date: Fri,  2 May 2025 10:52:38 +0200
Message-ID: <20250502085242.248645-1-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvtddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjefhleeihefgffeiffdtffeivdehfeetheekudekgfetffetveffueeujeeitdevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvuddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvl
 hdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi everyone,

This is V8 for per-phy DUMP helpers, improving support for ->dumpit()
operations for PHY targetting commands.

This V8 fixes some issues spotted by Jakub (thanks !) on the multi-part
DUMP sequence. The netdev reftracking was reworked to make sure that
during a filtered DUMP, we only keep a ref on the netdev during
individual .dumpit() calls.

Thanks,

Maxime

Changes in V8:
 - Fixed the dump process WRT refcounting
 - Reset the pos_phyindex for non-filtered DUMP
 - Reworked kdoc and comments

Changes in V7:
 - Move from dev_hold to netdev_hold()
 - Add an extra patch fr dev_hold() conversion.

Changes in V6:
 - Squash pse and plca patches into the first one, to avoid unused
   functions (Jakub)

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
V5: https://lore.kernel.org/netdev/20250410123350.174105-1-maxime.chevallier@bootlin.com/
V6: https://lore.kernel.org/netdev/20250415085155.132963-1-maxime.chevallier@bootlin.com/
V7: https://lore.kernel.org/netdev/20250422161717.164440-1-maxime.chevallier@bootlin.com/

Maxime Chevallier (3):
  net: ethtool: Introduce per-PHY DUMP operations
  net: ethtool: phy: Convert the PHY_GET command to generic phy dump
  net: ethtool: netlink: Use netdev_hold for dumpit() operations

 net/ethtool/netlink.c | 217 +++++++++++++++++++++++++--
 net/ethtool/netlink.h |   4 -
 net/ethtool/phy.c     | 342 ++++++++++++------------------------------
 3 files changed, 298 insertions(+), 265 deletions(-)

-- 
2.49.0


