Return-Path: <netdev+bounces-15751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E5A74985E
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 11:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5883328123F
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 09:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8DA5255;
	Thu,  6 Jul 2023 09:26:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE587483
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 09:26:33 +0000 (UTC)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D1F1BF3
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 02:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688635590; x=1720171590;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tpxhDS4eUcvbMNVT3Hp8qJc0b+xaK7HRLOVFFXA4q1A=;
  b=lgg6AZ07bCF70O0zlkFyczX5pM9/RZeCbRgTto7j1tlNRmNFOyXWQ9qh
   8X8DFSIfUX8ax6BwFWkRJiMXAbOUYOuYup42kVAYfU6VJffpTroj6Zh4g
   pjSGHvK3yA0pmdkmjsonbUALP0ByQnPRJzYjz+9Gmmu/p/IVOEeOsOei2
   GastFS3VQfgbFC3nCZyotjPNVh8j0arYFZ4r8LSNZvqPio4V9X7e4O4LX
   i3l0HOcdVtIM/9drgpelg/IbeHzBGB0YjcWsQ4mxtfcpLDHRAAhoPnWwm
   bKgCv5d1DcQQTHHlT4Df7qd1SDZghwHbJmBkV46nRxYfXXcZhPe7KyaUr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="427233149"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="427233149"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 02:25:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="784863739"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="784863739"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jul 2023 02:25:51 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net v3] ice: Fix memory management in ice_ethtool_fdir.c
Date: Thu,  6 Jul 2023 11:19:10 +0200
Message-Id: <20230706091910.124498-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix ethtool FDIR logic to not use memory after its release.
In the ice_ethtool_fdir.c file there are 2 spots where code can
refer to pointers which may be missing.

In the ice_cfg_fdir_xtrct_seq() function seg may be freed but
even then may be still used by memcpy(&tun_seg[1], seg, sizeof(*seg)).

In the ice_add_fdir_ethtool() function struct ice_fdir_fltr *input
may first fail to be added via ice_fdir_update_list_entry() but then
may be deleted by ice_fdir_update_list_entry.

Terminate in both cases when the returned value of the previous
operation is other than 0, free memory and don't use it anymore.

Replace managed memory alloc with kzalloc/kfree in
ice_cfg_fdir_xtrct_seq() since seg/tun_seg are used only by
ice_fdir_set_hw_fltr_rule().

Reported-by: Michal Schmidt <mschmidt@redhat.com>
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2208423
Fixes: cac2a27cd9ab ("ice: Support IPv4 Flow Director filters")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
v2: extend CC list, fix freeing memory before return
v3: correct typos in the commit msg
---
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c | 62 +++++++++----------
 1 file changed, 28 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
index ead6d50fc0ad..619b32f4bc53 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
@@ -1204,21 +1204,16 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
 		       struct ice_rx_flow_userdef *user)
 {
 	struct ice_flow_seg_info *seg, *tun_seg;
-	struct device *dev = ice_pf_to_dev(pf);
 	enum ice_fltr_ptype fltr_idx;
 	struct ice_hw *hw = &pf->hw;
 	bool perfect_filter;
 	int ret;
 
-	seg = devm_kzalloc(dev, sizeof(*seg), GFP_KERNEL);
-	if (!seg)
-		return -ENOMEM;
-
-	tun_seg = devm_kcalloc(dev, ICE_FD_HW_SEG_MAX, sizeof(*tun_seg),
-			       GFP_KERNEL);
-	if (!tun_seg) {
-		devm_kfree(dev, seg);
-		return -ENOMEM;
+	seg = kzalloc(sizeof(*seg), GFP_KERNEL);
+	tun_seg = kcalloc(ICE_FD_HW_SEG_MAX, sizeof(*tun_seg), GFP_KERNEL);
+	if (!tun_seg || !seg) {
+		ret = -ENOMEM;
+		goto exit;
 	}
 
 	switch (fsp->flow_type & ~FLOW_EXT) {
@@ -1264,7 +1259,7 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
 		ret = -EINVAL;
 	}
 	if (ret)
-		goto err_exit;
+		goto exit;
 
 	/* tunnel segments are shifted up one. */
 	memcpy(&tun_seg[1], seg, sizeof(*seg));
@@ -1281,42 +1276,39 @@ ice_cfg_fdir_xtrct_seq(struct ice_pf *pf, struct ethtool_rx_flow_spec *fsp,
 				     ICE_FLOW_FLD_OFF_INVAL);
 	}
 
-	/* add filter for outer headers */
 	fltr_idx = ice_ethtool_flow_to_fltr(fsp->flow_type & ~FLOW_EXT);
+
+	if (perfect_filter)
+		set_bit(fltr_idx, hw->fdir_perfect_fltr);
+	else
+		clear_bit(fltr_idx, hw->fdir_perfect_fltr);
+
+	/* add filter for outer headers */
 	ret = ice_fdir_set_hw_fltr_rule(pf, seg, fltr_idx,
 					ICE_FD_HW_SEG_NON_TUN);
-	if (ret == -EEXIST)
-		/* Rule already exists, free memory and continue */
-		devm_kfree(dev, seg);
-	else if (ret)
+	if (ret == -EEXIST) {
+		/* Rule already exists, free memory and count as success */
+		ret = 0;
+		goto exit;
+	} else if (ret) {
 		/* could not write filter, free memory */
-		goto err_exit;
+		ret = -EOPNOTSUPP;
+		goto exit;
+	}
 
 	/* make tunneled filter HW entries if possible */
 	memcpy(&tun_seg[1], seg, sizeof(*seg));
 	ret = ice_fdir_set_hw_fltr_rule(pf, tun_seg, fltr_idx,
 					ICE_FD_HW_SEG_TUN);
-	if (ret == -EEXIST) {
+	if (ret == -EEXIST)
 		/* Rule already exists, free memory and count as success */
-		devm_kfree(dev, tun_seg);
 		ret = 0;
-	} else if (ret) {
-		/* could not write tunnel filter, but outer filter exists */
-		devm_kfree(dev, tun_seg);
-	}
 
-	if (perfect_filter)
-		set_bit(fltr_idx, hw->fdir_perfect_fltr);
-	else
-		clear_bit(fltr_idx, hw->fdir_perfect_fltr);
+exit:
+	kfree(tun_seg);
+	kfree(seg);
 
 	return ret;
-
-err_exit:
-	devm_kfree(dev, tun_seg);
-	devm_kfree(dev, seg);
-
-	return -EOPNOTSUPP;
 }
 
 /**
@@ -1914,7 +1906,9 @@ int ice_add_fdir_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 	input->comp_report = ICE_FXD_FLTR_QW0_COMP_REPORT_SW_FAIL;
 
 	/* input struct is added to the HW filter list */
-	ice_fdir_update_list_entry(pf, input, fsp->location);
+	ret = ice_fdir_update_list_entry(pf, input, fsp->location);
+	if (ret)
+		goto release_lock;
 
 	ret = ice_fdir_write_all_fltr(pf, input, true);
 	if (ret)
-- 
2.31.1


