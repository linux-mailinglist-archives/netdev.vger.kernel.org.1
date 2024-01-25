Return-Path: <netdev+bounces-66013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD44E83CF0B
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 22:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34DE01F28318
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 21:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FD713B7B0;
	Thu, 25 Jan 2024 21:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CRPReSWs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E98D13AA51
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 21:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219888; cv=none; b=r3n4bDaysL+S+sxVyaTaXXw/fYr5Cr6zKDx1aiAsbtsFVb8yM+hYtYdzHCBz23S8PMB67lferSw7jLg9S3EHbxtEXqGYxlkt938HXQPL0BykzjJVNf3WfJLpkgQ40Gi4FaIzR2vgA4U++kyOSxEa+IbZcFwQEs5PxTWu47hxXJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219888; c=relaxed/simple;
	bh=DiThgfsoGsR+pFKV5qWLElB1Wl34x5slFqPiPD8NROA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZ6s6GO8c8sQ8HvLtL26vlxx2KU8UxCX+LaiSzaWQobHBO/SnT4YuC/P8MVCNpfhq15y2L2dNz3o9oIGfJnN7Vx1G0M5qKUxF7hqYEHUBPnfD3FcTBPuOF5Os2JIvsIT3RnJCfGZFV7e3D0AAkzKsJPs1YkrqLKkwfVUlM3Xw10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CRPReSWs; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706219887; x=1737755887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DiThgfsoGsR+pFKV5qWLElB1Wl34x5slFqPiPD8NROA=;
  b=CRPReSWsl6mL68oN4cRDYL6gk0ofXS8n/+7FXXtGgf+JF2sL3FWkKxrq
   P8hT+nRXNZ27ICNSt3tmZU7KeiZyGSD7ydCEO89+X4qGqEUH+rNRjZvLq
   aB38fYpsiF9A7Ci2mp5/UaHfsbvFetf+pLZ1lOK9pnnum9KdLRDicZaat
   ffZhQgEgHzpH2ff/VKPd9LDGxda37SNq5GV73iNrM1bapNWhV0f8uaSuD
   bBQlivfr3E8cLnthH/ZriLqFnVcjRl+xvZg/I1VfIkl+jXR9KCDYtngJZ
   B+MeXa21YFIwV5LZhkyIyYImPRlSNxVkCIlsnzkntg7lZHvDJIojqTmHt
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9069096"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9069096"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 13:58:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="35239927"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 25 Jan 2024 13:58:03 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 3/7] ice: rename verify_cached to has_ready_bitmap
Date: Thu, 25 Jan 2024 13:57:51 -0800
Message-ID: <20240125215757.2601799-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240125215757.2601799-1-anthony.l.nguyen@intel.com>
References: <20240125215757.2601799-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The tx->verify_cached flag is used to inform the Tx timestamp tracking
code whether it needs to verify the cached Tx timestamp value against
a previous captured value. This is necessary on E810 hardware which does
not have a Tx timestamp ready bitmap.

In addition, we currently rely on the fact that the
ice_get_phy_tx_tstamp_ready() function returns all 1s for E810 hardware.
Instead of introducing a brand new flag, rename and verify_cached to
has_ready_bitmap, inverting the relevant checks.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 12 ++++++------
 drivers/net/ethernet/intel/ice/ice_ptp.h |  8 +++++---
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 96b5f992f127..a10e0018b2e2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -606,11 +606,11 @@ void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx)
 	 * timestamp. If it is not, skip this for now assuming it hasn't yet
 	 * been captured by hardware.
 	 */
-	if (!drop_ts && tx->verify_cached &&
+	if (!drop_ts && !tx->has_ready_bitmap &&
 	    raw_tstamp == tx->tstamps[idx].cached_tstamp)
 		return;
 
-	if (tx->verify_cached && raw_tstamp)
+	if (!tx->has_ready_bitmap && raw_tstamp)
 		tx->tstamps[idx].cached_tstamp = raw_tstamp;
 	clear_bit(idx, tx->in_use);
 	skb = tx->tstamps[idx].skb;
@@ -751,7 +751,7 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 		 * from the last cached timestamp. If it is not, skip this for
 		 * now assuming it hasn't yet been captured by hardware.
 		 */
-		if (!drop_ts && tx->verify_cached &&
+		if (!drop_ts && !tx->has_ready_bitmap &&
 		    raw_tstamp == tx->tstamps[idx].cached_tstamp)
 			continue;
 
@@ -761,7 +761,7 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 
 skip_ts_read:
 		spin_lock_irqsave(&tx->lock, flags);
-		if (tx->verify_cached && raw_tstamp)
+		if (!tx->has_ready_bitmap && raw_tstamp)
 			tx->tstamps[idx].cached_tstamp = raw_tstamp;
 		clear_bit(idx, tx->in_use);
 		skb = tx->tstamps[idx].skb;
@@ -1014,7 +1014,7 @@ ice_ptp_init_tx_e82x(struct ice_pf *pf, struct ice_ptp_tx *tx, u8 port)
 	tx->block = port / ICE_PORTS_PER_QUAD;
 	tx->offset = (port % ICE_PORTS_PER_QUAD) * INDEX_PER_PORT_E82X;
 	tx->len = INDEX_PER_PORT_E82X;
-	tx->verify_cached = 0;
+	tx->has_ready_bitmap = 1;
 
 	return ice_ptp_alloc_tx_tracker(tx);
 }
@@ -1037,7 +1037,7 @@ ice_ptp_init_tx_e810(struct ice_pf *pf, struct ice_ptp_tx *tx)
 	 * verify new timestamps against cached copy of the last read
 	 * timestamp.
 	 */
-	tx->verify_cached = 1;
+	tx->has_ready_bitmap = 0;
 
 	return ice_ptp_alloc_tx_tracker(tx);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index afe454abe997..aa7a5588d11d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -100,7 +100,7 @@ struct ice_perout_channel {
  * the last timestamp we read for a given index. If the current timestamp
  * value is the same as the cached value, we assume a new timestamp hasn't
  * been captured. This avoids reporting stale timestamps to the stack. This is
- * only done if the verify_cached flag is set in ice_ptp_tx structure.
+ * only done if the has_ready_bitmap flag is not set in ice_ptp_tx structure.
  */
 struct ice_tx_tstamp {
 	struct sk_buff *skb;
@@ -130,7 +130,9 @@ enum ice_tx_tstamp_work {
  * @init: if true, the tracker is initialized;
  * @calibrating: if true, the PHY is calibrating the Tx offset. During this
  *               window, timestamps are temporarily disabled.
- * @verify_cached: if true, verify new timestamp differs from last read value
+ * @has_ready_bitmap: if true, the hardware has a valid Tx timestamp ready
+ *                    bitmap register. If false, fall back to verifying new
+ *                    timestamp values against previously cached copy.
  * @last_ll_ts_idx_read: index of the last LL TS read by the FW
  */
 struct ice_ptp_tx {
@@ -143,7 +145,7 @@ struct ice_ptp_tx {
 	u8 len;
 	u8 init : 1;
 	u8 calibrating : 1;
-	u8 verify_cached : 1;
+	u8 has_ready_bitmap : 1;
 	s8 last_ll_ts_idx_read;
 };
 
-- 
2.41.0


