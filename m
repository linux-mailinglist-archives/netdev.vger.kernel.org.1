Return-Path: <netdev+bounces-65006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D655838C9C
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 11:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E399F1F23792
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 10:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A54F5D8F4;
	Tue, 23 Jan 2024 10:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R62tH+1m"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF98D5D73A
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706007123; cv=none; b=dgpH5ZmUptIp5NszGryA5HKwCTuafhRWkJYrNEG+CNHlAVhDCns5s1fXH+KaTBiRx+HmRczlBsTTR1tn/iSwfcGDtyOqqPNsjbg2cs9eNiP/ZUzG41u0wlsKxx2aYSKHa766M8F6PqM2g0NWN0R/9IVE2zXYHO1bxnx4faM2w/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706007123; c=relaxed/simple;
	bh=l2zbQsoH+QHd/usOBxoSPjVj31op4Z/h6N+2WiXcFsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WhpoKVBGxHi+oM4WirjOi9B0ogeDgad58oi35k7JkQRCSUTZ1QkgK8I41lqj0PQNCxfUyMUt8XuJtkYOhXt9hedjnFn3wvJQokWmnSO1WGzLIMWuiVIlLGRVofpDQADC55B21prJ4OP5TchoL+tTWRwUdKCuhbBksPG5yjubyK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R62tH+1m; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706007122; x=1737543122;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l2zbQsoH+QHd/usOBxoSPjVj31op4Z/h6N+2WiXcFsc=;
  b=R62tH+1mP8KEFrRbNQBsnKDOFhDun/OExfsGldXXzdoDF52D/SGfux0h
   eoxNXWOotX1q3OnU/VAOeMTWAuU/XSXF6Ps3IIyFKUj7rDEtjbzBCRFnR
   i1WtlWyNtMZLWPF1B4xtUa2t8Lo8sxFDMaP2fD75FepfGyHA4toS9sUD2
   vfPfKt/9uFQSRG2JAijI+j1++YrNa/2i3QtKTp8m0Eise6M/HkuK7u8sm
   aNkYMBrssUsq+F1xoAVHFLFLTX4woo8sqvE8GrppHFj8CmIWI2XI1DhFi
   IO/gfrKERHk94ou0lQS4L5RrJkkvvriBUxuKTuL06gboZFiKI8BHFJTeD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="8877622"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="8877622"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 02:52:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="34365407"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orviesa001.jf.intel.com with ESMTP; 23 Jan 2024 02:52:00 -0800
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v7 iwl-next 4/7] ice: don't check has_ready_bitmap in E810 functions
Date: Tue, 23 Jan 2024 11:51:28 +0100
Message-Id: <20240123105131.2842935-5-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240123105131.2842935-1-karol.kolacinski@intel.com>
References: <20240123105131.2842935-1-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

E810 hardware does not have a Tx timestamp ready bitmap. Don't check
has_ready_bitmap in E810-specific functions.
Add has_ready_bitmap check in ice_ptp_process_tx_tstamp() to stop
relying on the fact that ice_get_phy_tx_tstamp_ready() returns all 1s.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
V5 -> V6: introduced this patch which was a part of a previous one

 drivers/net/ethernet/intel/ice/ice_ptp.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index a10e0018b2e2..69d11dbda22c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -601,17 +601,13 @@ void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx)
 	/* Read the low 32 bit value */
 	raw_tstamp |= (u64)rd32(&pf->hw, PF_SB_ATQBAH);
 
-	/* For PHYs which don't implement a proper timestamp ready bitmap,
-	 * verify that the timestamp value is different from the last cached
-	 * timestamp. If it is not, skip this for now assuming it hasn't yet
-	 * been captured by hardware.
+	/* Devices using this interface always verify the timestamp differs
+	 * relative to the last cached timestamp value.
 	 */
-	if (!drop_ts && !tx->has_ready_bitmap &&
-	    raw_tstamp == tx->tstamps[idx].cached_tstamp)
+	if (raw_tstamp == tx->tstamps[idx].cached_tstamp)
 		return;
 
-	if (!tx->has_ready_bitmap && raw_tstamp)
-		tx->tstamps[idx].cached_tstamp = raw_tstamp;
+	tx->tstamps[idx].cached_tstamp = raw_tstamp;
 	clear_bit(idx, tx->in_use);
 	skb = tx->tstamps[idx].skb;
 	tx->tstamps[idx].skb = NULL;
@@ -701,9 +697,11 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	hw = &pf->hw;
 
 	/* Read the Tx ready status first */
-	err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
-	if (err)
-		return;
+	if (tx->has_ready_bitmap) {
+		err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
+		if (err)
+			return;
+	}
 
 	/* Drop packets if the link went down */
 	link_up = ptp_port->link_up;
@@ -731,7 +729,8 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 		 * If we do not, the hardware logic for generating a new
 		 * interrupt can get stuck on some devices.
 		 */
-		if (!(tstamp_ready & BIT_ULL(phy_idx))) {
+		if (tx->has_ready_bitmap &&
+		    !(tstamp_ready & BIT_ULL(phy_idx))) {
 			if (drop_ts)
 				goto skip_ts_read;
 
-- 
2.40.1


