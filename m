Return-Path: <netdev+bounces-46215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971A57E289D
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 16:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F630B20BE4
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 15:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB4F28E04;
	Mon,  6 Nov 2023 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nC41Dq2L"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C11D1773B
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 15:26:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F07125
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 07:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699284375; x=1730820375;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z4hObpuNefplRECRvFfNiSxNjDgba8y3jRhdyvxG5+c=;
  b=nC41Dq2LXC30PxNnR3EqpQFz97eaflq/aOtNeAtmwHpK49qkrn9DymCp
   L2f3NBtU8Wqzq9l7y6cxa6DoBUKOnTHBZaGmjmPWoPBeUalxRooEYFyso
   5rfGetpfCKy/ONJXUWuLPIR8YpBTJ2aK9ciUZ7ztAQDnZw3yWoFdfvwWU
   BuHEXylDqaqoNW/dGZVo1gA006u20QP5bR1vha80KcPeVs32GvzQlPKPo
   uEgw/wIvZ1grdjkjCyi1mdm7Edly6Y2sTrPYoaTUiBtMHp2/EAacF4efN
   5OAtORi2xYGzqEIWOfT1I/jdE8ME9aSAPK9urLm8NgfZbHYCYXm9ym1MQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="389105786"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="389105786"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 07:26:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="791492575"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="791492575"
Received: from unknown (HELO fedora.jf.intel.com) ([10.166.244.154])
  by orsmga008.jf.intel.com with ESMTP; 06 Nov 2023 07:26:14 -0800
From: Paul Greenwalt <paul.greenwalt@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	kuba@kernel.org,
	horms@kernel.org,
	tony.brelinski@intel.com,
	Dan Nowlin <dan.nowlin@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH iwl-net] ice: fix DDP package download for packages without signature segment
Date: Mon,  6 Nov 2023 10:18:07 -0500
Message-ID: <20231106151808.421280-1-paul.greenwalt@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dan Nowlin <dan.nowlin@intel.com>

Commit 3cbdb0343022 ("ice: Add support for E830 DDP package segment")
incorrectly removed support for package download for packages without a
signature segment. These packages include the signature buffer inline
in the configurations buffers, and do not in a signature segment.

Fix package download by providing download support for both packages
with (ice_download_pkg_with_sig_seg()) and without signature segment
(ice_download_pkg_without_sig_seg()).

Fixes: 3cbdb0343022 ("ice: Add support for E830 DDP package segment")
Reported-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
Changelog
v1->v2:
Fix Reported-by email.
---

 drivers/net/ethernet/intel/ice/ice_ddp.c | 106 ++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index cfb1580f5850..3f1a11d0252c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -1479,14 +1479,14 @@ ice_post_dwnld_pkg_actions(struct ice_hw *hw)
 }
 
 /**
- * ice_download_pkg
+ * ice_download_pkg_with_sig_seg
  * @hw: pointer to the hardware structure
  * @pkg_hdr: pointer to package header
  *
  * Handles the download of a complete package.
  */
 static enum ice_ddp_state
-ice_download_pkg(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr)
+ice_download_pkg_with_sig_seg(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr)
 {
 	enum ice_aq_err aq_err = hw->adminq.sq_last_status;
 	enum ice_ddp_state state = ICE_DDP_PKG_ERR;
@@ -1519,6 +1519,106 @@ ice_download_pkg(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr)
 		state = ice_post_dwnld_pkg_actions(hw);
 
 	ice_release_global_cfg_lock(hw);
+
+	return state;
+}
+
+/**
+ * ice_dwnld_cfg_bufs
+ * @hw: pointer to the hardware structure
+ * @bufs: pointer to an array of buffers
+ * @count: the number of buffers in the array
+ *
+ * Obtains global config lock and downloads the package configuration buffers
+ * to the firmware.
+ */
+static enum ice_ddp_state
+ice_dwnld_cfg_bufs(struct ice_hw *hw, struct ice_buf *bufs, u32 count)
+{
+	enum ice_ddp_state state = ICE_DDP_PKG_SUCCESS;
+	struct ice_buf_hdr *bh;
+	int status;
+
+	if (!bufs || !count)
+		return ICE_DDP_PKG_ERR;
+
+	/* If the first buffer's first section has its metadata bit set
+	 * then there are no buffers to be downloaded, and the operation is
+	 * considered a success.
+	 */
+	bh = (struct ice_buf_hdr *)bufs;
+	if (le32_to_cpu(bh->section_entry[0].type) & ICE_METADATA_BUF)
+		return ICE_DDP_PKG_SUCCESS;
+
+	status = ice_acquire_global_cfg_lock(hw, ICE_RES_WRITE);
+	if (status) {
+		if (status == -EALREADY)
+			return ICE_DDP_PKG_ALREADY_LOADED;
+		return ice_map_aq_err_to_ddp_state(hw->adminq.sq_last_status);
+	}
+
+	state = ice_dwnld_cfg_bufs_no_lock(hw, bufs, 0, count, true);
+	if (!state)
+		state = ice_post_dwnld_pkg_actions(hw);
+
+	ice_release_global_cfg_lock(hw);
+
+	return state;
+}
+
+/**
+ * ice_download_pkg_without_sig_seg
+ * @hw: pointer to the hardware structure
+ * @ice_seg: pointer to the segment of the package to be downloaded
+ *
+ * Handles the download of a complete package without signature segment.
+ */
+static enum ice_ddp_state
+ice_download_pkg_without_sig_seg(struct ice_hw *hw, struct ice_seg *ice_seg)
+{
+	struct ice_buf_table *ice_buf_tbl;
+	enum ice_ddp_state state;
+
+	ice_debug(hw, ICE_DBG_PKG, "Segment format version: %d.%d.%d.%d\n",
+		  ice_seg->hdr.seg_format_ver.major,
+		  ice_seg->hdr.seg_format_ver.minor,
+		  ice_seg->hdr.seg_format_ver.update,
+		  ice_seg->hdr.seg_format_ver.draft);
+
+	ice_debug(hw, ICE_DBG_PKG, "Seg: type 0x%X, size %d, name %s\n",
+		  le32_to_cpu(ice_seg->hdr.seg_type),
+		  le32_to_cpu(ice_seg->hdr.seg_size), ice_seg->hdr.seg_id);
+
+	ice_buf_tbl = ice_find_buf_table(ice_seg);
+
+	ice_debug(hw, ICE_DBG_PKG, "Seg buf count: %d\n",
+		  le32_to_cpu(ice_buf_tbl->buf_count));
+
+	state = ice_dwnld_cfg_bufs(hw, ice_buf_tbl->buf_array,
+				   le32_to_cpu(ice_buf_tbl->buf_count));
+
+	return state;
+}
+
+/**
+ * ice_download_pkg
+ * @hw: pointer to the hardware structure
+ * @pkg_hdr: pointer to package header
+ * @ice_seg: pointer to the segment of the package to be downloaded
+ *
+ * Handles the download of a complete package.
+ */
+static enum ice_ddp_state
+ice_download_pkg(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr,
+		 struct ice_seg *ice_seg)
+{
+	enum ice_ddp_state state;
+
+	if (hw->pkg_has_signing_seg)
+		state = ice_download_pkg_with_sig_seg(hw, pkg_hdr);
+	else
+		state = ice_download_pkg_without_sig_seg(hw, ice_seg);
+
 	ice_post_pkg_dwnld_vlan_mode_cfg(hw);
 
 	return state;
@@ -2083,7 +2183,7 @@ enum ice_ddp_state ice_init_pkg(struct ice_hw *hw, u8 *buf, u32 len)
 
 	/* initialize package hints and then download package */
 	ice_init_pkg_hints(hw, seg);
-	state = ice_download_pkg(hw, pkg);
+	state = ice_download_pkg(hw, pkg, seg);
 	if (state == ICE_DDP_PKG_ALREADY_LOADED) {
 		ice_debug(hw, ICE_DBG_INIT,
 			  "package previously loaded - no work.\n");

base-commit: 016b9332a3346e97a6cacffea0f9dc10e1235a75
-- 
2.41.0


