Return-Path: <netdev+bounces-244608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8293CCBB545
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 01:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0546B300983E
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 00:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B416015ECD7;
	Sun, 14 Dec 2025 00:41:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03CF2EB10;
	Sun, 14 Dec 2025 00:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765672862; cv=none; b=H97OB5S78yEb7GguSa5JMhNZut/eJ9teP3ca/BNANTWW/zVNZlhgmAxlDpmG5pst8kQoRXIl1lxD08VNc+usNQPUibyJU5y3q3T84fdiTp+kzKOgy5+HdqfYW2jkQOqwH9tGKOrbS+Og0PkICKFN20lEDy7xHHR+5MMFYmbaNw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765672862; c=relaxed/simple;
	bh=KxcnItTyRqm0LRhEBw+W8qCpjohBWywOpOR/gma97Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LfoitWafaF8jYlR0LTtIhdQK9zB148+ZWtnNfk0sJUkMgp3pEfskVCmFJQm1AY9q9kudfOX+xo6qpNi6885ZOhCTNNsZ+nTsMWHo/tEwp80JqoqvNjYtOZ8TCWXXfsTRx3vCHmvCCcDYqV7jKyKqa56yEksU9IAeYHPYfZfw+z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vUaAG-000000006kv-1ze4;
	Sun, 14 Dec 2025 00:40:44 +0000
Date: Sun, 14 Dec 2025 00:40:40 +0000
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
Subject: [RFC PATCH v2 net-next 0/4] net: dsa: initial support for MaxLinear
 MxL862xx switches
Message-ID: <cover.1765671579.git.daniel@makrotopia.org>
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
 drivers/net/dsa/mxl862xx/mxl862xx-host.c      | 229 +++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx-host.h      |   4 +
 drivers/net/dsa/mxl862xx/mxl862xx.c           | 361 ++++++++++++++++++
 drivers/net/dsa/mxl862xx/mxl862xx.h           |  24 ++
 include/linux/mdio.h                          |  13 +
 include/net/dsa.h                             |   2 +
 net/dsa/Kconfig                               |   7 +
 net/dsa/Makefile                              |   1 +
 net/dsa/tag_mxl862xx.c                        | 113 ++++++
 17 files changed, 1088 insertions(+)
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

