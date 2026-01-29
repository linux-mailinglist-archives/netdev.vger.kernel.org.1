Return-Path: <netdev+bounces-254749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEpAGhg/e2mNCwIAu9opvQ
	(envelope-from <netdev+bounces-254749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:06:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13027AF637
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 12:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A734B3012E81
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 11:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC2D385536;
	Thu, 29 Jan 2026 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="IH+14h2j";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="QXgUMiy2"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90785356A0E;
	Thu, 29 Jan 2026 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769684553; cv=none; b=emJG2NbzNNs/QxeTUnhufRy245/ttL2GlQdogjZAnY0TFQEutdS9lMVp3iIfST7Mj2lJJ9vE7R17scnVSJdjI0A1Ovt1aeC2Gs2+865/gzDo9SB/ZmwPR4xkq0llPAcfy0FuV9I9k+bUJzKCOWDNM1O0y5EygKhPUl+j3w7fz2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769684553; c=relaxed/simple;
	bh=tONPc9hzB6jMfsjEda8KVc3XR9PMY1AWXjpVBWAXNRg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DfHCdI9QNccJCdWhFTaFpNiEVTI7VuUSv0KA6BjitKOH6YPNFfdZ3YVMlzWhViW4HrZHOmmXBGZmyiiMwNiQltm2p4f/MTHYtxl5TRf96KVO9W0DkZYlTe70fg18gxIUXhCfEkjTAB7G+ZnCui62kj8vuSdGhpZKenR3OLqiqLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=IH+14h2j; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=QXgUMiy2; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f1x793YDDz9vCZ;
	Thu, 29 Jan 2026 12:02:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1769684549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MA6Ut00LW++ic/Us0JJXgLnoZo0SRLSn0wVnaN1tGFM=;
	b=IH+14h2jAXZ59xxKiQW7uvqgvbGR6e0i91bdY34hCpHeIztXQoWUIKvWe/CHthIgXLLUDF
	6hx/UX7X0hRRDn7zYjY9ahlpmCaIY3cID/UJpWA//+G2PLg3kQxkF8Ki3tdgyf489ogNzR
	7ledCo+yHAYRdDLgJH2Q72Fp1AdST0SUaYOksWaKWS1QyRgIU59t/XIHp44sBC6iwM1fgg
	9N+YX8RIcJGk58RsDbmNcC+op9rINALLFssNEVxJwZGyXZUupNhev2M0iBmWn/pfXgTl+I
	V0CMxq6l/wU9JMW9PC0/VXMWUVN95WlhCZFUAyYrPyVVRL/dF3nQwNgJ++moDA==
From: Lukasz Majewski <lukasz.majewski@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1769684547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MA6Ut00LW++ic/Us0JJXgLnoZo0SRLSn0wVnaN1tGFM=;
	b=QXgUMiy2y+3XnJdNVQu4btaNa/PO90wlcLid8sWkMc8AVYv11Kr7Ue+voeGo+6REuyTbrt
	eTztN0YLBNx0oP/k4uA9vxFG4TJXlstZ78h1TZ/tpU9k+GKxuLq28sLvUDey17HuUdEaib
	8pTTsGXu1vMdL/ijk5ZQ3A7MmOd1eh4j7HjveTl9Hvfg2p1qxU6lzTUxfn1xDbTp+M2XKi
	49Nt/uIqTb+QITAovbULBNaeE9+xndVnjc+JLbinvU1w8OaYLKGqsHYv/nPHH5lQv95Z6j
	VngnqJfMQXxV+VroAfxyy5R34LQ593sUmXfEPz361YqAWASOQeva0eLMWEyvWA==
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
Subject: [net-next v21 0/7] net: mtip: Add support for MTIP imx287 L2 switch driver
Date: Thu, 29 Jan 2026 12:01:47 +0100
Message-Id: <20260129110154.1699976-1-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: qe8ni4omdgeehm9sz99pijumdche3xpy
X-MBO-RS-ID: 07305b32d9288a1fe30
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org,gmx.net,kernel.org,mailbox.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-254749-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.majewski@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:mid,mailbox.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,denx.de:url]
X-Rspamd-Queue-Id: 13027AF637
X-Rspamd-Action: no action


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
[3] - https://source.denx.de/linux/linux-imx28-l2switch/-/tree/imx28-v5.12-L2-upstream-switchdev-RFC_v1?ref_type=heads
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
 .../net/ethernet/freescale/mtipsw/mtipl2sw.c  | 2006 +++++++++++++++++
 .../net/ethernet/freescale/mtipsw/mtipl2sw.h  |  648 ++++++
 .../ethernet/freescale/mtipsw/mtipl2sw_br.c   |  136 ++
 .../ethernet/freescale/mtipsw/mtipl2sw_mgnt.c |  443 ++++
 10 files changed, 3409 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,imx28-mtip-switch.yaml
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/Kconfig
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/Makefile
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw.h
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_br.c
 create mode 100644 drivers/net/ethernet/freescale/mtipsw/mtipl2sw_mgnt.c

-- 
2.39.5


