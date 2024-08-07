Return-Path: <netdev+bounces-116441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 310F294A662
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 12:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04F7283D84
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 10:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5D91E2120;
	Wed,  7 Aug 2024 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XnIZeKGl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDF61DE868
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 10:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723028121; cv=none; b=AHGNx2vAj3/yMVcQuxcW7dIp+0R4SqjLQKfrJ9HdZJ5iBNoElmqe/XYCHHO+PnkkLCN6FJKacHepTFgaiHzNf4SkV59TNC0EJ1idXMAjWYgi1kvLHucUOjoa+ST1YgAmBy8Nl2xa20QSQjaEGXjN1R9z73spZkZWg/8ICCXQcZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723028121; c=relaxed/simple;
	bh=Jusq7YWDx6mJtyPjWnz6er9sRRpOwRpAmltB9HEnGBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kVfAx5VJEPGLcifgjp60k5/G2sxaR35g+9eJjJUdIhvA+c1pOTL+a8jrqaMuPn2R2BZrTZWv0L2TdZK0tahhrUNuaNosdpGbz+yPnHtT2FiYYAxV7JmuQkDAzZjJLReO/9vYTZ+XkUelqpbPchMDCyXYsMXqqlK7RmZ7o10/IFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XnIZeKGl; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723028120; x=1754564120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jusq7YWDx6mJtyPjWnz6er9sRRpOwRpAmltB9HEnGBM=;
  b=XnIZeKGlxii6c+P4d+IO+Br5cjuKXzEEJtEqo3BHWpbLCuGPPDEU/zvT
   BG3Jpdc6MfckQIPnPWU0JgyPbP0hZFWFoI+Cegnq12+SggkEC2yPj3WEi
   n3OYWnTRFJ7nPUf8L12hFP0v7pDRxvqschgC5OlVimbF/BtgQv1/cJmw6
   1SSakAZJ5uJLGd20Q6JE2J3hjfZGOcU3jMsjV362WdXeJPNZCCs97xRhq
   WjGvPlAcycdtRKEHxxyB1/lMjkuU4Q/YNmjPhbH5j0c7a2v5PZ4HA7X48
   +QCV6CmtK5xazKTpe8E+9ZN7JkzOnatCUk9xWtk54J4XnT5RLFRabKHNt
   A==;
X-CSE-ConnectionGUID: g/mP3oQkSuKQlSZhNsmXeg==
X-CSE-MsgGUID: PJ1MbhZcSAS7Ges9ZnWa9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="31664387"
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="31664387"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 03:55:19 -0700
X-CSE-ConnectionGUID: ZdRm4x6sToW2r9LnvbEmew==
X-CSE-MsgGUID: mL/dideMRtGqwFK73M/SjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="87757260"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa001.fm.intel.com with ESMTP; 07 Aug 2024 03:55:17 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	bjorn@kernel.org,
	luizcap@redhat.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH iwl-net 1/3] ice: fix page reuse when PAGE_SIZE is over 8k
Date: Wed,  7 Aug 2024 12:53:24 +0200
Message-Id: <20240807105326.86665-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240807105326.86665-1-maciej.fijalkowski@intel.com>
References: <20240807105326.86665-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Architectures that have PAGE_SIZE >= 8192 such as arm64 should act the
same as x86 currently, meaning reuse of a page should only take place
when no one else is busy with it.

Do two things independently of underlying PAGE_SIZE:
- store the page count under ice_rx_buf::pgcnt
- then act upon its value vs ice_rx_buf::pagecnt_bias when making the
  decision regarding page reuse

Fixes: 2b245cb29421 ("ice: Implement transmit and NAPI support")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
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
2.34.1


