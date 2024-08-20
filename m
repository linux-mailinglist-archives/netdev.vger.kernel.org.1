Return-Path: <netdev+bounces-120342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5616C959008
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 23:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 927E0B21B69
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 21:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769471C7B69;
	Tue, 20 Aug 2024 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NQN0OjLm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BB014B097
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 21:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724190991; cv=none; b=uGUFwdKb0U1nCL/G2aCmapzW5PGwSOYRrqRCPpGLRVQIp48Iyp0YH8FDCpWeEtXaxBtPwwo2yKF71sjKh1RmJdkAHeGFXlesV+aRFe2W4E3PdIc8eaH+pI4P3YBwH20N551AkmGu3WaMVTn5jbxl4LYyPreLY59iu5uoHIUCSaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724190991; c=relaxed/simple;
	bh=4AYFULdqWid0C0iMbMROdh5dwLQWttJFADbXMg87PoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sWNaZzstsHC3KPWtWRYGypQzhoIg0yuQr9ijkv1I5HCKF8NYAzj4i4VL9Di5fcYY7uIiDMxV54djkKeZ7/VIvMde6p+GOPK+ug+3D+mnDaGhqNXazPktWxriNM5BELI4PK8BZRcXplj2Zc/+0KqLqmcUuyWfCU/++097/iQDBOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NQN0OjLm; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724190988; x=1755726988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4AYFULdqWid0C0iMbMROdh5dwLQWttJFADbXMg87PoE=;
  b=NQN0OjLmlzyUqs6XUemJ+J90xnnE3b/DRNJwHCkFgZQ1J/5zokyR3M0G
   Lh4+iuDC6nHLWu2swOxPxb+LBg59/fU/RBjuhfd8fRYKLJw6NLbS3ljXB
   SRROIv4/bkCuq2rUOnxTP07QQaEGEt/oMpybT0l8AV21d1rqF6kjZw05k
   E+yCvSNwNHilNMQRvZZiOcrX9zXGb2awRs4iWcu8iC2oEosyHuAxMmITW
   EsK8+daUguvEsgpQ8EptTlwqX5ChcuAUSQaxEkXPj/M9bc/mGUEPv9Du+
   hgn4fOJ3Z1cNNDThNmiqI3zw/z5u38+UDEQRiHjsymSvZq6Rzeg34aYss
   w==;
X-CSE-ConnectionGUID: ZskaNYDgRISaiMsi+wbWbw==
X-CSE-MsgGUID: nJSu1nWCTV6brNBlVOh9Qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="39979347"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="39979347"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 14:56:27 -0700
X-CSE-ConnectionGUID: WPjgt2mxQfe1yEgBE75HMg==
X-CSE-MsgGUID: 5GWa06zzRCiM23R3HN31Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="65833192"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 20 Aug 2024 14:56:27 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	anthony.l.nguyen@intel.com,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH net 1/4] ice: fix page reuse when PAGE_SIZE is over 8k
Date: Tue, 20 Aug 2024 14:56:15 -0700
Message-ID: <20240820215620.1245310-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240820215620.1245310-1-anthony.l.nguyen@intel.com>
References: <20240820215620.1245310-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Architectures that have PAGE_SIZE >= 8192 such as arm64 should act the
same as x86 currently, meaning reuse of a page should only take place
when no one else is busy with it.

Do two things independently of underlying PAGE_SIZE:
- store the page count under ice_rx_buf::pgcnt
- then act upon its value vs ice_rx_buf::pagecnt_bias when making the
  decision regarding page reuse

Fixes: 2b245cb29421 ("ice: Implement transmit and NAPI support")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 8d25b6981269..50211188c1a7 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -837,16 +837,15 @@ ice_can_reuse_rx_page(struct ice_rx_buf *rx_buf)
 	if (!dev_page_is_reusable(page))
 		return false;
 
-#if (PAGE_SIZE < 8192)
 	/* if we are only owner of page we can reuse it */
 	if (unlikely(rx_buf->pgcnt - pagecnt_bias > 1))
 		return false;
-#else
+#if (PAGE_SIZE >= 8192)
 #define ICE_LAST_OFFSET \
 	(SKB_WITH_OVERHEAD(PAGE_SIZE) - ICE_RXBUF_2048)
 	if (rx_buf->page_offset > ICE_LAST_OFFSET)
 		return false;
-#endif /* PAGE_SIZE < 8192) */
+#endif /* PAGE_SIZE >= 8192) */
 
 	/* If we have drained the page fragment pool we need to update
 	 * the pagecnt_bias and page count so that we fully restock the
@@ -949,12 +948,7 @@ ice_get_rx_buf(struct ice_rx_ring *rx_ring, const unsigned int size,
 	struct ice_rx_buf *rx_buf;
 
 	rx_buf = &rx_ring->rx_buf[ntc];
-	rx_buf->pgcnt =
-#if (PAGE_SIZE < 8192)
-		page_count(rx_buf->page);
-#else
-		0;
-#endif
+	rx_buf->pgcnt = page_count(rx_buf->page);
 	prefetchw(rx_buf->page);
 
 	if (!size)
-- 
2.42.0


