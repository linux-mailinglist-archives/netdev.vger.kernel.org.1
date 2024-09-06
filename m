Return-Path: <netdev+bounces-125899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB45596F29C
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 13:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D6C8B20E7D
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 11:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CC41CB31E;
	Fri,  6 Sep 2024 11:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ceHU1er8"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A311CB318;
	Fri,  6 Sep 2024 11:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621381; cv=none; b=rnmsdpqRL1odw5Ut4ub0JgZT5DpdC+SDIx2f0air7Vx/PmSVDK+OT+4ozbNPMPhwb24WKN658Cp/uzWLw/Sgat36DaUKIAy1FmvQzQjAnRZb05YbA5RjM/7Rs/bZmZoMO993bLUuA8qdcYXxR5TQ3JS6yjfjIrczlRKGibM3QOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621381; c=relaxed/simple;
	bh=ElzpVPqZJhRp27RTz/7TvYNz21yHRU3EMPjpFgs7jbA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1f1a7xHuOkKKAAuPy+FL6LYng7IwrMaQJikqfs9iadcpIm8qIBnz92MILbUhI5KolknNaaztDy4bXG0jvbSVLQjTQjUATAxOIKsyx80xMDGuB5V664wQ8DsM9f3sMdL8iAvEvQ6ou2bZicG7dk7Gu+k6AAaRVaODsHYbxaetT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ceHU1er8; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 486BFnLm033720;
	Fri, 6 Sep 2024 06:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725621349;
	bh=F2eWGCPmdMdZeWzIBQ9V86zTlFKTt6VcS/tOtAny3tM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ceHU1er8iN4E43mMs8Y86E6zsQ26Zsl7yUlAPu5cOT/VryYFLP5JTUGwLX/GlKry7
	 PfamzZXxGF0mnS5U8+jCAqSCTy9yhhaO7anaiaNyjp5t0pvgu/CuCU3g2/a+MxfphS
	 LYDs4g1ejR8Rxeih6N2NbcI/E2uuFJLOv5GVIqfs=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 486BFnaW029031
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Sep 2024 06:15:49 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Sep 2024 06:15:49 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Sep 2024 06:15:49 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 486BFnI2059939;
	Fri, 6 Sep 2024 06:15:49 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 486BFmTa000330;
	Fri, 6 Sep 2024 06:15:49 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: <robh@kernel.org>, <jan.kiszka@siemens.com>, <dan.carpenter@linaro.org>,
        <saikrishnag@marvell.com>, <andrew@lunn.ch>,
        <javier.carrasco.cruz@gmail.com>, <jacob.e.keller@intel.com>,
        <diogo.ivo@siemens.com>, <horms@kernel.org>,
        <richardcochran@gmail.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>
Subject: [PATCH net-next v5 4/5] net: ti: icssg-prueth: Enable HSR Tx duplication, Tx Tag and Rx Tag offload
Date: Fri, 6 Sep 2024 16:45:37 +0530
Message-ID: <20240906111538.1259418-5-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906111538.1259418-1-danishanwar@ti.com>
References: <20240906111538.1259418-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Ravi Gunasekaran <r-gunasekaran@ti.com>

The HSR stack allows to offload its Tx packet duplication functionality to
the hardware. Enable this offloading feature for ICSSG driver. Add support
to offload HSR Tx Tag Insertion and Rx Tag Removal and duplicate discard.

Inorder to enable hsr-tag-ins-offload, hsr-dup-offload must also be enabled
as these are tightly coupled in the firmware implementation.

Duplicate discard is done as part of RX tag removal and it is
done by the firmware. When driver sends the r30 command
ICSSG_EMAC_HSR_RX_OFFLOAD_ENABLE, firmware does RX tag removal as well as
duplicate discard.

Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_common.c | 18 ++++++++++---
 drivers/net/ethernet/ti/icssg/icssg_config.c |  4 ++-
 drivers/net/ethernet/ti/icssg/icssg_config.h |  2 ++
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 28 +++++++++++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  3 +++
 5 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index b9d8a93d1680..fdebeb2f84e0 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -660,14 +660,15 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev
 {
 	struct cppi5_host_desc_t *first_desc, *next_desc, *cur_desc;
 	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth *prueth = emac->prueth;
 	struct netdev_queue *netif_txq;
 	struct prueth_tx_chn *tx_chn;
 	dma_addr_t desc_dma, buf_dma;
+	u32 pkt_len, dst_tag_id;
 	int i, ret = 0, q_idx;
 	bool in_tx_ts = 0;
 	int tx_ts_cookie;
 	void **swdata;
-	u32 pkt_len;
 	u32 *epib;
 
 	pkt_len = skb_headlen(skb);
@@ -712,9 +713,20 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev
 
 	/* set dst tag to indicate internal qid at the firmware which is at
 	 * bit8..bit15. bit0..bit7 indicates port num for directed
-	 * packets in case of switch mode operation
+	 * packets in case of switch mode operation and port num 0
+	 * for undirected packets in case of HSR offload mode
 	 */
-	cppi5_desc_set_tags_ids(&first_desc->hdr, 0, (emac->port_id | (q_idx << 8)));
+	dst_tag_id = emac->port_id | (q_idx << 8);
+
+	if (prueth->is_hsr_offload_mode &&
+	    (ndev->features & NETIF_F_HW_HSR_DUP))
+		dst_tag_id = PRUETH_UNDIRECTED_PKT_DST_TAG;
+
+	if (prueth->is_hsr_offload_mode &&
+	    (ndev->features & NETIF_F_HW_HSR_TAG_INS))
+		epib[1] |= PRUETH_UNDIRECTED_PKT_TAG_INS;
+
+	cppi5_desc_set_tags_ids(&first_desc->hdr, 0, dst_tag_id);
 	k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
 	cppi5_hdesc_attach_buf(first_desc, buf_dma, pkt_len, buf_dma, pkt_len);
 	swdata = cppi5_hdesc_get_swdata(first_desc);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.c b/drivers/net/ethernet/ti/icssg/icssg_config.c
index 7b2e6c192ff3..72ace151d8e9 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.c
@@ -531,7 +531,9 @@ static const struct icssg_r30_cmd emac_r32_bitmask[] = {
 	{{EMAC_NONE,  0xffff4000, EMAC_NONE, EMAC_NONE}},	/* Preemption on Tx ENABLE*/
 	{{EMAC_NONE,  0xbfff0000, EMAC_NONE, EMAC_NONE}},	/* Preemption on Tx DISABLE*/
 	{{0xffff0010,  EMAC_NONE, 0xffff0010, EMAC_NONE}},	/* VLAN AWARE*/
-	{{0xffef0000,  EMAC_NONE, 0xffef0000, EMAC_NONE}}	/* VLAN UNWARE*/
+	{{0xffef0000,  EMAC_NONE, 0xffef0000, EMAC_NONE}},	/* VLAN UNWARE*/
+	{{0xffff2000, EMAC_NONE, EMAC_NONE, EMAC_NONE}},	/* HSR_RX_OFFLOAD_ENABLE */
+	{{0xdfff0000, EMAC_NONE, EMAC_NONE, EMAC_NONE}}		/* HSR_RX_OFFLOAD_DISABLE */
 };
 
 int icssg_set_port_state(struct prueth_emac *emac,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
index 1ac60283923b..92c2deaa3068 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
@@ -80,6 +80,8 @@ enum icssg_port_state_cmd {
 	ICSSG_EMAC_PORT_PREMPT_TX_DISABLE,
 	ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE,
 	ICSSG_EMAC_PORT_VLAN_AWARE_DISABLE,
+	ICSSG_EMAC_HSR_RX_OFFLOAD_ENABLE,
+	ICSSG_EMAC_HSR_RX_OFFLOAD_DISABLE,
 	ICSSG_EMAC_PORT_MAX_COMMANDS
 };
 
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 676168d6fded..9af06454ba64 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -41,7 +41,10 @@
 #define DEFAULT_PORT_MASK	1
 #define DEFAULT_UNTAG_MASK	1
 
-#define NETIF_PRUETH_HSR_OFFLOAD_FEATURES	NETIF_F_HW_HSR_FWD
+#define NETIF_PRUETH_HSR_OFFLOAD_FEATURES	(NETIF_F_HW_HSR_FWD | \
+						 NETIF_F_HW_HSR_DUP | \
+						 NETIF_F_HW_HSR_TAG_INS | \
+						 NETIF_F_HW_HSR_TAG_RM)
 
 /* CTRLMMR_ICSSG_RGMII_CTRL register bits */
 #define ICSSG_CTRL_RGMII_ID_MODE                BIT(24)
@@ -758,6 +761,21 @@ static void emac_change_hsr_feature(struct net_device *ndev,
 	}
 }
 
+static netdev_features_t emac_ndo_fix_features(struct net_device *ndev,
+					       netdev_features_t features)
+{
+	/* In order to enable hsr tag insertion offload, hsr dup offload must
+	 * also be enabled as these two are tightly coupled in firmware
+	 * implementation.
+	 */
+	if (features & NETIF_F_HW_HSR_TAG_INS)
+		features |= NETIF_F_HW_HSR_DUP;
+	else
+		features &= ~NETIF_F_HW_HSR_DUP;
+
+	return features;
+}
+
 static int emac_ndo_set_features(struct net_device *ndev,
 				 netdev_features_t features)
 {
@@ -780,6 +798,7 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_eth_ioctl = icssg_ndo_ioctl,
 	.ndo_get_stats64 = icssg_ndo_get_stats64,
 	.ndo_get_phys_port_name = icssg_ndo_get_phys_port_name,
+	.ndo_fix_features = emac_ndo_fix_features,
 	.ndo_set_features = emac_ndo_set_features,
 };
 
@@ -1007,6 +1026,13 @@ static void icssg_change_mode(struct prueth *prueth)
 
 	for (mac = PRUETH_MAC0; mac < PRUETH_NUM_MACS; mac++) {
 		emac = prueth->emac[mac];
+		if (prueth->is_hsr_offload_mode) {
+			if (emac->ndev->features & NETIF_F_HW_HSR_TAG_RM)
+				icssg_set_port_state(emac, ICSSG_EMAC_HSR_RX_OFFLOAD_ENABLE);
+			else
+				icssg_set_port_state(emac, ICSSG_EMAC_HSR_RX_OFFLOAD_DISABLE);
+		}
+
 		if (netif_running(emac->ndev)) {
 			icssg_fdb_add_del(emac, eth_stp_addr, prueth->default_vlan,
 					  ICSSG_FDB_ENTRY_P0_MEMBERSHIP |
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index a4b025fae797..bba6da2e6bd8 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -59,6 +59,9 @@
 
 #define IEP_DEFAULT_CYCLE_TIME_NS	1000000	/* 1 ms */
 
+#define PRUETH_UNDIRECTED_PKT_DST_TAG	0
+#define PRUETH_UNDIRECTED_PKT_TAG_INS	BIT(30)
+
 /* Firmware status codes */
 #define ICSS_HS_FW_READY 0x55555555
 #define ICSS_HS_FW_DEAD 0xDEAD0000	/* lower 16 bits contain error code */
-- 
2.34.1


