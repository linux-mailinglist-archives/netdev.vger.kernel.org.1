Return-Path: <netdev+bounces-216335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CD3B3330E
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 00:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19D33207334
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 22:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50112459F8;
	Sun, 24 Aug 2025 22:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="o8nl4lxg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kdIUNEek"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E7C23B612;
	Sun, 24 Aug 2025 22:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756073296; cv=none; b=jM4ffv7qT0zd/KBap0t/VqHfBisdqK+7+xK1obAfJy+DOayRNNFLGHKNxtfpyIu7dXK3m4rhRKXCX59ETnq5dWGrofrOdaMNVo6RtjdAoxSPs7QhYbsgTSBbt54fm51zmfU8k1aqMb5DXYisEDIrlRadJSdjhaaaAwXQ/dyZv9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756073296; c=relaxed/simple;
	bh=lHTR5+yABEr38duqTzK4BTkDE46kvwmMNIop8UhLoA4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bjb2z3PbkBTmXyGB1lOG496CnSD70tickGYWyTyXE3/UfUkRUvq7IGwTq3sfDPUZjwGwvnuBFBUHY0VWpD9rQUtuj1bfg7XGqUUdEQYZo2moHv2u0tDpoW7KvMEeXboy7cN7igFOjFdfvsAKFkq9uXaTtoF/FiFbmM7fc/FGfMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=o8nl4lxg; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=kdIUNEek; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4c97N72r4Mz9tG1;
	Mon, 25 Aug 2025 00:08:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756073287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E3sqVzhFLKV5i/Tdp5YnbTV2avm7Uyp/iu5eoMFxSoE=;
	b=o8nl4lxgtjK1tdMjZREjbQX2t4nQ0nKoLEvxImNzcDERCndeFzWn/1tQx/ej3gdqiKodHA
	bDVo+MaD3NnJdAsH4UiFWk7dbp6onsszcKkrjkqxOj0jBdGxlDQYaAwY766KO7uNsrf01U
	98k226WQ3pV9ZZCmVS12zPHfnQTAa85rx+PP9MaIVE8+kVVwQAgNNNvJV3yVX5QCWuB9v6
	RmDx0P1wf9UlzPZBG6CtQ2sW8V9j1gKlGRcvz+uEDmo9j7nuQxMZKo+4J2M88mxVknjjR4
	0cxPpPdPjO4vee/ammEVoZB3bfkBSFvIrYcvzAFSczlA877hNLKVc+f7HN+O+Q==
From: Lukasz Majewski <lukasz.majewski@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756073285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E3sqVzhFLKV5i/Tdp5YnbTV2avm7Uyp/iu5eoMFxSoE=;
	b=kdIUNEekjnMaZDbJSQjSICIdvjosJvLBmrJ2dGOHM8PnSs8xeKqSuxapgUVRRZVxCJsl2J
	eZ3quJyUE6WpOTuoRtsEJ9/taMizyhANXDG9TG4qg96IQQcfVAD1BLA+Dm0QMJWwRBdeI5
	F+Wj15Uejr8X8M1A9rrKnt+e961Cv9+CFX8ZftaMZRgPcDXIyHRGR1TYBX6U9adZ7JGiax
	JDx+JeAmj+U8HU7ijUomg0/obeAgzURlN/GRV6ciDqV/XwxdDaHLSZnWZbpP57AjCR5cqv
	v4sNij6OUsqWRRwnrqxPHIBkqvQXi3kj5bRBp7NVoPdc+Z0ELmy7/O3QJtSJDQ==
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
Subject: [net-next v19 0/7] net: mtip: Add support for MTIP imx287 L2 switch driver
Date: Mon, 25 Aug 2025 00:07:29 +0200
Message-Id: <20250824220736.1760482-1-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 34da346fd6b5e7d2bbd
X-MBO-RS-META: gjb43brihfcxo4dw1be5tiq4fs7bf6r1

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

Lukasz Majewski (7):
  dt-bindings: net: Add MTIP L2 switch description
  net: mtip: The L2 switch driver for imx287
  net: mtip: Add buffers management functions to the L2 switch driver
  net: mtip: Add net_device_ops functions to the L2 switch driver
  net: mtip: Add mtip_switch_{rx|tx} functions to the L2 switch driver
  net: mtip: Extend the L2 switch driver with management operations
  net: mtip: Extend the L2 switch driver for imx287 with bridge
    operations

 .../bindings/net/nxp,imx28-mtip-switch.yaml   |  150 ++
 MAINTAINERS                                   |    7 +
 drivers/net/ethernet/freescale/Kconfig        |    1 +
 drivers/net/ethernet/freescale/Makefile       |    1 +
 drivers/net/ethernet/freescale/mtipsw/Kconfig |   13 +
 .../net/ethernet/freescale/mtipsw/Makefile    |    4 +
 .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 1984 +++++++++++++++++
 .../net/ethernet/freescale/mtipsw/mtipl2sw.h  |  651 ++++++
 .../ethernet/freescale/mtipsw/mtipl2sw_br.c   |  132 ++
 .../ethernet/freescale/mtipsw/mtipl2sw_mgnt.c |  443 ++++
 10 files changed, 3386 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/Kconfig
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/Makefile
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c

-- 
2.39.5


