Return-Path: <netdev+bounces-47501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 959307EA6B2
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C676A1C20A40
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20AF3D98D;
	Mon, 13 Nov 2023 23:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ft7afLvX"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD463D3A6
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:06:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5192FD68
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699916762; x=1731452762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DGPoUowa0X5aIDK+LjJ/YR50smrHczmVzcux4kSioAo=;
  b=Ft7afLvXbb7RR1oUGZViys9aA/LrWDAhdjgHwXkDYdyFL3XwvRihu9T2
   VTaT8YqsFRY06MUSxdPdl13xfsw77CKrWlC4RJAajIo9YGoJnnLtvyb2h
   sBGI+PGbtlqKXmDE6aJ4CNMzIkhWQg690Gve8OHQHx6GeZaNQ8SL1A7HS
   f0BgkmnxYkaZF4yncRWlpv8R5QUcKx1nTNaiKp7ED3S0kO6TjchifD3W+
   KBKKz+f9CpNT8CU9pZBWsPDqnqplbSmTaLDLdvYEx9YycutSy5mCvK8sp
   gp92gn+L1Ahg/KRTF9DqFH+ZaODOoGRlKMRUXiBj9p/lSvmEwO3OIMQ15
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="421633184"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="421633184"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 15:06:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="12598059"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 13 Nov 2023 15:06:01 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Dan Nowlin <dan.nowlin@intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Arpana Arland <arpanax.arland@intel.com>
Subject: [PATCH net 4/4] ice: fix DDP package download for packages without signature segment
Date: Mon, 13 Nov 2023 15:05:49 -0800
Message-ID: <20231113230551.548489-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113230551.548489-1-anthony.l.nguyen@intel.com>
References: <20231113230551.548489-1-anthony.l.nguyen@intel.com>
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
in the configurations buffers, and not in a signature segment.

Fix package download by providing download support for both packages
with (ice_download_pkg_with_sig_seg()) and without signature segment
(ice_download_pkg_without_sig_seg()).

Fixes: 3cbdb0343022 ("ice: Add support for E830 DDP package segment")
Reported-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Closes: https://lore.kernel.org/netdev/ZUT50a94kk2pMGKb@boxer/
Tested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ddp.c | 103 ++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index cfb1580f5850..8b7504a9df31 100644
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
@@ -1519,6 +1519,103 @@ ice_download_pkg(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr)
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
+	enum ice_ddp_state state;
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
+	return ice_dwnld_cfg_bufs(hw, ice_buf_tbl->buf_array,
+				  le32_to_cpu(ice_buf_tbl->buf_count));
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
@@ -2083,7 +2180,7 @@ enum ice_ddp_state ice_init_pkg(struct ice_hw *hw, u8 *buf, u32 len)
 
 	/* initialize package hints and then download package */
 	ice_init_pkg_hints(hw, seg);
-	state = ice_download_pkg(hw, pkg);
+	state = ice_download_pkg(hw, pkg, seg);
 	if (state == ICE_DDP_PKG_ALREADY_LOADED) {
 		ice_debug(hw, ICE_DBG_INIT,
 			  "package previously loaded - no work.\n");
-- 
2.41.0


