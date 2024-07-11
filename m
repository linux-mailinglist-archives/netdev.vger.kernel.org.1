Return-Path: <netdev+bounces-110761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8E992E378
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 11:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523321C212D6
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 09:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DA615748D;
	Thu, 11 Jul 2024 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mVdO5E3s"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568A41509B1
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720690212; cv=none; b=NuHtcuekRGqGZKN/XraGfl/lK8deCb7AHgPvVfCA/tbkOrrgQ46pgFJJ/CRj5PIYB0BJPnf9ke3cpItle4pJz3GIwBpOriljHqsBwl0QpXaETf+A7iTO6guIwt9YP8f6P/CIxHW60tmsnXjcEppU9MGR+H3dXCQlCHpI0cfgXSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720690212; c=relaxed/simple;
	bh=0YJY2Aa3go2/EbA2qSk2gMlQrXaVyiX2lgjsOCRJ0uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qSzLHFrXwJHKQA2ryZsLIN3g/eyO8mHbb3Vj2Gc8a0bUJu40zK03eAYC3nb7GbMoNNL9feHEXa1mln441EGBICoiuTzuHHWe9XHP+LxjsHUDxL356SdRrb91k5H0wjqdVDHyKyfZJ0sk6Ni4VmDU57a5YQ3nqRi9ylBTuRYTVx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mVdO5E3s; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720690211; x=1752226211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0YJY2Aa3go2/EbA2qSk2gMlQrXaVyiX2lgjsOCRJ0uQ=;
  b=mVdO5E3sDXfTavbUAw0E+pFllEBS97ymMdxMlHxDUT3Fc+KiSzDgE0G4
   +KTsCQ+7Ul5OQ/EP3IyzRiXO+GWioWtLzGM56fLg8IrsOaeW7Iw/W7uMG
   2nKXYxtSMEN0svSIIfUeaFSfzMdUWdpSJgFjx9I4SwNx4GYzbut7aKMZd
   5Mn5ohEOcMhvV73r9XEqLCfkM4f6qSWpFtQ0JwCMKD4Ls5FTFbd7xYbft
   TVbk+4+lcXk7Dh06PxTTkdD0kNgiGCqULHW2QgfRuNR31SX/UYJfCvqZ5
   nZQQKRxQz8dJ4JLwk7hVc5DB3V/4ftS5HhxbKOG2WfJVHy+DZkhmge+8n
   A==;
X-CSE-ConnectionGUID: a4kPx/t/RRmTzIovc83cqQ==
X-CSE-MsgGUID: Cys72DMuS12/7UgN8lwYhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="21821456"
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="21821456"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 02:28:21 -0700
X-CSE-ConnectionGUID: dqFxgdv2SkiWc+nFyYnzgw==
X-CSE-MsgGUID: eABvY0LrSmGf5AxIFdFSaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,199,1716274800"; 
   d="scan'208";a="48580022"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.132])
  by fmviesa010.fm.intel.com with ESMTP; 11 Jul 2024 02:28:19 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v2 iwl-next 3/4] ice: Add timestamp ready bitmap for E830 products
Date: Thu, 11 Jul 2024 11:24:26 +0200
Message-ID: <20240711092757.890786-9-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711092757.890786-6-karol.kolacinski@intel.com>
References: <20240711092757.890786-6-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

E830 PHY supports timestamp ready bitmap.
Enable the bitmap by refactoring tx init function.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 47 +++++-------------------
 drivers/net/ethernet/intel/ice/ice_ptp.h |  3 +-
 2 files changed, 11 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 6fae3841bdaa..6eb8583dc7bc 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -963,28 +963,6 @@ ice_ptp_release_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
 	tx->len = 0;
 }
 
-/**
- * ice_ptp_init_tx_eth56g - Initialize tracking for Tx timestamps
- * @pf: Board private structure
- * @tx: the Tx tracking structure to initialize
- * @port: the port this structure tracks
- *
- * Initialize the Tx timestamp tracker for this port. ETH56G PHYs
- * have independent memory blocks for all ports.
- *
- * Return: 0 for success, -ENOMEM when failed to allocate Tx tracker
- */
-static int ice_ptp_init_tx_eth56g(struct ice_pf *pf, struct ice_ptp_tx *tx,
-				  u8 port)
-{
-	tx->block = port;
-	tx->offset = 0;
-	tx->len = INDEX_PER_PORT_ETH56G;
-	tx->has_ready_bitmap = 1;
-
-	return ice_ptp_alloc_tx_tracker(tx);
-}
-
 /**
  * ice_ptp_init_tx_e82x - Initialize tracking for Tx timestamps
  * @pf: Board private structure
@@ -1008,24 +986,25 @@ ice_ptp_init_tx_e82x(struct ice_pf *pf, struct ice_ptp_tx *tx, u8 port)
 }
 
 /**
- * ice_ptp_init_tx_e810 - Initialize tracking for Tx timestamps
+ * ice_ptp_init_tx - Initialize tracking for Tx timestamps
  * @pf: Board private structure
  * @tx: the Tx tracking structure to initialize
+ * @port: the port this structure tracks
  *
- * Initialize the Tx timestamp tracker for this PF. For E810 devices, each
- * port has its own block of timestamps, independent of the other ports.
+ * Initialize the Tx timestamp tracker for this PF. For all PHYs except E82X,
+ * each port has its own block of timestamps, independent of the other ports.
  */
-static int
-ice_ptp_init_tx_e810(struct ice_pf *pf, struct ice_ptp_tx *tx)
+static int ice_ptp_init_tx(struct ice_pf *pf, struct ice_ptp_tx *tx, u8 port)
 {
-	tx->block = pf->hw.port_info->lport;
+	tx->block = port;
 	tx->offset = 0;
-	tx->len = INDEX_PER_PORT_E810;
+	tx->len = INDEX_PER_PORT;
+
 	/* The E810 PHY does not provide a timestamp ready bitmap. Instead,
 	 * verify new timestamps against cached copy of the last read
 	 * timestamp.
 	 */
-	tx->has_ready_bitmap = 0;
+	tx->has_ready_bitmap = ice_get_phy_model(&pf->hw) != ICE_PHY_E810;
 
 	return ice_ptp_alloc_tx_tracker(tx);
 }
@@ -3196,19 +3175,13 @@ static int ice_ptp_init_port(struct ice_pf *pf, struct ice_ptp_port *ptp_port)
 	mutex_init(&ptp_port->ps_lock);
 
 	switch (ice_get_phy_model(hw)) {
-	case ICE_PHY_ETH56G:
-		return ice_ptp_init_tx_eth56g(pf, &ptp_port->tx,
-					      ptp_port->port_num);
-	case ICE_PHY_E810:
-		return ice_ptp_init_tx_e810(pf, &ptp_port->tx);
 	case ICE_PHY_E82X:
 		kthread_init_delayed_work(&ptp_port->ov_work,
 					  ice_ptp_wait_for_offsets);
-
 		return ice_ptp_init_tx_e82x(pf, &ptp_port->tx,
 					    ptp_port->port_num);
 	default:
-		return -ENODEV;
+		return ice_ptp_init_tx(pf, &ptp_port->tx, ptp_port->port_num);
 	}
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 5b786e972388..288e06c35603 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -128,8 +128,7 @@ struct ice_ptp_tx {
 /* Quad and port information for initializing timestamp blocks */
 #define INDEX_PER_QUAD			64
 #define INDEX_PER_PORT_E82X		16
-#define INDEX_PER_PORT_E810		64
-#define INDEX_PER_PORT_ETH56G		64
+#define INDEX_PER_PORT			64
 
 /**
  * struct ice_ptp_port - data used to initialize an external port for PTP
-- 
2.45.2


