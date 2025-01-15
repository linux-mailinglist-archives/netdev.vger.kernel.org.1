Return-Path: <netdev+bounces-158312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7617A115E1
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 01:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6DA6169062
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BF6200CB;
	Wed, 15 Jan 2025 00:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FFEt0bSP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C5C1171C
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 00:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736899739; cv=none; b=VIEdEjWO5kpz9yLB7NAThpwKt9tSP8+asTe8a7+8cFy4gFg/porYxXfhxcTnwcRoqyYatFh3cMCZF+UjgtJ7VDhWsPSwn/mc95EuKZSfj17+BknA/ZUHh4xGC2v4TRtx5iESsVGbElP1FLwOEWY20xdiQEAjNh0pV/g1DimglsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736899739; c=relaxed/simple;
	bh=XXFSIc7xBnKLpfR0+sySgbuQC/PIyAYTMASgLT2XB/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Va4IzIamWBpDd+9Lv5OxYILvCvoefeL4f5Rv/9eSI9LiJwufKGlOGugqEfDWZeVv/afKoHOuLGoSAzFD88Rp6X6k1pmStNyFAPpQh3ZPhFsoqVBBG/wxQE3GENgmtmRuT81Vy6Mh1YW0qtLX71jB7pJWhm370f6Fs/wU70K118g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FFEt0bSP; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736899737; x=1768435737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XXFSIc7xBnKLpfR0+sySgbuQC/PIyAYTMASgLT2XB/k=;
  b=FFEt0bSPuhOr6FTseidaWJMC8jlxE1SB+SmAUaZ7T89XHgA77MTF+vag
   OdY1iGkydRRQcLwB4SUT09ILEE+0WDLMP8dFIIjdXjfJqqnyNZ1OtcSjq
   GffmXaXHsidOHeC5/RHDK37d+YF1QoncN3fsnmy9MoNV1/m2wf9+ePJkb
   E1l80QXlzxlbMpQehPjScEtpBhzYa835+XyZX2Me+ehgWvnjjnn5JSlbW
   bei260ecUlzC2Uy1Q4tFUmWRGXhBktUkFbxnhC2xyt6sGA26wfvCp7LfT
   /812ONwLfEAfXWgtHBe/VLcqQAZDjLrbCDq3MKCo9QdYLGq31ZboP4UBP
   A==;
X-CSE-ConnectionGUID: 6LWelQttSViD7rB9mjmRYA==
X-CSE-MsgGUID: fTq7onN4SRusKf7qpTfkjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="40897500"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="40897500"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 16:08:53 -0800
X-CSE-ConnectionGUID: daYPNjLHQOq3qcHU/LfuSA==
X-CSE-MsgGUID: 9esjSDbaQfyAOCGFPJtyxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128211424"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 14 Jan 2025 16:08:53 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	anton.nadezhdin@intel.com,
	przemyslaw.kitszel@intel.com,
	milena.olech@intel.com,
	arkadiusz.kubalewski@intel.com,
	richardcochran@gmail.com,
	mschmidt@redhat.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH net-next v2 08/13] ice: use read_poll_timeout_atomic in ice_read_phy_tstamp_ll_e810
Date: Tue, 14 Jan 2025 16:08:34 -0800
Message-ID: <20250115000844.714530-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115000844.714530-1-anthony.l.nguyen@intel.com>
References: <20250115000844.714530-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_read_phy_tstamp_ll_e810 function repeatedly reads the PF_SB_ATQBAL
register until the TS_LL_READ_TS bit is cleared. This is a perfect
candidate for using rd32_poll_timeout. However, the default implementation
uses a sleep-based wait. Use read_poll_timeout_atomic macro which is based
on the non-sleeping implementation and use it to replace the loop reading
in the ice_read_phy_tstamp_ll_e810 function.

Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 31 ++++++++++-----------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  2 +-
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 6f9d4dc82997..0c1c691f51d5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -4858,32 +4858,29 @@ static int
 ice_read_phy_tstamp_ll_e810(struct ice_hw *hw, u8 idx, u8 *hi, u32 *lo)
 {
 	u32 val;
-	u8 i;
+	int err;
 
 	/* Write TS index to read to the PF register so the FW can read it */
 	val = FIELD_PREP(TS_LL_READ_TS_IDX, idx) | TS_LL_READ_TS;
 	wr32(hw, PF_SB_ATQBAL, val);
 
 	/* Read the register repeatedly until the FW provides us the TS */
-	for (i = TS_LL_READ_RETRIES; i > 0; i--) {
-		val = rd32(hw, PF_SB_ATQBAL);
-
-		/* When the bit is cleared, the TS is ready in the register */
-		if (!(FIELD_GET(TS_LL_READ_TS, val))) {
-			/* High 8 bit value of the TS is on the bits 16:23 */
-			*hi = FIELD_GET(TS_LL_READ_TS_HIGH, val);
+	err = read_poll_timeout_atomic(rd32, val,
+				       !FIELD_GET(TS_LL_READ_TS, val), 10,
+				       TS_LL_READ_TIMEOUT, false, hw,
+				       PF_SB_ATQBAL);
+	if (err) {
+		ice_debug(hw, ICE_DBG_PTP, "Failed to read PTP timestamp using low latency read\n");
+		return err;
+	}
 
-			/* Read the low 32 bit value and set the TS valid bit */
-			*lo = rd32(hw, PF_SB_ATQBAH) | TS_VALID;
-			return 0;
-		}
+	/* High 8 bit value of the TS is on the bits 16:23 */
+	*hi = FIELD_GET(TS_LL_READ_TS_HIGH, val);
 
-		udelay(10);
-	}
+	/* Read the low 32 bit value and set the TS valid bit */
+	*lo = rd32(hw, PF_SB_ATQBAH) | TS_VALID;
 
-	/* FW failed to provide the TS in time */
-	ice_debug(hw, ICE_DBG_PTP, "Failed to read PTP timestamp using low latency read\n");
-	return -EINVAL;
+	return 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 1cee0f1bba2d..7a29faa593cc 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -689,7 +689,7 @@ static inline bool ice_is_dual(struct ice_hw *hw)
 #define BYTES_PER_IDX_ADDR_L		4
 
 /* Tx timestamp low latency read definitions */
-#define TS_LL_READ_RETRIES		200
+#define TS_LL_READ_TIMEOUT		2000
 #define TS_LL_READ_TS_HIGH		GENMASK(23, 16)
 #define TS_LL_READ_TS_IDX		GENMASK(29, 24)
 #define TS_LL_READ_TS_INTR		BIT(30)
-- 
2.47.1


