Return-Path: <netdev+bounces-175880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA5EA67DAA
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 21:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0639170DE4
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 20:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0A9212D62;
	Tue, 18 Mar 2025 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YiWsC0T7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760551DE4FE
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328324; cv=none; b=Mm+KWx2/xUuIINYwvcy320K2yNdnmD3CUvnzEIV1ycjjUrqQYiKYeMelQMCJSa+uRLs6Refk7Ij7R8jTiRfTYLg3HECFpHp9nWrf/+H6i/mbbu1tGUBW9LAZ7UdivIW12UNC1IU0KT7J8qjX+wKVfA3YOWsENZCEAahKWEFAxzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328324; c=relaxed/simple;
	bh=b6ApvI6CbYczUAGudmRUo/uw6X9KZRnk2rxj0Acg4ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EAHT0Jo2pBSslulbybl6UlMbCEutSRF4E0C1cKaTd3gcWlvJQc/fNk+mWpWLMlG0wuauPisAse4lYUJmchfgMB54U7iRgPFdpZ5K5iO9Wq5q6BiT1imS0/3Q/yO1iKDM0rT1Ye2qmvgYkIyO7B3ukhCC+RL/8wp05knf6l2pFdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YiWsC0T7; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742328323; x=1773864323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b6ApvI6CbYczUAGudmRUo/uw6X9KZRnk2rxj0Acg4ZI=;
  b=YiWsC0T74G8w/02Cq9CPGkTOrJretEyB8vb4EMYcoMVpaE77XpWDmX+z
   hyqsOqaKGayNon/ss/vLPxjW7BlFXCSZkDMWVXl6bX5xGIIzxUts3pzU2
   mm9LZbw5NbT676+DlvFEIRNusFXyQnahHWFN0sZo8ScoVTyWQVyTcVO5h
   OSaxAekNTZs7wVrd/W6jqOZd3bNJvVK7B8CeVKRHS7Dn8M/0G03O2XiG3
   0mBV1R7wfAzzTlmo5VrX9xrBt/vw7yVo4OizZgYFPaaVqS18Ba4Ztr6r2
   bnDKj1E792TH4TSW5f/A61DACPrsl3osN/hYS8x/tWkqCBHsVl6zhLxfU
   A==;
X-CSE-ConnectionGUID: YYU+BRFDQyqbc4E5M4VqbA==
X-CSE-MsgGUID: LxjYlG6MRKKjQ60vViNoVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43593016"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="43593016"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 13:05:20 -0700
X-CSE-ConnectionGUID: CJXvswzdS+CuYKZCRLOXOw==
X-CSE-MsgGUID: f6T8k14JQd6eIUbBIkVYTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="153363128"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 18 Mar 2025 13:05:18 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	arkadiusz.kubalewski@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 2/9] ice: ensure periodic output start time is in the future
Date: Tue, 18 Mar 2025 13:04:46 -0700
Message-ID: <20250318200511.2958251-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250318200511.2958251-1-anthony.l.nguyen@intel.com>
References: <20250318200511.2958251-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

On E800 series hardware, if the start time for a periodic output signal is
programmed into GLTSYN_TGT_H and GLTSYN_TGT_L registers, the hardware logic
locks up and the periodic output signal never starts. Any future attempt to
reprogram the clock function is futile as the hardware will not reset until
a power on.

The ice_ptp_cfg_perout function has logic to prevent this, as it checks if
the requested start time is in the past. If so, a new start time is
calculated by rounding up.

Since commit d755a7e129a5 ("ice: Cache perout/extts requests and check
flags"), the rounding is done to the nearest multiple of the clock period,
rather than to a full second. This is more accurate, since it ensures the
signal matches the user request precisely.

Unfortunately, there is a race condition with this rounding logic. If the
current time is close to the multiple of the period, we could calculate a
target time that is extremely soon. It takes time for the software to
program the registers, during which time this requested start time could
become a start time in the past. If that happens, the periodic output
signal will lock up.

For large enough periods, or for the logic prior to the mentioned commit,
this is unlikely. However, with the new logic rounding to the period and
with a small enough period, this becomes inevitable.

For example, attempting to enable a 10MHz signal requires a period of 100
nanoseconds. This means in the *best* case, we have 99 nanoseconds to
program the clock output. This is essentially impossible, and thus such a
small period practically guarantees that the clock output function will
lock up.

To fix this, add some slop to the clock time used to check if the start
time is in the past. Because it is not critical that output signals start
immediately, but it *is* critical that we do not brick the function, 0.5
seconds is selected. This does mean that any requested output will be
delayed by at least 0.5 seconds.

This slop is applied before rounding, so that we always round up to the
nearest multiple of the period that is at least 0.5 seconds in the future,
ensuring a minimum of 0.5 seconds to program the clock output registers.

Finally, to ensure that the hardware registers programming the clock output
complete in a timely manner, add a write flush to the end of
ice_ptp_write_perout. This ensures we don't risk any issue with PCIe
transaction batching.

Strictly speaking, this fixes a race condition all the way back at the
initial implementation of periodic output programming, as it is
theoretically possible to trigger this bug even on the old logic when
always rounding to a full second. However, the window is narrow, and the
code has been refactored heavily since then, making a direct backport not
apply cleanly.

Fixes: d755a7e129a5 ("ice: Cache perout/extts requests and check flags")
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index e26320ce52ca..a99e0fbd0b8b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1783,6 +1783,7 @@ static int ice_ptp_write_perout(struct ice_hw *hw, unsigned int chan,
 				  8 + chan + (tmr_idx * 4));
 
 	wr32(hw, GLGEN_GPIO_CTL(gpio_pin), val);
+	ice_flush(hw);
 
 	return 0;
 }
@@ -1843,9 +1844,10 @@ static int ice_ptp_cfg_perout(struct ice_pf *pf, struct ptp_perout_request *rq,
 		div64_u64_rem(start, period, &phase);
 
 	/* If we have only phase or start time is in the past, start the timer
-	 * at the next multiple of period, maintaining phase.
+	 * at the next multiple of period, maintaining phase at least 0.5 second
+	 * from now, so we have time to write it to HW.
 	 */
-	clk = ice_ptp_read_src_clk_reg(pf, NULL);
+	clk = ice_ptp_read_src_clk_reg(pf, NULL) + NSEC_PER_MSEC * 500;
 	if (rq->flags & PTP_PEROUT_PHASE || start <= clk - prop_delay_ns)
 		start = div64_u64(clk + period - 1, period) * period + phase;
 
-- 
2.47.1


