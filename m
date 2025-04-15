Return-Path: <netdev+bounces-182981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8D7A8A80D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 21:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73CFA7A386B
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FCF23C390;
	Tue, 15 Apr 2025 19:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N1oM4jQ4"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE215236424
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 19:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744745620; cv=none; b=Bk/Lt0Bodx77IPB+o/OLYWthPRKusMeVnDwqvzNJ05ofjJks/qKhueBYM6Mul4ZANgfVy15GGbAMYZW9AP/7TPpAvIc8bcs2y7gIfKaIyMs+ymb0cl03R36WEC/qwKetGrBie6dksuV1cNgHDEVs6Iu/UzLR+/gzSMPF8+sAHGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744745620; c=relaxed/simple;
	bh=Ts5bo86tTtwh2s23VSxkoMpFV1QQK3cEiprWvTS1MHo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k09kPXJTk1uvBBkld8SY/GnJdo12CEMolSZe9cW2lBaoacu8r5gFloI2+N/cyy4cVPP4KOIfsNCHl3jKrzBO9zSIH4UdRNGtXfLqFwlGoGEOmkEnQKEeFP/dfx+PLd1Fra3n+NAtc/kL75LwRNU14oX/1jA90XAR6JGu1ajHLf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N1oM4jQ4; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744745615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T0s7laNZe+Ra4wMHJ2pL3MTfBGq+kD5jv59e6Nhd28g=;
	b=N1oM4jQ4Lwu92X2S0t05SGm7yatDoaajqQms2NTdODIoyDLQrtVFgaxaPCaFUGyl80a7PJ
	/3eLC+yEjKRSjFz69q115+HcJ+BPeEjGZZKWzq8HNID5laWJxe7m7hMGA7zIW5XjdxrAPl
	rj8kk3uDjUTj0DAomRbaE2mSjGR1v8A=
From: Sean Anderson <sean.anderson@linux.dev>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: upstream@airoha.com,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Beznea <claudiu.beznea@microchip.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Joyce Ooi <joyce.ooi@intel.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Rob Herring <robh+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Robert Hancock <robert.hancock@calian.com>,
	Saravana Kannan <saravanak@google.com>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [net-next PATCH v3 00/11] Add PCS core support
Date: Tue, 15 Apr 2025 15:33:12 -0400
Message-Id: <20250415193323.2794214-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series adds support for creating PCSs as devices on a bus with a
driver (patch 3). As initial users,

- The Lynx PCS (and all of its users) is converted to this system (patch 5)
- The Xilinx PCS is broken out from the AXI Ethernet driver (patches 6-8)
- The Cadence MACB driver is converted to support external PCSs (namely
  the Xilinx PCS) (patches 9-10).

To build documentation without errors, this series requires commit
de258fa8ca8d ("scripts: kernel-doc: fix parsing function-like typedefs
(again)"), currently applied to docs-next [1].

Care has been taken to ensure backwards-compatibility. The main source
of this is that many PCS devices lack compatibles and get detected as
PHYs. To address this, pcs_get_by_fwnode_compat allows drivers to edit
the devicetree to add appropriate compatibles.

There is another series [2] with the same goal by Christian Marangi. In
comparison, I believe this series

- Implements a simpler and more-robust method of PCS access.
- Provides a more-direct upgrade path for existing MAC and PCS drivers.

[1] https://lore.kernel.org/all/e0abb103c73a96d76602d909f60ab8fd6e2fd0bd.1744106242.git.mchehab+huawei@kernel.org/
[2] https://lore.kernel.org/netdev/20250406221423.9723-1-ansuelsmth@gmail.com/

Changes in v3:
- Add '>' modifier for paragraph to description
- Adjust axienet_xilinx_pcs_get for changes to pcs_find_fwnode API
- Drop patches destined for other trees, as they have either already
  been applied or are no longer necessary.
- Edit description to reference clocks instead of resets
- Remove support for #pcs-cells. Upon further investigation, the
  requested functionality can be accomplished by specifying the PCS's
  fwnode manually.
- Select PCS_XILINX unconditionally

Changes in v2:
- Add fallbacks for pcs_get* and pcs_put
- Add support for #pcs-cells
- Change base compatible to just xlnx,pcs
- Change compatible to just xlnx,pcs
- Defer devicetree updates for another series
- Drop #clock-cells description
- Drop PCS_ALTERA_TSE which was accidentally added while rebasing
- Move #clock-cells after compatible
- Move update to macb_pcs_get_state to previous patch
- Remove outdated comment
- Remove second example
- Remove unused variable
- Remove unused variable lynx_properties
- Rename pcs-modes to xlnx,pcs-modes
- Reorder pcs_handle to come before suffix props
- Reword commit message
- Rework xilinx_pcs_validate to just clear out half-duplex modes instead
  of constraining modes based on the interface.

Sean Anderson (10):
  dt-bindings: net: Add Xilinx PCS
  net: phylink: Support setting PCS link change callbacks
  net: pcs: Add subsystem
  net: pcs: lynx: Convert to an MDIO driver
  net: phy: Export some functions
  net: pcs: Add Xilinx PCS driver
  net: axienet: Convert to use PCS subsystem
  net: macb: Move most of mac_config to mac_prepare
  net: macb: Support external PCSs
  of: property: Add device link support for PCS

Vladimir Oltean (1):
  net: dsa: ocelot: suppress PHY device scanning on the internal MDIO
    bus

 .../devicetree/bindings/net/xilinx,pcs.yaml   | 114 +++
 Documentation/networking/index.rst            |   1 +
 Documentation/networking/kapi.rst             |   4 +
 Documentation/networking/pcs.rst              | 102 +++
 MAINTAINERS                                   |   8 +
 drivers/net/dsa/ocelot/Kconfig                |   4 +
 drivers/net/dsa/ocelot/felix_vsc9959.c        |  15 +-
 drivers/net/dsa/ocelot/seville_vsc9953.c      |  16 +-
 drivers/net/ethernet/altera/Kconfig           |   2 +
 drivers/net/ethernet/altera/altera_tse_main.c |   7 +-
 drivers/net/ethernet/cadence/macb.h           |   1 +
 drivers/net/ethernet/cadence/macb_main.c      | 229 ++++--
 drivers/net/ethernet/freescale/dpaa/Kconfig   |   2 +-
 drivers/net/ethernet/freescale/dpaa2/Kconfig  |   3 +
 .../net/ethernet/freescale/dpaa2/dpaa2-mac.c  |  11 +-
 drivers/net/ethernet/freescale/enetc/Kconfig  |   2 +
 .../net/ethernet/freescale/enetc/enetc_pf.c   |   8 +-
 .../net/ethernet/freescale/enetc/enetc_pf.h   |   1 -
 .../freescale/enetc/enetc_pf_common.c         |   4 +-
 drivers/net/ethernet/freescale/fman/Kconfig   |   4 +-
 .../net/ethernet/freescale/fman/fman_memac.c  |  27 +-
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   3 +
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |   6 +-
 drivers/net/ethernet/xilinx/Kconfig           |   7 +
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |   4 +-
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 104 +--
 drivers/net/pcs/Kconfig                       |  44 +-
 drivers/net/pcs/Makefile                      |   4 +
 drivers/net/pcs/core.c                        | 690 ++++++++++++++++++
 drivers/net/pcs/pcs-lynx.c                    | 110 +--
 drivers/net/pcs/pcs-xilinx.c                  | 477 ++++++++++++
 drivers/net/phy/mdio_device.c                 |   1 +
 drivers/net/phy/phy_device.c                  |   3 +-
 drivers/net/phy/phylink.c                     |  24 +-
 drivers/of/property.c                         |   2 +
 include/linux/pcs-lynx.h                      |  13 +-
 include/linux/pcs-xilinx.h                    |  15 +
 include/linux/pcs.h                           | 193 +++++
 include/linux/phy.h                           |   1 +
 include/linux/phylink.h                       |  27 +-
 40 files changed, 1997 insertions(+), 296 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/xilinx,pcs.yaml
 create mode 100644 Documentation/networking/pcs.rst
 create mode 100644 drivers/net/pcs/core.c
 create mode 100644 drivers/net/pcs/pcs-xilinx.c
 create mode 100644 include/linux/pcs-xilinx.h
 create mode 100644 include/linux/pcs.h

-- 
2.35.1.1320.gc452695387.dirty


