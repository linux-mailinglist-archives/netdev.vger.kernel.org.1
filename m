Return-Path: <netdev+bounces-192557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054C0AC0645
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 09:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D343B4863
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 07:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F8824E4B3;
	Thu, 22 May 2025 07:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="GqYR1D95"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD9E241136;
	Thu, 22 May 2025 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747900524; cv=none; b=LBuMPPh+kwLeNt4uj/HefoT3NEKnkXyFK9RfAppHiGvn1b7sm/cnHUHjaHZJT1paxqqUX2TV58FABchXu3xGlVMQFZRN7+ollSV4YBgs6quK2dD5WSrVkRH+1VDzV9cAtkVaH66ZW0RO41z0I+Zy1zvYhC3dHDoOjQGEOE5uJYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747900524; c=relaxed/simple;
	bh=LQlF5YVK7B0Bdj6cq5MWXvYwRFxsOIq4rPYtjbNmgas=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o54baS/+JkKpETtXJo30v/20tbEfK0XrDcLs8nPLX6Rsm+dhLW/Bc7d1hJPM4dpj+04vzJVEh4fIyhAuX+EeHnyl2Cs7vmonvsXi3bM5AwudHaFJ4zf0Ilqvh4J6w8h29KpFgM8ZE8cZtFp0i6gUrOCR1mSE+pbIn63DyT8PtJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=GqYR1D95; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CFE531039728C;
	Thu, 22 May 2025 09:55:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1747900518; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=MJ7lmCjvK1+80wMyjFPNbT67zAQdNUXvibJ0absooOs=;
	b=GqYR1D95VJg8+Gf8v8ZUt8ueqV6Mj7VHimGEBqcDn/m5ExL5v/yifBtD5ouHnRbmEiZKt9
	EmwZg4eazBwUxCtgKhjfFO2XpIiEMhlQfj5Mc3Mh1uId17/FUEE63zeP48CX7EwZksqDPj
	8vjDdFbsEHhtK/TP0q9CE9g88HBTwErYBbvNzl00GYoF4hU+KCTQZD0OpWP/nMixgk45VN
	HMqqjitecI+53WwRj1Lg3aVAO96SPE3w+1OijjLuvKcAVmpcjgdxOJLiDRH6ftqiMg+LcE
	n3tM2uXFsA0T+JpJ23CgVAxdvkONPoTZ4jH7+0yyJqgFY1tb2pBB94VRWdCQug==
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
Subject: [net-next v12 0/7] net: mtip: Add support for MTIP imx287 L2 switch driver
Date: Thu, 22 May 2025 09:54:48 +0200
Message-Id: <20250522075455.1723560-1-lukma@denx.de>
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

5. Clang build:
	make LLVM_SUFFIX=-19 LLVM=1 mrproper
	cp ./arch/arm/configs/mxs_defconfig .config
	make ARCH=arm LLVM_SUFFIX=-19 LLVM=1 W=1 menuconfig
	make ARCH=arm LLVM_SUFFIX=-19 LLVM=1 W=1 -j8 LOADADDR=0x40008000 uImage dtbs

6. Kernel compliance checks:
	make coccicheck MODE=report J=4 M=drivers/net/ethernet/freescale/mtipsw/
	~/work/src/smatch/smatch_scripts/kchecker drivers/net/ethernet/freescale/mtipsw/


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

 .../bindings/net/nxp,imx28-mtip-switch.yaml   |  150 ++
 MAINTAINERS                                   |    7 +
 arch/arm/boot/dts/nxp/mxs/imx28-xea.dts       |   56 +
 arch/arm/boot/dts/nxp/mxs/imx28.dtsi          |    9 +-
 arch/arm/configs/mxs_defconfig                |   13 +-
 drivers/net/ethernet/freescale/Kconfig        |    1 +
 drivers/net/ethernet/freescale/Makefile       |    1 +
 drivers/net/ethernet/freescale/mtipsw/Kconfig |   13 +
 .../net/ethernet/freescale/mtipsw/Makefile    |    4 +
 .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 1970 +++++++++++++++++
 .../net/ethernet/freescale/mtipsw/mtipl2sw.h  |  771 +++++++
 .../ethernet/freescale/mtipsw/mtipl2sw_br.c   |  120 +
 .../ethernet/freescale/mtipsw/mtipl2sw_mgnt.c |  436 ++++
 13 files changed, 3540 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/Kconfig
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/Makefile
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c

-- 
2.39.5


