Return-Path: <netdev+bounces-212227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA11B1EC82
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 17:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90660580592
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 15:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913FE286416;
	Fri,  8 Aug 2025 15:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XGyNFvlW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96A6285CB9
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 15:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668457; cv=none; b=RnCXKfWFtZVAXiIYqUhTkyIuVgTe3/fgcnGsI1/iJBKfCXmmQFWf4pFbmOJtupRM5UqrnvkpgkjODk6FLTssafT1vPLWQkprZT/sXC/wKNr6Ng6JgugJbN42rCaeNPoWeHuuJpjIsUGOKGGs4c1JO+zVCFmat3eyvo8850Eawq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668457; c=relaxed/simple;
	bh=BHJY+KSo4oQqORjyQr7L3Ta1mYn3O21VYHEvy/pabXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e7ETcavrt8XRfcJ8+bhQD5ZXGKLc6UO01gg+Dq8DUCMiAnA6vi2GPPvzGx5jNw7LyOSfk6eCdoJXFpWiEdgkuuKzERDYl9imIjPk2S9qPxy2u1My9z8ysV3PDGY/MHoN6Kvte8oDh9WvHLK8yY7g05nbaGc5OYx3QdgX/Fqu1ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XGyNFvlW; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754668456; x=1786204456;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BHJY+KSo4oQqORjyQr7L3Ta1mYn3O21VYHEvy/pabXI=;
  b=XGyNFvlWnXY4jzrjntn6vBOaQoECwGXUuXnZIC8tJ3v2HZ169t5Pq1lu
   oRCu+FRIX1jhWFsrwdb8Mko+7fSOLp0dDIRcagWDgIMOxUoghmfXGnwg3
   JQgjCG1TC8kcbnqh4eks+XSmVV78BC2YnrQcDEDfqp+jvm4rtImISmzGG
   JjUXvDwk5qwvYGW+DuatsIuHb9XyKcXJnN4TKn4+jON150uw80XY1s6NQ
   pL1/MFS0H1Ll2SDBSZ0P5BeCvfJSdj29tWm3ctLKGEw/VT8+Hqb3RoUhq
   LghcD5/Dj0ouq3r1urxWHGS+2yRyUq8VaAXF+eTLOJTRlMMjwZ3cOmr2y
   w==;
X-CSE-ConnectionGUID: UqXMX2ppQFmxv7DfyDOkhw==
X-CSE-MsgGUID: LUlcGU7gS1O8984pLsREEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="68476102"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="68476102"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 08:53:51 -0700
X-CSE-ConnectionGUID: 7nyJYSelSF+DKucgdfCiUA==
X-CSE-MsgGUID: Vx0jAeNMRpyJlEhzux7Xow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="165680810"
Received: from gk3153-pr4-x299-22869.igk.intel.com (HELO localhost.igk.intel.com) ([10.102.21.130])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 08:53:48 -0700
From: Michal Kubiak <michal.kubiak@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: maciej.fijalkowski@intel.com,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	aleksander.lobakin@intel.com,
	anthony.l.nguyen@intel.com,
	Michal Kubiak <michal.kubiak@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH iwl-net] ice: fix incorrect counter for buffer allocation failures
Date: Fri,  8 Aug 2025 17:53:10 +0200
Message-ID: <20250808155310.1053477-1-michal.kubiak@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the driver increments `alloc_page_failed` when buffer allocation fails
in `ice_clean_rx_irq()`. However, this counter is intended for page allocation
failures, not buffer allocation issues.

This patch corrects the counter by incrementing `alloc_buf_failed` instead,
ensuring accurate statistics reporting for buffer allocation failures.

Fixes: 2fba7dc5157b ("ice: Add support for XDP multi-buffer on Rx side")
Reported-by: Jacob Keller <jacob.e.keller@intel.com>
Suggested-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Michal Kubiak <michal.kubiak@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 93907ab2eac7..1b1ebfd347ef 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1337,7 +1337,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 			skb = ice_construct_skb(rx_ring, xdp);
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {
-			rx_ring->ring_stats->rx_stats.alloc_page_failed++;
+			rx_ring->ring_stats->rx_stats.alloc_buf_failed++;
 			xdp_verdict = ICE_XDP_CONSUMED;
 		}
 		ice_put_rx_mbuf(rx_ring, xdp, ntc, xdp_verdict);
-- 
2.45.2


