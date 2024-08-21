Return-Path: <netdev+bounces-120600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC115959EDC
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A56A1F224FD
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A7C1ACE01;
	Wed, 21 Aug 2024 13:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F4h2RB49"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8E71A4AB6
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 13:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247464; cv=none; b=ZPot731nzUuAwkFv13GQ8q7wnSLhGM30PFJNZ31I0IV5BNM24OjYnLwd/p0/SwAbc7K4H8I+2zBwf/SKnLSNwv+Ntjt9QpoC40jBTj7kYOgdBcOup0qhjHn/WGT79Y5AmPUVrXI4WSZn7MkZR9HDCH0HT36FEacPG+b49kZ89k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247464; c=relaxed/simple;
	bh=Lo92JzGSPvW7JIhzn8YUg9F5HiG5kztdbTrYNNJw7zs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lOclQTNEBVr9LUuijUt/UWgsDvmaVXzzslPp14TWlToMa0kfjCTvTiL3wxEQgG3lFT4rrJTSqby+43leIbcq/xGZDPDZbNVLY2ZxRcW638vHX57Hxw6SIGJkP6zpN1gbHCrUqjgZsqPjT9cz/wsTWVQt0jiJgvxbrYpjDDLKC3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F4h2RB49; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724247462; x=1755783462;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lo92JzGSPvW7JIhzn8YUg9F5HiG5kztdbTrYNNJw7zs=;
  b=F4h2RB49FpscX0yPVhJE65Yh7p6cxLmRTVELCAv1zZPLiMWXsxBMQ0nr
   zN+PBtGO5isjeqagpoMNwt6H20+1ibfSwMNRjTE4ht5D6lB0nDd32Tx5K
   wLsQHe7/wPy7KrrCTSPGLc0bDtKEPkmBYt77IVnNDrKN/kq3GmFuWgN/0
   xfWmjKyjCALe8J2GqHgIWKGPW/1Yg2XpPKiD2n4LL13TwfkgoNlP/+N0D
   mi6U5qXJhYZfE8eP3+EC5o1tQK9/RHANekoqwjYTEWXGsOkwV7tZrFuAS
   6wmJC2BdTGF+xzcQG2933AtepFNtAVtL9ogw7SXUbwjKTElBLT0GA2y9r
   Q==;
X-CSE-ConnectionGUID: NGi6/cNHToOpbcHshKCjLQ==
X-CSE-MsgGUID: 9/iDDlbzRimbn9XLHK67JA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="45131486"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="45131486"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 06:37:38 -0700
X-CSE-ConnectionGUID: DUHs8gyJRMu8GefB45+G4Q==
X-CSE-MsgGUID: qIfE3EbfQceIfKcFkynjTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61071287"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa008.fm.intel.com with ESMTP; 21 Aug 2024 06:37:34 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 748ED28796;
	Wed, 21 Aug 2024 14:37:32 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Jiri Pirko <jiri@resnulli.us>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com,
	akpm@linux-foundation.org,
	willemb@google.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Igor Bagnucki <igor.bagnucki@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [PATCH iwl-next v3 4/6] ice: add Tx hang devlink health reporter
Date: Wed, 21 Aug 2024 15:37:12 +0200
Message-Id: <20240821133714.61417-5-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240821133714.61417-1-przemyslaw.kitszel@intel.com>
References: <20240821133714.61417-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add Tx hang devlink health reporter, see struct ice_tx_hang_event to see
what is reported.

Subsequent commits will extend it by more info, for now it dumps
descriptors with little metadata.

Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/Makefile       |   1 +
 .../intel/ice/devlink/devlink_health.h        |  48 +++++
 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 .../intel/ice/devlink/devlink_health.c        | 188 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_main.c     |  18 +-
 5 files changed, 252 insertions(+), 5 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/devlink_health.h
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/devlink_health.c

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index 3307d551f431..f2baba82480c 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -33,6 +33,7 @@ ice-y := ice_main.o	\
 	 ice_idc.o	\
 	 devlink/devlink.o	\
 	 devlink/devlink_port.o \
+	 devlink/devlink_health.o \
 	 ice_sf_eth.o	\
 	 ice_sf_vsi_vlan_ops.o \
 	 ice_ddp.o	\
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_health.h b/drivers/net/ethernet/intel/ice/devlink/devlink_health.h
new file mode 100644
index 000000000000..c50ef34cd244
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_health.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2024, Intel Corporation. */
+
+#ifndef _DEVLINK_HEALTH_H_
+#define _DEVLINK_HEALTH_H_
+
+#include <linux/types.h>
+
+/**
+ * DOC: devlink_health.h
+ *
+ * This header file stores everything that is needed for broadly understood
+ * devlink health mechanism for ice driver.
+ */
+
+struct ice_pf;
+struct ice_tx_ring;
+
+/**
+ * struct ice_health - stores ice devlink health reporters and accompanied data
+ * @tx_hang: devlink health reporter for tx_hang event
+ * @tx_hang_buf: pre-allocated place to put info for Tx hang reporter from
+ *               non-sleeping context
+ * @tx_ring: ring that the hang occured on
+ * @head: descriptior head
+ * @intr: interrupt register value
+ * @vsi_num: VSI owning the queue that the hang occured on
+ */
+struct ice_health {
+	struct devlink_health_reporter *tx_hang;
+	struct_group_tagged(ice_health_tx_hang_buf, tx_hang_buf,
+		struct ice_tx_ring *tx_ring;
+		u32 head;
+		u32 intr;
+		u16 vsi_num;
+	);
+};
+
+
+void ice_health_init(struct ice_pf *pf);
+void ice_health_deinit(struct ice_pf *pf);
+void ice_health_clear(struct ice_pf *pf);
+
+void ice_prep_tx_hang_report(struct ice_pf *pf, struct ice_tx_ring *tx_ring,
+			     u16 vsi_num, u32 head, u32 intr);
+void ice_report_tx_hang(struct ice_pf *pf);
+
+#endif /* _DEVLINK_HEALTH_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 0046684004ff..d2f2ed2d4bfa 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -78,6 +78,7 @@
 #include "ice_irq.h"
 #include "ice_dpll.h"
 #include "ice_adapter.h"
+#include "devlink/devlink_health.h"
 
 #define ICE_BAR0		0
 #define ICE_REQ_DESC_MULTIPLE	32
@@ -667,6 +668,7 @@ struct ice_pf {
 	struct ice_agg_node vf_agg_node[ICE_MAX_VF_AGG_NODES];
 	struct ice_dplls dplls;
 	struct device *hwmon_dev;
+	struct ice_health health_reporters;
 };
 
 extern struct workqueue_struct *ice_lag_wq;
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_health.c b/drivers/net/ethernet/intel/ice/devlink/devlink_health.c
new file mode 100644
index 000000000000..193dd4d00578
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_health.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024, Intel Corporation. */
+
+#include "devlink_health.h"
+#include "ice.h"
+
+#define ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, obj, name) \
+	devlink_fmsg_put(fmsg, #name, (obj)->name)
+
+/**
+ * ice_devlink_health_report - boilerplate to call given @reporter
+ *
+ * @reporter: devlink health reporter to call, do nothing on NULL
+ * @msg: message to pass up, "event name" is fine
+ * @priv_ctx: typically some event struct
+ */
+static void ice_devlink_health_report(struct devlink_health_reporter *reporter,
+				      const char *msg, void *priv_ctx)
+{
+	if (!reporter)
+		return;
+
+	/* We do not do auto recovering, so return value of the below function
+	 * will always be 0, thus we do ignore it.
+	 */
+	devlink_health_report(reporter, msg, priv_ctx);
+}
+
+/**
+ * ice_fmsg_put_ptr - put hex value of pointer into fmsg
+ *
+ * @fmsg: devlink fmsg under construction
+ * @name: name to pass
+ * @ptr: 64 bit value to print as hex and put into fmsg
+ */
+static void ice_fmsg_put_ptr(struct devlink_fmsg *fmsg, const char *name,
+			     void *ptr)
+{
+	char buf[sizeof(ptr) * 3];
+
+	sprintf(buf, "%p", ptr);
+	devlink_fmsg_put(fmsg, name, buf);
+}
+
+struct ice_tx_hang_event {
+	u32 head;
+	u32 intr;
+	u16 vsi_num;
+	u16 queue;
+	u16 next_to_clean;
+	u16 next_to_use;
+	struct ice_tx_ring *tx_ring;
+};
+
+static int ice_tx_hang_reporter_dump(struct devlink_health_reporter *reporter,
+				     struct devlink_fmsg *fmsg, void *priv_ctx,
+				     struct netlink_ext_ack *extack)
+{
+	struct ice_tx_hang_event *event = priv_ctx;
+
+	if (!event)
+		return 0;
+
+	devlink_fmsg_obj_nest_start(fmsg);
+	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, head);
+	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, intr);
+	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, vsi_num);
+	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, queue);
+	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, next_to_clean);
+	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, event, next_to_use);
+	devlink_fmsg_put(fmsg, "irq-mapping", event->tx_ring->q_vector->name);
+	ice_fmsg_put_ptr(fmsg, "desc-ptr", event->tx_ring->desc);
+	ice_fmsg_put_ptr(fmsg, "dma-ptr", (void *)(long)event->tx_ring->dma);
+	devlink_fmsg_binary_pair_put(fmsg, "desc", event->tx_ring->desc,
+				     event->tx_ring->count * sizeof(struct ice_tx_desc));
+	devlink_fmsg_obj_nest_end(fmsg);
+
+	return 0;
+}
+
+void ice_prep_tx_hang_report(struct ice_pf *pf, struct ice_tx_ring *tx_ring,
+			     u16 vsi_num, u32 head, u32 intr)
+{
+	struct ice_health_tx_hang_buf *buf = &pf->health_reporters.tx_hang_buf;
+
+	buf->tx_ring = tx_ring;
+	buf->vsi_num = vsi_num;
+	buf->head = head;
+	buf->intr = intr;
+}
+
+void ice_report_tx_hang(struct ice_pf *pf)
+{
+	struct ice_health_tx_hang_buf *buf = &pf->health_reporters.tx_hang_buf;
+	struct ice_tx_ring *tx_ring = buf->tx_ring;
+
+	struct ice_tx_hang_event ev = {
+		.head = buf->head,
+		.intr = buf->intr,
+		.vsi_num = buf->vsi_num,
+		.queue = tx_ring->q_index,
+		.next_to_clean = tx_ring->next_to_clean,
+		.next_to_use = tx_ring->next_to_use,
+		.tx_ring = tx_ring,
+	};
+
+	ice_devlink_health_report(pf->health_reporters.tx_hang, "Tx hang", &ev);
+}
+
+static struct devlink_health_reporter *
+ice_init_devlink_rep(struct ice_pf *pf,
+		     const struct devlink_health_reporter_ops *ops)
+{
+	struct devlink *devlink = priv_to_devlink(pf);
+	struct devlink_health_reporter *rep;
+	const u64 graceful_period = 0;
+
+	rep = devl_health_reporter_create(devlink, ops, graceful_period, pf);
+	if (IS_ERR(rep)) {
+		struct device *dev = ice_pf_to_dev(pf);
+
+		dev_err(dev, "failed to create devlink %s health report er",
+			ops->name);
+		return NULL;
+	}
+	return rep;
+}
+
+#define ICE_DEFINE_HEALTH_REPORTER_OPS(_name) \
+	static const struct devlink_health_reporter_ops ice_ ## _name ## _reporter_ops = { \
+	.name = #_name, \
+	.dump = ice_ ## _name ## _reporter_dump, \
+}
+
+ICE_DEFINE_HEALTH_REPORTER_OPS(tx_hang);
+
+/**
+ * ice_health_init - allocate and init all ice devlink health reporters and
+ * accompanied data
+ *
+ * @pf: PF struct
+ */
+void ice_health_init(struct ice_pf *pf)
+{
+	struct ice_health *reps = &pf->health_reporters;
+
+	reps->tx_hang = ice_init_devlink_rep(pf, &ice_tx_hang_reporter_ops);
+}
+
+/**
+ * ice_deinit_devl_reporter - destroy given devlink health reporter
+ * @reporter: reporter to destroy
+ */
+static void ice_deinit_devl_reporter(struct devlink_health_reporter *reporter)
+{
+	if (reporter)
+		devl_health_reporter_destroy(reporter);
+}
+
+/**
+ * ice_health_deinit - deallocate all ice devlink health reporters and
+ * accompanied data
+ *
+ * @pf: PF struct
+ */
+void ice_health_deinit(struct ice_pf *pf)
+{
+	ice_deinit_devl_reporter(pf->health_reporters.tx_hang);
+}
+
+static
+void ice_health_assign_healthy_state(struct devlink_health_reporter *reporter)
+{
+	if (reporter)
+		devlink_health_reporter_state_update(reporter,
+						     DEVLINK_HEALTH_REPORTER_STATE_HEALTHY);
+}
+
+/**
+ * ice_health_clear - clear devlink health issues after a reset
+ * @pf: the PF device structure
+ *
+ * Mark the PF in healthy state again after a reset has completed.
+ */
+void ice_health_clear(struct ice_pf *pf)
+{
+	ice_health_assign_healthy_state(pf->health_reporters.tx_hang);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 6f3ce0893cd9..be679ba02211 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2351,9 +2351,11 @@ static void ice_service_task(struct work_struct *work)
 	struct ice_pf *pf = container_of(work, struct ice_pf, serv_task);
 	unsigned long start_time = jiffies;
 
-	/* subtasks */
+	if (pf->health_reporters.tx_hang_buf.tx_ring) {
+		ice_report_tx_hang(pf);
+		pf->health_reporters.tx_hang_buf.tx_ring = NULL;
+	}
 
-	/* process reset requests first */
 	ice_reset_subtask(pf);
 
 	/* bail if a reset/recovery cycle is pending or rebuild failed */
@@ -5036,14 +5038,16 @@ static int ice_init_devlink(struct ice_pf *pf)
 		return err;
 
 	ice_devlink_init_regions(pf);
+	ice_health_init(pf);
 	ice_devlink_register(pf);
 
 	return 0;
 }
 
 static void ice_deinit_devlink(struct ice_pf *pf)
 {
 	ice_devlink_unregister(pf);
+	ice_health_deinit(pf);
 	ice_devlink_destroy_regions(pf);
 	ice_devlink_unregister_params(pf);
 }
@@ -7724,6 +7728,8 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 	/* if we get here, reset flow is successful */
 	clear_bit(ICE_RESET_FAILED, pf->state);
 
+	ice_health_clear(pf);
+
 	ice_plug_aux_dev(pf);
 	if (ice_is_feature_supported(pf, ICE_F_SRIOV_LAG))
 		ice_lag_rebuild(pf);
@@ -8214,16 +8220,18 @@ void ice_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 
 	if (tx_ring) {
 		struct ice_hw *hw = &pf->hw;
-		u32 head, val = 0;
+		u32 head, intr = 0;
 
 		head = FIELD_GET(QTX_COMM_HEAD_HEAD_M,
 				 rd32(hw, QTX_COMM_HEAD(vsi->txq_map[txqueue])));
 		/* Read interrupt register */
-		val = rd32(hw, GLINT_DYN_CTL(tx_ring->q_vector->reg_idx));
+		intr = rd32(hw, GLINT_DYN_CTL(tx_ring->q_vector->reg_idx));
 
 		netdev_info(netdev, "tx_timeout: VSI_num: %d, Q %u, NTC: 0x%x, HW_HEAD: 0x%x, NTU: 0x%x, INT: 0x%x\n",
 			    vsi->vsi_num, txqueue, tx_ring->next_to_clean,
-			    head, tx_ring->next_to_use, val);
+			    head, tx_ring->next_to_use, intr);
+
+		ice_prep_tx_hang_report(pf, tx_ring, vsi->vsi_num, head, intr);
 	}
 
 	pf->tx_timeout_last_recovery = jiffies;
-- 
2.39.3


