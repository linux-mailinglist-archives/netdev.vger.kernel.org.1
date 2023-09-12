Return-Path: <netdev+bounces-33208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9389479D082
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 13:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F02281C22
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1322F18032;
	Tue, 12 Sep 2023 11:59:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EA69443
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 11:59:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532AC1981
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 04:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694519949; x=1726055949;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bjAkhDvOyHj2BVvYeMiuQ2BaHhDZaB2jI5iM2AguytE=;
  b=FLLJrfxz5pjj3kmkTPs7L+1Pb4yM9wxBJi7eo5ulnuIqEgrUF9SlT/rC
   LZN42yYxN4dFmzr4ND1+Gei18YpiV/7PtKNCOcUxNeQJTmLpBGFe6CiPK
   H3LXxPZkbY2yoBZbQ24sM7YNn+SWHPhPdqbOFKn/WPsSRhGgXSzMNbk91
   8v62vNLS8kH7gR18+e+awS4rgWnJaDrHsztqIlGRWjfM9gqEVI+WXstno
   ggqXWYW7ILMIZSRMm/X/ocs7aDk2noAUMCyjpzurXk3PGR7o2heEyrJia
   syyAji+VjbbINA+61Lec5UuLvMHNxDVwAPsSoWtQq82AzSw8YZPL6d2ct
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378263748"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="378263748"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 04:59:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="867343275"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="867343275"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga004.jf.intel.com with ESMTP; 12 Sep 2023 04:59:04 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 0A69D332B7;
	Tue, 12 Sep 2023 12:59:03 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	leon@kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [PATCH] [Intel-wired-lan][PATCH iwl-next v2] ice: store VF's pci_dev ptr in ice_vf
Date: Tue, 12 Sep 2023 07:56:26 -0400
Message-Id: <20230912115626.105828-1-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Extend struct ice_vf by vfdev.
Calculation of vfdev falls more nicely into ice_create_vf_entries().

Caching of vfdev enables simplification of ice_restore_all_vfs_msi_state().

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c   |  2 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c  | 50 +++++++++++----------
 drivers/net/ethernet/intel/ice/ice_sriov.h  |  4 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c |  2 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h |  2 +-
 5 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index a5997008bb98..38adffbe0edf 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5561,7 +5561,7 @@ static void ice_pci_err_resume(struct pci_dev *pdev)
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
-
-	if (!pci_num_vf(pdev))
-		return;
+	struct ice_vf *vf;
+	u32 bkt;
 
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
2.38.1

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.


