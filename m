Return-Path: <netdev+bounces-186873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CECDAAA3B0B
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 00:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B74D4C4EC4
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08E327465F;
	Tue, 29 Apr 2025 22:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Drt/oDXu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5FA270EB2
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 22:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745964643; cv=none; b=u1UkfJhJ/tAkV43sxkHRWV6zqn/UftXYMMxsBjniJk3IY8cQkyrq8ffeiA0WkKtXbkTedHwIimy4mnAyymgMcJMnKFMKQ43XXge3q3gzMjfarx8BSvBsDSNoBCdFTpGHXI09e/oKGF+2lSyzWDkO3xfz7Q59CYX9UNKtuwA6VEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745964643; c=relaxed/simple;
	bh=4MBGhERd0WutBm3f5YueyVnOZsX0WNl8k4Kup481tgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoIihejCAf346beSfnkCM1QUdVAZP75d6WqJN8/XloTZJdEol0ni1mWb7F09os5fepBB31AYD5K9B7TGsKsekDTiQ7fHtn+2LROzYgKe/NOhsW5Rxfc4P+5rPQEsOTHPsWpn+fsJuCzrDbfVTCa7PdBkc4sw7agpqQevWUiF4o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Drt/oDXu; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745964642; x=1777500642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4MBGhERd0WutBm3f5YueyVnOZsX0WNl8k4Kup481tgg=;
  b=Drt/oDXuq72Nl/S1ZnABvXrhXvNHT05tPn+DB7Y3CEjeUmoGwR8Thjoa
   zSPygv95gVL3WugRypG/7Q6c1EW4PHNawGscXbrIxSmijY6UGa2DFT2gr
   bKx4x+dlZJw4wcxyFs8xIqofgNO6lxDXcmSrdDVPTFPfwAACnVFinsN82
   KeJo93Qm0kTzdnaRaj5rylqNqVAJ6c5X1XqCuhAmwEymmO46QTRupcrEh
   EIeQ1cfErDXbBfy5GMK7pUI46QCkK6tn1D+c920dP7+WC2z6TrOSORTri
   AJXXdC6bnJEM5Cz8vJzBvZaEJ6xSTjrsTWMKOYDVrugpJBnzKBGv9eEAK
   A==;
X-CSE-ConnectionGUID: ADr3HQibTl2f+5YPFEuNiA==
X-CSE-MsgGUID: glLTYOaKRbi7rnYDiTdayA==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47620132"
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="47620132"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2025 15:10:38 -0700
X-CSE-ConnectionGUID: OD/fPXlLT3aXGhXywijeJA==
X-CSE-MsgGUID: GJ50heDFS5+Ne68Idv57BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,250,1739865600"; 
   d="scan'208";a="138750769"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 29 Apr 2025 15:10:37 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	christopher.s.hall@intel.com,
	vinicius.gomes@intel.com,
	vinschen@redhat.com,
	dan.carpenter@linaro.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net 3/3] igc: fix lock order in igc_ptp_reset
Date: Tue, 29 Apr 2025 15:10:33 -0700
Message-ID: <20250429221034.3909139-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429221034.3909139-1-anthony.l.nguyen@intel.com>
References: <20250429221034.3909139-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

Commit 1a931c4f5e68 ("igc: add lock preventing multiple simultaneous PTM
transactions") added a new mutex to protect concurrent PTM transactions.
This lock is acquired in igc_ptp_reset() in order to ensure the PTM
registers are properly disabled after a device reset.

The flow where the lock is acquired already holds a spinlock, so acquiring
a mutex leads to a sleep-while-locking bug, reported both by smatch,
and the kernel test robot.

The critical section in igc_ptp_reset() does correctly use the
readx_poll_timeout_atomic variants, but the standard PTM flow uses regular
sleeping variants. This makes converting the mutex to a spinlock a bit
tricky.

Instead, re-order the locking in igc_ptp_reset. Acquire the mutex first,
and then the tmreg_lock spinlock. This is safe because there is no other
ordering dependency on these locks, as this is the only place where both
locks were acquired simultaneously. Indeed, any other flow acquiring locks
in that order would be wrong regardless.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Fixes: 1a931c4f5e68 ("igc: add lock preventing multiple simultaneous PTM transactions")
Link: https://lore.kernel.org/intel-wired-lan/Z_-P-Hc1yxcw0lTB@stanley.mountain/
Link: https://lore.kernel.org/intel-wired-lan/202504211511.f7738f5d-lkp@intel.com/T/#u
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 612ed26a29c5..efc7b30e4211 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -1290,6 +1290,8 @@ void igc_ptp_reset(struct igc_adapter *adapter)
 	/* reset the tstamp_config */
 	igc_ptp_set_timestamp_mode(adapter, &adapter->tstamp_config);
 
+	mutex_lock(&adapter->ptm_lock);
+
 	spin_lock_irqsave(&adapter->tmreg_lock, flags);
 
 	switch (adapter->hw.mac.type) {
@@ -1308,7 +1310,6 @@ void igc_ptp_reset(struct igc_adapter *adapter)
 		if (!igc_is_crosststamp_supported(adapter))
 			break;
 
-		mutex_lock(&adapter->ptm_lock);
 		wr32(IGC_PCIE_DIG_DELAY, IGC_PCIE_DIG_DELAY_DEFAULT);
 		wr32(IGC_PCIE_PHY_DELAY, IGC_PCIE_PHY_DELAY_DEFAULT);
 
@@ -1332,7 +1333,6 @@ void igc_ptp_reset(struct igc_adapter *adapter)
 			netdev_err(adapter->netdev, "Timeout reading IGC_PTM_STAT register\n");
 
 		igc_ptm_reset(hw);
-		mutex_unlock(&adapter->ptm_lock);
 		break;
 	default:
 		/* No work to do. */
@@ -1349,5 +1349,7 @@ void igc_ptp_reset(struct igc_adapter *adapter)
 out:
 	spin_unlock_irqrestore(&adapter->tmreg_lock, flags);
 
+	mutex_unlock(&adapter->ptm_lock);
+
 	wrfl();
 }
-- 
2.47.1


