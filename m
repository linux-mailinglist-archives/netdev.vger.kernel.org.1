Return-Path: <netdev+bounces-191818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F14ABD65F
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 13:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BDEE1BA37A8
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 11:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338BD28643F;
	Tue, 20 May 2025 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PbbEYLQX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6430F27F730
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 11:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747739325; cv=none; b=ldwcZgjSSeUGSgYOpgtI6t33JIg3j1IuyHvKknvL1NDnp4EuDSVEYn/CfM2FdSPoWenVmvz9+kb0DvCdh9Lk1lA56KJ0IMt9f9l3hY+jakQKIlX2aJL9+DDIm5y2PjZB7xn8Hj0WyrHbau3ZoejRhuyFHMmhIOfIA95HEmS2wrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747739325; c=relaxed/simple;
	bh=LpB/bL6N/QlssTjsWxnMEK+/tE3TscoCSAS/CeOtgWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2j8tqYhtr3RDvi9T4VSMAxS4H0TogEc8y/el/DXt/thzoJ1jFJIxeYotPLT6yF+42nPxRxRfv4XXkUluJfF8EVDH/KlVZKxkH8SPfrQ6jNHjvSzFaKKzQd65ahrujp+BgZzvUzSntJIkeG0n+tXZeOgp4Q9hE5wopeYlb6HFS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PbbEYLQX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747739323; x=1779275323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LpB/bL6N/QlssTjsWxnMEK+/tE3TscoCSAS/CeOtgWg=;
  b=PbbEYLQXtzBkxv1SaVsXEgDNQqXPwI3GyebXV8hzaTdcqXURQUOsJvHP
   lz65nZ2sBR31dho8sev7ZxsaHS4zH2ccrSIs1r7cOOrY9QdYxMF8U7M7n
   8USnanz/nxXU+BfqA0tkDwitB85EF/f8ldXW6Lx/vXEl8911t870jz9n8
   0wfVf9+SaZrJebemAui3tO9fphJcsZ1ZKeRv2kR0ZZi0Mlhq38MGPOAnG
   AJ6twuUKxGGn51GVhB9CrVJ3QzKPByxrpLbof4vo8mZUVFEhSoMIV52cG
   gWYje1FNKlZT3sE6JxWps4k014pfRPUHkjgbytnP86fNi3LmdLAM0yy7h
   A==;
X-CSE-ConnectionGUID: SA2PgLc2QCCWZ/KOFuM3ag==
X-CSE-MsgGUID: WZjlaReZQbSsGMQ3Vxj1mg==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="75069282"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="75069282"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 04:08:42 -0700
X-CSE-ConnectionGUID: fyxSlZ7JTK+9mnLOFg6NWw==
X-CSE-MsgGUID: DSQu1RuRQpS7aZJ+X/io+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="140173076"
Received: from kkolacin-desk1.ger.corp.intel.com (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.155])
  by orviesa007.jf.intel.com with ESMTP; 20 May 2025 04:08:41 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Milena Olech <milena.olech@intel.com>
Subject: [PATCH iwl-next 4/4] ice: read Tx timestamps in the IRQ top half
Date: Tue, 20 May 2025 13:06:29 +0200
Message-ID: <20250520110823.1937981-10-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520110823.1937981-6-karol.kolacinski@intel.com>
References: <20250520110823.1937981-6-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With sideband queue using delays and spin locks, it is possible to
read timestamps from the PHY in the top half of the interrupt.

This removes bottom half scheduling delays and improves timestamping
read times significantly, from >2 ms to <50 us.

Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 46 ++++++++++++------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index b8e55931fc52..e1068489fde5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2694,39 +2694,37 @@ irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
 
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
+	{
+		struct ice_ptp_tx *tx = &pf->ptp.port.tx;
+		u8 idx;
+
+		if (!ice_pf_state_is_nominal(pf))
+			return IRQ_HANDLED;
+
 		/* E810 capable of low latency timestamping with interrupt can
 		 * request a single timestamp in the top half and wait for
 		 * a second LL TS interrupt from the FW when it's ready.
 		 */
-		if (hw->dev_caps.ts_dev_info.ts_ll_int_read) {
-			struct ice_ptp_tx *tx = &pf->ptp.port.tx;
-			u8 idx;
-
-			if (!ice_pf_state_is_nominal(pf))
+		if (!hw->dev_caps.ts_dev_info.ts_ll_int_read) {
+			if (!ice_ptp_pf_handles_tx_interrupt(pf))
 				return IRQ_HANDLED;
 
-			spin_lock(&tx->lock);
-			idx = find_next_bit_wrap(tx->in_use, tx->len,
-						 tx->last_ll_ts_idx_read + 1);
-			if (idx != tx->len)
-				ice_ptp_req_tx_single_tstamp(tx, idx);
-			spin_unlock(&tx->lock);
-
-			return IRQ_HANDLED;
+			set_bit(ICE_MISC_THREAD_TX_TSTAMP, pf->misc_thread);
+			return IRQ_WAKE_THREAD;
 		}
-		fallthrough; /* non-LL_TS E810 */
-	case ICE_MAC_GENERIC:
-	case ICE_MAC_GENERIC_3K_E825:
-		/* All other devices process timestamps in the bottom half due
-		 * to sleeping or polling.
-		 */
-		if (!ice_ptp_pf_handles_tx_interrupt(pf))
-			return IRQ_HANDLED;
 
-		set_bit(ICE_MISC_THREAD_TX_TSTAMP, pf->misc_thread);
-		return IRQ_WAKE_THREAD;
+		spin_lock(&tx->lock);
+		idx = find_next_bit_wrap(tx->in_use, tx->len,
+					 tx->last_ll_ts_idx_read + 1);
+		if (idx != tx->len)
+			ice_ptp_req_tx_single_tstamp(tx, idx);
+		spin_unlock(&tx->lock);
+
+		return IRQ_HANDLED;
+	}
 	case ICE_MAC_E830:
-		/* E830 can read timestamps in the top half using rd32() */
+	case ICE_MAC_GENERIC:
+	case ICE_MAC_GENERIC_3K_E825:
 		if (ice_ptp_process_ts(pf) == ICE_TX_TSTAMP_WORK_PENDING) {
 			/* Process outstanding Tx timestamps. If there
 			 * is more work, re-arm the interrupt to trigger again.
-- 
2.49.0


