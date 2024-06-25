Return-Path: <netdev+bounces-106584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA733916EC0
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 19:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E86891C22FA3
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B501E176AAE;
	Tue, 25 Jun 2024 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aCkkCuY5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B71217556D
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334986; cv=none; b=GhIX/iuIgxLOmjTWAPno8aPX8GGxwhE+Q49Xk8Qf7LufiDnxgjAxmu8L5TKp4MT+snSRRB3O+77KFSa/VEqAYMBjouD/OCL2buXVV5IqFOJHOjxS+Yym2aq7tDTUYw50XmAsPOruJT4TUqu+97GQpNXrWA8yFB+XlYmzLIv+wRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334986; c=relaxed/simple;
	bh=NXEeve5ETMkKU7uSLvphekLowSXS9yulto4jUYWRXR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dcXNFANTeZtDmx4mf9HgWnUEfVWtUW/iqqa2Nzw4E2kq6oEtjlXqPoOoykyCkm/Wl6XqdLeZySry+fxNZt3xrs44k1ZzMBuZIAtBI8wi9tsIPT6lJH/EFhaVBPVZOJkiTNN3i4X0/YDcq6PQ3lqkhHG2lmSCUQdAW+EQS2/mZQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aCkkCuY5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719334985; x=1750870985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NXEeve5ETMkKU7uSLvphekLowSXS9yulto4jUYWRXR4=;
  b=aCkkCuY5NAhMIZzY4nVvokQ43SpXkixZvN1HKaUzWpGHw61yO/hxdrC9
   i51SI/wNYAnE4jAROUqRhi4UemvFIa/rvUgWd97R3X5eOhbSS3vcpPG+j
   HgmCorHC5WV4L9/7DplJ257C1VjkT1OmVl8t3phgxHRL4uEQ8l8a/XnTo
   Vw71HfQZFA2yOjnTiLDlg/P1EZWT9TScsWLUoM2v1zwl5IM4yMOcyfU0q
   XBawjscXRsOjEHhLVu4rET0v3XOpnTbA011NH+T8br5PGgs+nntSs+nkI
   wxHvnI4fiDz8k3edxrAc4ETBScXwK2pnOCV/R7SVGnp1LMzPvXxG4lEfi
   Q==;
X-CSE-ConnectionGUID: +PPEeczaTNW4J+CHCCLhsw==
X-CSE-MsgGUID: AXbSdTEqT9GbCrnvaNuj3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="33825653"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="33825653"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 10:02:54 -0700
X-CSE-ConnectionGUID: yKvZuWu0QUaMiZEvmGC0XQ==
X-CSE-MsgGUID: MjY1WSUoQTyIX0yQo+U4zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48893928"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 25 Jun 2024 10:02:54 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 2/4] ice: Don't process extts if PTP is disabled
Date: Tue, 25 Jun 2024 10:02:45 -0700
Message-ID: <20240625170248.199162-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625170248.199162-1-anthony.l.nguyen@intel.com>
References: <20240625170248.199162-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_ptp_extts_event() function can race with ice_ptp_release() and
result in a NULL pointer dereference which leads to a kernel panic.

Panic occurs because the ice_ptp_extts_event() function calls
ptp_clock_event() with a NULL pointer. The ice driver has already
released the PTP clock by the time the interrupt for the next external
timestamp event occurs.

To fix this, modify the ice_ptp_extts_event() function to check the
PTP state and bail early if PTP is not ready.

Fixes: 172db5f91d5f ("ice: add support for auxiliary input/output pins")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index d8ff9f26010c..0500ced1adf8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1559,6 +1559,10 @@ void ice_ptp_extts_event(struct ice_pf *pf)
 	u8 chan, tmr_idx;
 	u32 hi, lo;
 
+	/* Don't process timestamp events if PTP is not ready */
+	if (pf->ptp.state != ICE_PTP_READY)
+		return;
+
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 	/* Event time is captured by one of the two matched registers
 	 *      GLTSYN_EVNT_L: 32 LSB of sampled time event
-- 
2.41.0


