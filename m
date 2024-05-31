Return-Path: <netdev+bounces-99642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6435D8D5995
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 06:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F601C238C6
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 04:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF547C6CE;
	Fri, 31 May 2024 04:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iEX+JPJo"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3871524B4A;
	Fri, 31 May 2024 04:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717130750; cv=none; b=g5Te0g+6dcc2mLrz5jqqoXRfuCKB6GBpLDR19Voan/rxzmxAV6FAawEe3E+9OGIlNprU3cWZ1+/JoB3e5iu8a8+AProGvWFrjtkihAbGvIuWg22Myz2Zsf6sxXL7V8SAb0IOuWZmy/Ag+aWClxHsnfGwv9TSOb37bMgQZWu1J70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717130750; c=relaxed/simple;
	bh=UEx++riayLOMykd0Zhic5jPFq1PvkRZSQHcZYqCA+2o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1H/0m0+mWE8Z5SAN0YXvxmVH7ys3E1VlvTqawbFVadyzaEytkqCzrKCjHEVsXSqgOJQLqnxY5QYJGY1aGU/f7tvxsbFlyQ2NFLvfsrwRJB/QJIOPT6GYSyGUJuwKUfRl/hWxhm6MDsMAwZrjDSsM1jGANpFdK5KVl5EF89RBYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iEX+JPJo; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44V4jLBh120365;
	Thu, 30 May 2024 23:45:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717130721;
	bh=T5Pg7iY8dxrt+YpDQSkVBpMRNzVCOYFJERFwd2F7sFM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=iEX+JPJoT0wu/FAzJPlJAZ2isBP7TJjcJZ1joiH4gEw9KCk9dicQ0Yyyp8VwA8EtV
	 6loT73PLOzJXeKVOsrcpcPfqbMzbLMrc7oAArI0AU0MlR4tW3Ze0Mt1rz33LxPyJM7
	 s7Ws4dy4mxc4tSDFAnZu000PlfUMji2XIf1x9CTc=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44V4jLXo062280
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 May 2024 23:45:21 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 May 2024 23:45:20 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 May 2024 23:45:20 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44V4jKUx035772;
	Thu, 30 May 2024 23:45:20 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 44V4jJp8023398;
	Thu, 30 May 2024 23:45:20 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>, Simon Horman
	<horms@kernel.org>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Wolfram Sang
	<wsa+renesas@sang-engineering.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Vladimir Oltean
	<vladimir.oltean@nxp.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard
 Cochran <richardcochran@gmail.com>,
        Roger Quadros <rogerq@kernel.org>,
        MD
 Danish Anwar <danishanwar@ti.com>, Paolo Abeni <pabeni@redhat.com>,
        Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Jacob Keller
	<jacob.e.keller@intel.com>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH net-next v9 2/2] net: ti: icssg_prueth: add TAPRIO offload support
Date: Fri, 31 May 2024 10:15:12 +0530
Message-ID: <20240531044512.981587-3-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531044512.981587-1-danishanwar@ti.com>
References: <20240531044512.981587-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Roger Quadros <rogerq@ti.com>

The ICSSG dual-emac / switch firmware supports Enhanced Scheduled Traffic
(EST – defined in P802.1Qbv/D2.2 that later got included in IEEE
802.1Q-2018) configuration. EST allows express queue traffic to be
scheduled (placed) on the wire at specific repeatable time intervals. In
Linux kernel, EST configuration is done through tc command and the taprio
scheduler in the net core implements a software only scheduler
(SCH_TAPRIO). If the NIC is capable of EST configuration,user indicate
"flag 2" in the command which is then parsed by taprio scheduler in net
core and indicate that the command is to be offloaded to h/w. taprio then
offloads the command to the driver by calling ndo_setup_tc() ndo ops. This
patch implements ndo_setup_tc() to offload EST configuration to ICSSG.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/Kconfig              |   1 +
 drivers/net/ethernet/ti/Makefile             |   1 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c |   3 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |   2 +
 drivers/net/ethernet/ti/icssg/icssg_qos.c    | 288 +++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_qos.h    | 113 ++++++++
 6 files changed, 408 insertions(+)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index f160a3b71499..6deac9035610 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -190,6 +190,7 @@ config TI_ICSSG_PRUETH
 	depends on PRU_REMOTEPROC
 	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
 	depends on PTP_1588_CLOCK_OPTIONAL
+	depends on NET_SCH_TAPRIO
 	help
 	  Support dual Gigabit Ethernet ports over the ICSSG PRU Subsystem.
 	  This subsystem is available starting with the AM65 platform.
diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 59cd20a38267..0a86311bd170 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_TI_ICSSG_PRUETH) += icssg-prueth.o
 icssg-prueth-y := icssg/icssg_prueth.o \
 		  icssg/icssg_common.o \
 		  icssg/icssg_classifier.o \
+		  icssg/icssg_qos.o \
 		  icssg/icssg_queues.o \
 		  icssg/icssg_config.o \
 		  icssg/icssg_mii_cfg.o \
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index d159bdf7dd9d..8982ecb8a43d 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -706,6 +706,7 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_eth_ioctl = emac_ndo_ioctl,
 	.ndo_get_stats64 = emac_ndo_get_stats64,
 	.ndo_get_phys_port_name = emac_ndo_get_phys_port_name,
+	.ndo_setup_tc = icssg_qos_ndo_setup_tc,
 };
 
 static int prueth_netdev_init(struct prueth *prueth,
@@ -840,6 +841,8 @@ static int prueth_netdev_init(struct prueth *prueth,
 	emac->rx_hrtimer.function = &emac_rx_timer_callback;
 	prueth->emac[mac] = emac;
 
+	icssg_qos_tas_init(ndev);
+
 	return 0;
 
 free:
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index fab2428de78b..c6851546e6c5 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -37,6 +37,7 @@
 #include "icssg_config.h"
 #include "icss_iep.h"
 #include "icssg_switch_map.h"
+#include "icssg_qos.h"
 
 #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
 #define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
@@ -195,6 +196,7 @@ struct prueth_emac {
 	/* RX IRQ Coalescing Related */
 	struct hrtimer rx_hrtimer;
 	unsigned long rx_pace_timeout_ns;
+	struct prueth_qos qos;
 };
 
 /**
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
new file mode 100644
index 000000000000..5e93b1b9ca43
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
@@ -0,0 +1,288 @@
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
+	/* update the maxsdu table */
+	max_sdu_tbl_ptr = emac->dram.va + TAS_QUEUE_MAX_SDU_LIST;
+
+	for (gate_idx = 0; gate_idx < TAS_MAX_NUM_QUEUES; gate_idx++)
+		writew(tas->max_sdu_table.max_sdu[gate_idx], &max_sdu_tbl_ptr[gate_idx]);
+}
+
+static void tas_reset(struct prueth_emac *emac)
+{
+	struct tas_config *tas = &emac->qos.tas.config;
+	int i;
+
+	for (i = 0; i < TAS_MAX_NUM_QUEUES; i++)
+		tas->max_sdu_table.max_sdu[i] = 2048;
+
+	tas_update_maxsdu_table(emac);
+
+	writeb(TAS_LIST0, tas->active_list);
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
+		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_RESET);
+		tas->state = TAS_STATE_RESET;
+		break;
+	case TAS_STATE_ENABLE:
+		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_ENABLE);
+		tas->state = TAS_STATE_ENABLE;
+		break;
+	case TAS_STATE_DISABLE:
+		ret = emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_DISABLE);
+		tas->state = TAS_STATE_DISABLE;
+		break;
+	default:
+		netdev_err(emac->ndev, "%s: unsupported state\n", __func__);
+		ret = -EINVAL;
+		break;
+	}
+
+	if (ret)
+		netdev_err(emac->ndev, "TAS set state failed %d\n", ret);
+	return ret;
+}
+
+static int tas_set_trigger_list_change(struct prueth_emac *emac)
+{
+	struct tc_taprio_qopt_offload *admin_list = emac->qos.tas.taprio_admin;
+	struct tas_config *tas = &emac->qos.tas.config;
+	struct ptp_system_timestamp sts;
+	u32 change_cycle_count;
+	u32 cycle_time;
+	u64 base_time;
+	u64 cur_time;
+
+	/* IEP clock has a hardware errata due to which it wraps around exactly
+	 * once every taprio cycle. To compensate for that, adjust cycle time
+	 * by the wrap around time which is stored in emac->iep->def_inc
+	 */
+	cycle_time = admin_list->cycle_time - emac->iep->def_inc;
+	base_time = admin_list->base_time;
+	cur_time = prueth_iep_gettime(emac, &sts);
+
+	if (base_time > cur_time)
+		change_cycle_count = DIV_ROUND_UP_ULL(base_time - cur_time, cycle_time);
+	else
+		change_cycle_count = 1;
+
+	writel(cycle_time, emac->dram.va + TAS_ADMIN_CYCLE_TIME);
+	writel(change_cycle_count, emac->dram.va + TAS_CONFIG_CHANGE_CYCLE_COUNT);
+	writeb(admin_list->num_entries, emac->dram.va + TAS_ADMIN_LIST_LENGTH);
+
+	/* config_change cleared by f/w to ack reception of new shadow list */
+	writeb(1, &tas->config_list->config_change);
+	/* config_pending cleared by f/w when new shadow list is copied to active list */
+	writeb(1, &tas->config_list->config_pending);
+
+	return emac_set_port_state(emac, ICSSG_EMAC_PORT_TAS_TRIGGER);
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
+	if (admin_list->cycle_time > TAS_MAX_CYCLE_TIME)
+		return -EINVAL;
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
+	tas_update_fw_list_pointers(emac);
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
+	taprio_offload_free(taprio);
+
+	ret = tas_set_state(emac, TAS_STATE_RESET);
+	if (ret)
+		return ret;
+
+	return tas_set_state(emac, TAS_STATE_DISABLE);
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
+int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			   void *type_data)
+{
+	switch (type) {
+	case TC_SETUP_QDISC_TAPRIO:
+		return emac_setup_taprio(ndev, type_data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
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
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.h b/drivers/net/ethernet/ti/icssg/icssg_qos.h
new file mode 100644
index 000000000000..25baccdd1ce5
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.h
@@ -0,0 +1,113 @@
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
+};
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
+};
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
+	struct tc_taprio_qopt_offload *taprio_oper;
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
-- 
2.34.1


