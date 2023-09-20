Return-Path: <netdev+bounces-35289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AA67A8A76
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 19:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35174281B83
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 17:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A01E1A5A8;
	Wed, 20 Sep 2023 17:20:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB9B1A5A7
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 17:20:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA9AC6
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695230403; x=1726766403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sbrPoMKqQ5zBGa01L6EKN7f3/w+I/G6C+bglagpDja4=;
  b=ZMZVdyl1eFo6+Zv1wWVlWzamMg9OW66YT+GVfKiwLBYHTEbNFC4/Mm+w
   jhGSrurBdrZ+XyyTzEDBUkQVqJUkMLBszyRMHCdrHpeUXeo4DlU7Ep6nB
   aySnGPIAKg53CpL9qRft9wojvcbKwjEbgY5wzvHKDscT6zVN1S8UKosoc
   JAuVuq02NuMm8L4+Km4FfW6VJMLmK4ECkZBSg5woiJhuwhNbUIruzX6mb
   gdJLBHVPBaOOrAdj3i+9BvNqNiz0IkEvitn870ARgrb5edWjTZvb12Wix
   zn99GjQFPhQZz30ofmpWZF1qVPqrFLsTbXh+kVNCNDyoe+gsWZxQKWFzP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="411234462"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="411234462"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 10:20:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="1077543714"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="1077543714"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga005.fm.intel.com with ESMTP; 20 Sep 2023 10:19:59 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Michalik <michal.michalik@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	richardcochran@gmail.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 1/4] ice: Auxbus devices & driver for E822 TS
Date: Wed, 20 Sep 2023 10:19:26 -0700
Message-Id: <20230920171929.2198273-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230920171929.2198273-1-anthony.l.nguyen@intel.com>
References: <20230920171929.2198273-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Michal Michalik <michal.michalik@intel.com>

There is a problem in HW in E822-based devices leading to race
condition.
It might happen that, in order:
- PF0 (which owns the PHC) requests few timestamps,
- PF1 requests a timestamp,
- interrupt is being triggered and both PF0 and PF1 threads are woken
up,
- PF0 got one timestamp, still waiting for others so not going to sleep,
- PF1 gets it's timestamp, process it and go to sleep,
- PF1 requests a timestamp again,
- just before PF0 goes to sleep timestamp of PF1 appear,
- PF0 finishes all it's timestamps and go to sleep (PF1 also sleeping).
That leaves PF1 timestamp memory not read, which lead to blocking the
next interrupt from arriving.

Fix it by adding auxiliary devices and only one driver to handle all the
timestamps for all PF's by PHC owner. In the past each PF requested it's
own timestamps and process it from the start till the end which causes
problem described above. Currently each PF requests the timestamps as
before, but the actual reading of the completed timestamps is being done
by the PTP auxiliary driver, which is registered by the PF which owns PHC.

Additionally, the newly introduced auxiliary driver/devices for PTP clock
owner will be used for other features in all products (including E810).

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Michal Michalik <michal.michalik@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |  12 +
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  11 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 393 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |  30 ++
 5 files changed, 430 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index d30ae39c19f0..fcaa5c3b8ec0 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -673,6 +673,18 @@ static inline bool ice_vector_ch_enabled(struct ice_q_vector *qv)
 	return !!qv->ch; /* Enable it to run with TC */
 }
 
+/**
+ * ice_ptp_pf_handles_tx_interrupt - Check if PF handles Tx interrupt
+ * @pf: Board private structure
+ *
+ * Return true if this PF should respond to the Tx timestamp interrupt
+ * indication in the miscellaneous OICR interrupt handler.
+ */
+static inline bool ice_ptp_pf_handles_tx_interrupt(struct ice_pf *pf)
+{
+	return pf->ptp.tx_interrupt_mode != ICE_PTP_TX_INTERRUPT_NONE;
+}
+
 /**
  * ice_irq_dynamic_ena - Enable default interrupt generation settings
  * @hw: pointer to HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
index 531cc2194741..6756f3d51d14 100644
--- a/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
+++ b/drivers/net/ethernet/intel/ice/ice_hw_autogen.h
@@ -231,6 +231,7 @@
 #define PFINT_SB_CTL				0x0016B600
 #define PFINT_SB_CTL_MSIX_INDX_M		ICE_M(0x7FF, 0)
 #define PFINT_SB_CTL_CAUSE_ENA_M		BIT(30)
+#define PFINT_TSYN_MSK				0x0016C980
 #define QINT_RQCTL(_QRX)			(0x00150000 + ((_QRX) * 4))
 #define QINT_RQCTL_MSIX_INDX_S			0
 #define QINT_RQCTL_MSIX_INDX_M			ICE_M(0x7FF, 0)
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e22f41fea8db..c726913bc635 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3149,7 +3149,7 @@ static irqreturn_t ice_misc_intr(int __always_unused irq, void *data)
 
 	if (oicr & PFINT_OICR_TSYN_TX_M) {
 		ena_mask &= ~PFINT_OICR_TSYN_TX_M;
-		if (!hw->reset_ongoing)
+		if (!hw->reset_ongoing && ice_ptp_pf_handles_tx_interrupt(pf))
 			set_bit(ICE_MISC_THREAD_TX_TSTAMP, pf->misc_thread);
 	}
 
@@ -7375,8 +7375,13 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 	}
 
 	/* configure PTP timestamping after VSI rebuild */
-	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags))
-		ice_ptp_cfg_timestamp(pf, false);
+	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags)) {
+		if (pf->ptp.tx_interrupt_mode == ICE_PTP_TX_INTERRUPT_SELF)
+			ice_ptp_cfg_timestamp(pf, false);
+		else if (pf->ptp.tx_interrupt_mode == ICE_PTP_TX_INTERRUPT_ALL)
+			/* for E82x PHC owner always need to have interrupts */
+			ice_ptp_cfg_timestamp(pf, true);
+	}
 
 	err = ice_vsi_rebuild_by_type(pf, ICE_VSI_SWITCHDEV_CTRL);
 	if (err) {
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 05f922d3b316..9c21e81c29db 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -255,6 +255,24 @@ ice_verify_pin_e810t(struct ptp_clock_info *info, unsigned int pin,
 	return ice_ptp_set_sma_e810t(info, pin, func);
 }
 
+/**
+ * ice_ptp_configure_tx_tstamp - Enable or disable Tx timestamp interrupt
+ * @pf: The PF pointer to search in
+ * @on: bool value for whether timestamp interrupt is enabled or disabled
+ */
+static void ice_ptp_configure_tx_tstamp(struct ice_pf *pf, bool on)
+{
+	u32 val;
+
+	/* Configure the Tx timestamp interrupt */
+	val = rd32(&pf->hw, PFINT_OICR_ENA);
+	if (on)
+		val |= PFINT_OICR_TSYN_TX_M;
+	else
+		val &= ~PFINT_OICR_TSYN_TX_M;
+	wr32(&pf->hw, PFINT_OICR_ENA, val);
+}
+
 /**
  * ice_set_tx_tstamp - Enable or disable Tx timestamping
  * @pf: The PF pointer to search in
@@ -263,7 +281,6 @@ ice_verify_pin_e810t(struct ptp_clock_info *info, unsigned int pin,
 static void ice_set_tx_tstamp(struct ice_pf *pf, bool on)
 {
 	struct ice_vsi *vsi;
-	u32 val;
 	u16 i;
 
 	vsi = ice_get_main_vsi(pf);
@@ -277,13 +294,8 @@ static void ice_set_tx_tstamp(struct ice_pf *pf, bool on)
 		vsi->tx_rings[i]->ptp_tx = on;
 	}
 
-	/* Configure the Tx timestamp interrupt */
-	val = rd32(&pf->hw, PFINT_OICR_ENA);
-	if (on)
-		val |= PFINT_OICR_TSYN_TX_M;
-	else
-		val &= ~PFINT_OICR_TSYN_TX_M;
-	wr32(&pf->hw, PFINT_OICR_ENA, val);
+	if (pf->ptp.tx_interrupt_mode == ICE_PTP_TX_INTERRUPT_SELF)
+		ice_ptp_configure_tx_tstamp(pf, on);
 
 	pf->ptp.tstamp_config.tx_type = on ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
 }
@@ -674,9 +686,6 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	int err;
 	u8 idx;
 
-	if (!tx->init)
-		return;
-
 	ptp_port = container_of(tx, struct ice_ptp_port, tx);
 	pf = ptp_port_to_pf(ptp_port);
 	hw = &pf->hw;
@@ -774,6 +783,39 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	}
 }
 
+/**
+ * ice_ptp_tx_tstamp_owner - Process Tx timestamps for all ports on the device
+ * @pf: Board private structure
+ */
+static enum ice_tx_tstamp_work ice_ptp_tx_tstamp_owner(struct ice_pf *pf)
+{
+	struct ice_ptp_port *port;
+	unsigned int i;
+
+	mutex_lock(&pf->ptp.ports_owner.lock);
+	list_for_each_entry(port, &pf->ptp.ports_owner.ports, list_member) {
+		struct ice_ptp_tx *tx = &port->tx;
+
+		if (!tx || !tx->init)
+			continue;
+
+		ice_ptp_process_tx_tstamp(tx);
+	}
+	mutex_unlock(&pf->ptp.ports_owner.lock);
+
+	for (i = 0; i < ICE_MAX_QUAD; i++) {
+		u64 tstamp_ready;
+		int err;
+
+		/* Read the Tx ready status first */
+		err = ice_get_phy_tx_tstamp_ready(&pf->hw, i, &tstamp_ready);
+		if (err || tstamp_ready)
+			return ICE_TX_TSTAMP_WORK_PENDING;
+	}
+
+	return ICE_TX_TSTAMP_WORK_DONE;
+}
+
 /**
  * ice_ptp_tx_tstamp - Process Tx timestamps for this function.
  * @tx: Tx tracking structure to initialize
@@ -2465,7 +2507,21 @@ s8 ice_ptp_request_ts(struct ice_ptp_tx *tx, struct sk_buff *skb)
  */
 enum ice_tx_tstamp_work ice_ptp_process_ts(struct ice_pf *pf)
 {
-	return ice_ptp_tx_tstamp(&pf->ptp.port.tx);
+	switch (pf->ptp.tx_interrupt_mode) {
+	case ICE_PTP_TX_INTERRUPT_NONE:
+		/* This device has the clock owner handle timestamps for it */
+		return ICE_TX_TSTAMP_WORK_DONE;
+	case ICE_PTP_TX_INTERRUPT_SELF:
+		/* This device handles its own timestamps */
+		return ice_ptp_tx_tstamp(&pf->ptp.port.tx);
+	case ICE_PTP_TX_INTERRUPT_ALL:
+		/* This device handles timestamps for all ports */
+		return ice_ptp_tx_tstamp_owner(pf);
+	default:
+		WARN_ONCE(1, "Unexpected Tx timestamp interrupt mode %u\n",
+			  pf->ptp.tx_interrupt_mode);
+		return ICE_TX_TSTAMP_WORK_DONE;
+	}
 }
 
 static void ice_ptp_periodic_work(struct kthread_work *work)
@@ -2574,6 +2630,187 @@ void ice_ptp_reset(struct ice_pf *pf)
 	dev_err(ice_pf_to_dev(pf), "PTP reset failed %d\n", err);
 }
 
+/**
+ * ice_ptp_aux_dev_to_aux_pf - Get auxiliary PF handle for the auxiliary device
+ * @aux_dev: auxiliary device to get the auxiliary PF for
+ */
+static struct ice_pf *
+ice_ptp_aux_dev_to_aux_pf(struct auxiliary_device *aux_dev)
+{
+	struct ice_ptp_port *aux_port;
+	struct ice_ptp *aux_ptp;
+
+	aux_port = container_of(aux_dev, struct ice_ptp_port, aux_dev);
+	aux_ptp = container_of(aux_port, struct ice_ptp, port);
+
+	return container_of(aux_ptp, struct ice_pf, ptp);
+}
+
+/**
+ * ice_ptp_aux_dev_to_owner_pf - Get PF handle for the auxiliary device
+ * @aux_dev: auxiliary device to get the PF for
+ */
+static struct ice_pf *
+ice_ptp_aux_dev_to_owner_pf(struct auxiliary_device *aux_dev)
+{
+	struct ice_ptp_port_owner *ports_owner;
+	struct auxiliary_driver *aux_drv;
+	struct ice_ptp *owner_ptp;
+
+	if (!aux_dev->dev.driver)
+		return NULL;
+
+	aux_drv = to_auxiliary_drv(aux_dev->dev.driver);
+	ports_owner = container_of(aux_drv, struct ice_ptp_port_owner,
+				   aux_driver);
+	owner_ptp = container_of(ports_owner, struct ice_ptp, ports_owner);
+	return container_of(owner_ptp, struct ice_pf, ptp);
+}
+
+/**
+ * ice_ptp_auxbus_probe - Probe auxiliary devices
+ * @aux_dev: PF's auxiliary device
+ * @id: Auxiliary device ID
+ */
+static int ice_ptp_auxbus_probe(struct auxiliary_device *aux_dev,
+				const struct auxiliary_device_id *id)
+{
+	struct ice_pf *owner_pf = ice_ptp_aux_dev_to_owner_pf(aux_dev);
+	struct ice_pf *aux_pf = ice_ptp_aux_dev_to_aux_pf(aux_dev);
+
+	if (WARN_ON(!owner_pf))
+		return -ENODEV;
+
+	INIT_LIST_HEAD(&aux_pf->ptp.port.list_member);
+	mutex_lock(&owner_pf->ptp.ports_owner.lock);
+	list_add(&aux_pf->ptp.port.list_member,
+		 &owner_pf->ptp.ports_owner.ports);
+	mutex_unlock(&owner_pf->ptp.ports_owner.lock);
+
+	return 0;
+}
+
+/**
+ * ice_ptp_auxbus_remove - Remove auxiliary devices from the bus
+ * @aux_dev: PF's auxiliary device
+ */
+static void ice_ptp_auxbus_remove(struct auxiliary_device *aux_dev)
+{
+	struct ice_pf *owner_pf = ice_ptp_aux_dev_to_owner_pf(aux_dev);
+	struct ice_pf *aux_pf = ice_ptp_aux_dev_to_aux_pf(aux_dev);
+
+	mutex_lock(&owner_pf->ptp.ports_owner.lock);
+	list_del(&aux_pf->ptp.port.list_member);
+	mutex_unlock(&owner_pf->ptp.ports_owner.lock);
+}
+
+/**
+ * ice_ptp_auxbus_shutdown
+ * @aux_dev: PF's auxiliary device
+ */
+static void ice_ptp_auxbus_shutdown(struct auxiliary_device *aux_dev)
+{
+	/* Doing nothing here, but handle to auxbus driver must be satisfied */
+}
+
+/**
+ * ice_ptp_auxbus_suspend
+ * @aux_dev: PF's auxiliary device
+ * @state: power management state indicator
+ */
+static int
+ice_ptp_auxbus_suspend(struct auxiliary_device *aux_dev, pm_message_t state)
+{
+	/* Doing nothing here, but handle to auxbus driver must be satisfied */
+	return 0;
+}
+
+/**
+ * ice_ptp_auxbus_resume
+ * @aux_dev: PF's auxiliary device
+ */
+static int ice_ptp_auxbus_resume(struct auxiliary_device *aux_dev)
+{
+	/* Doing nothing here, but handle to auxbus driver must be satisfied */
+	return 0;
+}
+
+/**
+ * ice_ptp_auxbus_create_id_table - Create auxiliary device ID table
+ * @pf: Board private structure
+ * @name: auxiliary bus driver name
+ */
+static struct auxiliary_device_id *
+ice_ptp_auxbus_create_id_table(struct ice_pf *pf, const char *name)
+{
+	struct auxiliary_device_id *ids;
+
+	/* Second id left empty to terminate the array */
+	ids = devm_kcalloc(ice_pf_to_dev(pf), 2,
+			   sizeof(struct auxiliary_device_id), GFP_KERNEL);
+	if (!ids)
+		return NULL;
+
+	snprintf(ids[0].name, sizeof(ids[0].name), "ice.%s", name);
+
+	return ids;
+}
+
+/**
+ * ice_ptp_register_auxbus_driver - Register PTP auxiliary bus driver
+ * @pf: Board private structure
+ */
+static int ice_ptp_register_auxbus_driver(struct ice_pf *pf)
+{
+	struct auxiliary_driver *aux_driver;
+	struct ice_ptp *ptp;
+	struct device *dev;
+	char *name;
+	int err;
+
+	ptp = &pf->ptp;
+	dev = ice_pf_to_dev(pf);
+	aux_driver = &ptp->ports_owner.aux_driver;
+	INIT_LIST_HEAD(&ptp->ports_owner.ports);
+	mutex_init(&ptp->ports_owner.lock);
+	name = devm_kasprintf(dev, GFP_KERNEL, "ptp_aux_dev_%u_%u_clk%u",
+			      pf->pdev->bus->number, PCI_SLOT(pf->pdev->devfn),
+			      ice_get_ptp_src_clock_index(&pf->hw));
+
+	aux_driver->name = name;
+	aux_driver->shutdown = ice_ptp_auxbus_shutdown;
+	aux_driver->suspend = ice_ptp_auxbus_suspend;
+	aux_driver->remove = ice_ptp_auxbus_remove;
+	aux_driver->resume = ice_ptp_auxbus_resume;
+	aux_driver->probe = ice_ptp_auxbus_probe;
+	aux_driver->id_table = ice_ptp_auxbus_create_id_table(pf, name);
+	if (!aux_driver->id_table)
+		return -ENOMEM;
+
+	err = auxiliary_driver_register(aux_driver);
+	if (err) {
+		devm_kfree(dev, aux_driver->id_table);
+		dev_err(dev, "Failed registering aux_driver, name <%s>\n",
+			name);
+	}
+
+	return err;
+}
+
+/**
+ * ice_ptp_unregister_auxbus_driver - Unregister PTP auxiliary bus driver
+ * @pf: Board private structure
+ */
+static void ice_ptp_unregister_auxbus_driver(struct ice_pf *pf)
+{
+	struct auxiliary_driver *aux_driver = &pf->ptp.ports_owner.aux_driver;
+
+	auxiliary_driver_unregister(aux_driver);
+	devm_kfree(ice_pf_to_dev(pf), aux_driver->id_table);
+
+	mutex_destroy(&pf->ptp.ports_owner.lock);
+}
+
 /**
  * ice_ptp_prepare_for_reset - Prepare PTP for reset
  * @pf: Board private structure
@@ -2652,7 +2889,15 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
 	/* Release the global hardware lock */
 	ice_ptp_unlock(hw);
 
-	if (!ice_is_e810(hw)) {
+	if (pf->ptp.tx_interrupt_mode == ICE_PTP_TX_INTERRUPT_ALL) {
+		/* The clock owner for this device type handles the timestamp
+		 * interrupt for all ports.
+		 */
+		ice_ptp_configure_tx_tstamp(pf, true);
+
+		/* React on all quads interrupts for E82x */
+		wr32(hw, PFINT_TSYN_MSK + (0x4 * hw->pf_id), (u32)0x1f);
+
 		/* Enable quad interrupts */
 		err = ice_ptp_tx_ena_intr(pf, true, itr);
 		if (err)
@@ -2667,8 +2912,16 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
 	/* Store the PTP clock index for other PFs */
 	ice_set_ptp_clock_index(pf);
 
-	return 0;
+	err = ice_ptp_register_auxbus_driver(pf);
+	if (err) {
+		dev_err(ice_pf_to_dev(pf), "Failed to register PTP auxbus driver");
+		goto err_aux;
+	}
 
+	return 0;
+err_aux:
+	ice_clear_ptp_clock_index(pf);
+	ptp_clock_unregister(pf->ptp.clock);
 err_clk:
 	pf->ptp.clock = NULL;
 err_exit:
@@ -2718,6 +2971,13 @@ static int ice_ptp_init_port(struct ice_pf *pf, struct ice_ptp_port *ptp_port)
 	case ICE_PHY_E810:
 		return ice_ptp_init_tx_e810(pf, &ptp_port->tx);
 	case ICE_PHY_E822:
+		/* Non-owner PFs don't react to any interrupts on E82x,
+		 * neither on own quad nor on others
+		 */
+		if (!ice_ptp_pf_handles_tx_interrupt(pf)) {
+			ice_ptp_configure_tx_tstamp(pf, false);
+			wr32(hw, PFINT_TSYN_MSK + (0x4 * hw->pf_id), (u32)0x0);
+		}
 		kthread_init_delayed_work(&ptp_port->ov_work,
 					  ice_ptp_wait_for_offsets);
 
@@ -2728,6 +2988,101 @@ static int ice_ptp_init_port(struct ice_pf *pf, struct ice_ptp_port *ptp_port)
 	}
 }
 
+/**
+ * ice_ptp_release_auxbus_device
+ * @dev: device that utilizes the auxbus
+ */
+static void ice_ptp_release_auxbus_device(struct device *dev)
+{
+	/* Doing nothing here, but handle to auxbux device must be satisfied */
+}
+
+/**
+ * ice_ptp_create_auxbus_device - Create PTP auxiliary bus device
+ * @pf: Board private structure
+ */
+static int ice_ptp_create_auxbus_device(struct ice_pf *pf)
+{
+	struct auxiliary_device *aux_dev;
+	struct ice_ptp *ptp;
+	struct device *dev;
+	char *name;
+	int err;
+	u32 id;
+
+	ptp = &pf->ptp;
+	id = ptp->port.port_num;
+	dev = ice_pf_to_dev(pf);
+
+	aux_dev = &ptp->port.aux_dev;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "ptp_aux_dev_%u_%u_clk%u",
+			      pf->pdev->bus->number, PCI_SLOT(pf->pdev->devfn),
+			      ice_get_ptp_src_clock_index(&pf->hw));
+
+	aux_dev->name = name;
+	aux_dev->id = id;
+	aux_dev->dev.release = ice_ptp_release_auxbus_device;
+	aux_dev->dev.parent = dev;
+
+	err = auxiliary_device_init(aux_dev);
+	if (err)
+		goto aux_err;
+
+	err = auxiliary_device_add(aux_dev);
+	if (err) {
+		auxiliary_device_uninit(aux_dev);
+		goto aux_err;
+	}
+
+	return 0;
+aux_err:
+	dev_err(dev, "Failed to create PTP auxiliary bus device <%s>\n", name);
+	devm_kfree(dev, name);
+	return err;
+}
+
+/**
+ * ice_ptp_remove_auxbus_device - Remove PTP auxiliary bus device
+ * @pf: Board private structure
+ */
+static void ice_ptp_remove_auxbus_device(struct ice_pf *pf)
+{
+	struct auxiliary_device *aux_dev = &pf->ptp.port.aux_dev;
+
+	auxiliary_device_delete(aux_dev);
+	auxiliary_device_uninit(aux_dev);
+
+	memset(aux_dev, 0, sizeof(*aux_dev));
+}
+
+/**
+ * ice_ptp_init_tx_interrupt_mode - Initialize device Tx interrupt mode
+ * @pf: Board private structure
+ *
+ * Initialize the Tx timestamp interrupt mode for this device. For most device
+ * types, each PF processes the interrupt and manages its own timestamps. For
+ * E822-based devices, only the clock owner processes the timestamps. Other
+ * PFs disable the interrupt and do not process their own timestamps.
+ */
+static void ice_ptp_init_tx_interrupt_mode(struct ice_pf *pf)
+{
+	switch (pf->hw.phy_model) {
+	case ICE_PHY_E822:
+		/* E822 based PHY has the clock owner process the interrupt
+		 * for all ports.
+		 */
+		if (ice_pf_src_tmr_owned(pf))
+			pf->ptp.tx_interrupt_mode = ICE_PTP_TX_INTERRUPT_ALL;
+		else
+			pf->ptp.tx_interrupt_mode = ICE_PTP_TX_INTERRUPT_NONE;
+		break;
+	default:
+		/* other PHY types handle their own Tx interrupt */
+		pf->ptp.tx_interrupt_mode = ICE_PTP_TX_INTERRUPT_SELF;
+	}
+}
+
 /**
  * ice_ptp_init - Initialize PTP hardware clock support
  * @pf: Board private structure
@@ -2748,6 +3103,8 @@ void ice_ptp_init(struct ice_pf *pf)
 
 	ice_ptp_init_phy_model(hw);
 
+	ice_ptp_init_tx_interrupt_mode(pf);
+
 	/* If this function owns the clock hardware, it must allocate and
 	 * configure the PTP clock device to represent it.
 	 */
@@ -2770,6 +3127,10 @@ void ice_ptp_init(struct ice_pf *pf)
 	if (err)
 		goto err;
 
+	err = ice_ptp_create_auxbus_device(pf);
+	if (err)
+		goto err;
+
 	dev_info(ice_pf_to_dev(pf), "PTP init successful\n");
 	return;
 
@@ -2798,6 +3159,8 @@ void ice_ptp_release(struct ice_pf *pf)
 	/* Disable timestamping for both Tx and Rx */
 	ice_ptp_cfg_timestamp(pf, false);
 
+	ice_ptp_remove_auxbus_device(pf);
+
 	ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
 
 	clear_bit(ICE_FLAG_PTP, pf->flags);
@@ -2821,5 +3184,7 @@ void ice_ptp_release(struct ice_pf *pf)
 	ptp_clock_unregister(pf->ptp.clock);
 	pf->ptp.clock = NULL;
 
+	ice_ptp_unregister_auxbus_driver(pf);
+
 	dev_info(ice_pf_to_dev(pf), "Removed PTP clock\n");
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 995a57019ba7..d94c22329df0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -157,7 +157,9 @@ struct ice_ptp_tx {
  * ready for PTP functionality. It is used to track the port initialization
  * and determine when the port's PHY offset is valid.
  *
+ * @list_member: list member structure of auxiliary device
  * @tx: Tx timestamp tracking for this port
+ * @aux_dev: auxiliary device associated with this port
  * @ov_work: delayed work task for tracking when PHY offset is valid
  * @ps_lock: mutex used to protect the overall PTP PHY start procedure
  * @link_up: indicates whether the link is up
@@ -165,7 +167,9 @@ struct ice_ptp_tx {
  * @port_num: the port number this structure represents
  */
 struct ice_ptp_port {
+	struct list_head list_member;
 	struct ice_ptp_tx tx;
+	struct auxiliary_device aux_dev;
 	struct kthread_delayed_work ov_work;
 	struct mutex ps_lock; /* protects overall PTP PHY start procedure */
 	bool link_up;
@@ -173,11 +177,35 @@ struct ice_ptp_port {
 	u8 port_num;
 };
 
+enum ice_ptp_tx_interrupt {
+	ICE_PTP_TX_INTERRUPT_NONE = 0,
+	ICE_PTP_TX_INTERRUPT_SELF,
+	ICE_PTP_TX_INTERRUPT_ALL,
+};
+
+/**
+ * struct ice_ptp_port_owner - data used to handle the PTP clock owner info
+ *
+ * This structure contains data necessary for the PTP clock owner to correctly
+ * handle the timestamping feature for all attached ports.
+ *
+ * @aux_driver: the structure carring the auxiliary driver information
+ * @ports: list of porst handled by this port owner
+ * @lock: protect access to ports list
+ */
+struct ice_ptp_port_owner {
+	struct auxiliary_driver aux_driver;
+	struct list_head ports;
+	struct mutex lock;
+};
+
 #define GLTSYN_TGT_H_IDX_MAX		4
 
 /**
  * struct ice_ptp - data used for integrating with CONFIG_PTP_1588_CLOCK
+ * @tx_interrupt_mode: the TX interrupt mode for the PTP clock
  * @port: data for the PHY port initialization procedure
+ * @ports_owner: data for the auxiliary driver owner
  * @work: delayed work function for periodic tasks
  * @cached_phc_time: a cached copy of the PHC time for timestamp extension
  * @cached_phc_jiffies: jiffies when cached_phc_time was last updated
@@ -197,7 +225,9 @@ struct ice_ptp_port {
  * @late_cached_phc_updates: number of times cached PHC update is late
  */
 struct ice_ptp {
+	enum ice_ptp_tx_interrupt tx_interrupt_mode;
 	struct ice_ptp_port port;
+	struct ice_ptp_port_owner ports_owner;
 	struct kthread_delayed_work work;
 	u64 cached_phc_time;
 	unsigned long cached_phc_jiffies;
-- 
2.38.1


