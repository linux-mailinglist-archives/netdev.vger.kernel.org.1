Return-Path: <netdev+bounces-178700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04571A78543
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 01:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FCD716BF91
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 23:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC9F21C16A;
	Tue,  1 Apr 2025 23:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mh5JhYkl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B7E21638D
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 23:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743550569; cv=none; b=Vxfrb1BNnIEQbcWEYT4gS2CPvqgxBCTaMcYy1X6X75nAKFa5VYfW8RBJNkEiPo15VZFrBlXC+0nY5oarOizb3gPUMAJxCH5WQK+zNT4YnUGeNW3CAqHiY5xTdSWnSYFAVeZan8pAHEu5vCXMSYC858u7tWzP3rwe2ChmptLwLKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743550569; c=relaxed/simple;
	bh=DXDuX19oMmpBepGy4338YX9qnnHy5wXHexuyYjln/4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dPUtweO7ezRIqt1xP6+ix16SL8JzS/k2o6NLVpTZyH/I3gt9tvODq1voS+HIht3UJ3bt0+MNK4R4mDgqsPxbALGHm0Xx/Qb0jOTFi86ZsNPIp9gYijMrQaEtbrZJgCi6TG5vfRdDcN01PIolpvsR2jdmis9jknUHgouYnE8Q/hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mh5JhYkl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743550568; x=1775086568;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=DXDuX19oMmpBepGy4338YX9qnnHy5wXHexuyYjln/4w=;
  b=Mh5JhYklC8yHbTloBegXtFUwAnDKL/Py+1XqWrslcz21FrmtaGp2gF3X
   Ffvj/nLeFkMw/WHcN5h39ARpTruEYtXA7PWM0nw/Gs+A2iFpbIdxtWuHl
   dVBch3o33T2ZZqctw+c34Senm4V8uG87xXXmm96lnWtIOAMWnQD5WiIW7
   I+5e4ykx5+VQO0JivH5ENTbB/K7PFSN2FCfVeZgS7VOI26ZTPwPg7mBTz
   PKm2qcLnlaihT108goXZ1hfuOpb4AKTuzzluC0tnIUwYAlO+4hwIHoiun
   QHoAeVGgkzFVzE3g7zp8QeYh0HZup3IvEahQGiaaGT9HVtRhwXS3IMAav
   g==;
X-CSE-ConnectionGUID: Vwqo7PicQy25E4g/S55qSg==
X-CSE-MsgGUID: WEkl6zbvRQyJ4TGCzZcmBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="55527604"
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="55527604"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 16:36:06 -0700
X-CSE-ConnectionGUID: gCuhQsPxScejGRylF8A41Q==
X-CSE-MsgGUID: F4omPn7IReW2LKLogMkmlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="127354850"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 16:36:06 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 01 Apr 2025 16:35:31 -0700
Subject: [PATCH iwl-net v4 3/6] igc: move ktime snapshot into PTM retry
 loop
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250401-jk-igc-ptm-fixes-v4-v4-3-c0efb82bbf85@intel.com>
References: <20250401-jk-igc-ptm-fixes-v4-v4-0-c0efb82bbf85@intel.com>
In-Reply-To: <20250401-jk-igc-ptm-fixes-v4-v4-0-c0efb82bbf85@intel.com>
To: Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: david.zage@intel.com, vinicius.gomes@intel.com, 
 rodrigo.cadore@l-acoustics.com, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Christopher S M Hall <christopher.s.hall@intel.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Mor Bar-Gabay <morx.bar.gabay@intel.com>, 
 Avigail Dahan <avigailx.dahan@intel.com>, 
 Corinna Vinschen <vinschen@redhat.com>
X-Mailer: b4 0.14.2

From: Christopher S M Hall <christopher.s.hall@intel.com>

Move ktime_get_snapshot() into the loop. If a retry does occur, a more
recent snapshot will result in a more accurate cross-timestamp.

Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
Reviewed-by: Corinna Vinschen <vinschen@redhat.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index c640e346342be80fb53e68455d510fc6491366cd..516abe7405deee94866c22ccc3d101db1a21dbb6 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -1011,16 +1011,16 @@ static int igc_phc_get_syncdevicetime(ktime_t *device,
 	int err, count = 100;
 	ktime_t t1, t2_curr;
 
-	/* Get a snapshot of system clocks to use as historic value. */
-	ktime_get_snapshot(&adapter->snapshot);
-
+	/* Doing this in a loop because in the event of a
+	 * badly timed (ha!) system clock adjustment, we may
+	 * get PTM errors from the PCI root, but these errors
+	 * are transitory. Repeating the process returns valid
+	 * data eventually.
+	 */
 	do {
-		/* Doing this in a loop because in the event of a
-		 * badly timed (ha!) system clock adjustment, we may
-		 * get PTM errors from the PCI root, but these errors
-		 * are transitory. Repeating the process returns valid
-		 * data eventually.
-		 */
+		/* Get a snapshot of system clocks to use as historic value. */
+		ktime_get_snapshot(&adapter->snapshot);
+
 		igc_ptm_trigger(hw);
 
 		err = readx_poll_timeout(rd32, IGC_PTM_STAT, stat,

-- 
2.48.1.397.gec9d649cc640


