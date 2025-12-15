Return-Path: <netdev+bounces-244659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ACECBC244
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 01:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 207BF3005E9F
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 00:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3522E8E09;
	Mon, 15 Dec 2025 00:26:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC0F288C2C;
	Mon, 15 Dec 2025 00:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765758415; cv=none; b=PGn8EHLYN/BZf+7W+ObCvFvZwnmfh9arvNzs5nyxN4Hh0Kz2XhaVYEA3iHMQknd4rTzH/ajpdNWiuk0ltbGx0EGVnp0ut8OlFlAD3mM/XZsE2DPQ5kIsk63g1ZrXAsH8sNaISYZkqB0WZHpO0UGad1n3GlS36HZiSuuOEt5beuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765758415; c=relaxed/simple;
	bh=u35lqsNDh0hGEaRE+XE6Hhfpn4HUkb37YMhZXeV8vMI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CF7YTnJV2rQPbajP2fIVk9mxkUK07LYe7CDEyXBfL+68WYlJgOfTalCmv6bthQzDP1Nn4JWETti5spLo3TQcPn1Nr9hgALYdjdrK+ABf5tKRCCtyHOTTGWte5xzxoAhvSeff4JHIj4upnzqbSZLrz56OphWVNaqEvYziMHCaMqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vUwBG-000000002IO-2Ysp;
	Mon, 15 Dec 2025 00:11:14 +0000
Date: Mon, 15 Dec 2025 00:11:10 +0000
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
Subject: [PATCH RFC net-next v3 0/4] net: dsa: initial support for MaxLinear
 MxL862xx switches
Message-ID: <cover.1765757027.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This series adds very basic DSA support for the MaxLinear MxL86252
(5 PHY ports) and MxL86282 (8 PHY ports) switches. The intent is to
validate and get feedback on the overall approach and driver structure,
especially the firmware-mediated host interface.

MxL862xx integrates a firmware running on an embedded processor (Zephyr
RTOS). Host interaction uses a simple API transported over MDIO/MMD.
This series includes only what's needed to pass traffic between user
ports and the CPU port: relayed MDIO to internal PHYs, basic port
enable/disable, and CPU-port special tagging.

Thanks for taking a look.

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
  dt-bindings: net: dsa: add bindings for MaxLinear MxL862xx
  net: dsa: add tag formats for MxL862xx switches
  net: mdio: add unlocked mdiodev C45 bus accessors
  net: dsa: add basic initial driver for MxL862xx switches

 .../bindings/net/dsa/maxlinear,mxl862xx.yaml  | 162 ++++++++
 MAINTAINERS                                   |   8 +
 drivers/net/dsa/Kconfig                       |   2 +
 drivers/net/dsa/Makefile                      |   1 +
 drivers/net/dsa/mxl862xx/Kconfig              |  12 +
 drivers/net/dsa/mxl862xx/Makefile             |   3 +
 drivers/net/dsa/mxl862xx/mxl862xx-api.h       | 118 ++++++
 drivers/net/dsa/mxl862xx/mxl862xx-cmd.h       |  28 ++
 drivers/net/dsa/mxl862xx/mxl862xx-host.c      | 230 +++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-host.h      |   4 +
 drivers/net/dsa/mxl862xx/mxl862xx.c           | 361 ++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx.h           |  24 ++
 include/linux/mdio.h                          |  13 +
 include/net/dsa.h                             |   2 +
 net/dsa/Kconfig                               |   7 +
 net/dsa/Makefile                              |   1 +
 net/dsa/tag_mxl862xx.c                        | 113 ++++++
 17 files changed, 1089 insertions(+)
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

