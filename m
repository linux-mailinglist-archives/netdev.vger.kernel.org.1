Return-Path: <netdev+bounces-170743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CD9A49C7A
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 15:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA8D1898C8D
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4032702DF;
	Fri, 28 Feb 2025 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D4GQ4dIO"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7CA271260;
	Fri, 28 Feb 2025 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754547; cv=none; b=M725oVQQc2QlDTHx6cE484BVSWYShUsPEKo7EPNgO2ZROmS61+BseMaeyWekK66ExkSC75CtIWiavgRdQuaDglhyXSnQZ7/AyGDZwB2Hjm7tQ0a2mrUEqGbQ3uALxVWA9yV2j5CeMp2PZWKlbPxkY+UVT3XkgPWrzLQ1M2QTeCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754547; c=relaxed/simple;
	bh=cZDEWIRto6mybFYqScjIJHXOSTfCON4Wzt7rpupUNbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cVGLc0/Gg8p5ew4CnyZNjC/GBnVJAT2BoypAjVaFja0kLyuHmgfbXh+Nuj1KN5IL/rW1IBXJOYQEhO3m9W+9hU6qk1evH4Y21g4a50Nzeij6mL+8dQbxhNHNNbSj2ENfkjJHtEtmF5alWI3gJyiVAdZ5zQmYptG2OImhqByHxPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D4GQ4dIO; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1E4B944390;
	Fri, 28 Feb 2025 14:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740754543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pD0aysiymrvllBFzGF1nBmIkQ51KRCeKfXG88hk7YFg=;
	b=D4GQ4dIOy60FBFoSX3KDoMN6mwMMebvjw000ncNAfqP2sNmnKAik/1F0JoLS8XFBQk08WJ
	WZkGSahOpFK3a5/HC+B/Rt+URDNuFR0RIIS4hg/ct5kiClXRJNsYqrVHEykTIotbzPFc1U
	FfoQ5dlg+Mh/wrdoUXv5EZSBh7kJwNsZp2sDd/qXl0IC19miPw766LXvcphRX/mtMkscn8
	QOn+peH7mrqJ1JLveJwPoOslvbLP+bKRY4+6zRfAcTSYvS1Ldu9QlnF2STcpnHQDQlW3Or
	Fzf9m68J45wMZKke8ypYEMtY1ldTNzhgukqXWaRoAfiaYh45tqiMWbEcoSatdA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next v3 00/13] net: phy: Rework linkmodes handling in a dedicated file
Date: Fri, 28 Feb 2025 15:55:25 +0100
Message-ID: <20250228145540.2209551-1-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdeilecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejhfelieehgfffiefftdffiedvheefteehkedukefgteffteevffeuueejiedtveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello everyone,

This is V3 of the phy_caps series. In a nutshell, this series reworks the way
we maintain the list of speed/duplex capablities for each linkmode so that we
no longer have multiple definition of these associations.

That will help making sure that when people add new linkmodes in
include/uapi/linux/ethtool.h, they don't have to update phylib and phylink as
well, making the process more straightforward and less error-prone.

It also generalises the phy_caps interface to be able to lookup linkmodes
from phy_interface_t, which is needed for the multi-port work I've been working
on for a while.

This V3 addresses Russell's comments on the naming for the patches, but doesn't
contain any change in the code. There were a question from Russell on patch 9
from the previous round which I answered, I have kept the same API in that round
as I don't know if the conclusion from that discussion is that the phy_caps_lookup
API is OK or not.

I understand that this series isn't easy to review, if that's too much to process
for the limited gains, I'll come-up with a simpler approach for the phy_port and
leave the phy_settings alone :)

V1 : https://lore.kernel.org/netdev/20250222142727.894124-1-maxime.chevallier@bootlin.com/
V2 : https://lore.kernel.org/netdev/20250226100929.1646454-1-maxime.chevallier@bootlin.com/

For context, The text below is an extract from the V1 cover :

Following the V4 of the phy_port series [1] we've discussed about attempting
to extract some of the linkmode <-> capabilities (speed/duplex) <-> interface
logic into a dedicated file, so that we can re-use that logic out of
phylink.

While trying to do that, I might have gotten a bit carried-away, and I'm
therefore submitting this series to rework the way we are currently
managing the linkmodes <-> capabilities handling.

We are currently defining all the possible Ethernet linkmodes in an
enum ethtool_link_mode_bit_indices value defined in uapi/linux/ethtool.h :

	ETHTOOL_LINK_MODE_10baseT_Half_BIT	= 0,
	ETHTOOL_LINK_MODE_10baseT_Full_BIT	= 1,
	...

Each of these modes represents a media-side link definition, and runs at
a given speed and duplex.

Specific attributes for each modes are stored in net/ethtool/common.c, as
an array of struct link_mode_info :

	struct link_mode_info {
		int				speed;
		u8				lanes;
		u8				duplex;
	}

The link_mode_params[] array is the canonical definition for these modes,
as (1) there are build-time checks to make sure any new linkmode
definition is also defined in this array and (2) this array is always
compiled-in, as it's part of the net stack (i.e. it is not phylib-specific).

This array is however not optimized for lookups, as it is not ordered in
any particular fashion (new modes go at the end, regardless of their speed
and duplex).

Phylib also includes a similar array, in the form of the phy_settings
array in drivers/net/phy/phy-core.c :

	struct phy_setting {
		u32 speed;
		u8 duplex;
		u8 bit; // The enum index for the linkmode
	};

The phy_settings array however is ordered by descending speeds. A variety
of helpers in phylib rely on that ordering to perform lookups, usually
to get one or any linkmode corresponding to a requested speed and duplex.

Finally, we have some helpers in phylink (phylink_caps_to_linkmodes) that
allows getting the list of linkmodes that match a set of speed and duplex
value, all at once.

While the phylink and phylib helpers allows for efficient lookups, they
have some drawbacks as well :

	(1) : It's easy to forget updating of all of these helpers and structures
		  when adding a new linkmode. New linkmodes are actually added fairly
		  often, lately either for slow BaseT1 flavours, or for crazy-fast
		  modes (800Gbps modes, but I guess people won't stop there)
		  
	(2) : Even though the phylink and phylib modes use carefull sorting
		  to speed-up the lookup process, the phylib lookups are usually
		  done in descending speed order and will therefore get slower
		  as people add even faster link speeds.
		  
This series introduces a new "link_capabilities" structure that is used
to build an array of link_caps :

	struct link_capabilities {
		int speed;                           
		unsigned int duplex;
		__ETHTOOL_DECLARE_LINK_MODE_MASK(linkmodes);
	};

We group these in an array, indexed with LINK_CAPA enums that are basically
identical to the phylink MAC_CAPS :

...
LINK_CAPA_1000HD,             
LINK_CAPA_1000FD,
LINK_CAPA_2500FD,
LINK_CAPA_5000FD,
...

We now have an associative array of <speed,duplex> <-> All compatible linkmodes

This array is initialized at phylib-init time based on the content of
the link_mode_params[] array from net/ethtool/common.c, that way it is
always up-to-date with new modes, and always properly ordered.

Patches 3 to 8 then convert all lookups from the phy_settings array into
lookups from this link_caps array, hopefully speeding-up lookups in the
meantime (we iterate over possible speeds instead of individual linkmodes)

This series is not meant to introduce changes in behaviour, however patches
9 and 10 do introduce functionnal changes. When configuring the advert
for speeds >= 1G in PHY devices, as well as when constructing the link
parameters for fixed links in phylink, we used to rely on phy_settings
lookups returning one, and only one, compatible linkmode. This series will
make so that the lookups will result on all matching linkmodes being
returned, and MAY cause advert/fixed-link configuring more linkmodes.

Patches 12 and 13 extract the conversion logic for interface <-> caps from
phylink.

There are cons as well for this, as this is a bit more init time for phylib,
but maybe more importantly, we lose in the precision for the lookups in
phy_settings. However, given all the uses for phy_settings (most are just
to get speed/duplex), I think this is actually ok, but any comment would
be very welcome.

This series was tested with :
 - 10/100/1000M links
 - 2,5, 5, 10G BaseT links
 - 1G Fixed link

I also made sure that this compiles with the following options :

CONFIG_PHYLIB=n

CNFIG_PHYLINK=m
CONFIG_PHYLIB=m

CNFIG_PHYLINK=m
CONFIG_PHYLIB=y

CNFIG_PHYLINK=y
CONFIG_PHYLIB=y

All the new helpers that were introduced (in drivers/net/phy/phy-caps.h)
are for internal use only (only users should be core stuff, such as phylib and
phylink, and in the future, phy_port).

Thanks,

Maxime

[1]: https://lore.kernel.org/netdev/20250213101606.1154014-1-maxime.chevallier@bootlin.com/

Maxime Chevallier (13):
  net: ethtool: Export the link_mode_params definitions
  net: phy: Use an internal, searchable storage for the linkmodes
  net: phy: phy_caps: Move phy_speeds to phy_caps
  net: phy: phy_caps: Move __set_linkmode_max_speed to phy_caps
  net: phy: phy_caps: Introduce phy_caps_valid
  net: phy: phy_caps: Implement link_capabilities lookup by linkmode
  net: phy: phy_caps: Allow looking-up link caps based on speed and
    duplex
  net: phy: phy_device: Use link_capabilities lookup for PHY aneg config
  net: phylink: Use phy_caps_lookup for fixed-link configuration
  net: phy: drop phy_settings and the associated lookup helpers
  net: phylink: Add a mapping between MAC_CAPS and LINK_CAPS
  net: phylink: Convert capabilities to linkmodes using phy_caps
  net: phy: phy_caps: Allow getting an phy_interface's capabilities

 drivers/net/phy/Makefile     |   2 +-
 drivers/net/phy/phy-caps.h   |  62 +++++++
 drivers/net/phy/phy-core.c   | 253 ++------------------------
 drivers/net/phy/phy.c        |  37 ++--
 drivers/net/phy/phy_caps.c   | 340 +++++++++++++++++++++++++++++++++++
 drivers/net/phy/phy_device.c |  13 +-
 drivers/net/phy/phylink.c    | 337 +++++++++-------------------------
 include/linux/ethtool.h      |   8 +
 include/linux/phy.h          |  15 --
 net/ethtool/common.c         |   1 +
 net/ethtool/common.h         |   7 -
 11 files changed, 532 insertions(+), 543 deletions(-)
 create mode 100644 drivers/net/phy/phy-caps.h
 create mode 100644 drivers/net/phy/phy_caps.c

-- 
2.48.1


