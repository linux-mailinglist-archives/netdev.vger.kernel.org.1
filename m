Return-Path: <netdev+bounces-178105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E48C7A74B88
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 14:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A117F17DCB4
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 13:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF4B171092;
	Fri, 28 Mar 2025 13:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Jc5SfFfI"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4E715CD52;
	Fri, 28 Mar 2025 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743168975; cv=none; b=u+cax3ICKNlZZ4aI7QZ0WXvHc9Pg6JeE12ewca/QRfkyN3kx5VDklwUsP7Oklhr9/PxBbZbw9esK3wrlD2KZwlkCTva7Y5tE0fuMNTzfarayZ+9GcKtV/9GHOUjfPxbnGG0TFIXaCxT1aoO6Pn4zagSHld/RxLdfZ2MgQBPOz1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743168975; c=relaxed/simple;
	bh=sg8GirSessSombdIMsdHhlACalS+O1hf1X1t1pS/Jp4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MPkyaF36V6lWUFAZ+SJtPD+Z+lZUoGrg3Hg+sCYKZfx/zWboCFPjF//2wt/zkMlDvGC1c71dgA8n6o7Acr//4ZWsqf0U4f5CQugQcl9m3xKUfKns6QFl45c4RiBfraAckxaZNDC1L8DUxqtKXwnd8hXBuYbFoRCv2UoUlK98bAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Jc5SfFfI; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 31E27102F66E1;
	Fri, 28 Mar 2025 14:36:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743168970; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=qWMAPF3cn5kbOxEyMVJ11xNUGCsLYuxca09lazB+vpY=;
	b=Jc5SfFfI1ScBlnW5dChUdugdylxUiZJIcW46lbQRMaPpm+9RrERCnZDNEfn+YuIYLsvCea
	8gFtgGdQvNqPt0hFmO6wiiguFOEvjbwY0HUzS0ZG08j/2x2dRTuJPgCuZx3vAe/FVQLLKp
	mfOFJVx0hFvfh9tAnvn62Q8VTp0+cUBLAWQ2x62J7CkUtihOZhzaolJ/dxXYtd6GMZE3WE
	3+pKyV/V0ba9F0NffL/x6yf5Trmuqmo5vTO8bI98e94G+1vJAeUGmovaaupTEXAKV3pxsi
	bBecfae6BTEN0PF51+g7ZjUE3mxMtncQSPbZgs4V36TmaGBC4G7M3K3nSVQurg==
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
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 0/4] net: mtip: Add support for MTIP imx287 L2 switch driver
Date: Fri, 28 Mar 2025 14:35:40 +0100
Message-Id: <20250328133544.4149716-1-lukma@denx.de>
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


Lukasz Majewski (4):
  dt-bindings: net: Add MTIP L2 switch description
  ARM: dts: nxp: mxs: Adjust the imx28.dtsi L2 switch description
  ARM: dts: nxp: mxs: Adjust XEA board's DTS to support L2 switch
  net: mtip: The L2 switch driver for imx287

 .../bindings/net/nxp,imx287-mtip-switch.yaml  |  165 ++
 MAINTAINERS                                   |    7 +
 arch/arm/boot/dts/nxp/mxs/imx28-xea.dts       |   54 +
 arch/arm/boot/dts/nxp/mxs/imx28.dtsi          |    8 +-
 drivers/net/ethernet/freescale/Kconfig        |    1 +
 drivers/net/ethernet/freescale/Makefile       |    1 +
 drivers/net/ethernet/freescale/mtipsw/Kconfig |   13 +
 .../net/ethernet/freescale/mtipsw/Makefile    |    3 +
 .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 2035 +++++++++++++++++
 .../net/ethernet/freescale/mtipsw/mtipl2sw.h  |  781 +++++++
 .../ethernet/freescale/mtipsw/mtipl2sw_br.c   |  113 +
 .../ethernet/freescale/mtipsw/mtipl2sw_mgnt.c |  449 ++++
 12 files changed, 3628 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,imx287-mtip-switch.yaml
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/Kconfig
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/Makefile
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c

-- 
2.39.5


