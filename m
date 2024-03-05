Return-Path: <netdev+bounces-77637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3D487271B
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 19:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4750A1F29B5B
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 18:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DE93FE37;
	Tue,  5 Mar 2024 18:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVVzzh7q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0799920DE0
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 18:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665068; cv=none; b=FenVdB4LGkd0Dtu2cDR8dfsy2ANL3useKc3ekde4Y/btHqksG9mXwtIxookQJDpynH5rcEE00+wCjlr4rmdsG4JLmzxgqHAi/2ng2bemzIC1RnDmAL0Q7glLNtoUX8+BcDWl2SOgQDei/BqvS77pBwukIG9o9YS+ATZyLKdA9mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665068; c=relaxed/simple;
	bh=ZctnU+8qakL4RcLDmv6J7vppTFrIp2VFhILHZcJhI5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuPGF9aiYviSV0RCwy4lKP0pCNYUJ/b8GlFI3uhoB+/CeBHt13zZTKiNz4AkZJH2pGYhQeWBzGLdoaWSr3roPr7EkFj5n7r8orbSgq7HlmK0QXgww4Cu+La6oQp10izLK7Q0ZKIFabaoalk4NGYoskl/Qs2Wl4LYhFiFH5iCnss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVVzzh7q; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709665067; x=1741201067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZctnU+8qakL4RcLDmv6J7vppTFrIp2VFhILHZcJhI5s=;
  b=MVVzzh7q2qrsdMPIqDEs+JmuESN6Hr3EHBNnqSwwz1IWf0SfTjjhbWG0
   8NYx31XvS733EuNKJmvw22ULqocLEnoVJBjhSQB2soj4BWCayYmJ6S9tG
   xabiODBBz+MBW4nEQZmmwn8UY3zeVCtSanXke9k9HU0jOYCYgzkx1t9li
   7SvPHaJ/xUm/clXVrNHAJQmI9c6VGXc2FCY7um/Ea/HdcqIu70dQugKr4
   Tp1QhrbdSSFfDC+lNDPZvzvQkVKNDcPUstyBVDd9x2sanfcC/43qglJK3
   JgBqXPtUt7z98ovgWb6MN2TrwVSIRVOH0hnUYFU6L82qGSbmCQSSGv48T
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4822200"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="4822200"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 10:57:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="9337214"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 05 Mar 2024 10:57:44 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	anthony.l.nguyen@intel.com,
	arkadiusz.kubalewski@intel.com,
	jiri@resnulli.us,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net 4/8] ice: fix uninitialized dplls mutex usage
Date: Tue,  5 Mar 2024 10:57:32 -0800
Message-ID: <20240305185737.3925349-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305185737.3925349-1-anthony.l.nguyen@intel.com>
References: <20240305185737.3925349-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Schmidt <mschmidt@redhat.com>

The pf->dplls.lock mutex is initialized too late, after its first use.
Move it to the top of ice_dpll_init.
Note that the "err_exit" error path destroys the mutex. And the mutex is
the last thing destroyed in ice_dpll_deinit.
This fixes the following warning with CONFIG_DEBUG_MUTEXES:

 ice 0000:10:00.0: The DDP package was successfully loaded: ICE OS Default Package version 1.3.36.0
 ice 0000:10:00.0: 252.048 Gb/s available PCIe bandwidth (16.0 GT/s PCIe x16 link)
 ice 0000:10:00.0: PTP init successful
 ------------[ cut here ]------------
 DEBUG_LOCKS_WARN_ON(lock->magic != lock)
 WARNING: CPU: 0 PID: 410 at kernel/locking/mutex.c:587 __mutex_lock+0x773/0xd40
 Modules linked in: crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic ice(+) nvme nvme_c>
 CPU: 0 PID: 410 Comm: kworker/0:4 Not tainted 6.8.0-rc5+ #3
 Hardware name: HPE ProLiant DL110 Gen10 Plus/ProLiant DL110 Gen10 Plus, BIOS U56 10/19/2023
 Workqueue: events work_for_cpu_fn
 RIP: 0010:__mutex_lock+0x773/0xd40
 Code: c0 0f 84 1d f9 ff ff 44 8b 35 0d 9c 69 01 45 85 f6 0f 85 0d f9 ff ff 48 c7 c6 12 a2 a9 85 48 c7 c7 12 f1 a>
 RSP: 0018:ff7eb1a3417a7ae0 EFLAGS: 00010286
 RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
 RDX: 0000000000000002 RSI: ffffffff85ac2bff RDI: 00000000ffffffff
 RBP: ff7eb1a3417a7b80 R08: 0000000000000000 R09: 00000000ffffbfff
 R10: ff7eb1a3417a7978 R11: ff32b80f7fd2e568 R12: 0000000000000000
 R13: 0000000000000000 R14: 0000000000000000 R15: ff32b7f02c50e0d8
 FS:  0000000000000000(0000) GS:ff32b80efe800000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000055b5852cc000 CR3: 000000003c43a004 CR4: 0000000000771ef0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  <TASK>
  ? __warn+0x84/0x170
  ? __mutex_lock+0x773/0xd40
  ? report_bug+0x1c7/0x1d0
  ? prb_read_valid+0x1b/0x30
  ? handle_bug+0x42/0x70
  ? exc_invalid_op+0x18/0x70
  ? asm_exc_invalid_op+0x1a/0x20
  ? __mutex_lock+0x773/0xd40
  ? rcu_is_watching+0x11/0x50
  ? __kmalloc_node_track_caller+0x346/0x490
  ? ice_dpll_lock_status_get+0x28/0x50 [ice]
  ? __pfx_ice_dpll_lock_status_get+0x10/0x10 [ice]
  ? ice_dpll_lock_status_get+0x28/0x50 [ice]
  ice_dpll_lock_status_get+0x28/0x50 [ice]
  dpll_device_get_one+0x14f/0x2e0
  dpll_device_event_send+0x7d/0x150
  dpll_device_register+0x124/0x180
  ice_dpll_init_dpll+0x7b/0xd0 [ice]
  ice_dpll_init+0x224/0xa40 [ice]
  ? _dev_info+0x70/0x90
  ice_load+0x468/0x690 [ice]
  ice_probe+0x75b/0xa10 [ice]
  ? _raw_spin_unlock_irqrestore+0x4f/0x80
  ? process_one_work+0x1a3/0x500
  local_pci_probe+0x47/0xa0
  work_for_cpu_fn+0x17/0x30
  process_one_work+0x20d/0x500
  worker_thread+0x1df/0x3e0
  ? __pfx_worker_thread+0x10/0x10
  kthread+0x103/0x140
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x31/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1b/0x30
  </TASK>
 irq event stamp: 125197
 hardirqs last  enabled at (125197): [<ffffffff8416409d>] finish_task_switch.isra.0+0x12d/0x3d0
 hardirqs last disabled at (125196): [<ffffffff85134044>] __schedule+0xea4/0x19f0
 softirqs last  enabled at (105334): [<ffffffff84e1e65a>] napi_get_frags_check+0x1a/0x60
 softirqs last disabled at (105332): [<ffffffff84e1e65a>] napi_get_frags_check+0x1a/0x60
 ---[ end trace 0000000000000000 ]---

Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index adfa1f2a80a6..fda9140c0da4 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -2120,6 +2120,7 @@ void ice_dpll_init(struct ice_pf *pf)
 	struct ice_dplls *d = &pf->dplls;
 	int err = 0;
 
+	mutex_init(&d->lock);
 	err = ice_dpll_init_info(pf, cgu);
 	if (err)
 		goto err_exit;
@@ -2132,7 +2133,6 @@ void ice_dpll_init(struct ice_pf *pf)
 	err = ice_dpll_init_pins(pf, cgu);
 	if (err)
 		goto deinit_pps;
-	mutex_init(&d->lock);
 	if (cgu) {
 		err = ice_dpll_init_worker(pf);
 		if (err)
-- 
2.41.0


