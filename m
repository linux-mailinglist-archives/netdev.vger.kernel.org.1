Return-Path: <netdev+bounces-115776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3852947C27
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 15:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94A0A285AE4
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 13:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA36381DF;
	Mon,  5 Aug 2024 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="czY74J83"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E9C175A5
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722865583; cv=none; b=qKbWzz0HXS6E/8DSHzwsPWnNl4huhMDerHkd+D2Q0LtpHbVqrMQLkptKsDKdYMlHnWXigRH9keWLcqKQf4hnFO/boche23JE1+ZkQdijOpk6H+ko0Bk6xX1XWWRTGlEPUSPP1xyok8heOFkmn2wKv1YfwMVqFS2PZy6SiS7Mb/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722865583; c=relaxed/simple;
	bh=+t4Pq1jNolGbzWRb4tnaIRG2SI14L4cljaguo+v9RcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b8r4Xv8xFwQify47PxerK+Se8ftKdYUl0l4bKUH4yaMbmwoAzwOTCncY7cfDu3RMKP+N7o3jRvSMegWQm3qeOeIbMAk8FBISD+LznuS0vbTwN+CLOmSJFvLNaFsZx3HlkRKGgSsPpBOmrY0hOC0J8Ck+FuHYtBmrhlpGQiQxv/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=czY74J83; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722865581; x=1754401581;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+t4Pq1jNolGbzWRb4tnaIRG2SI14L4cljaguo+v9RcQ=;
  b=czY74J83YRKmOlb09KJW7ssLDeMD73lQ9enu1yH4F8jMk5p7b5VgMi1w
   2NMpV36bWL9h5d7wnlbuNLwFLYflX/DjVljNKdLyskmsIeM+nN7rUV71T
   /XdQE2Nb7wG9T9f1/iFzWOmWY50tP0CZXk4DNPKXwhCtSuP2eNStHq++i
   hFCLVeKrQjL4Wx0UWZ68hWglQIo/3pyTByXzCPzSf6NLiWoxfAmoMvKig
   o79WMbtMfWycGX26Pgs1B5c+bHSUqaV9fkbql6gLo3SBD+e0xh0KWU0Na
   aRBy1/m+AxDxvpb0M6CCiWNrh4cmTbwlU6YdFR/8i73EXRjrfngxDtKOr
   A==;
X-CSE-ConnectionGUID: DttKBLmQQrCi024paLnVTg==
X-CSE-MsgGUID: I3MXL7hTTPqYSbf7iHqNsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="43352099"
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="43352099"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 06:46:20 -0700
X-CSE-ConnectionGUID: 79w0iuq4Sdy4BnGpJNLmbQ==
X-CSE-MsgGUID: p/bj29U6S3eOwzsFrXW/dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,264,1716274800"; 
   d="scan'208";a="55841179"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa007.fm.intel.com with ESMTP; 05 Aug 2024 06:46:19 -0700
Received: from rozewie.igk.intel.com (rozewie.igk.intel.com [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id DC14D27BD9;
	Mon,  5 Aug 2024 14:46:17 +0100 (IST)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Subject: [PATCH iwl-net] ice: Flush FDB entries before reset
Date: Mon,  5 Aug 2024 15:43:50 +0200
Message-Id: <20240805134350.132357-1-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Triggering the reset while in switchdev mode causes
errors[1]. Rules are already removed by this time
because switch content is flushed in case of the reset.
We can avoid these errors by clearing the rules
early in the reset flow. Remove unnecessary
ice_clear_sw_switch_recipes.

[1]
ice 0000:01:00.0: Failed to delete FDB forward rule, err: -2
ice 0000:01:00.0: Failed to delete FDB guard rule, err: -2

Fixes: 7c945a1a8e5f ("ice: Switchdev FDB events support")
Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
 .../net/ethernet/intel/ice/ice_eswitch_br.c   |  2 +-
 .../net/ethernet/intel/ice/ice_eswitch_br.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 24 +++----------------
 3 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
index f5aceb32bf4d..814df3419d63 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
@@ -582,7 +582,7 @@ ice_eswitch_br_switchdev_event(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
-static void ice_eswitch_br_fdb_flush(struct ice_esw_br *bridge)
+void ice_eswitch_br_fdb_flush(struct ice_esw_br *bridge)
 {
 	struct ice_esw_br_fdb_entry *entry, *tmp;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
index c15c7344d7f8..66a2c804338f 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
@@ -117,5 +117,6 @@ void
 ice_eswitch_br_offloads_deinit(struct ice_pf *pf);
 int
 ice_eswitch_br_offloads_init(struct ice_pf *pf);
+void ice_eswitch_br_fdb_flush(struct ice_esw_br *bridge);
 
 #endif /* _ICE_ESWITCH_BR_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 8f02b33adad1..fd27c7995d60 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -520,25 +520,6 @@ static void ice_pf_dis_all_vsi(struct ice_pf *pf, bool locked)
 		pf->vf_agg_node[node].num_vsis = 0;
 }
 
-/**
- * ice_clear_sw_switch_recipes - clear switch recipes
- * @pf: board private structure
- *
- * Mark switch recipes as not created in sw structures. There are cases where
- * rules (especially advanced rules) need to be restored, either re-read from
- * hardware or added again. For example after the reset. 'recp_created' flag
- * prevents from doing that and need to be cleared upfront.
- */
-static void ice_clear_sw_switch_recipes(struct ice_pf *pf)
-{
-	struct ice_sw_recipe *recp;
-	u8 i;
-
-	recp = pf->hw.switch_info->recp_list;
-	for (i = 0; i < ICE_MAX_NUM_RECIPES; i++)
-		recp[i].recp_created = false;
-}
-
 /**
  * ice_prepare_for_reset - prep for reset
  * @pf: board private structure
@@ -575,8 +556,9 @@ ice_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	mutex_unlock(&pf->vfs.table_lock);
 
 	if (ice_is_eswitch_mode_switchdev(pf)) {
-		if (reset_type != ICE_RESET_PFR)
-			ice_clear_sw_switch_recipes(pf);
+		rtnl_lock();
+		ice_eswitch_br_fdb_flush(pf->eswitch.br_offloads->bridge);
+		rtnl_unlock();
 	}
 
 	/* release ADQ specific HW and SW resources */
-- 
2.40.1


