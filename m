Return-Path: <netdev+bounces-213866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F312DB272C6
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 01:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 734F47B035D
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 23:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60AA288513;
	Thu, 14 Aug 2025 23:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D1XWpq6l"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6622877EF
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 23:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212949; cv=none; b=kx7X6M4zzL12uS7yXHj8SnkuYOtWOurwvQkavHXhFNnts5kdODipFVmW5VfQ/tYOTRZ5Tx3dhYr21JwzPFHJJJbCjCa2p9ofYdjcHu2mjrfqGHgvzgRMC07j5xjOrqnR1/Bm0jPgvRr4wgN32AWctvmaHZWmNs/wH2tuZtP7VK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212949; c=relaxed/simple;
	bh=+yLoGT1nsPsmfL+sXTZRTS94jgn19XOsp5oEv+Vdn0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9aQ1tr6kg3LAI+y5PkA/6TQ9fWGjwFQupFlKMJAewx6rHePAAkkss4m3+GwK72xp1Ux4ukYQcq+bEMM6Ue0DkQs/wQdqVydXhshs+uAZ+ZY6Cspmvsbpecq9XqkYxYq/zDwdgfSl+UpCLWvzyEHhNVLW8b1NqoylAMw5lOzgds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D1XWpq6l; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755212948; x=1786748948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+yLoGT1nsPsmfL+sXTZRTS94jgn19XOsp5oEv+Vdn0E=;
  b=D1XWpq6llp235/QWhu1Yw8EAEV50TcrT58mgB6Lvzx1SnT41MLf07x7C
   F87PmbRx+2QV5CYyEa/BhZ1nXMgk2TxcV3HuPaQ764H8iITB7aV9Y2UDi
   bfu5z50JP4Fkw0514lUfTtuUdrp6RNFM5lyU7gm5LhnxnJ1aTZcsolcC5
   Jqsw8vE5n8Z2lkiw1R5wC0OahC+aeRoTXOCSKYhIA2cyWLC3TQCJlHJO3
   Npn1p1jezl01qFLr4mwSG0PhsCMBJWa89wKwelXiWS22GBPBugIDqMjM5
   PELzkkNX4BrH8tQ5wFqRgsZlWmQr+dZx82UEvZG3N8zNog3OxK0MRnPe5
   A==;
X-CSE-ConnectionGUID: /0sReaiUQlCtuJGgi8OVmQ==
X-CSE-MsgGUID: I0t97w60QQ6WhbuiGjqDBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="45117973"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="45117973"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 16:09:04 -0700
X-CSE-ConnectionGUID: cGd8mLuiRkG3+QpSJkAO5w==
X-CSE-MsgGUID: /wyeqQ6HQl+RqcXADZM/Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="166848132"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 14 Aug 2025 16:09:04 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Dave Ertman <david.m.ertman@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 3/7] ice: Add driver specific prefix to LAG defines
Date: Thu, 14 Aug 2025 16:08:50 -0700
Message-ID: <20250814230855.128068-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250814230855.128068-1-anthony.l.nguyen@intel.com>
References: <20250814230855.128068-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Ertman <david.m.ertman@intel.com>

A define in the LAG code is missing a driver specific prefix.
Add a prefix to the define.

Also shorten a defines name and move to a more logical place.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lag.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
index 96b11d8f1422..48efd8d27296 100644
--- a/drivers/net/ethernet/intel/ice/ice_lag.c
+++ b/drivers/net/ethernet/intel/ice/ice_lag.c
@@ -10,12 +10,14 @@
 #define ICE_LAG_RES_SHARED	BIT(14)
 #define ICE_LAG_RES_VALID	BIT(15)
 
-#define LACP_TRAIN_PKT_LEN		16
-static const u8 lacp_train_pkt[LACP_TRAIN_PKT_LEN] = { 0, 0, 0, 0, 0, 0,
-						       0, 0, 0, 0, 0, 0,
-						       0x88, 0x09, 0, 0 };
+#define ICE_TRAIN_PKT_LEN		16
+static const u8 lacp_train_pkt[ICE_TRAIN_PKT_LEN] = { 0, 0, 0, 0, 0, 0,
+						      0, 0, 0, 0, 0, 0,
+						      0x88, 0x09, 0, 0 };
 
 #define ICE_RECIPE_LEN			64
+#define ICE_LAG_SRIOV_CP_RECIPE		10
+
 static const u8 ice_dflt_vsi_rcp[ICE_RECIPE_LEN] = {
 	0x05, 0, 0, 0, 0x20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 	0x85, 0, 0x01, 0, 0, 0, 0xff, 0xff, 0x08, 0, 0, 0, 0, 0, 0, 0,
@@ -766,9 +768,6 @@ void ice_lag_move_vf_nodes_cfg(struct ice_lag *lag, u8 src_prt, u8 dst_prt)
 	ice_lag_destroy_netdev_list(lag, &ndlist);
 }
 
-#define ICE_LAG_SRIOV_CP_RECIPE		10
-#define ICE_LAG_SRIOV_TRAIN_PKT_LEN	16
-
 /**
  * ice_lag_cfg_cp_fltr - configure filter for control packets
  * @lag: local interface's lag struct
@@ -783,8 +782,7 @@ ice_lag_cfg_cp_fltr(struct ice_lag *lag, bool add)
 
 	vsi = lag->pf->vsi[0];
 
-	buf_len = ICE_SW_RULE_RX_TX_HDR_SIZE(s_rule,
-					     ICE_LAG_SRIOV_TRAIN_PKT_LEN);
+	buf_len = ICE_SW_RULE_RX_TX_HDR_SIZE(s_rule, ICE_TRAIN_PKT_LEN);
 	s_rule = kzalloc(buf_len, GFP_KERNEL);
 	if (!s_rule) {
 		netdev_warn(lag->netdev, "-ENOMEM error configuring CP filter\n");
@@ -799,8 +797,8 @@ ice_lag_cfg_cp_fltr(struct ice_lag *lag, bool add)
 					  ICE_SINGLE_ACT_LAN_ENABLE |
 					  ICE_SINGLE_ACT_VALID_BIT |
 					  FIELD_PREP(ICE_SINGLE_ACT_VSI_ID_M, vsi->vsi_num));
-		s_rule->hdr_len = cpu_to_le16(ICE_LAG_SRIOV_TRAIN_PKT_LEN);
-		memcpy(s_rule->hdr_data, lacp_train_pkt, LACP_TRAIN_PKT_LEN);
+		s_rule->hdr_len = cpu_to_le16(ICE_TRAIN_PKT_LEN);
+		memcpy(s_rule->hdr_data, lacp_train_pkt, ICE_TRAIN_PKT_LEN);
 		opc = ice_aqc_opc_add_sw_rules;
 	} else {
 		opc = ice_aqc_opc_remove_sw_rules;
-- 
2.47.1


