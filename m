Return-Path: <netdev+bounces-61318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C948235A0
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 20:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3741C23577
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 19:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C0C1CAB7;
	Wed,  3 Jan 2024 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5u1LC5S"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58321CAB2
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 19:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704310392; x=1735846392;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s9LPzh+8d0y+K6vyTl447kXDgsgqikolwPOYZVIOVXg=;
  b=Q5u1LC5SeZjOcag8j+3Qy9XtA1LbjcGxxesnhd6wqt26uefJjZGIwFzN
   B+EXBflxHqo2XFQN8Gg/bgxcW71U3El2CLLcsMUrsF1oMA2MdKmX/M4u7
   7yODuYl6z3tRihbAK8PHMbW3UsoUBAlqgj2Uu14GOtC8qy9QdP93Xg7by
   nVILhdSYypF+pXQDu411J1AxPLhh/4WK4XXLfF+Gr2/Qrn/KCYfZQ4JdW
   /E0RAPXLxOc/U5a3hvtoNC9fS3WAo4VghKf+rLgnELap+Mx7XImfW6HSK
   ZwfHI9XiRU77p6FEU8j8FwiU/NlyYnPdjycpaNBgGONI404EsmAzA6bAs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="395927483"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="395927483"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 11:33:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="780079852"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="780079852"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga002.jf.intel.com with ESMTP; 03 Jan 2024 11:33:01 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Andrii Staikov <andrii.staikov@intel.com>,
	anthony.l.nguyen@intel.com,
	Karen Ostrowska <karen.ostrowska@intel.com>,
	Mateusz Palczewski <mateusz.palczewski@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 2/4] i40e: Restore VF MSI-X state during PCI reset
Date: Wed,  3 Jan 2024 11:32:50 -0800
Message-ID: <20240103193254.822968-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240103193254.822968-1-anthony.l.nguyen@intel.com>
References: <20240103193254.822968-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrii Staikov <andrii.staikov@intel.com>

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
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Andrii Staikov <andrii.staikov@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  3 +++
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 26 +++++++++++++++++++
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  3 +++
 3 files changed, 32 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d5633a440cca..d5519af34657 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16518,6 +16518,9 @@ static void i40e_pci_error_reset_done(struct pci_dev *pdev)
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
2.41.0


