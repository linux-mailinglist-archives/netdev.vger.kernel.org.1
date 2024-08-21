Return-Path: <netdev+bounces-120654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1AC95A118
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 17:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E7B1F22817
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CD01B3B2C;
	Wed, 21 Aug 2024 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PuNQeUjl"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EF013D53E;
	Wed, 21 Aug 2024 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724253042; cv=none; b=DXIBAw+oIElNI278XAqkpXsfk+X9uHaGSsvJXZ3SebRbaRjZ5l0WdKRXM+tFtBOnY6KNC04q9lQcL1EqLlGafhOzw60zWj5rGUfj0pad/2WjRPxer3SNqHqqsHw90btxFLOLJQD52BXCBjlJ2fT33ygIE0qzPLhPB7oS4ADgi+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724253042; c=relaxed/simple;
	bh=svnwW+51eA5NmsjQhUKciu7Dt69pwQqFHAgSFl/uyGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IuBeJu8rTPizfYN+TWCk0S6VyHXtAGCaXWQNuqrqxxBrAPMYGp+YI3EO1OSH5lfQW43kZIi60DKYEU5T7PW9fAPC3cmUP8/r/5lHNNxfeKS/COQUimPdjN31xciUJlvZmVZzWfywmpkEbh5TnIRvpZIrWWM77PFN4+ZTkdJc3eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PuNQeUjl; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AA57240002;
	Wed, 21 Aug 2024 15:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724253037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FeFz2REgJ5Cu9Uyp5uPiEHWrqWRI+ecTPYClbo8H/3I=;
	b=PuNQeUjlcaBKJo8meYnbr7MSFBq1Rgs1kjNZezO3PEtmGFxF0l73oJlvCCts/bkqKSeDBd
	7kBDC4XDvS4QEShePOc/WYh1xS9TLmhG/sRCvHGtv5oBgPbnR/mfb/cfWq3x4uGftO2BSx
	AXZkLCveGV8yMDDLGguJAHJIghBjzCmHlO+xt156OgZFbVbc97YsQTaSOV+vCJ6yG17kSy
	++B76xUy6XW0YFgc9rmGzmPGsmsTCKTz7hNDVsQg4nitlM3FYghn/rX71d0md8ETKJRxgQ
	MPRqm15VnD1v8NY0xdI9UVS9Gq281639vA3WqGvkkRJHIOWfivkb1w7ZRGbFKg==
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
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Nathan Chancellor <nathan@kernel.org>,
	Antoine Tenart <atenart@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next v18 13/13] Documentation: networking: document phy_link_topology
Date: Wed, 21 Aug 2024 17:10:07 +0200
Message-ID: <20240821151009.1681151-14-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821151009.1681151-1-maxime.chevallier@bootlin.com>
References: <20240821151009.1681151-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

The newly introduced phy_link_topology tracks all ethernet PHYs that are
attached to a netdevice. Document the base principle, internal and
external APIs. As the phy_link_topology is expected to be extended, this
documentation will hold any further improvements and additions made
relative to topology handling.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 Documentation/networking/ethtool-netlink.rst  |   3 +
 Documentation/networking/index.rst            |   1 +
 .../networking/phy-link-topology.rst          | 121 ++++++++++++++++++
 3 files changed, 125 insertions(+)
 create mode 100644 Documentation/networking/phy-link-topology.rst

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index 8c152871c23c..44cb9e29f325 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -2198,10 +2198,13 @@ Retrieve information about a given Ethernet PHY sitting on the link. The DO
 operation returns all available information about dev->phydev. User can also
 specify a PHY_INDEX, in which case the DO request returns information about that
 specific PHY.
+
 As there can be more than one PHY, the DUMP operation can be used to list the PHYs
 present on a given interface, by passing an interface index or name in
 the dump request.
 
+For more information, refer to :ref:`phy_link_topology`
+
 Request contents:
 
   ====================================  ======  ==========================
diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index d1af04b952f8..c71b87346178 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -91,6 +91,7 @@ Contents:
    operstates
    packet_mmap
    phonet
+   phy-link-topology
    pktgen
    plip
    ppp_generic
diff --git a/Documentation/networking/phy-link-topology.rst b/Documentation/networking/phy-link-topology.rst
new file mode 100644
index 000000000000..4dec5d7d6513
--- /dev/null
+++ b/Documentation/networking/phy-link-topology.rst
@@ -0,0 +1,121 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. _phy_link_topology:
+
+=================
+PHY link topology
+=================
+
+Overview
+========
+
+The PHY link topology representation in the networking stack aims at representing
+the hardware layout for any given Ethernet link.
+
+An Ethernet interface from userspace's point of view is nothing but a
+:c:type:`struct net_device <net_device>`, which exposes configuration options
+through the legacy ioctls and the ethtool netlink commands. The base assumption
+when designing these configuration APIs were that the link looks something like ::
+
+  +-----------------------+        +----------+      +--------------+
+  | Ethernet Controller / |        | Ethernet |      | Connector /  |
+  |       MAC             | ------ |   PHY    | ---- |    Port      | ---... to LP
+  +-----------------------+        +----------+      +--------------+
+  struct net_device               struct phy_device
+
+Commands that needs to configure the PHY will go through the net_device.phydev
+field to reach the PHY and perform the relevant configuration.
+
+This assumption falls apart in more complex topologies that can arise when,
+for example, using SFP transceivers (although that's not the only specific case).
+
+Here, we have 2 basic scenarios. Either the MAC is able to output a serialized
+interface, that can directly be fed to an SFP cage, such as SGMII, 1000BaseX,
+10GBaseR, etc.
+
+The link topology then looks like this (when an SFP module is inserted) ::
+
+  +-----+  SGMII  +------------+
+  | MAC | ------- | SFP Module |
+  +-----+         +------------+
+
+Knowing that some modules embed a PHY, the actual link is more like ::
+
+  +-----+  SGMII   +--------------+
+  | MAC | -------- | PHY (on SFP) |
+  +-----+          +--------------+
+
+In this case, the SFP PHY is handled by phylib, and registered by phylink through
+its SFP upstream ops.
+
+Now some Ethernet controllers aren't able to output a serialized interface, so
+we can't directly connect them to an SFP cage. However, some PHYs can be used
+as media-converters, to translate the non-serialized MAC MII interface to a
+serialized MII interface fed to the SFP ::
+
+  +-----+  RGMII  +-----------------------+  SGMII  +--------------+
+  | MAC | ------- | PHY (media converter) | ------- | PHY (on SFP) |
+  +-----+         +-----------------------+         +--------------+
+
+This is where the model of having a single net_device.phydev pointer shows its
+limitations, as we now have 2 PHYs on the link.
+
+The phy_link topology framework aims at providing a way to keep track of every
+PHY on the link, for use by both kernel drivers and subsystems, but also to
+report the topology to userspace, allowing to target individual PHYs in configuration
+commands.
+
+API
+===
+
+The :c:type:`struct phy_link_topology <phy_link_topology>` is a per-netdevice
+resource, that gets initialized at netdevice creation. Once it's initialized,
+it is then possible to register PHYs to the topology through :
+
+:c:func:`phy_link_topo_add_phy`
+
+Besides registering the PHY to the topology, this call will also assign a unique
+index to the PHY, which can then be reported to userspace to refer to this PHY
+(akin to the ifindex). This index is a u32, ranging from 1 to U32_MAX. The value
+0 is reserved to indicate the PHY doesn't belong to any topology yet.
+
+The PHY can then be removed from the topology through
+
+:c:func:`phy_link_topo_del_phy`
+
+These function are already hooked into the phylib subsystem, so all PHYs that
+are linked to a net_device through :c:func:`phy_attach_direct` will automatically
+join the netdev's topology.
+
+PHYs that are on a SFP module will also be automatically registered IF the SFP
+upstream is phylink (so, no media-converter).
+
+PHY drivers that can be used as SFP upstream need to call :c:func:`phy_sfp_attach_phy`
+and :c:func:`phy_sfp_detach_phy`, which can be used as a
+.attach_phy / .detach_phy implementation for the
+:c:type:`struct sfp_upstream_ops <sfp_upstream_ops>`.
+
+UAPI
+====
+
+There exist a set of netlink commands to query the link topology from userspace,
+see ``Documentation/networking/ethtool-netlink.rst``.
+
+The whole point of having a topology representation is to assign the phyindex
+field in :c:type:`struct phy_device <phy_device>`. This index is reported to
+userspace using the ``ETHTOOL_MSG_PHY_GET`` ethtnl command. Performing a DUMP operation
+will result in all PHYs from all net_device being listed. The DUMP command
+accepts either a ``ETHTOOL_A_HEADER_DEV_INDEX`` or ``ETHTOOL_A_HEADER_DEV_NAME``
+to be passed in the request to filter the DUMP to a single net_device.
+
+The retrieved index can then be passed as a request parameter using the
+``ETHTOOL_A_HEADER_PHY_INDEX`` field in the following ethnl commands :
+
+* ``ETHTOOL_MSG_STRSET_GET`` to get the stats string set from a given PHY
+* ``ETHTOOL_MSG_CABLE_TEST_ACT`` and ``ETHTOOL_MSG_CABLE_TEST_ACT``, to perform
+  cable testing on a given PHY on the link (most likely the outermost PHY)
+* ``ETHTOOL_MSG_PSE_SET`` and ``ETHTOOL_MSG_PSE_GET`` for PHY-controlled PoE and PSE settings
+* ``ETHTOOL_MSG_PLCA_GET_CFG``, ``ETHTOOL_MSG_PLCA_SET_CFG`` and ``ETHTOOL_MSG_PLCA_GET_STATUS``
+  to set the PLCA (Physical Layer Collision Avoidance) parameters
+
+Note that the PHY index can be passed to other requests, which will silently
+ignore it if present and irrelevant.
-- 
2.45.2


