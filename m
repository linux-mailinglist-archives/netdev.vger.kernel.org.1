Return-Path: <netdev+bounces-235055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5791DC2B9A5
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 13:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9713B5CE2
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 12:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B2230B53E;
	Mon,  3 Nov 2025 12:17:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830CF309F19;
	Mon,  3 Nov 2025 12:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762172242; cv=none; b=hg+aNs3sZ7HyTC37eADVxXVw+TGgMYtBMLRfZjbp8FJ1U9+ydll8buxohrTc/ZAfSZMUF92khMlL9Z53O7CKPC8zxQPo7s0ZS6xz7HlKQx6R74q3zJgfdaaSFb7pYZuon3Amhe2uedAkWCvAJXNcdDi7lNUBWb20/rkT3MG4m+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762172242; c=relaxed/simple;
	bh=r4clbohuTPPXLe6DG+pud0HumqwBz3tzaQBhQxQRLNA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RiBX4d3Hxh0gGMqFM0mfDRa8IDB4Cc4e4b4aS97NhEAqJ5RUEZM/ASScjIq7jVQ9gRFmT3pkbfvKY8tSyNxPEc/yIpnldRS2rqiMvo33FR7QEqGomzvnEGN6DgaEwICsiNC2FEi2pUSq5S/aCrWDh1aVm005057m3SDP9LE3p14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vFtUb-000000000ma-1azG;
	Mon, 03 Nov 2025 12:17:01 +0000
Date: Mon, 3 Nov 2025 12:16:57 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v7 00/12] net: dsa: lantiq_gswip: Add support for
 MaxLinear GSW1xx switch family
Message-ID: <cover.1762170107.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch series extends the existing lantiq_gswip DSA driver to
support the MaxLinear GSW1xx family of dedicated Ethernet switch ICs.
These switches are based on the same IP as the Lantiq/Intel GSWIP found
in VR9 and xRX MIPS router SoCs which are currently supported by the
lantiq_gswip driver, but they are dedicated ICs connected via MDIO
rather than built-in components of a SoC accessible via memory-mapped
I/O.

The series includes several improvements and refactoring to implement
support for GSW1xx switch ICs by reusing the existing lantiq_gswip
driver.

The GSW1xx family includes several variants:
 - GSW120: 4 ports, 2 PHYs, RGMII & SGMII/2500Base-X
 - GSW125: 4 ports, 2 PHYs, RGMII & SGMII/2500Base-X, industrial temperature
 - GSW140: 6 ports, 4 PHYs, RGMII & SGMII/2500Base-X
 - GSW141: 6 ports, 4 PHYs, RGMII & SGMII
 - GSW145: 6 ports, 4 PHYs, RGMII & SGMII/2500Base-X, industrial temperature

Key features implemented:
 - MDIO-based register access using regmap
 - Support for SGMII/1000Base-X/2500Base-X SerDes interfaces
 - Configurable RGMII delays via device tree properties
 - Configurable RMII clock direction
 - Energy Efficient Ethernet (EEE) support
 - enabling/disabling learning
---
Series history:
 v7:
  * improve cover letter
  * complete documentation of series history, add lore links
  * dt-bindings: put patternProperties: after properties: to follow
    standardized order
  * dt-bindings: drop the addition of 'reg-names' to the list of
    required properties and also don't add it to the existing example

 v6: https://lore.kernel.org/all/cover.1761938079.git.daniel@makrotopia.org/
  * keep properties on top level and use allOf for
    conditional constraints
  * switch order of patches, move deviation from
    dsa.yaml#/$defs/ethernet-ports to this patch which actually
    needs it

 v5: https://lore.kernel.org/all/cover.1761823194.git.daniel@makrotopia.org/
  * dt-bindings: drop maxlinear,rx-inverted from example

 v4: https://lore.kernel.org/all/cover.1761693288.git.daniel@makrotopia.org/
  * break out PCS reset into dedicated function
  * drop hacky support for reverse-SGMII
  * remove again the custom properties for TX and RX inverted SerDes
    PCS in favor of waiting for generic properties to land
  * use __be16 to access tag fields
  * define ETH_P_MXLGSW in if_ether.h
  * drop *_SHIFT macros, get rid of _MASK suffix, use FIELD helpers
  * print tag using %8ph
  * drop maxlinear,rx-inverted and maxlinear,tx-inverted properties for
    now in favor of upcoming generic properties
  * rework to use legacy codepath as fallback for RGMII delays
  * set GSWIP_MII_CFG_RMII_CLK bit in RMII case inside the switch
    statement instead of a (wrong) if-clause just below
  * keep previous behavior regarding GSWIP_TABLE_MAC_BRIDGE_VAL1_VALID
    for GSWIP 2.1 and earlier, this has been clarified by MaxLinear
    engineers
  * remove misleading default delays

 v3: https://lore.kernel.org/all/cover.1761521845.git.daniel@makrotopia.org/
  * avoid disrupting link when calling .pcs_config()
  * sort functions and phylink_pcs_ops instance in same order as
    struct definition
  * always set bootstrap override bits and add explanatory comment
  * move definitions to separate header file
  * add custom properties for TX and RX inverted data on the SerDes
    interface
  * dt-bindings: redefine ports node so properties which are defined
    actually apply
  * dt-bindings: describe RGMII port with 2ps delay as 'rgmii-id' in
    example

 v2: https://lore.kernel.org/all/cover.1761402873.git.daniel@makrotopia.org/
  * removed left-overs of 4k VLAN support
  * fix use of uninitialized variable
  * remove git conflict left-overs which has somehow creeped into
    dt-bindings
  * indent dt-bindings example with 4 spaces instead of tabs

 v1: https://lore.kernel.org/all/cover.1761324950.git.daniel@makrotopia.org/
  * preparations have been merged in several separate series:

    https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=f0a24b2547cfdd5ec85a131e386a2ce4ff9179cb

    https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=88224095b4e512b027289183f432c0e84925d648

    https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=764a47a639c73e8d941cbbb10696a0eb98d10d7b

    https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=1d8f0059091e757973324ae76253c2c059e0810f

    https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=6e8e6baf16ce7d2310959ae81d0194a56874e0d2

  * comments received for the tag_max-gsw.c driver have been addressed

 RFC: https://lore.kernel.org/all/aKDhFCNwjDDwRKsI@pidgin.makrotopia.org/

Daniel Golle (12):
  net: dsa: lantiq_gswip: split into common and MMIO parts
  net: dsa: lantiq_gswip: support enable/disable learning
  net: dsa: lantiq_gswip: support Energy Efficient Ethernet
  net: dsa: lantiq_gswip: set link parameters also for CPU port
  net: dsa: lantiq_gswip: define and use
    GSWIP_TABLE_MAC_BRIDGE_VAL1_VALID
  dt-bindings: net: dsa: lantiq,gswip: add MaxLinear RMII refclk output
    property
  net: dsa: lantiq_gswip: add vendor property to setup MII refclk output
  dt-bindings: net: dsa: lantiq,gswip: add support for MII delay
    properties
  net: dsa: lantiq_gswip: allow adjusting MII delays
  dt-bindings: net: dsa: lantiq,gswip: add support for MaxLinear GSW1xx
    switches
  net: dsa: add tagging driver for MaxLinear GSW1xx switch family
  net: dsa: add driver for MaxLinear GSW1xx switch family

 .../bindings/net/dsa/lantiq,gswip.yaml        |  164 +-
 MAINTAINERS                                   |    3 +-
 drivers/net/dsa/lantiq/Kconfig                |   18 +-
 drivers/net/dsa/lantiq/Makefile               |    2 +
 drivers/net/dsa/lantiq/lantiq_gswip.c         | 1617 +--------------
 drivers/net/dsa/lantiq/lantiq_gswip.h         |   20 +
 drivers/net/dsa/lantiq/lantiq_gswip_common.c  | 1737 +++++++++++++++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.c           |  733 +++++++
 drivers/net/dsa/lantiq/mxl-gsw1xx.h           |  126 ++
 drivers/net/dsa/lantiq/mxl-gsw1xx_pce.h       |  154 ++
 include/net/dsa.h                             |    2 +
 include/uapi/linux/if_ether.h                 |    1 +
 net/dsa/Kconfig                               |    8 +
 net/dsa/Makefile                              |    1 +
 net/dsa/tag_mxl-gsw1xx.c                      |  116 ++
 15 files changed, 3101 insertions(+), 1601 deletions(-)
 create mode 100644 drivers/net/dsa/lantiq/lantiq_gswip_common.c
 create mode 100644 drivers/net/dsa/lantiq/mxl-gsw1xx.c
 create mode 100644 drivers/net/dsa/lantiq/mxl-gsw1xx.h
 create mode 100644 drivers/net/dsa/lantiq/mxl-gsw1xx_pce.h
 create mode 100644 net/dsa/tag_mxl-gsw1xx.c

-- 
2.51.2

