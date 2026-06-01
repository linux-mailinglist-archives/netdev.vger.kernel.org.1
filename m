Return-Path: <netdev+bounces-293700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGUtDg9uHWrlagkAu9opvQ
	(envelope-from <netdev+bounces-293700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:33:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A68E761E5E6
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 243243016B97
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 11:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6CC360ED5;
	Mon,  1 Jun 2026 11:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sVBx+ZPl";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="X8h5eiYk"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC6035E953;
	Mon,  1 Jun 2026 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780313563; cv=none; b=HbwD7TMz9gEIagTZT5blniGYh2ZJGX3elUG72omSg3pz4RwMQL4bD/MjnTW0Rsfj4YBD3VKMtmZ+U9UaYURsW2hmhjO66U61RFLyOlpbFlqhFRlubhbXdITyYi9DuCLZWdR3CtG6YEc1LRTnoCsMBZaNRZelHsAtYRFdTPWMzFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780313563; c=relaxed/simple;
	bh=jDZ35an42v1a6D8XAJeWmnrKss2NVTM1YSxd6gMMgZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GvuDNWijT4bRv5hbReJhFlno3g93Wh73gdOHf4GRKwhiVWNpyGAf8L802C1r0ee673cnxYZlPjqgYJokG674rEvG0ju8TdaIPIk7AadezTICy4MAQ9cpqJUYO1X2jZjwbBBMtaMV0MWlfUdRb7RTwHoa/Uca6T2sOzDDZmCYA8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=sVBx+ZPl; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=X8h5eiYk; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gTWpk0ccdz9tfX;
	Mon,  1 Jun 2026 13:25:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780313118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TckpevEDXvsiLT9gSo/NXB3/PFN+b7qd8kin63AE6NM=;
	b=sVBx+ZPlkp4VWVAm7WxruTkfk6IeJKjSLE4xpyNRT9gPixVIb4sBktRXVCVlaLo9fM4tF/
	lJU73eHts98v2hFxI3DT6MmGNLEjVs4j0TE5PJekJhBMsjMyTrfetWkKuOirIWl9Glue94
	VxcZW2d/csft6kxQ4/il5D3HUVQT2msOunFZ/shGDS9hCb/quyTOTbIDl8dtk6EGyiVsXn
	am2iDlEu4HFdYsjP79ttItTt95qDKPH3CdltL771RHcTHv+A7zlnIsr037cfTf6o3uPFjf
	Hz/PRD1ZNLH38w7DxoMJ34cklzt2a154/yXQbihvLN3utGmFKpKA/F4MJE1F+Q==
From: Lukasz Majewski <lukasz.majewski@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1780313116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TckpevEDXvsiLT9gSo/NXB3/PFN+b7qd8kin63AE6NM=;
	b=X8h5eiYkUEDXFT6Khl7e9LB/COTfrk5c262xb3Rv77cgS+OgNRj4SwK/A+RkuhO/yPLg3G
	kK9wK73Ww4u+Pou+yEEHWcCxSt6uvTnDcgA/I5wCSQwOc7saEwY9PLX5/Fpuw0W9SewyCU
	4X8n0MeEOh+uw06HzCK/PZ9dmGzVRge7dbQaxgfRztzhyHaKFabhptF9aXjG1xQYSf6KFU
	d76u+xHhdf5ntyu2CNH56Sg3x2wIotlnubBif57Pq31OH/66VBSAvFSjulNcVnDd5tSyvN
	fPgzoKZfEBaz8Mr4m7URv+JRxt8INwWHvVCO4uMX70ur+N+MHgD0UoggXQRg6w==
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Lukasz Majewski <lukasz.majewski@mailbox.org>
Subject: [net-next v24 0/7] net: mtip: Add support for MTIP imx287 L2 switch driver
Date: Mon,  1 Jun 2026 13:24:29 +0200
Message-ID: <20260601112437.2216043-1-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: k5gagsrmkhe77hpt495k77pa5tyem791
X-MBO-RS-ID: 7653ccd1b5e3ceaed63
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,lists.linux.dev,lists.infradead.org,mailbox.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-293700-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.majewski@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mailbox.org:mid,mailbox.org:dkim]
X-Rspamd-Queue-Id: A68E761E5E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

The driver from this series has following features:

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
          However, on top of this patch set the code with SWITCHDEV support (v6.6.
          PREEMPT_RT enabled) has been implemented in [4].

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
        make allmodconfig; ~/work/src/smatch/smatch_scripts/kchecker drivers/net/ethernet/freescale/mtipsw/

7. GCC:
        make mrproper
        make allmodconfig
        make W=1 drivers/net/ethernet/freescale/mtipsw/

        
        [source OE/Yocto SDK build environment]
        CROSS_COMPILE=arm-poky-linux-gnueabi- ARCH=arm make mrproper
        cp ./arch/arm/configs/mxs_defconfig .config
        CROSS_COMPILE=arm-poky-linux-gnueabi- ARCH=arm make menuconfig
        CROSS_COMPILE=arm-poky-linux-gnueabi- ARCH=arm make -j8 LOADADDR=0x40008000 uImage dtbs

8. DT_SCHEMA checks:
        source ~/.venv/bin/activate
        source /opt/poky/3.1.31/environment-setup-armv5e-poky-linux-gnueabi
        make dt_binding_check DT_SCHEMA_FILES=nxp,imx28-mtip-switch.yaml
        make CHECK_DTBS=y DT_SCHEMA_FILES=nxp,imx28-mtip-switch.yaml nxp/mxs/imx28-xea.dtb


Links:
[1] - https://github.com/lmajewski/linux-imx28-l2switch/commits/master
[2] - https://github.com/lmajewski/linux-imx28-l2switch/tree/imx28-v5.12-L2-upstream-RFC_v1
[3] - https://github.com/lmajewski/linux-imx28-l2switch/commits/imx28-v5.12-L2-upstream-RFC_v1
[4] - https://github.com/lmajewski/linux-imx28-l2switch/commits/vf610-linux-6.6.y-mtipl2sw


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
 .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 2046 +++++++++++++++++
 .../net/ethernet/freescale/mtipsw/mtipl2sw.h  |  648 ++++++
 .../ethernet/freescale/mtipsw/mtipl2sw_br.c   |  138 ++
 .../ethernet/freescale/mtipsw/mtipl2sw_mgnt.c |  442 ++++
 10 files changed, 3450 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/Kconfig
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/Makefile
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c

-- 
2.39.5


