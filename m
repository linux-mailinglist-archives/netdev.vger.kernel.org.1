Return-Path: <netdev+bounces-148350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B6F9E13A9
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 07:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8186B230CA
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 06:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEC5188701;
	Tue,  3 Dec 2024 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z1MuG2yj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C007D185B76
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 06:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733209119; cv=none; b=N2s0sUoXyOFN65PCzZVZT/L4N3odavaUg5CbZYO2v3dvh7kP/Ll1/fHZaT0EkK09+i118ZOl7fk40LmqnIYUvty/vt5EmtopqyCDrbbY/n3uLPsPkKUv92YDjzgTwok6e2jcR2EVzJw02n/nljB3B0aW3VEpPxRRJdINc794Kac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733209119; c=relaxed/simple;
	bh=WTA+P4/XXhLr1GLk9KygfQOHNw0/yELW2F+dXkxRwdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hJbykTfXJmlOw0UIoHwKWyB+UdRi56vqotyPoV+rr8bh3nLQM3LIXm4WmrqDvmU9uvqWAEkgmnXk2o/Mqx18j//zxLR5sYoqAYNyvVg4ykmiLUuIs96CnOrxsSyD1B7SJF62TECZ6E8HBvyRCoZUY9ew2RfIYU5DvYYlomn3M2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z1MuG2yj; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733209118; x=1764745118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WTA+P4/XXhLr1GLk9KygfQOHNw0/yELW2F+dXkxRwdk=;
  b=Z1MuG2yjsSNMuez4m6wGNj4v2uBUJjtSCrl9rlYsk+vZO/kByk2QFxsK
   B9qy5bfLHdfdFmsLFOPKXdiECYAQ8iRKHubaj+dhpBrNY4MSFYENJrGQr
   kKVfIVgjCiR2gwxelTxUXndzP5uQnaDh4odN3z/tLRCB7ohNIRK4lL9TZ
   kg69ylE5A+04RkytZFZJ9UPXe+axQ5byU0d5+l/cDlSSaUmGRtZJcosCH
   1xp3R6DLIjpi1J740SYfokBum3lpltJCmKPr8CLDdvoyVeofwgvp7FGTt
   P7CPSY4LqAEKnxcm+YGMgjpRCXTqq41Xblw4YnXp8yBZ/yoRbjEYWJhx8
   Q==;
X-CSE-ConnectionGUID: MxKndlhyQoaQebsKYBSrbw==
X-CSE-MsgGUID: YIcSFgV7TFq2LyrKzLVb3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33330509"
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="33330509"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 22:58:37 -0800
X-CSE-ConnectionGUID: Bru2l21lSF2e5QbLKVtA3Q==
X-CSE-MsgGUID: D9b2RiRcTxatT6GhGJ4wIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,204,1728975600"; 
   d="scan'208";a="93673709"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa010.fm.intel.com with ESMTP; 02 Dec 2024 22:58:34 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	pawel.chmielewski@intel.com,
	sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com,
	pio.raczynski@gmail.com,
	konrad.knitter@intel.com,
	marcin.szycik@intel.com,
	wojciech.drewek@intel.com,
	nex.sw.ncis.nat.hpm.dev@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	David.Laight@ACULAB.COM,
	pmenzel@molgen.mpg.de,
	mschmidt@redhat.com,
	himasekharx.reddy.pucha@intel.com,
	rafal.romanowski@intel.com
Subject: [iwl-next v9 4/9] ice: get rid of num_lan_msix field
Date: Tue,  3 Dec 2024 07:58:12 +0100
Message-ID: <20241203065817.13475-5-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241203065817.13475-1-michal.swiatkowski@linux.intel.com>
References: <20241203065817.13475-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the field to allow having more queues than MSI-X on VSI. As
default the number will be the same, but if there won't be more MSI-X
available VSI can run with at least one MSI-X.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  1 -
 drivers/net/ethernet/intel/ice/ice_base.c    | 10 ++++----
 drivers/net/ethernet/intel/ice/ice_ethtool.c |  6 ++---
 drivers/net/ethernet/intel/ice/ice_irq.c     | 11 ++++-----
 drivers/net/ethernet/intel/ice/ice_lib.c     | 25 +++++++++++---------
 5 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index bf07d64a58a7..f497f7d6eb71 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -618,7 +618,6 @@ struct ice_pf {
 	u16 max_pf_txqs;	/* Total Tx queues PF wide */
 	u16 max_pf_rxqs;	/* Total Rx queues PF wide */
 	struct ice_pf_msix msix;
-	u16 num_lan_msix;	/* Total MSIX vectors for base driver */
 	u16 num_lan_tx;		/* num LAN Tx queues setup */
 	u16 num_lan_rx;		/* num LAN Rx queues setup */
 	u16 next_vsi;		/* Next free slot in pf->vsi[] - 0-based! */
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 64b4243ace03..0b3cf9baef04 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -795,13 +795,11 @@ int ice_vsi_alloc_q_vectors(struct ice_vsi *vsi)
 	return 0;
 
 err_out:
-	while (v_idx--)
-		ice_free_q_vector(vsi, v_idx);
 
-	dev_err(dev, "Failed to allocate %d q_vector for VSI %d, ret=%d\n",
-		vsi->num_q_vectors, vsi->vsi_num, err);
-	vsi->num_q_vectors = 0;
-	return err;
+	dev_info(dev, "Failed to allocate %d q_vectors for VSI %d, new value %d",
+		 vsi->num_q_vectors, vsi->vsi_num, v_idx);
+	vsi->num_q_vectors = v_idx;
+	return v_idx ? 0 : err;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index c2f53946f1c3..5d001fe95753 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3789,8 +3789,7 @@ ice_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info)
  */
 static int ice_get_max_txq(struct ice_pf *pf)
 {
-	return min3(pf->num_lan_msix, (u16)num_online_cpus(),
-		    (u16)pf->hw.func_caps.common_cap.num_txq);
+	return min(num_online_cpus(), pf->hw.func_caps.common_cap.num_txq);
 }
 
 /**
@@ -3799,8 +3798,7 @@ static int ice_get_max_txq(struct ice_pf *pf)
  */
 static int ice_get_max_rxq(struct ice_pf *pf)
 {
-	return min3(pf->num_lan_msix, (u16)num_online_cpus(),
-		    (u16)pf->hw.func_caps.common_cap.num_rxq);
+	return min(num_online_cpus(), pf->hw.func_caps.common_cap.num_rxq);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
index 4a50a6dc817e..1a7d446ab5f1 100644
--- a/drivers/net/ethernet/intel/ice/ice_irq.c
+++ b/drivers/net/ethernet/intel/ice/ice_irq.c
@@ -108,7 +108,7 @@ void ice_clear_interrupt_scheme(struct ice_pf *pf)
 int ice_init_interrupt_scheme(struct ice_pf *pf)
 {
 	int total_vectors = pf->hw.func_caps.common_cap.num_msix_vectors;
-	int vectors, max_vectors;
+	int vectors;
 
 	/* load default PF MSI-X range */
 	if (!pf->msix.min)
@@ -118,20 +118,17 @@ int ice_init_interrupt_scheme(struct ice_pf *pf)
 		pf->msix.max = min(total_vectors,
 				   ice_get_default_msix_amount(pf));
 
-	if (pci_msix_can_alloc_dyn(pf->pdev)) {
+	if (pci_msix_can_alloc_dyn(pf->pdev))
 		vectors = pf->msix.min;
-		max_vectors = total_vectors;
-	} else {
+	else
 		vectors = pf->msix.max;
-		max_vectors = vectors;
-	}
 
 	vectors = pci_alloc_irq_vectors(pf->pdev, pf->msix.min, vectors,
 					PCI_IRQ_MSIX);
 	if (vectors < pf->msix.min)
 		return -ENOMEM;
 
-	ice_init_irq_tracker(pf, max_vectors, vectors);
+	ice_init_irq_tracker(pf, pf->msix.max, vectors);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 7da2f3336c59..ecc850a43643 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -157,6 +157,16 @@ static void ice_vsi_set_num_desc(struct ice_vsi *vsi)
 	}
 }
 
+static u16 ice_get_rxq_count(struct ice_pf *pf)
+{
+	return min(ice_get_avail_rxq_count(pf), num_online_cpus());
+}
+
+static u16 ice_get_txq_count(struct ice_pf *pf)
+{
+	return min(ice_get_avail_txq_count(pf), num_online_cpus());
+}
+
 /**
  * ice_vsi_set_num_qs - Set number of queues, descriptors and vectors for a VSI
  * @vsi: the VSI being configured
@@ -178,9 +188,7 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
 			vsi->alloc_txq = vsi->req_txq;
 			vsi->num_txq = vsi->req_txq;
 		} else {
-			vsi->alloc_txq = min3(pf->num_lan_msix,
-					      ice_get_avail_txq_count(pf),
-					      (u16)num_online_cpus());
+			vsi->alloc_txq = ice_get_txq_count(pf);
 		}
 
 		pf->num_lan_tx = vsi->alloc_txq;
@@ -193,17 +201,13 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
 				vsi->alloc_rxq = vsi->req_rxq;
 				vsi->num_rxq = vsi->req_rxq;
 			} else {
-				vsi->alloc_rxq = min3(pf->num_lan_msix,
-						      ice_get_avail_rxq_count(pf),
-						      (u16)num_online_cpus());
+				vsi->alloc_rxq = ice_get_rxq_count(pf);
 			}
 		}
 
 		pf->num_lan_rx = vsi->alloc_rxq;
 
-		vsi->num_q_vectors = min_t(int, pf->num_lan_msix,
-					   max_t(int, vsi->alloc_rxq,
-						 vsi->alloc_txq));
+		vsi->num_q_vectors = max(vsi->alloc_rxq, vsi->alloc_txq);
 		break;
 	case ICE_VSI_SF:
 		vsi->alloc_txq = 1;
@@ -1173,12 +1177,11 @@ static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 static void
 ice_chnl_vsi_setup_q_map(struct ice_vsi *vsi, struct ice_vsi_ctx *ctxt)
 {
-	struct ice_pf *pf = vsi->back;
 	u16 qcount, qmap;
 	u8 offset = 0;
 	int pow;
 
-	qcount = min_t(int, vsi->num_rxq, pf->num_lan_msix);
+	qcount = vsi->num_rxq;
 
 	pow = order_base_2(qcount);
 	qmap = FIELD_PREP(ICE_AQ_VSI_TC_Q_OFFSET_M, offset);
-- 
2.42.0


