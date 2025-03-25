Return-Path: <netdev+bounces-177336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE3DA6FA91
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027861893B58
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 11:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2942571C5;
	Tue, 25 Mar 2025 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="fdCItleR"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F4D2566C5;
	Tue, 25 Mar 2025 11:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903901; cv=none; b=qB9a/b15tZJAEVFwWDemflK71uMuIkmu//nACRurs27S/JRXPKC/9uIhulM8T+u+sGZy3ykbsM4aHbVh7gqmRaI9CmdvLGRl5kHho3FREVafhQbkVf9Lrq7NNEeJVtvTUzpbWD13qs+2HSkZTnZnM9Ejot8KbJcVs3vsMmauALc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903901; c=relaxed/simple;
	bh=ogJk0gjbecFlaa/OaLnvGTB/fbFW9JECh0LpYnOG8qk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=opo81TPoGsJAT4ePLLB6Zhi8dbO1IvE4e/UiYrAr9xea2Vih97q5C74PygW/t6Y6fwcN4ZH6uY003sfv+k8ILty5eubm1brU7Nv00oNWOKBUfDCmYn81hm4Wbqm851jGI7UZBHIPOItCdZV/Yy6hoLyZ94xmOW+8X8YIWDTN4/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=fdCItleR; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F1137102F66FF;
	Tue, 25 Mar 2025 12:58:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742903894; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=Pd9Mb9EGjiorJmqfD3xt+UhIpKbj2X3/flEfWMUs8j4=;
	b=fdCItleRY1ScOnEWpELgucVdXlUxLkQHTIfzCcdGcfmnKj9LIP5nqvDTQUjO46Act2J8NC
	D3TshBfu8viiqbsirGHG+tzbX4JjgHHVWY3k87i/TeAFBWlMGtiEKIs+CLp79iOhOQaorq
	DSbttWnBdJgrBX1HYkpTo0joXGpUA4wICUColKwuVWy+/kDTClinxRHbgOecQz/gxyFuSK
	d79YH9ol4ywqqkHip+Dhvl9DGl2qCSbQgAggPHfEr2LZD7nJQD2e6pnbck6pxWcjEP896U
	O++eo3dIRIAVVuv9FXLyYIHwuMxHyifWZTr1LcQ14iMhj6weVQz04GziUWr+og==
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	davem@davemloft.net,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 0/5] net: mtip: Add support for MTIP imx287 L2 switch driver
Date: Tue, 25 Mar 2025 12:57:31 +0100
Message-Id: <20250325115736.1732721-1-lukma@denx.de>
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



Lukasz Majewski (5):
  MAINTAINERS: Add myself as the MTIP L2 switch maintainer (IMX SoCs:
    imx287)
  dt-bindings: net: Add MTIP L2 switch description
    (fec,mtip-switch.yaml)
  arm: dts: Adjust the 'reg' range for imx287 L2 switch description
  arm: dts: imx287: Provide description for MTIP L2 switch
  net: mtip: The L2 switch driver for imx287

 .../bindings/net/fec,mtip-switch.yaml         |  160 ++
 MAINTAINERS                                   |    7 +
 arch/arm/boot/dts/nxp/mxs/imx28-xea.dts       |   56 +
 arch/arm/boot/dts/nxp/mxs/imx28.dtsi          |    4 +-
 drivers/net/ethernet/freescale/Kconfig        |    1 +
 drivers/net/ethernet/freescale/Makefile       |    1 +
 drivers/net/ethernet/freescale/mtipsw/Kconfig |   10 +
 .../net/ethernet/freescale/mtipsw/Makefile    |    6 +
 .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 2108 +++++++++++++++++
 .../net/ethernet/freescale/mtipsw/mtipl2sw.h  |  784 ++++++
 .../ethernet/freescale/mtipsw/mtipl2sw_br.c   |  113 +
 .../ethernet/freescale/mtipsw/mtipl2sw_mgnt.c |  434 ++++
 12 files changed, 3682 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/fec,mtip-switch.yaml
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/Kconfig
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/Makefile
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c

-- 
2.39.5


