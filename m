Return-Path: <netdev+bounces-120096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA005958469
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 12:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE011C248AC
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 10:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4319F18EFFF;
	Tue, 20 Aug 2024 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nRg0hfLt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEED18FC9F
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724149480; cv=none; b=Y0+tIQnaXxO08It3wDrsHH8H1IHibVwunqN/ZzJ3R7MqIuQvhaHE3AfjsWUcBiUbo2uvriqpqrqcVkgIikcug3NubkgnzZFubRqPhO+sGt8NPZc+guoyC5PVqHlpsF7gaMtRtQKUeex8XqmOI/+YkNudvucxUjvkFVfI+OvkImA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724149480; c=relaxed/simple;
	bh=7N5eGTkDiG8Qvv/AIj8ZvUfBEc+qQ7WfM1ZJ92TKzX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tms+uBrnQ/Yt9A5l9NDDDhmU80tsP/h4itMgqTUJkhwrmqCD474WqCldSIBBPry588Y8oCfrZtprfckY06ma7lndOpXH11uWNl+rFBYeViT0688pagFg6F/jiLCoEi468sSi2vdEyCBiBEoYS6qJVIvFSVOHZDNKnIPTa3oA++4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nRg0hfLt; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724149479; x=1755685479;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7N5eGTkDiG8Qvv/AIj8ZvUfBEc+qQ7WfM1ZJ92TKzX0=;
  b=nRg0hfLtgR8q44r0wJ65wVbsbw2ET4VepMjKDOdW7+4aDTf3LrAhkWCC
   gvFa8KCd+t0b42IS2S+ZZCMISkUvvUDd1KS6pjzhte4AeULdqVnHk6Vox
   kLq+o5DWYZEw3F0/z2CT//PSQSRCLEDoTVITmii1gFdi9758MAqd+9169
   jG3hVo+jxUpnPF6fCt1wf3iyIuXde6A1+HnIpVCsZ/inPJaxeCXQVIo9n
   9Tlo/58ccAzA8Np91zTbvqXXDpExEpuXTu4aBl8O3LTiiolPinKO03j/N
   x2dqLX2hr+YJx5sdYMpaswEEiIX8jae0NYS4tcJSh/4+sqeATaYPtURd8
   A==;
X-CSE-ConnectionGUID: MKhYp6FpTMSBrY5dkssExA==
X-CSE-MsgGUID: aZz/1ejwTFiUhQ1l+cAJmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="44962828"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="44962828"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:24:38 -0700
X-CSE-ConnectionGUID: 2tjR2am0TZSUwtbcPkq14w==
X-CSE-MsgGUID: bAGLMrF2TuSDmRtHOJSONw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="98152840"
Received: from unknown (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.108])
  by orviesa001.jf.intel.com with ESMTP; 20 Aug 2024 03:24:36 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v7 iwl-next 5/6] ice: Add timestamp ready bitmap for E830 products
Date: Tue, 20 Aug 2024 12:21:52 +0200
Message-ID: <20240820102402.576985-13-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240820102402.576985-8-karol.kolacinski@intel.com>
References: <20240820102402.576985-8-karol.kolacinski@intel.com>
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
 drivers/net/ethernet/intel/ice/ice_ptp.c | 56 +++++++-----------------
 drivers/net/ethernet/intel/ice/ice_ptp.h |  3 +-
 2 files changed, 17 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 861f6224540a..b438647717cc 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -942,28 +942,6 @@ ice_ptp_release_tx_tracker(struct ice_pf *pf, struct ice_ptp_tx *tx)
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
@@ -974,9 +952,11 @@ static int ice_ptp_init_tx_eth56g(struct ice_pf *pf, struct ice_ptp_tx *tx,
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
@@ -987,24 +967,27 @@ ice_ptp_init_tx_e82x(struct ice_pf *pf, struct ice_ptp_tx *tx, u8 port)
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
+ *
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
@@ -3344,20 +3327,13 @@ static int ice_ptp_init_port(struct ice_pf *pf, struct ice_ptp_port *ptp_port)
 	mutex_init(&ptp_port->ps_lock);
 
 	switch (hw->mac_type) {
-	case ICE_MAC_E810:
-	case ICE_MAC_E830:
-		return ice_ptp_init_tx_e810(pf, &ptp_port->tx);
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
-		return -ENODEV;
+		return ice_ptp_init_tx(pf, &ptp_port->tx, ptp_port->port_num);
 	}
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 5122b3a862fb..eae15b3b0286 100644
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


