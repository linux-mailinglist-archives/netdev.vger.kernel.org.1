Return-Path: <netdev+bounces-100574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898868FB390
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E1328705E
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 13:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227FF146A7B;
	Tue,  4 Jun 2024 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBwDhl7U"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DF8146A94
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 13:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507348; cv=none; b=FfKpWk1juNZ/rDWS95GjTZHmw1M90/STjaY5l03Qs4mqekuzuyuE9pzXo3bMboFl4n+1QjGPBr+JQZTJHnljI5hgf7NtyqKFcN46GwJf3XLry+PCivI2aw5nfK/F9NxX1PpB9sUIO1mwZUqNSJoaW6IXKwq3AFF5yFDy7Z21tnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507348; c=relaxed/simple;
	bh=ua5dTpw+9qCBRIHWSRrOzgeAU3++bdFfmcyuB6QgoB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PS73tAKDJkdeTVmXNnXbxF/lpHd2xw3wmN3nbsiw3LQgXtW0vW9+IGypwcIYHF3IsomScWCBfRZNDxwOgstGemiFJ3EYI/CrDvBHdPjx8tRn1DyOQIM23VUFerDGoJGTzfJ49+3woG7rNy9rm3NxQl71nTFfMPGj3KyoMCtPFqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBwDhl7U; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717507346; x=1749043346;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ua5dTpw+9qCBRIHWSRrOzgeAU3++bdFfmcyuB6QgoB4=;
  b=HBwDhl7UGTAGPiUGga0+Q6lUi0VDadb5IkN28szLO366IIX3SkgbAQ4R
   mKZeDwSZeLY7WNa9nIR2ExrCcNjDL0xTb1hxG8Hy7k+RmzZBAkYrBhR1i
   3jJ967ak33WYS8rA/uP34I92FAjUnwbGDZmUogUqQ+uKCa0XIn3P5gZxI
   HJoMMfHjYYIPIqwk3xHq1APVn2Qxy2OdukrOIin8EIppHoc8laTnth5pG
   Onqal9K95tmp2rpqerBjnoptiO9Ers3fpYbPTFbl2XCpUathaW1FzlLf4
   NfHWntykq5K82bySOL57sEaiIBaEDJ8a8R1Bv/P1zi6OplpO4cp29hLJZ
   Q==;
X-CSE-ConnectionGUID: dav3Tck8QPCr4++gI6Z6MQ==
X-CSE-MsgGUID: 0VwzS32+TI+//Gx3RBwQXA==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="31552919"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="31552919"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 06:22:26 -0700
X-CSE-ConnectionGUID: 82uMDi9DTIG3oG5ewjTUpA==
X-CSE-MsgGUID: FK1/GtEeSe6UkdOmUEPtOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37350236"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa009.fm.intel.com with ESMTP; 04 Jun 2024 06:22:24 -0700
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	michal.kubiak@intel.com,
	larysa.zaremba@intel.com,
	jacob.e.keller@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH v3 iwl-net 7/8] ice: add missing WRITE_ONCE when clearing ice_rx_ring::xdp_prog
Date: Tue,  4 Jun 2024 15:21:54 +0200
Message-Id: <20240604132155.3573752-8-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240604132155.3573752-1-maciej.fijalkowski@intel.com>
References: <20240604132155.3573752-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is read by data path and modified from process context on remote cpu
so it is needed to use WRITE_ONCE to clear the pointer.

Fixes: efc2214b6047 ("ice: Add support for XDP")
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index f4b2b1bca234..4c115531beba 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -456,7 +456,7 @@ void ice_free_rx_ring(struct ice_rx_ring *rx_ring)
 	if (rx_ring->vsi->type == ICE_VSI_PF)
 		if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
 			xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
-	rx_ring->xdp_prog = NULL;
+	WRITE_ONCE(rx_ring->xdp_prog, NULL);
 	if (rx_ring->xsk_pool) {
 		kfree(rx_ring->xdp_buf);
 		rx_ring->xdp_buf = NULL;
-- 
2.34.1


