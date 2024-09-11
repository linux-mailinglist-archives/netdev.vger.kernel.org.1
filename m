Return-Path: <netdev+bounces-127327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0687997507C
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77924B25969
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8D9186287;
	Wed, 11 Sep 2024 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gDtCS8bI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051B5185B65
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 11:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726052995; cv=none; b=FH8gS1itOUjjfxvFb184nypepPZmukkWKVajeMCMUPzPqBXd+Vgj7DiNRXtbBzflfRLHWnbV3KgwyruEjV59qcTuw3tNz1LJMYSIkUfdYHao0+35mTeu8G8kIRBdfm4XrOg6x0uHasTEY8juQ8MW2lJyq96H7AH5a5JJr6D5Mg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726052995; c=relaxed/simple;
	bh=nglqcRBydyDV/l2rB3MBpbbcLaOg3YIEjfFVGt93nfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lgy0axxwpMNBpPjIqlnRVc14pQui16SILQgeY3Mivzw/nk7pnfnX/Ve4t/PfyuPLb89NMJy6Tj6WXGNEwE0BOJR5RCaWyroBMNDmI1J4xfE3o0yd03LS3MqQxN8IfdnNcIjvMk4sXADw8bo6Ck4lfC8SdCvExqXlayJ9k0kNj3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gDtCS8bI; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726052993; x=1757588993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nglqcRBydyDV/l2rB3MBpbbcLaOg3YIEjfFVGt93nfk=;
  b=gDtCS8bIaB4KO84t3OW9qfx1veEGf1SfX8FMJVETrKbqhtikwzCMXwmp
   NnSyVMbhBAlU9E6BxUrM/VzLpHcg7B50VZkd5KffJaiqfq/RLxNu9cf3+
   B3z0P/yKZByLQ+Fwg4Jp5vg7n1ALV8RmdJgPTSEEqT6cVDOWZRfkQZCLZ
   z+U7WVmogiH54y67LJZlZnXV5QXirGcveNLl/Ghvi/onVL08HFQ3foFWK
   /qaHcpVAf8Ak6BLgx3Ca34Vo41ORqMEjuTDdY76/kPzXXfspJzrxDWe9D
   a/fjXLpqMZN4MesD/VWFxEJdXXk/zQeWg5nReGiwjAI6AZq7D/IoCcEWo
   g==;
X-CSE-ConnectionGUID: /NqechUkTpqWiUugSntJWw==
X-CSE-MsgGUID: nldlh/L5Qnio8eBokpgvkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35437565"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="35437565"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:09:52 -0700
X-CSE-ConnectionGUID: 5hhO8zdES6upw192l4bL2Q==
X-CSE-MsgGUID: HhBPlh0RSTCyC0kWVppc+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67352982"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa009.fm.intel.com with ESMTP; 11 Sep 2024 04:09:50 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.145])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id BA06A27BC4;
	Wed, 11 Sep 2024 12:09:48 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Dan Nowlin <dan.nowlin@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next 1/2] ice: refactor "last" segment of DDP pkg
Date: Wed, 11 Sep 2024 13:07:32 +0200
Message-ID: <20240911110926.25384-5-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911110926.25384-4-przemyslaw.kitszel@intel.com>
References: <20240911110926.25384-4-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ice_ddp_send_hunk() that buffers "sent FW hunk" calls to AQ in order
to mark the "last" one in more elegant way. Next commit will add even
more complicated "sent FW" flow, so it's better to untangle a bit before.

Note that metadata buffers were not skipped for NOT-@indicate_last
segments, this is fixed now.

Minor:
 + use ice_is_buffer_metadata() instead of open coding it in
   ice_dwnld_cfg_bufs();
 + ice_dwnld_cfg_bufs_no_lock() + dependencies were moved up a bit to have
   better git-diff, as this function was rewritten (in terms of git-blame)

CC: Paul Greenwalt <paul.greenwalt@intel.com>
CC: Dan Nowlin <dan.nowlin@intel.com>
CC: Ahmed Zaki <ahmed.zaki@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
git: --inter-hunk-context=6
---
 drivers/net/ethernet/intel/ice/ice_ddp.c | 280 ++++++++++++-----------
 1 file changed, 145 insertions(+), 135 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index 953262b88a58..9ec5f9cee466 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -1210,6 +1210,127 @@ ice_aq_download_pkg(struct ice_hw *hw, struct ice_buf_hdr *pkg_buf,
 	return status;
 }
 
+/**
+ * ice_is_buffer_metadata - determine if package buffer is a metadata buffer
+ * @buf: pointer to buffer header
+ * Return: whether given @buf is a metadata one.
+ */
+static bool ice_is_buffer_metadata(struct ice_buf_hdr *buf)
+{
+	return le32_to_cpu(buf->section_entry[0].type) & ICE_METADATA_BUF;
+}
+
+/**
+ * struct ice_ddp_send_ctx - sending context of current DDP segment
+ * @hw: pointer to the hardware struct
+ *
+ * Keeps current sending state (header, error) for the purpose of proper "last"
+ * bit settting in ice_aq_download_pkg(). Use via calls to ice_ddp_send_hunk().
+ */
+struct ice_ddp_send_ctx {
+	struct ice_hw *hw;
+/* private: only for ice_ddp_send_hunk() */
+	struct ice_buf_hdr *hdr;
+	int err;
+};
+
+/**
+ * ice_ddp_send_hunk - send one hunk of data to FW
+ * @ctx: current segment sending context
+ * @hunk: next hunk to send, size is always ICE_PKG_BUF_SIZE
+ *
+ * Send the next hunk of data to FW, retrying if needed.
+ *
+ * Notice: must be called once more with a NULL @hunk to finish up; such call
+ * will set up the "last" bit of an AQ request. After such call @ctx.hdr is
+ * cleared, @hw is still valid.
+ *
+ * Return: %ICE_DDP_PKG_SUCCESS if there were no problems; a sticky @err
+ *         otherwise.
+ */
+static enum ice_ddp_state ice_ddp_send_hunk(struct ice_ddp_send_ctx *ctx,
+					    struct ice_buf_hdr *hunk)
+{
+	struct ice_buf_hdr *prev_hunk = ctx->hdr;
+	struct ice_hw *hw = ctx->hw;
+	bool prev_was_last = !hunk;
+	enum ice_aq_err aq_err;
+	u32 offset, info;
+	int attempt, err;
+
+	if (ctx->err)
+		return ctx->err;
+
+	ctx->hdr = hunk;
+	if (!prev_hunk)
+		return ICE_DDP_PKG_SUCCESS; /* no problem so far */
+
+	for (attempt = 0; attempt < 5; attempt++) {
+		if (attempt)
+			msleep(20);
+
+		err = ice_aq_download_pkg(hw, prev_hunk, ICE_PKG_BUF_SIZE,
+					  prev_was_last, &offset, &info, NULL);
+
+		aq_err = hw->adminq.sq_last_status;
+		if (aq_err != ICE_AQ_RC_ENOSEC && aq_err != ICE_AQ_RC_EBADSIG)
+			break;
+	}
+
+	if (err) {
+		ice_debug(hw, ICE_DBG_PKG, "Pkg download failed: err %d off %d inf %d\n",
+			  err, offset, info);
+		ctx->err = ice_map_aq_err_to_ddp_state(aq_err);
+	} else if (attempt) {
+		dev_dbg(ice_hw_to_dev(hw),
+			"ice_aq_download_pkg number of retries: %d\n", attempt);
+	}
+
+	return ctx->err;
+}
+
+/**
+ * ice_dwnld_cfg_bufs_no_lock
+ * @ctx: context of the current buffers section to send
+ * @bufs: pointer to an array of buffers
+ * @start: buffer index of first buffer to download
+ * @count: the number of buffers to download
+ *
+ * Downloads package configuration buffers to the firmware. Metadata buffers
+ * are skipped, and the first metadata buffer found indicates that the rest
+ * of the buffers are all metadata buffers.
+ */
+static enum ice_ddp_state
+ice_dwnld_cfg_bufs_no_lock(struct ice_ddp_send_ctx *ctx, struct ice_buf *bufs,
+			   u32 start, u32 count)
+{
+	struct ice_buf_hdr *bh;
+	enum ice_ddp_state err;
+
+	if (!bufs || !count) {
+		ctx->err = ICE_DDP_PKG_ERR;
+		return ctx->err;
+	}
+
+	bufs += start;
+	bh = (struct ice_buf_hdr *)bufs;
+
+	for (int i = 0; i < count; i++, bufs++) {
+		bh = (struct ice_buf_hdr *)bufs;
+		/* Metadata buffers should not be sent to FW,
+		 * their presence means "we are done here".
+		 */
+		if (ice_is_buffer_metadata(bh))
+			break;
+
+		err = ice_ddp_send_hunk(ctx, bh);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 /**
  * ice_get_pkg_seg_by_idx
  * @pkg_hdr: pointer to the package header to be searched
@@ -1269,147 +1390,32 @@ ice_is_signing_seg_type_at_idx(struct ice_pkg_hdr *pkg_hdr, u32 idx,
 	return false;
 }
 
-/**
- * ice_is_buffer_metadata - determine if package buffer is a metadata buffer
- * @buf: pointer to buffer header
- */
-static bool ice_is_buffer_metadata(struct ice_buf_hdr *buf)
-{
-	if (le32_to_cpu(buf->section_entry[0].type) & ICE_METADATA_BUF)
-		return true;
-
-	return false;
-}
-
-/**
- * ice_is_last_download_buffer
- * @buf: pointer to current buffer header
- * @idx: index of the buffer in the current sequence
- * @count: the buffer count in the current sequence
- *
- * Note: this routine should only be called if the buffer is not the last buffer
- */
-static bool
-ice_is_last_download_buffer(struct ice_buf_hdr *buf, u32 idx, u32 count)
-{
-	struct ice_buf *next_buf;
-
-	if ((idx + 1) == count)
-		return true;
-
-	/* A set metadata flag in the next buffer will signal that the current
-	 * buffer will be the last buffer downloaded
-	 */
-	next_buf = ((struct ice_buf *)buf) + 1;
-
-	return ice_is_buffer_metadata((struct ice_buf_hdr *)next_buf);
-}
-
-/**
- * ice_dwnld_cfg_bufs_no_lock
- * @hw: pointer to the hardware structure
- * @bufs: pointer to an array of buffers
- * @start: buffer index of first buffer to download
- * @count: the number of buffers to download
- * @indicate_last: if true, then set last buffer flag on last buffer download
- *
- * Downloads package configuration buffers to the firmware. Metadata buffers
- * are skipped, and the first metadata buffer found indicates that the rest
- * of the buffers are all metadata buffers.
- */
-static enum ice_ddp_state
-ice_dwnld_cfg_bufs_no_lock(struct ice_hw *hw, struct ice_buf *bufs, u32 start,
-			   u32 count, bool indicate_last)
-{
-	enum ice_ddp_state state = ICE_DDP_PKG_SUCCESS;
-	struct ice_buf_hdr *bh;
-	enum ice_aq_err err;
-	u32 offset, info, i;
-
-	if (!bufs || !count)
-		return ICE_DDP_PKG_ERR;
-
-	/* If the first buffer's first section has its metadata bit set
-	 * then there are no buffers to be downloaded, and the operation is
-	 * considered a success.
-	 */
-	bh = (struct ice_buf_hdr *)(bufs + start);
-	if (le32_to_cpu(bh->section_entry[0].type) & ICE_METADATA_BUF)
-		return ICE_DDP_PKG_SUCCESS;
-
-	for (i = 0; i < count; i++) {
-		bool last = false;
-		int try_cnt = 0;
-		int status;
-
-		bh = (struct ice_buf_hdr *)(bufs + start + i);
-
-		if (indicate_last)
-			last = ice_is_last_download_buffer(bh, i, count);
-
-		while (1) {
-			status = ice_aq_download_pkg(hw, bh, ICE_PKG_BUF_SIZE,
-						     last, &offset, &info,
-						     NULL);
-			if (hw->adminq.sq_last_status != ICE_AQ_RC_ENOSEC &&
-			    hw->adminq.sq_last_status != ICE_AQ_RC_EBADSIG)
-				break;
-
-			try_cnt++;
-
-			if (try_cnt == 5)
-				break;
-
-			msleep(20);
-		}
-
-		if (try_cnt)
-			dev_dbg(ice_hw_to_dev(hw),
-				"ice_aq_download_pkg number of retries: %d\n",
-				try_cnt);
-
-		/* Save AQ status from download package */
-		if (status) {
-			ice_debug(hw, ICE_DBG_PKG, "Pkg download failed: err %d off %d inf %d\n",
-				  status, offset, info);
-			err = hw->adminq.sq_last_status;
-			state = ice_map_aq_err_to_ddp_state(err);
-			break;
-		}
-
-		if (last)
-			break;
-	}
-
-	return state;
-}
-
 /**
  * ice_download_pkg_sig_seg - download a signature segment
- * @hw: pointer to the hardware structure
+ * @ctx: context of the current buffers section to send
  * @seg: pointer to signature segment
  */
 static enum ice_ddp_state
-ice_download_pkg_sig_seg(struct ice_hw *hw, struct ice_sign_seg *seg)
+ice_download_pkg_sig_seg(struct ice_ddp_send_ctx *ctx, struct ice_sign_seg *seg)
 {
-	return  ice_dwnld_cfg_bufs_no_lock(hw, seg->buf_tbl.buf_array, 0,
-					   le32_to_cpu(seg->buf_tbl.buf_count),
-					   false);
+	return ice_dwnld_cfg_bufs_no_lock(ctx, seg->buf_tbl.buf_array, 0,
+					  le32_to_cpu(seg->buf_tbl.buf_count));
 }
 
 /**
  * ice_download_pkg_config_seg - download a config segment
- * @hw: pointer to the hardware structure
+ * @ctx: context of the current buffers section to send
  * @pkg_hdr: pointer to package header
  * @idx: segment index
  * @start: starting buffer
  * @count: buffer count
  *
  * Note: idx must reference a ICE segment
  */
 static enum ice_ddp_state
-ice_download_pkg_config_seg(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr,
-			    u32 idx, u32 start, u32 count)
+ice_download_pkg_config_seg(struct ice_ddp_send_ctx *ctx,
+			    struct ice_pkg_hdr *pkg_hdr, u32 idx, u32 start,
+			    u32 count)
 {
 	struct ice_buf_table *bufs;
 	struct ice_seg *seg;
@@ -1425,21 +1431,20 @@ ice_download_pkg_config_seg(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr,
 	if (start >= buf_count || start + count > buf_count)
 		return ICE_DDP_PKG_ERR;
 
-	return  ice_dwnld_cfg_bufs_no_lock(hw, bufs->buf_array, start, count,
-					   true);
+	return ice_dwnld_cfg_bufs_no_lock(ctx, bufs->buf_array, start, count);
 }
 
 /**
  * ice_dwnld_sign_and_cfg_segs - download a signing segment and config segment
- * @hw: pointer to the hardware structure
+ * @ctx: context of the current buffers section to send
  * @pkg_hdr: pointer to package header
  * @idx: segment index (must be a signature segment)
  *
  * Note: idx must reference a signature segment
  */
 static enum ice_ddp_state
-ice_dwnld_sign_and_cfg_segs(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr,
-			    u32 idx)
+ice_dwnld_sign_and_cfg_segs(struct ice_ddp_send_ctx *ctx,
+			    struct ice_pkg_hdr *pkg_hdr, u32 idx)
 {
 	enum ice_ddp_state state;
 	struct ice_sign_seg *seg;
@@ -1454,17 +1459,16 @@ ice_dwnld_sign_and_cfg_segs(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr,
 	}
 
 	count = le32_to_cpu(seg->signed_buf_count);
-	state = ice_download_pkg_sig_seg(hw, seg);
+	state = ice_download_pkg_sig_seg(ctx, seg);
 	if (state || !count)
 		goto exit;
 
 	conf_idx = le32_to_cpu(seg->signed_seg_idx);
 	start = le32_to_cpu(seg->signed_buf_start);
 
-	state = ice_download_pkg_config_seg(hw, pkg_hdr, conf_idx, start,
-					    count);
-
+	return ice_download_pkg_config_seg(ctx, pkg_hdr, conf_idx, start, count);
 exit:
+	ctx->err = state;
 	return state;
 }
 
@@ -1519,6 +1523,7 @@ ice_download_pkg_with_sig_seg(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr)
 {
 	enum ice_aq_err aq_err = hw->adminq.sq_last_status;
 	enum ice_ddp_state state = ICE_DDP_PKG_ERR;
+	struct ice_ddp_send_ctx ctx = { .hw = hw };
 	int status;
 	u32 i;
 
@@ -1539,7 +1544,9 @@ ice_download_pkg_with_sig_seg(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr)
 						    hw->pkg_sign_type))
 			continue;
 
-		state = ice_dwnld_sign_and_cfg_segs(hw, pkg_hdr, i);
+		ice_dwnld_sign_and_cfg_segs(&ctx, pkg_hdr, i);
+		/* finish up by sending last hunk with "last" flag set */
+		state = ice_ddp_send_hunk(&ctx, NULL);
 		if (state)
 			break;
 	}
@@ -1564,6 +1571,7 @@ ice_download_pkg_with_sig_seg(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr)
 static enum ice_ddp_state
 ice_dwnld_cfg_bufs(struct ice_hw *hw, struct ice_buf *bufs, u32 count)
 {
+	struct ice_ddp_send_ctx ctx = { .hw = hw };
 	enum ice_ddp_state state;
 	struct ice_buf_hdr *bh;
 	int status;
@@ -1576,17 +1584,19 @@ ice_dwnld_cfg_bufs(struct ice_hw *hw, struct ice_buf *bufs, u32 count)
 	 * considered a success.
 	 */
 	bh = (struct ice_buf_hdr *)bufs;
-	if (le32_to_cpu(bh->section_entry[0].type) & ICE_METADATA_BUF)
+	if (ice_is_buffer_metadata(bh))
 		return ICE_DDP_PKG_SUCCESS;
 
 	status = ice_acquire_global_cfg_lock(hw, ICE_RES_WRITE);
 	if (status) {
 		if (status == -EALREADY)
 			return ICE_DDP_PKG_ALREADY_LOADED;
 		return ice_map_aq_err_to_ddp_state(hw->adminq.sq_last_status);
 	}
 
-	state = ice_dwnld_cfg_bufs_no_lock(hw, bufs, 0, count, true);
+	ice_dwnld_cfg_bufs_no_lock(&ctx, bufs, 0, count);
+	/* finish up by sending last hunk with "last" flag set */
+	state = ice_ddp_send_hunk(&ctx, NULL);
 	if (!state)
 		state = ice_post_dwnld_pkg_actions(hw);
 
-- 
2.46.0


