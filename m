Return-Path: <netdev+bounces-82173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 551C388C90B
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 17:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7BC1F643A8
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 16:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E1A13CFAA;
	Tue, 26 Mar 2024 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZCIOybX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5300113CF83
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470250; cv=none; b=XYGlmSG5zNX3UfuRv/Fvm12opwgWVr35t9RTzdN3Y57s+NzWJ6Sbgdo8rZGzPqC5nMC2FAyRarMBiqKgJwPWIG/oIT3PIjiR2HjS5ZLKY6XtZTzyXStBuFB+k8cFogslXZDpWE0q8yQJvQ3X6SJhYUHLDqKHarDNlSWO1NyEtPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470250; c=relaxed/simple;
	bh=6FoKeU6c+r3cZG13vdZh6+5naHZHmr24ZICALbq94Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SBwBmsIukrEUmXe/RiqHA50w7gCHxXBpqeukjQfiY3up5v+oXD/j98DVoVNUA5s5gwW8Yiz69Tphtbv85f3UAy1UAUR2JhUOSCXGJ+EHmYp4OiFFmimpHZgxs09oBoUCJlnUN9mt1pRe9vVBHuxtLD5cC/9VdvThEto5dpGgGzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZCIOybX; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711470248; x=1743006248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6FoKeU6c+r3cZG13vdZh6+5naHZHmr24ZICALbq94Hk=;
  b=FZCIOybX+7KF5b5+Bgt0+TdSOsHn9mDT0zliDEZ4+rBpt0DYL09cfAH7
   /zquKOtYvQGNhVTy4MegPaf9766mJoouGIi6Xg4/Da7kjpqfPWGO/QrkQ
   9x3mIBtBPyq6mg5Dl/IKyP0MNW6guJGV/w7cXzpw0mqYM7XnN1+r7cF+/
   htLoZgISiDwcucXQl4Zepmw+qoXi3KpxUlrwN2NWsc8ogU0+R+Kvru1v6
   6u25Kuo2lpftP87HS7F2HC2z6E20qXNp6+wWpeJcnTRHforWSQ1fCN1Xa
   DjmHvdGQgzijqatf+sV1YZ7rgFIm4RNoxcmsrgE9AWgdk/Ta/FP2G8e53
   A==;
X-CSE-ConnectionGUID: B+89waz2SyCa9E0IhIIrcA==
X-CSE-MsgGUID: BS+rdYWUToeJFW1vIU/tJA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6471933"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6471933"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:24:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="16403057"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 26 Mar 2024 09:24:04 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	anthony.l.nguyen@intel.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 3/3] i40e: fix vf may be used uninitialized in this function warning
Date: Tue, 26 Mar 2024 09:23:44 -0700
Message-ID: <20240326162358.1224145-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240326162358.1224145-1-anthony.l.nguyen@intel.com>
References: <20240326162358.1224145-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

To fix the regression introduced by commit 52424f974bc5, which causes
servers hang in very hard to reproduce conditions with resets races.
Using two sources for the information is the root cause.
In this function before the fix bumping v didn't mean bumping vf
pointer. But the code used this variables interchangeably, so stale vf
could point to different/not intended vf.

Remove redundant "v" variable and iterate via single VF pointer across
whole function instead to guarantee VF pointer validity.

Fixes: 52424f974bc5 ("i40e: Fix VF hang when reset is triggered on another VF")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 34 +++++++++----------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 83a34e98bdc7..4c13f78af675 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1624,8 +1624,8 @@ bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
 {
 	struct i40e_hw *hw = &pf->hw;
 	struct i40e_vf *vf;
-	int i, v;
 	u32 reg;
+	int i;
 
 	/* If we don't have any VFs, then there is nothing to reset */
 	if (!pf->num_alloc_vfs)
@@ -1636,11 +1636,10 @@ bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
 		return false;
 
 	/* Begin reset on all VFs at once */
-	for (v = 0; v < pf->num_alloc_vfs; v++) {
-		vf = &pf->vf[v];
+	for (vf = &pf->vf[0]; vf < &pf->vf[pf->num_alloc_vfs]; ++vf) {
 		/* If VF is being reset no need to trigger reset again */
 		if (!test_bit(I40E_VF_STATE_RESETTING, &vf->vf_states))
-			i40e_trigger_vf_reset(&pf->vf[v], flr);
+			i40e_trigger_vf_reset(vf, flr);
 	}
 
 	/* HW requires some time to make sure it can flush the FIFO for a VF
@@ -1649,14 +1648,13 @@ bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
 	 * the VFs using a simple iterator that increments once that VF has
 	 * finished resetting.
 	 */
-	for (i = 0, v = 0; i < 10 && v < pf->num_alloc_vfs; i++) {
+	for (i = 0, vf = &pf->vf[0]; i < 10 && vf < &pf->vf[pf->num_alloc_vfs]; ++i) {
 		usleep_range(10000, 20000);
 
 		/* Check each VF in sequence, beginning with the VF to fail
 		 * the previous check.
 		 */
-		while (v < pf->num_alloc_vfs) {
-			vf = &pf->vf[v];
+		while (vf < &pf->vf[pf->num_alloc_vfs]) {
 			if (!test_bit(I40E_VF_STATE_RESETTING, &vf->vf_states)) {
 				reg = rd32(hw, I40E_VPGEN_VFRSTAT(vf->vf_id));
 				if (!(reg & I40E_VPGEN_VFRSTAT_VFRD_MASK))
@@ -1666,7 +1664,7 @@ bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
 			/* If the current VF has finished resetting, move on
 			 * to the next VF in sequence.
 			 */
-			v++;
+			++vf;
 		}
 	}
 
@@ -1676,39 +1674,39 @@ bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
 	/* Display a warning if at least one VF didn't manage to reset in
 	 * time, but continue on with the operation.
 	 */
-	if (v < pf->num_alloc_vfs)
+	if (vf < &pf->vf[pf->num_alloc_vfs])
 		dev_err(&pf->pdev->dev, "VF reset check timeout on VF %d\n",
-			pf->vf[v].vf_id);
+			vf->vf_id);
 	usleep_range(10000, 20000);
 
 	/* Begin disabling all the rings associated with VFs, but do not wait
 	 * between each VF.
 	 */
-	for (v = 0; v < pf->num_alloc_vfs; v++) {
+	for (vf = &pf->vf[0]; vf < &pf->vf[pf->num_alloc_vfs]; ++vf) {
 		/* On initial reset, we don't have any queues to disable */
-		if (pf->vf[v].lan_vsi_idx == 0)
+		if (vf->lan_vsi_idx == 0)
 			continue;
 
 		/* If VF is reset in another thread just continue */
 		if (test_bit(I40E_VF_STATE_RESETTING, &vf->vf_states))
 			continue;
 
-		i40e_vsi_stop_rings_no_wait(pf->vsi[pf->vf[v].lan_vsi_idx]);
+		i40e_vsi_stop_rings_no_wait(pf->vsi[vf->lan_vsi_idx]);
 	}
 
 	/* Now that we've notified HW to disable all of the VF rings, wait
 	 * until they finish.
 	 */
-	for (v = 0; v < pf->num_alloc_vfs; v++) {
+	for (vf = &pf->vf[0]; vf < &pf->vf[pf->num_alloc_vfs]; ++vf) {
 		/* On initial reset, we don't have any queues to disable */
-		if (pf->vf[v].lan_vsi_idx == 0)
+		if (vf->lan_vsi_idx == 0)
 			continue;
 
 		/* If VF is reset in another thread just continue */
 		if (test_bit(I40E_VF_STATE_RESETTING, &vf->vf_states))
 			continue;
 
-		i40e_vsi_wait_queues_disabled(pf->vsi[pf->vf[v].lan_vsi_idx]);
+		i40e_vsi_wait_queues_disabled(pf->vsi[vf->lan_vsi_idx]);
 	}
 
 	/* Hw may need up to 50ms to finish disabling the RX queues. We
@@ -1717,12 +1715,12 @@ bool i40e_reset_all_vfs(struct i40e_pf *pf, bool flr)
 	mdelay(50);
 
 	/* Finish the reset on each VF */
-	for (v = 0; v < pf->num_alloc_vfs; v++) {
+	for (vf = &pf->vf[0]; vf < &pf->vf[pf->num_alloc_vfs]; ++vf) {
 		/* If VF is reset in another thread just continue */
 		if (test_bit(I40E_VF_STATE_RESETTING, &vf->vf_states))
 			continue;
 
-		i40e_cleanup_reset_vf(&pf->vf[v]);
+		i40e_cleanup_reset_vf(vf);
 	}
 
 	i40e_flush(hw);
-- 
2.41.0


