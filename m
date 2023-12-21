Return-Path: <netdev+bounces-59635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2486081B890
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 14:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD4C1F269E5
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 13:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277C96D6F4;
	Thu, 21 Dec 2023 13:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G3OoJFs4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D556D6FB
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703165261; x=1734701261;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aleQJPWuPPAp07EORrmo8USwM+efZBPIKfnkxAkmJec=;
  b=G3OoJFs4y24CPWAJA0MuTi2MPXnSM4HK57IQnpYAMLa+4tNBzPg3HtMV
   6fZqQZXmLgOQgqABmQCy6mSB6pzGcA9VH3xWylRr6tU2TyirNHRiXu121
   KdKq82AJZ8tOu+Nj7oCL9la+/kFhELxZy2fZOw7Eiow8Uq2F4EBCt2SHd
   k9BWNZPLOrO0SQ9crj8nWRtfPMVnHsDUfmc6qz6Q0Y6M69buLx02qR1Gq
   68dllaQSkdbLqFmHdCwpHED1Tt72jgqco/B1EOaqkVWOMyOAo/5xKkobs
   /HVz+cSCimN9RFPRojDLlZ8v1nyq5azefIZDsbip76u5APknkM2y9llkR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="386400167"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="386400167"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 05:27:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="18683812"
Received: from unknown (HELO amlin-019-225.igk.intel.com) ([10.102.19.225])
  by fmviesa001.fm.intel.com with ESMTP; 21 Dec 2023 05:27:37 -0800
From: Andrii Staikov <andrii.staikov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Andrii Staikov <andrii.staikov@intel.com>,
	Karen Ostrowska <karen.ostrowska@intel.com>,
	Mateusz Palczewski <mateusz.palczewski@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Przemyslaw Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net  v5] i40e: Restore VF MSI-X state during PCI reset
Date: Thu, 21 Dec 2023 14:27:35 +0100
Message-Id: <20231221132735.1246164-1-andrii.staikov@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During a PCI FLR the MSI-X Enable flag in the VF PCI MSI-X capability
register will be cleared. This can lead to issues when a VF is
assigned to a VM because in these cases the VF driver receives no
indication of the PF PCI error/reset and additionally it is incapable
of restoring the cleared flag in the hypervisor configuration space
without fully reinitializing the driver interrupt functionality.

Since the VF driver is unable to easily resolve this condition on its own,
restore the VF MSI-X flag during the PF PCI reset handling.

Fixes: 19b7960b2da1 ("i40e: implement split PCI error reset handler")
Co-developed-by: Karen Ostrowska <karen.ostrowska@intel.com>
Signed-off-by: Karen Ostrowska <karen.ostrowska@intel.com>
Co-developed-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Przemyslaw Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Andrii Staikov <andrii.staikov@intel.com>
---
v1 -> v2: Fix signed-off tags
https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20231204131041.3369693-1-andrii.staikov@intel.com/

v2 -> v3: use @vf_dev in pci_get_device() instead of NULL and remove unnecessary call
https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20231206125127.218350-1-andrii.staikov@intel.com/

v3 -> v4: wrap the added functionality into the CONFIG_PCI_IOV define as
this is VF-related functionality
https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20231212122452.3250691-1-andrii.staikov@intel.com/

v4 -> v5: fix RB tags
---
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  3 +++
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 26 +++++++++++++++++++
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  3 +++
 3 files changed, 32 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 7bb1f64833eb..bbe2d115fb15 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16513,6 +16513,9 @@ static void i40e_pci_error_reset_done(struct pci_dev *pdev)
 		return;
 
 	i40e_reset_and_rebuild(pf, false, false);
+#ifdef CONFIG_PCI_IOV
+	i40e_restore_all_vfs_msi_state(pdev);
+#endif /* CONFIG_PCI_IOV */
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 3f99eb198245..d60f5419d6bd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -154,6 +154,32 @@ void i40e_vc_notify_reset(struct i40e_pf *pf)
 			     (u8 *)&pfe, sizeof(struct virtchnl_pf_event));
 }
 
+#ifdef CONFIG_PCI_IOV
+void i40e_restore_all_vfs_msi_state(struct pci_dev *pdev)
+{
+	u16 vf_id;
+	u16 pos;
+
+	/* Continue only if this is a PF */
+	if (!pdev->is_physfn)
+		return;
+
+	if (!pci_num_vf(pdev))
+		return;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
+	if (pos) {
+		struct pci_dev *vf_dev = NULL;
+
+		pci_read_config_word(pdev, pos + PCI_SRIOV_VF_DID, &vf_id);
+		while ((vf_dev = pci_get_device(pdev->vendor, vf_id, vf_dev))) {
+			if (vf_dev->is_virtfn && vf_dev->physfn == pdev)
+				pci_restore_msi_state(vf_dev);
+		}
+	}
+}
+#endif /* CONFIG_PCI_IOV */
+
 /**
  * i40e_vc_notify_vf_reset
  * @vf: pointer to the VF structure
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 2ee0f8a23248..5fd607c0de0a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -137,6 +137,9 @@ int i40e_ndo_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool enable);
 
 void i40e_vc_notify_link_state(struct i40e_pf *pf);
 void i40e_vc_notify_reset(struct i40e_pf *pf);
+#ifdef CONFIG_PCI_IOV
+void i40e_restore_all_vfs_msi_state(struct pci_dev *pdev);
+#endif /* CONFIG_PCI_IOV */
 int i40e_get_vf_stats(struct net_device *netdev, int vf_id,
 		      struct ifla_vf_stats *vf_stats);
 
-- 
2.25.1


