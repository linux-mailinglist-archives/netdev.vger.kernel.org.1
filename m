Return-Path: <netdev+bounces-138609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF659AE47D
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 14:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A5211C21F45
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 12:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC341D5151;
	Thu, 24 Oct 2024 12:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mkGaytF8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6791D5149
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 12:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729771969; cv=none; b=uSWNk0i7TM9LZpSAkZ65p4lCCHcsXZ9HWcobUEnETuQ0D9HGtbYrFhqZQIs/hyRnj/N4ho22Xj/CbQVtgRYtoe7UCpEYOafgFaRBTdHi9LPlZ+6aOD10Dd2MsTr9aZjgo3JWXnAL1rJ4w/sJuABbyKWHe+jjez2fE3C0a/gfU3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729771969; c=relaxed/simple;
	bh=G2HBjgNGxpBvGGTWrYgVvSgYDXaum8XjkVDO1u6EnAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUjXDOYBBHD1jx5uLU4a1sydqgG0OnMYagVYwhyEbaHagfi8T0VvWQMhuzGbo2RjwnW+hPvj7hbQ+jNq8X05MFyVPw/1k3TFKRklbrDKB4cvJYRqX0DiNaQSfkrnNZg/BsUL2oTVNPfZXqyJISXCbHhEf+9mqDmnsYrq5Ckrs3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mkGaytF8; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729771967; x=1761307967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G2HBjgNGxpBvGGTWrYgVvSgYDXaum8XjkVDO1u6EnAk=;
  b=mkGaytF8ZsxJ9ba0HM4ju77y6e8ncHF25kDFIpwVDKyOAnL99qFzO+LM
   RldBvPGzKUBMIoyf8ypPcyLp9g/UArjh0PbIlVWgj/gdovcnaxjxfDPNQ
   LnCv7RWKZmftAwJdz7EjrnVbF6xqjEYiXusRgrCy+PH92BtSiAMQpKGaC
   Yt198RwLZGxVFqbrDbBnqB4UnTNU+5k8SN6QsReURPk5LjTTyRcw4T3wr
   u5y0O35mQlW4lUDrDKLAW2moh4uogRVipHSxvJ3R6duWVulHmfU3/Lgh/
   8ey1naX2qR6qnAqwrnZ0cNr4e/bvQFFksKuBSH7Dv3mfaaAL1i43OlXik
   A==;
X-CSE-ConnectionGUID: aYP+oa1rRcCAYfkrgJuMpw==
X-CSE-MsgGUID: mxzDf4MJSFyM8Q6kt/xlWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11235"; a="40008296"
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="40008296"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 05:12:47 -0700
X-CSE-ConnectionGUID: I/TiOx7LTbqu4RBIRZ9xrQ==
X-CSE-MsgGUID: k4UVak+ITXup1EulkUc3Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,229,1725346800"; 
   d="scan'208";a="85184473"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa004.fm.intel.com with ESMTP; 24 Oct 2024 05:12:44 -0700
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
	David.Laight@ACULAB.COM
Subject: [iwl-next v5 4/9] ice: get rid of num_lan_msix field
Date: Thu, 24 Oct 2024 14:12:25 +0200
Message-ID: <20241024121230.5861-5-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241024121230.5861-1-michal.swiatkowski@linux.intel.com>
References: <20241024121230.5861-1-michal.swiatkowski@linux.intel.com>
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

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         |  1 -
 drivers/net/ethernet/intel/ice/ice_base.c    | 10 ++++----
 drivers/net/ethernet/intel/ice/ice_ethtool.c |  6 ++---
 drivers/net/ethernet/intel/ice/ice_irq.c     | 11 ++++-----
 drivers/net/ethernet/intel/ice/ice_lib.c     | 25 +++++++++++---------
 5 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 949b51434761..445f266d9cb9 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -622,7 +622,6 @@ struct ice_pf {
 	u16 max_pf_txqs;	/* Total Tx queues PF wide */
 	u16 max_pf_rxqs;	/* Total Rx queues PF wide */
 	struct ice_pf_msix msix;
-	u16 num_lan_msix;	/* Total MSIX vectors for base driver */
 	u16 num_lan_tx;		/* num LAN Tx queues setup */
 	u16 num_lan_rx;		/* num LAN Rx queues setup */
 	u16 next_vsi;		/* Next free slot in pf->vsi[] - 0-based! */
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 3a8e156d7d86..626f0a26d2c6 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -797,13 +797,11 @@ int ice_vsi_alloc_q_vectors(struct ice_vsi *vsi)
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
index 3d89d5303cd1..f1d5e43251ad 100644
--- a/drivers/net/ethernet/intel/ice/ice_irq.c
+++ b/drivers/net/ethernet/intel/ice/ice_irq.c
@@ -101,7 +101,7 @@ void ice_clear_interrupt_scheme(struct ice_pf *pf)
 int ice_init_interrupt_scheme(struct ice_pf *pf)
 {
 	int total_vectors = pf->hw.func_caps.common_cap.num_msix_vectors;
-	int vectors, max_vectors;
+	int vectors;
 
 	/* load default PF MSI-X range */
 	if (!pf->msix.min)
@@ -110,20 +110,17 @@ int ice_init_interrupt_scheme(struct ice_pf *pf)
 	if (!pf->msix.max)
 		pf->msix.max = total_vectors / 2;
 
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
index 01220e21cc81..bf88785c0c8a 100644
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


