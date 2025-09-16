Return-Path: <netdev+bounces-223727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C062AB5A3EC
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D0E3A6EEE
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F802F8BDC;
	Tue, 16 Sep 2025 21:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JmaPD8Wn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3E5292B44
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758058095; cv=none; b=WmX828QLC2ibUhtEVyk2y3JCUsfhtifyxZs95hpqIl9mDSl+0MeGHjQ/X67WwHGRt6BIwIKWmOXjx+QKEanQRJqJfE+jyjhSSMCq/JzX80CwgJuBTDh7aXqdnAyhTSUPt86aIIsUYUwmZoZhuw6jEtyTv2Lvhz2mFigC20hG9rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758058095; c=relaxed/simple;
	bh=vbrqha01jUKrpxYlEMGeCwgbaLb9hzrE/9MwGP1RgMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lA4U2NMeCMehhyYvabGLw0PUNFuZPfSBj3iHzmVzAHAWickU9pA4W22kR/42VJMjnqvexrYPZSEOELDFcas2RaQOHsRd2Aj0Ue2F/zNnXdSvbI6vT38J6iO1jkhzyGY2JEDC21hB/HQ69OItQ4za9mb52uM4/qxWIpmfBc1ymMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JmaPD8Wn; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758058094; x=1789594094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vbrqha01jUKrpxYlEMGeCwgbaLb9hzrE/9MwGP1RgMo=;
  b=JmaPD8WnmC/w5OGSvNgdYT85XNAhR57GE0/BywUVMx2qdAeeb2jt8eCn
   IVSjbqHA/m9Dfyw24B8+/d8cr/QEeYghQWIjn/9qsW7d90APJuTq3D2lN
   AHzU3z5pIl0XqWsC8e0eOLAXTWJivKhyk9ZcOKgmAKAbELW1Mye1aC2sb
   tpugMh2190x6m6SgyNEZKLQQjml6ruKjuXz6Nc/NrZVzk0PE/xRdrAQBQ
   bVR5AtT82/Jf+X9KJhQxQD5+DiiqNtuYpXqL+SLVZUbk86KVqYUKstff2
   laLjMIG6CqgJXxU2kWLr8YTpN6pvjKVtle6p9wlE3naMZ+BIrZuNwZb9U
   g==;
X-CSE-ConnectionGUID: 4jqatj7VSGq4jLg7yF/1VQ==
X-CSE-MsgGUID: O4zGgsGNR3aKFzt+k+xDuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60410774"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60410774"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 14:28:13 -0700
X-CSE-ConnectionGUID: i5EcxnS1SCC8epJUQtmpgA==
X-CSE-MsgGUID: VC9DlCIuTH6eA+yZVYXRRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,270,1751266800"; 
   d="scan'208";a="180316938"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 16 Sep 2025 14:28:12 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	anthony.l.nguyen@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 3/5] ixgbe: initialize aci.lock before it's used
Date: Tue, 16 Sep 2025 14:27:58 -0700
Message-ID: <20250916212801.2818440-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250916212801.2818440-1-anthony.l.nguyen@intel.com>
References: <20250916212801.2818440-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

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
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Fixes: 4600cdf9f5ac ("ixgbe: Enable link management in E610 device")
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 80e6a2ef1350..9a6a67a6d644 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6973,6 +6973,13 @@ static int ixgbe_sw_init(struct ixgbe_adapter *adapter,
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
@@ -11643,10 +11650,6 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err)
 		goto err_sw_init;
 
-	/* Make sure the SWFW semaphore is in a valid state */
-	if (hw->mac.ops.init_swfw_sync)
-		hw->mac.ops.init_swfw_sync(hw);
-
 	if (ixgbe_check_fw_error(adapter))
 		return ixgbe_recovery_probe(adapter);
 
@@ -11850,8 +11853,6 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ether_addr_copy(hw->mac.addr, hw->mac.perm_addr);
 	ixgbe_mac_set_default_filter(adapter);
 
-	if (hw->mac.type == ixgbe_mac_e610)
-		mutex_init(&hw->aci.lock);
 	timer_setup(&adapter->service_timer, ixgbe_service_timer, 0);
 
 	if (ixgbe_removed(hw->hw_addr)) {
@@ -12007,9 +12008,9 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
-- 
2.47.1


