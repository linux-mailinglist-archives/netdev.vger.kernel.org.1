Return-Path: <netdev+bounces-137034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9960C9A40F2
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 16:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B1F1C20C8B
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 14:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CFE1EE002;
	Fri, 18 Oct 2024 14:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D5QjhqDn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984C31D3182
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729261116; cv=none; b=Hbq3yBR5VIRKuqFqSYFZ1rzdE12/wUHoFdbLbJc7QIeSuidWX1KW8y6eARlfchN9vtJtxA+vsGpuBJkN9+IStyswcMLvwgjNdayCpWnQHTPNiOAl8RDzdg1dEUYIHmod2KtI9dV0LwXm5e71/YYgjWFwhiP4huhHEsolr7/VHvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729261116; c=relaxed/simple;
	bh=YwRF5hN8LiWMHJW+vgahFBnhO7gtBweNzskldU/Lyg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nelyOAnIaq5AHHqeGjkwYUH0or3t8cHu/KBY+lNaNdREBmCn1y7DO6vCIkKiZOZqbLHJBMpytFTngmi195dvv9C0b5lK4r0dxEQKelvEtxHpkz2VGFz7kPBSfaY9tc2IEOh1Z7ssmnwoI2ursFIc5d+OHk+hmXvt/VtZ617vT5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D5QjhqDn; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729261115; x=1760797115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YwRF5hN8LiWMHJW+vgahFBnhO7gtBweNzskldU/Lyg4=;
  b=D5QjhqDnKCwUA7oTLnq4uESYBpZkT7x02KBx0N3g2xGnr556ieuh6x2+
   SlEizS0Fu/vZowfgII62Ax5+KWYhIEnasOjSGnYwpNktGypx1SRubA/pT
   3lKmvsLKnt/SFnn9r2H6E7zLE6C5CtySRgjEFjvG5o3ODTHjQLZyHIKSH
   OKASSvHIWy0NKzhEHCSMjRC8xAvL+T1PhVMkSRAGD18601OuVIIwZhzpk
   ybqhn7yMyIOeS9vhyRCrCTns9e6G5OwkGqsPxCWGEwAAMaenNgvTP9Dlw
   TFshVtFmOgY/GFP5+hUCHsdYkMcowvi49ioTdsvpW+b3b13vRKA9CfXs8
   g==;
X-CSE-ConnectionGUID: y2+U/XDQTqGsFb2KyWnUyw==
X-CSE-MsgGUID: pv0sJJ12RAWejczcV98Xvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="46293165"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="46293165"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 07:18:34 -0700
X-CSE-ConnectionGUID: XzIAdjJ4QiCcmKcyoKoefw==
X-CSE-MsgGUID: G++cKWF7ROSHu7a6XlkMzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="78929748"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa008.fm.intel.com with ESMTP; 18 Oct 2024 07:18:32 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.186])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id DE4FC2FC66;
	Fri, 18 Oct 2024 15:18:29 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Dan Nowlin <dan.nowlin@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH iwl-next v3 2/2] ice: support optional flags in signature segment header
Date: Fri, 18 Oct 2024 16:17:37 +0200
Message-ID: <20241018141823.178918-6-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241018141823.178918-4-przemyslaw.kitszel@intel.com>
References: <20241018141823.178918-4-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Co-developed-by: Dan Nowlin <dan.nowlin@intel.com>
Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v2: co/- authorship change
---
 drivers/net/ethernet/intel/ice/ice_ddp.h |  5 ++++-
 drivers/net/ethernet/intel/ice/ice_ddp.c | 21 +++++++++++++++------
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.h b/drivers/net/ethernet/intel/ice/ice_ddp.h
index 79551da2a4b0..8a2d57fc5dae 100644
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
index 3e1173ef4b5c..5a70854b0ca2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -1438,23 +1438,27 @@ ice_download_pkg_config_seg(struct ice_ddp_send_ctx *ctx,
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
  * @pkg_hdr: pointer to package header
  * @idx: segment index (must be a signature segment)
  *
  * Note: idx must reference a signature segment
  */
 static enum ice_ddp_state
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
@@ -1473,6 +1477,13 @@ ice_dwnld_sign_and_cfg_segs(struct ice_ddp_send_ctx *ctx,
 
 	state = ice_download_pkg_config_seg(ctx, pkg_hdr, conf_idx, start,
 					    count);
+
+	/* finish up by sending last hunk with "last" flag set if requested by
+	 * DDP content */
+	flags = le32_to_cpu(seg->flags);
+	if (ice_is_last_sign_seg(flags))
+		state = ice_ddp_send_hunk(ctx, NULL);
+
 	return state;
 }
 
@@ -1548,9 +1559,7 @@ ice_download_pkg_with_sig_seg(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr)
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


