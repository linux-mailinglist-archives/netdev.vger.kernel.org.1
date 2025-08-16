Return-Path: <netdev+bounces-214325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 502FFB2904A
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 21:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E48171784
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 19:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C58212575;
	Sat, 16 Aug 2025 19:51:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA11621018A;
	Sat, 16 Aug 2025 19:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755373869; cv=none; b=qjWeHclGRoy642PD126m06l4O91f5kKxA/3tqnHMeSOFSnRWabzsnEiyFP4Wkpzvo9Qq1v60KErFgrDJNRP5GTSd8bxRb2HaxafZnGRYyrkHaRHEekyfGT6w1dPdXPWRDN0liUtHkC0qZhPRv0cmmzVCZpDSTJm2HTv9kPynAhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755373869; c=relaxed/simple;
	bh=RBbQrtRwehhemxLdMv5fjf08owk+Wvkmgcq4c5VJSAg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XXxC54eV137NflDyNbeqEjY6ZVHxhvQPPfhaInAGzmynscaSZo7pN3LI/sL2DgDl0Asq/Jt9Yz3UXlEhzJ7JYZzq7Wh/aWr+BJNU0TmRzebT2Xr7zau/NDXQtV8nIw7n9JrWiVOmhMR9u0bu4pKmIsrfQV3q613cL8BVzQ1VkWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1unMvQ-000000006vj-3naq;
	Sat, 16 Aug 2025 19:50:49 +0000
Date: Sat, 16 Aug 2025 20:50:44 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Arkadi Sharshevsky <arkadis@mellanox.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
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
Subject: [PATCH RFC net-next 00/23] net: dsa: lantiq_gswip: Add support for
 MaxLinear GSW1xx switch family
Message-ID: <aKDhFCNwjDDwRKsI@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch series extends the existing lantiq_gswip DSA driver to support
the MaxLinear GSW1xx family of dedicated Ethernet switch ICs. These switches
are based on the same IP as the Lantiq/Intel GSWIP found in VR9 and xRX
MIPS router SoCs, but are connected via MDIO instead of memory-mapped I/O.

The series includes several improvements and refactoring to prepare for the
new hardware support.

The GSW1xx family includes several variants:
- GSW120: 4 ports, 2 PHYs, RGMII & SGMII/2500Base-X
- GSW125: 4 ports, 2 PHYs, RGMII & SGMII/2500Base-X, industrial temperature
- GSW140: 6 ports, 4 PHYs, RGMII & SGMII/2500Base-X  
- GSW141: 6 ports, 4 PHYs, RGMII & SGMII
- GSW145: 6 ports, 4 PHYs, RGMII & SGMII/2500Base-X, industrial temperature

Key features implemented:
- MDIO-based register access using regmap
- Support for SGMII/1000Base-X/2500Base-X SerDes interfaces
- Configurable MII delays via device tree properties
- Energy Efficient Ethernet (EEE) support
- 4096 VLAN support on newer API versions
- Assisted learning on CPU port

This is submitted as RFC to gather feedback on the approach, particularly
regarding the prefered order of things, ie. should I first introduce all
features (some are already supported on GRX3xx), then split into MDIO and
common parts, then add new hardware like I did now, or rather first split
into MDIO and common parts, then add new hardware support and then new
features would follow (maybe even in follow series)?

Basic testing has be carried out on the GSW145 reference board, confirming
everything works as fine as it does on older Lantiq GSWIP hardware.
Brief testing also showed that nothing breaks on Lantiq VR9 (VRX208),
testing on slightly newer Intel GRX330 hardware is going to follow.

As Vladimir Oltean is working on a series of patches improving lantiq_gswip
the first patch of this series is likely to be replaced by his work and can
be ignored for now. I've included it anyway for completeness as that is also
what I have been testing.

Daniel Golle (23):
  net: dsa: lantiq_gswip: honor dsa_db passed to port_fdb_{add,del}
  net: dsa: lantiq_gswip: deduplicate dsa_switch_ops
  net: dsa: lantiq_gswip: prepare for more CPU port options
  net: dsa: lantiq_gswip: move definitions to header
  net: dsa: lantiq_gswip: introduce bitmaps for port types
  net: dsa: lantiq_gswip: load model-specific microcode
  net: dsa: lantiq_gswip: make DSA tag protocol model-specific
  net: dsa: lantiq_gswip: store switch API version in priv
  net: dsa: lantiq_gswip: add support for SWAPI version 2.3
  net: dsa: lantiq_gswip: support enable/disable learning
  net: dsa: lantiq_gswip: support Energy Efficient Ethernet
  net: dsa: lantiq_gswip: support 4k VLANs on API 2.2 or later
  net: dsa: lantiq_gswip: support model-specific mac_select_pcs()
  net: dsa: lantiq_gswip: support GSW1xx offset of MII register
  net: dsa: lantiq_gswip: allow adjusting MII delays
  net: dsa: lantiq_gswip: support standard MDIO node name
  net: dsa: lantiq_gswip: move MDIO bus registration to .setup()
  net: dsa: lantiq_gswip: convert to use regmap
  net: dsa: lantiq_gswip: split into common and MMIO parts
  net: dsa: lantiq_gswip: add registers specific for MaxLinear GSW1xx
  net: dsa: add tagging driver for MaxLinear GSW1xx switch family
  net: dsa: add driver for MaxLinear GSW1xx switch family
  net: dsa: lantiq_gswip: ignore SerDes modes in phylink_mac_config()

 drivers/net/dsa/Kconfig               |   17 +
 drivers/net/dsa/Makefile              |    2 +
 drivers/net/dsa/lantiq_gswip.c        | 1933 ++-----------------------
 drivers/net/dsa/lantiq_gswip.h        |  408 ++++++
 drivers/net/dsa/lantiq_gswip_common.c | 1778 +++++++++++++++++++++++
 drivers/net/dsa/lantiq_pce.h          |    9 +-
 drivers/net/dsa/mxl-gsw1xx.c          |  710 +++++++++
 drivers/net/dsa/mxl-gsw1xx_pce.h      |  160 ++
 include/net/dsa.h                     |    2 +
 net/dsa/Kconfig                       |    8 +
 net/dsa/Makefile                      |    1 +
 net/dsa/tag_mxl-gsw1xx.c              |  141 ++
 12 files changed, 3331 insertions(+), 1838 deletions(-)
 create mode 100644 drivers/net/dsa/lantiq_gswip.h
 create mode 100644 drivers/net/dsa/lantiq_gswip_common.c
 create mode 100644 drivers/net/dsa/mxl-gsw1xx.c
 create mode 100644 drivers/net/dsa/mxl-gsw1xx_pce.h
 create mode 100644 net/dsa/tag_mxl-gsw1xx.c

-- 
2.50.1

