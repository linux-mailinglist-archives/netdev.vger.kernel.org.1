Return-Path: <netdev+bounces-30070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A76785DDE
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 18:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61EBA280D90
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 16:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86931F185;
	Wed, 23 Aug 2023 16:48:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0BAC8E0
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 16:48:51 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C256611F
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 09:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692809330; x=1724345330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pa4u7jih0kNEcpkGBcia7bsThdkZg+nVr3AX65SVIVU=;
  b=SSiAp1/iBptVkAUtutnHxwbPiVlR73ShCl0MJxeoBdWz4pKBq+m/HZ6L
   GD5qiVr+vGZ19sk33bQHryNEk5JAw5CowMstu85F/rOMaxoZOdWf4P2AW
   fW029gaztBwcoauYpbgEsYCECojxA8Pv932j5G/xDIB7ob+gJ38bv/C2O
   f5voUg0KE78sQJC86Zdkt3rU8UXxjYiEy4+7Wbzgkc+uDdulOJcujudEB
   1FmkYabjby+Cg4zG+KyfJrD8MM4IHYvdFL1cg6iaHB9egwypuHN0DPaln
   XqsAk3wdtIzvzBe/izxpv3/LsYyKGSBn3VdLfvyuyrg+n5adaya4uhTf7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="438141139"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="438141139"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 09:48:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="802200557"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="802200557"
Received: from spiccard-mobl1.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.252.44.134])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 09:48:48 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [RFC PATCH net-next 3/3] ice: add support for symmetric Toeplitz RSS hash function
Date: Wed, 23 Aug 2023 10:48:31 -0600
Message-Id: <20230823164831.3284341-4-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823164831.3284341-1-ahmed.zaki@intel.com>
References: <20230823164831.3284341-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Support symmetric Toeplitz RSS hash function.

Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  2 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 11 ++++-
 drivers/net/ethernet/intel/ice/ice_lib.c     | 12 ++---
 drivers/net/ethernet/intel/ice/ice_main.c    | 52 ++++++++++++++++++++
 4 files changed, 69 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 5022b036ca4f..e68648c35085 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -356,6 +356,7 @@ struct ice_vsi {
 	/* RSS config */
 	u16 rss_table_size;	/* HW RSS table size */
 	u16 rss_size;		/* Allocated RSS queues */
+	u8 rss_hfunc;		/* User configured hash function */
 	u8 *rss_hkey_user;	/* User configured hash keys */
 	u8 *rss_lut_user;	/* User configured lookup table entries */
 	u8 rss_lut_type;	/* used to configure Get/Set RSS LUT AQ call */
@@ -892,6 +893,7 @@ int ice_set_rss_lut(struct ice_vsi *vsi, u8 *lut, u16 lut_size);
 int ice_get_rss_lut(struct ice_vsi *vsi, u8 *lut, u16 lut_size);
 int ice_set_rss_key(struct ice_vsi *vsi, u8 *seed);
 int ice_get_rss_key(struct ice_vsi *vsi, u8 *seed);
+int ice_set_rss_hfunc(struct ice_vsi *vsi, u8 hfunc);
 void ice_fill_rss_lut(u8 *lut, u16 rss_table_size, u16 rss_size);
 int ice_schedule_reset(struct ice_pf *pf, enum ice_reset_req reset);
 void ice_print_link_msg(struct ice_vsi *vsi, bool isup);
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index ad4d4702129f..9e22e22b895d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3148,7 +3148,7 @@ ice_get_rxfh_context(struct net_device *netdev, u32 *indir,
 	}
 
 	if (hfunc)
-		*hfunc = ETH_RSS_HASH_TOP;
+		*hfunc = vsi->rss_hfunc;
 
 	if (!indir)
 		return 0;
@@ -3215,7 +3215,8 @@ ice_set_rxfh(struct net_device *netdev, const u32 *indir, const u8 *key,
 	int err;
 
 	dev = ice_pf_to_dev(pf);
-	if (hfunc != ETH_RSS_HASH_NO_CHANGE && hfunc != ETH_RSS_HASH_TOP)
+	if (hfunc != ETH_RSS_HASH_NO_CHANGE &&
+	    hfunc != ETH_RSS_HASH_TOP && hfunc != ETH_RSS_HASH_SYM_TOP)
 		return -EOPNOTSUPP;
 
 	if (!test_bit(ICE_FLAG_RSS_ENA, pf->flags)) {
@@ -3229,6 +3230,12 @@ ice_set_rxfh(struct net_device *netdev, const u32 *indir, const u8 *key,
 		return -EOPNOTSUPP;
 	}
 
+	if (hfunc != ETH_RSS_HASH_NO_CHANGE) {
+		err = ice_set_rss_hfunc(vsi, hfunc);
+		if (err)
+			return err;
+	}
+
 	if (key) {
 		if (!vsi->rss_hkey_user) {
 			vsi->rss_hkey_user =
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 201570cd2e0b..160bce8f68b7 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1186,12 +1186,10 @@ static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 	case ICE_VSI_PF:
 		/* PF VSI will inherit RSS instance of PF */
 		lut_type = ICE_AQ_VSI_Q_OPT_RSS_LUT_PF;
-		hash_type = ICE_AQ_VSI_Q_OPT_RSS_TPLZ;
 		break;
 	case ICE_VSI_VF:
 		/* VF VSI will gets a small RSS table which is a VSI LUT type */
 		lut_type = ICE_AQ_VSI_Q_OPT_RSS_LUT_VSI;
-		hash_type = ICE_AQ_VSI_Q_OPT_RSS_TPLZ;
 		break;
 	default:
 		dev_dbg(dev, "Unsupported VSI type %s\n",
@@ -1199,10 +1197,12 @@ static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 		return;
 	}
 
-	ctxt->info.q_opt_rss = ((lut_type << ICE_AQ_VSI_Q_OPT_RSS_LUT_S) &
-				ICE_AQ_VSI_Q_OPT_RSS_LUT_M) |
-				((hash_type << ICE_AQ_VSI_Q_OPT_RSS_HASH_S) &
-				 ICE_AQ_VSI_Q_OPT_RSS_HASH_M);
+	vsi->rss_hfunc = ETH_RSS_HASH_TOP;
+	hash_type = ICE_AQ_VSI_Q_OPT_RSS_TPLZ;
+
+	ctxt->info.q_opt_rss =
+		FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_LUT_M, lut_type) |
+		FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_HASH_M, hash_type);
 }
 
 static void
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index c8286adae946..353fbc75f2c2 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7671,6 +7671,58 @@ int ice_get_rss_key(struct ice_vsi *vsi, u8 *seed)
 	return status;
 }
 
+/**
+ * ice_set_rss_hfunc - Set RSS HASH function
+ * @vsi: Pointer to VSI structure
+ * @hfunc: ethtool hash function (ETH_RSS_HASH_*)
+ *
+ * Returns 0 on success, negative on failure
+ */
+int ice_set_rss_hfunc(struct ice_vsi *vsi, u8 hfunc)
+{
+	struct ice_vsi_ctx *ctx;
+	u8 hash_type;
+	int err;
+
+	if (hfunc == vsi->rss_hfunc)
+		return 0;
+
+	switch (hfunc) {
+	case ETH_RSS_HASH_TOP:
+		hash_type = ICE_AQ_VSI_Q_OPT_RSS_TPLZ;
+		break;
+	case ETH_RSS_HASH_SYM_TOP:
+		hash_type = ICE_AQ_VSI_Q_OPT_RSS_SYM_TPLZ;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->info.valid_sections = cpu_to_le16(ICE_AQ_VSI_PROP_Q_OPT_VALID);
+	ctx->info.q_opt_rss = vsi->info.q_opt_rss;
+	ctx->info.q_opt_rss &= ~ICE_AQ_VSI_Q_OPT_RSS_HASH_M;
+	ctx->info.q_opt_rss |=
+		FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_HASH_M, hash_type);
+	ctx->info.q_opt_tc = vsi->info.q_opt_tc;
+	ctx->info.q_opt_flags = vsi->info.q_opt_rss;
+
+	err = ice_update_vsi(&vsi->back->hw, vsi->idx, ctx, NULL);
+	if (err) {
+		dev_err(ice_pf_to_dev(vsi->back), "Failed to configure RSS hash for VSI %d, error %d\n",
+			vsi->vsi_num, err);
+	} else {
+		vsi->info.q_opt_rss = ctx->info.q_opt_rss;
+		vsi->rss_hfunc = hfunc;
+	}
+
+	kfree(ctx);
+	return err;
+}
+
 /**
  * ice_bridge_getlink - Get the hardware bridge mode
  * @skb: skb buff
-- 
2.39.2


