Return-Path: <netdev+bounces-127328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D46E97507D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEF42B23B41
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96915186E4F;
	Wed, 11 Sep 2024 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SVYzPQcd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EF3186609
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726052995; cv=none; b=hUj/Oq/AaQQs78kJA3HZGsjg0ydyJ6/NJzWIaNP8XmFDfGHLcLhhjwFdzgnuk8Y22yZcKNOKUCw5G3cywhsHlqWmgUp4CSSK04cp8SpBgK0q0PmATmTxzh1ZrxSmp/MiqAseZfZxyVPuQHk57LjUytuMyFqmGRbLO/YgKUETbrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726052995; c=relaxed/simple;
	bh=soybigFmIlSrs1R3ou7FRmrWnLzOIypKD01PIh46pW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ak3yKR3kDpyJmyq09hSf0hjak5wu6jm/wXhTt/TyOMvBjyUPAAGKTwzzLH7TIsmhu7d16pcAlsoJfj7WD2E7GLLRqTCkkK3vBkBLJ5Za7GtretNGjRfK2DLSDnZnTyiVy8M8E0yKE/P+14Zw2JlGp/5HdACCHG1IwbFKA1gFcs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SVYzPQcd; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726052994; x=1757588994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=soybigFmIlSrs1R3ou7FRmrWnLzOIypKD01PIh46pW8=;
  b=SVYzPQcdPI/mtl7kU3/kJI8+Q1HI3qaJ48YX/2IN2MAEvG8RR9bFDgtv
   QhC57JJ8l5TV3QTzbXTgejsc7zisvkqxE3tMiY4fcHyG20dld2rNwnMvy
   4aOAJDlxaNrL3wFhZddrsi0sYNveQDkfSJEpF99GAtQn25JyXu1fEq9Ts
   54vec8CWDKhlYlFu4z6EgpBVDZRkhFRsNGGXEwWEiFW5yHfPXNrAiDkaE
   BlEtw+ynIDrxKa/4jD6uW8HWAlT2bbRM2i/8SRA+w0LGt2TKk6US2LIgV
   s310IFZFbyBfdDDxV5WbgxfcyGmxJw/CmyeSNAY9nWEkE+pX6++K6TO2V
   Q==;
X-CSE-ConnectionGUID: QtBj3ERxR0+WztjjFOlbSw==
X-CSE-MsgGUID: c344QqX2R4KSA7oladEl5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35437569"
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="35437569"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 04:09:53 -0700
X-CSE-ConnectionGUID: nT28gaEGQdSbroWrmyaHxA==
X-CSE-MsgGUID: 9sE0gGiOQvKaJ32xTk3cWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,219,1719903600"; 
   d="scan'208";a="67352985"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa009.fm.intel.com with ESMTP; 11 Sep 2024 04:09:51 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.145])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id CB85827BC5;
	Wed, 11 Sep 2024 12:09:49 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Dan Nowlin <dan.nowlin@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next 2/2] ice: support optional flags in signature segment header
Date: Wed, 11 Sep 2024 13:07:33 +0200
Message-ID: <20240911110926.25384-6-przemyslaw.kitszel@intel.com>
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

From: Paul Greenwalt <paul.greenwalt@intel.com>

An optional flag field has been added to the signature segment header.
The field contains two flags, a "valid" bit, and a "last segment" bit
that indicates whether the segment is the last segment that will be
sent to firmware.

If the flag field's valid bit is NOT set, then as was done before,
assume that this is the last segment being downloaded.

However, if the flag field's valid bit IS set, then use the last segment
flag to determine if this segment is the last segment to download.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
CC: Dan Nowlin <dan.nowlin@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Co-developed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ddp.h |  5 ++++-
 drivers/net/ethernet/intel/ice/ice_ddp.c | 24 +++++++++++++++++-------
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.h b/drivers/net/ethernet/intel/ice/ice_ddp.h
index 97f272317475..2bd3cecbc112 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.h
@@ -181,7 +181,10 @@ struct ice_sign_seg {
 	__le32 signed_seg_idx;
 	__le32 signed_buf_start;
 	__le32 signed_buf_count;
-#define ICE_SIGN_SEG_RESERVED_COUNT	44
+#define ICE_SIGN_SEG_FLAGS_VALID	0x80000000
+#define ICE_SIGN_SEG_FLAGS_LAST		0x00000001
+	__le32 flags;
+#define ICE_SIGN_SEG_RESERVED_COUNT	40
 	u8 reserved[ICE_SIGN_SEG_RESERVED_COUNT];
 	struct ice_buf_table buf_tbl;
 };
diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index 9ec5f9cee466..7dff0d95b423 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -1434,6 +1434,12 @@ ice_download_pkg_config_seg(struct ice_ddp_send_ctx *ctx,
 	return ice_dwnld_cfg_bufs_no_lock(ctx, bufs->buf_array, start, count);
 }
 
+static bool ice_is_last_sign_seg(u32 flags)
+{
+	return !(flags & ICE_SIGN_SEG_FLAGS_VALID) /* behavior prior to valid */
+	       || (flags & ICE_SIGN_SEG_FLAGS_LAST);
+}
+
 /**
  * ice_dwnld_sign_and_cfg_segs - download a signing segment and config segment
  * @ctx: context of the current buffers section to send
@@ -1446,11 +1452,9 @@ static enum ice_ddp_state
 ice_dwnld_sign_and_cfg_segs(struct ice_ddp_send_ctx *ctx,
 			    struct ice_pkg_hdr *pkg_hdr, u32 idx)
 {
+	u32 conf_idx, start, count, flags;
 	enum ice_ddp_state state;
 	struct ice_sign_seg *seg;
-	u32 conf_idx;
-	u32 start;
-	u32 count;
 
 	seg = (struct ice_sign_seg *)ice_get_pkg_seg_by_idx(pkg_hdr, idx);
 	if (!seg) {
@@ -1466,7 +1470,15 @@ ice_dwnld_sign_and_cfg_segs(struct ice_ddp_send_ctx *ctx,
 	conf_idx = le32_to_cpu(seg->signed_seg_idx);
 	start = le32_to_cpu(seg->signed_buf_start);
 
-	return ice_download_pkg_config_seg(ctx, pkg_hdr, conf_idx, start, count);
+	state = ice_download_pkg_config_seg(ctx, pkg_hdr, conf_idx, start,
+					    count);
+
+	/* finish up by sending last hunk with "last" flag set if requested by
+	 * DDP content */
+	flags = le32_to_cpu(seg->flags);
+	if (ice_is_last_sign_seg(flags))
+		state = ice_ddp_send_hunk(ctx, NULL);
+
 exit:
 	ctx->err = state;
 	return state;
@@ -1544,9 +1556,7 @@ ice_download_pkg_with_sig_seg(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr)
 						    hw->pkg_sign_type))
 			continue;
 
-		ice_dwnld_sign_and_cfg_segs(&ctx, pkg_hdr, i);
-		/* finish up by sending last hunk with "last" flag set */
-		state = ice_ddp_send_hunk(&ctx, NULL);
+		state = ice_dwnld_sign_and_cfg_segs(&ctx, pkg_hdr, i);
 		if (state)
 			break;
 	}
-- 
2.46.0


