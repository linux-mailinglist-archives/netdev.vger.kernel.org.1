Return-Path: <netdev+bounces-116794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F77D94BBFC
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6861F21587
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0F918C91C;
	Thu,  8 Aug 2024 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jxMIcU+i"
X-Original-To: netdev@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BC818C336;
	Thu,  8 Aug 2024 11:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723115310; cv=none; b=Ts4TSw2y+KXd/AyfTqwx7qhZRUsf6SESZyTab7hezPNLijjD9Tgow6nWPV2b7f8mXzTVCzJq/9tH1srjtoZKt/nFvuSZGNLn174hjJ9HcGURMAJOGIXsYMEmQQ08slzMdXGXiShS3R07QiBOb2py7Jgw7nWmXFpJBSyodn0JGJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723115310; c=relaxed/simple;
	bh=8GN8rdNe2iG//LkzVZVF0tVKQ8UPWVoD3V9yoztJMCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=glbqug0HyG1zFmz+cFcXCVyk7icsOnO5snvs7wqMWTQfbLmwCnjTkLgyImP1Q775cys/oLnijGJQrUNMxyjeEXQsRN2tVDx0oEyJZ4mfwlYBFTZtz3fFk7svMxwTPPzc5rFmt1/aqNxzszvQ8hMK/94MAoMWrd623EyozPJi0xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jxMIcU+i; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 478B8Fup121903;
	Thu, 8 Aug 2024 06:08:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723115295;
	bh=EbIkx1rog+a9euzHldSKYUYmYpK/31HoZhY9Xz1RGFI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=jxMIcU+iflM4vfcz9JfNM3CsM5joh+YAU0GA1ofDIp3TeyC7Wwogo0/0u/DLEClc+
	 q9QOWcid3g8mXhCw2o/MccpZPLmim24Vv5IycjnOU6jufDgRm788rO2MAuu8p3e8Ph
	 PG5qVfz63TJJGKqFDvu0zvficmqXQzpkT2EnYlUo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 478B8Fxg081600
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Aug 2024 06:08:15 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Aug 2024 06:08:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Aug 2024 06:08:14 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 478B8Erq087737;
	Thu, 8 Aug 2024 06:08:14 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 478B8E5F012016;
	Thu, 8 Aug 2024 06:08:14 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>, Vignesh Raghavendra
	<vigneshr@ti.com>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Diogo
 Ivo <diogo.ivo@siemens.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Simon
 Horman <horms@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo
 Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>
Subject: [PATCH net-next 6/6] net: ti: icssg-prueth: Enable HSR Tx Tag and Rx Tag offload
Date: Thu, 8 Aug 2024 16:38:00 +0530
Message-ID: <20240808110800.1281716-7-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808110800.1281716-1-danishanwar@ti.com>
References: <20240808110800.1281716-1-danishanwar@ti.com>
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

Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
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
index 2f485318c940..f061fa97a377 100644
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
index 778b41c16f2d..e0e551fc77e3 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -42,7 +42,9 @@
 #define DEFAULT_UNTAG_MASK	1
 
 #define NETIF_PRUETH_HSR_OFFLOAD	(NETIF_F_HW_HSR_FWD | \
-					 NETIF_F_HW_HSR_DUP)
+					 NETIF_F_HW_HSR_DUP | \
+					 NETIF_F_HW_HSR_TAG_INS | \
+					 NETIF_F_HW_HSR_TAG_RM)
 
 /* CTRLMMR_ICSSG_RGMII_CTRL register bits */
 #define ICSSG_CTRL_RGMII_ID_MODE                BIT(24)
@@ -1031,6 +1033,13 @@ static void icssg_change_mode(struct prueth *prueth)
 
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
index 79e8577caf91..518863f37794 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -58,6 +58,7 @@
 #define IEP_DEFAULT_CYCLE_TIME_NS	1000000	/* 1 ms */
 
 #define PRUETH_UNDIRECTED_PKT_DST_TAG	0
+#define PRUETH_UNDIRECTED_PKT_TAG_INS	BIT(30)
 
 /* Firmware status codes */
 #define ICSS_HS_FW_READY 0x55555555
-- 
2.34.1


