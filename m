Return-Path: <netdev+bounces-285813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF7pCSjf/Wn0jwAAu9opvQ
	(envelope-from <netdev+bounces-285813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:03:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B934D4F6BDF
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EA673060337
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 12:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D4B3E122F;
	Fri,  8 May 2026 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fYgwTyej"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A842F3E1CF4
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778245191; cv=none; b=OdgyqdiJSqGx0M/Vzql1YnkyjJ+Gas7bNcW0kFCraOgdtkfD3RLvX7F008ZVFm3b4U3ktrEvm1GJTHSOPM77MeA/3/0Al2XpCWAHQcrQYdzou0xjhSldcfh1Svc6DYGEyuP1Z3A9EnViRyu/+NayeuJoqCnKu3eQTyss+mnquqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778245191; c=relaxed/simple;
	bh=tcIF3olztzirYuNdibKrjAmw5KKYdetWRVQvzdBOXp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sWAPS/Xr7HK9hVVP+qifpHTF4GuZ/tw4qkRsTq5FpEBnEftwiXLcpQKDn58IK1tjuraq33N5okpjp3kR+vzgA/cWOn6oaRVJ61VXh+4FgP42p8eT9aoF0NpMfui4YdRVthVYD4ghx1eD+oooKfcdUtdGU5jFrxe3joI8VFgngU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fYgwTyej; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778245190; x=1809781190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tcIF3olztzirYuNdibKrjAmw5KKYdetWRVQvzdBOXp4=;
  b=fYgwTyejcGrethv9iLBObX41BiIDBD1J8ihyqHpOZtLfo1dXT7l+y2qk
   W1S5SKFi8+U9MTL9+eot3KJYteankaZC6k/wzmgG2aK1gQNpkEZAYELQb
   2uuDMtR7+dK9xsA6h+nGvih4+q16/GGhezUcYv6GjOA/N0xNr93oyKkOL
   cs7I/BVJLqWArMjTQDLbVpqsmLKpJfkRnI4/x4pVVz+iG/mhIF60I3mF2
   xGreT9Ehp1r+LnUCYNjy5Nfe6fUvx9Au1C7BVAL0x06gtASbIXRBwdei1
   NC5YERf0VnYA3bhhQXNbf2y1z+mhc5GVjjahAHGStpzkGqevBEaFPStnb
   A==;
X-CSE-ConnectionGUID: YzYG3JYDSnKVpP9x+Gp2wQ==
X-CSE-MsgGUID: YUnQUXBiQn+dGJx9jSGueg==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79199891"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="79199891"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 05:59:50 -0700
X-CSE-ConnectionGUID: Px6Abes9SJydlSe1VPKilg==
X-CSE-MsgGUID: 6OJBYbNuQJaAKbhNfDlFjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="241730119"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa005.fm.intel.com with ESMTP; 08 May 2026 05:59:44 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 908DD2FC41;
	Fri,  8 May 2026 13:59:42 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Michal Schmidt <mschmidt@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	bruce.richardson@intel.com,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
	padraig.j.connolly@intel.com,
	ananth.s@intel.com,
	timothy.miskell@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v1 05/15] ice: add helpers for Global RSS LUT alloc, free, vsi_update
Date: Fri,  8 May 2026 14:41:58 +0200
Message-Id: <20260508124208.11622-6-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260508124208.11622-1-przemyslaw.kitszel@intel.com>
References: <20260508124208.11622-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B934D4F6BDF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-285813-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.kitszel@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add AQ commands for RSS Global LUT allocation and free operations.
Functions will be called since subsequent commit.

Add programming code for GLOBAL LUT ID of UPDATE VSI AQ,
do the same for RSS LUT "type", also for PF LUT in case of VF VSI.

Co-developed-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |  1 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_switch.h   |  2 +
 drivers/net/ethernet/intel/ice/ice_lib.c      | 28 +++++++++++--
 drivers/net/ethernet/intel/ice/ice_switch.c   | 41 +++++++++++++++++++
 5 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index f9a43daf04fe..7f4f299c4d37 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -369,6 +369,7 @@ struct ice_vsi {
 	u8 *rss_hkey_user;	/* User configured hash keys */
 	u8 *rss_lut_user;	/* User configured lookup table entries */
 	u8 rss_lut_type;	/* used to configure Get/Set RSS LUT AQ call */
+	u8 global_lut_id;       /* valid when lut_type == GLOBAL_LUT */
 
 	/* aRFS members only allocated for the PF VSI */
 #define ICE_MAX_ARFS_LIST	1024
diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index d41b2427482d..c49896db51c6 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -169,6 +169,7 @@ struct ice_aqc_set_port_params {
 #define ICE_AQC_RES_TYPE_VSI_LIST_PRUNE			0x04
 #define ICE_AQC_RES_TYPE_RECIPE				0x05
 #define ICE_AQC_RES_TYPE_SWID				0x07
+#define ICE_AQC_RES_TYPE_GLOBAL_RSS_HASH		0x20
 #define ICE_AQC_RES_TYPE_FDIR_COUNTER_BLOCK		0x21
 #define ICE_AQC_RES_TYPE_FDIR_GUARANTEED_ENTRIES	0x22
 #define ICE_AQC_RES_TYPE_FDIR_SHARED_ENTRIES		0x23
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.h b/drivers/net/ethernet/intel/ice/ice_switch.h
index b442db4a2ce5..ab6a8c78d14a 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -401,6 +401,8 @@ ice_rem_adv_rule_by_id(struct ice_hw *hw,
 		       struct ice_rule_query_data *remove_entry);
 
 int ice_init_def_sw_recp(struct ice_hw *hw);
+int ice_alloc_rss_global_lut(struct ice_hw *hw, u16 *global_lut_id);
+int ice_free_rss_global_lut(struct ice_hw *hw, u16 global_lut_id);
 u16 ice_get_hw_vsi_num(struct ice_hw *hw, u16 vsi_handle);
 
 int ice_replay_vsi_all_fltr(struct ice_hw *hw, u16 vsi_handle);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index ac6698a01d2f..2de62cde14ab 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1154,30 +1154,46 @@ static void ice_set_fd_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 	ctxt->info.acl_def_act = cpu_to_le16(val);
 }
 
+/* Translate @lut_type used in most of the places to the Admin Queue
+ * Q_OPT value for RSS.
+ * Used with VSI ADD and VSI UPDATE AQs (opcodes 0x0210, 0x0211).
+ */
+static u8 ice_lut_type_to_aq_qopt_rss_val(enum ice_lut_type lut_type)
+{
+	switch (lut_type) {
+	case ICE_LUT_PF:
+		return ICE_AQ_VSI_Q_OPT_RSS_LUT_PF;
+	case ICE_LUT_GLOBAL:
+		return ICE_AQ_VSI_Q_OPT_RSS_LUT_GBL;
+	case ICE_LUT_VSI:
+	default:
+		return ICE_AQ_VSI_Q_OPT_RSS_LUT_VSI;
+	}
+}
+
 /**
  * ice_set_rss_vsi_ctx - Set RSS VSI context before adding a VSI
  * @ctxt: the VSI context being set
  * @vsi: the VSI being configured
  */
 void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 {
 	u8 lut_type, hash_type;
+	u8 global_lut_id = 0;
 	struct device *dev;
 	struct ice_pf *pf;
 
 	pf = vsi->back;
 	dev = ice_pf_to_dev(pf);
 
 	switch (vsi->type) {
 	case ICE_VSI_CHNL:
-	case ICE_VSI_PF:
-		/* PF VSI will inherit RSS instance of PF */
 		lut_type = ICE_AQ_VSI_Q_OPT_RSS_LUT_PF;
 		break;
+	case ICE_VSI_PF:
 	case ICE_VSI_VF:
 	case ICE_VSI_SF:
-		/* VF VSI will gets a small RSS table which is a VSI LUT type */
-		lut_type = ICE_AQ_VSI_Q_OPT_RSS_LUT_VSI;
+		lut_type = ice_lut_type_to_aq_qopt_rss_val(vsi->rss_lut_type);
 		break;
 	default:
 		dev_dbg(dev, "Unsupported VSI type %s\n",
@@ -1189,8 +1205,12 @@ void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 		vsi->rss_hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
 	hash_type = vsi->rss_hfunc;
 
+	if (vsi->rss_lut_type == ICE_LUT_GLOBAL)
+		 global_lut_id = vsi->global_lut_id;
+
 	ctxt->info.q_opt_rss =
 		FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_LUT_M, lut_type) |
+		FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_GBL_LUT_M, global_lut_id) |
 		FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_HASH_M, hash_type);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 88f1aefc24b3..b783c97f6cfe 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -1527,6 +1527,47 @@ ice_aq_get_sw_cfg(struct ice_hw *hw, struct ice_aqc_get_sw_cfg_resp_elem *buf,
 	return status;
 }
 
+/* Allocate a new Global LUT for the caller.
+ * LUT ID is returned via @global_lut_id.
+ */
+int ice_alloc_rss_global_lut(struct ice_hw *hw, u16 *global_lut_id)
+{
+	DEFINE_RAW_FLEX(struct ice_aqc_alloc_free_res_elem, buf, elem, 1);
+	u16 buf_len = __struct_size(buf);
+	int err;
+
+	buf->num_elems = cpu_to_le16(1);
+	buf->res_type = cpu_to_le16(ICE_AQC_RES_TYPE_GLOBAL_RSS_HASH);
+
+	err = ice_aq_alloc_free_res(hw, buf, buf_len, ice_aqc_opc_alloc_res);
+	if (err)
+		ice_debug(hw, ICE_DBG_RES, "Failed to allocate RSS global LUT, err %d\n",
+			  err);
+	else
+		*global_lut_id = le16_to_cpu(buf->elem[0].e.sw_resp);
+
+	return err;
+}
+
+/* Free Global LUT at @global_lut_id. */
+int ice_free_rss_global_lut(struct ice_hw *hw, u16 global_lut_id)
+{
+	DEFINE_RAW_FLEX(struct ice_aqc_alloc_free_res_elem, buf, elem, 1);
+	u16 buf_len = __struct_size(buf);
+	int err;
+
+	buf->num_elems = cpu_to_le16(1);
+	buf->res_type = cpu_to_le16(ICE_AQC_RES_TYPE_GLOBAL_RSS_HASH);
+	buf->elem[0].e.sw_resp = cpu_to_le16(global_lut_id);
+
+	err = ice_aq_alloc_free_res(hw, buf, buf_len, ice_aqc_opc_free_res);
+	if (err)
+		ice_debug(hw, ICE_DBG_RES, "Failed to free RSS global LUT %d, err %d\n",
+			  global_lut_id, err);
+
+	return err;
+}
+
 /**
  * ice_aq_add_vsi
  * @hw: pointer to the HW struct
-- 
2.39.3


