Return-Path: <netdev+bounces-118596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062309522F8
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 21:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 513A2B23A49
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 19:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0E81BF31A;
	Wed, 14 Aug 2024 19:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iOpoORC8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A046B1BF33D
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 19:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723665393; cv=none; b=jqzC41EkWc5d21oIqfv41z3uXHVPu9Egvd2/Fe9GTQVNRPHSRXzjHc1Fd9NMZ+YCzlaGYFriK3IvN+oYQVrfi0JYzzh06CBcdBgYxvT1rqP1mk8di6XwPwkWicVjQl9cSUlkFDVRxv5AXWS+zoyjoHlO3Bn7RmlqYgBgVC6CdtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723665393; c=relaxed/simple;
	bh=QcXMVNR7n0WqrIfB5oLtB2hirH7sLDvu1uveQW/UppQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0pAunoBr2wR2fFC7Le0FqrCx/Xt1RfLbERJ4GIYHXGWFQ/r/IIGIv3AQwk7AASa/oU/WxrT3TrqvvxWsI+85qZCuehW9Eij6/YryhK1icMH8cO9gB8v1p/zcB5kOJR7dDCFdtibTJ01onAQf6qh2CI9mrEY+/Nu6lCVKjUy/3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iOpoORC8; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723665391; x=1755201391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QcXMVNR7n0WqrIfB5oLtB2hirH7sLDvu1uveQW/UppQ=;
  b=iOpoORC8x/EIZ4EMeZsdlzLecl6E+k/3nb2mp17iL/96tzRVdn38v0CK
   yAiojQn7V5arkupAVcndD0rtiZaMyop7/nLtwNBkdcHPObNQAgGtJCPMb
   xzHNEuuSDhUxJJU0qVyeG9p+TZp3YJIUc1LPUwe3dKk/ke7eR+g8Q4UZK
   tjf+814rIHGs6O1lqMacID2tFCxW+lW34/99fIfG02zGKZQNei0JI1l89
   EZh/q5KxXHcSHudbJOeoDKB2PJjDNoufERISt3LKiXW6LnxuujN/4wstV
   KlmV0PayW7U9gMWPuu+3MsM7Argk4KK2YX3dy9Ezxjnuab/5sBAjdQOgb
   g==;
X-CSE-ConnectionGUID: P7AMYa8WTD6qq9cvsnjB5A==
X-CSE-MsgGUID: X+vuNXvCSaqrSh8Kpv+J9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="33292527"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="33292527"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 12:56:31 -0700
X-CSE-ConnectionGUID: Ip9+BcJdRXOHcVGT4jDPeA==
X-CSE-MsgGUID: WLRHaDaUR9uJ0GaRSswzdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="59869730"
Received: from unknown (HELO localhost.igk.intel.com) ([10.211.13.141])
  by orviesa008.jf.intel.com with ESMTP; 14 Aug 2024 12:56:30 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v5 4/5] ice: Use ice_adapter for PTP shared data instead of auxdev
Date: Wed, 14 Aug 2024 21:54:33 +0200
Message-ID: <20240814195434.72928-5-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814195434.72928-1-sergey.temerkhanov@intel.com>
References: <20240814195434.72928-1-sergey.temerkhanov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

Use struct ice_adapter to hold shared PTP data and control PTP
related actions instead of auxbus. This allows significant code
simplification and faster access to the container fields used in
the PTP support code.

Move the PTP port list to the ice_adapter container to simplify
the code and avoid race conditions which could occur due to the
synchronous nature of the initialization/access and
certain memory saving can be achieved by moving PTP data into
the ice_adapter itself.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_adapter.c |   6 +
 drivers/net/ethernet/intel/ice/ice_adapter.h |  17 +++
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 115 ++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_ptp.h     |   5 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h  |   5 +
 5 files changed, 105 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 903d0bc9e3e5..01a08cfd0090 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -50,11 +50,17 @@ static struct ice_adapter *ice_adapter_new(void)
 	spin_lock_init(&adapter->ptp_gltsyn_time_lock);
 	refcount_set(&adapter->refcount, 1);
 
+	mutex_init(&adapter->ports.lock);
+	INIT_LIST_HEAD(&adapter->ports.ports);
+
 	return adapter;
 }
 
 static void ice_adapter_free(struct ice_adapter *adapter)
 {
+	WARN_ON(!list_empty(&adapter->ports.ports));
+	mutex_destroy(&adapter->ports.lock);
+
 	kfree(adapter);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index eb7cac01c242..e233225848b3 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -4,18 +4,34 @@
 #ifndef _ICE_ADAPTER_H_
 #define _ICE_ADAPTER_H_
 
+#include <linux/types.h>
 #include <linux/spinlock_types.h>
 #include <linux/refcount_types.h>
 
 struct pci_dev;
 struct ice_pf;
 
+/**
+ * struct ice_port_list - data used to store the list of adapter ports
+ *
+ * This structure contains data used to maintain a list of adapter ports
+ *
+ * @ports: list of ports
+ * @lock: protect access to the ports list
+ */
+struct ice_port_list {
+	struct list_head ports;
+	/* To synchronize the ports list operations */
+	struct mutex lock;
+};
+
 /**
  * struct ice_adapter - PCI adapter resources shared across PFs
  * @ptp_gltsyn_time_lock: Spinlock protecting access to the GLTSYN_TIME
  *                        register of the PTP clock.
  * @refcount: Reference count. struct ice_pf objects hold the references.
  * @ctrl_pf: Control PF of the adapter
+ * @ports: Ports list
  */
 struct ice_adapter {
 	refcount_t refcount;
@@ -23,6 +39,7 @@ struct ice_adapter {
 	spinlock_t ptp_gltsyn_time_lock;
 
 	struct ice_pf *ctrl_pf;
+	struct ice_port_list ports;
 };
 
 struct ice_adapter *ice_adapter_get(const struct pci_dev *pdev);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index f6c50063d374..d078869c8bc9 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -62,7 +62,7 @@ static struct ice_pf *ice_get_ctrl_pf(struct ice_pf *pf)
 	return !pf->adapter ? NULL : pf->adapter->ctrl_pf;
 }
 
-static __maybe_unused struct ice_ptp *ice_get_ctrl_ptp(struct ice_pf *pf)
+static struct ice_ptp *ice_get_ctrl_ptp(struct ice_pf *pf)
 {
 	struct ice_pf *ctrl_pf = ice_get_ctrl_pf(pf);
 
@@ -734,8 +734,8 @@ static enum ice_tx_tstamp_work ice_ptp_tx_tstamp_owner(struct ice_pf *pf)
 	struct ice_ptp_port *port;
 	unsigned int i;
 
-	mutex_lock(&pf->ptp.ports_owner.lock);
-	list_for_each_entry(port, &pf->ptp.ports_owner.ports, list_member) {
+	mutex_lock(&pf->adapter->ports.lock);
+	list_for_each_entry(port, &pf->adapter->ports.ports, list_node) {
 		struct ice_ptp_tx *tx = &port->tx;
 
 		if (!tx || !tx->init)
@@ -743,7 +743,7 @@ static enum ice_tx_tstamp_work ice_ptp_tx_tstamp_owner(struct ice_pf *pf)
 
 		ice_ptp_process_tx_tstamp(tx);
 	}
-	mutex_unlock(&pf->ptp.ports_owner.lock);
+	mutex_unlock(&pf->adapter->ports.lock);
 
 	for (i = 0; i < ICE_GET_QUAD_NUM(pf->hw.ptp.num_lports); i++) {
 		u64 tstamp_ready;
@@ -908,7 +908,7 @@ ice_ptp_flush_all_tx_tracker(struct ice_pf *pf)
 {
 	struct ice_ptp_port *port;
 
-	list_for_each_entry(port, &pf->ptp.ports_owner.ports, list_member)
+	list_for_each_entry(port, &pf->adapter->ports.ports, list_node)
 		ice_ptp_flush_tx_tracker(ptp_port_to_pf(port), &port->tx);
 }
 
@@ -1508,10 +1508,10 @@ static void ice_ptp_restart_all_phy(struct ice_pf *pf)
 {
 	struct list_head *entry;
 
-	list_for_each(entry, &pf->ptp.ports_owner.ports) {
+	list_for_each(entry, &pf->adapter->ports.ports) {
 		struct ice_ptp_port *port = list_entry(entry,
 						       struct ice_ptp_port,
-						       list_member);
+						       list_node);
 
 		if (port->link_up)
 			ice_ptp_port_phy_restart(port);
@@ -2962,6 +2962,50 @@ void ice_ptp_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 	dev_err(ice_pf_to_dev(pf), "PTP reset failed %d\n", err);
 }
 
+static inline bool ice_is_primary(struct ice_hw *hw)
+{
+	return ice_is_e825c(hw) && ice_is_dual(hw) ?
+		!!(hw->dev_caps.nac_topo.mode & ICE_NAC_TOPO_PRIMARY_M) : true;
+}
+
+static int ice_ptp_setup_adapter(struct ice_pf *pf)
+{
+	if (!ice_pf_src_tmr_owned(pf) || !ice_is_primary(&pf->hw))
+		return -EPERM;
+
+	pf->adapter->ctrl_pf = pf;
+
+	return 0;
+}
+
+static int ice_ptp_setup_pf(struct ice_pf *pf)
+{
+	struct ice_ptp *ctrl_ptp = ice_get_ctrl_ptp(pf);
+	struct ice_ptp *ptp = &pf->ptp;
+
+	if (WARN_ON(!ctrl_ptp) || ice_get_phy_model(&pf->hw) == ICE_PHY_UNSUP)
+		return -ENODEV;
+
+	INIT_LIST_HEAD(&ptp->port.list_node);
+	mutex_lock(&pf->adapter->ports.lock);
+
+	list_add(&ptp->port.list_node,
+		 &pf->adapter->ports.ports);
+	mutex_unlock(&pf->adapter->ports.lock);
+
+	return 0;
+}
+
+static void ice_ptp_cleanup_pf(struct ice_pf *pf)
+{
+	struct ice_ptp *ptp = &pf->ptp;
+
+	if (ice_get_phy_model(&pf->hw) != ICE_PHY_UNSUP) {
+		mutex_lock(&pf->adapter->ports.lock);
+		list_del(&ptp->port.list_node);
+		mutex_unlock(&pf->adapter->ports.lock);
+	}
+}
 /**
  * ice_ptp_aux_dev_to_aux_pf - Get auxiliary PF handle for the auxiliary device
  * @aux_dev: auxiliary device to get the auxiliary PF for
@@ -3013,9 +3057,9 @@ static int ice_ptp_auxbus_probe(struct auxiliary_device *aux_dev,
 	if (WARN_ON(!owner_pf))
 		return -ENODEV;
 
-	INIT_LIST_HEAD(&aux_pf->ptp.port.list_member);
+	INIT_LIST_HEAD(&aux_pf->ptp.port.list_node);
 	mutex_lock(&owner_pf->ptp.ports_owner.lock);
-	list_add(&aux_pf->ptp.port.list_member,
+	list_add(&aux_pf->ptp.port.list_node,
 		 &owner_pf->ptp.ports_owner.ports);
 	mutex_unlock(&owner_pf->ptp.ports_owner.lock);
 
@@ -3032,7 +3076,7 @@ static void ice_ptp_auxbus_remove(struct auxiliary_device *aux_dev)
 	struct ice_pf *aux_pf = ice_ptp_aux_dev_to_aux_pf(aux_dev);
 
 	mutex_lock(&owner_pf->ptp.ports_owner.lock);
-	list_del(&aux_pf->ptp.port.list_member);
+	list_del(&aux_pf->ptp.port.list_node);
 	mutex_unlock(&owner_pf->ptp.ports_owner.lock);
 }
 
@@ -3092,7 +3136,7 @@ ice_ptp_auxbus_create_id_table(struct ice_pf *pf, const char *name)
  * ice_ptp_register_auxbus_driver - Register PTP auxiliary bus driver
  * @pf: Board private structure
  */
-static int ice_ptp_register_auxbus_driver(struct ice_pf *pf)
+static int __always_unused ice_ptp_register_auxbus_driver(struct ice_pf *pf)
 {
 	struct auxiliary_driver *aux_driver;
 	struct ice_ptp *ptp;
@@ -3135,7 +3179,7 @@ static int ice_ptp_register_auxbus_driver(struct ice_pf *pf)
  * ice_ptp_unregister_auxbus_driver - Unregister PTP auxiliary bus driver
  * @pf: Board private structure
  */
-static void ice_ptp_unregister_auxbus_driver(struct ice_pf *pf)
+static void __always_unused ice_ptp_unregister_auxbus_driver(struct ice_pf *pf)
 {
 	struct auxiliary_driver *aux_driver = &pf->ptp.ports_owner.aux_driver;
 
@@ -3154,15 +3198,12 @@ static void ice_ptp_unregister_auxbus_driver(struct ice_pf *pf)
  */
 int ice_ptp_clock_index(struct ice_pf *pf)
 {
-	struct auxiliary_device *aux_dev;
-	struct ice_pf *owner_pf;
+	struct ice_ptp *ctrl_ptp = ice_get_ctrl_ptp(pf);
 	struct ptp_clock *clock;
 
-	aux_dev = &pf->ptp.port.aux_dev;
-	owner_pf = ice_ptp_aux_dev_to_owner_pf(aux_dev);
-	if (!owner_pf)
+	if (!ctrl_ptp)
 		return -1;
-	clock = owner_pf->ptp.clock;
+	clock = ctrl_ptp->clock;
 
 	return clock ? ptp_clock_index(clock) : -1;
 }
@@ -3222,15 +3263,7 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
 	if (err)
 		goto err_clk;
 
-	err = ice_ptp_register_auxbus_driver(pf);
-	if (err) {
-		dev_err(ice_pf_to_dev(pf), "Failed to register PTP auxbus driver");
-		goto err_aux;
-	}
-
 	return 0;
-err_aux:
-	ptp_clock_unregister(pf->ptp.clock);
 err_clk:
 	pf->ptp.clock = NULL;
 err_exit:
@@ -3306,7 +3339,7 @@ static void ice_ptp_release_auxbus_device(struct device *dev)
  * ice_ptp_create_auxbus_device - Create PTP auxiliary bus device
  * @pf: Board private structure
  */
-static int ice_ptp_create_auxbus_device(struct ice_pf *pf)
+static __always_unused int ice_ptp_create_auxbus_device(struct ice_pf *pf)
 {
 	struct auxiliary_device *aux_dev;
 	struct ice_ptp *ptp;
@@ -3353,7 +3386,7 @@ static int ice_ptp_create_auxbus_device(struct ice_pf *pf)
  * ice_ptp_remove_auxbus_device - Remove PTP auxiliary bus device
  * @pf: Board private structure
  */
-static void ice_ptp_remove_auxbus_device(struct ice_pf *pf)
+static __always_unused void ice_ptp_remove_auxbus_device(struct ice_pf *pf)
 {
 	struct auxiliary_device *aux_dev = &pf->ptp.port.aux_dev;
 
@@ -3417,19 +3450,26 @@ void ice_ptp_init(struct ice_pf *pf)
 	/* If this function owns the clock hardware, it must allocate and
 	 * configure the PTP clock device to represent it.
 	 */
-	if (ice_pf_src_tmr_owned(pf)) {
+	if (ice_pf_src_tmr_owned(pf) && ice_is_primary(hw)) {
+		err = ice_ptp_setup_adapter(pf);
+		if (err)
+			goto err_exit;
 		err = ice_ptp_init_owner(pf);
 		if (err)
-			goto err;
+			goto err_exit;
 	}
 
+	err = ice_ptp_setup_pf(pf);
+	if (err)
+		goto err_exit;
+
 	ptp->port.port_num = hw->pf_id;
 	if (ice_is_e825c(hw) && hw->ptp.is_2x50g_muxed_topo)
 		ptp->port.port_num = hw->pf_id * 2;
 
 	err = ice_ptp_init_port(pf, &ptp->port);
 	if (err)
-		goto err;
+		goto err_exit;
 
 	/* Start the PHY timestamping block */
 	ice_ptp_reset_phy_timestamping(pf);
@@ -3437,20 +3477,16 @@ void ice_ptp_init(struct ice_pf *pf)
 	/* Configure initial Tx interrupt settings */
 	ice_ptp_cfg_tx_interrupt(pf);
 
-	err = ice_ptp_create_auxbus_device(pf);
-	if (err)
-		goto err;
-
 	ptp->state = ICE_PTP_READY;
 
 	err = ice_ptp_init_work(pf, ptp);
 	if (err)
-		goto err;
+		goto err_exit;
 
 	dev_info(ice_pf_to_dev(pf), "PTP init successful\n");
 	return;
 
-err:
+err_exit:
 	/* If we registered a PTP clock, release it */
 	if (pf->ptp.clock) {
 		ptp_clock_unregister(ptp->clock);
@@ -3477,7 +3513,7 @@ void ice_ptp_release(struct ice_pf *pf)
 	/* Disable timestamping for both Tx and Rx */
 	ice_ptp_disable_timestamp_mode(pf);
 
-	ice_ptp_remove_auxbus_device(pf);
+	ice_ptp_cleanup_pf(pf);
 
 	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
 
@@ -3492,9 +3528,6 @@ void ice_ptp_release(struct ice_pf *pf)
 		pf->ptp.kworker = NULL;
 	}
 
-	if (ice_pf_src_tmr_owned(pf))
-		ice_ptp_unregister_auxbus_driver(pf);
-
 	if (!pf->ptp.clock)
 		return;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index b8ab162a5538..cc36d6ffdc8f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -138,7 +138,7 @@ struct ice_ptp_tx {
  * ready for PTP functionality. It is used to track the port initialization
  * and determine when the port's PHY offset is valid.
  *
- * @list_member: list member structure of auxiliary device
+ * @list_node: list member structure
  * @tx: Tx timestamp tracking for this port
  * @aux_dev: auxiliary device associated with this port
  * @ov_work: delayed work task for tracking when PHY offset is valid
@@ -148,7 +148,7 @@ struct ice_ptp_tx {
  * @port_num: the port number this structure represents
  */
 struct ice_ptp_port {
-	struct list_head list_member;
+	struct list_head list_node;
 	struct ice_ptp_tx tx;
 	struct auxiliary_device aux_dev;
 	struct kthread_delayed_work ov_work;
@@ -174,6 +174,7 @@ enum ice_ptp_tx_interrupt {
  * @ports: list of porst handled by this port owner
  * @lock: protect access to ports list
  */
+
 struct ice_ptp_port_owner {
 	struct auxiliary_driver aux_driver;
 	struct list_head ports;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index fc946fcd28b9..f67981d64bb8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -468,6 +468,11 @@ static inline u64 ice_get_base_incval(struct ice_hw *hw)
 	}
 }
 
+static inline bool ice_is_dual(struct ice_hw *hw)
+{
+        return !!(hw->dev_caps.nac_topo.mode & ICE_NAC_TOPO_DUAL_M);
+}
+
 #define PFTSYN_SEM_BYTES	4
 
 #define ICE_PTP_CLOCK_INDEX_0	0x00
-- 
2.43.0


