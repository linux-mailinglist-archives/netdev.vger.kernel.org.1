Return-Path: <netdev+bounces-156487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EA1A06819
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 23:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAF49167B81
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 22:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B70B204F8B;
	Wed,  8 Jan 2025 22:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X7y0BCox"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC213204C03
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 22:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374691; cv=none; b=o+eExMy6an0mV6Lek/2e+lNnR41sulfaNWbRHKFYC8lWhkNphxwsx3ZOyGJe/s8CerEEaHaQh/AgELnsIXSfFd0kwSFAlSwrTZghWTLJKMp8YR860YCZlp9kBMEkmwvQTUFGrC7UcIdOlsNZeME7t28qNqQf9L2Ucx4jWMM8kHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374691; c=relaxed/simple;
	bh=QNitqn03vt3N0JWFwkhs42lTVjE856SfF+qJ35tzksI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fBYYj2MLgxOkjYvoR4SvgwV07zRcedL7ol46a2Sks+iy2j0vW0TQeSn/S1q8eU2JPi76EF+S9w98qEb4gC6hPpRXbycarpfcOGCMOjiPl6r1OnUBY058Nro1w4axhSeZ0tI9uYY4Su6GBlDxfAVytxQtL+BGl7/ficHSwEitskI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X7y0BCox; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736374690; x=1767910690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QNitqn03vt3N0JWFwkhs42lTVjE856SfF+qJ35tzksI=;
  b=X7y0BCoxnnEheR5Kz09vw45Z1M92UWHyRp+lRJahxSZCueOlH2sUXGs0
   /pLGesZZNQVAGlMdZC/7gOWZc5NL1BPnyyDb8otUzicGPWKpFHBmlFzi2
   P9zAS1fw13mcdCJZmI3RJUvutxBd9rFqaCCPkurmM/pzMZnbHaxdL6Azj
   7Xd0Cn0Rk8bd8X/KgrHOTwQR/QLt2CXSRfmw8dvVjKGRAJ8n1kfSpp9oN
   cC0wN+oei6amD7V7+xKjJCpIuoK60koDpGYT3mK8XlgVfd32NKNTPEntT
   gA+N8dM3ubTyRRsssc76Yd1U7qg1rG0gw0LlbHjDSt40+XnCYOij3T0e5
   Q==;
X-CSE-ConnectionGUID: 1DitvexXQliHU+VZ0UtJhQ==
X-CSE-MsgGUID: 0GYFWE10R7qKwf0Sz26HtQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="40384692"
X-IronPort-AV: E=Sophos;i="6.12,299,1728975600"; 
   d="scan'208";a="40384692"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 14:18:04 -0800
X-CSE-ConnectionGUID: AVuv2mp/QRGCIPFAn+zl6A==
X-CSE-MsgGUID: ou8JXEUHTPmS1j5Am1aKzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="140545134"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 08 Jan 2025 14:18:03 -0800
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
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 09/13] ice: rename TS_LL_READ* macros to REG_LL_PROXY_H_*
Date: Wed,  8 Jan 2025 14:17:46 -0800
Message-ID: <20250108221753.2055987-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108221753.2055987-1-anthony.l.nguyen@intel.com>
References: <20250108221753.2055987-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The TS_LL_READ macros are used as part of the low latency Tx timestamp
interface. A future firmware extension will add support for performing PHY
timer updates over this interface. Using TS_LL_READ as the prefix for these
macros will be confusing once the interface is used for other purposes.

Rename the macros, using the prefix REG_LL_PROXY_H, to better clarify that
this is for the low latency interface.
Additionally add macros for PF_SB_ATQBAH and PF_SB_ATQBAL registers to
better clarify content of this registers as PF_SB_ATQBAH contain low
part of Tx timestamp

Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 14 +++++++-------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 14 +++++++-------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 13 ++++++++-----
 3 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index a999fface272..980d3fe9f36b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -490,9 +490,9 @@ void ice_ptp_req_tx_single_tstamp(struct ice_ptp_tx *tx, u8 idx)
 	ice_trace(tx_tstamp_fw_req, tx->tstamps[idx].skb, idx);
 
 	/* Write TS index to read to the PF register so the FW can read it */
-	wr32(&pf->hw, PF_SB_ATQBAL,
-	     TS_LL_READ_TS_INTR | FIELD_PREP(TS_LL_READ_TS_IDX, idx) |
-	     TS_LL_READ_TS);
+	wr32(&pf->hw, REG_LL_PROXY_H,
+	     REG_LL_PROXY_H_TS_INTR_ENA | FIELD_PREP(REG_LL_PROXY_H_TS_IDX, idx) |
+	     REG_LL_PROXY_H_EXEC);
 	tx->last_ll_ts_idx_read = idx;
 }
 
@@ -519,20 +519,20 @@ void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx)
 
 	ice_trace(tx_tstamp_fw_done, tx->tstamps[idx].skb, idx);
 
-	val = rd32(&pf->hw, PF_SB_ATQBAL);
+	val = rd32(&pf->hw, REG_LL_PROXY_H);
 
 	/* When the bit is cleared, the TS is ready in the register */
-	if (val & TS_LL_READ_TS) {
+	if (val & REG_LL_PROXY_H_EXEC) {
 		dev_err(ice_pf_to_dev(pf), "Failed to get the Tx tstamp - FW not ready");
 		return;
 	}
 
 	/* High 8 bit value of the TS is on the bits 16:23 */
-	raw_tstamp = FIELD_GET(TS_LL_READ_TS_HIGH, val);
+	raw_tstamp = FIELD_GET(REG_LL_PROXY_H_TS_HIGH, val);
 	raw_tstamp <<= 32;
 
 	/* Read the low 32 bit value */
-	raw_tstamp |= (u64)rd32(&pf->hw, PF_SB_ATQBAH);
+	raw_tstamp |= (u64)rd32(&pf->hw, REG_LL_PROXY_L);
 
 	/* Devices using this interface always verify the timestamp differs
 	 * relative to the last cached timestamp value.
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index e9d3573e5606..47b784acf07f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -4861,23 +4861,23 @@ ice_read_phy_tstamp_ll_e810(struct ice_hw *hw, u8 idx, u8 *hi, u32 *lo)
 	int err;
 
 	/* Write TS index to read to the PF register so the FW can read it */
-	val = FIELD_PREP(TS_LL_READ_TS_IDX, idx) | TS_LL_READ_TS;
-	wr32(hw, PF_SB_ATQBAL, val);
+	val = FIELD_PREP(REG_LL_PROXY_H_TS_IDX, idx) | REG_LL_PROXY_H_EXEC;
+	wr32(hw, REG_LL_PROXY_H, val);
 
 	/* Read the register repeatedly until the FW provides us the TS */
-	err = rd32_poll_timeout_atomic(hw, PF_SB_ATQBAL, val,
-				       !FIELD_GET(TS_LL_READ_TS, val),
-				       10, TS_LL_READ_TIMEOUT);
+	err = rd32_poll_timeout_atomic(hw, REG_LL_PROXY_H, val,
+				       !FIELD_GET(REG_LL_PROXY_H_EXEC, val),
+				       10, REG_LL_PROXY_H_TIMEOUT_US);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to read PTP timestamp using low latency read\n");
 		return err;
 	}
 
 	/* High 8 bit value of the TS is on the bits 16:23 */
-	*hi = FIELD_GET(TS_LL_READ_TS_HIGH, val);
+	*hi = FIELD_GET(REG_LL_PROXY_H_TS_HIGH, val);
 
 	/* Read the low 32 bit value and set the TS valid bit */
-	*lo = rd32(hw, PF_SB_ATQBAH) | TS_VALID;
+	*lo = rd32(hw, REG_LL_PROXY_L) | TS_VALID;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 7a29faa593cc..5a3b1b15c746 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -689,11 +689,14 @@ static inline bool ice_is_dual(struct ice_hw *hw)
 #define BYTES_PER_IDX_ADDR_L		4
 
 /* Tx timestamp low latency read definitions */
-#define TS_LL_READ_TIMEOUT		2000
-#define TS_LL_READ_TS_HIGH		GENMASK(23, 16)
-#define TS_LL_READ_TS_IDX		GENMASK(29, 24)
-#define TS_LL_READ_TS_INTR		BIT(30)
-#define TS_LL_READ_TS			BIT(31)
+#define REG_LL_PROXY_H_TIMEOUT_US	2000
+#define REG_LL_PROXY_H_TS_HIGH		GENMASK(23, 16)
+#define REG_LL_PROXY_H_TS_IDX		GENMASK(29, 24)
+#define REG_LL_PROXY_H_TS_INTR_ENA	BIT(30)
+#define REG_LL_PROXY_H_EXEC		BIT(31)
+
+#define REG_LL_PROXY_L			PF_SB_ATQBAH
+#define REG_LL_PROXY_H			PF_SB_ATQBAL
 
 /* Internal PHY timestamp address */
 #define TS_L(a, idx) ((a) + ((idx) * BYTES_PER_IDX_ADDR_L_U))
-- 
2.47.1


