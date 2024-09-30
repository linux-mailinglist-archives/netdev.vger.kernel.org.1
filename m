Return-Path: <netdev+bounces-130350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2179A98A225
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 14:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E4F11F2367C
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 12:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB52199FBA;
	Mon, 30 Sep 2024 12:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DDzYH+3B"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439B8199E89
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 12:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727698586; cv=none; b=NFyDTJkcd75aezhjkIy6J5moL4gcWhZHq61eY7nml/neFWiQx6CIs9mS9WDdR5SzRBnz83cLjnxBeX9Ebey+ep+FbJEU5DVx/cLv8U7SmtyMf2Jvy70a3fDg4yh/x6d9ZoQQnkYR8lewKmF6dENnDsnpU4lojvqn9xx0jSvrbB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727698586; c=relaxed/simple;
	bh=OXtRQhRFvUYsb53Xo0Q1ez8WpG6DQbQfxSDVanojs54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XCMXDHzIGv+y69fGNbMf4bHOAtAVt7aZdgnsJl2wRlUn7le6Di+RmW8lrXAfNgS+3ojU5z3JIp0ZfCWEWO/ojcW+S/pjuxYhCGfj5Jby5f7+BkIhjobY1KuzcZr29rTiLTGDW+PWJyNBF9eGeir/PilO4tlih4aMMtSeGrVHang=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DDzYH+3B; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727698585; x=1759234585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OXtRQhRFvUYsb53Xo0Q1ez8WpG6DQbQfxSDVanojs54=;
  b=DDzYH+3BFQi3/gIZEuHNZNsb3L9Ifjqy7wM7KnIBXk0rkaVaHtdIvx47
   jtDPeTiMyIUkOtTx/AJtTW4x+n0DCnplCC1Nu/1aVTmdttBK4dIv/5N+r
   tlyrACH0wutcUzf60Wpt8oZpkFL3Z2ZxKIDvLz6C8g9OysGh2fiCG9rX7
   veEOD0uvm65SZvXlGWV6MbQykfGFBGP5ivAFpT/tRmp0L4FidwtqSDlrr
   Voc14p7L6nT6GYiqrcdfXsLbS++32kOVCqLT+4CXy+57aajzbMNJ5SvXX
   ULiPQwgr6fb1JNiJw/7tdo90tFjclUOIE5o+iDCaB2Mk4/UywF2ZRnA2X
   w==;
X-CSE-ConnectionGUID: esHnYm8GR5en0sx+XXw9Sw==
X-CSE-MsgGUID: mBC8FXIsR5+0ZHi6RAOzmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="26666787"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="26666787"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 05:16:25 -0700
X-CSE-ConnectionGUID: AIpsz+HkSjiTq/QUD/zWOA==
X-CSE-MsgGUID: WjjR9XQDR3qJCPgJmVVpWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="73592825"
Received: from kkolacin-desk1.igk.intel.com ([10.217.160.108])
  by fmviesa010.fm.intel.com with ESMTP; 30 Sep 2024 05:16:23 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v12 iwl-next 6/7] ice: Refactor ice_ptp_init_tx_*
Date: Mon, 30 Sep 2024 14:12:43 +0200
Message-ID: <20240930121610.679430-15-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240930121610.679430-9-karol.kolacinski@intel.com>
References: <20240930121610.679430-9-karol.kolacinski@intel.com>
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
index fb364c9ff4b3..cf8a9dc0e29f 100644
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
2.46.1


