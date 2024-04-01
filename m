Return-Path: <netdev+bounces-83787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B035B894449
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 19:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD492835C4
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 17:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7454E1D5;
	Mon,  1 Apr 2024 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B25Tw9cn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77794CE04
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711992271; cv=none; b=Mqlq9ZJZwxoTEEnGWqupLEg0jYhHNXogdDfE7KpylTG5xY38Or4tx88EebKr1ZindxUM/1t30cap/sCKw+4m74G311bGwZ2Ow/HNBvgrjz3G06cW0GXrxcQhq/YvVWrlGdjBnSMiKaph4xhvKTe0og2mtVSdqQr7RRyREr2c4Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711992271; c=relaxed/simple;
	bh=/b0DcjJpYb+Dv161QhUkOmh45tlANY3i1m4a0eZqaqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1ufWkz8Od+S9fAvfE3rmujJ0KZGn1KoJVwad4eTyktS+Mwez9hExJx8oOPjDnNxrElqnwMOt3+68iIuHUchCB89rcw1CKnbnip5VDUqWmOpg7o4GBsFPqt7eoPOUGOOxZKP6akpNZRaWTN0jyvH8ceRJSg+NB+3eCCr0CIhcAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B25Tw9cn; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711992270; x=1743528270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/b0DcjJpYb+Dv161QhUkOmh45tlANY3i1m4a0eZqaqk=;
  b=B25Tw9cn8jobaHtHzk8w1g7fLjVWD+ZWzCG4AeTQCLzcPLokKUJYIdOs
   YpGrjp1MLpTlPQCgi9lnYky4rw9RvYlOyctDfkeOe91MKvDJK5YwCTwok
   I6xFciLFKz7s0XOHYKoLOlRK7BGYgUKdA9onRAtuPG32mnzD5ktSm0UHo
   0Jipads9/3dzL9OgMp2Psod+TJ0upnHZ6HiF9bFtEjlmm0uRAs99ohQkg
   3Ymf2yANAEOFbEqXRs4jaLdoq/8FsaNRMRTfc+PlvXp1zCD9wfsaVIp4W
   0XG00rwYRi55XJ+vQKjJ4StDrejg09dTeplKfsnC6gfckzICYMKPy+NNN
   w==;
X-CSE-ConnectionGUID: LgEDt+jSQ4KqkwsP4ouYRQ==
X-CSE-MsgGUID: k27l7/HTQW6RZmVnrvVyKg==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="29606154"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="29606154"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 10:24:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="55235085"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 01 Apr 2024 10:24:27 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Schmidt <mschmidt@redhat.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next 3/8] ice: fold ice_ptp_read_time into ice_ptp_gettimex64
Date: Mon,  1 Apr 2024 10:24:13 -0700
Message-ID: <20240401172421.1401696-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240401172421.1401696-1-anthony.l.nguyen@intel.com>
References: <20240401172421.1401696-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Schmidt <mschmidt@redhat.com>

This is a cleanup. It is unnecessary to have this function just to call
another function.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 25 +++---------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 0875f37add78..0f17fc1181d2 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1166,26 +1166,6 @@ static void ice_ptp_reset_cached_phctime(struct ice_pf *pf)
 	ice_ptp_mark_tx_tracker_stale(&pf->ptp.port.tx);
 }
 
-/**
- * ice_ptp_read_time - Read the time from the device
- * @pf: Board private structure
- * @ts: timespec structure to hold the current time value
- * @sts: Optional parameter for holding a pair of system timestamps from
- *       the system clock. Will be ignored if NULL is given.
- *
- * This function reads the source clock registers and stores them in a timespec.
- * However, since the registers are 64 bits of nanoseconds, we must convert the
- * result to a timespec before we can return.
- */
-static void
-ice_ptp_read_time(struct ice_pf *pf, struct timespec64 *ts,
-		  struct ptp_system_timestamp *sts)
-{
-	u64 time_ns = ice_ptp_read_src_clk_reg(pf, sts);
-
-	*ts = ns_to_timespec64(time_ns);
-}
-
 /**
  * ice_ptp_write_init - Set PHC time to provided value
  * @pf: Board private structure
@@ -1926,9 +1906,10 @@ ice_ptp_gettimex64(struct ptp_clock_info *info, struct timespec64 *ts,
 		   struct ptp_system_timestamp *sts)
 {
 	struct ice_pf *pf = ptp_info_to_pf(info);
+	u64 time_ns;
 
-	ice_ptp_read_time(pf, ts, sts);
-
+	time_ns = ice_ptp_read_src_clk_reg(pf, sts);
+	*ts = ns_to_timespec64(time_ns);
 	return 0;
 }
 
-- 
2.41.0


