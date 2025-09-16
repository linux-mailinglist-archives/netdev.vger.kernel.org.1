Return-Path: <netdev+bounces-223728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C0AB5A3EE
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 213D91C011C8
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425D12F9D9E;
	Tue, 16 Sep 2025 21:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GmxfHw1k"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F0E2E7F03
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758058096; cv=none; b=qaVmeNQl4xhc62qnE8x1ABzyGx2kB9iRQK24/41690/XTQhr2dfQwEQItlMdnYf5pwae7d6S8jU5KZ+2+MP3tOTh5RMIKUdUgK/YR403g8jbNJwRoi/kS65jWmTGaNT77S8abWid9og0LpHLSPYwykonxiB0aIP4WaOOyjg16is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758058096; c=relaxed/simple;
	bh=ZcNL+0EGPfS1BO0FQJ/KCGS+1lYQ7JcxCKwEKgkJ8+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxloYBb3pHrUWNfZbOW/3tdhST7UaCJgQLTaqIn1Tp2iC0LVGQLQBe9cI89em1/+atQNAE/ZEKwBk4ZIjZ+JGh/5f4x97wdotfdRN5gKDMFUF81USHbcKmdvD9U1KbCGMehs7GLn+FnLd0ttlhT8RxL2dYIoHN3RCuerY4bIk3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GmxfHw1k; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758058095; x=1789594095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZcNL+0EGPfS1BO0FQJ/KCGS+1lYQ7JcxCKwEKgkJ8+A=;
  b=GmxfHw1kJHKCSW3ZaA8pZHkqsM29MNWL3ZEZ98q7LMukWTn8Woe392ij
   vig9GgsUWqSTckrTj2GQdZL9hi0P8C8AOSaC5xDJ6bwyLoF0SEGj8ZpSn
   bieO7vfqR+NcXVOGa5gEmE3yr679h8ivx9Q5usN38gJMs61qaqtaIzCX1
   zofhbWe40jG6sYNEHFLNBsMEtqRpqonnQowN9NFFgDNdR1FnHTc1qvUtx
   mMRExipU59RA46cmGjPa2G2sXi7NTyASFUgIJ7WAh+sNXkW2DFdnl7hvs
   HAOezEEvitrpg/FcZM9LIm/c1O6RgWvPJz3sSQ0wGFy2p2zIAQwkCr4Ti
   g==;
X-CSE-ConnectionGUID: XbIt8nLrS3OJYXTwiBXC2Q==
X-CSE-MsgGUID: uxJv6pAzQxWLsTWDk6uYTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60410780"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60410780"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 14:28:13 -0700
X-CSE-ConnectionGUID: +TJi0BjdRKCtqvuJnPhIoQ==
X-CSE-MsgGUID: K46dgxgJSEO5SIaX/VjcMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,270,1751266800"; 
   d="scan'208";a="180316941"
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
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 4/5] ixgbe: destroy aci.lock later within ixgbe_remove path
Date: Tue, 16 Sep 2025 14:27:59 -0700
Message-ID: <20250916212801.2818440-5-anthony.l.nguyen@intel.com>
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

There's another issue with aci.lock and previous patch uncovers it.
aci.lock is being destroyed during removing ixgbe while some of the
ixgbe closing routines are still ongoing. These routines use Admin
Command Interface which require taking aci.lock which has been already
destroyed what leads to call trace.

[  +0.000004] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
[  +0.000007] WARNING: CPU: 12 PID: 10277 at kernel/locking/mutex.c:155 mutex_lock+0x5f/0x70
[  +0.000002] Call Trace:
[  +0.000003]  <TASK>
[  +0.000006]  ixgbe_aci_send_cmd+0xc8/0x220 [ixgbe]
[  +0.000049]  ? try_to_wake_up+0x29d/0x5d0
[  +0.000009]  ixgbe_disable_rx_e610+0xc4/0x110 [ixgbe]
[  +0.000032]  ixgbe_disable_rx+0x3d/0x200 [ixgbe]
[  +0.000027]  ixgbe_down+0x102/0x3b0 [ixgbe]
[  +0.000031]  ixgbe_close_suspend+0x28/0x90 [ixgbe]
[  +0.000028]  ixgbe_close+0xfb/0x100 [ixgbe]
[  +0.000025]  __dev_close_many+0xae/0x220
[  +0.000005]  dev_close_many+0xc2/0x1a0
[  +0.000004]  ? kernfs_should_drain_open_files+0x2a/0x40
[  +0.000005]  unregister_netdevice_many_notify+0x204/0xb00
[  +0.000006]  ? __kernfs_remove.part.0+0x109/0x210
[  +0.000006]  ? kobj_kset_leave+0x4b/0x70
[  +0.000008]  unregister_netdevice_queue+0xf6/0x130
[  +0.000006]  unregister_netdev+0x1c/0x40
[  +0.000005]  ixgbe_remove+0x216/0x290 [ixgbe]
[  +0.000021]  pci_device_remove+0x42/0xb0
[  +0.000007]  device_release_driver_internal+0x19c/0x200
[  +0.000008]  driver_detach+0x48/0x90
[  +0.000003]  bus_remove_driver+0x6d/0xf0
[  +0.000006]  pci_unregister_driver+0x2e/0xb0
[  +0.000005]  ixgbe_exit_module+0x1c/0xc80 [ixgbe]

Same as for the previous commit, the issue has been highlighted by the
commit 337369f8ce9e ("locking/mutex: Add MUTEX_WARN_ON() into fast path").

Move destroying aci.lock to the end of ixgbe_remove(), as this
simply fixes the issue.

Fixes: 4600cdf9f5ac ("ixgbe: Enable link management in E610 device")
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 9a6a67a6d644..6218bdb7f941 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -12061,10 +12061,8 @@ static void ixgbe_remove(struct pci_dev *pdev)
 	set_bit(__IXGBE_REMOVING, &adapter->state);
 	cancel_work_sync(&adapter->service_task);
 
-	if (adapter->hw.mac.type == ixgbe_mac_e610) {
+	if (adapter->hw.mac.type == ixgbe_mac_e610)
 		ixgbe_disable_link_status_events(adapter);
-		mutex_destroy(&adapter->hw.aci.lock);
-	}
 
 	if (adapter->mii_bus)
 		mdiobus_unregister(adapter->mii_bus);
@@ -12124,6 +12122,9 @@ static void ixgbe_remove(struct pci_dev *pdev)
 	disable_dev = !test_and_set_bit(__IXGBE_DISABLED, &adapter->state);
 	free_netdev(netdev);
 
+	if (adapter->hw.mac.type == ixgbe_mac_e610)
+		mutex_destroy(&adapter->hw.aci.lock);
+
 	if (disable_dev)
 		pci_disable_device(pdev);
 }
-- 
2.47.1


