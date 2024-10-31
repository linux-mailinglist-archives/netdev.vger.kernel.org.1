Return-Path: <netdev+bounces-140621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C98E89B7441
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 07:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C281C21B3E
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 06:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2171448DC;
	Thu, 31 Oct 2024 06:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HhzQMpTA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5980F13D8A3
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730354418; cv=none; b=JcwjcujsccXxwdGk/nh3jvCR+39uMzDFTFH4jLtqCApcQfCAAin5ejq8N0Vq8pRP5fzkTK1VLeYVyKfiqm5br56g/UNpx8nEOiL2HpFaGdJF/iwKyqgT4RuLAyqQDyu0uTOjcMMn4F0M9xA2o85efIJTkphHccMqWgzw06QrvRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730354418; c=relaxed/simple;
	bh=wAF3JYpaJMaVVvrRpeHUKgd/P9Xv1gBYJiwvPM/V6tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZJHvE0YZ1T1MH8nB280N8Kgh555XL9HAQzavTqgDrHzqVeM4a/5IBsf1eyaEjTloGM6REFKd27jja4o7VW0T+Dv5eunoteayGQiSCYktG7YeGudoi3aqrEL2Xr2TsURSLbn0Sg3a/zQSKtk9cD6sB1TiGYVqCDjZnmio/UDEI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HhzQMpTA; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730354416; x=1761890416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wAF3JYpaJMaVVvrRpeHUKgd/P9Xv1gBYJiwvPM/V6tg=;
  b=HhzQMpTA339PR8kcIWvWhxw5aIF5TgPmIyo4n4SXfFrj8ahVhLLekQlu
   /EDkxkcqQrCOFiwd/Muhio+YMheAtPpgInZyNlp0m5jx1bU0RACC7g5Sg
   Lrb0qQm846hQum5blO+YBUeDGAxmJSTTXXWnT9XMBwYZ3CIr/iYtwMAF7
   N8gnuV+b/fOfoWpMSvJ+CtWMxIKYtnar9C0m2N/g9/gbow57rFlhGYf/b
   H+u47jVyHSSGmh4WfQf8RvKyb2GGxvRHDsh3hYxyFn2oDywJTLAvRhH3C
   TNGCWo2U3pMbzwP6mEY4J58ZTfdh5q7cgk9xUz9JvK0tUkmU94tcAHW0e
   Q==;
X-CSE-ConnectionGUID: 4fJiECLzQGSW5X5F0AYpjQ==
X-CSE-MsgGUID: 8Hx3ymnvRA6CdCorgl5/7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30272928"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30272928"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2024 23:00:15 -0700
X-CSE-ConnectionGUID: /Vn9IotMQ1+lOF6Qy5Xjcw==
X-CSE-MsgGUID: F746RiXBQIOi6aLYDqi3dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="82183642"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa007.fm.intel.com with ESMTP; 30 Oct 2024 23:00:14 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	sridhar.samudrala@intel.com
Subject: [iwl-next v1 3/3] ice: allow changing SF VSI queues number
Date: Thu, 31 Oct 2024 07:00:09 +0100
Message-ID: <20241031060009.38979-4-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241031060009.38979-1-michal.swiatkowski@linux.intel.com>
References: <20241031060009.38979-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move setting number of Rx and Tx queues to the separate functions and
use it in SF case.

Adjust getting max Rx and Tx queues for SF usecase.

Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 37 +++++++-----
 drivers/net/ethernet/intel/ice/ice_lib.c     | 63 ++++++++++++--------
 2 files changed, 60 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 9e2f20ed55d5..c68f7796b83e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3786,22 +3786,31 @@ ice_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info)
 
 /**
  * ice_get_max_txq - return the maximum number of Tx queues for in a PF
- * @pf: PF structure
+ * @vsi: VSI structure
  */
-static int ice_get_max_txq(struct ice_pf *pf)
+static int ice_get_max_txq(struct ice_vsi *vsi)
 {
-	return min3(pf->num_lan_msix, (u16)num_online_cpus(),
-		    (u16)pf->hw.func_caps.common_cap.num_txq);
+	u16 num_queues = vsi->back->num_lan_msix;
+
+	if (vsi->max_io_eqs)
+		num_queues = vsi->max_io_eqs;
+	return min3(num_queues, (u16)num_online_cpus(),
+		    (u16)vsi->back->hw.func_caps.common_cap.num_txq);
 }
 
 /**
  * ice_get_max_rxq - return the maximum number of Rx queues for in a PF
- * @pf: PF structure
+ * @vsi: VSI structure
  */
-static int ice_get_max_rxq(struct ice_pf *pf)
+static int ice_get_max_rxq(struct ice_vsi *vsi)
 {
-	return min3(pf->num_lan_msix, (u16)num_online_cpus(),
-		    (u16)pf->hw.func_caps.common_cap.num_rxq);
+	u16 num_queues = vsi->back->num_lan_msix;
+
+	if (vsi->max_io_eqs)
+		num_queues = vsi->max_io_eqs;
+
+	return min3(num_queues, (u16)num_online_cpus(),
+		    (u16)vsi->back->hw.func_caps.common_cap.num_rxq);
 }
 
 /**
@@ -3839,8 +3848,8 @@ ice_get_channels(struct net_device *dev, struct ethtool_channels *ch)
 	struct ice_pf *pf = vsi->back;
 
 	/* report maximum channels */
-	ch->max_rx = ice_get_max_rxq(pf);
-	ch->max_tx = ice_get_max_txq(pf);
+	ch->max_rx = ice_get_max_rxq(vsi);
+	ch->max_tx = ice_get_max_txq(vsi);
 	ch->max_combined = min_t(int, ch->max_rx, ch->max_tx);
 
 	/* report current channels */
@@ -3958,14 +3967,14 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 			   vsi->tc_cfg.numtc);
 		return -EINVAL;
 	}
-	if (new_rx > ice_get_max_rxq(pf)) {
+	if (new_rx > ice_get_max_rxq(vsi)) {
 		netdev_err(dev, "Maximum allowed Rx channels is %d\n",
-			   ice_get_max_rxq(pf));
+			   ice_get_max_rxq(vsi));
 		return -EINVAL;
 	}
-	if (new_tx > ice_get_max_txq(pf)) {
+	if (new_tx > ice_get_max_txq(vsi)) {
 		netdev_err(dev, "Maximum allowed Tx channels is %d\n",
-			   ice_get_max_txq(pf));
+			   ice_get_max_txq(vsi));
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 01220e21cc81..64a6152eaaef 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -157,6 +157,32 @@ static void ice_vsi_set_num_desc(struct ice_vsi *vsi)
 	}
 }
 
+static void ice_vsi_set_num_txqs(struct ice_vsi *vsi, u16 def_qs)
+{
+	if (vsi->req_txq) {
+		vsi->alloc_txq = vsi->req_txq;
+		vsi->num_txq = vsi->req_txq;
+	} else {
+		vsi->alloc_txq = min_t(u16, def_qs, (u16)num_online_cpus());
+	}
+}
+
+static void ice_vsi_set_num_rxqs(struct ice_vsi *vsi, bool rss_ena, u16 def_qs)
+{
+	/* only 1 Rx queue unless RSS is enabled */
+	if (rss_ena) {
+		vsi->alloc_rxq = 1;
+		return;
+	}
+
+	if (vsi->req_rxq) {
+		vsi->alloc_rxq = vsi->req_rxq;
+		vsi->num_rxq = vsi->req_rxq;
+	} else {
+		vsi->alloc_rxq = min_t(u16, def_qs, (u16)num_online_cpus());
+	}
+}
+
 /**
  * ice_vsi_set_num_qs - Set number of queues, descriptors and vectors for a VSI
  * @vsi: the VSI being configured
@@ -174,31 +200,13 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
 
 	switch (vsi_type) {
 	case ICE_VSI_PF:
-		if (vsi->req_txq) {
-			vsi->alloc_txq = vsi->req_txq;
-			vsi->num_txq = vsi->req_txq;
-		} else {
-			vsi->alloc_txq = min3(pf->num_lan_msix,
-					      ice_get_avail_txq_count(pf),
-					      (u16)num_online_cpus());
-		}
-
+		ice_vsi_set_num_txqs(vsi, min(pf->num_lan_msix,
+					      ice_get_avail_txq_count(pf)));
 		pf->num_lan_tx = vsi->alloc_txq;
 
-		/* only 1 Rx queue unless RSS is enabled */
-		if (!test_bit(ICE_FLAG_RSS_ENA, pf->flags)) {
-			vsi->alloc_rxq = 1;
-		} else {
-			if (vsi->req_rxq) {
-				vsi->alloc_rxq = vsi->req_rxq;
-				vsi->num_rxq = vsi->req_rxq;
-			} else {
-				vsi->alloc_rxq = min3(pf->num_lan_msix,
-						      ice_get_avail_rxq_count(pf),
-						      (u16)num_online_cpus());
-			}
-		}
-
+		ice_vsi_set_num_rxqs(vsi, !test_bit(ICE_FLAG_RSS_ENA, pf->flags),
+				     min(pf->num_lan_msix,
+					 ice_get_avail_rxq_count(pf)));
 		pf->num_lan_rx = vsi->alloc_rxq;
 
 		vsi->num_q_vectors = min_t(int, pf->num_lan_msix,
@@ -206,9 +214,12 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
 						 vsi->alloc_txq));
 		break;
 	case ICE_VSI_SF:
-		vsi->alloc_txq = 1;
-		vsi->alloc_rxq = 1;
-		vsi->num_q_vectors = 1;
+		ice_vsi_set_num_txqs(vsi, min(vsi->max_io_eqs,
+					      ice_get_avail_txq_count(pf)));
+		ice_vsi_set_num_rxqs(vsi, !test_bit(ICE_FLAG_RSS_ENA, pf->flags),
+				     min(vsi->max_io_eqs,
+					 ice_get_avail_rxq_count(pf)));
+		vsi->num_q_vectors = max_t(int, vsi->alloc_rxq, vsi->alloc_txq);
 		vsi->irq_dyn_alloc = true;
 		break;
 	case ICE_VSI_VF:
-- 
2.42.0


