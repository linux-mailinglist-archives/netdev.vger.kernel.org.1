Return-Path: <netdev+bounces-246042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E82CDD697
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 08:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D27C930010F9
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 07:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A42C2D5C68;
	Thu, 25 Dec 2025 07:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b="FPUtczFr"
X-Original-To: netdev@vger.kernel.org
Received: from mail65.out.titan.email (mail65.out.titan.email [34.235.186.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B6C1F4C8C
	for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 07:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.235.186.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766647198; cv=none; b=UJhRc/F9sH3X+UKWfAIcGpKx1zcTQ4NwTro0NVO3sI8WoDJ57AKe/y/U6zkeKDThtXG2b7+MvK8kunDrxOI9CwP+HZteXudTMGAtSAaxQh3NPkkqHhppqEi9XOlOM6q5bj2jaZMIFz9OfLDC1wJBfnJP+ql/ojoGp0qnb+TVFh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766647198; c=relaxed/simple;
	bh=wYs+ksPfMvjRDUUpt+3phUyJ8kVsLwG2fgQMmH83Gzk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KSEkK9f5cIAVaI3pIMGzCsR/OkUL9PEnTqgUyU7NTi/sd7SykzUN1VjNOYO3IQxwcFUf9vKeD3Q26VU20pQORBUhLiqhf6wsy3418qxFnDdcruD1zTwyhrLXZozNzk5Du2QB60nUj1gyNChIifcKspw3luylqXH01PV0JYVSy88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=@ziyao.cc header.b=FPUtczFr; arc=none smtp.client-ip=34.235.186.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Received: from localhost (localhost [127.0.0.1])
	by smtp-out.flockmail.com (Postfix) with ESMTP id 4dcKrP2Vmmz7t7w;
	Thu, 25 Dec 2025 07:19:49 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=5igudQll/8jOQKzJg51TRmECmK6LRp3/jTAkF/ssKKA=;
	c=relaxed/relaxed; d=ziyao.cc;
	h=from:to:cc:date:subject:message-id:mime-version:from:to:cc:subject:date:message-id:in-reply-to:reply-to:references;
	q=dns/txt; s=titan1; t=1766647189; v=1;
	b=FPUtczFr0IHDAjVxFkJxwAwzghGvDYIanUpIMRKfN1jAtCf2NQA954MfBKiyuCw8HArgbp8U
	fR3uITTVxkz2vtV7DWFjbTKyY3YkXkRRER+VWUondZrJwVVsZ/JDf0FiWS8mpSueA0trQ3rR+Zp
	MCTykQRGwZSm6cexEmGh52GM=
Received: from ketchup (unknown [117.171.66.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp-out.flockmail.com (Postfix) with ESMTPSA id 4dcKrH5nyzz7t7x;
	Thu, 25 Dec 2025 07:19:43 +0000 (UTC)
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
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
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Yao Zi <me@ziyao.cc>
Subject: [RFC PATCH net-next v5 0/3] Add DWMAC glue driver for Motorcomm YT6801
Date: Thu, 25 Dec 2025 07:19:11 +0000
Message-ID: <20251225071914.1903-1-me@ziyao.cc>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1766647189171909816.30087.9044332867085329703@prod-use1-smtp-out1002.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=WtDRMcfv c=1 sm=1 tr=0 ts=694ce595
	a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
	a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=CEWIc4RMnpUA:10 a=VwQbUJbxAAAA:8
	a=PHq6YzTAAAAA:8 a=NfpvoiIcAAAA:8 a=NEAV23lmAAAA:8 a=LpNgXrTXAAAA:8
	a=rXHHX5KNNKQTorzD0jcA:9 a=ZKzU8r6zoKMcqsNulkmm:22
	a=HwjPHhrhEcEjrsLHunKI:22 a=LqOpv0_-CX5VL_7kjZO3:22
	a=3z85VNIBY5UIEeAh_hcH:22 a=NWVoK91CQySWRX1oVYDe:22

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
Testing is done on i3-4170, it reaches 939Mbps (TX)/932Mbps (RX) on
average,

YT6801 TX

Connecting to host 192.168.114.51, port 5201
[  5] local 192.168.114.50 port 59372 connected to 192.168.114.51 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   112 MBytes   938 Mbits/sec    0    980 KBytes
[  5]   1.00-2.00   sec   112 MBytes   940 Mbits/sec    0   1.01 MBytes
[  5]   2.00-3.00   sec   112 MBytes   943 Mbits/sec    0   1.11 MBytes
[  5]   3.00-4.00   sec   112 MBytes   935 Mbits/sec    0   1.11 MBytes
[  5]   4.00-5.00   sec   113 MBytes   947 Mbits/sec    0   1.11 MBytes
[  5]   5.00-6.00   sec   112 MBytes   940 Mbits/sec    0   1.11 MBytes
[  5]   6.00-7.00   sec   112 MBytes   938 Mbits/sec    0   1.11 MBytes
[  5]   7.00-8.00   sec   111 MBytes   933 Mbits/sec    0   1.11 MBytes
[  5]   8.00-9.00   sec   112 MBytes   942 Mbits/sec    0   1.17 MBytes
[  5]   9.00-10.00  sec   112 MBytes   938 Mbits/sec    0   1.17 MBytes

YT6801 RX

Connecting to host 192.168.114.50, port 5201
[  5] local 192.168.114.51 port 34896 connected to 192.168.114.50 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   112 MBytes   940 Mbits/sec    0    484 KBytes
[  5]   1.00-2.00   sec   111 MBytes   934 Mbits/sec    0    484 KBytes
[  5]   2.00-3.00   sec   112 MBytes   936 Mbits/sec    0    718 KBytes
[  5]   3.00-4.00   sec   112 MBytes   936 Mbits/sec    0    839 KBytes
[  5]   4.00-5.00   sec   110 MBytes   928 Mbits/sec    0    882 KBytes
[  5]   5.00-6.00   sec   112 MBytes   940 Mbits/sec    0    882 KBytes
[  5]   6.00-7.00   sec   112 MBytes   936 Mbits/sec    0    882 KBytes
[  5]   7.00-8.00   sec   111 MBytes   934 Mbits/sec    0    926 KBytes
[  5]   8.00-9.00   sec   112 MBytes   937 Mbits/sec    0   1021 KBytes
[  5]   9.00-10.00  sec   111 MBytes   929 Mbits/sec    0   1021 KBytes

Thanks for your time and review.

[1]: https://lore.kernel.org/all/Z_T6vv013jraCzSD@shell.armlinux.org.uk/
[2]: https://lore.kernel.org/all/a48d76ac-db08-46d5-9528-f046a7b541dc@motor-comm.com/
[3]: https://lore.kernel.org/all/a48d76ac-db08-46d5-9528-f046a7b541dc@motor-comm.com/
[4]: https://github.com/deepin-community/kernel/tree/dc61248a0e21/drivers/net/ethernet/motorcomm/yt6801

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
 .../ethernet/stmicro/stmmac/dwmac-motorcomm.c | 386 ++++++++++++++++++
 drivers/net/phy/motorcomm.c                   |   4 +
 5 files changed, 406 insertions(+)
 create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-motorcomm.c

-- 
2.51.2


