Return-Path: <netdev+bounces-149266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4AD9E4FA0
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE7C1881976
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 08:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D829B1D0F46;
	Thu,  5 Dec 2024 08:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gsgw9AYZ"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF29239195;
	Thu,  5 Dec 2024 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733387131; cv=none; b=PQhc4KxlH6X8+HsJSXR1QjRB0mcLhJbl8kcBk0l43I9jetWvfJTpzwNBtPGcpj6+LEvlM2AsAojAA7vjtgMyjp+NzP+5qaDfn4+KxSt0EE/cagm/Zllv5w46TZ+IeaNrprXylkb7tR+zbAShLg6ok1MI6bSXwLXRWZQldnRN/Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733387131; c=relaxed/simple;
	bh=UB+b3HkY7tifPzbpWPejS0qY1zMz5EW7hIAejS1ii+Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WTJgdNVNhe9Wh/miCN12pwfQD7BmatyWxFr+6G4khbWisVnBcN6IU9hA84tBrA8R+8zUbKhO3HOWAGmQFzgi1xzNVY1m3MNhPBEoEcjjkQdG7SalJVdDH4aKeE30vbpSmeLOHJmY1BddhgAxP1STSaFsp0ynUZ/8cHi8a+I0tSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gsgw9AYZ; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4B58OvWX099638;
	Thu, 5 Dec 2024 02:24:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733387097;
	bh=pXDvVNsg4PZb1MJTvUXZ2QeIcEK/AdpqKjhTHsLxNbY=;
	h=From:To:CC:Subject:Date;
	b=gsgw9AYZLypexEN9EiUYulwWATXfv3DrsOdbkY8J97H/b0WwWbZ2SXwAqrteFggUl
	 KxphvQj/AGm9YmoWjK9DULnYYyiBfT3YRAtxLX5R9Zet+oWiGPxPpluD4BBSnDgE6c
	 lNJH2cvAYTpo4utd/pdah96D6fSUjRzea4y7ysNQ=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B58Ov1C103734
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Dec 2024 02:24:57 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 5
 Dec 2024 02:24:57 -0600
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 5 Dec 2024 02:24:57 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B58OvZW070817;
	Thu, 5 Dec 2024 02:24:57 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4B58OuuT021296;
	Thu, 5 Dec 2024 02:24:56 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <vigneshr@ti.com>, <m-malladi@ti.com>, Roger Quadros <rogerq@kernel.org>,
        <javier.carrasco.cruz@gmail.com>, <diogo.ivo@siemens.com>,
        <horms@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <danishanwar@ti.com>
Subject: [PATCH net v3 1/2] net: ti: icssg-prueth: Fix firmware load sequence.
Date: Thu, 5 Dec 2024 13:54:46 +0530
Message-ID: <20241205082447.777463-1-m-malladi@ti.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: MD Danish Anwar <danishanwar@ti.com>

Timesync related operations are ran in PRU0 cores for both ICSSG SLICE0
and SLICE1. Currently whenever any ICSSG interface comes up we load the
respective firmwares to PRU cores and whenever interface goes down, we
stop the resective cores. Due to this, when SLICE0 goes down while
SLICE1 is still active, PRU0 firmwares are unloaded and PRU0 core is
stopped. This results in clock jump for SLICE1 interface as the timesync
related operations are no longer running.

As there are interdependencies between SLICE0 and SLICE1 firmwares,
fix this by running both PRU0 and PRU1 firmwares as long as at least 1
ICSSG interface is up. Add new flag in prueth struct to check if all
firmwares are running.

Use emacs_initialized as reference count to load the firmwares for the
first and last interface up/down. Moving init_emac_mode and fw_offload_mode
API outside of icssg_config to icssg_common_start API as they need
to be called only once per firmware boot.

Fixes: c1e0230eeaab ("net: ti: icss-iep: Add IEP driver")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

Hi all,

This patch is based on net-next tagged next-20241128.
v2:https://lore.kernel.org/all/20241128122931.2494446-2-m-malladi@ti.com/

* Changes since v2 (v3-v2):
- error handling in caller function of prueth_emac_common_start()
- Use prus_running flag check before stopping the firmwares
Both suggested by Roger Quadros <rogerq@kernel.org>

 drivers/net/ethernet/ti/icssg/icssg_config.c |  45 ++++--
 drivers/net/ethernet/ti/icssg/icssg_config.h |   1 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 157 ++++++++++++-------
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |   5 +
 4 files changed, 140 insertions(+), 68 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
index 5d2491c2943a..342150756cf7 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
@@ -397,7 +397,7 @@ static int prueth_emac_buffer_setup(struct prueth_emac *emac)
 	return 0;
 }
 
-static void icssg_init_emac_mode(struct prueth *prueth)
+void icssg_init_emac_mode(struct prueth *prueth)
 {
 	/* When the device is configured as a bridge and it is being brought
 	 * back to the emac mode, the host mac address has to be set as 0.
@@ -406,9 +406,6 @@ static void icssg_init_emac_mode(struct prueth *prueth)
 	int i;
 	u8 mac[ETH_ALEN] = { 0 };
 
-	if (prueth->emacs_initialized)
-		return;
-
 	/* Set VLAN TABLE address base */
 	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1, SMEM_VLAN_OFFSET_MASK,
 			   addr <<  SMEM_VLAN_OFFSET);
@@ -423,15 +420,13 @@ static void icssg_init_emac_mode(struct prueth *prueth)
 	/* Clear host MAC address */
 	icssg_class_set_host_mac_addr(prueth->miig_rt, mac);
 }
+EXPORT_SYMBOL_GPL(icssg_init_emac_mode);
 
-static void icssg_init_fw_offload_mode(struct prueth *prueth)
+void icssg_init_fw_offload_mode(struct prueth *prueth)
 {
 	u32 addr = prueth->shram.pa + EMAC_ICSSG_SWITCH_DEFAULT_VLAN_TABLE_OFFSET;
 	int i;
 
-	if (prueth->emacs_initialized)
-		return;
-
 	/* Set VLAN TABLE address base */
 	regmap_update_bits(prueth->miig_rt, FDB_GEN_CFG1, SMEM_VLAN_OFFSET_MASK,
 			   addr <<  SMEM_VLAN_OFFSET);
@@ -448,6 +443,7 @@ static void icssg_init_fw_offload_mode(struct prueth *prueth)
 		icssg_class_set_host_mac_addr(prueth->miig_rt, prueth->hw_bridge_dev->dev_addr);
 	icssg_set_pvid(prueth, prueth->default_vlan, PRUETH_PORT_HOST);
 }
+EXPORT_SYMBOL_GPL(icssg_init_fw_offload_mode);
 
 int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
 {
@@ -455,11 +451,6 @@ int icssg_config(struct prueth *prueth, struct prueth_emac *emac, int slice)
 	struct icssg_flow_cfg __iomem *flow_cfg;
 	int ret;
 
-	if (prueth->is_switch_mode || prueth->is_hsr_offload_mode)
-		icssg_init_fw_offload_mode(prueth);
-	else
-		icssg_init_emac_mode(prueth);
-
 	memset_io(config, 0, TAS_GATE_MASK_LIST0);
 	icssg_miig_queues_init(prueth, slice);
 
@@ -786,3 +777,31 @@ void icssg_set_pvid(struct prueth *prueth, u8 vid, u8 port)
 		writel(pvid, prueth->shram.va + EMAC_ICSSG_SWITCH_PORT0_DEFAULT_VLAN_OFFSET);
 }
 EXPORT_SYMBOL_GPL(icssg_set_pvid);
+
+int emac_fdb_flow_id_updated(struct prueth_emac *emac)
+{
+	struct mgmt_cmd_rsp fdb_cmd_rsp = { 0 };
+	int slice = prueth_emac_slice(emac);
+	struct mgmt_cmd fdb_cmd = { 0 };
+	int ret = 0;
+
+	fdb_cmd.header = ICSSG_FW_MGMT_CMD_HEADER;
+	fdb_cmd.type   = ICSSG_FW_MGMT_FDB_CMD_TYPE_RX_FLOW;
+	fdb_cmd.seqnum = ++(emac->prueth->icssg_hwcmdseq);
+	fdb_cmd.param  = 0;
+
+	fdb_cmd.param |= (slice << 4);
+	fdb_cmd.cmd_args[0] = 0;
+
+	ret = icssg_send_fdb_msg(emac, &fdb_cmd, &fdb_cmd_rsp);
+
+	if (ret)
+		return ret;
+
+	WARN_ON(fdb_cmd.seqnum != fdb_cmd_rsp.seqnum);
+	if (fdb_cmd_rsp.status == 1)
+		return 0;
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(emac_fdb_flow_id_updated);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
index 92c2deaa3068..c884e9fa099e 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
@@ -55,6 +55,7 @@ struct icssg_rxq_ctx {
 #define ICSSG_FW_MGMT_FDB_CMD_TYPE	0x03
 #define ICSSG_FW_MGMT_CMD_TYPE		0x04
 #define ICSSG_FW_MGMT_PKT		0x80000000
+#define ICSSG_FW_MGMT_FDB_CMD_TYPE_RX_FLOW	0x05
 
 struct icssg_r30_cmd {
 	u32 cmd[4];
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index c568c84a032b..2e22e793b01a 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -164,11 +164,11 @@ static struct icssg_firmwares icssg_emac_firmwares[] = {
 	}
 };
 
-static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
+static int prueth_emac_start(struct prueth *prueth, int slice)
 {
 	struct icssg_firmwares *firmwares;
 	struct device *dev = prueth->dev;
-	int slice, ret;
+	int ret;
 
 	if (prueth->is_switch_mode)
 		firmwares = icssg_switch_firmwares;
@@ -177,16 +177,6 @@ static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
 	else
 		firmwares = icssg_emac_firmwares;
 
-	slice = prueth_emac_slice(emac);
-	if (slice < 0) {
-		netdev_err(emac->ndev, "invalid port\n");
-		return -EINVAL;
-	}
-
-	ret = icssg_config(prueth, emac, slice);
-	if (ret)
-		return ret;
-
 	ret = rproc_set_firmware(prueth->pru[slice], firmwares[slice].pru);
 	ret = rproc_boot(prueth->pru[slice]);
 	if (ret) {
@@ -208,7 +198,6 @@ static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
 		goto halt_rtu;
 	}
 
-	emac->fw_running = 1;
 	return 0;
 
 halt_rtu:
@@ -220,6 +209,80 @@ static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
 	return ret;
 }
 
+static int prueth_emac_common_start(struct prueth *prueth)
+{
+	struct prueth_emac *emac;
+	int ret = 0;
+	int slice;
+
+	if (!prueth->emac[ICSS_SLICE0] && !prueth->emac[ICSS_SLICE1])
+		return -EINVAL;
+
+	/* clear SMEM and MSMC settings for all slices */
+	memset_io(prueth->msmcram.va, 0, prueth->msmcram.size);
+	memset_io(prueth->shram.va, 0, ICSSG_CONFIG_OFFSET_SLICE1 * PRUETH_NUM_MACS);
+
+	icssg_class_default(prueth->miig_rt, ICSS_SLICE0, 0, false);
+	icssg_class_default(prueth->miig_rt, ICSS_SLICE1, 0, false);
+
+	if (prueth->is_switch_mode || prueth->is_hsr_offload_mode)
+		icssg_init_fw_offload_mode(prueth);
+	else
+		icssg_init_emac_mode(prueth);
+
+	for (slice = 0; slice < PRUETH_NUM_MACS; slice++) {
+		emac = prueth->emac[slice];
+		if (emac) {
+			ret |= icssg_config(prueth, emac, slice);
+			if (ret)
+				return ret;
+		}
+		ret |= prueth_emac_start(prueth, slice);
+	}
+	if (!ret)
+		prueth->prus_running = 1;
+	else
+		return ret;
+
+	emac = prueth->emac[ICSS_SLICE0] ? prueth->emac[ICSS_SLICE0] :
+	       prueth->emac[ICSS_SLICE1];
+	ret = icss_iep_init(emac->iep, &prueth_iep_clockops,
+			    emac, IEP_DEFAULT_CYCLE_TIME_NS);
+	if (ret) {
+		dev_err(prueth->dev, "Failed to initialize IEP module\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int prueth_emac_common_stop(struct prueth *prueth)
+{
+	struct prueth_emac *emac;
+	int slice;
+
+	if (!prueth->emac[ICSS_SLICE0] && !prueth->emac[ICSS_SLICE1])
+		return -EINVAL;
+
+	icssg_class_disable(prueth->miig_rt, ICSS_SLICE0);
+	icssg_class_disable(prueth->miig_rt, ICSS_SLICE1);
+
+	for (slice = 0; slice < PRUETH_NUM_MACS; slice++) {
+		if (prueth->prus_running) {
+			rproc_shutdown(prueth->txpru[slice]);
+			rproc_shutdown(prueth->rtu[slice]);
+			rproc_shutdown(prueth->pru[slice]);
+		}
+	}
+	prueth->prus_running = 0;
+
+	emac = prueth->emac[ICSS_SLICE0] ? prueth->emac[ICSS_SLICE0] :
+	       prueth->emac[ICSS_SLICE1];
+	icss_iep_exit(emac->iep);
+
+	return 0;
+}
+
 /* called back by PHY layer if there is change in link state of hw port*/
 static void emac_adjust_link(struct net_device *ndev)
 {
@@ -369,12 +432,13 @@ static void prueth_iep_settime(void *clockops_data, u64 ns)
 {
 	struct icssg_setclock_desc __iomem *sc_descp;
 	struct prueth_emac *emac = clockops_data;
+	struct prueth *prueth = emac->prueth;
 	struct icssg_setclock_desc sc_desc;
 	u64 cyclecount;
 	u32 cycletime;
 	int timeout;
 
-	if (!emac->fw_running)
+	if (!prueth->prus_running)
 		return;
 
 	sc_descp = emac->prueth->shram.va + TIMESYNC_FW_WC_SETCLOCK_DESC_OFFSET;
@@ -543,23 +607,17 @@ static int emac_ndo_open(struct net_device *ndev)
 {
 	struct prueth_emac *emac = netdev_priv(ndev);
 	int ret, i, num_data_chn = emac->tx_ch_num;
+	struct icssg_flow_cfg __iomem *flow_cfg;
 	struct prueth *prueth = emac->prueth;
 	int slice = prueth_emac_slice(emac);
 	struct device *dev = prueth->dev;
 	int max_rx_flows;
 	int rx_flow;
 
-	/* clear SMEM and MSMC settings for all slices */
-	if (!prueth->emacs_initialized) {
-		memset_io(prueth->msmcram.va, 0, prueth->msmcram.size);
-		memset_io(prueth->shram.va, 0, ICSSG_CONFIG_OFFSET_SLICE1 * PRUETH_NUM_MACS);
-	}
-
 	/* set h/w MAC as user might have re-configured */
 	ether_addr_copy(emac->mac_addr, ndev->dev_addr);
 
 	icssg_class_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
-	icssg_class_default(prueth->miig_rt, slice, 0, false);
 	icssg_ft1_set_mac_addr(prueth->miig_rt, slice, emac->mac_addr);
 
 	/* Notify the stack of the actual queue counts. */
@@ -597,18 +655,23 @@ static int emac_ndo_open(struct net_device *ndev)
 		goto cleanup_napi;
 	}
 
-	/* reset and start PRU firmware */
-	ret = prueth_emac_start(prueth, emac);
-	if (ret)
-		goto free_rx_irq;
+	if (!prueth->emacs_initialized) {
+		ret = prueth_emac_common_start(prueth);
+		if (ret)
+			goto stop;
+	}
 
-	icssg_mii_update_mtu(prueth->mii_rt, slice, ndev->max_mtu);
+	flow_cfg = emac->dram.va + ICSSG_CONFIG_OFFSET + PSI_L_REGULAR_FLOW_ID_BASE_OFFSET;
+	writew(emac->rx_flow_id_base, &flow_cfg->rx_base_flow);
+	ret = emac_fdb_flow_id_updated(emac);
 
-	if (!prueth->emacs_initialized) {
-		ret = icss_iep_init(emac->iep, &prueth_iep_clockops,
-				    emac, IEP_DEFAULT_CYCLE_TIME_NS);
+	if (ret) {
+		netdev_err(ndev, "Failed to update Rx Flow ID %d", ret);
+		goto stop;
 	}
 
+	icssg_mii_update_mtu(prueth->mii_rt, slice, ndev->max_mtu);
+
 	ret = request_threaded_irq(emac->tx_ts_irq, NULL, prueth_tx_ts_irq,
 				   IRQF_ONESHOT, dev_name(dev), emac);
 	if (ret)
@@ -653,8 +716,7 @@ static int emac_ndo_open(struct net_device *ndev)
 free_tx_ts_irq:
 	free_irq(emac->tx_ts_irq, emac);
 stop:
-	prueth_emac_stop(emac);
-free_rx_irq:
+	prueth_emac_common_stop(prueth);
 	free_irq(emac->rx_chns.irq[rx_flow], emac);
 cleanup_napi:
 	prueth_ndev_del_tx_napi(emac, emac->tx_ch_num);
@@ -689,8 +751,6 @@ static int emac_ndo_stop(struct net_device *ndev)
 	if (ndev->phydev)
 		phy_stop(ndev->phydev);
 
-	icssg_class_disable(prueth->miig_rt, prueth_emac_slice(emac));
-
 	if (emac->prueth->is_hsr_offload_mode)
 		__dev_mc_unsync(ndev, icssg_prueth_hsr_del_mcast);
 	else
@@ -728,11 +788,9 @@ static int emac_ndo_stop(struct net_device *ndev)
 	/* Destroying the queued work in ndo_stop() */
 	cancel_delayed_work_sync(&emac->stats_work);
 
-	if (prueth->emacs_initialized == 1)
-		icss_iep_exit(emac->iep);
-
 	/* stop PRUs */
-	prueth_emac_stop(emac);
+	if (prueth->emacs_initialized == 1)
+		prueth_emac_common_stop(prueth);
 
 	free_irq(emac->tx_ts_irq, emac);
 
@@ -1069,16 +1127,10 @@ static void prueth_emac_restart(struct prueth *prueth)
 	icssg_set_port_state(emac1, ICSSG_EMAC_PORT_DISABLE);
 
 	/* Stop both pru cores for both PRUeth ports*/
-	prueth_emac_stop(emac0);
-	prueth->emacs_initialized--;
-	prueth_emac_stop(emac1);
-	prueth->emacs_initialized--;
+	prueth_emac_common_stop(prueth);
 
 	/* Start both pru cores for both PRUeth ports */
-	prueth_emac_start(prueth, emac0);
-	prueth->emacs_initialized++;
-	prueth_emac_start(prueth, emac1);
-	prueth->emacs_initialized++;
+	prueth_emac_common_start(prueth);
 
 	/* Enable forwarding for both PRUeth ports */
 	icssg_set_port_state(emac0, ICSSG_EMAC_PORT_FORWARD);
@@ -1413,13 +1465,10 @@ static int prueth_probe(struct platform_device *pdev)
 		prueth->pa_stats = NULL;
 	}
 
-	if (eth0_node) {
+	if (eth0_node || eth1_node) {
 		ret = prueth_get_cores(prueth, ICSS_SLICE0, false);
 		if (ret)
 			goto put_cores;
-	}
-
-	if (eth1_node) {
 		ret = prueth_get_cores(prueth, ICSS_SLICE1, false);
 		if (ret)
 			goto put_cores;
@@ -1618,14 +1667,12 @@ static int prueth_probe(struct platform_device *pdev)
 	pruss_put(prueth->pruss);
 
 put_cores:
-	if (eth1_node) {
-		prueth_put_cores(prueth, ICSS_SLICE1);
-		of_node_put(eth1_node);
-	}
-
-	if (eth0_node) {
+	if (eth0_node || eth1_node) {
 		prueth_put_cores(prueth, ICSS_SLICE0);
 		of_node_put(eth0_node);
+
+		prueth_put_cores(prueth, ICSS_SLICE1);
+		of_node_put(eth1_node);
 	}
 
 	return ret;
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index f5c1d473e9f9..b30f2e9a73d8 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -257,6 +257,7 @@ struct icssg_firmwares {
  * @is_switchmode_supported: indicates platform support for switch mode
  * @switch_id: ID for mapping switch ports to bridge
  * @default_vlan: Default VLAN for host
+ * @prus_running: flag to indicate if all pru cores are running
  */
 struct prueth {
 	struct device *dev;
@@ -298,6 +299,7 @@ struct prueth {
 	int default_vlan;
 	/** @vtbl_lock: Lock for vtbl in shared memory */
 	spinlock_t vtbl_lock;
+	bool prus_running;
 };
 
 struct emac_tx_ts_response {
@@ -361,6 +363,8 @@ int icssg_set_port_state(struct prueth_emac *emac,
 			 enum icssg_port_state_cmd state);
 void icssg_config_set_speed(struct prueth_emac *emac);
 void icssg_config_half_duplex(struct prueth_emac *emac);
+void icssg_init_emac_mode(struct prueth *prueth);
+void icssg_init_fw_offload_mode(struct prueth *prueth);
 
 /* Buffer queue helpers */
 int icssg_queue_pop(struct prueth *prueth, u8 queue);
@@ -377,6 +381,7 @@ void icssg_vtbl_modify(struct prueth_emac *emac, u8 vid, u8 port_mask,
 		       u8 untag_mask, bool add);
 u16 icssg_get_pvid(struct prueth_emac *emac);
 void icssg_set_pvid(struct prueth *prueth, u8 vid, u8 port);
+int emac_fdb_flow_id_updated(struct prueth_emac *emac);
 #define prueth_napi_to_tx_chn(pnapi) \
 	container_of(pnapi, struct prueth_tx_chn, napi_tx)
 
-- 
2.25.1


