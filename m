Return-Path: <netdev+bounces-142117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EBC9BD87C
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 23:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24DF82843AE
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 22:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6BA216DF8;
	Tue,  5 Nov 2024 22:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MADADX2l"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A38216A31
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730845447; cv=none; b=EMhBqwu/nShoO6LoKb21kbWDOEoiJoHMMi0vKUnU5yWpB7H46qB/rg01xCdsTNN1P5ktcSf+Zk7ya/rBoPF1Igdgg8z7Sth5SyiUTLOC7c1nWEeH4LH1G/+i3YEon92Aw/C9MwKGMYaJo38VonhMRhXhaBp/N5K09GnD0ddHAas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730845447; c=relaxed/simple;
	bh=lBj1cJu2ZEkFnLs2ep/9MrSyHrHCfVLTIlE0NVdEsYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3zeZ19yF7hGY9b8OVfd9Z1xjOWznkOUQlzfp6amxPbLGlojJE90014+kvWygWEEc4zCJn8WzdAIxG3+9T7clDFwYkbFqDCyanXnnaXh4BGFJWAw3oql4IMjfQXlGaixXdEfJElHqVxySzX1z9WovHByMQv6K+0pTsdaW22wdw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MADADX2l; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730845446; x=1762381446;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lBj1cJu2ZEkFnLs2ep/9MrSyHrHCfVLTIlE0NVdEsYM=;
  b=MADADX2l32PHfy7I3d3QZBjpNayMYrAWireVc0KXn5T8UWSZ97Tm9G/V
   bGl1OyftDrgiAOYU2Cb27yEqG61bxmcEhUbxRRPhqyWcC9+kVPH/1k0U4
   TZNzGLHvl0o0uXQEFkeyksUjE8lqqfmdxqB7fzoJ5i1/ZVb9dd7vXlANR
   WF7qEDDEvbC09OCXiilSma+QfdA92Ikaq2mmNTBpaFAsqCN8HG3Ja83p/
   mLRDVzw8zRNNTaeWcf+uLfUDdldSlvOGxop+XNUbryvzx0qEv5mufUidQ
   4h5f3uuIR3Pql74IfA6AMm5c/kCyw6t4Cwu/odUk/54tJUUgK6R7eXuXh
   w==;
X-CSE-ConnectionGUID: oABL8PK9QISLRjhJuiQoUA==
X-CSE-MsgGUID: +fd4kz2aRL2FAV17jFEGKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34314298"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34314298"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 14:24:01 -0800
X-CSE-ConnectionGUID: qrzW0Rl8SoudeIodxfK0eQ==
X-CSE-MsgGUID: 1t9o1JcARZ6Xb878KK4f1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="84322457"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 05 Nov 2024 14:24:00 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next 08/15] ice: initialize pf->supported_rxdids immediately after loading DDP
Date: Tue,  5 Nov 2024 14:23:42 -0800
Message-ID: <20241105222351.3320587-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241105222351.3320587-1-anthony.l.nguyen@intel.com>
References: <20241105222351.3320587-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The pf->supported_rxdids field is used to populate the list of valid RXDIDs
that a VF may use when negotiating VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC.

The set of supported RXDIDs is dependent on the DDP, and can be read from
the GLXFLXP_RXDID_FLAGS register. The PF needs to send this list to the
VF upon receiving the VIRTCHNL_OP_GET_SUPPORTED_RXDIDs. It also needs to
use this list to validate the requested descriptor ID from the VF when
programming the Rx queues.

A future update to support VF live migration will also want to validate
that the target VF can support the same descriptor ID when migrating.

Currently, pf->supported_rxdids is initialized inside the
ice_vc_query_rxdid() function. This means that it is only ever initialized
if at least one VF actually tries to negotiate
VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC. It is also unnecessarily re-initialized
every time the VF loads and requests the descriptor list. This worked
before because the PF only checks pf->suppported_rxdids when programming
the Rx queue if the VF actually negotiates the
VIRTCHNL_VF_OFFLOAD_RX_FLEX_DESC feature.

This will be problematic for VF live migration. We need the list of
supported Rx descriptor IDs when migrating. It is possible that no VF on
the target PF has ever actually issued a VIRTCHNL_OP_GET_SUPPORTED_RXDIDs.

Refactor the driver to initialize pf->supported_rxdids during driver
initialization after the DDP is loaded. This is simpler, avoids unnecessary
duplicate work, and avoids issues with the live migration process.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c     | 31 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 20 ++----------
 2 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c96feb292f84..db463793d870 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4560,6 +4560,34 @@ ice_init_tx_topology(struct ice_hw *hw, const struct firmware *firmware)
 	return 0;
 }
 
+/**
+ * ice_init_supported_rxdids - Initialize supported Rx descriptor IDs
+ * @hw: pointer to the hardware structure
+ * @pf: pointer to pf structure
+ *
+ * The pf->supported_rxdids bitmap is used to indicate to VFs which descriptor
+ * formats the PF hardware supports. The exact list of supported RXDIDs
+ * depends on the loaded DDP package. The IDs can be determined by reading the
+ * GLFLXP_RXDID_FLAGS register after the DDP package is loaded.
+ *
+ * Note that the legacy 32-byte RXDID 0 is always supported but is not listed
+ * in the DDP package. The 16-byte legacy descriptor is never supported by
+ * VFs.
+ */
+static void ice_init_supported_rxdids(struct ice_hw *hw, struct ice_pf *pf)
+{
+	pf->supported_rxdids = BIT(ICE_RXDID_LEGACY_1);
+
+	for (int i = ICE_RXDID_FLEX_NIC; i < ICE_FLEX_DESC_RXDID_MAX_NUM; i++) {
+		u32 regval;
+
+		regval = rd32(hw, GLFLXP_RXDID_FLAGS(i, 0));
+		if ((regval >> GLFLXP_RXDID_FLAGS_FLEXIFLAG_4N_S)
+			& GLFLXP_RXDID_FLAGS_FLEXIFLAG_4N_M)
+			pf->supported_rxdids |= BIT(i);
+	}
+}
+
 /**
  * ice_init_ddp_config - DDP related configuration
  * @hw: pointer to the hardware structure
@@ -4594,6 +4622,9 @@ static int ice_init_ddp_config(struct ice_hw *hw, struct ice_pf *pf)
 	ice_load_pkg(firmware, pf);
 	release_firmware(firmware);
 
+	/* Initialize the supported Rx descriptor IDs after loading DDP */
+	ice_init_supported_rxdids(hw, pf);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index cc070c467fdd..bc9fadaccad0 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -3032,11 +3032,9 @@ static int ice_vc_query_rxdid(struct ice_vf *vf)
 {
 	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
 	struct virtchnl_supported_rxdids *rxdid = NULL;
-	struct ice_hw *hw = &vf->pf->hw;
 	struct ice_pf *pf = vf->pf;
 	int len = 0;
-	int ret, i;
-	u32 regval;
+	int ret;
 
 	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
 		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
@@ -3056,21 +3054,7 @@ static int ice_vc_query_rxdid(struct ice_vf *vf)
 		goto err;
 	}
 
-	/* RXDIDs supported by DDP package can be read from the register
-	 * to get the supported RXDID bitmap. But the legacy 32byte RXDID
-	 * is not listed in DDP package, add it in the bitmap manually.
-	 * Legacy 16byte descriptor is not supported.
-	 */
-	rxdid->supported_rxdids |= BIT(ICE_RXDID_LEGACY_1);
-
-	for (i = ICE_RXDID_FLEX_NIC; i < ICE_FLEX_DESC_RXDID_MAX_NUM; i++) {
-		regval = rd32(hw, GLFLXP_RXDID_FLAGS(i, 0));
-		if ((regval >> GLFLXP_RXDID_FLAGS_FLEXIFLAG_4N_S)
-			& GLFLXP_RXDID_FLAGS_FLEXIFLAG_4N_M)
-			rxdid->supported_rxdids |= BIT(i);
-	}
-
-	pf->supported_rxdids = rxdid->supported_rxdids;
+	rxdid->supported_rxdids = pf->supported_rxdids;
 
 err:
 	ret = ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_GET_SUPPORTED_RXDIDS,
-- 
2.42.0


