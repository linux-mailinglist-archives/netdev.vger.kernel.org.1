Return-Path: <netdev+bounces-126101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE83E96FE00
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 00:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9743C285417
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 22:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD61915C151;
	Fri,  6 Sep 2024 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MmWY3k6j"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2822B15B572
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 22:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725661820; cv=none; b=Mr/yFbMxOpoNXi6rFr/5oWH9g+3sRKq/EteZMYHhyGKcEwA+o3Lvjdqh+2sD0SyuMw8tv+d0e74FdnF66NrTDIDQuYVAcB/p9PTgaLsTFldYd4p9yDRlvSJuS3hPI+0GZsrStRBtUsmake6ZXcifRsktG7glv1Cu+JACWyV7em0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725661820; c=relaxed/simple;
	bh=Qvv35Y9NQgr6BPHTmsfkJNLbXKhulC4W/wuJP96y8r4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8Z63pmZxOLaYL+aZuMaPW9ecfEoJKbHGWY3HUeFd9N81Br1/zbSH23pCcqcieKtWuspi/4KAkhB9EDMRj3OMLqE6oQdQxhcxnidWEpl4fsXpMk94x807/v3h7/tXhsV5Z4CkN5lEAK9+ffcE1G3S/Qz8qrx7r+lFeACUANw7hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MmWY3k6j; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725661819; x=1757197819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qvv35Y9NQgr6BPHTmsfkJNLbXKhulC4W/wuJP96y8r4=;
  b=MmWY3k6jle3otyi2KAw8mB/WwpJKqB1nwauqNn+B/vogBCCvG+q6tshF
   IYtAKtX7b8K8LJZ6r97TTtr/9vIuaOCRnoT6sCNoAHjSgoI2ap9/tf3rL
   Eo2Hojxv9Vn/+zQjaLXaF2pt4qvEXrQYkcRpYKtn/W58YIgkVXgTGNCtd
   +s7geepvxSAGhqrikuRbu/Ts/g7gJQTOAGSdWwmkPbrxdb4kxbDEhyytx
   yEiWAAewJjZ1QhrjUJ0R693No46IGv0i0+SgQ/ggrAwWnRJWsEXtRHu0c
   e9kCHW2lQQat8k3Ce2f0AnuzeZgGJ5YLgZRX+jqOZOYlSbJUb0ixbE1qo
   A==;
X-CSE-ConnectionGUID: HsmfE87YQyqV0ozcWQXquQ==
X-CSE-MsgGUID: 5fJvFMQGTt2sowzVfW1tPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="35030740"
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="35030740"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 15:30:18 -0700
X-CSE-ConnectionGUID: ZrZ8RTKYT5qX5o1Mp1UA+w==
X-CSE-MsgGUID: JEsb+bvjSfShmb3gjPZABg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="70490452"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 06 Sep 2024 15:30:17 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jiri@nvidia.com,
	shayd@nvidia.com,
	wojciech.drewek@intel.com,
	horms@kernel.org,
	sridhar.samudrala@intel.com,
	mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com,
	michal.kubiak@intel.com,
	pio.raczynski@gmail.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	maciej.fijalkowski@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next v5 09/15] ice: create port representor for SF
Date: Fri,  6 Sep 2024 15:30:00 -0700
Message-ID: <20240906223010.2194591-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240906223010.2194591-1-anthony.l.nguyen@intel.com>
References: <20240906223010.2194591-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Implement attaching and detaching SF port representor. It is done in the
same way as the VF port representor.

SF port representor is always added or removed with devlink
lock taken.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../ethernet/intel/ice/devlink/devlink_port.c |  6 +--
 drivers/net/ethernet/intel/ice/ice_eswitch.c  | 39 ++++++++++++++
 drivers/net/ethernet/intel/ice/ice_eswitch.h  | 11 ++++
 drivers/net/ethernet/intel/ice/ice_repr.c     | 52 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_repr.h     |  7 ++-
 drivers/net/ethernet/intel/ice/ice_sf_eth.c   |  2 +
 6 files changed, 113 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
index 9abd31e44df5..dc62046e26b7 100644
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
index 00d49477bdcb..c0b3e70a7ea3 100644
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
  * ice_eswitch_get_target - get netdev based on src_vsi from descriptor
  * @rx_ring: ring used to receive the packet
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.h b/drivers/net/ethernet/intel/ice/ice_eswitch.h
index d1699954a7ad..20ce32dda69c 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.h
@@ -9,7 +9,9 @@
 
 #ifdef CONFIG_ICE_SWITCHDEV
 void ice_eswitch_detach_vf(struct ice_pf *pf, struct ice_vf *vf);
+void ice_eswitch_detach_sf(struct ice_pf *pf, struct ice_dynamic_port *sf);
 int ice_eswitch_attach_vf(struct ice_pf *pf, struct ice_vf *vf);
+int ice_eswitch_attach_sf(struct ice_pf *pf, struct ice_dynamic_port *sf);
 
 int ice_eswitch_mode_get(struct devlink *devlink, u16 *mode);
 int
@@ -34,12 +36,21 @@ void ice_eswitch_decfg_vsi(struct ice_vsi *vsi, const u8 *mac);
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
index c6e77b9c6a32..ee28632e87b4 100644
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
 
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index 05d9e7384c5e..e90546aea729 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -126,6 +126,8 @@ static int ice_sf_dev_probe(struct auxiliary_device *adev,
 	}
 	vsi->sf = dyn_port;
 
+	ice_eswitch_update_repr(&dyn_port->repr_id, vsi);
+
 	err = ice_devlink_create_sf_dev_port(sf_dev);
 	if (err) {
 		dev_err(dev, "Cannot add ice virtual devlink port for subfunction");
-- 
2.42.0


