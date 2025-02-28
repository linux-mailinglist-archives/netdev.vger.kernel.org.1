Return-Path: <netdev+bounces-170623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D836A4965A
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DCCC1897070
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280A7260372;
	Fri, 28 Feb 2025 10:00:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-12.us.a.mail.aliyun.com (out198-12.us.a.mail.aliyun.com [47.90.198.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2249D25F97C;
	Fri, 28 Feb 2025 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736848; cv=none; b=XUR8ElNw2eaEcWCmgSnJkFZwZKJ1zFS3gRk+yYBNiElS6YIMvaxRHf48Doo+qyC/rcPy2oKbREz5UqyYD9HIdu3e8cJxxNcGYc4TrPuvhvhXt0bJOOIcUOVpEUImLwhhXvDGPMNMrqYGvgYOhWX3YaL01j6dZMXsFLnCV2sXGlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736848; c=relaxed/simple;
	bh=wCzcqb5ex/eO+H7R2RyhdEzh0ARjyXyxCI2VpaIU6go=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MgRJ8WqvNrc8hDHQhib5JJipiU4IX9idKBOmrrQUz1pX3pxVB2HjAUDJU0Of7Pb9AtQq/6NwqzTNA/UIc4VRH48YTZ9FigtYG3raoz8wcYjPRhTF7WEA0CQx+FCGzv/XNvohlU9HVnK0J2yTw4Prw8Ngyw8qSbjn/Hlzp0yBycA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.bfyn0sj_1740736820 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 28 Feb 2025 18:00:31 +0800
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
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com
Subject: [PATCH net-next v3 00/14] net:yt6801: Add Motorcomm yt6801 PCIe driver
Date: Fri, 28 Feb 2025 18:00:06 +0800
Message-Id: <20250228100020.3944-1-Frank.Sae@motor-comm.com>
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

v3:
 - Remove about 5000 lines of code
 - Remove statistics, ethtool, WoL, PHY handling ...
 - Reorganize this driver code and remove redundant code
 - Remove unnecessary yt_dbg information
 - Remove netif_carrier_on/netif_carrier_off
 - Remove hw_ops
 - Add PHY_INTERFACE_MODE_INTERNAL mode in phy driver to support yt6801
 - replease '#ifdef CONFIG_PCI_MSI' as 'if (IS_ENABLED(CONFIG_PCI_MSI) {}'
 - replease ‘fxgmac_pdata val’ as 'priv'

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
  motorcomm:yt6801: Implement mdio register
  motorcomm:yt6801: Add support for a pci table in this module
  motorcomm:yt6801: Implement pci_driver shutdown
  motorcomm:yt6801: Implement the fxgmac_init function
  motorcomm:yt6801: Implement the .ndo_open function
  motorcomm:yt6801: Implement the fxgmac_start function
  phy:motorcomm: Add PHY_INTERFACE_MODE_INTERNAL to support YT6801
  motorcomm:yt6801: Implement the fxgmac_hw_init function
  motorcomm:yt6801: Implement the poll functions
  motorcomm:yt6801: Implement .ndo_start_xmit function
  motorcomm:yt6801: Implement some net_device_ops function
  motorcomm:yt6801: Implement pci_driver suspend and resume
  motorcomm:yt6801: Add makefile and Kconfig
  motorcomm:yt6801: update ethernet documentation and maintainer

 .../device_drivers/ethernet/index.rst         |    1 +
 .../ethernet/motorcomm/yt6801.rst             |   20 +
 MAINTAINERS                                   |    8 +
 drivers/net/ethernet/Kconfig                  |    1 +
 drivers/net/ethernet/Makefile                 |    1 +
 drivers/net/ethernet/motorcomm/Kconfig        |   27 +
 drivers/net/ethernet/motorcomm/Makefile       |    6 +
 .../net/ethernet/motorcomm/yt6801/Makefile    |    8 +
 .../net/ethernet/motorcomm/yt6801/yt6801.h    |  379 +++
 .../ethernet/motorcomm/yt6801/yt6801_desc.c   |  571 ++++
 .../ethernet/motorcomm/yt6801/yt6801_desc.h   |   35 +
 .../ethernet/motorcomm/yt6801/yt6801_net.c    | 2876 +++++++++++++++++
 .../ethernet/motorcomm/yt6801/yt6801_pci.c    |  186 ++
 .../ethernet/motorcomm/yt6801/yt6801_type.h   |  967 ++++++
 drivers/net/phy/motorcomm.c                   |    6 +
 15 files changed, 5092 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/motorcomm/yt6801.rst
 create mode 100644 drivers/net/ethernet/motorcomm/Kconfig
 create mode 100644 drivers/net/ethernet/motorcomm/Makefile
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/Makefile
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801.h
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.c
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_desc.h
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_net.c
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_pci.c
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_type.h

-- 
2.34.1


