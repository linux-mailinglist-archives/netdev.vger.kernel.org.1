Return-Path: <netdev+bounces-170213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4B7A47D5B
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 13:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA23E3B29FF
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 12:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3039F22B8A9;
	Thu, 27 Feb 2025 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJVfMA4i"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D324B5AE;
	Thu, 27 Feb 2025 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658604; cv=none; b=IUWr7xuyZ65LUd8EXGCoMAmGN0riwMILnTif1CseES6aDNUACR5gVT+DIj+BsFEGXgNRxd6CxYu2qyZoje4KBTesc20kiHhQvS7hP8hGM8kQ8RqNhoGcUiHH9sqf4N+/IJucFVTXpgbhayKqOtj5e5g4qGxBh0gw+PZ+QPBYcEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658604; c=relaxed/simple;
	bh=3B68ndRlRYLxP/8pC4+Fmm06fsLO6KJg+oy0KLO1Twg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R59vqSa/6C1hrQPLNR+sE4eY5Ujl20ve2ebLHoaezcnv6yM30AdOs1mm8NNz3SzQtXKCwlkd3nQ4mFxRoOLIK6dG3zagOWfqkd9CSst0wcp5vOqAMaauGnglpCR1t4J+8n7nQzzko2Mki+4jXTd6MzDqe86S8Wc0gb0L0z4EFIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nJVfMA4i; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740658602; x=1772194602;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3B68ndRlRYLxP/8pC4+Fmm06fsLO6KJg+oy0KLO1Twg=;
  b=nJVfMA4iT4ozSTvkhFTOWq9XoByvWXwtE+BQU+Vpfk+wp5zmrd6yztHS
   qI+8BmB83TAXrIKcZbIqdNCGX7ineqsPKKJ0Ao91CL83vfc6iANPtGlGX
   QrqMiv43UFVHNarilYbMzZUDyHmQsPNXkM+KoIx7ruQvY4r9q+FJkMdzw
   BsfKrHbQkkcOBnYKkv3Y13sEG3lw7brnrfIvW2A+Rjhm3bk73waF2EhRc
   EUG28zfGMfs+SHGjYLQpCBcxfrwkCCGnPEN/N7EBYD719hD7yzcwRqnOM
   KEKJCd3vOsnDMH1Myn+vLgbk3zo/LORm5ihKoBu+JYzJCcpNmtEw4oTdm
   Q==;
X-CSE-ConnectionGUID: poqClaYmQWSkXOynRxahXw==
X-CSE-MsgGUID: BVHgkGCCRDK6dZnX6UBSYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41464274"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="41464274"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 04:16:41 -0800
X-CSE-ConnectionGUID: FaGy/bVPSu2TMb+h1UTLiw==
X-CSE-MsgGUID: qK8nIfgOTtKnYWj/rrQvDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117519088"
Received: from yongliang-ubuntu20-ilbpg12.png.intel.com ([10.88.227.39])
  by orviesa007.jf.intel.com with ESMTP; 27 Feb 2025 04:16:34 -0800
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
To: Simon Horman <horms@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	David E Box <david.e.box@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
	David E Box <david.e.box@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v9 0/6] Enable SGMII and 2500BASEX interface mode switching for Intel platforms
Date: Thu, 27 Feb 2025 20:15:16 +0800
Message-Id: <20250227121522.1802832-1-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During the interface mode change, the 'phylink_major_config' function will
be triggered in phylink. The modification of the following functions will
support the switching between SGMII and 2500BASE-X interface modes for
the Intel platform:

- xpcs_switch_interface_mode: Re-initiates clause 37 auto-negotiation for
  the SGMII interface mode to perform auto-negotiation.
- mac_finish: Configures the SerDes according to the interface mode.

With the above changes, the code will work as follows during the interface
mode change. The PCS will reconfigure according to the pcs_neg_mode and the
selected interface mode. Then, the MAC driver will perform SerDes
configuration in 'mac_finish' based on the selected interface mode. During
the SerDes configuration, the selected interface mode will identify TSN
lane registers from FIA and then send IPC commands to the Power Management
Controller (PMC) through the PMC driver/API. The PMC will act as a proxy to
program the PLL registers.

Change log:
v1 -> v2: 
 - Add static to pmc_lpm_modes declaration
 - Add cur_link_an_mode to the kernel doc
 - Combine 2 commits i.e. "stmmac: intel: Separate driver_data of ADL-N
 from TGL" and "net: stmmac: Add 1G/2.5G auto-negotiation
 support for ADL-N" into 1 commit.

v2 -> v3:
 - Create `pmc_ipc.c` file for `intel_pmc_ipc()` function and 
 allocate the file in `arch/x86/platform/intel/` directory.
 - Update phylink's AN mode during phy interface change and 
 not exposing phylink's AN mode into phylib.
 
 v3 -> v4:
 - Introduce `allow_switch_interface` flag to have all ethtool 
 link modes that are supported and advertised will be published.
 - Introduce `mac_get_pcs_neg_mode` function that selects the PCS 
 negotiation mode according to the interface mode.
 - Remove pcs-xpcs.c changes and handle pcs during `mac_select_pcs`
 function
 - Configure SerDes base on the interface on `mac_finish` function.
 
 v4 -> v5:
 - remove 'allow_switch_interface' related patches.
 - remove 'mac_select_pcs' related patches.
 - add a soft reset according to XPCS datasheet for re-initiate Clause 37
 auto-negotiation when switching to SGMII interface mode.

v5 -> v6:
- Remove 'mac_get_pcs_neg_mode' related patches. 
  The pcs_neg_mode is properly handled by the
  'net: add negotiation of in-band capabilities' patch series:
  https://patchwork.kernel.org/project/netdevbpf/cover/Z08kCwxdkU4n2V6x@shell.armlinux.org.uk/
- Using act_link_an_mode to determine PHY, as cfg_link_an_mode was not
  updated for the 2500BASE-X interface mode, caused a failure to link up.
- Clean up and standardize the interface mode switch for xpcs.

v6 -> v7:
- Remove the "net: phylink: use act_link_an_mode to determine PHY" patch.
- Use pl->link_interface in phylink_expects_phy().
- Remove priv->plat->serdes_powerup in intel_tsn_lane_is_available() as it is
  always true.
- Refactor the code in intel_config_serdes().
- Rename intel_config_serdes() to intel_mac_finish() with an AN mode parameter.
- Define the magic number as "max_fia_regs".
- Store the pointer and the number of elements in the platform info structure.
- Move the arrays to the C file.

v7 -> v8:
- Move xpcs_switch_interface_mode() into xpcs_pre_config().
- Move the "stmmac: intel: interface switching support for EHL platform" commit
  into "stmmac: intel: configure SerDes according to the interface mode" to
  resolve the "defined but not used" error.
- Changes for the "arch: x86: add IPC mailbox accessor function and add SoC register access" commit:
    - Rephrase the second bullet in the patch description.
    - Remove 'config INTEL_PMC_IPC' from Kconfig, as discussed.
    - Remove the authors from intel_pmc_ipc.h.
    - Define VALID_IPC_RESPONSE for package.count.
    - Update the copyright year to 2025.
    - Create struct pmc_ipc_rbuf.
    - Update the function description for intel_pmc_ipc().

v8 -> v9
- Clarify the patch description by changing "link goes down" to
  "interface is taken down administratively."
- Revert the change in txgbe_xpcs_switch_mode().
- Swap the sequence of patches 4 and 5.
- Rename the subject line from "stmmac: intel: ..." to "net: stmmac: ...".

v1: https://patchwork.kernel.org/project/netdevbpf/cover/20230622041905.629430-1-yong.liang.choong@linux.intel.com/
v2: https://patchwork.kernel.org/project/netdevbpf/cover/20230804084527.2082302-1-yong.liang.choong@linux.intel.com/
v3: https://patchwork.kernel.org/project/netdevbpf/cover/20230921121946.3025771-1-yong.liang.choong@linux.intel.com/
v4: https://patchwork.kernel.org/project/netdevbpf/cover/20240129130253.1400707-1-yong.liang.choong@linux.intel.com/
v5: https://patchwork.kernel.org/project/netdevbpf/cover/20240215030500.3067426-1-yong.liang.choong@linux.intel.com/
v6: https://patchwork.kernel.org/project/netdevbpf/cover/20250204061020.1199124-1-yong.liang.choong@linux.intel.com/
v7: https://patchwork.kernel.org/project/netdevbpf/cover/20250206131859.2960543-1-yong.liang.choong@linux.intel.com/
v8: https://patchwork.kernel.org/project/netdevbpf/cover/20250226074837.1679988-1-yong.liang.choong@linux.intel.com/

Choong Yong Liang (5):
  net: phylink: use pl->link_interface in phylink_expects_phy()
  net: pcs: xpcs: re-initiate clause 37 Auto-negotiation
  net: stmmac: configure SerDes on mac_finish
  net: stmmac: configure SerDes according to the interface mode
  net: stmmac: interface switching support for ADL-N platform

David E. Box (1):
  arch: x86: add IPC mailbox accessor function and add SoC register
    access

 MAINTAINERS                                   |   1 +
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 231 +++++++++++++++++-
 .../net/ethernet/stmicro/stmmac/dwmac-intel.h |  29 +++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  13 +
 drivers/net/pcs/pcs-xpcs.c                    |  25 +-
 drivers/net/phy/phylink.c                     |   2 +-
 .../linux/platform_data/x86/intel_pmc_ipc.h   |  94 +++++++
 include/linux/stmmac.h                        |   4 +
 9 files changed, 389 insertions(+), 11 deletions(-)
 create mode 100644 include/linux/platform_data/x86/intel_pmc_ipc.h

-- 
2.34.1


