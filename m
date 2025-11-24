Return-Path: <netdev+bounces-241225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D977C81999
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41AFE3AC284
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B86A298987;
	Mon, 24 Nov 2025 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="YZmQM9HS"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0B81A285;
	Mon, 24 Nov 2025 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001959; cv=none; b=aiCgHX5ubfQNkBz26KfGGVIO8jwy0zF4NehIjXOLG2f7KhC+UJFC6Ha8G4nqTE2zt9M1AsPKvcA5I938IVmOfaUerty1ousJCN7aSVmsYjM/qDfJwCjTiGH1NYuFZJu6ndoF6PNCqsX9Tr6cl0NInzy859qBVc56D5QwopCNrgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001959; c=relaxed/simple;
	bh=CGEVMgtRZ6mLI9Ca7ONqd9pWguioV/EDurTDlkC9pBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=osVuwHA8zJ6iaiTRHPwOg5U1E6gbG7+0ILvqHosGBHBo5dnzKvES3pknLMOFtT17TOwyU1EQJI5ydscGDbxSyYVz2OxEgpoXClRW1QtS6xc94Lrx3jiyc+JSCL77d9xfBlBzMhYl1TZER06AVZ7A3tpMAC2cqMtlgGAm8NqO3HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=YZmQM9HS; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 3BDC822D43;
	Mon, 24 Nov 2025 17:32:35 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ypXWgmSQ0K9C; Mon, 24 Nov 2025 17:32:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1764001954; bh=CGEVMgtRZ6mLI9Ca7ONqd9pWguioV/EDurTDlkC9pBI=;
	h=From:To:Cc:Subject:Date;
	b=YZmQM9HStxf/31hsyi+0bNkdWFqm4jJ7LI6k1aLCawc7aMekm1pgkYrJ4g/q+53vi
	 Fn99JDETtxycgbRue0RBDigoS7QnttvAvb4cZLVEmwqmyz8Ks7R6gFs+9fGIYZoIxp
	 Z2uWjQ6rH3FbMyxARD469opiQH4iumZrYFyJtw6W3KJcgWyUROCitVnerfqK/yLAi0
	 32VU9g6X+DU5HPvrS2FnAlhbDP5ekmjC50/jLjS/P3gXgmro5DbjAaGU4e4E6Q6ZUW
	 ty33eZtm3KQ7zCFtieTRUG/L/WORDeGCetzhIMApi/3V95l2Cl5/4uAVCPJPzMOwz3
	 53sd0RVd4jj2Q==
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
	netdev@vger.kernel.org,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>
Subject: [PATCH net-next v3 0/3] Add DWMAC glue driver for Motorcomm YT6801
Date: Mon, 24 Nov 2025 16:32:08 +0000
Message-ID: <20251124163211.54994-1-ziyao@disroot.org>
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
it reaches 869Mbps (TX)/943Mbps (RX) on average,

## YT6801 TX

Connecting to host 172.16.70.12, port 5201
[  5] local 172.16.70.230 port 43802 connected to 172.16.70.12 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   102 MBytes   858 Mbits/sec    0    335 KBytes
[  5]   1.00-2.00   sec   103 MBytes   867 Mbits/sec    0    441 KBytes
[  5]   2.00-3.00   sec   103 MBytes   863 Mbits/sec    0    441 KBytes
[  5]   3.00-4.00   sec   104 MBytes   870 Mbits/sec    0    441 KBytes
[  5]   4.00-5.00   sec   104 MBytes   869 Mbits/sec    0    441 KBytes
[  5]   5.00-6.00   sec   104 MBytes   869 Mbits/sec    0    591 KBytes
[  5]   6.00-7.00   sec   104 MBytes   876 Mbits/sec    0    629 KBytes
[  5]   7.00-8.00   sec   105 MBytes   878 Mbits/sec    0    629 KBytes
[  5]   8.00-9.00   sec   104 MBytes   872 Mbits/sec    0    629 KBytes
[  5]   9.00-10.00  sec   104 MBytes   871 Mbits/sec    0    629 KBytes

## YT6801 RX

Connecting to host 172.16.70.230, port 5201
[  5] local 172.16.70.12 port 60866 connected to 172.16.70.230 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   113 MBytes   949 Mbits/sec    0    352 KBytes
[  5]   1.00-2.00   sec   113 MBytes   945 Mbits/sec    0    352 KBytes
[  5]   2.00-3.00   sec   112 MBytes   938 Mbits/sec    0    352 KBytes
[  5]   3.00-4.00   sec   113 MBytes   945 Mbits/sec    0    352 KBytes
[  5]   4.00-5.00   sec   112 MBytes   938 Mbits/sec    0    407 KBytes
[  5]   5.00-6.00   sec   112 MBytes   940 Mbits/sec    0    407 KBytes
[  5]   6.00-7.00   sec   113 MBytes   945 Mbits/sec    0    436 KBytes
[  5]   7.00-8.00   sec   112 MBytes   941 Mbits/sec    0    436 KBytes
[  5]   8.00-9.00   sec   113 MBytes   947 Mbits/sec    0    645 KBytes
[  5]   9.00-10.00  sec   112 MBytes   939 Mbits/sec    0    645 KBytes

This series depends on v5 of series "Unify platform suspend/resume
routines for PCI DWMAC glue"[5] for a clean apply. It has been some time
since I sent v1 of the series, I'm sorry for the delay. Many thanks for
your time and review.

[1]: https://lore.kernel.org/all/Z_T6vv013jraCzSD@shell.armlinux.org.uk/
[2]: https://lore.kernel.org/all/a48d76ac-db08-46d5-9528-f046a7b541dc@motor-comm.com/
[3]: https://lore.kernel.org/all/a48d76ac-db08-46d5-9528-f046a7b541dc@motor-comm.com/
[4]: https://github.com/deepin-community/kernel/tree/dc61248a0e21/drivers/net/ethernet/motorcomm/yt6801
[5]: https://lore.kernel.org/netdev/20251124160417.51514-1-ziyao@disroot.org/

Changed from v2
- Rebase on top of next-20251124
- Switch to stmmac_plat_dat_alloc() then drop now redundant parameters
  from motorcomm_default_plat_data()
- Set STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP
- Add a comment indicating the possible source of CSR clock
- Link to v2: https://lore.kernel.org/netdev/20251111105252.53487-1-ziyao@disroot.org/

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
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   9 +
 drivers/net/ethernet/stmicro/stmmac/Makefile  |   1 +
 .../ethernet/stmicro/stmmac/dwmac-motorcomm.c | 378 ++++++++++++++++++
 drivers/net/phy/motorcomm.c                   |   4 +
 5 files changed, 398 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c

-- 
2.51.2


