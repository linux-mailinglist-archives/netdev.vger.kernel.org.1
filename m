Return-Path: <netdev+bounces-100149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9908D7F58
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 11:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B791F20CEF
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 09:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A50A82C63;
	Mon,  3 Jun 2024 09:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QT2ACEaJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFED481D0
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 09:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407966; cv=none; b=driukHN3k683bhtynM83yG3e+QeE524auJHCtH6HhVduF5HaOIY3X5z+MZhgtx6ukQ/RwhJW+JMaOblV5gS6WzgxeV08zOP3vITKT9X1GhcwxolnyzObrqQbZB1/ReEeEKtRx3d2B7C8WqRx74avElyevAXVMVtSuyEEwwX8SLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407966; c=relaxed/simple;
	bh=R1f8BLRLk6TCqEIrbNUeJ7wbK7KYlbw4xiTMWaM0VJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCm2MRxOe4zHvsXDKy/0+DdrZrOx0J9epfkU1W0kY/yOP0bGRaYkxAAoOjN+vwWVlQUWuQTTa3hqL1eIBzXI1NdnywaIYMcODPwnAWZ84fNohWLjLpkLJA0MpBEgCDQkYY0UspqZ6rS9r8aty2diT/N6v5vI3hGqRHdeacV1Ckg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QT2ACEaJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717407966; x=1748943966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R1f8BLRLk6TCqEIrbNUeJ7wbK7KYlbw4xiTMWaM0VJU=;
  b=QT2ACEaJnqeGHWMAyq5tY71oImzB+iwCQEPYMLnskMkVHPTVOVHXL9Zf
   jjQNkVJ3cboksCXxwdDoNujNAl6WjUD6LQXBYIPvNOUipmKf4O2wt66Y1
   JjlcT7uWvNyk94u+hr6be68Iu0djdWHX/mmsConp7Y6svfCcPq3PLp7tt
   Nozy4PmTjxO6xNMoY/+gT7r6FJx7w04SS/ariXkpd8OeeXEiz7KTN+rKy
   0JpNRfVw/LvYsI62ct8wkdtzB4AptEVWvjzNcQ30jg0+MPErYbk8YEeCr
   KGqOAyUZyAW5Z/uWv9jIunJkfErY9S8zLcwADsrhJhnFXFMh5hiFiGjHI
   w==;
X-CSE-ConnectionGUID: g5+SgjMASceo6XSSFmFoWg==
X-CSE-MsgGUID: scXuJnKuROm0oJxGqvO6IQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="17732711"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="17732711"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 02:46:05 -0700
X-CSE-ConnectionGUID: VCRCjdCSSCuCSoqTY8CdHA==
X-CSE-MsgGUID: 8/weFJEeSpqsPrPykQwEzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="37448240"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa007.jf.intel.com with ESMTP; 03 Jun 2024 02:45:57 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com,
	sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com,
	wojciech.drewek@intel.com,
	pio.raczynski@gmail.com,
	jiri@nvidia.com,
	mateusz.polchlopek@intel.com,
	shayd@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com,
	horms@kernel.org
Subject: [iwl-next v4 09/15] ice: create port representor for SF
Date: Mon,  3 Jun 2024 11:50:19 +0200
Message-ID: <20240603095025.1395347-10-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240603095025.1395347-1-michal.swiatkowski@linux.intel.com>
References: <20240603095025.1395347-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement attaching and detaching SF port representor. It is done in the
same way as the VF port representor.

SF port representor is always added or removed with devlink
lock taken.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 .../ethernet/intel/ice/devlink/devlink_port.c |  6 +--
 drivers/net/ethernet/intel/ice/ice_eswitch.c  | 39 ++++++++++++++
 drivers/net/ethernet/intel/ice/ice_eswitch.h  | 11 ++++
 drivers/net/ethernet/intel/ice/ice_repr.c     | 52 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_repr.h     |  7 ++-
 5 files changed, 111 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
index f06baabd0112..fb3ff68e0666 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
@@ -543,7 +543,7 @@ static void ice_dealloc_dynamic_port(struct ice_dynamic_port *dyn_port)
 	struct ice_pf *pf = dyn_port->pf;
 
 	xa_erase(&pf->sf_nums, devlink_port->attrs.pci_sf.sf);
-	devl_port_unregister(devlink_port);
+	ice_eswitch_detach_sf(pf, dyn_port);
 	ice_vsi_free(dyn_port->vsi);
 	xa_erase(&pf->dyn_ports, dyn_port->vsi->idx);
 	kfree(dyn_port);
@@ -765,9 +765,9 @@ ice_alloc_dynamic_port(struct ice_pf *pf,
 		goto unroll_vsi_alloc;
 	}
 
-	err = ice_devlink_create_sf_port(dyn_port);
+	err = ice_eswitch_attach_sf(pf, dyn_port);
 	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "Port registration failed");
+		NL_SET_ERR_MSG_MOD(extack, "Failed to attach SF to eswitch");
 		goto unroll_xa_insert;
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index a4e7ed9fbaf5..d8c06147d4d4 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -525,6 +525,30 @@ int ice_eswitch_attach_vf(struct ice_pf *pf, struct ice_vf *vf)
 	return err;
 }
 
+/**
+ * ice_eswitch_attach_sf - attach SF to a eswitch
+ * @pf: pointer to PF structure
+ * @sf: pointer to SF structure to be attached
+ *
+ * During attaching port representor for SF is created.
+ *
+ * Return: zero on success or an error code on failure.
+ */
+int ice_eswitch_attach_sf(struct ice_pf *pf, struct ice_dynamic_port *sf)
+{
+	struct ice_repr *repr = ice_repr_create_sf(sf);
+	int err;
+
+	if (IS_ERR(repr))
+		return PTR_ERR(repr);
+
+	err = ice_eswitch_attach(pf, repr, &sf->repr_id);
+	if (err)
+		ice_repr_destroy(repr);
+
+	return err;
+}
+
 static void ice_eswitch_detach(struct ice_pf *pf, struct ice_repr *repr)
 {
 	ice_eswitch_stop_reprs(pf);
@@ -568,6 +592,21 @@ void ice_eswitch_detach_vf(struct ice_pf *pf, struct ice_vf *vf)
 	devl_unlock(devlink);
 }
 
+/**
+ * ice_eswitch_detach_sf - detach SF from a eswitch
+ * @pf: pointer to PF structure
+ * @sf: pointer to SF structure to be detached
+ */
+void ice_eswitch_detach_sf(struct ice_pf *pf, struct ice_dynamic_port *sf)
+{
+	struct ice_repr *repr = xa_load(&pf->eswitch.reprs, sf->repr_id);
+
+	if (!repr)
+		return;
+
+	ice_eswitch_detach(pf, repr);
+}
+
 /**
  * ice_eswitch_rebuild - rebuild eswitch
  * @pf: pointer to PF structure
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.h b/drivers/net/ethernet/intel/ice/ice_eswitch.h
index 265b2af055b0..20f301093b36 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.h
@@ -9,7 +9,9 @@
 
 #ifdef CONFIG_ICE_SWITCHDEV
 void ice_eswitch_detach_vf(struct ice_pf *pf, struct ice_vf *vf);
+void ice_eswitch_detach_sf(struct ice_pf *pf, struct ice_dynamic_port *sf);
 int ice_eswitch_attach_vf(struct ice_pf *pf, struct ice_vf *vf);
+int ice_eswitch_attach_sf(struct ice_pf *pf, struct ice_dynamic_port *sf);
 void ice_eswitch_rebuild(struct ice_pf *pf);
 
 int ice_eswitch_mode_get(struct devlink *devlink, u16 *mode);
@@ -35,12 +37,21 @@ void ice_eswitch_decfg_vsi(struct ice_vsi *vsi, const u8 *mac);
 static inline void
 ice_eswitch_detach_vf(struct ice_pf *pf, struct ice_vf *vf) { }
 
+static inline void
+ice_eswitch_detach_sf(struct ice_pf *pf, struct ice_dynamic_port *sf) { }
+
 static inline int
 ice_eswitch_attach_vf(struct ice_pf *pf, struct ice_vf *vf)
 {
 	return -EOPNOTSUPP;
 }
 
+static inline int
+ice_eswitch_attach_sf(struct ice_pf *pf, struct ice_dynamic_port *sf)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline void ice_eswitch_stop_all_tx_queues(struct ice_pf *pf) { }
 
 static inline void
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 5d71f623b1e0..5ea8b512c421 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -302,6 +302,12 @@ static void ice_repr_rem_vf(struct ice_repr *repr)
 	ice_virtchnl_set_dflt_ops(repr->vf);
 }
 
+static void ice_repr_rem_sf(struct ice_repr *repr)
+{
+	unregister_netdev(repr->netdev);
+	ice_devlink_destroy_sf_port(repr->sf);
+}
+
 static void ice_repr_set_tx_topology(struct ice_pf *pf)
 {
 	struct devlink *devlink;
@@ -420,6 +426,52 @@ struct ice_repr *ice_repr_create_vf(struct ice_vf *vf)
 	return repr;
 }
 
+static int ice_repr_add_sf(struct ice_repr *repr)
+{
+	struct ice_dynamic_port *sf = repr->sf;
+	int err;
+
+	err = ice_devlink_create_sf_port(sf);
+	if (err)
+		return err;
+
+	SET_NETDEV_DEVLINK_PORT(repr->netdev, &sf->devlink_port);
+	err = ice_repr_reg_netdev(repr->netdev);
+	if (err)
+		goto err_netdev;
+
+	return 0;
+
+err_netdev:
+	ice_devlink_destroy_sf_port(sf);
+	return err;
+}
+
+/**
+ * ice_repr_create_sf - add representor for SF VSI
+ * @sf: SF to create port representor on
+ *
+ * Set correct representor type for SF and functions pointer.
+ *
+ * Return: created port representor on success, error otherwise
+ */
+struct ice_repr *ice_repr_create_sf(struct ice_dynamic_port *sf)
+{
+	struct ice_repr *repr = ice_repr_create(sf->vsi);
+
+	if (!repr)
+		return ERR_PTR(-ENOMEM);
+
+	repr->type = ICE_REPR_TYPE_SF;
+	repr->sf = sf;
+	repr->ops.add = ice_repr_add_sf;
+	repr->ops.rem = ice_repr_rem_sf;
+
+	ether_addr_copy(repr->parent_mac, sf->hw_addr);
+
+	return repr;
+}
+
 struct ice_repr *ice_repr_get(struct ice_pf *pf, u32 id)
 {
 	return xa_load(&pf->eswitch.reprs, id);
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.h b/drivers/net/ethernet/intel/ice/ice_repr.h
index d3454b6f5d41..dcba07899877 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.h
+++ b/drivers/net/ethernet/intel/ice/ice_repr.h
@@ -17,6 +17,7 @@ struct ice_repr_pcpu_stats {
 
 enum ice_repr_type {
 	ICE_REPR_TYPE_VF,
+	ICE_REPR_TYPE_SF,
 };
 
 struct ice_repr {
@@ -28,7 +29,10 @@ struct ice_repr {
 	u32 id;
 	u8 parent_mac[ETH_ALEN];
 	enum ice_repr_type type;
-	struct ice_vf *vf;
+	union {
+		struct ice_vf *vf;
+		struct ice_dynamic_port *sf;
+	};
 	struct {
 		int (*add)(struct ice_repr *repr);
 		void (*rem)(struct ice_repr *repr);
@@ -36,6 +40,7 @@ struct ice_repr {
 };
 
 struct ice_repr *ice_repr_create_vf(struct ice_vf *vf);
+struct ice_repr *ice_repr_create_sf(struct ice_dynamic_port *sf);
 
 void ice_repr_destroy(struct ice_repr *repr);
 
-- 
2.42.0


