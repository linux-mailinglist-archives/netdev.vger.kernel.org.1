Return-Path: <netdev+bounces-187407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B76DAA6FF9
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 12:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A68B7A41D4
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 10:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D7322B5B5;
	Fri,  2 May 2025 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cKnfz23L"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5161A4A32;
	Fri,  2 May 2025 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746182591; cv=none; b=VmoNgxpLzwau0+pZMzPheZHjL2jPUTbQMEcmWUfcG656g7gjp0ZywWdIzQKWj20tf0VesbdVDQqhjNhLD3JFeIbxqhayhwvY3zTeyiVtzqg86oTKrdCvpRyvaiIYCzN1occ1fsSxfVmLLYdJaL9kQaNYdZ86Ke1UCFpRaKB8YTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746182591; c=relaxed/simple;
	bh=qtO1RuDFwkqXM/+VfM5kxiNfohKkRiAK3/qhMuYz0pA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uu7M+ndJ3OzdjOD4p6JBHoNVFvP0UYnxWS5pQNq9gK1cCkLB0JOr3cqQNGEmBTcvAeuE2/P1F81rqX12ooK8J+ET+x4zTQK6J+DOWCDx9YXrKRjccqwaSNd7ydS6xlDzUnwiw54vq8Cf/Vu+hrZbBADf+UmoYtw4b6OLbUwPUtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=cKnfz23L; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 542AgeOC214681
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 May 2025 05:42:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1746182560;
	bh=wQh1bPD4GMQ0stSLy4ldW5E9OVnfmoitz2LlprhCPpw=;
	h=From:To:CC:Subject:Date;
	b=cKnfz23L1PqEjFR8JelVwYoimiKMbxZ3q1XMgYPdd1t2CUlMpZAHI4YwpHAamHQeU
	 4hz+ZWJDiK/vp2RkxwzHWer3ssKLvinHQA448KWseJhYyvsvMV1xhl6tC4erGxofpK
	 TNUwL5hOY9tqoIBj7D7hZX59VnximbeclqluIYdw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 542AgeoH012852
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 2 May 2025 05:42:40 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 2
 May 2025 05:42:39 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 2 May 2025 05:42:39 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 542AgdaT112250;
	Fri, 2 May 2025 05:42:39 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 542AgcqD004444;
	Fri, 2 May 2025 05:42:39 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Meghana Malladi <m-malladi@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Simon Horman <horms@kernel.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Roger Quadros <rogerq@kernel.org>,
        MD
 Danish Anwar <danishanwar@ti.com>, Paolo Abeni <pabeni@redhat.com>,
        Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Roger Quadros <rogerq@ti.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: [PATCH net-next v10] net: ti: icssg-prueth: add TAPRIO offload support
Date: Fri, 2 May 2025 16:12:35 +0530
Message-ID: <20250502104235.492896-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Roger Quadros <rogerq@ti.com>

The Time-Aware Shaper (TAS) is a key feature of the Enhanced Scheduled
Traffic (EST) mechanism defined in IEEE 802.1Q-2018. This patch adds TAS
support for the ICSSG driver by interacting with the ICSSG firmware to
manage gate control lists, cycle times, and other TAS parameters.

The firmware maintains active and shadow lists. The driver updates the
operating list using API `tas_update_oper_list()` which,
- Updates firmware list pointers via `tas_update_fw_list_pointers`.
- Writes gate masks, window end times, and clears unused entries in the
  shadow list.
- Updates gate close times and Max SDU values for each queue.
- Triggers list changes using `tas_set_trigger_list_change`, which
  - Computes cycle count (base-time % cycle-time) and extend (base-time %
    cycle-time)
  - Writes cycle time, cycle count, and extend values to firmware memory.
  - base-time being in past or base-time not being a multiple of
    cycle-time is taken care by the firmware. Driver just writes these
    variable for firmware and firmware takes care of the scheduling.
  - If base-time is not a multiple of cycle-time, the value of extend
    (base-time % cycle-time) is used by the firmware to extend the last
    cycle.
  - Sets `config_change` and `config_pending` flags to notify firmware of
    the new shadow list and its readiness for activation.
  - Sends the `ICSSG_EMAC_PORT_TAS_TRIGGER` r30 command to ask firmware to
    swap active and shadow lists.
- Waits for the firmware to clear the `config_change` flag before
  completing the update and returning successfully.

This implementation ensures seamless TAS functionality by offloading
scheduling complexities to the firmware.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
v9 - v10:
There has been significant changes since v9. I have tried to address all
the comments given by Vladimir Oltean <vladimir.oltean@nxp.com> on v9
*) Made the driver depend on NET_SCH_TAPRIO || NET_SCH_TAPRIO=n for TAS
*) Used MACRO for max sdu size instead of magic number
*) Kept `tas->state = state` outside of the switch case in `tas_set_state`
*) Implemented TC_QUERY_CAPS case in `icssg_qos_ndo_setup_tc`
*) Calling `tas_update_fw_list_pointers` only once in
   `tas_update_oper_list` as the second call as unnecessary.
*) Moved the check for TAS_MAX_CYCLE_TIME to beginning of
   `emac_taprio_replace`
*) Added `__packed` to structures in `icssg_qos.h`
*) Modified implementation of `tas_set_trigger_list_change` to handle
   cases where base-time isn't a multiple of cycle-time. For this a new
   variable extend has to be calculated as base-time % cycle-time. This
   variable is used by firmware to extend the last cycle.
*) The API prueth_iep_gettime() and prueth_iep_settime() also needs to be
   adjusted according to the cycle time extension. These changes are also
   taken care in this patch.

v9 https://lore.kernel.org/all/20240531044512.981587-3-danishanwar@ti.com/

 drivers/net/ethernet/ti/Kconfig               |   1 +
 drivers/net/ethernet/ti/Makefile              |   2 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |   7 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   2 +
 drivers/net/ethernet/ti/icssg/icssg_qos.c     | 310 ++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_qos.h     | 112 +++++++
 .../net/ethernet/ti/icssg/icssg_switch_map.h  |   6 +
 7 files changed, 439 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index a07c910c497a..a69a2220b20e 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -192,6 +192,7 @@ config TI_ICSSG_PRUETH
 	depends on NET_SWITCHDEV
 	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
 	depends on PTP_1588_CLOCK_OPTIONAL
+	depends on NET_SCH_TAPRIO || NET_SCH_TAPRIO=n
 	help
 	  Support dual Gigabit Ethernet ports over the ICSSG PRU Subsystem.
 	  This subsystem is available starting with the AM65 platform.
diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index cbcf44806924..d0ff793a8639 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -32,7 +32,7 @@ ti-am65-cpsw-nuss-$(CONFIG_TI_K3_AM65_CPSW_SWITCHDEV) += am65-cpsw-switchdev.o
 obj-$(CONFIG_TI_K3_AM65_CPTS) += am65-cpts.o
 
 obj-$(CONFIG_TI_ICSSG_PRUETH) += icssg-prueth.o icssg.o
-icssg-prueth-y := icssg/icssg_prueth.o icssg/icssg_switchdev.o
+icssg-prueth-y := icssg/icssg_prueth.o icssg/icssg_switchdev.o icssg/icssg_qos.o
 
 obj-$(CONFIG_TI_ICSSG_PRUETH_SR1) += icssg-prueth-sr1.o icssg.o
 icssg-prueth-sr1-y := icssg/icssg_prueth_sr1.o
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 443f90fa6557..a6f3e0f797a6 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -453,6 +453,7 @@ static u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *
 
 	ts = ((u64)hi_rollover_count) << 23 | iepcount_hi;
 	ts = ts * (u64)IEP_DEFAULT_CYCLE_TIME_NS + iepcount_lo;
+	ts += readl(prueth->shram.va + TIMESYNC_CYCLE_EXTN_TIME);
 
 	return ts;
 }
@@ -491,6 +492,9 @@ static void prueth_iep_settime(void *clockops_data, u64 ns)
 		usleep_range(500, 1000);
 	}
 
+	/* Clear the Cycle extension adjustments */
+	writel(0, emac->dram.va + TIMESYNC_CYCLE_EXTN_TIME);
+
 	dev_err(emac->prueth->dev, "settime timeout\n");
 }
 
@@ -1160,6 +1164,7 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_vlan_rx_kill_vid = emac_ndo_vlan_rx_del_vid,
 	.ndo_bpf = emac_ndo_bpf,
 	.ndo_xdp_xmit = emac_xdp_xmit,
+	.ndo_setup_tc = icssg_qos_ndo_setup_tc,
 };
 
 static int prueth_netdev_init(struct prueth *prueth,
@@ -1297,6 +1302,8 @@ static int prueth_netdev_init(struct prueth *prueth,
 		      HRTIMER_MODE_REL_PINNED);
 	prueth->emac[mac] = emac;
 
+	icssg_qos_tas_init(ndev);
+
 	return 0;
 
 free:
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 23c465f1ce7f..b88d6ea527fa 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -41,6 +41,7 @@
 #include "icssg_config.h"
 #include "icss_iep.h"
 #include "icssg_switch_map.h"
+#include "icssg_qos.h"
 
 #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
 #define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
@@ -240,6 +241,7 @@ struct prueth_emac {
 	struct netdev_hw_addr_list vlan_mcast_list[MAX_VLAN_ID];
 	struct bpf_prog *xdp_prog;
 	struct xdp_attachment_info xdpi;
+	struct prueth_qos qos;
 };
 
 /* The buf includes headroom compatible with both skb and xdpf */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
new file mode 100644
index 000000000000..b42c896675d3
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Texas Instruments ICSSG PRUETH QoS submodule
+ * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#include <linux/printk.h>
+#include "icssg_prueth.h"
+#include "icssg_switch_map.h"
+
+static void tas_update_fw_list_pointers(struct prueth_emac *emac)
+{
+	struct tas_config *tas = &emac->qos.tas.config;
+
+	if ((readb(tas->active_list)) == TAS_LIST0) {
+		tas->fw_active_list = emac->dram.va + TAS_GATE_MASK_LIST0;
+		tas->fw_shadow_list = emac->dram.va + TAS_GATE_MASK_LIST1;
+	} else {
+		tas->fw_active_list = emac->dram.va + TAS_GATE_MASK_LIST1;
+		tas->fw_shadow_list = emac->dram.va + TAS_GATE_MASK_LIST0;
+	}
+}
+
+static void tas_update_maxsdu_table(struct prueth_emac *emac)
+{
+	struct tas_config *tas = &emac->qos.tas.config;
+	u16 __iomem *max_sdu_tbl_ptr;
+	u8 gate_idx;
+
+	max_sdu_tbl_ptr = emac->dram.va + TAS_QUEUE_MAX_SDU_LIST;
+
+	/* In the tc-taprio UAPI, a max-sdu value of 0 is special and means "no
+	 * maxSDU limit for this TX queue". The firmware doesn't treat max-sdu
+	 * value of 0 specially. As a result the driver needs to change the
+	 * max-sdu value of 0 to PRUETH_MAX_MTU so that the firmware can treat
+	 * it accordingly.
+	 */
+	for (gate_idx = 0; gate_idx < TAS_MAX_NUM_QUEUES; gate_idx++) {
+		if (!tas->max_sdu_table.max_sdu[gate_idx])
+			tas->max_sdu_table.max_sdu[gate_idx] = PRUETH_MAX_MTU;
+		writew(tas->max_sdu_table.max_sdu[gate_idx], &max_sdu_tbl_ptr[gate_idx]);
+	}
+}
+
+static void tas_reset(struct prueth_emac *emac)
+{
+	struct tas_config *tas = &emac->qos.tas.config;
+	int i;
+
+	for (i = 0; i < TAS_MAX_NUM_QUEUES; i++)
+		tas->max_sdu_table.max_sdu[i] = PRUETH_MAX_MTU;
+
+	tas_update_maxsdu_table(emac);
+
+	memset_io(tas->fw_active_list, 0, sizeof(*tas->fw_active_list));
+	memset_io(tas->fw_shadow_list, 0, sizeof(*tas->fw_shadow_list));
+}
+
+static int tas_set_state(struct prueth_emac *emac, enum tas_state state)
+{
+	struct tas_config *tas = &emac->qos.tas.config;
+	int ret;
+
+	if (tas->state == state)
+		return 0;
+
+	switch (state) {
+	case TAS_STATE_RESET:
+		tas_reset(emac);
+		ret = icssg_set_port_state(emac, ICSSG_EMAC_PORT_TAS_RESET);
+		break;
+	case TAS_STATE_ENABLE:
+		ret = icssg_set_port_state(emac, ICSSG_EMAC_PORT_TAS_ENABLE);
+		break;
+	case TAS_STATE_DISABLE:
+		ret = icssg_set_port_state(emac, ICSSG_EMAC_PORT_TAS_DISABLE);
+		break;
+	}
+
+	if (!ret)
+		tas->state = state;
+
+	return ret;
+}
+
+static int tas_set_trigger_list_change(struct prueth_emac *emac)
+{
+	struct tc_taprio_qopt_offload *admin_list = emac->qos.tas.taprio_admin;
+	struct tas_config *tas = &emac->qos.tas.config;
+	u32 change_cycle_count;
+	u32 cycle_time;
+	u64 base_time;
+	u32 extend;
+
+	/* IEP clock has a hardware errata due to which it wraps around exactly
+	 * once every taprio cycle. To compensate for that, adjust cycle time
+	 * by the wrap around time which is stored in emac->iep->def_inc
+	 */
+	cycle_time = admin_list->cycle_time - emac->iep->def_inc;
+	base_time = admin_list->base_time;
+
+	change_cycle_count = base_time / cycle_time;
+	extend = base_time % cycle_time;
+
+	writel(cycle_time, emac->dram.va + TAS_ADMIN_CYCLE_TIME);
+	writel(change_cycle_count, emac->dram.va + TAS_CONFIG_CHANGE_CYCLE_COUNT);
+	writeb(admin_list->num_entries, emac->dram.va + TAS_ADMIN_LIST_LENGTH);
+	writel(extend, emac->dram.va + TAS_CONFIG_CYCLE_EXTEND);
+
+	/* config_change cleared by f/w to ack reception of new shadow list */
+	writeb(1, &tas->config_list->config_change);
+	/* config_pending cleared by f/w when new shadow list is copied to active list */
+	writeb(1, &tas->config_list->config_pending);
+
+	return icssg_set_port_state(emac, ICSSG_EMAC_PORT_TAS_TRIGGER);
+}
+
+static int tas_update_oper_list(struct prueth_emac *emac)
+{
+	struct tc_taprio_qopt_offload *admin_list = emac->qos.tas.taprio_admin;
+	struct tas_config *tas = &emac->qos.tas.config;
+	u32 tas_acc_gate_close_time = 0;
+	u8 idx, gate_idx, val;
+	int ret;
+
+	tas_update_fw_list_pointers(emac);
+
+	for (idx = 0; idx < admin_list->num_entries; idx++) {
+		writeb(admin_list->entries[idx].gate_mask,
+		       &tas->fw_shadow_list->gate_mask_list[idx]);
+		tas_acc_gate_close_time += admin_list->entries[idx].interval;
+
+		/* extend last entry till end of cycle time */
+		if (idx == admin_list->num_entries - 1)
+			writel(admin_list->cycle_time,
+			       &tas->fw_shadow_list->win_end_time_list[idx]);
+		else
+			writel(tas_acc_gate_close_time,
+			       &tas->fw_shadow_list->win_end_time_list[idx]);
+	}
+
+	/* clear remaining entries */
+	for (idx = admin_list->num_entries; idx < TAS_MAX_CMD_LISTS; idx++) {
+		writeb(0, &tas->fw_shadow_list->gate_mask_list[idx]);
+		writel(0, &tas->fw_shadow_list->win_end_time_list[idx]);
+	}
+
+	/* update the Array of gate close time for each queue in each window */
+	for (idx = 0 ; idx < admin_list->num_entries; idx++) {
+		/* On Linux, only PRUETH_MAX_TX_QUEUES are supported per port */
+		for (gate_idx = 0; gate_idx < PRUETH_MAX_TX_QUEUES; gate_idx++) {
+			u8 gate_mask_list_idx = readb(&tas->fw_shadow_list->gate_mask_list[idx]);
+			u32 gate_close_time = 0;
+
+			if (gate_mask_list_idx & BIT(gate_idx))
+				gate_close_time = readl(&tas->fw_shadow_list->win_end_time_list[idx]);
+
+			writel(gate_close_time,
+			       &tas->fw_shadow_list->gate_close_time_list[idx][gate_idx]);
+		}
+	}
+
+	/* Update the maxsdu table for firmware */
+	tas_update_maxsdu_table(emac);
+
+	/* tell f/w to swap active & shadow list */
+	ret = tas_set_trigger_list_change(emac);
+	if (ret) {
+		netdev_err(emac->ndev, "failed to swap f/w config list: %d\n", ret);
+		return ret;
+	}
+
+	/* Wait for completion */
+	ret = readb_poll_timeout(&tas->config_list->config_change, val, !val,
+				 USEC_PER_MSEC, 10 * USEC_PER_MSEC);
+	if (ret) {
+		netdev_err(emac->ndev, "TAS list change completion time out\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int emac_taprio_replace(struct net_device *ndev,
+			       struct tc_taprio_qopt_offload *taprio)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	int ret;
+
+	if (taprio->cycle_time_extension) {
+		NL_SET_ERR_MSG_MOD(taprio->extack, "Cycle time extension not supported");
+		return -EOPNOTSUPP;
+	}
+
+	if (taprio->cycle_time > TAS_MAX_CYCLE_TIME) {
+		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "cycle_time %llu is more than max supported cycle_time",
+				       taprio->cycle_time);
+		return -EINVAL;
+	}
+
+	if (taprio->cycle_time < TAS_MIN_CYCLE_TIME) {
+		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "cycle_time %llu is less than min supported cycle_time %d",
+				       taprio->cycle_time, TAS_MIN_CYCLE_TIME);
+		return -EINVAL;
+	}
+
+	if (taprio->num_entries > TAS_MAX_CMD_LISTS) {
+		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "num_entries %lu is more than max supported entries %d",
+				       taprio->num_entries, TAS_MAX_CMD_LISTS);
+		return -EINVAL;
+	}
+
+	if (emac->qos.tas.taprio_admin)
+		taprio_offload_free(emac->qos.tas.taprio_admin);
+
+	emac->qos.tas.taprio_admin = taprio_offload_get(taprio);
+	ret = tas_update_oper_list(emac);
+	if (ret)
+		goto clear_taprio;
+
+	ret = tas_set_state(emac, TAS_STATE_ENABLE);
+	if (ret)
+		goto clear_taprio;
+
+	return 0;
+
+clear_taprio:
+	emac->qos.tas.taprio_admin = NULL;
+	taprio_offload_free(taprio);
+
+	return ret;
+}
+
+static int emac_taprio_destroy(struct net_device *ndev,
+			       struct tc_taprio_qopt_offload *taprio)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	int ret;
+
+	ret = tas_set_state(emac, TAS_STATE_DISABLE);
+	if (ret)
+		return ret;
+
+	return tas_set_state(emac, TAS_STATE_RESET);
+}
+
+static int emac_setup_taprio(struct net_device *ndev, void *type_data)
+{
+	struct tc_taprio_qopt_offload *taprio = type_data;
+	int ret;
+
+	switch (taprio->cmd) {
+	case TAPRIO_CMD_REPLACE:
+		ret = emac_taprio_replace(ndev, taprio);
+		break;
+	case TAPRIO_CMD_DESTROY:
+		ret = emac_taprio_destroy(ndev, taprio);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+	}
+
+	return ret;
+}
+
+static int emac_tc_query_caps(struct net_device *ndev, void *type_data)
+{
+	struct tc_query_caps_base *base = type_data;
+
+	switch (base->type) {
+	case TC_SETUP_QDISC_TAPRIO: {
+		struct tc_taprio_caps *caps = base->caps;
+
+		caps->gate_mask_per_txq = true;
+
+		return 0;
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			   void *type_data)
+{
+	switch (type) {
+	case TC_SETUP_QDISC_TAPRIO:
+		return emac_setup_taprio(ndev, type_data);
+	case TC_QUERY_CAPS:
+		return emac_tc_query_caps(ndev, type_data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+EXPORT_SYMBOL_GPL(icssg_qos_ndo_setup_tc);
+
+void icssg_qos_tas_init(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct tas_config *tas;
+
+	tas = &emac->qos.tas.config;
+
+	tas->config_list = emac->dram.va + TAS_CONFIG_CHANGE_TIME;
+	tas->active_list = emac->dram.va + TAS_ACTIVE_LIST_INDEX;
+
+	tas_update_fw_list_pointers(emac);
+
+	tas_set_state(emac, TAS_STATE_RESET);
+}
+EXPORT_SYMBOL_GPL(icssg_qos_tas_init);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.h b/drivers/net/ethernet/ti/icssg/icssg_qos.h
new file mode 100644
index 000000000000..60cd50c661b6
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#ifndef __NET_TI_ICSSG_QOS_H
+#define __NET_TI_ICSSG_QOS_H
+
+#include <linux/atomic.h>
+#include <linux/netdevice.h>
+#include <net/pkt_sched.h>
+
+/* Maximum number of gate command entries in each list. */
+#define TAS_MAX_CMD_LISTS   (16)
+
+/* Maximum number of transmit queues supported by implementation */
+#define TAS_MAX_NUM_QUEUES  (8)
+
+/* Minimum cycle time supported by implementation (in ns) */
+#define TAS_MIN_CYCLE_TIME  (1000000)
+
+/* Minimum cycle time supported by implementation (in ns) */
+#define TAS_MAX_CYCLE_TIME  (4000000000)
+
+/* Minimum TAS window duration supported by implementation (in ns) */
+#define TAS_MIN_WINDOW_DURATION  (10000)
+
+/**
+ * enum tas_list_num - TAS list number
+ * @TAS_LIST0: TAS list number is 0
+ * @TAS_LIST1: TAS list number is 1
+ */
+enum tas_list_num {
+	TAS_LIST0 = 0,
+	TAS_LIST1 = 1
+};
+
+/**
+ * enum tas_state - State of TAS in firmware
+ * @TAS_STATE_DISABLE: TAS state machine is disabled.
+ * @TAS_STATE_ENABLE: TAS state machine is enabled.
+ * @TAS_STATE_RESET: TAS state machine is reset.
+ */
+enum tas_state {
+	TAS_STATE_DISABLE = 0,
+	TAS_STATE_ENABLE = 1,
+	TAS_STATE_RESET = 2,
+};
+
+/**
+ * struct tas_config_list - Config state machine variables
+ * @config_change_time: New list is copied at this time
+ * @config_change_error_counter: Incremented if admin->BaseTime < current time
+ *				 and TAS_enabled is true
+ * @config_pending: True if list update is pending
+ * @config_change: Set to true when application trigger updating of admin list
+ *		   to active list, cleared when configChangeTime is updated
+ */
+struct tas_config_list {
+	u64 config_change_time;
+	u32 config_change_error_counter;
+	u8 config_pending;
+	u8 config_change;
+} __packed;
+
+/* Max SDU table. See IEEE Std 802.1Q-2018 12.29.1.1 */
+struct tas_max_sdu_table {
+	u16 max_sdu[TAS_MAX_NUM_QUEUES];
+};
+
+/**
+ * struct tas_firmware_list - TAS List Structure based on firmware memory map
+ * @gate_mask_list: Window gate mask list
+ * @win_end_time_list: Window end time list
+ * @gate_close_time_list: Array of gate close time for each queue in each window
+ */
+struct tas_firmware_list {
+	u8 gate_mask_list[TAS_MAX_CMD_LISTS];
+	u32 win_end_time_list[TAS_MAX_CMD_LISTS];
+	u32 gate_close_time_list[TAS_MAX_CMD_LISTS][TAS_MAX_NUM_QUEUES];
+} __packed;
+
+/**
+ * struct tas_config - Main Time Aware Shaper Handle
+ * @state: TAS state
+ * @max_sdu_table: Max SDU table
+ * @config_list: Config change variables
+ * @active_list: Current operating list operating list
+ * @fw_active_list: Active List pointer, used by firmware
+ * @fw_shadow_list: Shadow List pointer, used by driver
+ */
+struct tas_config {
+	enum tas_state state;
+	struct tas_max_sdu_table max_sdu_table;
+	struct tas_config_list __iomem *config_list;
+	u8 __iomem *active_list;
+	struct tas_firmware_list __iomem *fw_active_list;
+	struct tas_firmware_list __iomem *fw_shadow_list;
+};
+
+struct prueth_qos_tas {
+	struct tc_taprio_qopt_offload *taprio_admin;
+	struct tas_config config;
+};
+
+struct prueth_qos {
+	struct prueth_qos_tas tas;
+};
+
+void icssg_qos_tas_init(struct net_device *ndev);
+int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			   void *type_data);
+#endif /* __NET_TI_ICSSG_QOS_H */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
index 490a9cc06fb0..e659a66bb7d7 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
@@ -46,6 +46,9 @@
 /* Same as P2_PORT_DF_VLAN_OFFSET */
 #define EMAC_ICSSG_SWITCH_PORT2_DEFAULT_VLAN_OFFSET        P2_PORT_DF_VLAN_OFFSET
 
+/* Time adjustment to be done due to Cycle extension */
+#define TIMESYNC_CYCLE_EXTN_TIME                           0x0028
+
 /* VLAN-FID Table offset. 4096 VIDs. 2B per VID = 8KB = 0x2000 */
 #define VLAN_STATIC_REG_TABLE_OFFSET                       0x0100
 
@@ -177,6 +180,9 @@
 /* Stores the table used for priority mapping. 1B per PCP/Queue */
 #define PORT_Q_PRIORITY_MAPPING_OFFSET                     0x003C
 
+/* Memory to store time value to be used for Cycle extension */
+#define TAS_CONFIG_CYCLE_EXTEND				   0x00A4
+
 /* Used to notify the FW of the current link speed */
 #define PORT_LINK_SPEED_OFFSET                             0x00A8
 

base-commit: 630cb33ccfcd04563598d0f0edd96c94ddf3352d
-- 
2.34.1


