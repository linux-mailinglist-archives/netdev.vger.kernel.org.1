Return-Path: <netdev+bounces-117932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA1094FEFD
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 09:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3FEB1F23CF8
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 07:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684FC13AA2D;
	Tue, 13 Aug 2024 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ttUPc7Rx"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A646F2F3;
	Tue, 13 Aug 2024 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723534994; cv=none; b=qG+21i3/umYp4+o2E6AsaViYeT4mAMS/Es5zap73FsnXFZckRRPb5OUw1KHdmcjqZYQ/YTgbho+HOug4xm8/APzq/dcyqxHDCdAOMPS6BoiOaUf4thfe/gYTAEoY96Cm+ZQPFLJX78hKKCwR06eZSDoT9/hDNNyA9/bmnIoC4Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723534994; c=relaxed/simple;
	bh=uYRpE04haqDk3Z3swLsfw8h3zFXsadK3WjTaL9DfkTY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MCOxMySJMXV4nvDtgS/cH5jhaX8q8ArM43IW7PQSv9C/edni7sEApeioRtBvdnPI5tOlSj1PesEE83wz5MdjWROn6CjGZcOAyGHcv8ZlsR8Dmr58tHUN4eKhR6orWxjFDDYKiU4Q7YPAHfKSwlL6Qn45tUueV04WGmoD7AgsLaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ttUPc7Rx; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47D7gkC9050779;
	Tue, 13 Aug 2024 02:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723534966;
	bh=e1n5doa41HMjU1IkT5+Eu+LhBbKdjklZBnOD1KIS8Rg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ttUPc7RxcI+xkYksEKXiFK5wRZwOtP8wDxxT2Ra2GQW0TUIDLHrXc4/rHcgQX+Ubk
	 akg2rJO2hgq36yZnIo9EcbX5C2zLeKMaYsKv/1yhl9po2r93tLTxY9tC5t13fwxnTp
	 R8RlIB+mA382l9yD8c9BB/oEajhOa8xeIDKHDTXQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47D7gk65039945
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Aug 2024 02:42:46 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 02:42:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 02:42:45 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47D7gj8R025810;
	Tue, 13 Aug 2024 02:42:45 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 47D7gjmY008742;
	Tue, 13 Aug 2024 02:42:45 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Jacob Keller
	<jacob.e.keller@intel.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman
	<horms@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v2 5/7] net: ti: icssg-prueth: Enable HSR Tx Packet duplication offload
Date: Tue, 13 Aug 2024 13:12:31 +0530
Message-ID: <20240813074233.2473876-6-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813074233.2473876-1-danishanwar@ti.com>
References: <20240813074233.2473876-1-danishanwar@ti.com>
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
index 142e267ff136..b32a2bff34dc 100644
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
@@ -897,7 +898,7 @@ static int prueth_netdev_init(struct prueth *prueth,
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


