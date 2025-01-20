Return-Path: <netdev+bounces-159805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF15A16FAF
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 16:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B673A498C
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 15:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493EF1E9B15;
	Mon, 20 Jan 2025 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VhPziKCO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCD31E9B27
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737388239; cv=none; b=JIevM5240ZMbQgHfeurnccCGyCOect9Vu5iMUoK/6xCfvNusKY73UdDRwP382u9pqtaNB5ySuX570MQLMiXoasej6tmbO1qFGCRb+H9dSkcvhuau0CNuvE00TOwi+mvpTxLViQwVXSPhslKOsZ22UJMA5y/qD1lCbB5eFRee1cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737388239; c=relaxed/simple;
	bh=pXZSZ+TgLF8TssBvRmeh5b/o1fsmuwuJIZalOf+X/G0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GVS7s3HrvswA+2ayzr4dnyLxeCDIxxmXNYFR3PUeTJaO4vRmXrkUVxY/cbtUlwNv6YIykyzmU1MiODeZiqSALJK6P/hP4uAV8ZDjILeoq2HjzgKkERB6uzllZzRRdExcLMcMrRpyQCLc8h5CUQNZSuMpYx+Fz0pYdpuPR+bAZWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VhPziKCO; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737388237; x=1768924237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pXZSZ+TgLF8TssBvRmeh5b/o1fsmuwuJIZalOf+X/G0=;
  b=VhPziKCOSoTI+k1WZ9D/ZkoL1RgNTiM1xQ+HKxWN6zDz4N2e/odM6CPi
   d0n1BzoWYhENCEVxzVssZ0eWVsR8vq87ea/cyAPp0Ld9EjKPdNyMSmM+L
   nKkP+0lsmzhY4TpwWzSDXbEKFES7PrqR/Ep2tDNjNcZAP4Qr6OL6aoR5W
   Ap9x1I4c6Vx4VwVqB881lCC9v84aGecGTdYzNqB8u/Y3TDeiduIcun3Es
   3siYLpnu4+ixWPWP/d1cYWkeNQiw8vkKw0qs4W9tAeLax5VGCcoBQiSIz
   lSGXBzNjKcJjSZDNJBKpy9gOW+Ckq9x5S41zCsCRIK4BqXgbdWm0vT73o
   w==;
X-CSE-ConnectionGUID: hUTNkWAQRb2bIN/2aW5zGQ==
X-CSE-MsgGUID: j7knd/rET8uFFmdKZllx3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="55342354"
X-IronPort-AV: E=Sophos;i="6.13,219,1732608000"; 
   d="scan'208";a="55342354"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 07:50:37 -0800
X-CSE-ConnectionGUID: 3fpZ5ka0TSenAx+fJEuMEg==
X-CSE-MsgGUID: QdNfNdOjSryjxdjqnEundw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,219,1732608000"; 
   d="scan'208";a="106369835"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa006.fm.intel.com with ESMTP; 20 Jan 2025 07:50:35 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	jacob.e.keller@intel.com,
	xudu@redhat.com,
	mschmidt@redhat.com,
	jmaxwell@redhat.com,
	poros@redhat.com,
	przemyslaw.kitszel@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH v3 iwl-net 2/3] ice: gather page_count()'s of each frag right before XDP prog call
Date: Mon, 20 Jan 2025 16:50:15 +0100
Message-Id: <20250120155016.556735-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250120155016.556735-1-maciej.fijalkowski@intel.com>
References: <20250120155016.556735-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we store the pgcnt on few fragments while being in the middle of
gathering the whole frame and we stumbled upon DD bit not being set, we
terminate the NAPI Rx processing loop and come back later on. Then on
next NAPI execution we work on previously stored pgcnt.

Imagine that second half of page was used actively by networking stack
and by the time we came back, stack is not busy with this page anymore
and decremented the refcnt. The page reuse algorithm in this case should
be good to reuse the page but given the old refcnt it will not do so and
attempt to release the page via page_frag_cache_drain() with
pagecnt_bias used as an arg. This in turn will result in negative refcnt
on struct page, which was initially observed by Xu Du.

Therefore, move the page count storage from ice_get_rx_buf() to a place
where we are sure that whole frame has been collected, but before
calling XDP program as it internally can also change the page count of
fragments belonging to xdp_buff.

Fixes: ac0753391195 ("ice: Store page count inside ice_rx_buf")
Reported-and-tested-by: Xu Du <xudu@redhat.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Co-developed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index f2134ad57ead..9aa53ad2d8f2 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -924,7 +924,6 @@ ice_get_rx_buf(struct ice_rx_ring *rx_ring, const unsigned int size,
 	struct ice_rx_buf *rx_buf;
 
 	rx_buf = &rx_ring->rx_buf[ntc];
-	rx_buf->pgcnt = page_count(rx_buf->page);
 	prefetchw(rx_buf->page);
 
 	if (!size)
@@ -940,6 +939,22 @@ ice_get_rx_buf(struct ice_rx_ring *rx_ring, const unsigned int size,
 	return rx_buf;
 }
 
+static void ice_get_pgcnts(struct ice_rx_ring *rx_ring)
+{
+	u32 nr_frags = rx_ring->nr_frags + 1;
+	u32 idx = rx_ring->first_desc;
+	struct ice_rx_buf *rx_buf;
+	u32 cnt = rx_ring->count;
+
+	for (int i = 0; i < nr_frags; i++) {
+		rx_buf = &rx_ring->rx_buf[idx];
+		rx_buf->pgcnt = page_count(rx_buf->page);
+
+		if (++idx == cnt)
+			idx = 0;
+	}
+}
+
 /**
  * ice_build_skb - Build skb around an existing buffer
  * @rx_ring: Rx descriptor ring to transact packets on
@@ -1230,6 +1245,7 @@ int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		if (ice_is_non_eop(rx_ring, rx_desc))
 			continue;
 
+		ice_get_pgcnts(rx_ring);
 		ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_buf, rx_desc);
 		if (rx_buf->act == ICE_XDP_PASS)
 			goto construct_skb;
-- 
2.43.0


