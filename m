Return-Path: <netdev+bounces-81755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD70988B171
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52553C01C12
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B8746450;
	Mon, 25 Mar 2024 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T7QJtGpq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526F945023
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397230; cv=none; b=V6rwFimGCzH6WJ4U/LkRcKin/EXYdjai0aAW6zwHDVAc351xx03bp+vKk2VbCgAeJmh9ICbh2MupArHCQK/UdTZc/HAYQ6GCjcV17tPHBmU67+KlhedXUZnOj35s1bdC02bc2QhJyH0LkaPSj+G1xWBwn26rJm3iR82ERJGj4XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397230; c=relaxed/simple;
	bh=SySjsu3iIts3KDcSJn2phpj7veR/XiDI5y0PSoDvTy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYYOeVKX+8bqE42LO+yBABfFjx9c6arUXd1Kyj3Z6GMOzqawkVCh7iwFYvI80C73DFVGayT1ihE07l/lN/zPy0hbQ3Uutr94UBKuBLlxIDJ1rTu0v/EDMV1e/YI9kzTuoERZZ+k6NlIN5orZS0q7gKLpbBxh8BbF7o7QMRPMgW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T7QJtGpq; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711397229; x=1742933229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SySjsu3iIts3KDcSJn2phpj7veR/XiDI5y0PSoDvTy0=;
  b=T7QJtGpqJ9a8OcdZVBkZqKLWDrs/n9FVK12fVVca4wGbO0fbAA/Yc3l0
   /tycP5eZDpBi9dxevYjB4KdRFjQXcIAH4bVFueGQpMR5HRo9F9X70XqIE
   pg9mPBOYTl9VOnnI3xoE+bAN2iXw1zFcp8d4jTVBnXyyKt8y+ZH5k64cL
   mp+f1EgUNi4jOKDrKD6kHCvvFbeFHA/bggFTqNc0lnzNZFJ3HL2xF4IE0
   6ps+4cssgdGE9NYwrdz68DtLeBhJ91tA/BUHrjLpkgUQPdJG0fsMi47zX
   Ltqvjm+oFaveNpQRh3wrRdX+AdyoSK6RRGIaJu5QxUKiEkyLnXxAg3aJx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="17855100"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="17855100"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 13:07:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="20459296"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 25 Mar 2024 13:07:05 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	Robert Elliott <elliott@hpe.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 2/4] ice: fix memory corruption bug with suspend and rebuild
Date: Mon, 25 Mar 2024 13:06:46 -0700
Message-ID: <20240325200659.993749-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240325200659.993749-1-anthony.l.nguyen@intel.com>
References: <20240325200659.993749-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The ice driver would previously panic after suspend. This is caused
from the driver *only* calling the ice_vsi_free_q_vectors() function by
itself, when it is suspending. Since commit b3e7b3a6ee92 ("ice: prevent
NULL pointer deref during reload") the driver has zeroed out
num_q_vectors, and only restored it in ice_vsi_cfg_def().

This further causes the ice_rebuild() function to allocate a zero length
buffer, after which num_q_vectors is updated, and then the new value of
num_q_vectors is used to index into the zero length buffer, which
corrupts memory.

The fix entails making sure all the code referencing num_q_vectors only
does so after it has been reset via ice_vsi_cfg_def().

I didn't perform a full bisect, but I was able to test against 6.1.77
kernel and that ice driver works fine for suspend/resume with no panic,
so sometime since then, this problem was introduced.

Also clean up an un-needed init of a local variable in the function
being modified.

PANIC from 6.8.0-rc1:

[1026674.915596] PM: suspend exit
[1026675.664697] ice 0000:17:00.1: PTP reset successful
[1026675.664707] ice 0000:17:00.1: 2755 msecs passed between update to cached PHC time
[1026675.667660] ice 0000:b1:00.0: PTP reset successful
[1026675.675944] ice 0000:b1:00.0: 2832 msecs passed between update to cached PHC time
[1026677.137733] ixgbe 0000:31:00.0 ens787: NIC Link is Up 1 Gbps, Flow Control: None
[1026677.190201] BUG: kernel NULL pointer dereference, address: 0000000000000010
[1026677.192753] ice 0000:17:00.0: PTP reset successful
[1026677.192764] ice 0000:17:00.0: 4548 msecs passed between update to cached PHC time
[1026677.197928] #PF: supervisor read access in kernel mode
[1026677.197933] #PF: error_code(0x0000) - not-present page
[1026677.197937] PGD 1557a7067 P4D 0
[1026677.212133] ice 0000:b1:00.1: PTP reset successful
[1026677.212143] ice 0000:b1:00.1: 4344 msecs passed between update to cached PHC time
[1026677.212575]
[1026677.243142] Oops: 0000 [#1] PREEMPT SMP NOPTI
[1026677.247918] CPU: 23 PID: 42790 Comm: kworker/23:0 Kdump: loaded Tainted: G        W          6.8.0-rc1+ #1
[1026677.257989] Hardware name: Intel Corporation M50CYP2SBSTD/M50CYP2SBSTD, BIOS SE5C620.86B.01.01.0005.2202160810 02/16/2022
[1026677.269367] Workqueue: ice ice_service_task [ice]
[1026677.274592] RIP: 0010:ice_vsi_rebuild_set_coalesce+0x130/0x1e0 [ice]
[1026677.281421] Code: 0f 84 3a ff ff ff 41 0f b7 74 ec 02 66 89 b0 22 02 00 00 81 e6 ff 1f 00 00 e8 ec fd ff ff e9 35 ff ff ff 48 8b 43 30 49 63 ed <41> 0f b7 34 24 41 83 c5 01 48 8b 3c e8 66 89 b7 aa 02 00 00 81 e6
[1026677.300877] RSP: 0018:ff3be62a6399bcc0 EFLAGS: 00010202
[1026677.306556] RAX: ff28691e28980828 RBX: ff28691e41099828 RCX: 0000000000188000
[1026677.314148] RDX: 0000000000000000 RSI: 0000000000000010 RDI: ff28691e41099828
[1026677.321730] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[1026677.329311] R10: 0000000000000007 R11: ffffffffffffffc0 R12: 0000000000000010
[1026677.336896] R13: 0000000000000000 R14: 0000000000000000 R15: ff28691e0eaa81a0
[1026677.344472] FS:  0000000000000000(0000) GS:ff28693cbffc0000(0000) knlGS:0000000000000000
[1026677.353000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[1026677.359195] CR2: 0000000000000010 CR3: 0000000128df4001 CR4: 0000000000771ef0
[1026677.366779] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[1026677.374369] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[1026677.381952] PKRU: 55555554
[1026677.385116] Call Trace:
[1026677.388023]  <TASK>
[1026677.390589]  ? __die+0x20/0x70
[1026677.394105]  ? page_fault_oops+0x82/0x160
[1026677.398576]  ? do_user_addr_fault+0x65/0x6a0
[1026677.403307]  ? exc_page_fault+0x6a/0x150
[1026677.407694]  ? asm_exc_page_fault+0x22/0x30
[1026677.412349]  ? ice_vsi_rebuild_set_coalesce+0x130/0x1e0 [ice]
[1026677.418614]  ice_vsi_rebuild+0x34b/0x3c0 [ice]
[1026677.423583]  ice_vsi_rebuild_by_type+0x76/0x180 [ice]
[1026677.429147]  ice_rebuild+0x18b/0x520 [ice]
[1026677.433746]  ? delay_tsc+0x8f/0xc0
[1026677.437630]  ice_do_reset+0xa3/0x190 [ice]
[1026677.442231]  ice_service_task+0x26/0x440 [ice]
[1026677.447180]  process_one_work+0x174/0x340
[1026677.451669]  worker_thread+0x27e/0x390
[1026677.455890]  ? __pfx_worker_thread+0x10/0x10
[1026677.460627]  kthread+0xee/0x120
[1026677.464235]  ? __pfx_kthread+0x10/0x10
[1026677.468445]  ret_from_fork+0x2d/0x50
[1026677.472476]  ? __pfx_kthread+0x10/0x10
[1026677.476671]  ret_from_fork_asm+0x1b/0x30
[1026677.481050]  </TASK>

Fixes: b3e7b3a6ee92 ("ice: prevent NULL pointer deref during reload")
Reported-by: Robert Elliott <elliott@hpe.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index ee3f0d3e3f6d..558422120312 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3091,7 +3091,7 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
 {
 	struct ice_vsi_cfg_params params = {};
 	struct ice_coalesce_stored *coalesce;
-	int prev_num_q_vectors = 0;
+	int prev_num_q_vectors;
 	struct ice_pf *pf;
 	int ret;
 
@@ -3105,13 +3105,6 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
 	if (WARN_ON(vsi->type == ICE_VSI_VF && !vsi->vf))
 		return -EINVAL;
 
-	coalesce = kcalloc(vsi->num_q_vectors,
-			   sizeof(struct ice_coalesce_stored), GFP_KERNEL);
-	if (!coalesce)
-		return -ENOMEM;
-
-	prev_num_q_vectors = ice_vsi_rebuild_get_coalesce(vsi, coalesce);
-
 	ret = ice_vsi_realloc_stat_arrays(vsi);
 	if (ret)
 		goto err_vsi_cfg;
@@ -3121,6 +3114,13 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
 	if (ret)
 		goto err_vsi_cfg;
 
+	coalesce = kcalloc(vsi->num_q_vectors,
+			   sizeof(struct ice_coalesce_stored), GFP_KERNEL);
+	if (!coalesce)
+		return -ENOMEM;
+
+	prev_num_q_vectors = ice_vsi_rebuild_get_coalesce(vsi, coalesce);
+
 	ret = ice_vsi_cfg_tc_lan(pf, vsi);
 	if (ret) {
 		if (vsi_flags & ICE_VSI_FLAG_INIT) {
@@ -3139,8 +3139,8 @@ int ice_vsi_rebuild(struct ice_vsi *vsi, u32 vsi_flags)
 
 err_vsi_cfg_tc_lan:
 	ice_vsi_decfg(vsi);
-err_vsi_cfg:
 	kfree(coalesce);
+err_vsi_cfg:
 	return ret;
 }
 
-- 
2.41.0


