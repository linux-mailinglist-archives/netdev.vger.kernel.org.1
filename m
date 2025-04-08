Return-Path: <netdev+bounces-180114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB81A7FA3F
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C441894095
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F5326562E;
	Tue,  8 Apr 2025 09:44:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-9.us.a.mail.aliyun.com (out198-9.us.a.mail.aliyun.com [47.90.198.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB80265CA1;
	Tue,  8 Apr 2025 09:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105488; cv=none; b=FIoX5eL010OabjvAltA8Jq5f7mvRxIuSs1DSlmeC+rQrQMg4I5KZ4nBd8dmEObSJ5NSt6/QkqRUe3UgLkb9O2j3JnXeuQ1zHuS/an+Yn3ramsLVeDVQVSqjq0jkBX2WNrYWtB6cvjY/mBXVgL+JtQsMUMOuKBI6UFysYxcC2Nek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105488; c=relaxed/simple;
	bh=GixCokwCS7+n5tP2v6Bl4rJr3BXVl1PYohdWXt19vS4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Lwhj15p6SS3HhO0sYzhwFi5kv4xZf0lRjjlKop5vVEziXGnEOKUCuQOLYbNQ+cbZCkNhQjsx6eA8pqoCWrl7RBgcHvO7f7iTbRszfJYIeI47TeP3APO9rnBkXCLaq2MvHJ0V5FPKvWbBtwoyBf7g3OBU63SH8d9jFjdLEgARfg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.cGww6yv_1744104515 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Apr 2025 17:28:50 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Frank <Frank.Sae@motor-comm.com>,
	netdev@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Parthiban.Veerasooran@microchip.com,
	linux-kernel@vger.kernel.org,
	"andrew+netdev @ lunn . ch" <andrew+netdev@lunn.ch>,
	lee@trager.us,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	geert+renesas@glider.be,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com
Subject: [PATCH net-next v4 00/14] yt6801: Add Motorcomm yt6801 PCIe driver
Date: Tue,  8 Apr 2025 17:28:21 +0800
Message-Id: <20250408092835.3952-1-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series includes adding Motorcomm YT6801 Gigabit ethernet driver
 and adding yt6801 ethernet driver entry in MAINTAINERS file.
YT6801 integrates a YT8531S phy.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---

v4:
 - Redefine rges and bits
 - Reorganize the read and write function of regs
 - Replae ‘pcim_iomap_regions’ as 'pcim_iomap_region'
 - Replae ‘mutex_lock(&priv->mutex)’ as 'rtnl_lock（）'
 - Replae ‘phydev_info(...YT6801.\n");’ as 'dev_info_once（...YT6801.\n");'
   in phy driver
 - Remove pcim_iomap_table
 - Use "yt6801: " and "net: phy: motorcomm: " as prefixes for these patches

v3: https://patchwork.kernel.org/project/netdevbpf/cover/20250228100020.3944-1-Frank.Sae@motor-comm.com/
 - Remove about 5000 lines of code
 - Remove statistics, ethtool, WoL, PHY handling ...
 - Reorganize this driver code and remove redundant code
 - Remove unnecessary yt_dbg information
 - Remove netif_carrier_on/netif_carrier_off
 - Remove hw_ops
 - Add PHY_INTERFACE_MODE_INTERNAL mode in phy driver to support yt6801
 - Replae '#ifdef CONFIG_PCI_MSI' as 'if (IS_ENABLED(CONFIG_PCI_MSI) {}'
 - Replae ‘fxgmac_pdata val’ as 'priv'

v2: https://patchwork.kernel.org/project/netdevbpf/cover/20241120105625.22508-1-Frank.Sae@motor-comm.com/
 - Split this driver into multiple patches.
 - Reorganize this driver code and remove redundant code
 - Remove PHY handling code and use phylib.
 - Remove writing ASPM config
 - Use generic power management instead of pci_driver.suspend()/resume()
 - Add Space before closing "*/"

v1: https://patchwork.kernel.org/project/netdevbpf/patch/20240913124113.9174-1-Frank.Sae@motor-comm.com/


This patch is to add the ethernet device driver for the PCIe interface of
 Motorcomm YT6801 Gigabit Ethernet.
We tested this driver on an Ubuntu x86 PC with YT6801 network card.

Frank Sae (14):
  yt6801: Add support for a pci table in this module
  yt6801: Implement mdio register
  yt6801: Implement pci_driver shutdown
  yt6801: Implement the fxgmac_init function
  yt6801: Implement the .ndo_open function
  yt6801: Implement the fxgmac_start function
  net:phy:motorcomm: Add PHY_INTERFACE_MODE_INTERNAL to support YT6801
  yt6801: Implement the fxgmac_hw_init function
  yt6801: Implement the poll functions
  yt6801: Implement .ndo_start_xmit function
  yt6801: Implement some net_device_ops function
  yt6801: Implement pci_driver suspend and resume
  yt6801: Add makefile and Kconfig
  yt6801: update ethernet documentation and maintainer

 .../device_drivers/ethernet/index.rst         |    1 +
 .../ethernet/motorcomm/yt6801.rst             |   20 +
 MAINTAINERS                                   |    8 +
 drivers/net/ethernet/Kconfig                  |    1 +
 drivers/net/ethernet/Makefile                 |    1 +
 drivers/net/ethernet/motorcomm/Kconfig        |   27 +
 drivers/net/ethernet/motorcomm/Makefile       |    6 +
 .../net/ethernet/motorcomm/yt6801/Makefile    |    8 +
 .../ethernet/motorcomm/yt6801/yt6801_desc.c   |  565 ++++
 .../ethernet/motorcomm/yt6801/yt6801_desc.h   |   35 +
 .../ethernet/motorcomm/yt6801/yt6801_main.c   | 3006 +++++++++++++++++
 .../ethernet/motorcomm/yt6801/yt6801_type.h   |  956 ++++++
 drivers/net/phy/motorcomm.c                   |    6 +
 13 files changed, 4640 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/motorcomm/yt6801.rst
 create mode 100644 drivers/net/ethernet/motorcomm/Kconfig
 create mode 100644 drivers/net/ethernet/motorcomm/Makefile
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/Makefile
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.h
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_main.c
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h

-- 
2.34.1


