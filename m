Return-Path: <netdev+bounces-160383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B6CA197C7
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 18:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D723188D2E6
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 17:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4DA21519C;
	Wed, 22 Jan 2025 17:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KdIdIhWD"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12778214802;
	Wed, 22 Jan 2025 17:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567781; cv=none; b=mjP3zL7zbUU+WpsE7TYMe2gz1pDfWr4C5Rok1g5uB2ffmZQ2RCR+QiTXJE931AtcA8m06IiX5/ep6pOGI3f4UVLw2T3Db2mUo3x6xUFqVORuvpckLxngTOATehVGqZlyDq2yeHCPvNxHUAezU5IwNwhI/LIE0KrLlAqUuWIVAuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567781; c=relaxed/simple;
	bh=iwwLc4tUQO0n+VIjKBA05uFvIoGDeQnCfqu5klLEwn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aCTqSA6NhyLbzVqIuu7gjMnnED1hWaop5qhPHrj5Jm3WKa/Rp8vy9px9wkAcoqBZ0rXgbrIL4bZsqdRpx9D2khNKu5NObR04CSP9F9mRJ9tdNFCVajRb7+QeMdz7+9ZZLJOh4HZCm6Iq7QZBd17btt7Ll7lvNo1FYv2ReXHzDiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KdIdIhWD; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9B4841BF206;
	Wed, 22 Jan 2025 17:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737567776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e+BotoW1qAloOkrfAJN9aQKph0ytt4fsgUwv49xYln0=;
	b=KdIdIhWDtOyCr1grtrO7qqX0a9ZlXZxYbW86bMHZws/vB/z+LbYT7ZbXLnjQerF0MOumkY
	adf6FyCGBJZy/RC7hH6ti7KYIP24sIfdfCP7zIDa7rsvU7IauevmM33+4TRVePKbZ6oH4q
	U9QpoP1SCSmzVLbBYjWDvm1eRhjsHlHx4ZYCUJrZBGQOYTmYA2Pwc8Z0NMlLsri24sXC/O
	U7oyFvQlbzxy9QjZm/R/cbpUr0guPuIZytpe3PIOtGt6k58al9pB17qOWG2qraccvcChjN
	LSXHfJMff6jZ1Z98BDUs0szhT9EVqMto8zuyPqoxdxSK71nS2z4BQodTdEUEsQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
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
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Antoine Tenart <atenart@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH net-next RFC v2 0/6] net: phy: Introduce a port representation 
Date: Wed, 22 Jan 2025 18:42:45 +0100
Message-ID: <20250122174252.82730-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello everyone,

This is a second RFC for the introduction of a front-facing interfaces
for ethernet devices.

The firts RFC[1] already got some reviews, focusing on the DT part of
that work. To better lay the ground for further discussions, this second
round includes a binding :)

Oleksij suggested some further possibilities for improving this binding,
as we could consider describing connectors in great details for
crossover detection, PoE ping mappings, etc. However, as this is
preliminary work, the included binding is still quite simple but can
certainly be extended.

This RFC V2 doesn't bring much compared to V1 :
 - A binding was introduced
 - A warning has been fixed in the dp83822 patch
 - The "lanes" property has been made optional

You'll find below more or less the same text as the cover for RFC V1.

First, a short disclaimer. This series is RFC, and there are quite a lot of
shortcomings :

 - The port representation is in a minimal form
 - No SFP support is included, but it will be required for that series to come
   out of RFC as we can't gracefully handle multi-port interfaces without it.

These shortcomigs come from timing constraints, but also because I'd like to
start discussing that topic with some code as a basis.

For now, the only representation we have about the physical ports of an interface
come from the 'port' field (PORT_FIBRE, PORT_TP, PORT_MII, etc.), the presence or
not of an SFP module and the linkmodes reported by the ethtol ksettings ops. This
isn't enough to get a good idea of what the actual interface with the outside world
looks like.

The end-goal of the work this series is a part of is to get support for multi-port
interfaces. My end use-case has 2 ports, each driven by a dedicated PHY, but this
also applies to dual-port PHYs.

The current series introduces the object "struct phy_port". The naming may be
improved, as I think we could consider supporting port representation without
depending on phylib (not the case in this RFC). For now, not only do we integrate
that work in phylib, but only PHY-driven ports are supported.

In some situations, having a good representation of the physical port in devicetree
proves to be quite useful. We're seeing vendor properties to address the lack of
port representation such as micrel,fiber-mode or ti,fiber-mode, but there are needs
for more (glitchy straps that detect fiber mode on a PHY connected to copper,
RJ45 ports connected with 2 lanes only, ...).

Example 1 : PHY with RJ45 connected with 2 lanes only

&mdio {

	ge_phy: ethernet-phy@0 {
		reg = <0>;

		mdi {
			port-0 {
				media = "BaseT",
				lanes = <2>;
			};
		};

	};
};

Example 2 : PHY with a 100BaseFX port, without SFP

&mdio {

	fiber-phy: ethernet-phy@0 {
		reg = <0>;

		mdi {
			port-0 {
				media = "BaseF",
				lanes = <1>;
			};
		};

	};
};

These ports may even be used to specify PSE-PD information for PoE ports that
are drivern by a dedicated PoE controller sitting in-between the PHY and the
connector :

&mdio {

	ge_phy: ethernet-phy@0 {
		reg = <0>;

		mdi {
			port-0 {
				media = "BaseT",
				lanes = <4>;
				pse = <&pse1>;
			};
		};

	};
};

The ports are initialized using the following sequence :

1: The PHY driver's probe() function indicated the max number of ports the device
can control

2: We parse the devicetree to find generic port representations

3: If we don't have at least one port from DT, we create one

4: We call the phy's .attach_port() for each port created so far. This allows
   the phy driver either to take action based on the generic port devicetree
   indications, or to populate the port information based on straps and
   vendor-specific DT properties (think micrel,fiber-mode and similar)

5: If the ports are still not initialized (no .attach_port, no generic DT), then
   we use snesible default value from what the PHY's supported modes.

6: We reconstruct the PHY's supported field in case there are limitations from the
   port (2 lanes on BaseT for example). This last step will need to be changed
   when SFP gets added.

So, the current work is only about init. The next steps for that work are :

 - Introduce phy_port_ops, including a .configure() and a .read_status() to get
 proper support for multi-port PHYs. This also means maintaining a list of
 advertising/lp_advertising modes for each port.

 - Add SFP support. It's a tricky part, the way I see that and have prototyped is
 by representing the SFP cage itself as a port, as well as the SFP module's port.
 ports therefore become chainable.

 - Add the ability to list the ports in userspace.

Prototype work for the above parts exist, but due to lack of time I couldn't get
them polished enough for inclusion in that RFC.

Let me know if you see this going in the right direction, I'm really all ears
for suggestions on this, it's quite difficult to make sure no current use-case
breaks and no heavy rework is needed in PHY drivers.

Patches 1, 2 and 3 are preparatory work for the mediums representation. Patch 4
introduces the phy_port and patch 5 shows an example of usage in the dp83822 phy.

Patch 6 is the new binding.

Thanks,

Maxime

[1]:https://lore.kernel.org/netdev/20241220201506.2791940-1-maxime.chevallier@bootlin.com/

Maxime Chevallier (6):
  net: ethtool: common: Make BaseT a 4-lanes mode
  net: ethtool: Introduce ETHTOOL_LINK_MEDIUM_* values
  net: ethtool: Export the link_mode_params definitions
  net: phy: Introduce PHY ports representation
  net: phy: dp83822: Add support for phy_port representation
  dt-bindings: net: Introduce the phy-port description

 .../devicetree/bindings/net/ethernet-phy.yaml |  18 ++
 .../bindings/net/ethernet-port.yaml           |  47 +++++
 drivers/net/phy/Makefile                      |   2 +-
 drivers/net/phy/dp83822.c                     |  63 +++---
 drivers/net/phy/phy_device.c                  | 167 +++++++++++++++
 drivers/net/phy/phy_port.c                    | 166 +++++++++++++++
 include/linux/ethtool.h                       |  73 +++++++
 include/linux/phy.h                           |  31 +++
 include/linux/phy_port.h                      |  69 ++++++
 net/ethtool/common.c                          | 197 ++++++++++--------
 net/ethtool/common.h                          |   7 -
 11 files changed, 716 insertions(+), 124 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/ethernet-port.yaml
 create mode 100644 drivers/net/phy/phy_port.c
 create mode 100644 include/linux/phy_port.h

-- 
2.48.1


