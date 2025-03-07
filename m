Return-Path: <netdev+bounces-173030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF44A56F29
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861EE3B7B3A
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 17:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3208241CBC;
	Fri,  7 Mar 2025 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TSDWWp0p"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03C021A44C;
	Fri,  7 Mar 2025 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368983; cv=none; b=iE4V8CyK2O9cqXrfd5vUx15MupWLf4i20LqXUgtpekV4PZ3B5BGn7CZBBPFUZbe5rYHLUXBUQ4VRYqW3wWpvCcaAXFvOHgqwyg74PNTczUCqa8Oh+k0F9e96pZCBIyYLSz/uRtogAc1AlnR94rp/ns6zRqFsuNEVzX28wb2OQdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368983; c=relaxed/simple;
	bh=EYyNphtGdxTij3tGstNqVpQHFvB4lfqgf5fMT5vkXRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKxQ/2RycDtATThC7L6l2JyxoighjnE6x9VLzP8uPOrgasOFFa1EMe7TLRVnHZwShdJl+F9Q5XkhEPZCUmejahYiXDNBBUdNsnu7jslgRB4bLbrtWDFi1rMrE4SGXUoTF3kXa9LKWvxNWey8tC0cUGx595caO/MYloBR9qizkQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TSDWWp0p; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D33DF20457;
	Fri,  7 Mar 2025 17:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741368977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=junFff7hbIRhDqgiPdaOciaOP2LhM4k1pmuNAX39HWM=;
	b=TSDWWp0pWtK+4VElFU2ShgwPGmCtNg5wQftpsSXOA6MWOopitGWZGFpCHDbzb1amqmVLE+
	lQ8sT+K1rcJyiVRjwoxlYRhHbjyQpxMgJ41J20bg57ypvG5JOOMeSk0NzeD0JLxRuwJCzm
	/u2pbzHlJ7y0GV5BTdtXRVsl1LKlz4+0+ffZ9VaEJWo+7dJy+hGq1XqmONk61Iani9n8yF
	cp7k5oVuiJdVrHJlK4WRpkT1hzw0wqqAutildM0wsZQW5t4J2/vXLHs/mMJuSQiXUQ0Cjd
	4EGUClPM4a2MNYuN/RZxvc562xLEX4RttHkrICjzL16XV0uX8vSUL8gl2zqhJQ==
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
Subject: [PATCH net-next v5 02/13] net: phy: Use an internal, searchable storage for the linkmodes
Date: Fri,  7 Mar 2025 18:35:59 +0100
Message-ID: <20250307173611.129125-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
References: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveegtdffleffleevueellefgjeefvedvjefhheegfefgffdvfeetgeevudetffdtnecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmr
 giivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

The canonical definition for all the link modes is in linux/ethtool.h,
which is complemented by the link_mode_params array stored in
net/ethtool/common.h . That array contains all the metadata about each
of these modes, including the Speed and Duplex information.

Phylib and phylink needs that information as well for internal
management of the link, which was done by duplicating that information
in locally-stored arrays and lookup functions. This makes it easy for
developpers adding new modes to forget modifying phylib and phylink
accordingly.

However, the link_mode_params array in net/ethtool/common.c is fairly
inefficient to search through, as it isn't sorted in any manner. Phylib
and phylink perform a lot of lookup operations, mostly to filter modes
by speed and/or duplex.

We therefore introduce the link_caps private array in phy_caps.c, that
indexes linkmodes in a more efficient manner. Each element associated a
tuple <speed, duplex> to a bitfield of all the linkmodes runs at these
speed/duplex.

We end-up with an array that's fairly short, easily addressable and that
it optimised for the typical use-cases of phylib/phylink.

That array is initialized at the same time as phylib. As the
link_mode_params array is part of the net stack, which phylink depends
on, it should always be accessible from phylib.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V5: Fail on unknown speed

 drivers/net/phy/Makefile     |  2 +-
 drivers/net/phy/phy-caps.h   | 43 +++++++++++++++++
 drivers/net/phy/phy_caps.c   | 90 ++++++++++++++++++++++++++++++++++++
 drivers/net/phy/phy_device.c |  5 ++
 4 files changed, 139 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/phy/phy-caps.h
 create mode 100644 drivers/net/phy/phy_caps.c

diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 8f9ba5e8290d..23ce205ae91d 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -3,7 +3,7 @@
 
 libphy-y			:= phy.o phy-c45.o phy-core.o phy_device.o \
 				   linkmode.o phy_link_topology.o \
-				   phy_package.o
+				   phy_package.o phy_caps.o
 mdio-bus-y			+= mdio_bus.o mdio_device.o
 
 ifdef CONFIG_MDIO_DEVICE
diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
new file mode 100644
index 000000000000..6024f1d11a93
--- /dev/null
+++ b/drivers/net/phy/phy-caps.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * link caps internal header, for link modes <-> capabilities <-> interfaces
+ * conversions.
+ */
+
+#ifndef __PHY_CAPS_H
+#define __PHY_CAPS_H
+
+#include <linux/ethtool.h>
+
+enum {
+	LINK_CAPA_10HD = 0,
+	LINK_CAPA_10FD,
+	LINK_CAPA_100HD,
+	LINK_CAPA_100FD,
+	LINK_CAPA_1000HD,
+	LINK_CAPA_1000FD,
+	LINK_CAPA_2500FD,
+	LINK_CAPA_5000FD,
+	LINK_CAPA_10000FD,
+	LINK_CAPA_20000FD,
+	LINK_CAPA_25000FD,
+	LINK_CAPA_40000FD,
+	LINK_CAPA_50000FD,
+	LINK_CAPA_56000FD,
+	LINK_CAPA_100000FD,
+	LINK_CAPA_200000FD,
+	LINK_CAPA_400000FD,
+	LINK_CAPA_800000FD,
+
+	__LINK_CAPA_MAX,
+};
+
+struct link_capabilities {
+	int speed;
+	unsigned int duplex;
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(linkmodes);
+};
+
+int phy_caps_init(void);
+
+#endif /* __PHY_CAPS_H */
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
new file mode 100644
index 000000000000..6cb18e216d97
--- /dev/null
+++ b/drivers/net/phy/phy_caps.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/ethtool.h>
+#include <linux/linkmode.h>
+#include <linux/phy.h>
+
+#include "phy-caps.h"
+
+static struct link_capabilities link_caps[__LINK_CAPA_MAX] __ro_after_init = {
+	{ SPEED_10, DUPLEX_HALF, {0} }, /* LINK_CAPA_10HD */
+	{ SPEED_10, DUPLEX_FULL, {0} }, /* LINK_CAPA_10FD */
+	{ SPEED_100, DUPLEX_HALF, {0} }, /* LINK_CAPA_100HD */
+	{ SPEED_100, DUPLEX_FULL, {0} }, /* LINK_CAPA_100FD */
+	{ SPEED_1000, DUPLEX_HALF, {0} }, /* LINK_CAPA_1000HD */
+	{ SPEED_1000, DUPLEX_FULL, {0} }, /* LINK_CAPA_1000FD */
+	{ SPEED_2500, DUPLEX_FULL, {0} }, /* LINK_CAPA_2500FD */
+	{ SPEED_5000, DUPLEX_FULL, {0} }, /* LINK_CAPA_5000FD */
+	{ SPEED_10000, DUPLEX_FULL, {0} }, /* LINK_CAPA_10000FD */
+	{ SPEED_20000, DUPLEX_FULL, {0} }, /* LINK_CAPA_20000FD */
+	{ SPEED_25000, DUPLEX_FULL, {0} }, /* LINK_CAPA_25000FD */
+	{ SPEED_40000, DUPLEX_FULL, {0} }, /* LINK_CAPA_40000FD */
+	{ SPEED_50000, DUPLEX_FULL, {0} }, /* LINK_CAPA_50000FD */
+	{ SPEED_56000, DUPLEX_FULL, {0} }, /* LINK_CAPA_56000FD */
+	{ SPEED_100000, DUPLEX_FULL, {0} }, /* LINK_CAPA_100000FD */
+	{ SPEED_200000, DUPLEX_FULL, {0} }, /* LINK_CAPA_200000FD */
+	{ SPEED_400000, DUPLEX_FULL, {0} }, /* LINK_CAPA_400000FD */
+	{ SPEED_800000, DUPLEX_FULL, {0} }, /* LINK_CAPA_800000FD */
+};
+
+static int speed_duplex_to_capa(int speed, unsigned int duplex)
+{
+	if (duplex == DUPLEX_UNKNOWN ||
+	    (speed > SPEED_1000 && duplex != DUPLEX_FULL))
+		return -EINVAL;
+
+	switch (speed) {
+	case SPEED_10: return duplex == DUPLEX_FULL ?
+			      LINK_CAPA_10FD : LINK_CAPA_10HD;
+	case SPEED_100: return duplex == DUPLEX_FULL ?
+			       LINK_CAPA_100FD : LINK_CAPA_100HD;
+	case SPEED_1000: return duplex == DUPLEX_FULL ?
+				LINK_CAPA_1000FD : LINK_CAPA_1000HD;
+	case SPEED_2500: return LINK_CAPA_2500FD;
+	case SPEED_5000: return LINK_CAPA_5000FD;
+	case SPEED_10000: return LINK_CAPA_10000FD;
+	case SPEED_20000: return LINK_CAPA_20000FD;
+	case SPEED_25000: return LINK_CAPA_25000FD;
+	case SPEED_40000: return LINK_CAPA_40000FD;
+	case SPEED_50000: return LINK_CAPA_50000FD;
+	case SPEED_56000: return LINK_CAPA_56000FD;
+	case SPEED_100000: return LINK_CAPA_100000FD;
+	case SPEED_200000: return LINK_CAPA_200000FD;
+	case SPEED_400000: return LINK_CAPA_400000FD;
+	case SPEED_800000: return LINK_CAPA_800000FD;
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * phy_caps_init() - Initializes the link_caps array from the link_mode_params.
+ *
+ * Returns: 0 if phy caps init was successful, -EINVAL if we found an
+ *	    unexpected linkmode setting that requires LINK_CAPS update.
+ *
+ */
+int phy_caps_init(void)
+{
+	const struct link_mode_info *linkmode;
+	int i, capa;
+
+	/* Fill the caps array from net/ethtool/common.c */
+	for (i = 0; i < __ETHTOOL_LINK_MODE_MASK_NBITS; i++) {
+		linkmode = &link_mode_params[i];
+		capa = speed_duplex_to_capa(linkmode->speed, linkmode->duplex);
+
+		if (capa < 0) {
+			if (linkmode->speed != SPEED_UNKNOWN) {
+				pr_err("Unknown speed %d, please update LINK_CAPS\n",
+				       linkmode->speed);
+				return -EINVAL;
+			}
+			continue;
+		}
+
+		__set_bit(i, link_caps[capa].linkmodes);
+	}
+
+	return 0;
+}
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index b2d32fbc8c85..4980862398d0 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -42,6 +42,7 @@
 #include <linux/unistd.h>
 
 #include "phylib-internal.h"
+#include "phy-caps.h"
 
 MODULE_DESCRIPTION("PHY library");
 MODULE_AUTHOR("Andy Fleming");
@@ -3558,6 +3559,10 @@ static int __init phy_init(void)
 	if (rc)
 		goto err_ethtool_phy_ops;
 
+	rc = phy_caps_init();
+	if (rc)
+		goto err_mdio_bus;
+
 	features_init();
 
 	rc = phy_driver_register(&genphy_c45_driver, THIS_MODULE);
-- 
2.48.1


