Return-Path: <netdev+bounces-184996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2FEA980DB
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 09:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1834C188B452
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 07:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C4F269885;
	Wed, 23 Apr 2025 07:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="SJjSNzMo"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807B4223DE4;
	Wed, 23 Apr 2025 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745393389; cv=none; b=W0w4pruvjQPZYjyN44nv85i8NAMY/bJEUYXY9UnzqBpSLWaUh5NkAu4knka5U8Wptxr+1qWnh724+IXoQHsM14A24PZmiTWjlDy/OKCJNhS4NMmbyvG4Z/bDoSF6vS/L/rExD6MtxEejtG727SQH+MShM/dqNq+DkbnfgZB4A4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745393389; c=relaxed/simple;
	bh=f9WnUHLwI7r5PxohoerOyRrhe9IoLi9FojqIHzXvEiU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lQnWlZ055d6AjqC25G2p6Y5hSkpB6sdoof3ku8vhBO86W1fNtL0qTXqFuOelaanycAvlkaHTGefwqARQVdqamuRvzXvoiQtOekEu6iXYTJP/wPSFa1Jsjjg319r9LtBa+pHR+l2W+T0OTvIN+5UpNkvXn4Wr8K76z7ZLto7MQag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=SJjSNzMo; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A985D102E13E3;
	Wed, 23 Apr 2025 09:29:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745393379; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=kvjT2AQfxdFmD9bmhbjX7G3FMB2UewEmBGLVIkkuwUE=;
	b=SJjSNzMoaRulgtXnVfnUhgtb8PRqAWhK9pQIc5i+ZWJi6CO6OOBTapSGhRtHwzvytJGQL4
	jaVPa9dr8qrWm75FakSpycPL6UUki6tiFotCqeXT73BdOfMXGVw6hcny8YM/S2TjKMvKqd
	LrbynugloIYP62dPsxwbukTTw8f9cbnQOEGM892gpZ92pdEKAabRG7OV16U36zDJPKsVcS
	9DVLeMgc2PiXS8rHG/eGo+Bqx5NRsvYgrXZzfKjdvhy32op+Yz1bn146FldSWlFXTFnCx1
	UxzGhRVwJjSYivu4/acCg92yzidV4AytiAEm9RhbV+V0lHfF7gK5DKDbOXXcTA==
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Lukasz Majewski <lukma@denx.de>
Subject: [net-next v7 0/7] net: mtip: Add support for MTIP imx287 L2 switch driver
Date: Wed, 23 Apr 2025 09:29:04 +0200
Message-Id: <20250423072911.3513073-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This patch series adds support for More Than IP's L2 switch driver embedded
in some NXP's SoCs. This one has been tested on imx287, but is also available
in the vf610.

In the past there has been performed some attempts to upstream this driver:

1. The 4.19-cip based one [1]
2. DSA based one for 5.12 [2] - i.e. the switch itself was treat as a DSA switch
   with NO tag appended.
3. The extension for FEC driver for 5.12 [3] - the trick here was to fully reuse
   FEC when the in-HW switching is disabled. When bridge offloading is enabled,
   the driver uses already configured MAC and PHY to also configure PHY.

All three approaches were not accepted as eligible for upstreaming.

The driver from this series has floowing features:

1. It is fully separated from fec_main - i.e. can be used interchangeable
   with it. To be more specific - one can build them as modules and
   if required switch between them when e.g. bridge offloading is required.

   To be more specific:
        - Use FEC_MAIN: When one needs support for two ETH ports with separate
          uDMAs used for both and bridging can be realized in SW.

        - Use MTIPL2SW: When it is enough to support two ports with only uDMA0
          attached to switch and bridging shall be offloaded to HW. 

2. This driver uses MTIP's L2 switch internal VLAN feature to provide port
   separation at boot time. Port separation is disabled when bridging is
   required.

3. Example usage:
        Configuration:
        ip link set lan0 up; sleep 1;
        ip link set lan1 up; sleep 1;
        ip link add name br0 type bridge;
        ip link set br0 up; sleep 1;
        ip link set lan0 master br0;
        ip link set lan1 master br0;
        bridge link;
        ip addr add 192.168.2.17/24 dev br0;
        ping -c 5 192.168.2.222

        Removal:
        ip link set br0 down;
        ip link delete br0 type bridge;
        ip link set dev lan1 down
        ip link set dev lan0 down

4. Limitations:
        - Driver enables and disables switch operation with learning and ageing.
        - Missing is the advanced configuration (e.g. adding entries to FBD). This is
          on purpose, as up till now we didn't had consensus about how the driver
          shall be added to Linux.

Links:
[1] - https://github.com/lmajewski/linux-imx28-l2switch/commits/master
[2] - https://github.com/lmajewski/linux-imx28-l2switch/tree/imx28-v5.12-L2-upstream-RFC_v1
[3] - https://source.denx.de/linux/linux-imx28-l2switch/-/tree/imx28-v5.12-L2-upstream-switchdev-RFC_v1?ref_type=heads

Lukasz Majewski (7):
  dt-bindings: net: Add MTIP L2 switch description
  ARM: dts: nxp: mxs: Adjust the imx28.dtsi L2 switch description
  ARM: dts: nxp: mxs: Adjust XEA board's DTS to support L2 switch
  net: mtip: The L2 switch driver for imx287
  ARM: mxs_defconfig: Enable CONFIG_NFS_FSCACHE
  ARM: mxs_defconfig: Update mxs_defconfig to 6.15-rc1
  ARM: mxs_defconfig: Enable CONFIG_FEC_MTIP_L2SW to support MTIP L2
    switch

 .../bindings/net/nxp,imx28-mtip-switch.yaml   |  148 ++
 MAINTAINERS                                   |    7 +
 arch/arm/boot/dts/nxp/mxs/imx28-xea.dts       |   56 +
 arch/arm/boot/dts/nxp/mxs/imx28.dtsi          |    9 +-
 arch/arm/configs/mxs_defconfig                |   13 +-
 drivers/net/ethernet/freescale/Kconfig        |    1 +
 drivers/net/ethernet/freescale/Makefile       |    1 +
 drivers/net/ethernet/freescale/mtipsw/Kconfig |   13 +
 .../net/ethernet/freescale/mtipsw/Makefile    |    3 +
 .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 1989 +++++++++++++++++
 .../net/ethernet/freescale/mtipsw/mtipl2sw.h  |  788 +++++++
 .../ethernet/freescale/mtipsw/mtipl2sw_br.c   |  120 +
 .../ethernet/freescale/mtipsw/mtipl2sw_mgnt.c |  449 ++++
 13 files changed, 3586 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/Kconfig
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/Makefile
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c

-- 
2.39.5


