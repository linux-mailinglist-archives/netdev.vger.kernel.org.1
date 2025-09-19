Return-Path: <netdev+bounces-224825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF99B8AD4D
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 19:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3176F5C045A
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 17:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD79322C6D;
	Fri, 19 Sep 2025 17:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RegQdsaW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033BE3218B2
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 17:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304463; cv=none; b=OWlWI5y/c+gzH5JJRmYWuGlwngoVq4EK+cPlHbVpytHXqJeMwplfdRehihYNaKcK1E/zl+/DbAenHqxO+FkW4/mlZ5Jjd7VJGyGeWUgvZn60c4gJ6JVstYl3jp4kA01wz5Rv//YUMB377+n2NCqVmH3oLjREX2b7Wuu+i9/yvdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304463; c=relaxed/simple;
	bh=NfTBl4l4E4PNgvSv0/DjQBuAeJMtAP4UlgMU0ieW1Wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=snbrkaEq3wGIbh+Eh9Yhi2lEgzq03oBt9c3CEpCg1DVEaBFgouqKLWOk4JMZCWzUWqbeGusqchicahSupTgELtSao2Ste3As47URJmYIiKdK4C+TsTD/ETKnNiZNzMqwtYqtJBUQadJQHjrIculE7m4SBpBvyeqh2YLGcxijwh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RegQdsaW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758304462; x=1789840462;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NfTBl4l4E4PNgvSv0/DjQBuAeJMtAP4UlgMU0ieW1Wk=;
  b=RegQdsaWhWfCba625MB7esxk0kElLfqr1BmXqIl9Jom9O53oHGM80oWU
   v93bzkgb1UL1yFWdli6TGQcYZioY5sKLchHWDy7NvvbBvztr9wjx3QsyS
   xLvtnIkNWTIXxfnXII9WRVIhlFfDHDe8Ha/V9ff3o/7ODjm1DQdaYpst0
   5ErL74DGL1dTuiMTYr22bflq8pE4bEYJcJAZvUR18zXjr/N+3grzwNUkC
   tBMbxeOKwxPtSmmUo0BBln+3c7BuSdFNGXzegulbp/+8s+v8y4EhD0n89
   gobywYo+onrCOvI7mgpXg4YKRvmAnpJISkbE48FsVzlb6nFs+Pia3o4Iw
   w==;
X-CSE-ConnectionGUID: I2qPlxXDSxiRVInURHeQTg==
X-CSE-MsgGUID: 8DeVtLE0QNqMhIkOH1Ifhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="78097080"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="78097080"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 10:54:21 -0700
X-CSE-ConnectionGUID: RGOImW7WSCGX9AQVAzBCWA==
X-CSE-MsgGUID: ICATBIdETayWryg5kIQncw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="176709484"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 19 Sep 2025 10:54:20 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Dave Ertman <david.m.ertman@intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Priya Singh <priyax.singh@intel.com>
Subject: [PATCH net-next 3/7] ice: Remove deprecated ice_lag_move_new_vf_nodes() call
Date: Fri, 19 Sep 2025 10:54:06 -0700
Message-ID: <20250919175412.653707-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250919175412.653707-1-anthony.l.nguyen@intel.com>
References: <20250919175412.653707-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Ertman <david.m.ertman@intel.com>

Moving the code to handle the LAG part of a VF reset to helper
functions deprecated the function ice_lag_move_new_vf_nodes().
The cleanup missed a call to this function in the error path of
ice_vc_cfg_qs_msg().

In the case that would end in the error path, a NULL pointer would
be encountered due to the empty list of netdevs for members of the
aggregate.

Remove the unnecessary call to ice_lag_move_new_vf_nodes(), and since
this is the only call to this function, remove the function as well.

Fixes: 351d8d8ab6af ("ice: breakout common LAG code into helpers")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Tested-by: Priya Singh <priyax.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
Targeted for net-next as the code is not yet present in net

 drivers/net/ethernet/intel/ice/ice_lag.c     | 55 --------------------
 drivers/net/ethernet/intel/ice/ice_lag.h     |  1 -
 drivers/net/ethernet/intel/ice/virt/queues.c |  2 -
 3 files changed, 58 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 80312e1dcf7f..aebf8e08a297 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -789,61 +789,6 @@ ice_lag_move_single_vf_nodes(struct ice_lag *lag, u8 oldport, u8 newport,
 		ice_lag_move_vf_node_tc(lag, oldport, newport, vsi_num, tc);
 }
 
-/**
- * ice_lag_move_new_vf_nodes - Move Tx scheduling nodes for a VF if required
- * @vf: the VF to move Tx nodes for
- *
- * Called just after configuring new VF queues. Check whether the VF Tx
- * scheduling nodes need to be updated to fail over to the active port. If so,
- * move them now.
- */
-void ice_lag_move_new_vf_nodes(struct ice_vf *vf)
-{
-	struct ice_lag_netdev_list ndlist;
-	u8 pri_port, act_port;
-	struct ice_lag *lag;
-	struct ice_vsi *vsi;
-	struct ice_pf *pf;
-
-	vsi = ice_get_vf_vsi(vf);
-
-	if (WARN_ON(!vsi))
-		return;
-
-	if (WARN_ON(vsi->type != ICE_VSI_VF))
-		return;
-
-	pf = vf->pf;
-	lag = pf->lag;
-
-	mutex_lock(&pf->lag_mutex);
-	if (!lag->bonded)
-		goto new_vf_unlock;
-
-	pri_port = pf->hw.port_info->lport;
-	act_port = lag->active_port;
-
-	if (lag->upper_netdev)
-		ice_lag_build_netdev_list(lag, &ndlist);
-
-	if (lag->bonded && lag->primary && !list_empty(lag->netdev_head)) {
-		if (lag->bond_aa &&
-		    ice_is_feature_supported(pf, ICE_F_SRIOV_AA_LAG))
-			ice_lag_aa_failover(lag, ICE_LAGS_IDX, NULL);
-
-		if (!lag->bond_aa &&
-		    ice_is_feature_supported(pf, ICE_F_SRIOV_LAG) &&
-		    pri_port != act_port)
-			ice_lag_move_single_vf_nodes(lag, pri_port, act_port,
-						     vsi->idx);
-	}
-
-	ice_lag_destroy_netdev_list(lag, &ndlist);
-
-new_vf_unlock:
-	mutex_unlock(&pf->lag_mutex);
-}
-
 /**
  * ice_lag_move_vf_nodes - move Tx scheduling nodes for all VFs to new port
  * @lag: lag info struct
diff --git a/drivers/net/ethernet/intel/ice/ice_lag.h b/drivers/net/ethernet/intel/ice/ice_lag.h
index e2a0a782bdd7..f77ebcd61042 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.h
+++ b/drivers/net/ethernet/intel/ice/ice_lag.h
@@ -82,7 +82,6 @@ struct ice_lag_work {
 	} info;
 };
 
-void ice_lag_move_new_vf_nodes(struct ice_vf *vf);
 void ice_lag_aa_failover(struct ice_lag *lag, u8 dest, struct ice_pf *e_pf);
 int ice_init_lag(struct ice_pf *pf);
 void ice_deinit_lag(struct ice_pf *pf);
diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
index aa2c5bf0d2a2..370f6ec2a374 100644
--- a/drivers/net/ethernet/intel/ice/virt/queues.c
+++ b/drivers/net/ethernet/intel/ice/virt/queues.c
@@ -906,8 +906,6 @@ int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 	ice_lag_complete_vf_reset(pf->lag, act_prt);
 	mutex_unlock(&pf->lag_mutex);
 
-	ice_lag_move_new_vf_nodes(vf);
-
 	/* send the response to the VF */
 	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_CONFIG_VSI_QUEUES,
 				     VIRTCHNL_STATUS_ERR_PARAM, NULL, 0);
-- 
2.47.1


