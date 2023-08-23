Return-Path: <netdev+bounces-30093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B08D785F58
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 20:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB34281360
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 18:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE661F923;
	Wed, 23 Aug 2023 18:11:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681D51ED47
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 18:11:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724C3CC7
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 11:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692814277; x=1724350277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1V4K2POTSsh1TsuWPjXs0qGCmfECTzXW7vUhbnWYP6U=;
  b=INklx0BdRIYbvilZLWwOt56YmQiwLBYVEpJE7V3aBZyl7JUkXY+rjUMt
   kuftHawqilyKo7YN3CBUYVYiZOmLR4wIcjzG0iHJ6Ji0FR+tvKpW5CEl2
   IuINeTKhaFbUkYZ8j7xxVcyBdWWikYstjhFDaO4cX2I+lfDVRs2GoHHAW
   5c5MLf2MdG41oMKs9w2fi4+J8c0lEFGVr5jZBmJUVJr1aSfis9lv/YYQK
   QjvZ8LTHvkM19aE/VSQ8h3y0L54p+KP4WcnCfTnOCVStZz3ShrtCKHnUP
   xc2voBeEgMaG7gAbKB9qMx5EU+sv+Jpf6z50lM1gCQfXnZ3pzK9muot8G
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="374211862"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="374211862"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 11:11:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="851141527"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="851141527"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga002.fm.intel.com with ESMTP; 23 Aug 2023 11:11:12 -0700
Received: from baltimore.igk.intel.com (baltimore.igk.intel.com [10.102.21.1])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 327E833E8D;
	Wed, 23 Aug 2023 19:11:11 +0100 (IST)
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: intel-wired-lan@osuosl.org
Cc: netdev@vger.kernel.org,
	andrew@lunn.ch,
	aelior@marvell.com,
	manishc@marvell.com,
	Dan Nowlin <dan.nowlin@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH iwl-next v3 6/8] ice: Add support for E830 DDP package segment
Date: Wed, 23 Aug 2023 20:06:30 +0200
Message-Id: <20230823180633.2450617-7-pawel.chmielewski@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230823180633.2450617-1-pawel.chmielewski@intel.com>
References: <20230823180633.2450617-1-pawel.chmielewski@intel.com>
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

From: Dan Nowlin <dan.nowlin@intel.com>

Add support for E830 DDP package segment. For the E830 package,
signature buffers will not be included inline in the configuration
buffers. Instead, the signature buffers will be located in a
signature segment.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
Co-developed-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ddp.c  | 426 ++++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_ddp.h  |  27 +-
 drivers/net/ethernet/intel/ice/ice_type.h |   3 +
 3 files changed, 382 insertions(+), 74 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index b27ec93638b6..15ea477b76bd 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -1201,23 +1201,120 @@ ice_aq_download_pkg(struct ice_hw *hw, struct ice_buf_hdr *pkg_buf,
 }
 
 /**
- * ice_dwnld_cfg_bufs
+ * ice_get_pkg_seg_by_idx
+ * @pkg_hdr: pointer to the package header to be searched
+ * @idx: index of segment
+ */
+static struct ice_generic_seg_hdr *
+ice_get_pkg_seg_by_idx(struct ice_pkg_hdr *pkg_hdr, u32 idx)
+{
+	if (idx < le32_to_cpu(pkg_hdr->seg_count))
+		return (struct ice_generic_seg_hdr *)
+			((u8 *)pkg_hdr +
+			 le32_to_cpu(pkg_hdr->seg_offset[idx]));
+
+	return NULL;
+}
+
+/**
+ * ice_is_signing_seg_at_idx - determine if segment is a signing segment
+ * @pkg_hdr: pointer to package header
+ * @idx: segment index
+ */
+static bool ice_is_signing_seg_at_idx(struct ice_pkg_hdr *pkg_hdr, u32 idx)
+{
+	struct ice_generic_seg_hdr *seg;
+
+	seg = ice_get_pkg_seg_by_idx(pkg_hdr, idx);
+	if (!seg)
+		return false;
+
+	return le32_to_cpu(seg->seg_type) == SEGMENT_TYPE_SIGNING;
+}
+
+/**
+ * ice_is_signing_seg_type_at_idx
+ * @pkg_hdr: pointer to package header
+ * @idx: segment index
+ * @seg_id: segment id that is expected
+ * @sign_type: signing type
+ *
+ * Determine if a segment is a signing segment of the correct type
+ */
+static bool
+ice_is_signing_seg_type_at_idx(struct ice_pkg_hdr *pkg_hdr, u32 idx,
+			       u32 seg_id, u32 sign_type)
+{
+	struct ice_sign_seg *seg;
+
+	if (!ice_is_signing_seg_at_idx(pkg_hdr, idx))
+		return false;
+
+	seg = (struct ice_sign_seg *)ice_get_pkg_seg_by_idx(pkg_hdr, idx);
+
+	if (seg && le32_to_cpu(seg->seg_id) == seg_id &&
+	    le32_to_cpu(seg->sign_type) == sign_type)
+		return true;
+
+	return false;
+}
+
+/**
+ * ice_is_buffer_metadata - determine if package buffer is a metadata buffer
+ * @buf: pointer to buffer header
+ */
+static bool ice_is_buffer_metadata(struct ice_buf_hdr *buf)
+{
+	if (le32_to_cpu(buf->section_entry[0].type) & ICE_METADATA_BUF)
+		return true;
+
+	return false;
+}
+
+/**
+ * ice_is_last_download_buffer
+ * @buf: pointer to current buffer header
+ * @idx: index of the buffer in the current sequence
+ * @count: the buffer count in the current sequence
+ *
+ * Note: this routine should only be called if the buffer is not the last buffer
+ */
+static bool
+ice_is_last_download_buffer(struct ice_buf_hdr *buf, u32 idx, u32 count)
+{
+	struct ice_buf *next_buf;
+
+	if ((idx + 1) == count)
+		return true;
+
+	/* A set metadata flag in the next buffer will signal that the current
+	 * buffer will be the last buffer downloaded
+	 */
+	next_buf = ((struct ice_buf *)buf) + 1;
+
+	return ice_is_buffer_metadata((struct ice_buf_hdr *)next_buf);
+}
+
+/**
+ * ice_dwnld_cfg_bufs_no_lock
  * @hw: pointer to the hardware structure
  * @bufs: pointer to an array of buffers
- * @count: the number of buffers in the array
+ * @start: buffer index of first buffer to download
+ * @count: the number of buffers to download
+ * @indicate_last: if true, then set last buffer flag on last buffer download
  *
- * Obtains global config lock and downloads the package configuration buffers
- * to the firmware. Metadata buffers are skipped, and the first metadata buffer
- * found indicates that the rest of the buffers are all metadata buffers.
+ * Downloads package configuration buffers to the firmware. Metadata buffers
+ * are skipped, and the first metadata buffer found indicates that the rest
+ * of the buffers are all metadata buffers.
  */
-static enum ice_ddp_state ice_dwnld_cfg_bufs(struct ice_hw *hw,
-					     struct ice_buf *bufs, u32 count)
+static enum ice_ddp_state
+ice_dwnld_cfg_bufs_no_lock(struct ice_hw *hw, struct ice_buf *bufs, u32 start,
+			   u32 count, bool indicate_last)
 {
 	enum ice_ddp_state state = ICE_DDP_PKG_SUCCESS;
 	struct ice_buf_hdr *bh;
 	enum ice_aq_err err;
 	u32 offset, info, i;
-	int status;
 
 	if (!bufs || !count)
 		return ICE_DDP_PKG_ERR;
@@ -1226,43 +1323,25 @@ static enum ice_ddp_state ice_dwnld_cfg_bufs(struct ice_hw *hw,
 	 * then there are no buffers to be downloaded, and the operation is
 	 * considered a success.
 	 */
-	bh = (struct ice_buf_hdr *)bufs;
+	bh = (struct ice_buf_hdr *)(bufs + start);
 	if (le32_to_cpu(bh->section_entry[0].type) & ICE_METADATA_BUF)
 		return ICE_DDP_PKG_SUCCESS;
 
-	status = ice_acquire_global_cfg_lock(hw, ICE_RES_WRITE);
-	if (status) {
-		if (status == -EALREADY)
-			return ICE_DDP_PKG_ALREADY_LOADED;
-		return ice_map_aq_err_to_ddp_state(hw->adminq.sq_last_status);
-	}
-
 	for (i = 0; i < count; i++) {
-		bool last = ((i + 1) == count);
+		bool last = false;
+		int status;
 
-		if (!last) {
-			/* check next buffer for metadata flag */
-			bh = (struct ice_buf_hdr *)(bufs + i + 1);
+		bh = (struct ice_buf_hdr *)(bufs + start + i);
 
-			/* A set metadata flag in the next buffer will signal
-			 * that the current buffer will be the last buffer
-			 * downloaded
-			 */
-			if (le16_to_cpu(bh->section_count))
-				if (le32_to_cpu(bh->section_entry[0].type) &
-				    ICE_METADATA_BUF)
-					last = true;
-		}
-
-		bh = (struct ice_buf_hdr *)(bufs + i);
+		if (indicate_last)
+			last = ice_is_last_download_buffer(bh, i, count);
 
 		status = ice_aq_download_pkg(hw, bh, ICE_PKG_BUF_SIZE, last,
 					     &offset, &info, NULL);
 
 		/* Save AQ status from download package */
 		if (status) {
-			ice_debug(hw, ICE_DBG_PKG,
-				  "Pkg download failed: err %d off %d inf %d\n",
+			ice_debug(hw, ICE_DBG_PKG, "Pkg download failed: err %d off %d inf %d\n",
 				  status, offset, info);
 			err = hw->adminq.sq_last_status;
 			state = ice_map_aq_err_to_ddp_state(err);
@@ -1273,72 +1352,196 @@ static enum ice_ddp_state ice_dwnld_cfg_bufs(struct ice_hw *hw,
 			break;
 	}
 
-	if (!status) {
-		status = ice_set_vlan_mode(hw);
-		if (status)
-			ice_debug(hw, ICE_DBG_PKG,
-				  "Failed to set VLAN mode: err %d\n", status);
+	return state;
+}
+
+/**
+ * ice_download_pkg_sig_seg - download a signature segment
+ * @hw: pointer to the hardware structure
+ * @seg: pointer to signature segment
+ */
+static enum ice_ddp_state
+ice_download_pkg_sig_seg(struct ice_hw *hw, struct ice_sign_seg *seg)
+{
+	return  ice_dwnld_cfg_bufs_no_lock(hw, seg->buf_tbl.buf_array, 0,
+					   le32_to_cpu(seg->buf_tbl.buf_count),
+					   false);
+}
+
+/**
+ * ice_download_pkg_config_seg - download a config segment
+ * @hw: pointer to the hardware structure
+ * @pkg_hdr: pointer to package header
+ * @idx: segment index
+ * @start: starting buffer
+ * @count: buffer count
+ *
+ * Note: idx must reference a ICE segment
+ */
+static enum ice_ddp_state
+ice_download_pkg_config_seg(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr,
+			    u32 idx, u32 start, u32 count)
+{
+	struct ice_buf_table *bufs;
+	struct ice_seg *seg;
+	u32 buf_count;
+
+	seg = (struct ice_seg *)ice_get_pkg_seg_by_idx(pkg_hdr, idx);
+	if (!seg)
+		return ICE_DDP_PKG_ERR;
+
+	bufs = ice_find_buf_table(seg);
+	buf_count = le32_to_cpu(bufs->buf_count);
+
+	if (start >= buf_count || start + count > buf_count)
+		return ICE_DDP_PKG_ERR;
+
+	return  ice_dwnld_cfg_bufs_no_lock(hw, bufs->buf_array, start, count,
+					   true);
+}
+
+/**
+ * ice_dwnld_sign_and_cfg_segs - download a signing segment and config segment
+ * @hw: pointer to the hardware structure
+ * @pkg_hdr: pointer to package header
+ * @idx: segment index (must be a signature segment)
+ *
+ * Note: idx must reference a signature segment
+ */
+static enum ice_ddp_state
+ice_dwnld_sign_and_cfg_segs(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr,
+			    u32 idx)
+{
+	enum ice_ddp_state state;
+	struct ice_sign_seg *seg;
+	u32 conf_idx;
+	u32 start;
+	u32 count;
+
+	seg = (struct ice_sign_seg *)ice_get_pkg_seg_by_idx(pkg_hdr, idx);
+	if (!seg) {
+		state = ICE_DDP_PKG_ERR;
+		goto exit;
 	}
 
-	ice_release_global_cfg_lock(hw);
+	conf_idx = le32_to_cpu(seg->signed_seg_idx);
+	start = le32_to_cpu(seg->signed_buf_start);
+	count = le32_to_cpu(seg->signed_buf_count);
+
+	state = ice_download_pkg_sig_seg(hw, seg);
+	if (state)
+		goto exit;
+
+	state = ice_download_pkg_config_seg(hw, pkg_hdr, conf_idx, start,
+					    count);
 
+exit:
 	return state;
 }
 
 /**
- * ice_aq_get_pkg_info_list
+ * ice_match_signing_seg - determine if a matching signing segment exists
+ * @pkg_hdr: pointer to package header
+ * @seg_id: segment id that is expected
+ * @sign_type: signing type
+ */
+static bool
+ice_match_signing_seg(struct ice_pkg_hdr *pkg_hdr, u32 seg_id, u32 sign_type)
+{
+	u32 i;
+
+	for (i = 0; i < le32_to_cpu(pkg_hdr->seg_count); i++) {
+		if (ice_is_signing_seg_type_at_idx(pkg_hdr, i, seg_id,
+						   sign_type))
+			return true;
+	}
+
+	return false;
+}
+
+/**
+ * ice_post_dwnld_pkg_actions - perform post download package actions
  * @hw: pointer to the hardware structure
- * @pkg_info: the buffer which will receive the information list
- * @buf_size: the size of the pkg_info information buffer
- * @cd: pointer to command details structure or NULL
- *
- * Get Package Info List (0x0C43)
  */
-static int ice_aq_get_pkg_info_list(struct ice_hw *hw,
-				    struct ice_aqc_get_pkg_info_resp *pkg_info,
-				    u16 buf_size, struct ice_sq_cd *cd)
+static enum ice_ddp_state
+ice_post_dwnld_pkg_actions(struct ice_hw *hw)
 {
-	struct ice_aq_desc desc;
+	int status;
 
-	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_get_pkg_info_list);
+	status = ice_set_vlan_mode(hw);
+	if (status) {
+		ice_debug(hw, ICE_DBG_PKG, "Failed to set VLAN mode: err %d\n",
+			  status);
+		return ICE_DDP_PKG_ERR;
+	}
 
-	return ice_aq_send_cmd(hw, &desc, pkg_info, buf_size, cd);
+	return ICE_DDP_PKG_SUCCESS;
 }
 
 /**
  * ice_download_pkg
  * @hw: pointer to the hardware structure
- * @ice_seg: pointer to the segment of the package to be downloaded
+ * @pkg_hdr: pointer to package header
  *
  * Handles the download of a complete package.
  */
-static enum ice_ddp_state ice_download_pkg(struct ice_hw *hw,
-					   struct ice_seg *ice_seg)
+static enum ice_ddp_state
+ice_download_pkg(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr)
 {
-	struct ice_buf_table *ice_buf_tbl;
+	enum ice_aq_err aq_err = hw->adminq.sq_last_status;
+	enum ice_ddp_state state = ICE_DDP_PKG_ERR;
 	int status;
+	u32 i;
 
-	ice_debug(hw, ICE_DBG_PKG, "Segment format version: %d.%d.%d.%d\n",
-		  ice_seg->hdr.seg_format_ver.major,
-		  ice_seg->hdr.seg_format_ver.minor,
-		  ice_seg->hdr.seg_format_ver.update,
-		  ice_seg->hdr.seg_format_ver.draft);
+	ice_debug(hw, ICE_DBG_INIT, "Segment ID %d\n", hw->pkg_seg_id);
+	ice_debug(hw, ICE_DBG_INIT, "Signature type %d\n", hw->pkg_sign_type);
 
-	ice_debug(hw, ICE_DBG_PKG, "Seg: type 0x%X, size %d, name %s\n",
-		  le32_to_cpu(ice_seg->hdr.seg_type),
-		  le32_to_cpu(ice_seg->hdr.seg_size), ice_seg->hdr.seg_id);
+	status = ice_acquire_global_cfg_lock(hw, ICE_RES_WRITE);
+	if (status) {
+		if (status == -EALREADY)
+			state = ICE_DDP_PKG_ALREADY_LOADED;
+		else
+			state = ice_map_aq_err_to_ddp_state(aq_err);
+		return state;
+	}
 
-	ice_buf_tbl = ice_find_buf_table(ice_seg);
+	for (i = 0; i < le32_to_cpu(pkg_hdr->seg_count); i++) {
+		if (!ice_is_signing_seg_type_at_idx(pkg_hdr, i, hw->pkg_seg_id,
+						    hw->pkg_sign_type))
+			continue;
 
-	ice_debug(hw, ICE_DBG_PKG, "Seg buf count: %d\n",
-		  le32_to_cpu(ice_buf_tbl->buf_count));
+		state = ice_dwnld_sign_and_cfg_segs(hw, pkg_hdr, i);
+		if (state)
+			break;
+	}
 
-	status = ice_dwnld_cfg_bufs(hw, ice_buf_tbl->buf_array,
-				    le32_to_cpu(ice_buf_tbl->buf_count));
+	if (!state)
+		state = ice_post_dwnld_pkg_actions(hw);
 
+	ice_release_global_cfg_lock(hw);
 	ice_post_pkg_dwnld_vlan_mode_cfg(hw);
 
-	return status;
+	return state;
+}
+
+/**
+ * ice_aq_get_pkg_info_list
+ * @hw: pointer to the hardware structure
+ * @pkg_info: the buffer which will receive the information list
+ * @buf_size: the size of the pkg_info information buffer
+ * @cd: pointer to command details structure or NULL
+ *
+ * Get Package Info List (0x0C43)
+ */
+static int ice_aq_get_pkg_info_list(struct ice_hw *hw,
+				    struct ice_aqc_get_pkg_info_resp *pkg_info,
+				    u16 buf_size, struct ice_sq_cd *cd)
+{
+	struct ice_aq_desc desc;
+
+	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_get_pkg_info_list);
+
+	return ice_aq_send_cmd(hw, &desc, pkg_info, buf_size, cd);
 }
 
 /**
@@ -1497,6 +1700,73 @@ ice_find_seg_in_pkg(struct ice_hw *hw, u32 seg_type,
 	return NULL;
 }
 
+/**
+ * ice_has_signing_seg - determine if package has a signing segment
+ * @hw: pointer to the hardware structure
+ * @pkg_hdr: pointer to the driver's package hdr
+ */
+static bool ice_has_signing_seg(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr)
+{
+	struct ice_generic_seg_hdr *seg_hdr;
+
+	seg_hdr = (struct ice_generic_seg_hdr *)
+		ice_find_seg_in_pkg(hw, SEGMENT_TYPE_SIGNING, pkg_hdr);
+
+	return seg_hdr ? true : false;
+}
+
+/**
+ * ice_get_pkg_segment_id - get correct package segment id, based on device
+ * @mac_type: MAC type of the device
+ */
+static u32 ice_get_pkg_segment_id(enum ice_mac_type mac_type)
+{
+	u32 seg_id;
+
+	switch (mac_type) {
+	case ICE_MAC_E830:
+		seg_id = SEGMENT_TYPE_ICE_E830;
+		break;
+	case ICE_MAC_GENERIC:
+	default:
+		seg_id = SEGMENT_TYPE_ICE_E810;
+		break;
+	}
+
+	return seg_id;
+}
+
+/**
+ * ice_get_pkg_sign_type - get package segment sign type, based on device
+ * @mac_type: MAC type of the device
+ */
+static u32 ice_get_pkg_sign_type(enum ice_mac_type mac_type)
+{
+	u32 sign_type;
+
+	switch (mac_type) {
+	case ICE_MAC_E830:
+		sign_type = SEGMENT_SIGN_TYPE_RSA3K_SBB;
+		break;
+	case ICE_MAC_GENERIC:
+	default:
+		sign_type = SEGMENT_SIGN_TYPE_RSA2K;
+		break;
+	}
+
+	return sign_type;
+}
+
+/**
+ * ice_get_signing_req - get correct package requirements, based on device
+ * @hw: pointer to the hardware structure
+ */
+static void ice_get_signing_req(struct ice_hw *hw)
+{
+	hw->pkg_seg_id = ice_get_pkg_segment_id(hw->mac_type);
+	hw->pkg_sign_type = ice_get_pkg_sign_type(hw->mac_type);
+}
+
 /**
  * ice_init_pkg_info
  * @hw: pointer to the hardware structure
@@ -1512,7 +1782,14 @@ static enum ice_ddp_state ice_init_pkg_info(struct ice_hw *hw,
 	if (!pkg_hdr)
 		return ICE_DDP_PKG_ERR;
 
-	seg_hdr = ice_find_seg_in_pkg(hw, SEGMENT_TYPE_ICE, pkg_hdr);
+	hw->pkg_has_signing_seg = ice_has_signing_seg(hw, pkg_hdr);
+	ice_get_signing_req(hw);
+
+	ice_debug(hw, ICE_DBG_INIT, "Pkg using segment id: 0x%08X\n",
+		  hw->pkg_seg_id);
+
+	seg_hdr = (struct ice_generic_seg_hdr *)
+		ice_find_seg_in_pkg(hw, hw->pkg_seg_id, pkg_hdr);
 	if (seg_hdr) {
 		struct ice_meta_sect *meta;
 		struct ice_pkg_enum state;
@@ -1635,7 +1912,7 @@ static enum ice_ddp_state ice_chk_pkg_compat(struct ice_hw *hw,
 	}
 
 	/* find ICE segment in given package */
-	*seg = (struct ice_seg *)ice_find_seg_in_pkg(hw, SEGMENT_TYPE_ICE,
+	*seg = (struct ice_seg *)ice_find_seg_in_pkg(hw, hw->pkg_seg_id,
 						     ospkg);
 	if (!*seg) {
 		ice_debug(hw, ICE_DBG_INIT, "no ice segment in package.\n");
@@ -1809,6 +2086,11 @@ enum ice_ddp_state ice_init_pkg(struct ice_hw *hw, u8 *buf, u32 len)
 	if (state)
 		return state;
 
+	/* must be a matching segment */
+	if (hw->pkg_has_signing_seg &&
+	    !ice_match_signing_seg(pkg, hw->pkg_seg_id, hw->pkg_sign_type))
+		return ICE_DDP_PKG_ERR;
+
 	/* before downloading the package, check package version for
 	 * compatibility with driver
 	 */
@@ -1818,7 +2100,7 @@ enum ice_ddp_state ice_init_pkg(struct ice_hw *hw, u8 *buf, u32 len)
 
 	/* initialize package hints and then download package */
 	ice_init_pkg_hints(hw, seg);
-	state = ice_download_pkg(hw, seg);
+	state = ice_download_pkg(hw, pkg);
 	if (state == ICE_DDP_PKG_ALREADY_LOADED) {
 		ice_debug(hw, ICE_DBG_INIT,
 			  "package previously loaded - no work.\n");
diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.h b/drivers/net/ethernet/intel/ice/ice_ddp.h
index abb5f32f2ef4..ff66c2ffb1a2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.h
@@ -98,10 +98,21 @@ struct ice_pkg_hdr {
 	__le32 seg_offset[];
 };
 
+/* Package signing algorithm types */
+#define SEGMENT_SIGN_TYPE_INVALID	0x00000000
+#define SEGMENT_SIGN_TYPE_RSA2K		0x00000001
+#define SEGMENT_SIGN_TYPE_RSA3K		0x00000002
+#define SEGMENT_SIGN_TYPE_RSA3K_SBB	0x00000003 /* Secure Boot Block */
+#define SEGMENT_SIGN_TYPE_RSA3K_E825	0x00000005
+
 /* generic segment */
 struct ice_generic_seg_hdr {
-#define SEGMENT_TYPE_METADATA 0x00000001
-#define SEGMENT_TYPE_ICE 0x00000010
+#define SEGMENT_TYPE_INVALID	0x00000000
+#define SEGMENT_TYPE_METADATA	0x00000001
+#define SEGMENT_TYPE_ICE_E810	0x00000010
+#define SEGMENT_TYPE_SIGNING	0x00001001
+#define SEGMENT_TYPE_ICE_RUN_TIME_CFG 0x00000020
+#define SEGMENT_TYPE_ICE_E830	0x00000017
 	__le32 seg_type;
 	struct ice_pkg_ver seg_format_ver;
 	__le32 seg_size;
@@ -163,6 +174,18 @@ struct ice_global_metadata_seg {
 #define ICE_MIN_S_SZ 1
 #define ICE_MAX_S_SZ 4084
 
+struct ice_sign_seg {
+	struct ice_generic_seg_hdr hdr;
+	__le32 seg_id;
+	__le32 sign_type;
+	__le32 signed_seg_idx;
+	__le32 signed_buf_start;
+	__le32 signed_buf_count;
+#define ICE_SIGN_SEG_RESERVED_COUNT	44
+	u8 reserved[ICE_SIGN_SEG_RESERVED_COUNT];
+	struct ice_buf_table buf_tbl;
+};
+
 /* section information */
 struct ice_section_entry {
 	__le32 type;
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 35ee5b29ea34..63fa84368e6b 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -912,7 +912,10 @@ struct ice_hw {
 
 	/* Active package version (currently active) */
 	struct ice_pkg_ver active_pkg_ver;
+	u32 pkg_seg_id;
+	u32 pkg_sign_type;
 	u32 active_track_id;
+	u8 pkg_has_signing_seg:1;
 	u8 active_pkg_name[ICE_PKG_NAME_SIZE];
 	u8 active_pkg_in_nvm;
 
-- 
2.37.3


