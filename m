Return-Path: <netdev+bounces-196037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFD9AD33AA
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 12:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BDFB3B897C
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 10:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E572028C2C9;
	Tue, 10 Jun 2025 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="uruVWk6F"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC913284B33;
	Tue, 10 Jun 2025 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749551712; cv=none; b=tYIZ+X1Mr2lIHj03PlZtlVPzgOUCcDKF5ZFO7b3mTMaXtEZm3KeX65q8cb+PfDRQQBR/JNBW184D5fiGI+yk5Mgb4jvT9YJJnN+fPMmXNL08qM74NatmbyYtLhrx8KiZfxUUkdvmH93Z9FRjuUe2WxqEJkF2boqYws4gPL6v+7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749551712; c=relaxed/simple;
	bh=Z8cY0pZc5Zl9cs4akIFSVBgwp5hKJb5sS01kIB6Niiw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trsIxJmTZmlYbP+AgLOOK9bm8NkvlriiiJB1Uj3nJo7Cbj07CAYD0HhmYw51M77CEF4cChM9DmGtxAYC0m9acOOfL8W19pq497gQ+PKfaCkQ2bGd5GwsXrlR0pNq2CdXa3xOOLNjTYqSdAPbBa+n68aeiu8iatPW33wb8bMJQpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=uruVWk6F; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55AAYpL222658442, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749551691; bh=AAUhRrMFZrjqVUvPeFiNbTFXxRVnyTh5hjM775vrSoU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=uruVWk6FjuDsUFdF6ZK9vCntlpm7ntskcP+8G6Hr7m6L/Ss7Ri5b0r+cs3L5apxsX
	 HybGbFS4SFyznKt3zxsOpLpgvoLIfMuKQi9YO7YFnXhPJmLVmolyjYxuWHmqizOFd9
	 PTwg5h305h5iIJfFV6r6M68AjmzqC7UTRnNnA8+uzbjaZW1cxoPn7Bwx60JxYD+RlD
	 hwOgHnlflZyFGc5SzQaBsrxMtyd9fO5WLWatc92uhQw5s90NGu3PqLOPIm8pG+AWD/
	 F2GATaU5xcOETNqe1SkJTTYCfVTylKEym0F1fFHHt+MEXLcMje23rLMuAYzXVnymwb
	 5vaQsW4xBiT2A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55AAYpL222658442
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 18:34:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Jun 2025 18:34:52 +0800
Received: from RTDOMAIN (172.21.210.109) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 10 Jun
 2025 18:34:51 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <jdamato@fastly.com>,
        <pkshih@realtek.com>, <larry.chiu@realtek.com>,
        Justin Lai
	<justinlai0215@realtek.com>
Subject: [PATCH net-next 2/2] rtase: Link queues to NAPI instances
Date: Tue, 10 Jun 2025 18:33:34 +0800
Message-ID: <20250610103334.10446-3-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610103334.10446-1-justinlai0215@realtek.com>
References: <20250610103334.10446-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Link queues to NAPI instances with netif_queue_set_napi. This
information can be queried with the netdev-genl API.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase.h    |  4 +++
 .../net/ethernet/realtek/rtase/rtase_main.c   | 33 +++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
index 498cfe4d0cac..be98f4de46c4 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase.h
+++ b/drivers/net/ethernet/realtek/rtase/rtase.h
@@ -39,6 +39,9 @@
 #define RTASE_FUNC_RXQ_NUM  1
 #define RTASE_INTERRUPT_NUM 1
 
+#define RTASE_TX_RING 0
+#define RTASE_RX_RING 1
+
 #define RTASE_MITI_TIME_COUNT_MASK    GENMASK(3, 0)
 #define RTASE_MITI_TIME_UNIT_MASK     GENMASK(7, 4)
 #define RTASE_MITI_DEFAULT_TIME       128
@@ -288,6 +291,7 @@ struct rtase_ring {
 	u32 cur_idx;
 	u32 dirty_idx;
 	u16 index;
+	u8 ring_type;
 
 	struct sk_buff *skbuff[RTASE_NUM_DESC];
 	void *data_buf[RTASE_NUM_DESC];
diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index a88af868da8c..ef3ada91d555 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -326,6 +326,7 @@ static void rtase_tx_desc_init(struct rtase_private *tp, u16 idx)
 	ring->cur_idx = 0;
 	ring->dirty_idx = 0;
 	ring->index = idx;
+	ring->ring_type = RTASE_TX_RING;
 	ring->alloc_fail = 0;
 
 	for (i = 0; i < RTASE_NUM_DESC; i++) {
@@ -345,6 +346,10 @@ static void rtase_tx_desc_init(struct rtase_private *tp, u16 idx)
 		ring->ivec = &tp->int_vector[0];
 		list_add_tail(&ring->ring_entry, &tp->int_vector[0].ring_list);
 	}
+
+	netif_queue_set_napi(tp->dev, ring->index,
+			     NETDEV_QUEUE_TYPE_TX,
+			     &ring->ivec->napi);
 }
 
 static void rtase_map_to_asic(union rtase_rx_desc *desc, dma_addr_t mapping,
@@ -590,6 +595,7 @@ static void rtase_rx_desc_init(struct rtase_private *tp, u16 idx)
 	ring->cur_idx = 0;
 	ring->dirty_idx = 0;
 	ring->index = idx;
+	ring->ring_type = RTASE_RX_RING;
 	ring->alloc_fail = 0;
 
 	for (i = 0; i < RTASE_NUM_DESC; i++)
@@ -597,6 +603,9 @@ static void rtase_rx_desc_init(struct rtase_private *tp, u16 idx)
 
 	ring->ring_handler = rx_handler;
 	ring->ivec = &tp->int_vector[idx];
+	netif_queue_set_napi(tp->dev, ring->index,
+			     NETDEV_QUEUE_TYPE_RX,
+			     &ring->ivec->napi);
 	list_add_tail(&ring->ring_entry, &tp->int_vector[idx].ring_list);
 }
 
@@ -1161,8 +1170,18 @@ static void rtase_down(struct net_device *dev)
 		ivec = &tp->int_vector[i];
 		napi_disable(&ivec->napi);
 		list_for_each_entry_safe(ring, tmp, &ivec->ring_list,
-					 ring_entry)
+					 ring_entry) {
+			if (ring->ring_type == RTASE_TX_RING)
+				netif_queue_set_napi(tp->dev, ring->index,
+						     NETDEV_QUEUE_TYPE_TX,
+						     NULL);
+			else
+				netif_queue_set_napi(tp->dev, ring->index,
+						     NETDEV_QUEUE_TYPE_RX,
+						     NULL);
+
 			list_del(&ring->ring_entry);
+		}
 	}
 
 	netif_tx_disable(dev);
@@ -1518,8 +1537,18 @@ static void rtase_sw_reset(struct net_device *dev)
 	for (i = 0; i < tp->int_nums; i++) {
 		ivec = &tp->int_vector[i];
 		list_for_each_entry_safe(ring, tmp, &ivec->ring_list,
-					 ring_entry)
+					 ring_entry) {
+			if (ring->ring_type == RTASE_TX_RING)
+				netif_queue_set_napi(tp->dev, ring->index,
+						     NETDEV_QUEUE_TYPE_TX,
+						     NULL);
+			else
+				netif_queue_set_napi(tp->dev, ring->index,
+						     NETDEV_QUEUE_TYPE_RX,
+						     NULL);
+
 			list_del(&ring->ring_entry);
+		}
 	}
 
 	ret = rtase_init_ring(dev);
-- 
2.34.1


