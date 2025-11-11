Return-Path: <netdev+bounces-237566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F2AC4D45C
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 12:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D32F3AC3B5
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB1234B18B;
	Tue, 11 Nov 2025 10:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="By9aR6tG"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF3034C838;
	Tue, 11 Nov 2025 10:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858398; cv=none; b=uXJHx901h0O9OJ1PnLIA/hUDVHOdYnSyfTjaJ1OdbwFXCaXn7/UmYcIcWpBsarWiMoPZusms0Z7uAzCOJA99w9+UVrSficEqQpv+Y6jJzTLu4nGLluOARkMBPjNhvzNepf7oCN33RbtBoSV8lhiY2fKeP6QDkLirIoc1GDSVzwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858398; c=relaxed/simple;
	bh=+0H9MF3ikGUBaNb3AMAF4EOw8zBuEXaVgvch8FjGW5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hVTvVcdhNMGMYXEliCuVnrj/Tc+gYDPI+JrZZlq/nlCivyan0KOmMuG44yGQDIIs/yq9fnnEUVyNlhGDCME5bUo2uXTvP2miMWS2TJuwa153XLW1abNqpKuK+rpWg467eY3ti4YW+mg5zEs2hB94gZGwZpebO5bYy2OXtpfBrU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=By9aR6tG; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 40BB525ED6;
	Tue, 11 Nov 2025 11:53:14 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u99sWGufKARy; Tue, 11 Nov 2025 11:53:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1762858393; bh=+0H9MF3ikGUBaNb3AMAF4EOw8zBuEXaVgvch8FjGW5Y=;
	h=From:To:Cc:Subject:Date;
	b=By9aR6tGYYB/7Q9RH56U7I5cyXubG/GNsooStruG9eCKE/hdDSqMrsa/KUoY+GVQo
	 DBHttS0JdqGIPxMiJtdJ+STYUUt4ahPKkDuXFbbjT3NsizbRkcQMUQrfMmo36YfhjC
	 veaTzhggJHAJiGzGvHww3jb74VMyky9mvXmgTdI2CbBkY/nO8U3Z4yfVl1Vgsv3ejv
	 9KZzeB22Nz+q/V/ALYcRhg7eqsMWit7XOgBf0ogYlPvUL2Z4bpDoNpVeneX++hHJYd
	 1DeVE1WDsk58a+EZmOhqborsktzjkGSzjG3GhiV7iNzHGzuuTi84XejdLzon4iw5xw
	 obF3veqG6m2SQ==
From: Yao Zi <ziyao@disroot.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yao Zi <ziyao@disroot.org>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 0/3] Add DWMAC glue driver for Motorcomm YT6801
Date: Tue, 11 Nov 2025 10:52:49 +0000
Message-ID: <20251111105252.53487-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds glue driver for Motorcomm YT6801 PCIe ethernet
controller, which is considered mostly compatible with DWMAC-4 IP by
inspecting the register layout[1]. It integrates a Motorcomm YT8531S PHY
(confirmed by reading PHY ID) and GMII is used to connect the PHY to
MAC[2].

The initialization logic of the MAC is mostly based on previous upstream
effort for the controller[3] and the Deepin-maintained downstream Linux
driver[4] licensed under GPL-2.0 according to its SPDX headers. However,
this series is a completely re-write of the previous patch series,
utilizing the existing DWMAC4 driver and introducing a glue driver only.

This series only aims to add basic networking functions for the
controller, features like WoL, RSS and LED control are omitted for now.
Testing is done on Loongson 3A5000 machine. Through a local GbE switch,
it reaches 868Mbps (TX)/942Mbps (RX) on average,

## YT6801 TX

Connecting to host 172.16.70.12, port 5201
[  5] local 172.16.70.230 port 54806 connected to 172.16.70.12 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   102 MBytes   855 Mbits/sec    0    342 KBytes
[  5]   1.00-2.00   sec   104 MBytes   869 Mbits/sec    0    424 KBytes
[  5]   2.00-3.00   sec   104 MBytes   868 Mbits/sec    0    474 KBytes
[  5]   3.00-4.00   sec   103 MBytes   865 Mbits/sec    0    474 KBytes
[  5]   4.00-5.00   sec   104 MBytes   869 Mbits/sec    0    474 KBytes
[  5]   5.00-6.00   sec   104 MBytes   873 Mbits/sec    0    474 KBytes
[  5]   6.00-7.00   sec   103 MBytes   863 Mbits/sec    0    474 KBytes
[  5]   7.00-8.00   sec   104 MBytes   870 Mbits/sec    0    474 KBytes
[  5]   8.00-9.00   sec   103 MBytes   863 Mbits/sec    0    474 KBytes
[  5]   9.00-10.00  sec   105 MBytes   876 Mbits/sec    0    474 KBytes

## YT6801 RX

Connecting to host 172.16.70.230, port 5201
[  5] local 172.16.70.12 port 59346 connected to 172.16.70.230 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   113 MBytes   950 Mbits/sec    0    383 KBytes
[  5]   1.00-2.00   sec   112 MBytes   941 Mbits/sec    0    406 KBytes
[  5]   2.00-3.00   sec   113 MBytes   946 Mbits/sec    0    406 KBytes
[  5]   3.00-4.00   sec   111 MBytes   933 Mbits/sec    0    406 KBytes
[  5]   4.00-5.00   sec   112 MBytes   938 Mbits/sec    0    406 KBytes
[  5]   5.00-6.00   sec   112 MBytes   943 Mbits/sec    0    426 KBytes
[  5]   6.00-7.00   sec   112 MBytes   941 Mbits/sec    0    426 KBytes
[  5]   7.00-8.00   sec   111 MBytes   932 Mbits/sec    0    426 KBytes
[  5]   8.00-9.00   sec   113 MBytes   950 Mbits/sec    0    566 KBytes
[  5]   9.00-10.00  sec   112 MBytes   938 Mbits/sec    0    566 KBytes

This series depends on v4 of series "Unify platform suspend/resume
routines for PCI DWMAC glue"[5] for a clean apply. It has been some time
since I sent v1 of the series, I'm sorry for the delay. Many thanks for
your time and review.

[1]: https://lore.kernel.org/all/Z_T6vv013jraCzSD@shell.armlinux.org.uk/
[2]: https://lore.kernel.org/all/a48d76ac-db08-46d5-9528-f046a7b541dc@motor-comm.com/
[3]: https://lore.kernel.org/all/a48d76ac-db08-46d5-9528-f046a7b541dc@motor-comm.com/
[4]: https://github.com/deepin-community/kernel/tree/dc61248a0e21/drivers/net/ethernet/motorcomm/yt6801
[5]: https://lore.kernel.org/netdev/20251111100727.15560-2-ziyao@disroot.org/

Changed from v1
- Drop (original) PATCH 1, add no vendor ID entry to linux/pci_ids.h
- Use PHY_INTERFACE_MODE_GMII instead of PHY_INTERFACE_MODE_INTERNAL
- Drop extra register read in motorcomm_efuse_read_byte()
- Rename EPHY_RESET to EPHY_MDIO_PHY_RESET, add a comment to reflect its
  function better
- Use the newly-introduced generic PCI suspend/resume routines
- Generate a random MAC address instead of failing to probe when no MAC
  address is programmed in eFuse (seen on some OEM EVBs).
- Collect Tested-by tags
- Link to v1: https://lore.kernel.org/netdev/20251014164746.50696-2-ziyao@disroot.org/

Yao Zi (3):
  net: phy: motorcomm: Support YT8531S PHY in YT6801 Ethernet controller
  net: stmmac: Add glue driver for Motorcomm YT6801 ethernet controller
  MAINTAINERS: Assign myself as maintainer of Motorcomm DWMAC glue
    driver

 MAINTAINERS                                   |   6 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   7 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-motorcomm.c | 379 ++++++++++++++++++
 drivers/net/phy/motorcomm.c                   |   4 +
 5 files changed, 397 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c

-- 
2.51.2


