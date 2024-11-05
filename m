Return-Path: <netdev+bounces-142112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582ED9BD875
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 23:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 760351C2210A
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 22:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6229A216A08;
	Tue,  5 Nov 2024 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YUIsZjWQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE31021644E
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 22:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730845444; cv=none; b=PCn+28qNcXaRa65ndXcsVKmCOKLyrJUebf4+xNS+olGnpQPbUTgFsjzPNd7KhuWbmY5cKaqLOTl+3zlv0UuWlzMAEZ4JEwnGHnXv6s04qfnnLF0YGzOW0gn8H0+PpFIiwDCevK7OX+c1aXI7Ssv0El8HErto+gGfUvDYwF4Eafw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730845444; c=relaxed/simple;
	bh=NgdVcrljFqMwr/5rI/mHmHlEbUgCPMK/aLx08vBDNxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dg+Z0j67szs44N43TicMZgtEHHD9lvoIS/bLLDJ0VdR0lxs7JpGVWm2Y7XSbVrcrZfIeVAKPiZCS/ZcsRyP+JE1GzsdgTQAQ1e5E6GIGm2piawrAw82GZM+VpSHiR28YKQWjJGwk0dE5LNrr1O+30IXub6k3jq8QA26ReSHBvCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YUIsZjWQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730845443; x=1762381443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NgdVcrljFqMwr/5rI/mHmHlEbUgCPMK/aLx08vBDNxk=;
  b=YUIsZjWQWda6o6c6Z57QQHTIiyeR/L82zeuWrIXS2dIk8YAXlZckIY82
   ZKQh311Jwa30ZmF7w8Mk6FDinPYwOd8GL+GmvzVQXziLO/2vKfDdWBgtI
   1aXucFM2hi+fanB+wiqPDE5cp4vCaf+UyKUEhZjnijPIjSQDgT7WftDwj
   hO1tn/5+4PfAGXVwnmqpvUtuGjNkTZ9yiUXG+a6fEZd6PeeZjlrrfMvAL
   D+H32v4KVSO/wJfYEXZAcQPGo4bo21uHEptWV+fv5UFqk9NPqoyZyBj1f
   AmrPquZhK8bfAehu4kKRZD+EFFt34vrGRX/34d12mixmnEBQ1oXeyCbg/
   Q==;
X-CSE-ConnectionGUID: 1c4VTwyqTHaUpTXUZcAQ5g==
X-CSE-MsgGUID: aTf/3q/tSYOPI6YWbH21rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34314275"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34314275"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 14:24:00 -0800
X-CSE-ConnectionGUID: 5BuOZltMRseZ3wOwM34Lkw==
X-CSE-MsgGUID: g/hMSjn3RR6rne93Zd2NMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="84322443"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 05 Nov 2024 14:23:59 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Dan Nowlin <dan.nowlin@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 05/15] ice: support optional flags in signature segment header
Date: Tue,  5 Nov 2024 14:23:39 -0800
Message-ID: <20241105222351.3320587-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241105222351.3320587-1-anthony.l.nguyen@intel.com>
References: <20241105222351.3320587-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

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
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ddp.c | 22 ++++++++++++++++------
 drivers/net/ethernet/intel/ice/ice_ddp.h |  5 ++++-
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index 3e1173ef4b5c..94d78ef382ce 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -1438,6 +1438,12 @@ ice_download_pkg_config_seg(struct ice_ddp_send_ctx *ctx,
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
@@ -1450,11 +1456,9 @@ static enum ice_ddp_state
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
@@ -1473,6 +1477,14 @@ ice_dwnld_sign_and_cfg_segs(struct ice_ddp_send_ctx *ctx,
 
 	state = ice_download_pkg_config_seg(ctx, pkg_hdr, conf_idx, start,
 					    count);
+
+	/* finish up by sending last hunk with "last" flag set if requested by
+	 * DDP content
+	 */
+	flags = le32_to_cpu(seg->flags);
+	if (ice_is_last_sign_seg(flags))
+		state = ice_ddp_send_hunk(ctx, NULL);
+
 	return state;
 }
 
@@ -1548,9 +1560,7 @@ ice_download_pkg_with_sig_seg(struct ice_hw *hw, struct ice_pkg_hdr *pkg_hdr)
 						    hw->pkg_sign_type))
 			continue;
 
-		ice_dwnld_sign_and_cfg_segs(&ctx, pkg_hdr, i);
-		/* finish up by sending last hunk with "last" flag set */
-		state = ice_ddp_send_hunk(&ctx, NULL);
+		state = ice_dwnld_sign_and_cfg_segs(&ctx, pkg_hdr, i);
 		if (state)
 			break;
 	}
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
-- 
2.42.0


