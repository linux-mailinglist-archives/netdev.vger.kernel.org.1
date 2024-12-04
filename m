Return-Path: <netdev+bounces-148954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DA69E3985
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 13:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C341695C5
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 12:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862271B6D03;
	Wed,  4 Dec 2024 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jfgbL44w"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0DB1B6CE4
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 12:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733314154; cv=none; b=px7wwyqmPaWPcdg5pDxxbVaav2UHIV520nyk38h+aWwA3Zc1rVWaj4PgLUCMJzfbro9UkBCUttiv+0OUZB9C3uY+q1N/r71Fwa6PitC2nD+Z9CbIwFi+Oxsc52hWTAzK5cTYAVGefvx9Z7CMSQpgV7fw0udc8y+fkJFoNt9S7PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733314154; c=relaxed/simple;
	bh=COIAgBpaDgvxMQfshBZKESnH/IvXIyo7s7gLs1O76b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsMXLHAXFBzL3YJN3JnKENRkzvNKpZQrYs7YV15QBsuI3IgPrwxTMWIdUb45zAF36VqLbLKiLODT4TYPup1i72GsYIq+c3cOdCfdd+EbW9YMSC5eE+IgEKvvi0u3i8hXiVyETukZsttspT5Q7hyEhR2zape+l82NdbnXnNZpRXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jfgbL44w; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733314153; x=1764850153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=COIAgBpaDgvxMQfshBZKESnH/IvXIyo7s7gLs1O76b8=;
  b=jfgbL44w962oCwbupIcb59DAaY7JT3p3KOVb52r1CpEXUEdO5QU9ZsAe
   SRGaKAN943miI4SYOB0pPCL6nsOaaa1LVCNSFziF2Q54QrVOO44ZjoJp7
   hENq8D+44J1Erw5gZ8d1r98ooFTxoT0uiBxL5SPrBhpCjsWh6G8B5TysO
   VhxXW2ICj2cW9bIIkWJDE3SlRcy12dlr9EJxTzv176DcZ2EzwrAlbkzn8
   cu9Qkij7dd0nQZtc9VUdAuHDNWGUdV7SVJt+me3BsyQ8AYo/TUn8XLq++
   uW+P4MC80Ljol+eGRv6PQFFbOErBqBui5HN+LSVrmepBctlmBOEA1kpEf
   w==;
X-CSE-ConnectionGUID: 7GyhzNsIQ9itQMg+YVHxNw==
X-CSE-MsgGUID: gSyVT7iDTSW1tTAyv9th7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="32918423"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="32918423"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 04:09:12 -0800
X-CSE-ConnectionGUID: WCt/XWNFTYiXtJuO2A5kHw==
X-CSE-MsgGUID: 1qPnCPk8QLCIHIIfl1zi0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="116994560"
Received: from host61.igk.intel.com ([10.123.220.61])
  by fmviesa002.fm.intel.com with ESMTP; 04 Dec 2024 04:09:10 -0800
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
Subject: [PATCH iwl-next 1/5] ice: use rd32_poll_timeout_atomic in ice_read_phy_tstamp_ll_e810
Date: Wed,  4 Dec 2024 13:03:44 -0500
Message-ID: <20241204180709.307607-2-anton.nadezhdin@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241204180709.307607-1-anton.nadezhdin@intel.com>
References: <20241204180709.307607-1-anton.nadezhdin@intel.com>
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
index e55aeab0975c..b9cf8ce9644a 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -4868,32 +4868,28 @@ static int
 ice_read_phy_tstamp_ll_e810(struct ice_hw *hw, u8 idx, u8 *hi, u32 *lo)
 {
 	u32 val;
-	u8 i;
+	u8 err;
 
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
index 5c11d8a69fd3..4c059e2f4d96 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -694,7 +694,7 @@ static inline bool ice_is_dual(struct ice_hw *hw)
 #define BYTES_PER_IDX_ADDR_L		4
 
 /* Tx timestamp low latency read definitions */
-#define TS_LL_READ_RETRIES		200
+#define TS_LL_READ_TIMEOUT		2000
 #define TS_LL_READ_TS_HIGH		GENMASK(23, 16)
 #define TS_LL_READ_TS_IDX		GENMASK(29, 24)
 #define TS_LL_READ_TS_INTR		BIT(30)
-- 
2.42.0


