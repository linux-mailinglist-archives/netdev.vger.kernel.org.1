Return-Path: <netdev+bounces-152122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 567979F2C6F
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 09:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26C667A1F47
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 08:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E3E20100E;
	Mon, 16 Dec 2024 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8KLnTM0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFE5200136
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734339393; cv=none; b=GRAU6pbmfM2rC/epVByqRJ5O9uXYF9VLyYw5FIFCkeXucyJIB2C3LixpUN0qhDrTyMhdQQf2ZhrFZl4pc79B36se8tpzrzZNwJDwQMo/F1vpBzCMfBOSmtE0VaUBvuO8CP4k3ekGfSkZrhZv+89h840vxhrGEnZJDuOsZ1o4WFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734339393; c=relaxed/simple;
	bh=tTrUHU/UfhsiPCt/C0iCANolN5harHvI6rQ+JdSrwn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcxZocfOlaCUPB+ovbTA/LyzqN6TOvCLAn9/Nl37ycqIv+5lkXMj+U3nBogjTbujQbA8yEV39yVJuIb7YP16qORkhEKewJ3bi92EeibVTYJ/0Nxs4YTrZtDY8vFaCyRlpHZhohM3jkL53Igm9GOIfn8LT0OSmgu2fJvvYIVIAK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8KLnTM0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734339391; x=1765875391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tTrUHU/UfhsiPCt/C0iCANolN5harHvI6rQ+JdSrwn4=;
  b=Q8KLnTM0IkZM5QdyZhtc/8ZSHjvhefzx+OYYHbVsOjAUStXCJNVteo58
   9eMUhjZSYCciV/Ajq+ZJ80Ilwa+JUaet7FrlFRC8so/CWDjEayTBJ53ve
   pLqsY9SRTRrv/jVp1vVRuueCCC7RUFuH68tyvQFats8LTqyUL+XYQuf0P
   4M+8tqinxApqB3BrH+vyLkXz05JBwvbU4lSJGty7uxRnX4fg0FGlwuIvX
   XCBCzn2gX3yxMIdKQseZjb8i2zzu1hr2UtXWKoRbO+/MCqn325bzx8KO4
   YIq2RZjOvFh6GFyXksvbq/DA2UuJqSeKdYOcpgC79BnBnS6vn+ZNYxghs
   Q==;
X-CSE-ConnectionGUID: yinT0pJfQTu2jYr0H1UK2g==
X-CSE-MsgGUID: b4Af63FCSPGv7q4VyzwlJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34942397"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="34942397"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 00:56:30 -0800
X-CSE-ConnectionGUID: TZ2w4sfWSAGAHxcNAtLQSg==
X-CSE-MsgGUID: nsO9VPF3QROWXBkZRoxgIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102117157"
Received: from host61.igk.intel.com ([10.123.220.61])
  by orviesa005.jf.intel.com with ESMTP; 16 Dec 2024 00:56:26 -0800
From: Anton Nadezhdin <anton.nadezhdin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	Anton Nadezhdin <anton.nadezhdin@intel.com>
Subject: [PATCH iwl-next v2 1/5] ice: use rd32_poll_timeout_atomic in ice_read_phy_tstamp_ll_e810
Date: Mon, 16 Dec 2024 09:53:28 -0500
Message-ID: <20241216145453.333745-2-anton.nadezhdin@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241216145453.333745-1-anton.nadezhdin@intel.com>
References: <20241216145453.333745-1-anton.nadezhdin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_read_phy_tstamp_ll_e810 function repeatedly reads the PF_SB_ATQBAL
register until the TS_LL_READ_TS bit is cleared. This is a perfect
candidate for using rd32_poll_timeout. However, the default implementation
uses a sleep-based wait.

Add a new rd32_poll_timeout_atomic macro which is based on the non-sleeping
read_poll_timeout_atomic implementation. Use this to replace the loop
reading in the ice_read_phy_tstamp_ll_e810 function.

This will also be used in the future when low latency PHY timer updates are
supported.

Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_osdep.h  |  3 +++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 30 +++++++++------------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  2 +-
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_osdep.h b/drivers/net/ethernet/intel/ice/ice_osdep.h
index b9f383494b3f..9bb343de80a9 100644
--- a/drivers/net/ethernet/intel/ice/ice_osdep.h
+++ b/drivers/net/ethernet/intel/ice/ice_osdep.h
@@ -26,6 +26,9 @@
 
 #define rd32_poll_timeout(a, addr, val, cond, delay_us, timeout_us) \
 	read_poll_timeout(rd32, val, cond, delay_us, timeout_us, false, a, addr)
+#define rd32_poll_timeout_atomic(a, addr, val, cond, delay_us, timeout_us) \
+	read_poll_timeout_atomic(rd32, val, cond, delay_us, timeout_us, false, \
+				 a, addr)
 
 #define ice_flush(a)		rd32((a), GLGEN_STAT)
 #define ICE_M(m, s)		((m ## U) << (s))
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index e017e72cee5b..4a0d5d9ad605 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -4883,32 +4883,28 @@ static int
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
+	err = rd32_poll_timeout_atomic(hw, PF_SB_ATQBAL, val,
+				       !FIELD_GET(TS_LL_READ_TS, val),
+				       10, TS_LL_READ_TIMEOUT);
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
index 3227bd78d291..937f530c842e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -674,7 +674,7 @@ static inline bool ice_is_dual(struct ice_hw *hw)
 #define BYTES_PER_IDX_ADDR_L		4
 
 /* Tx timestamp low latency read definitions */
-#define TS_LL_READ_RETRIES		200
+#define TS_LL_READ_TIMEOUT		2000
 #define TS_LL_READ_TS_HIGH		GENMASK(23, 16)
 #define TS_LL_READ_TS_IDX		GENMASK(29, 24)
 #define TS_LL_READ_TS_INTR		BIT(30)
-- 
2.42.0


