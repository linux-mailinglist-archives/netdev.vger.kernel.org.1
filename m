Return-Path: <netdev+bounces-212807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85BD1B2214D
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2F43B1185
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 08:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A29B2E425B;
	Tue, 12 Aug 2025 08:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="b7uc+SQ2";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YLNtE3M1"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EC81EBFE0;
	Tue, 12 Aug 2025 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987418; cv=none; b=VBbiUF/G5/uJer+NLUqRtgZ8cuHTGaGjdmHI0AjZHt73oH3mXUO2KWxvW2DpyoK4Hro2Vbx7VFfKItHiFV+VOldgb/vdc4pM6aTsU31tFNHGeiUkxptVQgRLbp9fN+cOM4H2hkRiIwWIp4866bU71pIZwQJILhr/ftvdra1r69k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987418; c=relaxed/simple;
	bh=srE7D7L9/u192GanVekX3BUoJZpmRMxmHcUC88Pm87k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WgRnmzE/R7gmjqo8oIb+5tyMxGPinYjNgSFSY8BTfx6xsQsqR/FPmc/k30tHNTZ4HoWfnDTYVMuZLVmu8lDciwwAqTBxLFyakzYxpvpTP6SuUTz+n1/HQjjUlxVD1CS29pJENiro7txQgoa/yaQJ+gzU3I2TD4b3K9XujKmLwiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=b7uc+SQ2; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=YLNtE3M1; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4c1Pnx1429z9tBL;
	Tue, 12 Aug 2025 10:30:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1754987413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tim9zJqoan0tIu3OtmzB8FNQkJ8QRkYdTZJDAm99bA0=;
	b=b7uc+SQ2Ka+8MC4fMt0XYXLuZRclyEHTcpeb8TCmMiRbUd6FDysUiG+hRn31oAWWm2XUUa
	+5II3Z3bKYaeHIesSUicqOaBdm/LvgIa1z4OkSFulWG3DJddLixUSXHUuxIaHxz4OjK/GH
	YYbxQIEnv9/DZFzoDalgBCGRV//mbQl98QWCsjCYjsBt/RiMh2EvKcNsHWUjUFhWZ0dmXT
	6XdHF8usQ0eT8YXu8wcbjn4vuaorUw5S0eQ/qoPD2KkgqTi6FZowtqskcVfRdCvagxgycW
	sSvWkVJFm/s72PJk8aopJQ0d63Qampf4mto2w57WCx08OjPZrgFEistK/8ptWA==
From: Lukasz Majewski <lukasz.majewski@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1754987407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tim9zJqoan0tIu3OtmzB8FNQkJ8QRkYdTZJDAm99bA0=;
	b=YLNtE3M1jr6tXQT/j2NcOGu8yRK9EUNmvJkh7N9xq6hRv/iaZSAvs8ZzynH2a7RYWSpvdL
	8ssnstR4Ir4SOWiAWhjUTllbQVK2yB7vRXZIjM1pvUp/uxTcy2Er+DBG6903s5U0k4LyCl
	tdTQcS1Q7L6Q8K3Mq4upxsaC05uV6HdhLHV0WoRoh3J3IFz7Tq1XDBAYyPZ+dSUk2l4hns
	5/5PBgIc/7mSQutD9qoJsZY1+bmfS7gpZgKQtwqrMU8DJXDJlzVGCqX4Pxer9QMET4JTsK
	nyDbZlQsVug9WS23gCuoF6K4l1RPEUqBijSAfuA8asxKFwSMXnN4F1+cmyHxHw==
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
	Lukasz Majewski <lukasz.majewski@mailbox.org>
Subject: [net-next RESEND v17 00/12] net: mtip: Add support for MTIP imx287 L2 switch driver
Date: Tue, 12 Aug 2025 10:29:27 +0200
Message-Id: <20250812082939.541733-1-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: de84e7807fef554053a
X-MBO-RS-META: doyiq3bhgxpcouwn67ftdjd79ksdcesc

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

        make LLVM_SUFFIX=-19 LLVM=1 mrproper
        make LLVM_SUFFIX=-19 LLVM=1 allmodconfig
        make LLVM_SUFFIX=-19 LLVM=1 W=1 drivers/net/ethernet/freescale/mtipsw/ | tee llvm_build.log
        make LLVM_SUFFIX=-19 LLVM=1 W=1 -j8 | tee llvm_build.log

6. Kernel compliance checks:
	make coccicheck MODE=report J=4 M=drivers/net/ethernet/freescale/mtipsw/
	~/work/src/smatch/smatch_scripts/kchecker drivers/net/ethernet/freescale/mtipsw/

7. GCC
        make mrproper
        make allmodconfig
        make W=1 drivers/net/ethernet/freescale/mtipsw/

Links:
[1] - https://github.com/lmajewski/linux-imx28-l2switch/commits/master
[2] - https://github.com/lmajewski/linux-imx28-l2switch/tree/imx28-v5.12-L2-upstream-RFC_v1
[3] - https://source.denx.de/linux/linux-imx28-l2switch/-/tree/imx28-v5.12-L2-upstream-switchdev-RFC_v1?ref_type=heads


Lukasz Majewski (12):
  dt-bindings: net: Add MTIP L2 switch description
  ARM: dts: nxp: mxs: Adjust the imx28.dtsi L2 switch description
  ARM: dts: nxp: mxs: Adjust XEA board's DTS to support L2 switch
  net: mtip: The L2 switch driver for imx287
  net: mtip: Add buffers management functions to the L2 switch driver
  net: mtip: Add net_device_ops functions to the L2 switch driver
  net: mtip: Add mtip_switch_{rx|tx} functions to the L2 switch driver
  net: mtip: Extend the L2 switch driver with management operations
  net: mtip: Extend the L2 switch driver for imx287 with bridge
    operations
  ARM: mxs_defconfig: Enable CONFIG_NFS_FSCACHE
  ARM: mxs_defconfig: Update mxs_defconfig to 6.16-rc5
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
 .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 1962 +++++++++++++++++
 .../net/ethernet/freescale/mtipsw/mtipl2sw.h  |  651 ++++++
 .../ethernet/freescale/mtipsw/mtipl2sw_br.c   |  132 ++
 .../ethernet/freescale/mtipsw/mtipl2sw_mgnt.c |  443 ++++
 13 files changed, 3431 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/Kconfig
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/Makefile
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c

-- 
2.39.5


