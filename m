Return-Path: <netdev+bounces-234304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E81FCC1F2C3
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B42CB4E15E2
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 09:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163352BDC25;
	Thu, 30 Oct 2025 09:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NRuese9T"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA91C37A3A0
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 09:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815049; cv=none; b=FSFbtUx92kCpyUl1DvHjtxlx7JgQVC+VgD2wHlQGmd3e/BWZHjVMVpvP/DBi1NCksZdWPjtny+xgLb9AyIJ++lwpzQea0NBbiODsRuTyyQ7TqAyTKJ/+opZKiobZSnshsBcUmBxzDIeAWz8huC7NfS5+2QSAfptT+zbtOs9iG3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815049; c=relaxed/simple;
	bh=NQz9mtyQ3kbfgKNwxwkoZhI35YM8EEwYuaM+QW+FjI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TEO8ynhYrT4lFeqFlHzrfaGJcqVChdjHfTmzDkzdH282+UfeJAxPlDvVdIG3vPd+WHJlP8nWLE0elyzifp2KQV2SLObO7ib1wkSlkdhjOIZRUwlhAeGo7YOuXHBMXqTYc1WoquEOPQPMSB8kzXB/OCuxZlz9mGw3PvGrzESlZeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NRuese9T; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761815047; x=1793351047;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NQz9mtyQ3kbfgKNwxwkoZhI35YM8EEwYuaM+QW+FjI8=;
  b=NRuese9TP0pxRzIeFds3pcfIpPJUD3etRdu7D8nseB+aUVrUSScAeU46
   DyX1ia+DNrIqIg3rTe8gflzsNCBRAexygT2qOqtsYdZo2mTrulWr0cEZ7
   mIhn2zf/LiZCR9W7rJP4nZ9+Af3wl+V4b93cHEhq+qwjyrprd/ts+ubE4
   Q9aDkirZkgB9Q7l/DOqMucHRnmr5hFYz6rWV4xdJxcuDuWxLzzoLWn+1m
   h6GG+k0ahXsT48UFPoaaH7ZpqNdFPLrKaQcq+CdnkEgp+oajpCFM9laoc
   7Wg4tN8K/aSGG6kW8Al6uf//QyXRmJV2NrPV+9AoDs6EClGCOlUkjIkCq
   w==;
X-CSE-ConnectionGUID: d3rz7HIxRfCCTwK8y12hWg==
X-CSE-MsgGUID: 8TYh1VLXQpuqkckpnC/3fQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63983182"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="63983182"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 02:04:06 -0700
X-CSE-ConnectionGUID: iP8AZmHOQtiVpCl0RxZP+w==
X-CSE-MsgGUID: l5nv9fnAQ7SdSZDvOXwS5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="190235827"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by orviesa004.jf.intel.com with ESMTP; 30 Oct 2025 02:04:05 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pmenzel@molgen.mpg.de,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v3] ice: use netif_get_num_default_rss_queues()
Date: Thu, 30 Oct 2025 09:30:53 +0100
Message-ID: <20251030083053.2166525-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some high-core systems (like AMD EPYC Bergamo, Intel Clearwater
Forest) loading ice driver with default values can lead to queue/irq
exhaustion. It will result in no additional resources for SR-IOV.

In most cases there is no performance reason for more than half
num_cpus(). Limit the default value to it using generic
netif_get_num_default_rss_queues().

Still, using ethtool the number of queues can be changed up to
num_online_cpus(). It can be done by calling:
$ethtool -L ethX combined $(nproc)

This change affects only the default queue amount.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
v2 --> v3:
 * use $(nproc) in command example in commit message

v1 --> v2:
 * Follow Olek's comment and switch from custom limiting to the generic
   netif_...() function.
 * Add more info in commit message (Paul)
 * Dropping RB tags, as it is different patch now
---
 drivers/net/ethernet/intel/ice/ice_irq.c |  5 +++--
 drivers/net/ethernet/intel/ice/ice_lib.c | 12 ++++++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
index 30801fd375f0..1d9b2d646474 100644
--- a/drivers/net/ethernet/intel/ice/ice_irq.c
+++ b/drivers/net/ethernet/intel/ice/ice_irq.c
@@ -106,9 +106,10 @@ static struct ice_irq_entry *ice_get_irq_res(struct ice_pf *pf,
 #define ICE_RDMA_AEQ_MSIX 1
 static int ice_get_default_msix_amount(struct ice_pf *pf)
 {
-	return ICE_MIN_LAN_OICR_MSIX + num_online_cpus() +
+	return ICE_MIN_LAN_OICR_MSIX + netif_get_num_default_rss_queues() +
 	       (test_bit(ICE_FLAG_FD_ENA, pf->flags) ? ICE_FDIR_MSIX : 0) +
-	       (ice_is_rdma_ena(pf) ? num_online_cpus() + ICE_RDMA_AEQ_MSIX : 0);
+	       (ice_is_rdma_ena(pf) ? netif_get_num_default_rss_queues() +
+				      ICE_RDMA_AEQ_MSIX : 0);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index bac481e8140d..e366d089bef9 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -159,12 +159,14 @@ static void ice_vsi_set_num_desc(struct ice_vsi *vsi)
 
 static u16 ice_get_rxq_count(struct ice_pf *pf)
 {
-	return min(ice_get_avail_rxq_count(pf), num_online_cpus());
+	return min(ice_get_avail_rxq_count(pf),
+		   netif_get_num_default_rss_queues());
 }
 
 static u16 ice_get_txq_count(struct ice_pf *pf)
 {
-	return min(ice_get_avail_txq_count(pf), num_online_cpus());
+	return min(ice_get_avail_txq_count(pf),
+		   netif_get_num_default_rss_queues());
 }
 
 /**
@@ -907,13 +909,15 @@ static void ice_vsi_set_rss_params(struct ice_vsi *vsi)
 		if (vsi->type == ICE_VSI_CHNL)
 			vsi->rss_size = min_t(u16, vsi->num_rxq, max_rss_size);
 		else
-			vsi->rss_size = min_t(u16, num_online_cpus(),
+			vsi->rss_size = min_t(u16,
+					      netif_get_num_default_rss_queues(),
 					      max_rss_size);
 		vsi->rss_lut_type = ICE_LUT_PF;
 		break;
 	case ICE_VSI_SF:
 		vsi->rss_table_size = ICE_LUT_VSI_SIZE;
-		vsi->rss_size = min_t(u16, num_online_cpus(), max_rss_size);
+		vsi->rss_size = min_t(u16, netif_get_num_default_rss_queues(),
+				      max_rss_size);
 		vsi->rss_lut_type = ICE_LUT_VSI;
 		break;
 	case ICE_VSI_VF:
-- 
2.49.0


