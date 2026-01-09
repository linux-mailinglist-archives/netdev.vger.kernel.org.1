Return-Path: <netdev+bounces-248408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A1058D083C5
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 10:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6074301E6B2
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 09:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33174350A34;
	Fri,  9 Jan 2026 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="MslA0N5l"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7899E33064A;
	Fri,  9 Jan 2026 09:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767951358; cv=pass; b=ViyscfR8C3E7KmUGvVDDXHpgYD3MML0ip96lcumhpRSrN7Jca/42W64I6x9pRy7bDQJNPF90YKhzMy0meU8ynn2zV56SIIfH+3pRr++oq9h2/9DEyzLnmCv54g0pu0WRCTe0xNr2do0WG/Q1qbtZtUaXFI+wCfeYu74vxKYKxdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767951358; c=relaxed/simple;
	bh=Fgp3xDIze5wNJnq/qBv9KMx22Z8Eyhke2CrKpQPZqRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bw3hiJbJqW8kAj4vaMW8SY9OcXnzimW2v2EUhNkhAZzBUZd42E3Dqh1c0CVUa4b9ctYSjqU6X8ncUyuDrlzbR7Io0kGvwxB8bKCD3MRC1D+iO6Kd7aW9wXsg8b1CpcHXgDcbKLVcVUlrd6opEp5RTgOVQ509z03hqdj5Ocsiw8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=MslA0N5l; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1767951315; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=n8AYHkWbuA6cXI+xDFC8mypaI66ar5dEtGAW8js78txS2kBh36ROp1uHpHmipT8UAjeNyleOtcVr/RwqXABR7afq8FflhJA0D9MJxBGNMzptGc29vvXY6ypbs1iVh4YFcHW8E/SFJQZ1NaoLtMTVB6IioQfQKYU22LgNMjkvDak=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767951315; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/4uiYgL64qKklyMkP+6JhGLHXbzFffeqpoQ3nWft5+I=; 
	b=Nqn8VUBow4IDv6Ls9Oth8fQkpm1ICEkeJt20Dj0ErZK/H3RBQbJde+n/v5RQoYFaJHkWleUk+7FHqhDeR/J8sORi3AW6+F4C/jDjcVTkeGepnwq+ZkwMTkGf0Yerujo1SBm5XzJFNwW1p+9hWXL/nVsCkWeqUXfvwdwxRRBJ5/M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767951315;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=/4uiYgL64qKklyMkP+6JhGLHXbzFffeqpoQ3nWft5+I=;
	b=MslA0N5lZEo7/zRw1Ud6nPBF6JFcVBbigF4QhIhPSCfeEiHk/hFtpRKUSFH5048F
	x8ak+EDf28NFK6H7R0Pp/6f/lzp421IjcON7T2mmBaN4Ox5z4NxYbESnpxroLarp1oV
	eXATiIspemDxbEZrlQebVtfShEjYsk91az0mcwUU=
Received: by mx.zohomail.com with SMTPS id 1767951312227667.7187390848119;
	Fri, 9 Jan 2026 01:35:12 -0800 (PST)
From: Yao Zi <me@ziyao.cc>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH RESEND net-next v6 0/3] Add DWMAC glue driver for Motorcomm YT6801
Date: Fri,  9 Jan 2026 09:34:43 +0000
Message-ID: <20260109093445.46791-2-me@ziyao.cc>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

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
Testing is done on i3-4170, it reaches 939Mbps (TX)/933Mbps (RX) on
average,

YT6801 TX

Connecting to host 192.168.114.51, port 5201
[  5] local 192.168.114.50 port 52986 connected to 192.168.114.51 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   112 MBytes   938 Mbits/sec    0    950 KBytes
[  5]   1.00-2.00   sec   113 MBytes   949 Mbits/sec    0   1.08 MBytes
[  5]   2.00-3.00   sec   112 MBytes   938 Mbits/sec    0   1.08 MBytes
[  5]   3.00-4.00   sec   111 MBytes   932 Mbits/sec    0   1.13 MBytes
[  5]   4.00-5.00   sec   113 MBytes   945 Mbits/sec    0   1.13 MBytes
[  5]   5.00-6.00   sec   112 MBytes   936 Mbits/sec    0   1.13 MBytes
[  5]   6.00-7.00   sec   112 MBytes   942 Mbits/sec    0   1.19 MBytes
[  5]   7.00-8.00   sec   112 MBytes   935 Mbits/sec    0   1.19 MBytes
[  5]   8.00-9.00   sec   113 MBytes   948 Mbits/sec    0   1.19 MBytes
[  5]   9.00-10.00  sec   111 MBytes   931 Mbits/sec    0   1.19 MBytes

YT6801 RX

Connecting to host 192.168.114.50, port 5201
[  5] local 192.168.114.51 port 41578 connected to 192.168.114.50 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   113 MBytes   944 Mbits/sec    0    542 KBytes
[  5]   1.00-2.00   sec   111 MBytes   934 Mbits/sec    0    850 KBytes
[  5]   2.00-3.00   sec   111 MBytes   933 Mbits/sec    0   1.01 MBytes
[  5]   3.00-4.00   sec   112 MBytes   943 Mbits/sec    0   1.01 MBytes
[  5]   4.00-5.00   sec   111 MBytes   932 Mbits/sec    0   1.01 MBytes
[  5]   5.00-6.00   sec   111 MBytes   929 Mbits/sec    0   1.01 MBytes
[  5]   6.00-7.00   sec   112 MBytes   937 Mbits/sec    0   1.01 MBytes
[  5]   7.00-8.00   sec   112 MBytes   941 Mbits/sec    0   1.01 MBytes
[  5]   8.00-9.00   sec   111 MBytes   929 Mbits/sec    0   1.01 MBytes
[  5]   9.00-10.00  sec   111 MBytes   932 Mbits/sec    0   1.01 MBytes

My mail provider failed to deliver the original v6 series to the list,
sorry for the inconvenience. Thanks for your time and review.

[1]: https://lore.kernel.org/all/Z_T6vv013jraCzSD@shell.armlinux.org.uk/
[2]: https://lore.kernel.org/all/a48d76ac-db08-46d5-9528-f046a7b541dc@motor-comm.com/
[3]: https://lore.kernel.org/all/a48d76ac-db08-46d5-9528-f046a7b541dc@motor-comm.com/
[4]: https://github.com/deepin-community/kernel/tree/dc61248a0e21/drivers/net/ethernet/motorcomm/yt6801

Changed from v5
- PATCH 1: Collect review tags
- PATCH 2: Remove struct device from dwmac_motorcomm_priv, since it's
           only used during probe.
- Link to v5: https://lore.kernel.org/netdev/20251225071914.1903-1-me@ziyao.cc/

Changed from v4
- PATCH 1: don't set RGMII delay register in GMII mode
- PATCH 2
  - Disable ASPM L1 link state to work around problematic PCIe addon
    cards
  - Don't use an extra buffer when reading eFuse patches
  - Call eth_random_addr() directly when generating a random MAC is
    necessary
  - Drop unused register field definitions
  - Fix indentation for interrupt-moderation-related field definitions
- Link to v4: https://lore.kernel.org/all/20251216180331.61586-1-me@ziyao.cc/

Changed from v3
- Manually register a devres action to call pci_free_irq_vectors(),
  instead of relying on the obsolete behavior of
  pci_alloc_irq_vectors().
- Remove redundant call to pci_free_irq_vectors() in remove callback.
- Use my new mail address me@ziyao.cc for Sign-off-by and commit author.
- Link to v3: https://lore.kernel.org/netdev/20251124163211.54994-1-ziyao@disroot.org/

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
 .../ethernet/stmicro/stmmac/dwmac-motorcomm.c | 384 ++++++++++++++++++
 drivers/net/phy/motorcomm.c                   |   4 +
 5 files changed, 404 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c

-- 
2.52.0


