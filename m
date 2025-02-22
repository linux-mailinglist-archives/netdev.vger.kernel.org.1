Return-Path: <netdev+bounces-168761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A2EA408FE
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 15:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C91F3BF4D9
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 14:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F32E156F41;
	Sat, 22 Feb 2025 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AXQgwZ5t"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2107156237;
	Sat, 22 Feb 2025 14:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740234463; cv=none; b=rsNiHdvVVhkEmvUIiNKdcRJwN5loXrmkzE7KBTUYS6yv6U87LbYxyOJ1oGndX7/TkYbpkbgUbOuEk0Blbd6SApAmNI02/y76skabWHVzBi43ClN3rlgI6GVCJb6DKlcaIfwaCu8lipJm79hMUbV3wl+FDMb+FHq1dyRwT94NiRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740234463; c=relaxed/simple;
	bh=QvRwvp+ydVb3r6U6a5oarDYj5qrVHjOQ6YWb1uXsGlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qp815HF8sMJ5Pf6ubWu+HLcv7y0EAoHmtti+NfBEqunXKeqOiLIJeK1qHzr6ceeDnRBTU3dTypMwFGNHGtTQYmC9lo3Ctt/nHP+wN/eqIITMmmQN4TJKHQIOd8ER/+UxmnhH65hZF9026dOooFvuXYAu5RIzWNbUqnZXFmpa/n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AXQgwZ5t; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1712343284;
	Sat, 22 Feb 2025 14:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740234453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pGwEt+QWoi5fS4m2LqhDwntpqVFxHq+vM5vBU2vIlNs=;
	b=AXQgwZ5t1bBuMnyMxDGNT+ZM7Dp43ZpQJq0eLq3gZXaTLPL+diBZ3FYQ3UARDdhX32eCoG
	SsGLrBtj5woB4ZbhBdkmm4DXW6IvsCMvmzZG3V0k4e9Z7tsvva1acB3ANp1kEAUqE7/yQ6
	TX2NHJufl3iVByZQ7TB5085Hi8p3iRSve4Iin8s0eMWSk+cjzrgqjKZcDA9EkSEmxXcWyz
	l8xSOzJ+tBbIC+9wC0gM3i260vJ3wF25ZUNkWI4+t9rl0XpVelgrrYw0sfAf4qcwog4If/
	RvXZOaE8PzFJuCJort+drRegHX0GX2I+ZO7txFqYhVEdxUSVi77sDJA1w+ZFTw==
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
Subject: [PATCH net-next 00/13] net: phy: Rework linkmodes handling in a dedicated file
Date: Sat, 22 Feb 2025 15:27:12 +0100
Message-ID: <20250222142727.894124-1-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejfeduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejhfelieehgfffiefftdffiedvheefteehkedukefgteffteevffeuueejiedtveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello everyone,

Following the V4 of the phy_port series [1] we've discussed about attempting
to extract some of the linkmode <-> capabilities (speed/duplex) <-> interface
logic into a dedicated file, so that we can re-use that logic out of
phylink. That would be the first 3 patches of this series.

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

Patches 6 to 12 then convert all lookups from the phy_settings array into
lookups from this link_caps array, hopefully speeding-up lookups in the
meantime (we iterate over possible speeds instead of individual linkmodes)

Patch 13 simply removes the phy_settings array altogether.

This series is not meant to introduce changes in behaviour, however patches
11 and 12 do introduce functionnal changes. When configuring the advert
for speeds >= 1G in PHY devices, as well as when constructing the link
parameters for fixed links in phylink, we used to rely on phy_settings
lookups returning one, and only one, compatible linkmode. This series will
make so that the lookups will result on all matching linkmodes being
returned, and MAY cause advert/fixed-link configuring more linkmodes.

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

Heiner is currently working on cleaning-up the headers and internal
helpers for phylib, this series may conflict with it.

All the new helpers that were introduced (in drivers/net/phy/phy-caps.h)
are for internal use only (only users should be core stuff, such as phylib and
phylink, and in the future, phy_port).

Thanks,

Maxime

[1]: https://lore.kernel.org/netdev/20250213101606.1154014-1-maxime.chevallier@bootlin.com/

Maxime Chevallier (13):
  net: phy: Extract the speed/duplex to linkmode conversion from phylink
  net: phy: phylink: Extract the logic to get caps from interface
  net: phy: phylink: Extract getting the max speed for a given interface
  net: ethtool: Export the link_mode_params definitions
  net: phy: Use an internal, searchable storage for the linkmodes
  net: phy: phy_caps: Move phy_speeds to phy_caps
  net: phy: phy_caps: Move __set_linkmode_max_speed to phy_caps
  net: phy: phy_caps: Introduce link_caps_valid
  net: phy: phy_caps: Implement link_capabilities lookup by linkmode
  net: phy: phy_caps: Allow looking-up link caps based on speed and
    duplex
  net: phy: phy_device: Use link_capabilities lookup for PHY aneg config
  net: phy: phylink: Use phy_caps_lookup for fixed-link configuration
  net: phy: drop phy_settings and the associated lookup helpers

 drivers/net/phy/Makefile     |   2 +-
 drivers/net/phy/phy-caps.h   |  39 +++
 drivers/net/phy/phy-core.c   | 254 ++----------------
 drivers/net/phy/phy.c        |  38 +--
 drivers/net/phy/phy_caps.c   | 496 +++++++++++++++++++++++++++++++++++
 drivers/net/phy/phy_device.c |  14 +-
 drivers/net/phy/phylink.c    | 359 +++----------------------
 include/linux/ethtool.h      |   8 +
 include/linux/phy.h          |  14 -
 net/ethtool/common.c         |   1 +
 net/ethtool/common.h         |   7 -
 11 files changed, 615 insertions(+), 617 deletions(-)
 create mode 100644 drivers/net/phy/phy-caps.h
 create mode 100644 drivers/net/phy/phy_caps.c

-- 
2.48.1


