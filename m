Return-Path: <netdev+bounces-105764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A9A912AF4
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 18:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B208D1F27EFE
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 16:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EFC167DB5;
	Fri, 21 Jun 2024 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L0EIVZ4/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7891662F6
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718986112; cv=none; b=CW+xHcsR0KBaidYUEBJ0BLCzqHvG+LxKvKQ9E9wmau6+kMrgYCCnRLPtDMo4lPXTnzefcmHEwmtGj1oBq3spQQWEuEBdbjbuCy7HBjVFXKrcAEMEMheHYct9GXGOVgP3njfJSj3l5vhucYT77bp9oC15DNzHM1rPDe2FZB0XkHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718986112; c=relaxed/simple;
	bh=RLJ98cauh4ihSAhpM4t8QV5f65++vWXTHtxYQQp8ybk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUGqyt63HnaEmkqKlSsudKUSlrxL5BZZzpl4FJaBykrr2DTbw69xxOO2ikqoivituCg+/Ek/mwIt2+qcObLTIyWD4E38oHO3u6f5yPyfz/4CC4t+gutZY2IiY8sEVJtBoHkFvQp1Sl+uP/TS4kvxo47dn5CXmo/Q5zyuiCjlMkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L0EIVZ4/; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718986110; x=1750522110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RLJ98cauh4ihSAhpM4t8QV5f65++vWXTHtxYQQp8ybk=;
  b=L0EIVZ4/RgHIxC7jovsaBWD9/Enagl5FuBiXA5lq/AhlKp+pL3Twi3pB
   UiQlLJD+YSQgrlOiWNPhYZZryHNQKBEjiXwAJlF7eDGxpkZlBd85EfR8L
   GwC3v8jg+l3rfPU3nbFduApkuUh69VXkkJixzCi5+QOaA0Vpee4xQqFXW
   G5fyy07p23fEYd20jlzc28jhomq4aeyFW1eEvUbg5vOiA6LaaxmTZp9rx
   vLtctf7wYFrjrpYwBaylML4yxdFBS3hiLioYUD1C1+0hMUrLeuF1W1qfF
   MmWgplr/Zd6RmaZJI4lzPxcQKRdZNOyvcnSDlm5e5IvGpzWkH29tNgc/j
   g==;
X-CSE-ConnectionGUID: sf7+OK3YRi2dhVGDq8qIvw==
X-CSE-MsgGUID: dY0OeFTXSDuABlo4+zl9jA==
X-IronPort-AV: E=McAfee;i="6700,10204,11110"; a="19801421"
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="19801421"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 09:08:28 -0700
X-CSE-ConnectionGUID: Sq7FKzW0QiirbNMU2YkOeA==
X-CSE-MsgGUID: Cut0MjErQ7ehkwNz6vcYpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,255,1712646000"; 
   d="scan'208";a="47149813"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 21 Jun 2024 09:08:27 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Simon Horman <horms@kernel.org>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 4/4] ice: update representor when VSI is ready
Date: Fri, 21 Jun 2024 09:08:17 -0700
Message-ID: <20240621160820.3394806-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240621160820.3394806-1-anthony.l.nguyen@intel.com>
References: <20240621160820.3394806-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

In case of reset of VF VSI can be reallocated. To handle this case it
should be properly updated.

Reload representor as vsi->vsi_num can be different than the one stored
when representor was created.

Instead of only changing antispoof do whole VSI configuration for
eswitch.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 21 +++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_eswitch.h |  4 ++--
 drivers/net/ethernet/intel/ice/ice_vf_lib.c  |  2 +-
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index 3f73f46111fc..4f539b1c7781 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -178,16 +178,16 @@ void ice_eswitch_decfg_vsi(struct ice_vsi *vsi, const u8 *mac)
  * @repr_id: representor ID
  * @vsi: VSI for which port representor is configured
  */
-void ice_eswitch_update_repr(unsigned long repr_id, struct ice_vsi *vsi)
+void ice_eswitch_update_repr(unsigned long *repr_id, struct ice_vsi *vsi)
 {
 	struct ice_pf *pf = vsi->back;
 	struct ice_repr *repr;
-	int ret;
+	int err;
 
 	if (!ice_is_switchdev_running(pf))
 		return;
 
-	repr = xa_load(&pf->eswitch.reprs, repr_id);
+	repr = xa_load(&pf->eswitch.reprs, *repr_id);
 	if (!repr)
 		return;
 
@@ -197,12 +197,19 @@ void ice_eswitch_update_repr(unsigned long repr_id, struct ice_vsi *vsi)
 	if (repr->br_port)
 		repr->br_port->vsi = vsi;
 
-	ret = ice_vsi_update_security(vsi, ice_vsi_ctx_clear_antispoof);
-	if (ret) {
-		ice_fltr_add_mac_and_broadcast(vsi, repr->parent_mac,
-					       ICE_FWD_TO_VSI);
+	err = ice_eswitch_cfg_vsi(vsi, repr->parent_mac);
+	if (err)
 		dev_err(ice_pf_to_dev(pf), "Failed to update VSI of port representor %d",
 			repr->id);
+
+	/* The VSI number is different, reload the PR with new id */
+	if (repr->id != vsi->vsi_num) {
+		xa_erase(&pf->eswitch.reprs, repr->id);
+		repr->id = vsi->vsi_num;
+		if (xa_insert(&pf->eswitch.reprs, repr->id, repr, GFP_KERNEL))
+			dev_err(ice_pf_to_dev(pf), "Failed to reload port representor %d",
+				repr->id);
+		*repr_id = repr->id;
 	}
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.h b/drivers/net/ethernet/intel/ice/ice_eswitch.h
index 9a25606e9740..09194d514f9b 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.h
@@ -18,7 +18,7 @@ ice_eswitch_mode_set(struct devlink *devlink, u16 mode,
 		     struct netlink_ext_ack *extack);
 bool ice_is_eswitch_mode_switchdev(struct ice_pf *pf);
 
-void ice_eswitch_update_repr(unsigned long repr_id, struct ice_vsi *vsi);
+void ice_eswitch_update_repr(unsigned long *repr_id, struct ice_vsi *vsi);
 
 void ice_eswitch_stop_all_tx_queues(struct ice_pf *pf);
 
@@ -47,7 +47,7 @@ ice_eswitch_set_target_vsi(struct sk_buff *skb,
 			   struct ice_tx_offload_params *off) { }
 
 static inline void
-ice_eswitch_update_repr(unsigned long repr_id, struct ice_vsi *vsi) { }
+ice_eswitch_update_repr(unsigned long *repr_id, struct ice_vsi *vsi) { }
 
 static inline int ice_eswitch_configure(struct ice_pf *pf)
 {
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 48a8d462d76a..5635e9da2212 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -948,7 +948,7 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
 		goto out_unlock;
 	}
 
-	ice_eswitch_update_repr(vf->repr_id, vsi);
+	ice_eswitch_update_repr(&vf->repr_id, vsi);
 
 	/* if the VF has been reset allow it to come up again */
 	ice_mbx_clear_malvf(&vf->mbx_info);
-- 
2.41.0


