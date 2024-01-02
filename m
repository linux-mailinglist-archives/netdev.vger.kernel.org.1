Return-Path: <netdev+bounces-61033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CC2822484
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 23:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD29286B91
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 22:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB8F1775B;
	Tue,  2 Jan 2024 22:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jbzqzwef"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D62B17728
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 22:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704233080; x=1735769080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sK4OZj3OFnpsB7oD6iLfDMrtBZcUiMGVK9TjfpN+kC8=;
  b=Jbzqzwef1kZJEYHWJyJzV9J20Et0J+i2VrxSyuTygNullW8158bcpxfl
   3qO5TE6RfRXLgwOurCmlpDTOVbaGBxE7AkpzsnWYUinS7xOy4BPlFQH69
   Wy6NoQuRyFSDtUiGAQW7gtlEYpPfp/o26ue2+M3QldI9VQD3CcxHgvpvK
   ejTnYINdsrws50YcDZLoZZt4zSvvmBNT8yKgvkhZgbShsgqg7dCWqdnBt
   Qb5ohEh20LTtSAaVXo3OMREQsfpY3iBbBaOCA/Z9OT8A2KjjcQKlaXljL
   3mvRfazH+1a7mdHIh1MEB1WbZh91m/03Mz4kHycWHbqISdzSmWBYeVbBL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="15567892"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="15567892"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 14:04:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="808621409"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="808621409"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga008.jf.intel.com with ESMTP; 02 Jan 2024 14:04:36 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Petr Oros <poros@redhat.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 4/7] ice: replace ice_vf_recreate_vsi() with ice_vf_reconfig_vsi()
Date: Tue,  2 Jan 2024 14:04:20 -0800
Message-ID: <20240102220428.698969-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240102220428.698969-1-anthony.l.nguyen@intel.com>
References: <20240102220428.698969-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_vf_create_vsi() function and its VF ops helper introduced by commit
a4c785e8162e ("ice: convert vf_ops .vsi_rebuild to .create_vsi") are used
during an individual VF reset to re-create the VSI. This was done in order
to ensure that the VSI gets properly reconfigured within the hardware.

This is somewhat heavy handed as we completely release the VSI memory and
structure, and then create a new VSI. This can also potentially force a
change of the VSI index as we will re-use the first open slot in the VSI
array which may not be the same.

As part of implementing devlink reload, commit 6624e780a577 ("ice: split
ice_vsi_setup into smaller functions") split VSI setup into smaller
functions, introducing both ice_vsi_cfg() and ice_vsi_decfg() which can be
used to configure or deconfigure an existing software VSI structure.

Rather than completely removing the VSI and adding a new one using the
.create_vsi() VF operation, simply use ice_vsi_decfg() to remove the
current configuration. Save the VSI type and then call ice_vsi_cfg() to
reconfigure the VSI as the same type that it was before.

The existing reset logic assumes that all hardware filters will be removed,
so also call ice_fltr_remove_all() before re-configuring the VSI.

This new operation does not re-create the VSI, so rename it to
ice_vf_reconfig_vsi().

The new approach can safely share the exact same flow for both SR-IOV VFs
as well as the Scalable IOV VFs being worked on. This uses less code and is
a better abstraction over fully deleting the VSI and adding a new one.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Petr Oros <poros@redhat.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c    | 24 ++-----------
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 35 +++++++++++++------
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  1 -
 .../ethernet/intel/ice/ice_vf_lib_private.h   |  1 +
 4 files changed, 28 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index 4ee349fe6409..a94a1c48c3de 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -761,24 +761,6 @@ static void ice_sriov_clear_reset_trigger(struct ice_vf *vf)
 	ice_flush(hw);
 }
 
-/**
- * ice_sriov_create_vsi - Create a new VSI for a VF
- * @vf: VF to create the VSI for
- *
- * This is called by ice_vf_recreate_vsi to create the new VSI after the old
- * VSI has been released.
- */
-static int ice_sriov_create_vsi(struct ice_vf *vf)
-{
-	struct ice_vsi *vsi;
-
-	vsi = ice_vf_vsi_setup(vf);
-	if (!vsi)
-		return -ENOMEM;
-
-	return 0;
-}
-
 /**
  * ice_sriov_post_vsi_rebuild - tasks to do after the VF's VSI have been rebuilt
  * @vf: VF to perform tasks on
@@ -798,7 +780,6 @@ static const struct ice_vf_ops ice_sriov_vf_ops = {
 	.poll_reset_status = ice_sriov_poll_reset_status,
 	.clear_reset_trigger = ice_sriov_clear_reset_trigger,
 	.irq_close = NULL,
-	.create_vsi = ice_sriov_create_vsi,
 	.post_vsi_rebuild = ice_sriov_post_vsi_rebuild,
 };
 
@@ -1141,8 +1122,7 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 	if (vf->first_vector_idx < 0)
 		goto unroll;
 
-	ice_vf_vsi_release(vf);
-	if (vf->vf_ops->create_vsi(vf)) {
+	if (ice_vf_reconfig_vsi(vf)) {
 		/* Try to rebuild with previous values */
 		needs_rebuild = true;
 		goto unroll;
@@ -1169,7 +1149,7 @@ int ice_sriov_set_msix_vec_count(struct pci_dev *vf_dev, int msix_vec_count)
 		return -EINVAL;
 
 	if (needs_rebuild)
-		vf->vf_ops->create_vsi(vf);
+		ice_vf_reconfig_vsi(vf);
 
 	ice_ena_vf_mappings(vf);
 	ice_put_vf(vf);
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index d6f74513b495..2ffdae9a82df 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -248,29 +248,44 @@ static void ice_vf_pre_vsi_rebuild(struct ice_vf *vf)
 }
 
 /**
- * ice_vf_recreate_vsi - Release and re-create the VF's VSI
- * @vf: VF to recreate the VSI for
+ * ice_vf_reconfig_vsi - Reconfigure a VF VSI with the device
+ * @vf: VF to reconfigure the VSI for
  *
- * This is only called when a single VF is being reset (i.e. VVF, VFLR, host
- * VF configuration change, etc)
+ * This is called when a single VF is being reset (i.e. VVF, VFLR, host VF
+ * configuration change, etc).
  *
- * It releases and then re-creates a new VSI.
+ * It brings the VSI down and then reconfigures it with the hardware.
  */
-static int ice_vf_recreate_vsi(struct ice_vf *vf)
+int ice_vf_reconfig_vsi(struct ice_vf *vf)
 {
+	struct ice_vsi *vsi = ice_get_vf_vsi(vf);
+	struct ice_vsi_cfg_params params = {};
 	struct ice_pf *pf = vf->pf;
 	int err;
 
-	ice_vf_vsi_release(vf);
+	if (WARN_ON(!vsi))
+		return -EINVAL;
+
+	params = ice_vsi_to_params(vsi);
+	params.flags = ICE_VSI_FLAG_NO_INIT;
 
-	err = vf->vf_ops->create_vsi(vf);
+	ice_vsi_decfg(vsi);
+	ice_fltr_remove_all(vsi);
+
+	err = ice_vsi_cfg(vsi, &params);
 	if (err) {
 		dev_err(ice_pf_to_dev(pf),
-			"Failed to recreate the VF%u's VSI, error %d\n",
+			"Failed to reconfigure the VF%u's VSI, error %d\n",
 			vf->vf_id, err);
 		return err;
 	}
 
+	/* Update the lan_vsi_num field since it might have been changed. The
+	 * PF lan_vsi_idx number remains the same so we don't need to change
+	 * that.
+	 */
+	vf->lan_vsi_num = vsi->vsi_num;
+
 	return 0;
 }
 
@@ -928,7 +943,7 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
 
 	ice_vf_pre_vsi_rebuild(vf);
 
-	if (ice_vf_recreate_vsi(vf)) {
+	if (ice_vf_reconfig_vsi(vf)) {
 		dev_err(dev, "Failed to release and setup the VF%u's VSI\n",
 			vf->vf_id);
 		err = -EFAULT;
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.h b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
index 35866553f288..0cc9034065c5 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.h
@@ -62,7 +62,6 @@ struct ice_vf_ops {
 	bool (*poll_reset_status)(struct ice_vf *vf);
 	void (*clear_reset_trigger)(struct ice_vf *vf);
 	void (*irq_close)(struct ice_vf *vf);
-	int (*create_vsi)(struct ice_vf *vf);
 	void (*post_vsi_rebuild)(struct ice_vf *vf);
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h b/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h
index 0c7e77c0a09f..91ba7fe0eaee 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h
@@ -23,6 +23,7 @@
 #warning "Only include ice_vf_lib_private.h in CONFIG_PCI_IOV virtualization files"
 #endif
 
+int ice_vf_reconfig_vsi(struct ice_vf *vf);
 void ice_initialize_vf_entry(struct ice_vf *vf);
 void ice_dis_vf_qs(struct ice_vf *vf);
 int ice_check_vf_init(struct ice_vf *vf);
-- 
2.41.0


