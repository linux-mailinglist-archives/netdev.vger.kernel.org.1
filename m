Return-Path: <netdev+bounces-152723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7C29F5882
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 22:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F89C1894ACC
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 21:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225CB1FA251;
	Tue, 17 Dec 2024 21:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XrgU5/5X"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2EE1F9F6F
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 21:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734469735; cv=none; b=SvqzQ/1bgeuo11pwfnFvOAD5wzsoAiYwOZCJwpqMRUeDtsAaKFcdghtgV8wTcnrwShiO11jTLk2Yh+5lyhVDcgKyIJUEhW7juyNgltumq0x6xxKSEKHh1BiDDBrdSqeumzoRE33X8YDiFvoUrJeLr8/WETKFVw9imLB+ZEkEdPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734469735; c=relaxed/simple;
	bh=2tytuUZvm3nJXddfq6bF/ZkXswf1hBc3FocAMhjrtaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TNYAX2bp26fbd8mNrQyQOKjdhBNYbYce2igmVYYvdsqsoxgJ5wKWocu7txOd04lZuwXPbrqMnNmTtbDDLyNnEi8lnKg3NAQqB7m3exeBxYJc0ZyFYhbiCG0G2E6ygJ62bt4YFOT1QByUiEKS2AoUsy1f98dvag5pPbsDEHDmZsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XrgU5/5X; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734469733; x=1766005733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2tytuUZvm3nJXddfq6bF/ZkXswf1hBc3FocAMhjrtaE=;
  b=XrgU5/5X+crkyqSqkGGV5/43Rser+u2R6Qa4wA1KoHexeTb5OglmK10m
   ottMLgfOFAjpiOYcB/kPurqz3pjUmIeTd6xEOpfk8XlQ0unIEgUGv4lQE
   XRgigJysHvNwRcFofO+TresWKo1XhE3MJ13cvXsuI1jF6lP/Yb9g/rIge
   7Gr9pYxEjuqJXBpfdnEadbqiFn/4RipQZ1Sw944+OOcPH9iPPFykvomvT
   p1zGlIzJn4imef/Lro3t97cbyxBdlTd8u9MAYY38Q+zDuaZLbadZ2mLn4
   3N7QMMAN4UxLChO/AoqLc2nNOwqlx/PzXlgeLCjzwxXsu6KSFZumPkXQK
   A==;
X-CSE-ConnectionGUID: LwvOUmMGTJSwzWGFYZlXeQ==
X-CSE-MsgGUID: WexEN+ybSZavS3VNo7s7FA==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="34794865"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="34794865"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 13:08:52 -0800
X-CSE-ConnectionGUID: n6KJEVyeSe+jUf1BUUKCcA==
X-CSE-MsgGUID: jpLzBKsFQZqfPXLrivxbRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="97436339"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 17 Dec 2024 13:08:50 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	mateusz.polchlopek@intel.com,
	joe@perches.com,
	horms@kernel.org,
	jiri@resnulli.us,
	apw@canonical.com,
	lukas.bulwahn@gmail.com,
	dwaipayanray1@gmail.com,
	Igor Bagnucki <igor.bagnucki@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next v2 5/6] ice: add Tx hang devlink health reporter
Date: Tue, 17 Dec 2024 13:08:32 -0800
Message-ID: <20241217210835.3702003-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217210835.3702003-1-anthony.l.nguyen@intel.com>
References: <20241217210835.3702003-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Add Tx hang devlink health reporter, see struct ice_tx_hang_event to see
what exactly is reported. For now dump descriptors with little metadata
and skb diagnostic information.

Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/Makefile       |   1 +
 .../net/ethernet/intel/ice/devlink/health.c   | 192 ++++++++++++++++++
 .../net/ethernet/intel/ice/devlink/health.h   |  47 +++++
 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  18 +-
 5 files changed, 255 insertions(+), 5 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/health.c
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/health.h

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index 56aa23aee472..9e0d9f710441 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -32,6 +32,7 @@ ice-y := ice_main.o	\
 	 ice_parser_rt.o \
 	 ice_idc.o	\
 	 devlink/devlink.o	\
+	 devlink/health.o \
 	 devlink/port.o \
 	 ice_sf_eth.o	\
 	 ice_sf_vsi_vlan_ops.o \
diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
new file mode 100644
index 000000000000..984d910fc41d
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/devlink/health.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024, Intel Corporation. */
+
+#include "health.h"
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
+	struct sk_buff *skb;
+
+	if (!event)
+		return 0;
+
+	skb = event->tx_ring->tx_buf->skb;
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
+	ice_fmsg_put_ptr(fmsg, "skb-ptr", skb);
+	devlink_fmsg_binary_pair_put(fmsg, "desc", event->tx_ring->desc,
+				     event->tx_ring->count * sizeof(struct ice_tx_desc));
+	devlink_fmsg_dump_skb(fmsg, skb);
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
diff --git a/drivers/net/ethernet/intel/ice/devlink/health.h b/drivers/net/ethernet/intel/ice/devlink/health.h
new file mode 100644
index 000000000000..5ce601227acb
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/devlink/health.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2024, Intel Corporation. */
+
+#ifndef _HEALTH_H_
+#define _HEALTH_H_
+
+#include <linux/types.h>
+
+/**
+ * DOC: health.h
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
+ * @tx_ring: ring that the hang occurred on
+ * @head: descriptor head
+ * @intr: interrupt register value
+ * @vsi_num: VSI owning the queue that the hang occurred on
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
+void ice_health_init(struct ice_pf *pf);
+void ice_health_deinit(struct ice_pf *pf);
+void ice_health_clear(struct ice_pf *pf);
+
+void ice_prep_tx_hang_report(struct ice_pf *pf, struct ice_tx_ring *tx_ring,
+			     u16 vsi_num, u32 head, u32 intr);
+void ice_report_tx_hang(struct ice_pf *pf);
+
+#endif /* _HEALTH_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 2f5d6f974185..71e05d30f0fd 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -78,6 +78,7 @@
 #include "ice_irq.h"
 #include "ice_dpll.h"
 #include "ice_adapter.h"
+#include "devlink/health.h"
 
 #define ICE_BAR0		0
 #define ICE_REQ_DESC_MULTIPLE	32
@@ -665,6 +666,7 @@ struct ice_pf {
 	struct ice_agg_node vf_agg_node[ICE_MAX_VF_AGG_NODES];
 	struct ice_dplls dplls;
 	struct device *hwmon_dev;
+	struct ice_health health_reporters;
 
 	u8 num_quanta_prof_used;
 };
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d641dd8b8184..316f5109bd3f 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2364,9 +2364,11 @@ static void ice_service_task(struct work_struct *work)
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
@@ -5087,6 +5089,7 @@ static int ice_init_devlink(struct ice_pf *pf)
 		return err;
 
 	ice_devlink_init_regions(pf);
+	ice_health_init(pf);
 	ice_devlink_register(pf);
 
 	return 0;
@@ -5095,6 +5098,7 @@ static int ice_init_devlink(struct ice_pf *pf)
 static void ice_deinit_devlink(struct ice_pf *pf)
 {
 	ice_devlink_unregister(pf);
+	ice_health_deinit(pf);
 	ice_devlink_destroy_regions(pf);
 	ice_devlink_unregister_params(pf);
 }
@@ -7793,6 +7797,8 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 	/* if we get here, reset flow is successful */
 	clear_bit(ICE_RESET_FAILED, pf->state);
 
+	ice_health_clear(pf);
+
 	ice_plug_aux_dev(pf);
 	if (ice_is_feature_supported(pf, ICE_F_SRIOV_LAG))
 		ice_lag_rebuild(pf);
@@ -8283,16 +8289,18 @@ void ice_tx_timeout(struct net_device *netdev, unsigned int txqueue)
 
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
2.47.1


