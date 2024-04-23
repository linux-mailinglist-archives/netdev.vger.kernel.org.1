Return-Path: <netdev+bounces-90641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A43048AF687
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 20:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A962288DE8
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 18:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50ED3140370;
	Tue, 23 Apr 2024 18:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="io8I7lkt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EC313FD65
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713896860; cv=none; b=Ui9qiwpuDsmq7YqCNfTop3bnyh6s6OP9xDR6vkOXQleHglvfpyX7EOFdh9us45I/TN4IwmsIlK9YoQdOjlgptd6lcA263jMgvd+y9N7QgJSX1V8ge4zHlBi0pDx9SNcrNBjfyJ4crUSgnVF/dbGsXYa17T481IhKwFMOM6brkc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713896860; c=relaxed/simple;
	bh=d/AFckVwIlDJqtktghKyE69rR1/ytAZ7+AvIQFrdkiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=neS8sM9eqRcyU/3J+2QbBlFI5mLmUZ6lxBxoGpFi2og+ak1nEMrN7byDTVxYJqR7J5hY18vVFX65GUTJhjq8Onatc57NxsiuwE6Um66zBiu4jsQuyCpZZtnh+HJLi6bvJJ5Gi0vQqGlIj6rBvVssVszh3GzZFHkoLAyb+q4/o34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=io8I7lkt; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713896859; x=1745432859;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d/AFckVwIlDJqtktghKyE69rR1/ytAZ7+AvIQFrdkiU=;
  b=io8I7lktqw7QzFPtxKaqeeHPBcqdcENsvE3w9wsCM03BhnZTPoTUCFiv
   8Wr/KR9ddCQrw0SQow3Av0L/4NH5ApuIzcNK3hwYzquwFfaPSfIKQMwtb
   Q90XZxvTPSnk/6MUIY3Jqw73d/yaSaGw+kaz24TpEoJS8e/Jm+Q29wJKQ
   MJpvwiJatVdgTbryZRONLuRWVCyjWTOPDextcbWEtQUw87S60o81uqcSD
   spFkO5rt6FJvto0Yv0AcvJBIo1f45AQG+Y2z1I+KwfNs+oCsZe4T+v0Gd
   SMNUzfnbYO04oM0xbvHJPcRNyeWlfiPtz1TzSEo+Dvhg3zMzyJB/WC3RR
   Q==;
X-CSE-ConnectionGUID: hREhf5gERyS7T8Qysai5hQ==
X-CSE-MsgGUID: lfZrM8wnSIKhQRTzqGg2Tw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20195283"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20195283"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 11:27:36 -0700
X-CSE-ConnectionGUID: FL/acL8fQSa6TebhA7przQ==
X-CSE-MsgGUID: 5y3I4xgmT/S3enMMEyubMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="47726114"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 23 Apr 2024 11:27:35 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Dave Ertman <david.m.ertman@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 4/4] ice: fix LAG and VF lock dependency in ice_reset_vf()
Date: Tue, 23 Apr 2024 11:27:20 -0700
Message-ID: <20240423182723.740401-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240423182723.740401-1-anthony.l.nguyen@intel.com>
References: <20240423182723.740401-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

9f74a3dfcf83 ("ice: Fix VF Reset paths when interface in a failed over
aggregate"), the ice driver has acquired the LAG mutex in ice_reset_vf().
The commit placed this lock acquisition just prior to the acquisition of
the VF configuration lock.

If ice_reset_vf() acquires the configuration lock via the ICE_VF_RESET_LOCK
flag, this could deadlock with ice_vc_cfg_qs_msg() because it always
acquires the locks in the order of the VF configuration lock and then the
LAG mutex.

Lockdep reports this violation almost immediately on creating and then
removing 2 VF:

======================================================
WARNING: possible circular locking dependency detected
6.8.0-rc6 #54 Tainted: G        W  O
------------------------------------------------------
kworker/60:3/6771 is trying to acquire lock:
ff40d43e099380a0 (&vf->cfg_lock){+.+.}-{3:3}, at: ice_reset_vf+0x22f/0x4d0 [ice]

but task is already holding lock:
ff40d43ea1961210 (&pf->lag_mutex){+.+.}-{3:3}, at: ice_reset_vf+0xb7/0x4d0 [ice]

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (&pf->lag_mutex){+.+.}-{3:3}:
       __lock_acquire+0x4f8/0xb40
       lock_acquire+0xd4/0x2d0
       __mutex_lock+0x9b/0xbf0
       ice_vc_cfg_qs_msg+0x45/0x690 [ice]
       ice_vc_process_vf_msg+0x4f5/0x870 [ice]
       __ice_clean_ctrlq+0x2b5/0x600 [ice]
       ice_service_task+0x2c9/0x480 [ice]
       process_one_work+0x1e9/0x4d0
       worker_thread+0x1e1/0x3d0
       kthread+0x104/0x140
       ret_from_fork+0x31/0x50
       ret_from_fork_asm+0x1b/0x30

-> #0 (&vf->cfg_lock){+.+.}-{3:3}:
       check_prev_add+0xe2/0xc50
       validate_chain+0x558/0x800
       __lock_acquire+0x4f8/0xb40
       lock_acquire+0xd4/0x2d0
       __mutex_lock+0x9b/0xbf0
       ice_reset_vf+0x22f/0x4d0 [ice]
       ice_process_vflr_event+0x98/0xd0 [ice]
       ice_service_task+0x1cc/0x480 [ice]
       process_one_work+0x1e9/0x4d0
       worker_thread+0x1e1/0x3d0
       kthread+0x104/0x140
       ret_from_fork+0x31/0x50
       ret_from_fork_asm+0x1b/0x30

other info that might help us debug this:
 Possible unsafe locking scenario:
       CPU0                    CPU1
       ----                    ----
  lock(&pf->lag_mutex);
                               lock(&vf->cfg_lock);
                               lock(&pf->lag_mutex);
  lock(&vf->cfg_lock);

 *** DEADLOCK ***
4 locks held by kworker/60:3/6771:
 #0: ff40d43e05428b38 ((wq_completion)ice){+.+.}-{0:0}, at: process_one_work+0x176/0x4d0
 #1: ff50d06e05197e58 ((work_completion)(&pf->serv_task)){+.+.}-{0:0}, at: process_one_work+0x176/0x4d0
 #2: ff40d43ea1960e50 (&pf->vfs.table_lock){+.+.}-{3:3}, at: ice_process_vflr_event+0x48/0xd0 [ice]
 #3: ff40d43ea1961210 (&pf->lag_mutex){+.+.}-{3:3}, at: ice_reset_vf+0xb7/0x4d0 [ice]

stack backtrace:
CPU: 60 PID: 6771 Comm: kworker/60:3 Tainted: G        W  O       6.8.0-rc6 #54
Hardware name:
Workqueue: ice ice_service_task [ice]
Call Trace:
 <TASK>
 dump_stack_lvl+0x4a/0x80
 check_noncircular+0x12d/0x150
 check_prev_add+0xe2/0xc50
 ? save_trace+0x59/0x230
 ? add_chain_cache+0x109/0x450
 validate_chain+0x558/0x800
 __lock_acquire+0x4f8/0xb40
 ? lockdep_hardirqs_on+0x7d/0x100
 lock_acquire+0xd4/0x2d0
 ? ice_reset_vf+0x22f/0x4d0 [ice]
 ? lock_is_held_type+0xc7/0x120
 __mutex_lock+0x9b/0xbf0
 ? ice_reset_vf+0x22f/0x4d0 [ice]
 ? ice_reset_vf+0x22f/0x4d0 [ice]
 ? rcu_is_watching+0x11/0x50
 ? ice_reset_vf+0x22f/0x4d0 [ice]
 ice_reset_vf+0x22f/0x4d0 [ice]
 ? process_one_work+0x176/0x4d0
 ice_process_vflr_event+0x98/0xd0 [ice]
 ice_service_task+0x1cc/0x480 [ice]
 process_one_work+0x1e9/0x4d0
 worker_thread+0x1e1/0x3d0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x104/0x140
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x31/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1b/0x30
 </TASK>

To avoid deadlock, we must acquire the LAG mutex only after acquiring the
VF configuration lock. Fix the ice_reset_vf() to acquire the LAG mutex only
after we either acquire or check that the VF configuration lock is held.

Fixes: 9f74a3dfcf83 ("ice: Fix VF Reset paths when interface in a failed over aggregate")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Dave Ertman <david.m.ertman@intel.com>
Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Tested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_vf_lib.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 21d26e19338a..d10a4be965b5 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -856,6 +856,11 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
 		return 0;
 	}
 
+	if (flags & ICE_VF_RESET_LOCK)
+		mutex_lock(&vf->cfg_lock);
+	else
+		lockdep_assert_held(&vf->cfg_lock);
+
 	lag = pf->lag;
 	mutex_lock(&pf->lag_mutex);
 	if (lag && lag->bonded && lag->primary) {
@@ -867,11 +872,6 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
 			act_prt = ICE_LAG_INVALID_PORT;
 	}
 
-	if (flags & ICE_VF_RESET_LOCK)
-		mutex_lock(&vf->cfg_lock);
-	else
-		lockdep_assert_held(&vf->cfg_lock);
-
 	if (ice_is_vf_disabled(vf)) {
 		vsi = ice_get_vf_vsi(vf);
 		if (!vsi) {
@@ -956,14 +956,14 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
 	ice_mbx_clear_malvf(&vf->mbx_info);
 
 out_unlock:
-	if (flags & ICE_VF_RESET_LOCK)
-		mutex_unlock(&vf->cfg_lock);
-
 	if (lag && lag->bonded && lag->primary &&
 	    act_prt != ICE_LAG_INVALID_PORT)
 		ice_lag_move_vf_nodes_cfg(lag, pri_prt, act_prt);
 	mutex_unlock(&pf->lag_mutex);
 
+	if (flags & ICE_VF_RESET_LOCK)
+		mutex_unlock(&vf->cfg_lock);
+
 	return err;
 }
 
-- 
2.41.0


