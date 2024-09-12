Return-Path: <netdev+bounces-127765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EF9976606
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 11:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA8A284EED
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 09:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239E719F429;
	Thu, 12 Sep 2024 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TpNjGefj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7A919F12D
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726134458; cv=none; b=oAU2xxoo3m+LUhI0cfahQ9o/PkZFuf/tF4TAy/vyEbxMBtYBQEaUIpz4NeK+ZtKCQ3QGzG9QwU0CmN/aOXsim6ffGq2H9t6FsOUa51ZneOoJ215ZQF8cMca15pmtzolq8vigYxGnJzhuy5jBlvSp5U7rl0fr7CQTmNs4TV5kzI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726134458; c=relaxed/simple;
	bh=4HRqVP8zXV6KjpDXTGhxm8NP5s8TffV+6Iz0T0Eeujs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjpj2DyMMpW6KSltdQRFkWQng9ez339Tj16dMnyZgaG5/BaODX1c74UvabF5KwNSVCqXi7y+oDf+/3V8bIJzzvOQjJbHULuaJUzqSsHdroL0ZcGIX+az8uSe/BqDealWaEP6iGpLMCWahU8TW+5htDym30AUdDFURw1rhYvsCHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TpNjGefj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726134457; x=1757670457;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4HRqVP8zXV6KjpDXTGhxm8NP5s8TffV+6Iz0T0Eeujs=;
  b=TpNjGefj9gIHJQMc+qR32f6yIS6yqN9CMLqy7UYqWKb0pKg1HjeKBHc4
   VoLnw8lmyE81wWdN3crDw0eTRlnYtJOJukrMcpMkuw3wOkpI80kp66ubT
   HLBsE5iiXd5LbVmMI/e59pc97DBz4WBmVaPEOnWYuQ96eKybCfGL3JuaA
   XDXaj5Hj/FQWWBheHhqW7rA26nJTuolZfsTXejFIRfbeQ8wQ/88/QrpXl
   6rECauae+Zv5d1hE0dC3R45UM4GDnap6moc1etINQnzA/nVF8aC7IG1GX
   wnPLHkkEHX4IU62W+CvdXI6sv5//lKdHxw54ej6qH9xYd1UcCOpS+Uwrk
   A==;
X-CSE-ConnectionGUID: roD8a/dDQ2WEcMTm+JzRCg==
X-CSE-MsgGUID: 3zK1XtRyQpCP1/4INkVnjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="36115403"
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="36115403"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 02:47:37 -0700
X-CSE-ConnectionGUID: c4X+HOSgQxWCvkffVkYhcQ==
X-CSE-MsgGUID: S7hkskopS6Gr5S2c8gCm5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,222,1719903600"; 
   d="scan'208";a="72650690"
Received: from kkolacin-desk1.igk.intel.com ([10.217.160.108])
  by orviesa004.jf.intel.com with ESMTP; 12 Sep 2024 02:47:34 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v10 iwl-next 6/7] ice: Refactor ice_ptp_init_tx_*
Date: Thu, 12 Sep 2024 11:41:51 +0200
Message-ID: <20240912094720.832348-15-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912094720.832348-9-karol.kolacinski@intel.com>
References: <20240912094720.832348-9-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unify ice_ptp_init_tx_* functions for most of the MAC types except E82X.
This simplifies the code for the future use with new MAC types.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
V7 -> V8: Renamed the patch and reworded the commit message

 drivers/net/ethernet/intel/ice/ice_ptp.c | 56 ++++++++----------------
 drivers/net/ethernet/intel/ice/ice_ptp.h |  3 +-
 2 files changed, 20 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 47c356d68e2e..7993646e78b5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -945,28 +945,6 @@ ice_ptp_release_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
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
@@ -977,9 +955,11 @@ static int ice_ptp_init_tx_eth56g(struct ice_pf *pf, struct ice_ptp_tx *tx,
  * the timestamp block is shared for all ports in the same quad. To avoid
  * ports using the same timestamp index, logically break the block of
  * registers into chunks based on the port number.
+ *
+ * Return: 0 on success, -ENOMEM when out of memory
  */
-static int
-ice_ptp_init_tx_e82x(struct ice_pf *pf, struct ice_ptp_tx *tx, u8 port)
+static int ice_ptp_init_tx_e82x(struct ice_pf *pf, struct ice_ptp_tx *tx,
+				u8 port)
 {
 	tx->block = ICE_GET_QUAD_NUM(port);
 	tx->offset = (port % ICE_PORTS_PER_QUAD) * INDEX_PER_PORT_E82X;
@@ -990,24 +970,27 @@ ice_ptp_init_tx_e82x(struct ice_pf *pf, struct ice_ptp_tx *tx, u8 port)
 }
 
 /**
- * ice_ptp_init_tx_e810 - Initialize tracking for Tx timestamps
+ * ice_ptp_init_tx - Initialize tracking for Tx timestamps
  * @pf: Board private structure
  * @tx: the Tx tracking structure to initialize
+ * @port: the port this structure tracks
+ *
+ * Initialize the Tx timestamp tracker for this PF. For all PHYs except E82X,
+ * each port has its own block of timestamps, independent of the other ports.
  *
- * Initialize the Tx timestamp tracker for this PF. For E810 devices, each
- * port has its own block of timestamps, independent of the other ports.
+ * Return: 0 on success, -ENOMEM when out of memory
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
+	tx->has_ready_bitmap = pf->hw.mac_type != ICE_MAC_E810;
 
 	return ice_ptp_alloc_tx_tracker(tx);
 }
@@ -3205,6 +3188,8 @@ static int ice_ptp_init_work(struct ice_pf *pf, struct ice_ptp *ptp)
  * ice_ptp_init_port - Initialize PTP port structure
  * @pf: Board private structure
  * @ptp_port: PTP port structure
+ *
+ * Return: 0 on success, -ENODEV on invalid MAC type, -ENOMEM on failed alloc.
  */
 static int ice_ptp_init_port(struct ice_pf *pf, struct ice_ptp_port *ptp_port)
 {
@@ -3214,16 +3199,13 @@ static int ice_ptp_init_port(struct ice_pf *pf, struct ice_ptp_port *ptp_port)
 
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
-		return ice_ptp_init_tx_e810(pf, &ptp_port->tx);
+	case ICE_MAC_GENERIC_3K_E825:
+		return ice_ptp_init_tx(pf, &ptp_port->tx, ptp_port->port_num);
 	case ICE_MAC_GENERIC:
 		kthread_init_delayed_work(&ptp_port->ov_work,
 					  ice_ptp_wait_for_offsets);
-
 		return ice_ptp_init_tx_e82x(pf, &ptp_port->tx,
 					    ptp_port->port_num);
-	case ICE_MAC_GENERIC_3K_E825:
-		return ice_ptp_init_tx_eth56g(pf, &ptp_port->tx,
-					      ptp_port->port_num);
 	default:
 		return -ENODEV;
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index acee46ad793a..5af474285780 100644
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
2.46.0


