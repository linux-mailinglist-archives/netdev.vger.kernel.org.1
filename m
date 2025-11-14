Return-Path: <netdev+bounces-238634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1693EC5C5DD
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 10:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 679D2500D5A
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 09:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4C930594A;
	Fri, 14 Nov 2025 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="0DUYdpt8"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F10D2FBE02;
	Fri, 14 Nov 2025 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112201; cv=none; b=dHfzpsR7ZqoA+oTDm4O0m1TAy/JuTE0pOl6ZvJAQOR1tvkdDjYtGJ4rMbHSb7RFM/Clgg7TZI7TcZEHxDVe0dRFiKq3Dqkoek22pwwNjQ8RIprq4mwn1euTcVAWqa5xUKS1PVarC7KFA7PQRc6GHfCl5IiWk3wfIhM04S4IciQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112201; c=relaxed/simple;
	bh=ju5owjvu0VX4i8wx7oDwNYqk2/lw7ZaH7ZQofWhxsR4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNAtH7ZcTJheHtIIrgC1I25CjGBN7E6+p1vrfk4WkiWYiUM864YqvNSVmd8Zm/mnlxz8lUvwpCHw2MPT6wufhweWxKmfdMtkc1R7Ma1AtT0i1IbJKlZG7GSJ1Qpgn1M461r2TEw8VN9/GI93oD+WWqAIWuOiBULwdiE8aw20zlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=0DUYdpt8; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=edwiiQt5CblhIFOI2q5eeGhAoeEx3vefP2XkXj3E38A=;
	b=0DUYdpt8SqvqfACD/LFZi/hVi/wRkEr3ZeWhKJ8hCQVEYt6QXoUilPsDSO/ox+t98sEHELXcV
	+Br4G5kU+Jh8B2XJAnbW0D/4QZQvTi6Jelh9/GRUyjZVtuowdj7cvFdu/JXyM69U0yLgLSMsvKc
	foGO1slyU1/u+3YgxHohCMc=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4d7BTq3jTrz1cyPl;
	Fri, 14 Nov 2025 17:21:35 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 8FCB41400CF;
	Fri, 14 Nov 2025 17:23:16 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Nov 2025 17:23:15 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net-next 2/3] net: hibmcge: reduce packet drop under stress testing
Date: Fri, 14 Nov 2025 17:22:21 +0800
Message-ID: <20251114092222.2071583-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20251114092222.2071583-1-shaojijie@huawei.com>
References: <20251114092222.2071583-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)

Under stress test scenarios, hibmcge driver may not receive packets
in a timely manner, which can lead to the buffer of the hardware queue
being exhausted, resulting in packet drop.

This patch doubles the software queue depth and uses half of the buffer
to fill the hardware queue before receiving packets, thus preventing
packet loss caused by the hardware queue buffer being exhausted.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 47 +++++++++++++++----
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
index 5f2e48f1dd25..ea691d564161 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
@@ -377,7 +377,8 @@ static int hbg_rx_fill_one_buffer(struct hbg_priv *priv)
 	struct hbg_buffer *buffer;
 	int ret;
 
-	if (hbg_queue_is_full(ring->ntc, ring->ntu, ring))
+	if (hbg_queue_is_full(ring->ntc, ring->ntu, ring) ||
+	    hbg_fifo_is_full(priv, ring->dir))
 		return 0;
 
 	buffer = &ring->queue[ring->ntu];
@@ -396,6 +397,26 @@ static int hbg_rx_fill_one_buffer(struct hbg_priv *priv)
 	return 0;
 }
 
+static int hbg_rx_fill_buffers(struct hbg_priv *priv)
+{
+	u32 remained = hbg_hw_get_fifo_used_num(priv, HBG_DIR_RX);
+	u32 max_count = priv->dev_specs.rx_fifo_num;
+	u32 refill_count;
+	int ret;
+
+	if (unlikely(remained >= max_count))
+		return 0;
+
+	refill_count = max_count - remained;
+	while (refill_count--) {
+		ret = hbg_rx_fill_one_buffer(priv);
+		if (unlikely(ret))
+			break;
+	}
+
+	return ret;
+}
+
 static bool hbg_sync_data_from_hw(struct hbg_priv *priv,
 				  struct hbg_buffer *buffer)
 {
@@ -420,6 +441,7 @@ static int hbg_napi_rx_poll(struct napi_struct *napi, int budget)
 	u32 packet_done = 0;
 	u32 pkt_len;
 
+	hbg_rx_fill_buffers(priv);
 	while (packet_done < budget) {
 		if (unlikely(hbg_queue_is_empty(ring->ntc, ring->ntu, ring)))
 			break;
@@ -497,6 +519,16 @@ static int hbg_ring_init(struct hbg_priv *priv, struct hbg_ring *ring,
 	u32 i, len;
 
 	len = hbg_get_spec_fifo_max_num(priv, dir) + 1;
+	/* To improve receiving performance under high-stress scenarios,
+	 * in the `hbg_napi_rx_poll()`, we first use the other half of
+	 * the buffer to receive packets from the hardware via the
+	 * `hbg_rx_fill_buffers()`, and then process the packets in the
+	 * original half of the buffer to avoid packet loss caused by
+	 * hardware overflow as much as possible.
+	 */
+	if (dir == HBG_DIR_RX)
+		len += hbg_get_spec_fifo_max_num(priv, dir);
+
 	ring->queue = dma_alloc_coherent(&priv->pdev->dev,
 					 len * sizeof(*ring->queue),
 					 &ring->queue_dma, GFP_KERNEL);
@@ -545,21 +577,16 @@ static int hbg_tx_ring_init(struct hbg_priv *priv)
 static int hbg_rx_ring_init(struct hbg_priv *priv)
 {
 	int ret;
-	u32 i;
 
 	ret = hbg_ring_init(priv, &priv->rx_ring, hbg_napi_rx_poll, HBG_DIR_RX);
 	if (ret)
 		return ret;
 
-	for (i = 0; i < priv->rx_ring.len - 1; i++) {
-		ret = hbg_rx_fill_one_buffer(priv);
-		if (ret) {
-			hbg_ring_uninit(&priv->rx_ring);
-			return ret;
-		}
-	}
+	ret = hbg_rx_fill_buffers(priv);
+	if (ret)
+		hbg_ring_uninit(&priv->rx_ring);
 
-	return 0;
+	return ret;
 }
 
 int hbg_txrx_init(struct hbg_priv *priv)
-- 
2.33.0


