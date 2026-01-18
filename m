Return-Path: <netdev+bounces-250795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD59D39293
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 04:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 108B9300C345
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 03:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B3330DECE;
	Sun, 18 Jan 2026 03:45:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFFC30CD95;
	Sun, 18 Jan 2026 03:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768707915; cv=none; b=Y6iX7G5G3du041++6RNnpmPrPJhJeKOZrl8/u+1M/7mqfnS/VwzG6HNBIXzfE/rmdPZleRaAe11MPdELuuxBVfX9tDzj3w1Di92VNzbzli7tR9n1DqQxTozS/kEPRztMjFLjjhrcvIneiM/EdXTRFErbPvOc7W+eC7f5ICQBBvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768707915; c=relaxed/simple;
	bh=D9CWzrFKG52MIuAC8LLe36eiQ7AE3riIFpkAsoidNtM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dnfw4IBKYzQ6BvJ25Nvr/bJsIdI31bpO130uxAo6vZ7VeJdVdrwBAd95zSxQsKbXBFPx3O+wsmyOgCPQ6oYhqlNTPf5IAWNTrIXCon6BfxkaeqPu76QH3KO3MvTbsvLCOAQtDuGVDEdRt3ovOFt7ooXOdRxIK/mEK3GpoHOZ5vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vhJiq-000000000ih-2ACI;
	Sun, 18 Jan 2026 03:45:04 +0000
Date: Sun, 18 Jan 2026 03:44:54 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH v7 net-next 0/4] net: dsa: initial support for MaxLinear
 MxL862xx switches
Message-ID: <cover.1768707226.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This series adds very basic DSA support for the MaxLinear MxL86252
(5 PHY ports) and MxL86282 (8 PHY ports) switches.

MxL862xx integrates a firmware running on an embedded processor (running
Zephyr RTOS). Host interaction uses a simple netlink-like API transported
over MDIO/MMD.

This series includes only what's needed to pass traffic between user
ports and the CPU port: relayed MDIO to internal PHYs, basic port
enable/disable, and CPU-port special tagging.

Follow up series will bring bridge, VLAN, ... offloading, and support
for using a 802.1Q-based special tag instead of the proprietary 8-byte
tag.
---
basic DSA selftests were run, results:
 * no_forwarding.sh: all tests PASS
 * bridge_vlan_unaware.sh: all tests PASS
 * bridge_vlan_mcast.sh: all tests PASS
 * bridge_vlan_aware.sh: all tests PASS
 * local_termination.sh: all tests PASS or XFAIL, except for
TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address   [FAIL]
        reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address, allmulti   [FAIL]
        reception succeeded, but should have failed

As obviously this is mostly testing the Linux software bridge at this point
I didn't bother to run any of the FDB or MDB related tests.

Changes since v6
1/4 dt-bindings: net: dsa: add MaxLinear MxL862xx
 * no changes
2/4 net: dsa: add tag format for MxL862xx switches
 * no changes
3/4 net: mdio: add unlocked mdiodev C45 bus accessors
 * no changes
4/4 net: dsa: add basic initial driver for MxL862xx switches
 * fix kerneldoc style


Changes since RFC v5
1/4 dt-bindings: net: dsa: add MaxLinear MxL862xx
 * no changes

2/4 net: dsa: add tag format for MxL862xx switches
 * remove unnecessary check for skb != NULL
 * merge consecutively printed warnings into single dev_warn_ratelimited

3/4 net: mdio: add unlocked mdiodev C45 bus accessors
 * no changes

4/4 net: dsa: add basic initial driver for MxL862xx switches
 * include bridge and bridgeport API needed to isolate ports
 * remove warning in .setup as ports are now isolated
 * make ready-after-reset check more robust by adding delay
 * sort structs in order of struct definitions
 * best effort to sort functions without introducing additional prototypes
 * always use enums with kerneldoc comments in mxl862xx-api.h
 * remove bogus .phy_read and .phy_write DSA ops as the driver anyway registers
   a user MDIO bus with Clause-22 and Clause-45 operations
 * various small style fixes

Changes since RFC v4
1/4 dt-bindings: net: dsa: add MaxLinear MxL862xx
 * no changes

2/4 net: dsa: add tag format for MxL862xx switches
 * drop unused precompiler macros

3/4 net: mdio: add unlocked mdiodev C45 bus accessors
 * fix indentation

4/4 net: dsa: add basic initial driver for MxL862xx switches
 * output warning in .setup regarding unknown pre-configuration
 * add comment explaining why CFGGET is used in reset function


Changes since RFC v3
1/4 dt-bindings: net: dsa: add MaxLinear MxL862xx
 * remove labels from example
 * remove 'bindings for' from commit title

2/4 net: dsa: add tag format for MxL862xx switches
 * describe fields and variables with comments
 * sub-interface is only 5 bits
 * harmonize Kconfig symbol name
 * maintain alphabetic order in Kconfig
 * fix typo s/beginnig/beginning/
 * fix typo s/swtiches/switches/
 * arrange local variables in reverse xmas tree order

3/4 net: mdio: add unlocked mdiodev C45 bus accessors
 * unchanged

4/4 net: dsa: add basic initial driver for MxL862xx switches
 * poll switch readiness after reset
 * implement driver shutdown
 * added port_fast_aging API call and driver op
 * unified port setup in new .port_setup op
 * improve comment explaining special handlign for unaligned API read
 * various typos and formatting improvements


Changes since RFC v2
1/4, 2/4, 3/4: unchanged

4/4 net: dsa: add basic initial driver for MxL862xx switches
 * fix return value being uninitialized on error in mxl862xx_api_wrap()
 * add missing description in kerneldoc comment of
   struct mxl862xx_ss_sp_tag


Changes since initial RFC

1/4 dt-bindings: net: dsa: add bindings for MaxLinear MxL862xx
 * better description in dt-bindings doc

2/4 net: dsa: add tag formats for MxL862xx switches
 * make sure all tag fields are initialized

3/4 net: mdio: add unlocked mdiodev C45 bus accessors
 * new patch

4/4 net: dsa: add basic initial driver for MxL862xx switches
 * make use of struct mdio_device
 * add phylink_mac_ops stubs
 * drop leftover nonsense from mxl862xx_phylink_get_caps()
 * fix endian conversions
 * use __le32 instead of enum types in over-the-wire structs
 * use existing MDIO_* macros whenever possible
 * simplify API constants to be more readable
 * use readx_poll_timeout instead of open-coding poll timeout loop
 * add mxl862xx_reg_read() and mxl862xx_reg_write() helpers
 * demystify error codes returned by the firmware
 * add #defines for mxl862xx_ss_sp_tag member values
 * move reset to dedicated function, clarify magic number being the
   reset command ID


Daniel Golle (4):
  dt-bindings: net: dsa: add MaxLinear MxL862xx
  net: dsa: add tag format for MxL862xx switches
  net: mdio: add unlocked mdiodev C45 bus accessors
  net: dsa: add basic initial driver for MxL862xx switches

 .../bindings/net/dsa/maxlinear,mxl862xx.yaml  | 154 ++++++
 MAINTAINERS                                   |   8 +
 drivers/net/dsa/Kconfig                       |   2 +
 drivers/net/dsa/Makefile                      |   1 +
 drivers/net/dsa/mxl862xx/Kconfig              |  12 +
 drivers/net/dsa/mxl862xx/Makefile             |   3 +
 drivers/net/dsa/mxl862xx/mxl862xx-api.h       | 521 ++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h       |  44 ++
 drivers/net/dsa/mxl862xx/mxl862xx-host.c      | 230 ++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-host.h      |   5 +
 drivers/net/dsa/mxl862xx/mxl862xx.c           | 498 +++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx.h           |  25 +
 include/linux/mdio.h                          |  13 +
 include/net/dsa.h                             |   2 +
 net/dsa/Kconfig                               |   7 +
 net/dsa/Makefile                              |   1 +
 net/dsa/tag_mxl862xx.c                        | 112 ++++
 17 files changed, 1638 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/maxlinear,mxl862xx.yaml
 create mode 100644 drivers/net/dsa/mxl862xx/Kconfig
 create mode 100644 drivers/net/dsa/mxl862xx/Makefile
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-api.h
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-host.c
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx-host.h
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx.c
 create mode 100644 drivers/net/dsa/mxl862xx/mxl862xx.h
 create mode 100644 net/dsa/tag_mxl862xx.c

-- 
2.52.0

