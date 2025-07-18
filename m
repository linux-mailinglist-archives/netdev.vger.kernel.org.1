Return-Path: <netdev+bounces-208228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2339B0AA69
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 20:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E931C4881A
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 18:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6902E975B;
	Fri, 18 Jul 2025 18:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJIMdbVh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A892E88AB
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864693; cv=none; b=hL9NCpecaiVPCnesmtyBBBKt/SXMGfWNPZT0oZvaMINserKbaoB/rddMkZSb6Pgrd/etpVR2e02tXMmt4xzTiOapECcPKC9ryiV7Zcl9IN87RN62u67H5S7W+Esege7LgNsWXYt2abmrwCwsxhm6l6Tunk0Leyok8dCBiHPijUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864693; c=relaxed/simple;
	bh=cykOqrsbgsjq602xlMnmGbwDj5FfMBEAq/MYI35EVIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgJt13BtnfDvxq9YE9cva/ht271vd0kS+GG4imbp0aDLOhqiucLwLpD1fQWnnKh76RGAw9WXWQE5V6KYA6vqHeZvSoMscXdCDpGfWk6PHjk0GVsoy+fulXC68X+Errm0HNAOpIkKkdY5d5DWLTmwOTjuziqaKXmnrSmxyXSKvv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJIMdbVh; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752864691; x=1784400691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cykOqrsbgsjq602xlMnmGbwDj5FfMBEAq/MYI35EVIY=;
  b=fJIMdbVhxftxqjAundVCY1iC24KKCtdwbAkgZo73lscRN5YsWOAhIgkt
   e5aBb1sCriZ/mDz4zHU4osCfxozd2bn061EcFm+yFw5AYdjBodYD8IIRY
   K4z+9ooJ26CBtN0rf8POJKPiYN6Ymawy6L7giJHCf685sWnTKxYd5hhv2
   TW09ebCm2OVhqj/e/Dn2dYfwwRq5pQ/2ptdtY+b+KAb38N4mcwhU0xgba
   nYmPyZkVTFlS9oQty8wJVXo42vtPDXSw4SzYilpDMCVrkBV0t8LMcoBus
   i66GhDsni9iDSY2J97ani6RDuVNY9iSp4krL2HoUj80dajg3JajwUpfQa
   w==;
X-CSE-ConnectionGUID: 4rD/bKGjSsKpRAy7QPoapg==
X-CSE-MsgGUID: PW6DnA4NRKGEHL5tLvUqQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11496"; a="55320608"
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="55320608"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 11:51:25 -0700
X-CSE-ConnectionGUID: +vkGIVsFTYWVdN2y7i1Uyw==
X-CSE-MsgGUID: bilj0gluRD2TTDaXXmMUZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,322,1744095600"; 
   d="scan'208";a="157506904"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 18 Jul 2025 11:51:25 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Dave Ertman <david.m.ertman@intel.com>,
	anthony.l.nguyen@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH net-next 09/13] ice: breakout common LAG code into helpers
Date: Fri, 18 Jul 2025 11:51:10 -0700
Message-ID: <20250718185118.2042772-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250718185118.2042772-1-anthony.l.nguyen@intel.com>
References: <20250718185118.2042772-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Ertman <david.m.ertman@intel.com>

In the VF handling code, parts of the code for lag can be broken out into
helper functions to reduce code duplication. Break this code out into
helper functions

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c      | 42 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_lag.h      |  2 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 19 ++-------
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 23 ++--------
 4 files changed, 51 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index d132eb477551..c8b4fa3efbd4 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -822,6 +822,48 @@ ice_lag_cfg_cp_fltr(struct ice_lag *lag, bool add)
 	kfree(s_rule);
 }
 
+/**
+ * ice_lag_prepare_vf_reset - helper to adjust vf lag for reset
+ * @lag: lag struct for interface that owns VF
+ *
+ * Context: must be called with the lag_mutex lock held.
+ *
+ * Return: active lport value or ICE_LAG_INVALID_PORT if nothing moved.
+ */
+u8 ice_lag_prepare_vf_reset(struct ice_lag *lag)
+{
+	u8 pri_prt, act_prt;
+
+	if (lag && lag->bonded && lag->primary && lag->upper_netdev) {
+		pri_prt = lag->pf->hw.port_info->lport;
+		act_prt = lag->active_port;
+		if (act_prt != pri_prt && act_prt != ICE_LAG_INVALID_PORT) {
+			ice_lag_move_vf_nodes_cfg(lag, act_prt, pri_prt);
+			return act_prt;
+		}
+	}
+
+	return ICE_LAG_INVALID_PORT;
+}
+
+/**
+ * ice_lag_complete_vf_reset - helper for lag after reset
+ * @lag: lag struct for primary interface
+ * @act_prt: which port should be active for lag
+ *
+ * Context: must be called while holding the lag_mutex.
+ */
+void ice_lag_complete_vf_reset(struct ice_lag *lag, u8 act_prt)
+{
+	u8 pri_prt;
+
+	if (lag && lag->bonded && lag->primary &&
+	    act_prt != ICE_LAG_INVALID_PORT) {
+		pri_prt = lag->pf->hw.port_info->lport;
+		ice_lag_move_vf_nodes_cfg(lag, pri_prt, act_prt);
+	}
+}
+
 /**
  * ice_lag_info_event - handle NETDEV_BONDING_INFO event
  * @lag: LAG info struct
diff --git a/drivers/net/ethernet/intel/ice/ice_lag.h b/drivers/net/ethernet/intel/ice/ice_lag.h
index bab2c83142a1..69347d9f986b 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.h
+++ b/drivers/net/ethernet/intel/ice/ice_lag.h
@@ -70,4 +70,6 @@ void ice_deinit_lag(struct ice_pf *pf);
 void ice_lag_rebuild(struct ice_pf *pf);
 bool ice_lag_is_switchdev_running(struct ice_pf *pf);
 void ice_lag_move_vf_nodes_cfg(struct ice_lag *lag, u8 src_prt, u8 dst_prt);
+u8 ice_lag_prepare_vf_reset(struct ice_lag *lag);
+void ice_lag_complete_vf_reset(struct ice_lag *lag, u8 act_prt);
 #endif /* _ICE_LAG_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index c639ce716d32..5ee74f3e82dc 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -859,16 +859,13 @@ static void ice_notify_vf_reset(struct ice_vf *vf)
 int ice_reset_vf(struct ice_vf *vf, u32 flags)
 {
 	struct ice_pf *pf = vf->pf;
-	struct ice_lag *lag;
 	struct ice_vsi *vsi;
-	u8 act_prt, pri_prt;
 	struct device *dev;
 	int err = 0;
+	u8 act_prt;
 	bool rsd;
 
 	dev = ice_pf_to_dev(pf);
-	act_prt = ICE_LAG_INVALID_PORT;
-	pri_prt = pf->hw.port_info->lport;
 
 	if (flags & ICE_VF_RESET_NOTIFY)
 		ice_notify_vf_reset(vf);
@@ -884,16 +881,8 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
 	else
 		lockdep_assert_held(&vf->cfg_lock);
 
-	lag = pf->lag;
 	mutex_lock(&pf->lag_mutex);
-	if (lag && lag->bonded && lag->primary) {
-		act_prt = lag->active_port;
-		if (act_prt != pri_prt && act_prt != ICE_LAG_INVALID_PORT &&
-		    lag->upper_netdev)
-			ice_lag_move_vf_nodes_cfg(lag, act_prt, pri_prt);
-		else
-			act_prt = ICE_LAG_INVALID_PORT;
-	}
+	act_prt = ice_lag_prepare_vf_reset(pf->lag);
 
 	if (ice_is_vf_disabled(vf)) {
 		vsi = ice_get_vf_vsi(vf);
@@ -979,9 +968,7 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
 	ice_reset_vf_mbx_cnt(vf);
 
 out_unlock:
-	if (lag && lag->bonded && lag->primary &&
-	    act_prt != ICE_LAG_INVALID_PORT)
-		ice_lag_move_vf_nodes_cfg(lag, pri_prt, act_prt);
+	ice_lag_complete_vf_reset(pf->lag, act_prt);
 	mutex_unlock(&pf->lag_mutex);
 
 	if (flags & ICE_VF_RESET_LOCK)
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 9460b6561b69..05511157c571 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -1996,24 +1996,13 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 	    (struct virtchnl_vsi_queue_config_info *)msg;
 	struct virtchnl_queue_pair_info *qpi;
 	struct ice_pf *pf = vf->pf;
-	struct ice_lag *lag;
 	struct ice_vsi *vsi;
-	u8 act_prt, pri_prt;
 	int i = -1, q_idx;
 	bool ena_ts;
+	u8 act_prt;
 
-	lag = pf->lag;
 	mutex_lock(&pf->lag_mutex);
-	act_prt = ICE_LAG_INVALID_PORT;
-	pri_prt = pf->hw.port_info->lport;
-	if (lag && lag->bonded && lag->primary) {
-		act_prt = lag->active_port;
-		if (act_prt != pri_prt && act_prt != ICE_LAG_INVALID_PORT &&
-		    lag->upper_netdev)
-			ice_lag_move_vf_nodes_cfg(lag, act_prt, pri_prt);
-		else
-			act_prt = ICE_LAG_INVALID_PORT;
-	}
+	act_prt = ice_lag_prepare_vf_reset(pf->lag);
 
 	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states))
 		goto error_param;
@@ -2141,9 +2130,7 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 		}
 	}
 
-	if (lag && lag->bonded && lag->primary &&
-	    act_prt != ICE_LAG_INVALID_PORT)
-		ice_lag_move_vf_nodes_cfg(lag, pri_prt, act_prt);
+	ice_lag_complete_vf_reset(pf->lag, act_prt);
 	mutex_unlock(&pf->lag_mutex);
 
 	/* send the response to the VF */
@@ -2160,9 +2147,7 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 				vf->vf_id, i);
 	}
 
-	if (lag && lag->bonded && lag->primary &&
-	    act_prt != ICE_LAG_INVALID_PORT)
-		ice_lag_move_vf_nodes_cfg(lag, pri_prt, act_prt);
+	ice_lag_complete_vf_reset(pf->lag, act_prt);
 	mutex_unlock(&pf->lag_mutex);
 
 	ice_lag_move_new_vf_nodes(vf);
-- 
2.47.1


