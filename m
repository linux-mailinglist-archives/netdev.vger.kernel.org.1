Return-Path: <netdev+bounces-116795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B086594BBFF
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D44371C21286
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5D018CC13;
	Thu,  8 Aug 2024 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ClNWc5YR"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDAD18C911;
	Thu,  8 Aug 2024 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723115312; cv=none; b=m/Pw7rKcZAPC/A2Gc+Keg8N7u7MkdakoH2kaWG6HmGPJOKKtr0WAe37/953QlawRtI69AZshLmuer06ITjJ2z0w8pnToiLydlupQUl03bVwuwMXo3HT8r0cFacCY+FmE+2ZitSjvKp0nuGbdJy1l7iXXLOickpcs3r2ek6MsVkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723115312; c=relaxed/simple;
	bh=6KrYAwrej7Iqoq8pZ/8GVOZiaRMq/VYw35cQWH/ETX8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s8kELpBOoSHUi1a3oDDu/RTgbEcZk+zEklq8vnucpQ+adkHIlnE8xaLtrzGsB8hq6RiIkhP0OFHRpnCyKsIe1v54ZGGudhqwHMwZTBGZzvrc/5DdodDiQY3pOU5Sb3GsGrrIiJyC1/DgoCQY6p6U0XlQIdjTYnQRuoDKq9yoUyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ClNWc5YR; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 478B89PT048329;
	Thu, 8 Aug 2024 06:08:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723115289;
	bh=PZILdJcV560FHECF/98DamlP8kjBoSbJmu+dhVKAsmM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ClNWc5YRyGZUHSNPBnITP1oIHlhHc0IwGCnA+02G2Q6KNTsgpoCmVlByV1/p+pzx2
	 PRv0D/cLYAYfV3PG9ZnERaj4AbJdyo5Wtf5u4R8XhcpGEFCv/yrEqqicgpjYT7PWW7
	 3E7Hwjnkg7yQIL9Qy7kW3brB2Rh04DkQKMi0FTpM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 478B898Y063571
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Aug 2024 06:08:09 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Aug 2024 06:08:09 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Aug 2024 06:08:09 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 478B88HJ087613;
	Thu, 8 Aug 2024 06:08:08 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 478B88TG012000;
	Thu, 8 Aug 2024 06:08:08 -0500
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
Subject: [PATCH net-next 3/6] net: ti: icssg-prueth: Enable HSR Tx Packet duplication offload
Date: Thu, 8 Aug 2024 16:37:57 +0530
Message-ID: <20240808110800.1281716-4-danishanwar@ti.com>
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

The HSR stack allows to offload its Tx packet duplication functionality to
the hardware. Enable this offloading feature for ICSSG driver

Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_common.c | 13 ++++++++++---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c |  5 +++--
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  2 ++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index b9d8a93d1680..2d6d8648f5a9 100644
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
@@ -712,9 +713,15 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev
 
 	/* set dst tag to indicate internal qid at the firmware which is at
 	 * bit8..bit15. bit0..bit7 indicates port num for directed
-	 * packets in case of switch mode operation
+	 * packets in case of switch mode operation and port num 0
+	 * for undirected packets in case of HSR offload mode
 	 */
-	cppi5_desc_set_tags_ids(&first_desc->hdr, 0, (emac->port_id | (q_idx << 8)));
+	dst_tag_id = emac->port_id | (q_idx << 8);
+
+	if (prueth->is_hsr_offload_mode && (ndev->features & NETIF_F_HW_HSR_DUP))
+		dst_tag_id = PRUETH_UNDIRECTED_PKT_DST_TAG;
+
+	cppi5_desc_set_tags_ids(&first_desc->hdr, 0, dst_tag_id);
 	k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
 	cppi5_hdesc_attach_buf(first_desc, buf_dma, pkt_len, buf_dma, pkt_len);
 	swdata = cppi5_hdesc_get_swdata(first_desc);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 675a01658d17..657bf1b4e5ec 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -41,7 +41,8 @@
 #define DEFAULT_PORT_MASK	1
 #define DEFAULT_UNTAG_MASK	1
 
-#define NETIF_PRUETH_HSR_OFFLOAD	NETIF_F_HW_HSR_FWD
+#define NETIF_PRUETH_HSR_OFFLOAD	(NETIF_F_HW_HSR_FWD | \
+					 NETIF_F_HW_HSR_DUP)
 
 /* CTRLMMR_ICSSG_RGMII_CTRL register bits */
 #define ICSSG_CTRL_RGMII_ID_MODE                BIT(24)
@@ -895,7 +896,7 @@ static int prueth_netdev_init(struct prueth *prueth,
 	ndev->ethtool_ops = &icssg_ethtool_ops;
 	ndev->hw_features = NETIF_F_SG;
 	ndev->features = ndev->hw_features;
-	ndev->hw_features |= NETIF_F_HW_HSR_FWD;
+	ndev->hw_features |= NETIF_PRUETH_HSR_OFFLOAD;
 
 	netif_napi_add(ndev, &emac->napi_rx, icssg_napi_rx_poll);
 	hrtimer_init(&emac->rx_hrtimer, CLOCK_MONOTONIC,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 40bc3912b6ae..6cb1dce8b309 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -57,6 +57,8 @@
 
 #define IEP_DEFAULT_CYCLE_TIME_NS	1000000	/* 1 ms */
 
+#define PRUETH_UNDIRECTED_PKT_DST_TAG	0
+
 /* Firmware status codes */
 #define ICSS_HS_FW_READY 0x55555555
 #define ICSS_HS_FW_DEAD 0xDEAD0000	/* lower 16 bits contain error code */
-- 
2.34.1


