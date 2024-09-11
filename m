Return-Path: <netdev+bounces-127255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB3E974C53
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 10:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC2A2864C3
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 08:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF0A1714A4;
	Wed, 11 Sep 2024 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JTYAUehM"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DA915C140;
	Wed, 11 Sep 2024 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726042598; cv=none; b=NDmtoSVMNspwdPiV2hifZ7919uP0fS6T3uFQPJXLWmt/s8XcKRYItXcLZ3vEkeuyVg6CwxqzNkCrPw7hzzCQtF6/Sm5XuBXQRTYb0SUtJuGQu2kgY86uDEOuxNit0AoeAfl3Z1tC2fNFWoSmPJj+KzqPKAIvQN/rbHEdKWbi898=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726042598; c=relaxed/simple;
	bh=ZlgqMF8SxWYPoQ+y0vXHa9nUO96mEwYTUrNjA1wM3JM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIYKODXRQVOP3Z+iMNzaSqmigTGsHCFA90N0Jl6SqDFXT0pC6OSSU3CqnStCA/USsI8p1Q6PeaDxh7jA9RjvfHJPdCkKUo49a52NspNbmO2eTYRBKkig80etjbUiJnhBBGfanT2nUJr+ZXs3d81YurnfXVt5SG68SS+QwTqwxdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JTYAUehM; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48B8GDZw118252;
	Wed, 11 Sep 2024 03:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726042573;
	bh=sQgqAW7tL/SUop77vExL6oNcILRV33lonQJVVjaKmto=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=JTYAUehM/n2rGHxuHF6iUUSBLuhLdduRMGgG6F8bojdSjExl5JjjNL1oCfUI3sqhF
	 X1caEMN7xusOuxKHweiLzDYhhQ7hBlgjwysq75hkNcirH33RqHd+uiLgzb7VrXjxUh
	 O+cLbd9yzg8LZly9CpfhZem6tRSv40xegqWiOoEw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48B8GDuH092174;
	Wed, 11 Sep 2024 03:16:13 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 11
 Sep 2024 03:16:13 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 11 Sep 2024 03:16:13 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48B8GDoE119138;
	Wed, 11 Sep 2024 03:16:13 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 48B8GCRf032142;
	Wed, 11 Sep 2024 03:16:13 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: <robh@kernel.org>, <jan.kiszka@siemens.com>, <dan.carpenter@linaro.org>,
        <r-gunasekaran@ti.com>, <saikrishnag@marvell.com>, <andrew@lunn.ch>,
        <javier.carrasco.cruz@gmail.com>, <jacob.e.keller@intel.com>,
        <diogo.ivo@siemens.com>, <horms@kernel.org>,
        <richardcochran@gmail.com>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v6 4/5] net: ti: icssg-prueth: Enable HSR Tx duplication, Tx Tag and Rx Tag offload
Date: Wed, 11 Sep 2024 13:46:02 +0530
Message-ID: <20240911081603.2521729-5-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911081603.2521729-1-danishanwar@ti.com>
References: <20240911081603.2521729-1-danishanwar@ti.com>
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

hsr tag insertion offload and hsr dup offload are tightly coupled in
firmware implementation. Both these features need to be enabled / disabled
together.

Duplicate discard is done as part of RX tag removal and it is
done by the firmware. When driver sends the r30 command
ICSSG_EMAC_HSR_RX_OFFLOAD_ENABLE, firmware does RX tag removal as well as
duplicate discard.

Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_common.c | 18 ++++++++--
 drivers/net/ethernet/ti/icssg/icssg_config.c |  4 ++-
 drivers/net/ethernet/ti/icssg/icssg_config.h |  2 ++
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 36 +++++++++++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  3 ++
 5 files changed, 58 insertions(+), 5 deletions(-)

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
index b38a4a6072c4..d128764982ae 100644
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
@@ -744,6 +747,29 @@ static void emac_ndo_set_rx_mode(struct net_device *ndev)
 	queue_work(emac->cmd_wq, &emac->rx_mode_work);
 }
 
+static netdev_features_t emac_ndo_fix_features(struct net_device *ndev,
+					       netdev_features_t features)
+{
+	/* hsr tag insertion offload and hsr dup offload are tightly coupled in
+	 * firmware implementation. Both these features need to be enabled /
+	 * disabled together.
+	 */
+	if (!(ndev->features & (NETIF_F_HW_HSR_DUP | NETIF_F_HW_HSR_TAG_INS)))
+		if ((features & NETIF_F_HW_HSR_DUP) ||
+		    (features & NETIF_F_HW_HSR_TAG_INS))
+			features |= NETIF_F_HW_HSR_DUP |
+				    NETIF_F_HW_HSR_TAG_INS;
+
+	if ((ndev->features & NETIF_F_HW_HSR_DUP) ||
+	    (ndev->features & NETIF_F_HW_HSR_TAG_INS))
+		if (!(features & NETIF_F_HW_HSR_DUP) ||
+		    !(features & NETIF_F_HW_HSR_TAG_INS))
+			features &= ~(NETIF_F_HW_HSR_DUP |
+				      NETIF_F_HW_HSR_TAG_INS);
+
+	return features;
+}
+
 static const struct net_device_ops emac_netdev_ops = {
 	.ndo_open = emac_ndo_open,
 	.ndo_stop = emac_ndo_stop,
@@ -755,6 +781,7 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_eth_ioctl = icssg_ndo_ioctl,
 	.ndo_get_stats64 = icssg_ndo_get_stats64,
 	.ndo_get_phys_port_name = icssg_ndo_get_phys_port_name,
+	.ndo_fix_features = emac_ndo_fix_features,
 };
 
 static int prueth_netdev_init(struct prueth *prueth,
@@ -981,6 +1008,13 @@ static void icssg_change_mode(struct prueth *prueth)
 
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


