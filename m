Return-Path: <netdev+bounces-169235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 469B3A430C0
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 00:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3873BA5B4
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 23:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65B820C481;
	Mon, 24 Feb 2025 23:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="idoiG1OZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B528520C488
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 23:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439362; cv=none; b=QxAQb9/mBW9Z6kmo/aRPxJ+fEuodCQ8wycZclbxgdECmJ4GqS2kNccCD8pdwObi2jmz5HOvBRTF2ogqGSLbIknVo48ZTcqv3dL4oBKRVbP2RHHhap6T1bVzGNkkuvCKOVXyyigTiK0zCjv4t6OAVY+dhFb5Gy+QITn8OuWjJbxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439362; c=relaxed/simple;
	bh=6w+UArCyON/1seBfb1skkQg/fUan9OUwJT9DM7ke5Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X/FeOjQF25SXUD/9H8S7GfsmJbarf1Xgw1Ewym+h+eVpUst/uuDkZ+uLaZKtLOqVvX9Qn9GBwZgRX+JiP2yqfga9aJXaHTjtcGCakWqqpCLK385L1ehOTetKztLOVqELwZjIh0J3LEy8BkSt16HB7JCgEMBdi5IDGjiPzaw6uZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=idoiG1OZ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740439361; x=1771975361;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6w+UArCyON/1seBfb1skkQg/fUan9OUwJT9DM7ke5Qo=;
  b=idoiG1OZwcdr8diuKeOce6JPA/E+uiiZtM8JgioDtk4gu63R4BWDnuEA
   I0e5EebSwnys0rm9fQOBAykOM9sv/nJ0Eh8GXZj58rnqGlbPo2Gw1TIdq
   o4mD6hC0MRNoHZaaWWtMml7guiio2gPIIs6r/yoeEJufVYrf9ymeW6d4T
   cM19bps1txszP49ObZ2bFIugFsnZG+CVvvu2xnQUc7GgCSQM8aOtd5hs8
   seUu+lzog5MDj9KvPUSEjwJjmUd7EF4rFKZCDtoloYfBqUUdzJuOtBZCp
   W3+CXPyz+GsWWMowoVJ2CpsXasWEbXyn86RVryxEi5nSI15T0XKe/uFEU
   g==;
X-CSE-ConnectionGUID: uMZBjHhLQjSS7RToZEuYmw==
X-CSE-MsgGUID: c0TwlbHeTFehv6AVsciqzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="40406596"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="40406596"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 15:22:40 -0800
X-CSE-ConnectionGUID: U3J2lRS1QZayrRBspD0s4g==
X-CSE-MsgGUID: CuyWXZYER6m5X/tbWHtehA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="115997747"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.245.244.43])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 15:22:34 -0800
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
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v9 0/6] net: napi: add CPU affinity to napi->config 
Date: Mon, 24 Feb 2025 16:22:21 -0700
Message-ID: <20250224232228.990783-1-ahmed.zaki@intel.com>
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
the ARFS rmaps.

The first patch moves the aRFS rmap management to CORE. It also adds the
IRQ affinity mask to napi_config and re-applies the mask after reset.
Patches 2, 4 and 5 use the new API for ena, ice and idpf drivers.

ICE does not always delete the NAPIs before releasing the IRQs. The third
patch makes sure the driver removes the IRQ number along with the queue
when the NAPIs are disabled. Without this, the next patches in this series
would free the IRQ before releasing the IRQ notifier (which generates
warnings).

Tested on ice and idpf.

V9:
    - Merge all core changes in the first patch, then followed by drivers
      changes. (Jakub)
    - Refactor netif_napi_set_irq_locked() to show differences between
      irq_affinity_auto only vs rx_cpu_rmap_auto = true. (Jakub)
    - Move default affinity setting to netif_set_affinity_auto (Jakub).
    - Add a py selftest for IRQ affinity. (Jakub)
    - Remove bnxt changes since it recently added TPH (commit c214410c47d6
      "bnxt_en: Add TPH support in BNXT driver"). This required the driver
      to have custom IRQ affinity function. For the core to support this,
      we may need to extend the API in this series to allow drivers to
      provide their own callbacks when calling netif_napi_set_irq().

V8:
    - https://lore.kernel.org/netdev/20250211210657.428439-1-ahmed.zaki@intel.com/
    - Add a new patch in "ice" that releases the IRQs and their notifiers
      when clearing the NAPI queues (pls read 3rd paragraph above).
    - Add a new NAPI flag "NAPI_STATE_HAS_NOTIFIER" that simplifies the
      code for IRQ notifier detection (Patch 2).
    - Move the IRQ notifier auto-removal to napi_delete() instead of
      napi_disable(). This is the reason for the new ice patch. (Jakub)
    - Add a WARN_ON_ONCE(!napi->config) in netif_napi_set_irq_locked().
      This would detect drivers that asked for irq_affinity_auto but did
      not use napi_add_config(). (Patch 3) (Joe)
    - Rename netif_enable_irq_affinity() to netif_set_affinity_auto()
      (Patch 3) (Jakub).
V7:
    - https://lore.kernel.org/netdev/20250204220622.156061-1-ahmed.zaki@intel.com/
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
  net: move aRFS rmap management and CPU affinity to core
  net: ena: use napi's aRFS rmap notifers
  ice: clear NAPI's IRQ numbers in ice_vsi_clear_napi_queues()
  ice: use napi's irq affinity and rmap IRQ notifiers
  idpf: use napi's irq affinity

Jakub Kicinski (1):
  selftests: drv-net: add tests for napi IRQ affinity notifiers

 Documentation/networking/scaling.rst          |   6 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |  43 +----
 drivers/net/ethernet/intel/ice/ice.h          |   3 -
 drivers/net/ethernet/intel/ice/ice_arfs.c     |  33 +---
 drivers/net/ethernet/intel/ice/ice_arfs.h     |   2 -
 drivers/net/ethernet/intel/ice/ice_base.c     |   7 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  16 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  47 +----
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   1 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  22 +--
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   6 +-
 include/linux/cpu_rmap.h                      |   1 +
 include/linux/netdevice.h                     |  24 ++-
 lib/cpu_rmap.c                                |   2 +-
 net/core/dev.c                                | 169 ++++++++++++++++++
 .../testing/selftests/drivers/net/hw/Makefile |   4 +
 tools/testing/selftests/drivers/net/hw/irq.py |  99 ++++++++++
 .../selftests/drivers/net/hw/xdp_dummy.bpf.c  |  13 ++
 .../selftests/drivers/net/lib/py/env.py       |   8 +-
 19 files changed, 343 insertions(+), 163 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/irq.py
 create mode 100644 tools/testing/selftests/drivers/net/hw/xdp_dummy.bpf.c

-- 
2.43.0


