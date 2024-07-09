Return-Path: <netdev+bounces-110251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC55292B9A5
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 14:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8EE1F258C3
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 12:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF7C159209;
	Tue,  9 Jul 2024 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZs0Znax"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C5F15AD8B
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 12:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528609; cv=none; b=kntTFI4wVyUxVWVsaSFMZo93m8ZRLRDldD60tm/IhCSg0ybJx42kB0fOfVDHOvCamMJ58yUS0d2H0Yltiuu9uu2G5cDIfwETp8O7p1mKD2lPBVkMe6M3WJ6RRsRQOOXmydDS5NC+f6HXH/sXjYakwAv7FtgindwxG6l/xwSlMG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528609; c=relaxed/simple;
	bh=TUbwMCbAvbauDg71o7l7BEtvTh/1DLG3VL2z+zREaEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3bwf/5692K2GWJdLbM0maXIlD16CUDHrSMUd2udciJKheDpz3qi/YL/9pAM+pPlJOOX98TleuCkA57goKxWL3/KhP85eZICDvwbNmFkj8wlB60fDIFC+3rNbnw9Du11I4KWoJp9e/yns5hxUL6+kZgLZyAdv+r9ESfZTh9o+7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZs0Znax; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720528608; x=1752064608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TUbwMCbAvbauDg71o7l7BEtvTh/1DLG3VL2z+zREaEo=;
  b=FZs0Znax6URTezUtsRJ6K3pPEH/SuBgA9dCoMx0aj/vha4n7frSXLBAk
   i1aMSmUSnNhTBfZPfHZMKTWa7ax7tjD7qZEezKKLP4q9njQ3JDCn1g3xg
   hXqUmqw1pod2vqESIGbqZOIhh1bXDXn5z+UWxfSUSm9uI50MsCVM96wWf
   lyjFR9H2REHrg7UtFZcTKtH287/bM4fNofSSoGhHLyk7I7iPk4vyW05Sz
   R238/CzqNmOnpwPQxTZxU7QkZGsWFc+lmHTXH9GNW7+RfNDAQd+EUU15T
   qwJ6K++LBFIQUxPUtvit7uMxgNWR/YSsY4PO7o4BzC7lBXBNQ/+PAeT3p
   g==;
X-CSE-ConnectionGUID: 60q74uiiRwmVP27t9ySJWw==
X-CSE-MsgGUID: zXyam8opRcKgOgzjvD/V7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17598169"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="17598169"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 05:36:47 -0700
X-CSE-ConnectionGUID: 9JLZV39JTOOy4CXHIPlqHQ==
X-CSE-MsgGUID: 1GWUB12CQ3+euqePU8EzoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="47776113"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.132])
  by orviesa010.jf.intel.com with ESMTP; 09 Jul 2024 05:36:46 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH iwl-next 3/4] ice: Add timestamp ready bitmap for E830 products
Date: Tue,  9 Jul 2024 14:34:57 +0200
Message-ID: <20240709123629.666151-9-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709123629.666151-6-karol.kolacinski@intel.com>
References: <20240709123629.666151-6-karol.kolacinski@intel.com>
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
index ada2ede217b4..924e4160a414 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -962,28 +962,6 @@ ice_ptp_release_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
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
@@ -1007,24 +985,25 @@ ice_ptp_init_tx_e82x(struct ice_pf *pf, struct ice_ptp_tx *tx, u8 port)
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
@@ -3035,19 +3014,13 @@ static int ice_ptp_init_port(struct ice_pf *pf, struct ice_ptp_port *ptp_port)
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
index e495af509642..4cd75efef5ba 100644
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


