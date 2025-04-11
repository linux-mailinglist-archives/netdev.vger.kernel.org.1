Return-Path: <netdev+bounces-181698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A242FA8633E
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 18:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AAAF179B08
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 16:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6977B21D3E1;
	Fri, 11 Apr 2025 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y25HvBQc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A194F21C167
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 16:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744388952; cv=none; b=WZfYToon0SU56OzW3+YAO9olR0H5Od9WDQYbPvTy+xzUqjoE4olLQmiL6B/FDRIrFHdiGv/FT4coTXB8iWE6lc57Ow8wBqLGEEUB8XRrqtnSCdGAxcIqbKstmmIBUlqqvZft1x8Kq+AjJyigwWK3fgP9Ot/k+Kw9RRFxdr0LHo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744388952; c=relaxed/simple;
	bh=qEwzHUQuv196Eofg67XtRaCW14Vto73nX8nwLomb5D8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3s+vp83KkN7CmUIfZ2XzQB6eS4MV7uDHTLYiml+L05X3mVEz72v2bugBE5/E5JKgkot838ALncaM+nNt9bf/gCJYF2PpYmF2Zly+CC1kdCQt4LK2LNrgwWHJ2LzFLmkC60wjhCy15er+lc0Fo06qEWVftOP9n35HWE/8WvOs/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y25HvBQc; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744388950; x=1775924950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qEwzHUQuv196Eofg67XtRaCW14Vto73nX8nwLomb5D8=;
  b=Y25HvBQcI+wma4QwW0lfvGCJ3HlhswkXj95L5aCadmMlQUaAhkLQgRZb
   1f9rDyi2URMnNkC26GeLyWy+/jJWRGTScBozb0IT4nCG9Qgdl/SXxl/FY
   Iwij8irZLMPjG60/4kflodlDWAYPxrIVf41Rbjxl5c0xTRoV+ZvGmH9BI
   FvE7Pv2BB1Bz+h7jO7+hTfXJtvF3UZN09k6RmYjWaCB2AHbNGbBHK2KbP
   prwAIFHjNiygFsSxDbeyxesaEqqQMp7wCpu6xkQvhBYp3r/VuXK2J8Nov
   oQ6sxj/mXLAAXtL9LMOnjlsTNJE93qeG4+b+DsBRY/USW+wl9O2E7uE6T
   w==;
X-CSE-ConnectionGUID: ZV7zHVK8RcOi78/UYXP87g==
X-CSE-MsgGUID: HEeBLYZtRbadcjxEvyaq6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="56610957"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="56610957"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 09:29:09 -0700
X-CSE-ConnectionGUID: Oy72zJmaT0iaZ/ZBzVrsOw==
X-CSE-MsgGUID: C8bcKghrQK2iW4dot8cBGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="133343139"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 11 Apr 2025 09:29:09 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Christopher S M Hall <christopher.s.hall@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	vinicius.gomes@intel.com,
	david.zage@intel.com,
	michal.swiatkowski@linux.intel.com,
	richardcochran@gmail.com,
	vinschen@redhat.com,
	rodrigo.cadore@l-acoustics.com,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH net 3/6] igc: move ktime snapshot into PTM retry loop
Date: Fri, 11 Apr 2025 09:28:52 -0700
Message-ID: <20250411162857.2754883-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411162857.2754883-1-anthony.l.nguyen@intel.com>
References: <20250411162857.2754883-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index c640e346342b..516abe7405de 100644
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
2.47.1


