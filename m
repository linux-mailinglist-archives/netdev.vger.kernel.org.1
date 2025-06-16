Return-Path: <netdev+bounces-198073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185E9ADB28D
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECB697A38BC
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 13:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBC32DBF4E;
	Mon, 16 Jun 2025 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gJbY9KT2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828932980B0
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 13:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750081953; cv=none; b=rbk0bscGGno+0EgiCeRqq2kp/+W/rXnkloCYvKqh2fvK21oU0SWHSV4NcFMJ8sAaLv4rckOSaESj3fTeC5JISRqBwrTeljEAoTuos0EzQsCYzyC5dNamj26FI/pBgnDk6cjzGH4fiGs4LTbS1cjHaYyrMi68wIxbRL9qRd3XNHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750081953; c=relaxed/simple;
	bh=tmGIZrqUdKwsTfypfMjWY4BiQcvZrniX9b2OdyQnEfA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CqntqvY+uM6LIkgn2HuXntmieDhBSJAHEsLey2JzAQJDyK9uR8OGzAHD0VUv7P7cjTCwXEVokFpOtVxxztlOBdbL4woushyjRmB35Wdv7D8ECnYjDCUl7q1m2h7i7JA1OnKMXPKkx9Y4xowDDGSwLOTtdc4RBcf+myQSk9SnP4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gJbY9KT2; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750081951; x=1781617951;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tmGIZrqUdKwsTfypfMjWY4BiQcvZrniX9b2OdyQnEfA=;
  b=gJbY9KT24iHdEXqLc+PabsElrPi+YSzXEdzVLaR3eixnnNW7lncfCINg
   ins8yAWX0UyU//vSLrv0MLNPcxGjaE3luSU7c/tzPJHYi4xccrQ5qfxi9
   esm9tyiQaM9jHiWYDH1X9uI6R+fRyJFBlZMAgj1b7JrJND8/2bSniGD23
   DAOtbf59caD9JeOFMj83OVdtBoiSNW2DrPtxfgVLf3JCzwZ23iIasK9Ds
   P+bYQO1JUr9ypuUvoP7yFjKk6nHdgZ1X29/6rGpKqtql8IUrUEaB2cItt
   /nUO8znuF8ifVQmWL0NLS4tSw1I0Ss3Y4th/77JAccCW7pZNi3uHw92Si
   Q==;
X-CSE-ConnectionGUID: COXOoyrSRomlR6eejYKTgg==
X-CSE-MsgGUID: JM+TChmlTumE/LdrVGk+yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="74758751"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="74758751"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 06:52:26 -0700
X-CSE-ConnectionGUID: ZBlJptONQkaeR5d+jI1KUg==
X-CSE-MsgGUID: VJnSZJrpSKeMAIz1gubSjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="148382406"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa007.fm.intel.com with ESMTP; 16 Jun 2025 06:52:24 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net v1] ixgbe: initialize aci.lock before it's used
Date: Mon, 16 Jun 2025 15:36:36 +0200
Message-Id: <20250616133636.1304288-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently aci.lock is initialized too late. A bunch of ACI callbacks
using the lock are called prior it's initialized.

Commit 337369f8ce9e ("locking/mutex: Add MUTEX_WARN_ON() into fast path")
highlights that issue what results in call trace.

[    4.092899] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
[    4.092910] WARNING: CPU: 0 PID: 578 at kernel/locking/mutex.c:154 mutex_lock+0x6d/0x80
[    4.098757] Call Trace:
[    4.098847]  <TASK>
[    4.098922]  ixgbe_aci_send_cmd+0x8c/0x1e0 [ixgbe]
[    4.099108]  ? hrtimer_try_to_cancel+0x18/0x110
[    4.099277]  ixgbe_aci_get_fw_ver+0x52/0xa0 [ixgbe]
[    4.099460]  ixgbe_check_fw_error+0x1fc/0x2f0 [ixgbe]
[    4.099650]  ? usleep_range_state+0x69/0xd0
[    4.099811]  ? usleep_range_state+0x8c/0xd0
[    4.099964]  ixgbe_probe+0x3b0/0x12d0 [ixgbe]
[    4.100132]  local_pci_probe+0x43/0xa0
[    4.100267]  work_for_cpu_fn+0x13/0x20
[    4.101647]  </TASK>

Move aci.lock mutex initialization to ixgbe_sw_init() before any ACI
command is sent. Along with that move also related SWFW semaphore in
order to reduce size of ixgbe_probe() and that way all locks are
initialized in ixgbe_sw_init().

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Fixes: 4600cdf9f5ac ("ixgbe: Enable link management in E610 device")
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 03d31e5b131d..18cae81dc794 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6801,6 +6801,13 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter,
 		break;
 	}
 
+	/* Make sure the SWFW semaphore is in a valid state */
+	if (hw->mac.ops.init_swfw_sync)
+		hw->mac.ops.init_swfw_sync(hw);
+
+	if (hw->mac.type == ixgbe_mac_e610)
+		mutex_init(&hw->aci.lock);
+
 #ifdef IXGBE_FCOE
 	/* FCoE support exists, always init the FCoE lock */
 	spin_lock_init(&adapter->fcoe.lock);
@@ -11473,10 +11480,6 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto err_sw_init;
 
-	/* Make sure the SWFW semaphore is in a valid state */
-	if (hw->mac.ops.init_swfw_sync)
-		hw->mac.ops.init_swfw_sync(hw);
-
 	if (ixgbe_check_fw_error(adapter))
 		return ixgbe_recovery_probe(adapter);
 
@@ -11680,8 +11683,6 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ether_addr_copy(hw->mac.addr, hw->mac.perm_addr);
 	ixgbe_mac_set_default_filter(adapter);
 
-	if (hw->mac.type == ixgbe_mac_e610)
-		mutex_init(&hw->aci.lock);
 	timer_setup(&adapter->service_timer, ixgbe_service_timer, 0);
 
 	if (ixgbe_removed(hw->hw_addr)) {
@@ -11837,9 +11838,9 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	devl_unlock(adapter->devlink);
 	ixgbe_release_hw_control(adapter);
 	ixgbe_clear_interrupt_scheme(adapter);
+err_sw_init:
 	if (hw->mac.type == ixgbe_mac_e610)
 		mutex_destroy(&adapter->hw.aci.lock);
-err_sw_init:
 	ixgbe_disable_sriov(adapter);
 	adapter->flags2 &= ~IXGBE_FLAG2_SEARCH_FOR_SFP;
 	iounmap(adapter->io_addr);

base-commit: a76bd1156de9fd1d4be4502cbb5160a709ff4cd7
-- 
2.31.1


