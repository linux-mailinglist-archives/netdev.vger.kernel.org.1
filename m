Return-Path: <netdev+bounces-54416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D6780703E
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 13:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8C61C208F7
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 12:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC6A36AF1;
	Wed,  6 Dec 2023 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ns/dzzs5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D28BFA
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 04:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701867137; x=1733403137;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/j8Pyzp3zBTEaKRK16Ro1dJDuEcGxdLkZKTCrp8+pD8=;
  b=ns/dzzs5rj0wa6GReapEGYfAZQDc434/NAXWwoND8XQW/qJDWaAJAEsf
   NVWUUqqCGXWLWt+hwV7yR+RmNIY5EaRycETeQSactDJgqTuR57eZunQ9j
   56XaTrf3+nn9M2peGTfXhY6qudUeT3HLlpHHJ+jBZ6LPVKpSAzzoKvhJc
   Vnk/cWQzhUy/FTuDFGD5BYRrUH+SMf4DYQu3+bTcfRT3b+V3Jin/TvLRT
   5bnLS58Y7QwyEo/dtMOnNuEcQmXuy15aQmoMK2Z8vLCyJrT4YTvJmNNzD
   c5SmtxvOejEflLmhBmun7lWKf11kCHo8ILUYJmetP/KBN1Hy2bxgRORLw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="396843749"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="396843749"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 04:51:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="894729380"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="894729380"
Received: from unknown (HELO amlin-019-225.igk.intel.com) ([10.102.19.225])
  by orsmga004.jf.intel.com with ESMTP; 06 Dec 2023 04:51:30 -0800
From: Andrii Staikov <andrii.staikov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Andrii Staikov <andrii.staikov@intel.com>,
	Karen Ostrowska <karen.ostrowska@intel.com>,
	Mateusz Palczewski <mateusz.palczewski@intel.com>,
	Drewek Wojciech <wojciech.drewek@intel.com>,
	Kitszel Przemyslaw <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net  v3] i40e: Restore VF MSI-X state during PCI reset
Date: Wed,  6 Dec 2023 13:51:27 +0100
Message-Id: <20231206125127.218350-1-andrii.staikov@intel.com>
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
Reviewed-by: Drewek Wojciech <wojciech.drewek@intel.com>
Reviewed-by: Kitszel Przemyslaw <przemyslaw.kitszel@intel.com>
Signed-off-by: Andrii Staikov <andrii.staikov@intel.com>
---
v1 -> v2: Fix signed-off tags
v2 -> v3: use @vf_dev in pci_get_device() instead of NULL and
remove unnecessary call
---
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  2 ++
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 24 +++++++++++++++++++
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  1 +
 3 files changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 7bb1f64833eb..7272d0227a55 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16513,6 +16513,8 @@ static void i40e_pci_error_reset_done(struct pci_dev *pdev)
 		return;
 
 	i40e_reset_and_rebuild(pf, false, false);
+
+	i40e_restore_all_vfs_msi_state(pdev);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 3f99eb198245..7c8ba2675ed5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -154,6 +154,30 @@ void i40e_vc_notify_reset(struct i40e_pf *pf)
 			     (u8 *)&pfe, sizeof(struct virtchnl_pf_event));
 }
 
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
+
 /**
  * i40e_vc_notify_vf_reset
  * @vf: pointer to the VF structure
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 2ee0f8a23248..1ff879784563 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -137,6 +137,7 @@ int i40e_ndo_set_vf_spoofchk(struct net_device *netdev, int vf_id, bool enable);
 
 void i40e_vc_notify_link_state(struct i40e_pf *pf);
 void i40e_vc_notify_reset(struct i40e_pf *pf);
+void i40e_restore_all_vfs_msi_state(struct pci_dev *pdev);
 int i40e_get_vf_stats(struct net_device *netdev, int vf_id,
 		      struct ifla_vf_stats *vf_stats);
 
-- 
2.25.1


