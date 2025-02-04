Return-Path: <netdev+bounces-162770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FADA27E00
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 23:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E6E166059
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 22:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628572036FD;
	Tue,  4 Feb 2025 22:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mtq+P3QG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A2F25A623
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 22:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738706799; cv=none; b=ekrSZVnK43qcaMab5aDaq6Woo39AaLhyHesphQnJ3KAeYcU9elMflZOXCbgyFxy8t2WdhgWf6cBfu3zBroze0FHKARgroq8/dfd/4d6IjqPUI7WS3j+nxhlYLG6yQx2PflL4tszzQ9tEMXfMvxVcFg9QUxiN6lcnv0qsU8gvY28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738706799; c=relaxed/simple;
	bh=a/CitE48ivMMjOFdZfilEb8WarjRDAAXO/Eqizt7faA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EKuDLJkMOTQzgUka2L6OpFN81HG6r8PqHPe3Yh3j9xIEZ+EYb+3MU5SdBERGShuSX6A/PPgNu07zz1aTF9g+wf9gpPJB6OLxyn78Pxcz+s1BZf6ifl6YuG/JSCDqIMWO+JzlBon0SR+dKZCXP1t1D9Cumlp0l/o93LeGkLiAkec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mtq+P3QG; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738706796; x=1770242796;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a/CitE48ivMMjOFdZfilEb8WarjRDAAXO/Eqizt7faA=;
  b=mtq+P3QGnimpitD4wFCii9btvEm16cmpwa52vvJFZC1tt5HWUGxaaOQq
   knAxirMI1jOVuWNOZ7v9tBiI9iubNeEWI9lJCDjNMyCa+3k++m8TKaJl8
   QZxY7cO5jeBAPiqqSnEW/5GP5thpwkimiYs8R/D3KrdssM0EGHJhnpeWY
   vIKQoSgZKaZrz61oI0qpSXRyz2fX6zB80bMxXiuQul3LHaPZcLWyNy5Pv
   cPdTa+wOtxhHgYvda0MweBPqhgT3v0ApEiHvDpC0p8as4/NK6SgzzAc2e
   SE+LgRsxv/f/9J54muJFGhp+hYsg4OrzhHYSRJrGCoAFLinHEhnBGabow
   w==;
X-CSE-ConnectionGUID: PQ/24L9PRT+ehVuxo47koA==
X-CSE-MsgGUID: yC4SLtolTqqA7fHSR90+9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43003365"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="43003365"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 14:06:36 -0800
X-CSE-ConnectionGUID: gDBmcFePT/igTwICSYS2GA==
X-CSE-MsgGUID: 9FE2diyoSFiTRbv7s6za2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114771261"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.110.39])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 14:06:30 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	michael.chan@broadcom.com,
	tariqt@nvidia.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jdamato@fastly.com,
	shayd@nvidia.com,
	akpm@linux-foundation.org,
	shayagr@amazon.com,
	kalesh-anakkur.purayil@broadcom.com,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v7 0/5] net: napi: add CPU affinity to napi->config
Date: Tue,  4 Feb 2025 15:06:17 -0700
Message-ID: <20250204220622.156061-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drivers usually need to re-apply the user-set IRQ affinity to their IRQs
after reset. However, since there can be only one IRQ affinity notifier
for each IRQ, registering IRQ notifiers conflicts with the ARFS rmap
management in the core (which also registers separate IRQ affinity
notifiers).   

Move the IRQ affinity management to the napi struct. This way we can have
a unified IRQ notifier to re-apply the user-set affinity and also manage
the ARFS rmaps. The first patch  moves the ARFS rmap management to CORE.
The second patch adds the IRQ affinity mask to napi_config and re-applies
the mask after reset. Patches 3-5 use the new API for bnxt, ice and idpf
drivers.

Tested on bnxt, ice and idpf.

V7:
    - P1: add documentation for netif_enable_cpu_rmap()
    - P1: move a couple of "if (rx_cpu_rmap_auto)" from patch 1 to patch 2
      where they are really needed.
    - P1: remove a defensive "if (!rmap)"
    - p1: In netif_disable_cpu_rmap(), remove the for loop that frees
          notifiers since this is already done in napi_disable_locked().
          Also rename it to netif_del_cpu_rmap().
    - P1 and P2: simplify the if conditions in netif_napi_set_irq_locked()
    - Other nits

V6:
    - https://lore.kernel.org/netdev/20250118003335.155379-1-ahmed.zaki@intel.com/
    - Modifications to have less #ifdef CONFIG_RF_ACCL guards
    - Remove rmap entry in napi_disable
    - Rebase on rc7 and use netif_napi_set_irq_locked()
    - Assume IRQ can be -1 and free resources if an old valid IRQ was
      associated with the napi. For this, I had to merge the first 2
      patches to use the new rmap API.

V5:
    - https://lore.kernel.org/netdev/20250113171042.158123-1-ahmed.zaki@intel.com/
    - Add kernel doc for new netdev flags (Simon).
    - Remove defensive (if !napi) check in napi_irq_cpu_rmap_add()
      (patch 2) since caller is already dereferencing the pointer (Simon).
    - Fix build error when CONFIG_ARFS_ACCEL is not defined (patch 3).

v4:
    - https://lore.kernel.org/netdev/20250109233107.17519-1-ahmed.zaki@intel.com/
    - Better introduction in the cover letter.
    - Fix Kernel build errors in ena_init_rx_cpu_rmap() (Patch 1)
    - Fix kernel test robot warnings reported by Dan Carpenter:
      https://lore.kernel.org/all/202501050625.nY1c97EX-lkp@intel.com/
    - Remove unrelated empty line in patch 4 (Kalesh Anakkur Purayil)
    - Fix a memleak (rmap was not freed) by calling cpu_rmap_put() in
      netif_napi_affinity_release() (patch 2).

v3:
    - https://lore.kernel.org/netdev/20250104004314.208259-1-ahmed.zaki@intel.com/
    - Assign one cpu per mask starting from local NUMA node (Shay Drori).
    - Keep the new ARFS and Affinity flags per nedev (Jakub).

v2:
    - https://lore.kernel.org/netdev/202412190454.nwvp3hU2-lkp@intel.com/T/
    - Also move the ARFS IRQ affinity management from drivers to core. Via
      netif_napi_set_irq(), drivers can ask the core to add the IRQ to the
      ARFS rmap (already allocated by the driver).

RFC -> v1:
    - https://lore.kernel.org/netdev/20241210002626.366878-1-ahmed.zaki@intel.com/
    - move static inline affinity functions to net/dev/core.c
    - add the new napi->irq_flags (patch 1)
    - add code changes to bnxt, mlx4 and ice.

Ahmed Zaki (5):
  net: move ARFS rmap management to core
  net: napi: add CPU affinity to napi_config
  bnxt: use napi's irq affinity
  ice: use napi's irq affinity
  idpf: use napi's irq affinity

 Documentation/networking/scaling.rst         |   6 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c |  43 +----
 drivers/net/ethernet/broadcom/bnxt/bnxt.c    |  54 +------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h    |   2 -
 drivers/net/ethernet/intel/ice/ice.h         |   3 -
 drivers/net/ethernet/intel/ice/ice_arfs.c    |  17 +-
 drivers/net/ethernet/intel/ice/ice_base.c    |   7 +-
 drivers/net/ethernet/intel/ice/ice_lib.c     |   6 -
 drivers/net/ethernet/intel/ice/ice_main.c    |  47 +-----
 drivers/net/ethernet/intel/idpf/idpf_lib.c   |   1 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c  |  22 +--
 drivers/net/ethernet/intel/idpf/idpf_txrx.h  |   6 +-
 include/linux/cpu_rmap.h                     |   1 +
 include/linux/netdevice.h                    |  25 ++-
 lib/cpu_rmap.c                               |   2 +-
 net/core/dev.c                               | 160 ++++++++++++++++++-
 16 files changed, 210 insertions(+), 192 deletions(-)

-- 
2.43.0


