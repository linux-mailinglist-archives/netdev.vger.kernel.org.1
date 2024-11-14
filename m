Return-Path: <netdev+bounces-144874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFAE9C89EB
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 13:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCBE8B2CEC7
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E681E1AA7A2;
	Thu, 14 Nov 2024 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UXZhThG+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9361F9AA8
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 12:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586824; cv=none; b=FZw5NqQzaxc0uM0x2i4ACRiU9U5aRHTtWEbP4w8DiYvYiA0idonmf+o0MPb4ivlYPhTrJLcDtHigEw+nfaV2IYhcCt8bPE+eD/Q8kK5xj4dVn9nGDtYI/3Veo5kU7qcUWq5WJJslNiUfaq+bWZ8l6P3NoFSDrtnl6VfFBJ+0hPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586824; c=relaxed/simple;
	bh=vG5PT+LRcFWRKQ7gLisT6orX1rLiZZEsa27JP17mFZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnIycrxS1eOTL9n4HZ6agSzO61idIMu7AhrDypAN5j+6Z0Ov1WrQm1nTAPRsZxI8UexlAWmk+vbKbteIrOQSPDYEBhw6OXW60nRU68+ve7uBV434GQI/A8yVgiIpGINxKLlqBnJbvIQ8oNOZEMZeZ6/PZYpD0CtpclVrQXWDAdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UXZhThG+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731586823; x=1763122823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vG5PT+LRcFWRKQ7gLisT6orX1rLiZZEsa27JP17mFZ0=;
  b=UXZhThG+tK8hOL73l1U4jA3BPUVhEgHG+L9ZoT7VBgpAOMpizT4PgC5z
   uTHRi0VGGUlBe9thtY3YjlVphjaVunbbp131u/6/TUm+zIFKSiHQ0WyNO
   tUFg2q7t7y5nX2oap4zQpYLkK2TCHmm1ZgNRjGpM5FJPsOcjuFeNxq5t+
   LWr6Mf5t+HgnBKS4DeN8z6Hj5RhWiVVDBuWSsYLZP3ErIplF70c972Cvl
   lm4xENr08sFrG82xkMo6km+kSS+xBhPq2ZMBhhSQMZZl4pn0rmWgfU7ko
   m4xMXjae19Kbm879jlCnhxjTObnvfgPf3WMsJvUBAQjI64N1tFg5lZAgG
   A==;
X-CSE-ConnectionGUID: IWVbb7nIRXuMdYFApBCQvg==
X-CSE-MsgGUID: 5GgG+sQnThmb4Kmdsfw8Tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="56916871"
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="56916871"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 04:20:23 -0800
X-CSE-ConnectionGUID: 4MNzM4j+TmOXT6egpb3aXg==
X-CSE-MsgGUID: KQ5PX0/yTQC3w9UW3jLjOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="93135847"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by orviesa003.jf.intel.com with ESMTP; 14 Nov 2024 04:20:18 -0800
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
	rafal.romanowski@intel.com
Subject: [PATCH 2/8] ice: remove splitting MSI-X between features
Date: Thu, 14 Nov 2024 13:18:34 +0100
Message-ID: <20241114122009.97416-3-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241114122009.97416-1-michal.swiatkowski@linux.intel.com>
References: <20241114122009.97416-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With dynamic approach to alloc MSI-X there is no sense to statically
split MSI-X between PF features.

Splitting was also calculating needed MSI-X. Move this part to separate
function and use as max value.

Remove ICE_ESWITCH_MSIX, as there is no need for additional MSI-X for
switchdev.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h     |   2 -
 drivers/net/ethernet/intel/ice/ice_irq.c | 172 +++--------------------
 2 files changed, 16 insertions(+), 158 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 3e6036e8366b..74243126a12e 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -97,8 +97,6 @@
 #define ICE_MIN_MSIX		(ICE_MIN_LAN_TXRX_MSIX + ICE_MIN_LAN_OICR_MSIX)
 #define ICE_FDIR_MSIX		2
 #define ICE_RDMA_NUM_AEQ_MSIX	4
-#define ICE_MIN_RDMA_MSIX	2
-#define ICE_ESWITCH_MSIX	1
 #define ICE_NO_VSI		0xffff
 #define ICE_VSI_MAP_CONTIG	0
 #define ICE_VSI_MAP_SCATTER	1
diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
index 0659b96b9b8c..4a50a6dc817e 100644
--- a/drivers/net/ethernet/intel/ice/ice_irq.c
+++ b/drivers/net/ethernet/intel/ice/ice_irq.c
@@ -84,155 +84,11 @@ static struct ice_irq_entry *ice_get_irq_res(struct ice_pf *pf, bool dyn_only)
 	return entry;
 }
 
-/**
- * ice_reduce_msix_usage - Reduce usage of MSI-X vectors
- * @pf: board private structure
- * @v_remain: number of remaining MSI-X vectors to be distributed
- *
- * Reduce the usage of MSI-X vectors when entire request cannot be fulfilled.
- * pf->num_lan_msix and pf->num_rdma_msix values are set based on number of
- * remaining vectors.
- */
-static void ice_reduce_msix_usage(struct ice_pf *pf, int v_remain)
+static int ice_get_default_msix_amount(struct ice_pf *pf)
 {
-	int v_rdma;
-
-	if (!ice_is_rdma_ena(pf)) {
-		pf->num_lan_msix = v_remain;
-		return;
-	}
-
-	/* RDMA needs at least 1 interrupt in addition to AEQ MSIX */
-	v_rdma = ICE_RDMA_NUM_AEQ_MSIX + 1;
-
-	if (v_remain < ICE_MIN_LAN_TXRX_MSIX + ICE_MIN_RDMA_MSIX) {
-		dev_warn(ice_pf_to_dev(pf), "Not enough MSI-X vectors to support RDMA.\n");
-		clear_bit(ICE_FLAG_RDMA_ENA, pf->flags);
-
-		pf->num_rdma_msix = 0;
-		pf->num_lan_msix = ICE_MIN_LAN_TXRX_MSIX;
-	} else if ((v_remain < ICE_MIN_LAN_TXRX_MSIX + v_rdma) ||
-		   (v_remain - v_rdma < v_rdma)) {
-		/* Support minimum RDMA and give remaining vectors to LAN MSIX
-		 */
-		pf->num_rdma_msix = ICE_MIN_RDMA_MSIX;
-		pf->num_lan_msix = v_remain - ICE_MIN_RDMA_MSIX;
-	} else {
-		/* Split remaining MSIX with RDMA after accounting for AEQ MSIX
-		 */
-		pf->num_rdma_msix = (v_remain - ICE_RDMA_NUM_AEQ_MSIX) / 2 +
-				    ICE_RDMA_NUM_AEQ_MSIX;
-		pf->num_lan_msix = v_remain - pf->num_rdma_msix;
-	}
-}
-
-/**
- * ice_ena_msix_range - Request a range of MSIX vectors from the OS
- * @pf: board private structure
- *
- * Compute the number of MSIX vectors wanted and request from the OS. Adjust
- * device usage if there are not enough vectors. Return the number of vectors
- * reserved or negative on failure.
- */
-static int ice_ena_msix_range(struct ice_pf *pf)
-{
-	int num_cpus, hw_num_msix, v_other, v_wanted, v_actual;
-	struct device *dev = ice_pf_to_dev(pf);
-	int err;
-
-	hw_num_msix = pf->hw.func_caps.common_cap.num_msix_vectors;
-	num_cpus = num_online_cpus();
-
-	/* LAN miscellaneous handler */
-	v_other = ICE_MIN_LAN_OICR_MSIX;
-
-	/* Flow Director */
-	if (test_bit(ICE_FLAG_FD_ENA, pf->flags))
-		v_other += ICE_FDIR_MSIX;
-
-	/* switchdev */
-	v_other += ICE_ESWITCH_MSIX;
-
-	v_wanted = v_other;
-
-	/* LAN traffic */
-	pf->num_lan_msix = num_cpus;
-	v_wanted += pf->num_lan_msix;
-
-	/* RDMA auxiliary driver */
-	if (ice_is_rdma_ena(pf)) {
-		pf->num_rdma_msix = num_cpus + ICE_RDMA_NUM_AEQ_MSIX;
-		v_wanted += pf->num_rdma_msix;
-	}
-
-	if (v_wanted > hw_num_msix) {
-		int v_remain;
-
-		dev_warn(dev, "not enough device MSI-X vectors. wanted = %d, available = %d\n",
-			 v_wanted, hw_num_msix);
-
-		if (hw_num_msix < ICE_MIN_MSIX) {
-			err = -ERANGE;
-			goto exit_err;
-		}
-
-		v_remain = hw_num_msix - v_other;
-		if (v_remain < ICE_MIN_LAN_TXRX_MSIX) {
-			v_other = ICE_MIN_MSIX - ICE_MIN_LAN_TXRX_MSIX;
-			v_remain = ICE_MIN_LAN_TXRX_MSIX;
-		}
-
-		ice_reduce_msix_usage(pf, v_remain);
-		v_wanted = pf->num_lan_msix + pf->num_rdma_msix + v_other;
-
-		dev_notice(dev, "Reducing request to %d MSI-X vectors for LAN traffic.\n",
-			   pf->num_lan_msix);
-		if (ice_is_rdma_ena(pf))
-			dev_notice(dev, "Reducing request to %d MSI-X vectors for RDMA.\n",
-				   pf->num_rdma_msix);
-	}
-
-	/* actually reserve the vectors */
-	v_actual = pci_alloc_irq_vectors(pf->pdev, ICE_MIN_MSIX, v_wanted,
-					 PCI_IRQ_MSIX);
-	if (v_actual < 0) {
-		dev_err(dev, "unable to reserve MSI-X vectors\n");
-		err = v_actual;
-		goto exit_err;
-	}
-
-	if (v_actual < v_wanted) {
-		dev_warn(dev, "not enough OS MSI-X vectors. requested = %d, obtained = %d\n",
-			 v_wanted, v_actual);
-
-		if (v_actual < ICE_MIN_MSIX) {
-			/* error if we can't get minimum vectors */
-			pci_free_irq_vectors(pf->pdev);
-			err = -ERANGE;
-			goto exit_err;
-		} else {
-			int v_remain = v_actual - v_other;
-
-			if (v_remain < ICE_MIN_LAN_TXRX_MSIX)
-				v_remain = ICE_MIN_LAN_TXRX_MSIX;
-
-			ice_reduce_msix_usage(pf, v_remain);
-
-			dev_notice(dev, "Enabled %d MSI-X vectors for LAN traffic.\n",
-				   pf->num_lan_msix);
-
-			if (ice_is_rdma_ena(pf))
-				dev_notice(dev, "Enabled %d MSI-X vectors for RDMA.\n",
-					   pf->num_rdma_msix);
-		}
-	}
-
-	return v_actual;
-
-exit_err:
-	pf->num_rdma_msix = 0;
-	pf->num_lan_msix = 0;
-	return err;
+	return ICE_MIN_LAN_OICR_MSIX + num_online_cpus() +
+	       (test_bit(ICE_FLAG_FD_ENA, pf->flags) ? ICE_FDIR_MSIX : 0) +
+	       (ice_is_rdma_ena(pf) ? num_online_cpus() + ICE_RDMA_NUM_AEQ_MSIX : 0);
 }
 
 /**
@@ -259,17 +115,21 @@ int ice_init_interrupt_scheme(struct ice_pf *pf)
 		pf->msix.min = ICE_MIN_MSIX;
 
 	if (!pf->msix.max)
-		pf->msix.max = total_vectors / 2;
-
-	vectors = ice_ena_msix_range(pf);
+		pf->msix.max = min(total_vectors,
+				   ice_get_default_msix_amount(pf));
 
-	if (vectors < 0)
-		return -ENOMEM;
-
-	if (pci_msix_can_alloc_dyn(pf->pdev))
+	if (pci_msix_can_alloc_dyn(pf->pdev)) {
+		vectors = pf->msix.min;
 		max_vectors = total_vectors;
-	else
+	} else {
+		vectors = pf->msix.max;
 		max_vectors = vectors;
+	}
+
+	vectors = pci_alloc_irq_vectors(pf->pdev, pf->msix.min, vectors,
+					PCI_IRQ_MSIX);
+	if (vectors < pf->msix.min)
+		return -ENOMEM;
 
 	ice_init_irq_tracker(pf, max_vectors, vectors);
 
-- 
2.42.0


