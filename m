Return-Path: <netdev+bounces-42750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6287D0098
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 19:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A06BA1C20F2B
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 17:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A1D3588D;
	Thu, 19 Oct 2023 17:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/MScNra"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5561634CEA
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 17:32:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4A3116
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697736757; x=1729272757;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TAksRarHa7tMnZNs4/LhxGtnH/P74jw9RFYwtEsw6Yg=;
  b=U/MScNraqkpv225jbMCwpFg4+acbsI33k2Iq/zr/cRge+1HnDOTtKtS2
   acZtwhC+GH1yss1O9G1PhUgU0JVncl7oj8qr2qbAnEnldapkyO0fyQjai
   b2Nnz2wTx5fqTGjN91mxHrErWzWIAjLveWAiP0Ca6V8cHMHF7XgjwnEbd
   6VChXWE3jUamnFiwABTZIzcbORSeOga4rLgc16Mu4NktnkwuKYoe48Vp9
   f2xsDfiD+24Q6A5WpibdtMWM2oCfZCYOGHwzsvnPw2pPh2S2ZfJlvW0LM
   dqx+fNe5W2o/yUwKufLF6qw6aC+Ufu2JXWZAyVtxTkbtLa0mzCiaKiQbY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="389183702"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="389183702"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:32:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="760722692"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="760722692"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:32:35 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next 06/11] ice: set MSI-X vector count on VF
Date: Thu, 19 Oct 2023 10:32:22 -0700
Message-ID: <20231019173227.3175575-7-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019173227.3175575-1-jacob.e.keller@intel.com>
References: <20231019173227.3175575-1-jacob.e.keller@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Implement ops needed to set MSI-X vector count on VF.

sriov_get_vf_total_msix() should return total number of MSI-X that can
be used by the VFs. Return the value set by devlink resources API
(pf->req_msix.vf).

sriov_set_msix_vec_count() will set number of MSI-X on particular VF.
Disable VF register mapping, rebuild VSI with new MSI-X and queues
values and enable new VF register mapping.

For best performance set number of queues equal to number of MSI-X.

Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c  |  2 +
 drivers/net/ethernet/intel/ice/ice_sriov.c | 69 ++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_sriov.h | 13 ++++
 3 files changed, 84 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 646b407d465c..33c8fcc78f41 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5617,6 +5617,8 @@ static struct pci_driver ice_driver = {
 #endif /* CONFIG_PM */
 	.shutdown = ice_shutdown,
 	.sriov_configure = ice_sriov_configure,
+	.sriov_get_vf_total_msix = ice_sriov_get_vf_total_msix,
+	.sriov_set_msix_vec_count = ice_sriov_set_msix_vec_count,
 	.err_handler = &ice_pci_err_handler
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 49adb0b05817..679bf63fd17a 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -987,6 +987,75 @@ static int ice_check_sriov_allowed(struct ice_pf *pf)
 	return 0;
 }
 
+/**
+ * ice_sriov_get_vf_total_msix - return number of MSI-X used by VFs
+ * @pdev: pointer to pci_dev struct
+ *
+ * The function is called via sysfs ops
+ */
+u32 ice_sriov_get_vf_total_msix(struct pci_dev *pdev)
+{
+	struct ice_pf *pf = pci_get_drvdata(pdev);
+
+	return pf->sriov_irq_size - ice_get_max_used_msix_vector(pf);
+}
+
+/**
+ * ice_sriov_set_msix_vec_count
+ * @vf_dev: pointer to pci_dev struct of VF device
+ * @msix_vec_count: new value for MSI-X amount on this VF
+ *
+ * Set requested MSI-X, queues and registers for @vf_dev.
+ *
+ * First do some sanity checks like if there are any VFs, if the new value
+ * is correct etc. Then disable old mapping (MSI-X and queues registers), change
+ * MSI-X and queues, rebuild VSI and enable new mapping.
+ *
+ * If it is possible (driver not binded to VF) try to remap also other VFs to
+ * linearize irqs register usage.
+ */
+int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
+{
+	struct pci_dev *pdev = pci_physfn(vf_dev);
+	struct ice_pf *pf = pci_get_drvdata(pdev);
+	struct ice_vf *vf;
+	u16 queues;
+	int id;
+
+	if (!ice_get_num_vfs(pf))
+		return -ENOENT;
+
+	if (!msix_vec_count)
+		return 0;
+
+	queues = msix_vec_count;
+	/* add 1 MSI-X for OICR */
+	msix_vec_count += 1;
+
+	/* Transition of PCI VF function number to function_id */
+	for (id = 0; id < pci_num_vf(pdev); id++) {
+		if (vf_dev->devfn == pci_iov_virtfn_devfn(pdev, id))
+			break;
+	}
+
+	if (id == pci_num_vf(pdev))
+		return -ENOENT;
+
+	vf = ice_get_vf_by_id(pf, id);
+
+	if (!vf)
+		return -ENOENT;
+
+	ice_dis_vf_mappings(vf);
+	vf->num_msix = msix_vec_count;
+	vf->num_vf_qs = queues;
+	ice_vsi_rebuild(ice_get_vf_vsi(vf), ICE_VSI_FLAG_NO_INIT);
+	ice_ena_vf_mappings(vf);
+	ice_put_vf(vf);
+
+	return 0;
+}
+
 /**
  * ice_sriov_configure - Enable or change number of VFs via sysfs
  * @pdev: pointer to a pci_dev structure
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.h b/drivers/net/ethernet/intel/ice/ice_sriov.h
index 06829443d540..8488df38b586 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.h
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.h
@@ -60,6 +60,8 @@ void ice_print_vfs_mdd_events(struct ice_pf *pf);
 void ice_print_vf_rx_mdd_event(struct ice_vf *vf);
 bool
 ice_vc_validate_pattern(struct ice_vf *vf, struct virtchnl_proto_hdrs *proto);
+u32 ice_sriov_get_vf_total_msix(struct pci_dev *pdev);
+int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count);
 #else /* CONFIG_PCI_IOV */
 static inline void ice_process_vflr_event(struct ice_pf *pf) { }
 static inline void ice_free_vfs(struct ice_pf *pf) { }
@@ -142,5 +144,16 @@ ice_get_vf_stats(struct net_device __always_unused *netdev,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline u32 ice_sriov_get_vf_total_msix(struct pci_dev *pdev)
+{
+	return 0;
+}
+
+static inline int
+ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_PCI_IOV */
 #endif /* _ICE_SRIOV_H_ */
-- 
2.41.0


