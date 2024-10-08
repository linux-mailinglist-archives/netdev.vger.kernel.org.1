Return-Path: <netdev+bounces-133335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3E7995B48
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FA51B20BA6
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F49E2178F1;
	Tue,  8 Oct 2024 23:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UnQf5gAa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7780215F5A
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 23:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728428473; cv=none; b=LtkTiSpZ3Ox89tnT2hFrZUPpiX9gGJu4CAiHpSd8DLRIzNmUS7LrCd2KWlnWdQ5+7uqSFNKgF6MfrKZbIOOitccOXKRr9HqD/tc6EHr2trBc4ob/+nRIiGEqntML4PsNaDTePkkQ1qCYgIze3ZwvHnU04rj23Co2qJg/0quyztY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728428473; c=relaxed/simple;
	bh=LF8uBmxrYp5MpdiB1kxsi1hPL2B9zDj76UHT6rM1LAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRVg5lYhBq7isuG/BVrdDOhML43HpZ8NqapNkI6O3L38Qn4LUbHMk4vl0Rc4a7dfFYAG66l3jAMxZiDmpGxLJ58I0mZIY0XGIUv3OmNTmRu8rUHRgEvrl+SD+ACTlQdnwJ+2ZDJ0fesVKSs9gaJV0+e3yill01X5gZBAf4iWGWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UnQf5gAa; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728428472; x=1759964472;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LF8uBmxrYp5MpdiB1kxsi1hPL2B9zDj76UHT6rM1LAc=;
  b=UnQf5gAaoLWosmWT+NyyGd1cEy+yjp7ys3m1GSH/TC6c+fKLZRRHM8+s
   iQk3FVXVm5zQuWM5OanmuRrtExGNCabaVZ291TI0v4RzhYXVHVN5Bgl2T
   IB6yMOi4Y3ms53pupJ1iMDRwuBkAg6eIt8RNcxUuVngZqHlPSJomALd1R
   Hc3Qy3grFS3jVb+3Y5ZmVFZluOaGtmdB0oN/IVud/LUEhcHU8FNMifYyl
   IWTpvL6TIedt0/EZd9TUN0oK872nUVNDO7tDIlC31mIDKqqu4NUHvv13h
   onRq1S1fdgCP2UfXmex4MGFGl3K3MoLc3viwsCfBSIplKHO420lEPmxlV
   g==;
X-CSE-ConnectionGUID: iZ96XN44Tf2h4dK9iNoOXw==
X-CSE-MsgGUID: gaV0eye1RemCQFth5c/d9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="15302409"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="15302409"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:01:10 -0700
X-CSE-ConnectionGUID: AkQCb1B/QdWBk6pUHfrv+Q==
X-CSE-MsgGUID: rYy1U8D2Thym7cTEwTM1zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="106787585"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 08 Oct 2024 16:01:04 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Wojciech Drewek <wojciech.drewek@intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	michal.swiatkowski@linux.intel.com,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net 3/7] ice: Flush FDB entries before reset
Date: Tue,  8 Oct 2024 16:00:41 -0700
Message-ID: <20241008230050.928245-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241008230050.928245-1-anthony.l.nguyen@intel.com>
References: <20241008230050.928245-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wojciech Drewek <wojciech.drewek@intel.com>

Triggering the reset while in switchdev mode causes
errors[1]. Rules are already removed by this time
because switch content is flushed in case of the reset.
This means that rules were deleted from HW but SW
still thinks they exist so when we get
SWITCHDEV_FDB_DEL_TO_DEVICE notification we try to
delete not existing rule.

We can avoid these errors by clearing the rules
early in the reset flow before they are removed from HW.
Switchdev API will get notified that the rule was removed
so we won't get SWITCHDEV_FDB_DEL_TO_DEVICE notification.
Remove unnecessary ice_clear_sw_switch_recipes.

[1]
ice 0000:01:00.0: Failed to delete FDB forward rule, err: -2
ice 0000:01:00.0: Failed to delete FDB guard rule, err: -2

Fixes: 7c945a1a8e5f ("ice: Switchdev FDB events support")
Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/ice_eswitch_br.c   |  5 +++-
 .../net/ethernet/intel/ice/ice_eswitch_br.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 24 +++----------------
 3 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
index f5aceb32bf4d..cccb7ddf61c9 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
@@ -582,10 +582,13 @@ ice_eswitch_br_switchdev_event(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
-static void ice_eswitch_br_fdb_flush(struct ice_esw_br *bridge)
+void ice_eswitch_br_fdb_flush(struct ice_esw_br *bridge)
 {
 	struct ice_esw_br_fdb_entry *entry, *tmp;
 
+	if (!bridge)
+		return;
+
 	list_for_each_entry_safe(entry, tmp, &bridge->fdb_list, list)
 		ice_eswitch_br_fdb_entry_notify_and_cleanup(bridge, entry);
 }
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
index 09d1a4eb5716..b1e7727b8677 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -521,25 +521,6 @@ static void ice_pf_dis_all_vsi(struct ice_pf *pf, bool locked)
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
@@ -576,8 +557,9 @@ ice_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
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
2.42.0


