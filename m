Return-Path: <netdev+bounces-122694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83E8962340
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 11:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37C30B21BA1
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 09:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F5116087B;
	Wed, 28 Aug 2024 09:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="juVFMJAH"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EECF15F3FF;
	Wed, 28 Aug 2024 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724836782; cv=none; b=cmSVs81+xT3jJtBwxYH0UCUbJce/xfHg+La6M2R1jehs96OaOqDnMDJvDVmJ5PrJP6OGxrXOWT+CIfzJH7m0nD1ePTOwIZfIQ6jEkbmu5HJWsOfHvcFZUGCG7cyS4WzMOuuua0/S4/fH/sSVknXVmf8F4tW0xUz6JazhBTRT+C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724836782; c=relaxed/simple;
	bh=/tOEMxVEgJKdh754e3csoAnjrR9XyA1c8erixLUNyl4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e91bjnU0/Zf5DDHKpKUdzaMr6bLIED9KtgjM7uXy3Ajw79iXl7I5K23rhJWdrsNuixgcl7ym5PIntuYsXOm413WiCqnzZj+ii036qoU8Vf5lGWALKtwzmyGTi20x9kuZ6wsvYv8/4aDZy4GbxxKWB7S8AWoPnGoGtD3FvW+EZb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=juVFMJAH; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47S9JGBg031048;
	Wed, 28 Aug 2024 04:19:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724836756;
	bh=FziPQMgOT1f5KMk8a+N1ZrZVM3/nfyRUxNQ0qygEBZ0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=juVFMJAHYKb5Qb3fNE0e4zpMS8YngFHexVFVXhpf7kbishN8wnZRzmk6mPDa/K1r4
	 FZReUfq9lwwCKYX3HbFq6oa0KA3JWGe1i5hkrL4xuC6lE96KRfkAJYe0nEksmPbEha
	 wCjPC6hzAH5Hz/YFDkMt9DSrD+sMKCJqgPFXym04=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47S9JG6B068106
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 04:19:16 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 04:19:16 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 04:19:16 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47S9JGFa054803;
	Wed, 28 Aug 2024 04:19:16 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 47S9JFUw007492;
	Wed, 28 Aug 2024 04:19:15 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Andrew Lunn <andrew@lunn.ch>, Dan Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Javier Carrasco
	<javier.carrasco.cruz@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman <horms@kernel.org>,
        Richard
 Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v3 6/6] net: ti: icssg-prueth: Enable HSR Tx Tag and Rx Tag offload
Date: Wed, 28 Aug 2024 14:49:01 +0530
Message-ID: <20240828091901.3120935-7-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828091901.3120935-1-danishanwar@ti.com>
References: <20240828091901.3120935-1-danishanwar@ti.com>
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

Add support to offload HSR Tx Tag Insertion and Rx Tag Removal
and duplicate discard.

Duplicate discard is done as part of RX tag removal and it is
done by the firmware. When driver sends the r30 command
ICSSG_EMAC_HSR_RX_OFFLOAD_ENABLE, firmware does RX tag removal as well as
duplicate discard.

Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_common.c |  3 +++
 drivers/net/ethernet/ti/icssg/icssg_config.c |  4 +++-
 drivers/net/ethernet/ti/icssg/icssg_config.h |  2 ++
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 11 ++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  1 +
 5 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 2d6d8648f5a9..4eae4f9250c0 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -721,6 +721,9 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev
 	if (prueth->is_hsr_offload_mode && (ndev->features & NETIF_F_HW_HSR_DUP))
 		dst_tag_id = PRUETH_UNDIRECTED_PKT_DST_TAG;
 
+	if (prueth->is_hsr_offload_mode && (ndev->features & NETIF_F_HW_HSR_TAG_INS))
+		epib[1] |= PRUETH_UNDIRECTED_PKT_TAG_INS;
+
 	cppi5_desc_set_tags_ids(&first_desc->hdr, 0, dst_tag_id);
 	k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
 	cppi5_hdesc_attach_buf(first_desc, buf_dma, pkt_len, buf_dma, pkt_len);
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
index ecc342bcc1b5..c671cf9813f0 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -42,7 +42,9 @@
 #define DEFAULT_UNTAG_MASK	1
 
 #define NETIF_PRUETH_HSR_OFFLOAD_FEATURES	(NETIF_F_HW_HSR_FWD | \
-						 NETIF_F_HW_HSR_DUP)
+						 NETIF_F_HW_HSR_DUP | \
+						 NETIF_F_HW_HSR_TAG_INS | \
+						 NETIF_F_HW_HSR_TAG_RM)
 
 /* CTRLMMR_ICSSG_RGMII_CTRL register bits */
 #define ICSSG_CTRL_RGMII_ID_MODE                BIT(24)
@@ -1034,6 +1036,13 @@ static void icssg_change_mode(struct prueth *prueth)
 
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
index e110a5f92684..bba6da2e6bd8 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -60,6 +60,7 @@
 #define IEP_DEFAULT_CYCLE_TIME_NS	1000000	/* 1 ms */
 
 #define PRUETH_UNDIRECTED_PKT_DST_TAG	0
+#define PRUETH_UNDIRECTED_PKT_TAG_INS	BIT(30)
 
 /* Firmware status codes */
 #define ICSS_HS_FW_READY 0x55555555
-- 
2.34.1


