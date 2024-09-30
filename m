Return-Path: <netdev+bounces-130642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4D398AFF6
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 00:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED8B1F21BF1
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E18199EB1;
	Mon, 30 Sep 2024 22:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a9dxUS2S"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52EA18C92A
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 22:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727735771; cv=none; b=Bt2l1s5XfdehyfRZ+yUH90m17fpybKqgGi5rsPGJpWyCTKll74XKIsmWJ5ebKLNii2BDdZd809jNItJ/LD5Z0sa8OS7F6xGrd+yvnO1G5TTUfiQoCcvm1rhbW9i4kbuYrLymb2wS+v2dtwXKi+8TVRzdvqWRks1jByLkDnhwgiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727735771; c=relaxed/simple;
	bh=CYH6YMsYN5AMSQ4NsPFmFsVzG3bKFhKvc6NV0JWR8H8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aVT5o0msCZm/CasLKiUArJeqJeXpK+CvH1jYzItGA8gLej8HF49FBhIkUVA6xp3mFFQ2dPRCP3G8QaUomdXnvk9G415OjgVJBON5pdDhGVpVNtJomjTgdOD7NG8bjCmbrsy8hZsJ2lgvo8B2ZCVzL83cofYYYIySnHVmHeE8T0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a9dxUS2S; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727735770; x=1759271770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CYH6YMsYN5AMSQ4NsPFmFsVzG3bKFhKvc6NV0JWR8H8=;
  b=a9dxUS2SuB2i4+xsEUYzcp7bHgXyxY3kEgFVc0H9OlKqEMqqGu1NDSyp
   SLY74+oS0q2JRkRPaPJ7R78fdqYWnocOvGrzg0TIS77x46RY94gzIjki2
   7h4mXWWPezbtpoEgYC31u9k/jC5iqG2RC5S5kTkWnLNpOfqRvneKjyaRY
   mCaWHDL/4ECi1KiHmQxEEnzSdA9R7aqj70AR9Yf5dmWz0ipztQ8ih+w6P
   dl5vRoVj1e0EDhBD7MDTtcDo47edwelGhqYxZyHSYqWSTA95MfNcaYPjh
   Mz0Nge4ypLBS8CgwqU7FezqvpOBykiTqob6khU5L1mDwscmf5tPVCy7IK
   Q==;
X-CSE-ConnectionGUID: AkyomwUJRNOLP/z/1rBnbg==
X-CSE-MsgGUID: R+9o9EF6TDaGAve1hpxAhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="30734879"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="30734879"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 15:36:06 -0700
X-CSE-ConnectionGUID: 4G/8+ISNSMurCrFOQXDrgg==
X-CSE-MsgGUID: pGEw6KpmQW+R0bN0ye34bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="73496620"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 30 Sep 2024 15:36:07 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [PATCH net 05/10] ice: fix memleak in ice_init_tx_topology()
Date: Mon, 30 Sep 2024 15:35:52 -0700
Message-ID: <20240930223601.3137464-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20240930223601.3137464-1-anthony.l.nguyen@intel.com>
References: <20240930223601.3137464-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Fix leak of the FW blob (DDP pkg).

Make ice_cfg_tx_topo() const-correct, so ice_init_tx_topology() can avoid
copying whole FW blob. Copy just the topology section, and only when
needed. Reuse the buffer allocated for the read of the current topology.

This was found by kmemleak, with the following trace for each PF:
    [<ffffffff8761044d>] kmemdup_noprof+0x1d/0x50
    [<ffffffffc0a0a480>] ice_init_ddp_config+0x100/0x220 [ice]
    [<ffffffffc0a0da7f>] ice_init_dev+0x6f/0x200 [ice]
    [<ffffffffc0a0dc49>] ice_init+0x29/0x560 [ice]
    [<ffffffffc0a10c1d>] ice_probe+0x21d/0x310 [ice]

Constify ice_cfg_tx_topo() @buf parameter.
This cascades further down to few more functions.

Fixes: cc5776fe1832 ("ice: Enable switching default Tx scheduler topology")
CC: Larysa Zaremba <larysa.zaremba@intel.com>
CC: Jacob Keller <jacob.e.keller@intel.com>
CC: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
CC: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ddp.c  | 58 +++++++++++------------
 drivers/net/ethernet/intel/ice/ice_ddp.h  |  4 +-
 drivers/net/ethernet/intel/ice/ice_main.c |  8 +---
 3 files changed, 31 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index 953262b88a58..272fd823a825 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -31,7 +31,7 @@ static const struct ice_tunnel_type_scan tnls[] = {
  * Verifies various attributes of the package file, including length, format
  * version, and the requirement of at least one segment.
  */
-static enum ice_ddp_state ice_verify_pkg(struct ice_pkg_hdr *pkg, u32 len)
+static enum ice_ddp_state ice_verify_pkg(const struct ice_pkg_hdr *pkg, u32 len)
 {
 	u32 seg_count;
 	u32 i;
@@ -57,13 +57,13 @@ static enum ice_ddp_state ice_verify_pkg(struct ice_pkg_hdr *pkg, u32 len)
 	/* all segments must fit within length */
 	for (i = 0; i < seg_count; i++) {
 		u32 off = le32_to_cpu(pkg->seg_offset[i]);
-		struct ice_generic_seg_hdr *seg;
+		const struct ice_generic_seg_hdr *seg;
 
 		/* segment header must fit */
 		if (len < off + sizeof(*seg))
 			return ICE_DDP_PKG_INVALID_FILE;
 
-		seg = (struct ice_generic_seg_hdr *)((u8 *)pkg + off);
+		seg = (void *)pkg + off;
 
 		/* segment body must fit */
 		if (len < off + le32_to_cpu(seg->seg_size))
@@ -119,13 +119,13 @@ static enum ice_ddp_state ice_chk_pkg_version(struct ice_pkg_ver *pkg_ver)
  *
  * This helper function validates a buffer's header.
  */
-static struct ice_buf_hdr *ice_pkg_val_buf(struct ice_buf *buf)
+static const struct ice_buf_hdr *ice_pkg_val_buf(const struct ice_buf *buf)
 {
-	struct ice_buf_hdr *hdr;
+	const struct ice_buf_hdr *hdr;
 	u16 section_count;
 	u16 data_end;
 
-	hdr = (struct ice_buf_hdr *)buf->buf;
+	hdr = (const struct ice_buf_hdr *)buf->buf;
 	/* verify data */
 	section_count = le16_to_cpu(hdr->section_count);
 	if (section_count < ICE_MIN_S_COUNT || section_count > ICE_MAX_S_COUNT)
@@ -165,8 +165,8 @@ static struct ice_buf_table *ice_find_buf_table(struct ice_seg *ice_seg)
  * unexpected value has been detected (for example an invalid section count or
  * an invalid buffer end value).
  */
-static struct ice_buf_hdr *ice_pkg_enum_buf(struct ice_seg *ice_seg,
-					    struct ice_pkg_enum *state)
+static const struct ice_buf_hdr *ice_pkg_enum_buf(struct ice_seg *ice_seg,
+						  struct ice_pkg_enum *state)
 {
 	if (ice_seg) {
 		state->buf_table = ice_find_buf_table(ice_seg);
@@ -1800,9 +1800,9 @@ int ice_update_pkg(struct ice_hw *hw, struct ice_buf *bufs, u32 count)
  * success it returns a pointer to the segment header, otherwise it will
  * return NULL.
  */
-static struct ice_generic_seg_hdr *
+static const struct ice_generic_seg_hdr *
 ice_find_seg_in_pkg(struct ice_hw *hw, u32 seg_type,
-		    struct ice_pkg_hdr *pkg_hdr)
+		    const struct ice_pkg_hdr *pkg_hdr)
 {
 	u32 i;
 
@@ -1813,11 +1813,9 @@ ice_find_seg_in_pkg(struct ice_hw *hw, u32 seg_type,
 
 	/* Search all package segments for the requested segment type */
 	for (i = 0; i < le32_to_cpu(pkg_hdr->seg_count); i++) {
-		struct ice_generic_seg_hdr *seg;
+		const struct ice_generic_seg_hdr *seg;
 
-		seg = (struct ice_generic_seg_hdr
-			       *)((u8 *)pkg_hdr +
-				  le32_to_cpu(pkg_hdr->seg_offset[i]));
+		seg = (void *)pkg_hdr + le32_to_cpu(pkg_hdr->seg_offset[i]);
 
 		if (le32_to_cpu(seg->seg_type) == seg_type)
 			return seg;
@@ -2354,12 +2352,12 @@ ice_get_set_tx_topo(struct ice_hw *hw, u8 *buf, u16 buf_size,
  *
  * Return: zero when update was successful, negative values otherwise.
  */
-int ice_cfg_tx_topo(struct ice_hw *hw, u8 *buf, u32 len)
+int ice_cfg_tx_topo(struct ice_hw *hw, const void *buf, u32 len)
 {
-	u8 *current_topo, *new_topo = NULL;
-	struct ice_run_time_cfg_seg *seg;
-	struct ice_buf_hdr *section;
-	struct ice_pkg_hdr *pkg_hdr;
+	u8 *new_topo = NULL, *topo __free(kfree) = NULL;
+	const struct ice_run_time_cfg_seg *seg;
+	const struct ice_buf_hdr *section;
+	const struct ice_pkg_hdr *pkg_hdr;
 	enum ice_ddp_state state;
 	u16 offset, size = 0;
 	u32 reg = 0;
@@ -2375,15 +2373,13 @@ int ice_cfg_tx_topo(struct ice_hw *hw, u8 *buf, u32 len)
 		return -EOPNOTSUPP;
 	}
 
-	current_topo = kzalloc(ICE_AQ_MAX_BUF_LEN, GFP_KERNEL);
-	if (!current_topo)
+	topo = kzalloc(ICE_AQ_MAX_BUF_LEN, GFP_KERNEL);
+	if (!topo)
 		return -ENOMEM;
 
-	/* Get the current Tx topology */
-	status = ice_get_set_tx_topo(hw, current_topo, ICE_AQ_MAX_BUF_LEN, NULL,
-				     &flags, false);
-
-	kfree(current_topo);
+	/* Get the current Tx topology flags */
+	status = ice_get_set_tx_topo(hw, topo, ICE_AQ_MAX_BUF_LEN, NULL, &flags,
+				     false);
 
 	if (status) {
 		ice_debug(hw, ICE_DBG_INIT, "Get current topology is failed\n");
@@ -2419,7 +2415,7 @@ int ice_cfg_tx_topo(struct ice_hw *hw, u8 *buf, u32 len)
 		goto update_topo;
 	}
 
-	pkg_hdr = (struct ice_pkg_hdr *)buf;
+	pkg_hdr = (const struct ice_pkg_hdr *)buf;
 	state = ice_verify_pkg(pkg_hdr, len);
 	if (state) {
 		ice_debug(hw, ICE_DBG_INIT, "Failed to verify pkg (err: %d)\n",
@@ -2428,7 +2424,7 @@ int ice_cfg_tx_topo(struct ice_hw *hw, u8 *buf, u32 len)
 	}
 
 	/* Find runtime configuration segment */
-	seg = (struct ice_run_time_cfg_seg *)
+	seg = (const struct ice_run_time_cfg_seg *)
 	      ice_find_seg_in_pkg(hw, SEGMENT_TYPE_ICE_RUN_TIME_CFG, pkg_hdr);
 	if (!seg) {
 		ice_debug(hw, ICE_DBG_INIT, "5 layer topology segment is missing\n");
@@ -2461,8 +2457,10 @@ int ice_cfg_tx_topo(struct ice_hw *hw, u8 *buf, u32 len)
 		return -EIO;
 	}
 
-	/* Get the new topology buffer */
-	new_topo = ((u8 *)section) + offset;
+	/* Get the new topology buffer, reuse current topo copy mem */
+	static_assert(ICE_PKG_BUF_SIZE == ICE_AQ_MAX_BUF_LEN);
+	new_topo = topo;
+	memcpy(new_topo, (u8 *)section + offset, size);
 
 update_topo:
 	/* Acquire global lock to make sure that set topology issued
diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.h b/drivers/net/ethernet/intel/ice/ice_ddp.h
index 97f272317475..79551da2a4b0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.h
@@ -438,7 +438,7 @@ struct ice_pkg_enum {
 	u32 buf_idx;
 
 	u32 type;
-	struct ice_buf_hdr *buf;
+	const struct ice_buf_hdr *buf;
 	u32 sect_idx;
 	void *sect;
 	u32 sect_type;
@@ -467,6 +467,6 @@ ice_pkg_enum_entry(struct ice_seg *ice_seg, struct ice_pkg_enum *state,
 void *ice_pkg_enum_section(struct ice_seg *ice_seg, struct ice_pkg_enum *state,
 			   u32 sect_type);
 
-int ice_cfg_tx_topo(struct ice_hw *hw, u8 *buf, u32 len);
+int ice_cfg_tx_topo(struct ice_hw *hw, const void *buf, u32 len);
 
 #endif
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index eeb48cc48e08..fbab72fab79c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4536,16 +4536,10 @@ ice_init_tx_topology(struct ice_hw *hw, const struct firmware *firmware)
 	u8 num_tx_sched_layers = hw->num_tx_sched_layers;
 	struct ice_pf *pf = hw->back;
 	struct device *dev;
-	u8 *buf_copy;
 	int err;
 
 	dev = ice_pf_to_dev(pf);
-	/* ice_cfg_tx_topo buf argument is not a constant,
-	 * so we have to make a copy
-	 */
-	buf_copy = kmemdup(firmware->data, firmware->size, GFP_KERNEL);
-
-	err = ice_cfg_tx_topo(hw, buf_copy, firmware->size);
+	err = ice_cfg_tx_topo(hw, firmware->data, firmware->size);
 	if (!err) {
 		if (hw->num_tx_sched_layers > num_tx_sched_layers)
 			dev_info(dev, "Tx scheduling layers switching feature disabled\n");
-- 
2.42.0


