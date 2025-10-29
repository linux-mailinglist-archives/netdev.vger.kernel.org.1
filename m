Return-Path: <netdev+bounces-233711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC67C17804
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 592D91AA351D
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC361FF7C8;
	Wed, 29 Oct 2025 00:16:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C805A1EEE6;
	Wed, 29 Oct 2025 00:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761697012; cv=none; b=QlY4059HE6cIwCQsEtaJ1SJ8S9tuTVcy4eXify1imNAbikIIG6wVsPWu7k7Nl/+p/QD+7RWj0TCL19bSUa+FwF7W/qpbTMgI5m8nWsmziNIC2zFEz2BOPvGM2XXl3dLBcmsRnHFq56fzH+8bQ0OsH4wEbycAhcS8BBYPQO0CR0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761697012; c=relaxed/simple;
	bh=3YgYwC7txpShnJatR7AU3bd/YUQxdw7XP633EE01xPc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fbUlki7TyqWXDc0ibh7mbDw7xkorRjnURR3yt5H81pkI6t7ljkOt4o3eqguDJywKgfhBqKaaMc4uu6t9paCA3teK9lYN7AQVsC76w6eBjsfyeKCplA6R8EDehoQHSaA1IuMNCzVi5jNTpzl9EAkrd/tkTSTlQq3ZhZaq51BVQ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vDtrd-0000000049R-0Njq;
	Wed, 29 Oct 2025 00:16:33 +0000
Date: Wed, 29 Oct 2025 00:16:29 +0000
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
Subject: [PATCH net-next v4 00/12] net: dsa: lantiq_gswip: Add support for
 MaxLinear GSW1xx switch family
Message-ID: <cover.1761693288.git.daniel@makrotopia.org>
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
 - Configurable RGMII delays via device tree properties
 - Configurable RMII clock direction
 - Energy Efficient Ethernet (EEE) support
 - enabling/disabling learning

Daniel Golle (12):
  net: dsa: lantiq_gswip: split into common and MMIO parts
  net: dsa: lantiq_gswip: support enable/disable learning
  net: dsa: lantiq_gswip: support Energy Efficient Ethernet
  net: dsa: lantiq_gswip: set link parameters also for CPU port
  net: dsa: lantiq_gswip: define and use
    GSWIP_TABLE_MAC_BRIDGE_VAL1_VALID
  dt-bindings: net: dsa: lantiq,gswip: add support for MII delay
    properties
  net: dsa: lantiq_gswip: allow adjusting MII delays
  dt-bindings: net: dsa: lantiq,gswip: add MaxLinear RMII refclk output
    property
  net: dsa: lantiq_gswip: add vendor property to setup MII refclk output
  dt-bindings: net: dsa: lantiq,gswip: add support for MaxLinear GSW1xx
    switches
  net: dsa: add tagging driver for MaxLinear GSW1xx switch family
  net: dsa: add driver for MaxLinear GSW1xx switch family

 .../bindings/net/dsa/lantiq,gswip.yaml        |  301 ++-
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
 15 files changed, 3171 insertions(+), 1668 deletions(-)
 create mode 100644 drivers/net/dsa/lantiq/lantiq_gswip_common.c
 create mode 100644 drivers/net/dsa/lantiq/mxl-gsw1xx.c
 create mode 100644 drivers/net/dsa/lantiq/mxl-gsw1xx.h
 create mode 100644 drivers/net/dsa/lantiq/mxl-gsw1xx_pce.h
 create mode 100644 net/dsa/tag_mxl-gsw1xx.c

-- 
2.51.1

