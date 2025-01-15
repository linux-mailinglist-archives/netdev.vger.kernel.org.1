Return-Path: <netdev+bounces-158313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EC0A115E5
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 01:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E7723A8884
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF0A2AD0C;
	Wed, 15 Jan 2025 00:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q2XUgycg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6E9182C5
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 00:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736899740; cv=none; b=MXr4KJnl3Hl0BgAfpouKJGjxLu8Vnih2MGzcp0+D5YY1ZY17gewRV2k4/z6i7ApdahS71OYLz0Ut33MHyHl4dr2YuUeGYclf9/5zPkWXNJ2mVsQdkuC31hgbV2IaZ05W5PumEnrRd7Iai8JE2p0EmlxRwwRQ8exy7cwd2qzqMQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736899740; c=relaxed/simple;
	bh=W1yCDyaLWJd/yr1q4TJI18cR0PCQ8U+TKaUUD/Qxwao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ik/jLRiFN1PB7PDKQQLWxdbh0TSYzBd0SpKQp2BR8WrgWDJ3bp31vrUkCQaeXokWO2PulXHInByf9fk7LEXUGPwdKLtBNu6Vw8JhuHTFcCjYRrDDnCfxH65d53UJJB4dSTBd8ly0xiajQyr9VGO29X7q7rH40TMHQ9gVYAxYqHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q2XUgycg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736899738; x=1768435738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W1yCDyaLWJd/yr1q4TJI18cR0PCQ8U+TKaUUD/Qxwao=;
  b=Q2XUgycgfKrAkOJ+duaZruCj2LTimjh+P/91nUp6Kwy7dZUrXx14feZl
   0Ym83jQzUm+Ef3ckHCpiWTSdXQQN6WykEr0l6tKrp+KKpIMOZzEZTmd5w
   v3hsQKje9ktNwO/ykpHkhtCMmC7xB3DsOxIXwfVl4uGHf4ClAtdAf47IB
   AD+YWejpQxFHQy2m5ym29Bdg/A5+qcimo+WJBQWIQLGI+WeXa/Ciyu94x
   HBF+w4Yrf5/6bp371J9XZVsza/DVBZnh+qGfDhnspm/eB8K1vrcpcdb5X
   Jqm42hUhD0DYZf5DagBpG10pZjY/7u4aVf5Eas8Qyir/ZCZTpGGs+ReaT
   g==;
X-CSE-ConnectionGUID: D+rP+p4DSdGQL0Hb3TncdQ==
X-CSE-MsgGUID: LmlVqmDORzmRhcIXX7booA==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="40897507"
X-IronPort-AV: E=Sophos;i="6.12,315,1728975600"; 
   d="scan'208";a="40897507"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 16:08:54 -0800
X-CSE-ConnectionGUID: YRPmN1JVS4CFLfe7UNCDeA==
X-CSE-MsgGUID: hMp3D7ZoRsaQYZJVyXzcjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128211429"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 14 Jan 2025 16:08:54 -0800
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
Subject: [PATCH net-next v2 09/13] ice: rename TS_LL_READ* macros to REG_LL_PROXY_H_*
Date: Tue, 14 Jan 2025 16:08:35 -0800
Message-ID: <20250115000844.714530-10-anthony.l.nguyen@intel.com>
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
index 0c1c691f51d5..da9ce758b250 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -4861,24 +4861,24 @@ ice_read_phy_tstamp_ll_e810(struct ice_hw *hw, u8 idx, u8 *hi, u32 *lo)
 	int err;
 
 	/* Write TS index to read to the PF register so the FW can read it */
-	val = FIELD_PREP(TS_LL_READ_TS_IDX, idx) | TS_LL_READ_TS;
-	wr32(hw, PF_SB_ATQBAL, val);
+	val = FIELD_PREP(REG_LL_PROXY_H_TS_IDX, idx) | REG_LL_PROXY_H_EXEC;
+	wr32(hw, REG_LL_PROXY_H, val);
 
 	/* Read the register repeatedly until the FW provides us the TS */
 	err = read_poll_timeout_atomic(rd32, val,
-				       !FIELD_GET(TS_LL_READ_TS, val), 10,
-				       TS_LL_READ_TIMEOUT, false, hw,
-				       PF_SB_ATQBAL);
+				       !FIELD_GET(REG_LL_PROXY_H_EXEC, val), 10,
+				       REG_LL_PROXY_H_TIMEOUT_US, false, hw,
+				       REG_LL_PROXY_H);
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


