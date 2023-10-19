Return-Path: <netdev+bounces-42751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA727D0099
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 19:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4EC1C20FA3
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 17:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFD037155;
	Thu, 19 Oct 2023 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WkURxDa6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483D4341AC
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 17:32:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCB2126
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 10:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697736756; x=1729272756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sIadEwKa1pNDOFRukWp4a2jsmlR9TkC+Zor4xv7CoQw=;
  b=WkURxDa6h3iLaoW1H25Wt9NnsQNbZRGpoTEIPJwkTQZQswT94TRVhKou
   F/51OBLdRdTbGGMG8N69PoQi0K/QoeULWLN1+k+jamIh04CqvRaPhg6q1
   PkFSOwrAr78NsE0QfNwET5ns3v/lnIx9B7eCvyFeQwgnNrFPLnBVO8DxZ
   dxhch1SM0YHq8hlXXmbO/iGTk0WCgS9zEMiUSVzVBaaitlhopowfekEfs
   TL5JhCgJbOgfP3I6RDxFBmuMNKJnLXV9+Tn6qobEPukTg45sJfvXo3tdo
   t4xlmfHHKN0chh8xEuj1ZSzXXHBFSY26rUOqwTViipas4dLw9IQdDidlO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="389183686"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="389183686"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:32:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="760722678"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="760722678"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.241.1])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 10:32:34 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 03/11] ice: store VF's pci_dev ptr in ice_vf
Date: Thu, 19 Oct 2023 10:32:19 -0700
Message-ID: <20231019173227.3175575-4-jacob.e.keller@intel.com>
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

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Extend struct ice_vf by vfdev.
Calculation of vfdev falls more nicely into ice_create_vf_entries().

Caching of vfdev enables simplification of ice_restore_all_vfs_msi_state().

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c   |  2 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c  | 50 +++++++++++----------
 drivers/net/ethernet/intel/ice/ice_sriov.h  |  4 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c |  2 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h |  2 +-
 5 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 0dd7f23395b0..646b407d465c 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5523,7 +5523,7 @@ static void ice_pci_err_resume(struct pci_dev *pdev)
 		return;
 	}
 
-	ice_restore_all_vfs_msi_state(pdev);
+	ice_restore_all_vfs_msi_state(pf);
 
 	ice_do_reset(pf, ICE_RESET_PFR);
 	ice_service_task_restart(pf);
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 31314e7540f8..4ae59c59e22b 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -789,14 +789,19 @@ static const struct ice_vf_ops ice_sriov_vf_ops = {
  */
 static int ice_create_vf_entries(struct ice_pf *pf, u16 num_vfs)
 {
+	struct pci_dev *pdev = pf->pdev;
 	struct ice_vfs *vfs = &pf->vfs;
+	struct pci_dev *vfdev = NULL;
 	struct ice_vf *vf;
-	u16 vf_id;
-	int err;
+	u16 vf_pdev_id;
+	int err, pos;
 
 	lockdep_assert_held(&vfs->table_lock);
 
-	for (vf_id = 0; vf_id < num_vfs; vf_id++) {
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
+	pci_read_config_word(pdev, pos + PCI_SRIOV_VF_DID, &vf_pdev_id);
+
+	for (u16 vf_id = 0; vf_id < num_vfs; vf_id++) {
 		vf = kzalloc(sizeof(*vf), GFP_KERNEL);
 		if (!vf) {
 			err = -ENOMEM;
@@ -812,11 +817,23 @@ static int ice_create_vf_entries(struct ice_pf *pf, u16 num_vfs)
 
 		ice_initialize_vf_entry(vf);
 
+		do {
+			vfdev = pci_get_device(pdev->vendor, vf_pdev_id, vfdev);
+		} while (vfdev && vfdev->physfn != pdev);
+		vf->vfdev = vfdev;
 		vf->vf_sw_id = pf->first_sw;
 
+		pci_dev_get(vfdev);
+
 		hash_add_rcu(vfs->table, &vf->entry, vf_id);
 	}
 
+	/* Decrement of refcount done by pci_get_device() inside the loop does
+	 * not touch the last iteration's vfdev, so it has to be done manually
+	 * to balance pci_dev_get() added within the loop.
+	 */
+	pci_dev_put(vfdev);
+
 	return 0;
 
 err_free_entries:
@@ -1709,31 +1726,16 @@ void ice_print_vfs_mdd_events(struct ice_pf *pf)
 
 /**
  * ice_restore_all_vfs_msi_state - restore VF MSI state after PF FLR
- * @pdev: pointer to a pci_dev structure
+ * @pf: pointer to the PF structure
  *
  * Called when recovering from a PF FLR to restore interrupt capability to
  * the VFs.
  */
-void ice_restore_all_vfs_msi_state(struct pci_dev *pdev)
+void ice_restore_all_vfs_msi_state(struct ice_pf *pf)
 {
-	u16 vf_id;
-	int pos;
+	struct ice_vf *vf;
+	u32 bkt;
 
-	if (!pci_num_vf(pdev))
-		return;
-
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_SRIOV);
-	if (pos) {
-		struct pci_dev *vfdev;
-
-		pci_read_config_word(pdev, pos + PCI_SRIOV_VF_DID,
-				     &vf_id);
-		vfdev = pci_get_device(pdev->vendor, vf_id, NULL);
-		while (vfdev) {
-			if (vfdev->is_virtfn && vfdev->physfn == pdev)
-				pci_restore_msi_state(vfdev);
-			vfdev = pci_get_device(pdev->vendor, vf_id,
-					       vfdev);
-		}
-	}
+	ice_for_each_vf(pf, bkt, vf)
+		pci_restore_msi_state(vf->vfdev);
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.h b/drivers/net/ethernet/intel/ice/ice_sriov.h
index 346cb2666f3a..06829443d540 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.h
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.h
@@ -33,7 +33,7 @@ int
 ice_get_vf_cfg(struct net_device *netdev, int vf_id, struct ifla_vf_info *ivi);
 
 void ice_free_vfs(struct ice_pf *pf);
-void ice_restore_all_vfs_msi_state(struct pci_dev *pdev);
+void ice_restore_all_vfs_msi_state(struct ice_pf *pf);
 
 int
 ice_set_vf_port_vlan(struct net_device *netdev, int vf_id, u16 vlan_id, u8 qos,
@@ -67,7 +67,7 @@ static inline
 void ice_vf_lan_overflow_event(struct ice_pf *pf, struct ice_rq_event_info *event) { }
 static inline void ice_print_vfs_mdd_events(struct ice_pf *pf) { }
 static inline void ice_print_vf_rx_mdd_event(struct ice_vf *vf) { }
-static inline void ice_restore_all_vfs_msi_state(struct pci_dev *pdev) { }
+static inline void ice_restore_all_vfs_msi_state(struct ice_pf *pf) { }
 
 static inline int
 ice_sriov_configure(struct pci_dev __always_unused *pdev,
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index 24e4f4d897b6..aca1f2ea5034 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -56,6 +56,8 @@ static void ice_release_vf(struct kref *ref)
 {
 	struct ice_vf *vf = container_of(ref, struct ice_vf, refcnt);
 
+	pci_dev_put(vf->vfdev);
+
 	vf->vf_ops->free(vf);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index 31a082e8a827..628396aa4a04 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -82,7 +82,7 @@ struct ice_vf {
 	struct rcu_head rcu;
 	struct kref refcnt;
 	struct ice_pf *pf;
-
+	struct pci_dev *vfdev;
 	/* Used during virtchnl message handling and NDO ops against the VF
 	 * that will trigger a VFR
 	 */
-- 
2.41.0


