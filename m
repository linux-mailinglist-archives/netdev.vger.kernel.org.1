Return-Path: <netdev+bounces-124480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F43969A8D
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59471C22DF3
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 10:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA581B9859;
	Tue,  3 Sep 2024 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ndHqJMPa"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A6D1A3AA3;
	Tue,  3 Sep 2024 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360467; cv=none; b=qFdx2i226qxWAhRPA+GQGZno/1SYlRgtmmOqVgz4uKwMMNWrkZmlq27mDMfCI8tlr8GsEuulaQTKBapCZPSnTDDNHwRV9AajgBMXFFabYmN+eM8D5zpKY2qbBkuL301L3rA99b2ld6ad8M9gi7vpoOb1LTz4QSzLtcNrMnKYGLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360467; c=relaxed/simple;
	bh=wyZXp4Md/MFngzkw68Lepo2K/SE40gk0xDZRG/0y18Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OBd6A1pdVm8vNcMzxrhTH3G3WOmhpX9Rr1bDVKQjRr3dsGIIW0eBJNSnqREhJzAQQza1Z0bsCqZQPjZi9R10XYCJvOsrpMcJshYbB67rpr2NP7q22djVU4hdf9+66cckY7FkX14b87+ZrlAc46sIxPHxIxinosPxZAyIbuMNBLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ndHqJMPa; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725360464; x=1756896464;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wyZXp4Md/MFngzkw68Lepo2K/SE40gk0xDZRG/0y18Q=;
  b=ndHqJMPaAUIRGexqrmky7H/PnV+UhT25qpX1/2Ds5LQ+Bfk2pseyY8vW
   rKrjYJvYegB/RuamsoV+YLHvIjO9Jvw2JUNVNuIb2Rq4TG+RSSaaauE+h
   YtCCAfAa9qRIxo8CO99NQeSzsb5Vz/YAd7VTDeKMvKPrSjJGYknTrtQFU
   fwprGQOZLT0xNsTHeXCbeR3ae1ThBC01rl/VgweNCp2pPFnkWieQvye+M
   hdObMxG2HVd6PG2jUhhSello0PztPBQeH4cLf0OJrIZ/KMK7f4+9VU3ZC
   C4iGpDOvPgtohj8EbyWjBpa776QoUhYhNvNPLtwjKvWyChsSmykDo+tya
   Q==;
X-CSE-ConnectionGUID: gMxGs1AKRjyzUsZY+6HQ0g==
X-CSE-MsgGUID: 45r109pJQu2E3EaRsjyMMQ==
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="34314848"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Sep 2024 03:47:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 3 Sep 2024 03:47:21 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 3 Sep 2024 03:47:11 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <horatiu.vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <steen.hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>
CC: <parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>,
	<alexanderduyck@fb.com>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<rdunlap@infradead.org>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<linux@bigler.io>, <markku.vorne@kempower.com>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v7 00/14] Add support for OPEN Alliance 10BASE-T1x MACPHY Serial Interface
Date: Tue, 3 Sep 2024 16:16:51 +0530
Message-ID: <20240903104705.378684-1-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series contain the below updates,
- Adds support for OPEN Alliance 10BASE-T1x MACPHY Serial Interface in the
  net/ethernet/oa_tc6.c.
  Link to the spec:
  -----------------
  https://opensig.org/download/document/OPEN_Alliance_10BASET1x_MAC-PHY_Serial_Interface_V1.1.pdf

- Adds driver support for Microchip LAN8650/1 Rev.B1 10BASE-T1S MACPHY
  Ethernet driver in the net/ethernet/microchip/lan865x/lan865x.c.
  Link to the product:
  --------------------
  https://www.microchip.com/en-us/product/lan8650

Testing Details:
----------------
The driver performance was tested using iperf3 in the below two setups
separately.

Setup 1:
--------
Node 0 - Raspberry Pi 4 with LAN8650 MAC-PHY 
Node 1 - Raspberry Pi 4 with EVB-LAN8670-USB USB Stick

Setup 2:
--------
Node 0 - SAMA7G54-EK with LAN8650 MAC-PHY 
Node 1 - Raspberry Pi 4 with EVB-LAN8670-USB USB Stick

Achieved maximum of 9.4 Mbps.

Some systems like Raspberry Pi 4 need performance mode enabled to get the
proper clock speed for SPI. Refer below link for more details.

https://github.com/raspberrypi/linux/issues/3381#issuecomment-1144723750

Changes:
v2:
- Removed RFC tag.
- OA TC6 framework configured in the Kconfig and Makefile to compile as a
  module.
- Kerneldoc headers added for all the API methods exposed to MAC driver.
- Odd parity calculation logic updated from the below link,
  https://elixir.bootlin.com/linux/latest/source/lib/bch.c#L348
- Control buffer memory allocation moved to the initial function.
- struct oa_tc6 implemented as an obaque structure.
- Removed kthread for handling mac-phy interrupt instead threaded irq is
  used.
- Removed interrupt implementation for soft reset handling instead of
  that polling has been implemented.
- Registers name in the defines changed according to the specification
  document.
- Registers defines are arranged in the order of offset and followed by
  register fields.
- oa_tc6_write_register() implemented for writing a single register and
  oa_tc6_write_registers() implemented for writing multiple registers.
- oa_tc6_read_register() implemented for reading a single register and
  oa_tc6_read_registers() implemented for reading multiple registers.
- Removed DRV_VERSION macro as git hash provided by ethtool.
- Moved MDIO bus registration and PHY initialization to the OA TC6 lib.
- Replaced lan865x_set/get_link_ksettings() functions with
  phy_ethtool_ksettings_set/get() functions.
- MAC-PHY's standard capability register values checked against the
  user configured values.
- Removed unnecessary parameters validity check in various places.
- Removed MAC address configuration in the lan865x_net_open() function as
  it is done in the lan865x_probe() function already.
- Moved standard registers and proprietary vendor registers to the
  respective files.
- Added proper subject prefixes for the DT bindings.
- Moved OA specific properties to a separate DT bindings and corrected the
  types & mistakes in the DT bindings.
- Inherited OA specific DT bindings to the LAN865x specific DT bindings.
- Removed sparse warnings in all the places.
- Used net_err_ratelimited() for printing the error messages.
- oa_tc6_process_rx_chunks() function and the content of oa_tc6_handler()
  function are split into small functions.
- Used proper macros provided by network layer for calculating the
  MAX_ETH_LEN.
- Return value of netif_rx() function handled properly.
- Removed unnecessary NULL initialization of skb in the
  oa_tc6_rx_eth_ready() function removed.
- Local variables declaration ordered in reverse xmas tree notation.

v3:
- Completely redesigned all the patches.
- Control and data interface patches are divided into multiple small
  patches.
- Device driver APIs added in the oa-tc6-framework.rst file.
- Code readability improved in all the patches.
- Defined macros wherever is possible.
- Changed RESETC to STATUS0_RESETC for improving the readability.
- Removed OA specific DT bindings.
- Used default configurations defined in the OA spec.
- All variables are named properly as per OA spec for more redability.
- Bigger functions are split into multiple smaller functions.
- DT binding check is done.
- Phy mask is removed in phy scanning.
- Used NET_RX_DROP to compare the rx packet submission status.
- Indentation in the Kconfig file corrected.
- Removed CONFIG_OF and CONFIG_ACPI ifdefs.
- Removed MODULE_ALIAS().

v4:
- Fixed indentation in oa-tc6-framework.rst file.
- Replaced ENODEV error code with EPROTO in the
  oa_tc6_check_ctrl_write_reply and oa_tc6_check_ctrl_read_reply()
  functions.
- Renamed oa_tc6_read_sw_reset_status() function as
  oa_tc6_read_status0().
- Changed software reset polling delay as 1ms and polling timeout as 1s.
- Implemented clause 45 registers direct access.
- Replaced ENODEV error code with ENOMEM in the
  oa_tc6_mdiobus_register() function.
- Changed transmit skbs queue size as 2.
- Added skb_linearize() function to convert contiguous packet data.
- Checked kthread_should_stop() in the oa_tc6_spi_thread_handler()
  function before proceeding for the oa_tc6_try_spi_transfer().
- Removed netdev_err() print in the oa_tc6_allocate_rx_skb() function.
- Added spi-peripheral-props reference in the dt-bindings.
- Changed the fallback order in the dt-bindings.
- Replaced netif_start_queue() with netif_wake_queue().
- Empty data transfer performed in the oa_tc6_init() function to clear
  the reset complete interrupt.
- ZARFE bit in the CONFIG0 register is set to 1 to avoid lan865x halt
  based on the recommendation in the lan865x errata.

v5:
- Added base commit info in the cover letter.
- Fixed all the warnings reported in the oa-tc6-framework.rst file.
- Fixed kernel-doc reported warnings.
- Fixed reverse christmas tree notation.
- Printed error code in case STATUS0 register read is failed.
- Removed C29 support in the PHY initialization.
- Returned the same error code from the function instead of replacing
  with another error code.
- Used netdev_alloc_skb_ip_align() to allocate receive skb buffer.
- Enabling zero align receive frame feature moved to OA TC6 framework
  as a helper function for vendor specific drivers.
- Replaced eth_hw_addr_set() with eth_commit_mac_addr_change() as it is
  a better pair for eth_prepare_mac_addr_change().
- Fixed device tree binding issues in the driver and documentation.
- Fixed multicast addresses hash value calculation.

v6:
- Replaced "depends on" with "select" for selecting OA_TC6 library in the
  lan865x Kconfig file.
- Fixed multicast address configuration.

v7:
- Removed tx skb queue handling and introduced two skb pointers to point
  waiting and ongoing tx skb's.
- Removed netif_rx() return value check and rx drop statistics update as
  it is already handled in the dev_core_stats_rx_dropped_inc(skb->dev)
  function.
- Removed lan865x_get_drvinfo() function as the core fills this basic
  info automatically.

Parthiban Veerasooran (14):
  Documentation: networking: add OPEN Alliance 10BASE-T1x MAC-PHY serial
    interface
  net: ethernet: oa_tc6: implement register write operation
  net: ethernet: oa_tc6: implement register read operation
  net: ethernet: oa_tc6: implement software reset
  net: ethernet: oa_tc6: implement error interrupts unmasking
  net: ethernet: oa_tc6: implement internal PHY initialization
  net: phy: microchip_t1s: add c45 direct access in LAN865x internal PHY
  net: ethernet: oa_tc6: enable open alliance tc6 data communication
  net: ethernet: oa_tc6: implement transmit path to transfer tx ethernet
    frames
  net: ethernet: oa_tc6: implement receive path to receive rx ethernet
    frames
  net: ethernet: oa_tc6: implement mac-phy interrupt
  net: ethernet: oa_tc6: add helper function to enable zero align rx
    frame
  microchip: lan865x: add driver support for Microchip's LAN865X MAC-PHY
  dt-bindings: net: add Microchip's LAN865X 10BASE-T1S MACPHY

 .../bindings/net/microchip,lan8650.yaml       |   80 +
 Documentation/networking/index.rst            |    1 +
 Documentation/networking/oa-tc6-framework.rst |  497 ++++++
 MAINTAINERS                                   |   15 +
 drivers/net/ethernet/Kconfig                  |   11 +
 drivers/net/ethernet/Makefile                 |    1 +
 drivers/net/ethernet/microchip/Kconfig        |    1 +
 drivers/net/ethernet/microchip/Makefile       |    1 +
 .../net/ethernet/microchip/lan865x/Kconfig    |   19 +
 .../net/ethernet/microchip/lan865x/Makefile   |    6 +
 .../net/ethernet/microchip/lan865x/lan865x.c  |  429 ++++++
 drivers/net/ethernet/oa_tc6.c                 | 1361 +++++++++++++++++
 drivers/net/phy/microchip_t1s.c               |   30 +
 include/linux/oa_tc6.h                        |   24 +
 include/uapi/linux/mdio.h                     |    1 +
 15 files changed, 2477 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/microchip,lan8650.yaml
 create mode 100644 Documentation/networking/oa-tc6-framework.rst
 create mode 100644 drivers/net/ethernet/microchip/lan865x/Kconfig
 create mode 100644 drivers/net/ethernet/microchip/lan865x/Makefile
 create mode 100644 drivers/net/ethernet/microchip/lan865x/lan865x.c
 create mode 100644 drivers/net/ethernet/oa_tc6.c
 create mode 100644 include/linux/oa_tc6.h


base-commit: 221f9cce949ac8042f65b71ed1fde13b99073256
-- 
2.34.1


