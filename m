Return-Path: <netdev+bounces-71216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4CB8529E3
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 08:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A778A1C21C87
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263FA17596;
	Tue, 13 Feb 2024 07:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PJg88UhH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E82F17998
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809473; cv=none; b=VLIst48amYs/4zjEw8h4fxeVqtJpv/GVeZ72LH3iX4GX3xFSOWaHwVUH6NlqajB/XOArU1QzmOMVttQruPu1o1JLvYzjtBtVvReQPoBvH8Psjw4u+1rkuUqYvCcDGMvM6Mz6G1NXo/rzBGoIctqh1pMSvtjC6I+4L1vqFcmux6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809473; c=relaxed/simple;
	bh=JlRPe6MTxLeS4x76G5oR4XxIb9euzskRMiWYdNzY5IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cc8VO62xPQDPGx6Y0WCRLqywr372RMt+IcWYbHgEvt89My2zllA+Lyp6DoQH80vBDK3XKSgayHMUSeQStNGDwqG35/5hh99kW+QPdhYidn4eKDYo5qQAIpkBjMhFc30Ak00B+U6Hw6fcefTA0zMJnn0+kT31f3n28qijyqOj4aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PJg88UhH; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707809471; x=1739345471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JlRPe6MTxLeS4x76G5oR4XxIb9euzskRMiWYdNzY5IM=;
  b=PJg88UhHS78TD5QQPke90iyy94f/XiX1YN3pqkyLq9Jc0lcZBY6I0ChN
   L44dsO0Iq8sSSGx0JkB+YFBJun68NMB79ItWinQ0gu9FrAWv0YsfEi2fX
   zrHldIw0uuwI0doaQo7RFMe6qBo3JEECuqDUw4TrYlfJR8VTd3G4PjviN
   pqCwl8OVIZ8xEolxPavZtw0oJpbKUipt06+kiE740BXlIbf0oFh5+XvSJ
   g5cBc6tQ8LG43W3HA7FjmXQmPa6AgnrQSyyv0UhZy293b6F62tZ567Haa
   4p9jhFLVeII4nkDCUutZ3NKfeGkqe17b4PXSXCE6g0wFiTHxdAbH5FV79
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="19219882"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="19219882"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 23:31:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="2797544"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa009.jf.intel.com with ESMTP; 12 Feb 2024 23:31:02 -0800
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
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [iwl-next v1 4/7] ice, irdma: move interrupts code to irdma
Date: Tue, 13 Feb 2024 08:35:06 +0100
Message-ID: <20240213073509.77622-5-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240213073509.77622-1-michal.swiatkowski@linux.intel.com>
References: <20240213073509.77622-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move responsibility of MSI-X requesting for RDMA feature from ice driver
to irdma driver. It is done to allow simple fallback when there is not
enough MSI-X available.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/infiniband/hw/irdma/hw.c         |  2 -
 drivers/infiniband/hw/irdma/main.c       | 46 ++++++++++++++++-
 drivers/infiniband/hw/irdma/main.h       |  3 ++
 drivers/net/ethernet/intel/ice/ice.h     |  2 -
 drivers/net/ethernet/intel/ice/ice_idc.c | 64 ++++++------------------
 include/linux/net/intel/iidc.h           |  2 +
 6 files changed, 63 insertions(+), 56 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index bd4b2b896444..748abddf71ef 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -497,8 +497,6 @@ static int irdma_save_msix_info(struct irdma_pci_f *rf)
 	iw_qvlist->num_vectors = rf->msix_count;
 	if (rf->msix_count <= num_online_cpus())
 		rf->msix_shared = true;
-	else if (rf->msix_count > num_online_cpus() + 1)
-		rf->msix_count = num_online_cpus() + 1;
 
 	pmsix = rf->msix_entries;
 	for (i = 0, ceq_idx = 0; i < rf->msix_count; i++, iw_qvinfo++) {
diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
index 3f13200ff71b..69ad137be7aa 100644
--- a/drivers/infiniband/hw/irdma/main.c
+++ b/drivers/infiniband/hw/irdma/main.c
@@ -206,6 +206,43 @@ static void irdma_lan_unregister_qset(struct irdma_sc_vsi *vsi,
 		ibdev_dbg(&iwdev->ibdev, "WS: LAN free_res for rdma qset failed.\n");
 }
 
+static int irdma_init_interrupts(struct irdma_pci_f *rf, struct ice_pf *pf)
+{
+	int i;
+
+	rf->msix_count = num_online_cpus() + IRDMA_NUM_AEQ_MSIX;
+	rf->msix_entries = kcalloc(rf->msix_count, sizeof(*rf->msix_entries),
+				   GFP_KERNEL);
+	if (!rf->msix_entries)
+		return -ENOMEM;
+
+	for (i = 0; i < rf->msix_count; i++)
+		if (ice_alloc_rdma_qvector(pf, &rf->msix_entries[i]))
+			break;
+
+	if (i < IRDMA_MIN_MSIX) {
+		for (; i >= 0; i--)
+			ice_free_rdma_qvector(pf, &rf->msix_entries[i]);
+
+		kfree(rf->msix_entries);
+		return -ENOMEM;
+	}
+
+	rf->msix_count = i;
+
+	return 0;
+}
+
+static void irdma_deinit_interrupts(struct irdma_pci_f *rf, struct ice_pf *pf)
+{
+	int i;
+
+	for (i = 0; i < rf->msix_count; i++)
+		ice_free_rdma_qvector(pf, &rf->msix_entries[i]);
+
+	kfree(rf->msix_entries);
+}
+
 static void irdma_remove(struct auxiliary_device *aux_dev)
 {
 	struct iidc_auxiliary_dev *iidc_adev = container_of(aux_dev,
@@ -216,6 +253,7 @@ static void irdma_remove(struct auxiliary_device *aux_dev)
 
 	irdma_ib_unregister_device(iwdev);
 	ice_rdma_update_vsi_filter(pf, iwdev->vsi_num, false);
+	irdma_deinit_interrupts(iwdev->rf, pf);
 
 	pr_debug("INIT: Gen2 PF[%d] device remove success\n", PCI_FUNC(pf->pdev->devfn));
 }
@@ -230,9 +268,7 @@ static void irdma_fill_device_info(struct irdma_device *iwdev, struct ice_pf *pf
 	rf->gen_ops.unregister_qset = irdma_lan_unregister_qset;
 	rf->hw.hw_addr = pf->hw.hw_addr;
 	rf->pcidev = pf->pdev;
-	rf->msix_count =  pf->num_rdma_msix;
 	rf->pf_id = pf->hw.pf_id;
-	rf->msix_entries = &pf->msix_entries[pf->rdma_base_vector];
 	rf->default_vsi.vsi_idx = vsi->vsi_num;
 	rf->protocol_used = pf->rdma_mode & IIDC_RDMA_PROTOCOL_ROCEV2 ?
 			    IRDMA_ROCE_PROTOCOL_ONLY : IRDMA_IWARP_PROTOCOL_ONLY;
@@ -281,6 +317,10 @@ static int irdma_probe(struct auxiliary_device *aux_dev, const struct auxiliary_
 	irdma_fill_device_info(iwdev, pf, vsi);
 	rf = iwdev->rf;
 
+	err = irdma_init_interrupts(rf, pf);
+	if (err)
+		goto err_init_interrupts;
+
 	err = irdma_ctrl_init_hw(rf);
 	if (err)
 		goto err_ctrl_init;
@@ -311,6 +351,8 @@ static int irdma_probe(struct auxiliary_device *aux_dev, const struct auxiliary_
 err_rt_init:
 	irdma_ctrl_deinit_hw(rf);
 err_ctrl_init:
+	irdma_deinit_interrupts(rf, pf);
+err_init_interrupts:
 	kfree(iwdev->rf);
 	ib_dealloc_device(&iwdev->ibdev);
 
diff --git a/drivers/infiniband/hw/irdma/main.h b/drivers/infiniband/hw/irdma/main.h
index b65bc2ea542f..6c6bafb7b478 100644
--- a/drivers/infiniband/hw/irdma/main.h
+++ b/drivers/infiniband/hw/irdma/main.h
@@ -117,6 +117,9 @@ extern struct auxiliary_driver i40iw_auxiliary_drv;
 
 #define IRDMA_IRQ_NAME_STR_LEN (64)
 
+#define IRDMA_NUM_AEQ_MSIX	1
+#define IRDMA_MIN_MSIX		2
+
 enum init_completion_state {
 	INVALID_STATE = 0,
 	INITIAL_STATE,
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 5c9a95883456..1f4d31549528 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -96,8 +96,6 @@
 #define ICE_MIN_MSIX		(ICE_MIN_LAN_TXRX_MSIX + ICE_MIN_LAN_OICR_MSIX)
 #define ICE_MAX_MSIX		256
 #define ICE_FDIR_MSIX		2
-#define ICE_RDMA_NUM_AEQ_MSIX	4
-#define ICE_MIN_RDMA_MSIX	2
 #define ICE_ESWITCH_MSIX	1
 #define ICE_NO_VSI		0xffff
 #define ICE_VSI_MAP_CONTIG	0
diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c b/drivers/net/ethernet/intel/ice/ice_idc.c
index 145b27f2a4ce..bab3e81cad5d 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc.c
+++ b/drivers/net/ethernet/intel/ice/ice_idc.c
@@ -228,61 +228,34 @@ void ice_get_qos_params(struct ice_pf *pf, struct iidc_qos_params *qos)
 }
 EXPORT_SYMBOL_GPL(ice_get_qos_params);
 
-/**
- * ice_alloc_rdma_qvectors - Allocate vector resources for RDMA driver
- * @pf: board private structure to initialize
- */
-static int ice_alloc_rdma_qvectors(struct ice_pf *pf)
+int ice_alloc_rdma_qvector(struct ice_pf *pf, struct msix_entry *entry)
 {
-	if (ice_is_rdma_ena(pf)) {
-		int i;
-
-		pf->msix_entries = kcalloc(pf->num_rdma_msix,
-					   sizeof(*pf->msix_entries),
-						  GFP_KERNEL);
-		if (!pf->msix_entries)
-			return -ENOMEM;
+	struct msi_map map = ice_alloc_irq(pf, true);
 
-		/* RDMA is the only user of pf->msix_entries array */
-		pf->rdma_base_vector = 0;
-
-		for (i = 0; i < pf->num_rdma_msix; i++) {
-			struct msix_entry *entry = &pf->msix_entries[i];
-			struct msi_map map;
+	if (map.index < 0)
+		return -ENOMEM;
 
-			map = ice_alloc_irq(pf, false);
-			if (map.index < 0)
-				break;
+	entry->entry = map.index;
+	entry->vector = map.virq;
 
-			entry->entry = map.index;
-			entry->vector = map.virq;
-		}
-	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ice_alloc_rdma_qvector);
 
 /**
  * ice_free_rdma_qvector - free vector resources reserved for RDMA driver
  * @pf: board private structure to initialize
+ * @entry: MSI-X entry to be removed
  */
-static void ice_free_rdma_qvector(struct ice_pf *pf)
+void ice_free_rdma_qvector(struct ice_pf *pf, struct msix_entry *entry)
 {
-	int i;
-
-	if (!pf->msix_entries)
-		return;
-
-	for (i = 0; i < pf->num_rdma_msix; i++) {
-		struct msi_map map;
+	struct msi_map map;
 
-		map.index = pf->msix_entries[i].entry;
-		map.virq = pf->msix_entries[i].vector;
-		ice_free_irq(pf, map);
-	}
-
-	kfree(pf->msix_entries);
-	pf->msix_entries = NULL;
+	map.index = entry->entry;
+	map.virq = entry->vector;
+	ice_free_irq(pf, map);
 }
+EXPORT_SYMBOL_GPL(ice_free_rdma_qvector);
 
 /**
  * ice_adev_release - function to be mapped to AUX dev's release op
@@ -382,12 +355,6 @@ int ice_init_rdma(struct ice_pf *pf)
 		return -ENOMEM;
 	}
 
-	/* Reserve vector resources */
-	ret = ice_alloc_rdma_qvectors(pf);
-	if (ret < 0) {
-		dev_err(dev, "failed to reserve vectors for RDMA\n");
-		goto err_reserve_rdma_qvector;
-	}
 	pf->rdma_mode |= IIDC_RDMA_PROTOCOL_ROCEV2;
 	ret = ice_plug_aux_dev(pf);
 	if (ret)
@@ -395,8 +362,6 @@ int ice_init_rdma(struct ice_pf *pf)
 	return 0;
 
 err_plug_aux_dev:
-	ice_free_rdma_qvector(pf);
-err_reserve_rdma_qvector:
 	pf->adev = NULL;
 	xa_erase(&ice_aux_id, pf->aux_idx);
 	return ret;
@@ -412,6 +377,5 @@ void ice_deinit_rdma(struct ice_pf *pf)
 		return;
 
 	ice_unplug_aux_dev(pf);
-	ice_free_rdma_qvector(pf);
 	xa_erase(&ice_aux_id, pf->aux_idx);
 }
diff --git a/include/linux/net/intel/iidc.h b/include/linux/net/intel/iidc.h
index 1c1332e4df26..13274c3def66 100644
--- a/include/linux/net/intel/iidc.h
+++ b/include/linux/net/intel/iidc.h
@@ -78,6 +78,8 @@ int ice_del_rdma_qset(struct ice_pf *pf, struct iidc_rdma_qset_params *qset);
 int ice_rdma_request_reset(struct ice_pf *pf, enum iidc_reset_type reset_type);
 int ice_rdma_update_vsi_filter(struct ice_pf *pf, u16 vsi_id, bool enable);
 void ice_get_qos_params(struct ice_pf *pf, struct iidc_qos_params *qos);
+int ice_alloc_rdma_qvector(struct ice_pf *pf, struct msix_entry *entry);
+void ice_free_rdma_qvector(struct ice_pf *pf, struct msix_entry *entry);
 
 /* Structure representing auxiliary driver tailored information about the core
  * PCI dev, each auxiliary driver using the IIDC interface will have an
-- 
2.42.0


