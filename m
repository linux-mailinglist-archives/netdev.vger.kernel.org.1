Return-Path: <netdev+bounces-117585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A5494E6D0
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 08:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6D31C20896
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 06:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00ED414F9C7;
	Mon, 12 Aug 2024 06:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="n8bn71VX"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D911E14D432;
	Mon, 12 Aug 2024 06:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723444687; cv=none; b=akxfYhcTDjotkYrfAhRw8fu0tXdiOBPWagLIcZ2abWyxJRflmr2Y5YKIc2aZnfi7xPlUfAvffnGXSZT2y5QPihL8efzevgcDpMjFBcF7wIEkDksW9b13G//R6rH7gV1qgMxt2X3idddvKY63DoruZ+1nT/XrkHphIG3nKxRoeCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723444687; c=relaxed/simple;
	bh=AhqqdQ8frQtVr/1cS68E/tXrrIN47kM9QV+Mjg3V06E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l/c+r1JV9NZ/M2uHanj0J0d/G6fiBm/UY/SN6qiqrtYS7GfwmV0uJLrC+OAks9vlnvSeaW+apOuOdiEGGjXPuL8xRUEauPHqZDd5dmGiE0Xxd9EcWSM2nKgLeeyqLRVwSMj2prrV/KCC8Aq26cn+zAeRtwhD4ng2QH/ywLiM7AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=n8bn71VX; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47C6be0L33756037, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723444660; bh=AhqqdQ8frQtVr/1cS68E/tXrrIN47kM9QV+Mjg3V06E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=n8bn71VXMlnGHfseEBaASlgdIY5Hxz9fH7/ufxNqrhXch33UIKt4eaAUZHT8tbGly
	 BA8JCv5+cnVt/Ud7o+6wCyy7qAt1AfaTcUL5pHBCW0ZPZJFEdIos3qkuTykf9Iw7yd
	 B541XiZ3QmkMOmyqGVAKB39bN1pk/sWJSFlZuKReqTGnngCR+M9Bck7FyM6euh+drh
	 rErDWdki4+je0RJv4b3tf51ZUUOjOZLQ+D8P6x9rjm/7jQvtaXJDSukBNKMiOEQDZT
	 W6LobPUWXAkrgsuE/mFMCtN/R7IpYGp9OeIXV9Eq/cQ7DHiQFMdVMeGh/8ay7dV5N0
	 4Edp71EKGlYZQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47C6be0L33756037
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Aug 2024 14:37:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 12 Aug 2024 14:37:41 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 12 Aug
 2024 14:37:40 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <jdamato@fastly.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v27 03/13] rtase: Implement the rtase_down function
Date: Mon, 12 Aug 2024 14:35:29 +0800
Message-ID: <20240812063539.575865-4-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812063539.575865-1-justinlai0215@realtek.com>
References: <20240812063539.575865-1-justinlai0215@realtek.com>
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

Implement the rtase_down function to disable hardware setting
and interrupt and clear descriptor ring.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 .../net/ethernet/realtek/rtase/rtase_main.c   | 150 ++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 091e445b5deb..da795570e9ac 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -192,6 +192,56 @@ static int rtase_alloc_desc(struct rtase_private *tp)
 	return -ENOMEM;
 }
 
+static void rtase_unmap_tx_skb(struct pci_dev *pdev, u32 len,
+			       struct rtase_tx_desc *desc)
+{
+	dma_unmap_single(&pdev->dev, le64_to_cpu(desc->addr), len,
+			 DMA_TO_DEVICE);
+	desc->opts1 = cpu_to_le32(RTK_OPTS1_DEBUG_VALUE);
+	desc->opts2 = 0x00;
+	desc->addr = cpu_to_le64(RTK_MAGIC_NUMBER);
+}
+
+static void rtase_tx_clear_range(struct rtase_ring *ring, u32 start, u32 n)
+{
+	struct rtase_tx_desc *desc_base = ring->desc;
+	struct rtase_private *tp = ring->ivec->tp;
+	u32 i;
+
+	for (i = 0; i < n; i++) {
+		u32 entry = (start + i) % RTASE_NUM_DESC;
+		struct rtase_tx_desc *desc = desc_base + entry;
+		u32 len = ring->mis.len[entry];
+		struct sk_buff *skb;
+
+		if (len == 0)
+			continue;
+
+		rtase_unmap_tx_skb(tp->pdev, len, desc);
+		ring->mis.len[entry] = 0;
+		skb = ring->skbuff[entry];
+		if (!skb)
+			continue;
+
+		tp->stats.tx_dropped++;
+		dev_kfree_skb_any(skb);
+		ring->skbuff[entry] = NULL;
+	}
+}
+
+static void rtase_tx_clear(struct rtase_private *tp)
+{
+	struct rtase_ring *ring;
+	u16 i;
+
+	for (i = 0; i < tp->func_tx_queue_num; i++) {
+		ring = &tp->tx_ring[i];
+		rtase_tx_clear_range(ring, ring->dirty_idx, RTASE_NUM_DESC);
+		ring->cur_idx = 0;
+		ring->dirty_idx = 0;
+	}
+}
+
 static void rtase_mark_to_asic(union rtase_rx_desc *desc, u32 rx_buf_sz)
 {
 	u32 eor = le32_to_cpu(desc->desc_cmd.opts1) & RTASE_RING_END;
@@ -408,6 +458,80 @@ static void rtase_tally_counter_clear(const struct rtase_private *tp)
 	rtase_w32(tp, RTASE_DTCCR0, cmd | RTASE_COUNTER_RESET);
 }
 
+static void rtase_irq_dis_and_clear(const struct rtase_private *tp)
+{
+	const struct rtase_int_vector *ivec = &tp->int_vector[0];
+	u32 val1;
+	u16 val2;
+	u8 i;
+
+	rtase_w32(tp, ivec->imr_addr, 0);
+	val1 = rtase_r32(tp, ivec->isr_addr);
+	rtase_w32(tp, ivec->isr_addr, val1);
+
+	for (i = 1; i < tp->int_nums; i++) {
+		ivec = &tp->int_vector[i];
+		rtase_w16(tp, ivec->imr_addr, 0);
+		val2 = rtase_r16(tp, ivec->isr_addr);
+		rtase_w16(tp, ivec->isr_addr, val2);
+	}
+}
+
+static void rtase_poll_timeout(const struct rtase_private *tp, u32 cond,
+			       u32 sleep_us, u64 timeout_us, u16 reg)
+{
+	int err;
+	u8 val;
+
+	err = read_poll_timeout(rtase_r8, val, val & cond, sleep_us,
+				timeout_us, false, tp, reg);
+
+	if (err == -ETIMEDOUT)
+		netdev_err(tp->dev, "poll reg 0x00%x timeout\n", reg);
+}
+
+static void rtase_nic_reset(const struct net_device *dev)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+	u16 rx_config;
+	u8 val;
+
+	rx_config = rtase_r16(tp, RTASE_RX_CONFIG_0);
+	rtase_w16(tp, RTASE_RX_CONFIG_0, rx_config & ~RTASE_ACCEPT_MASK);
+
+	val = rtase_r8(tp, RTASE_MISC);
+	rtase_w8(tp, RTASE_MISC, val | RTASE_RX_DV_GATE_EN);
+
+	val = rtase_r8(tp, RTASE_CHIP_CMD);
+	rtase_w8(tp, RTASE_CHIP_CMD, val | RTASE_STOP_REQ);
+	mdelay(2);
+
+	rtase_poll_timeout(tp, RTASE_STOP_REQ_DONE, 100, 150000,
+			   RTASE_CHIP_CMD);
+
+	rtase_poll_timeout(tp, RTASE_TX_FIFO_EMPTY, 100, 100000,
+			   RTASE_FIFOR);
+
+	rtase_poll_timeout(tp, RTASE_RX_FIFO_EMPTY, 100, 100000,
+			   RTASE_FIFOR);
+
+	val = rtase_r8(tp, RTASE_CHIP_CMD);
+	rtase_w8(tp, RTASE_CHIP_CMD, val & ~(RTASE_TE | RTASE_RE));
+	val = rtase_r8(tp, RTASE_CHIP_CMD);
+	rtase_w8(tp, RTASE_CHIP_CMD, val & ~RTASE_STOP_REQ);
+
+	rtase_w16(tp, RTASE_RX_CONFIG_0, rx_config);
+}
+
+static void rtase_hw_reset(const struct net_device *dev)
+{
+	const struct rtase_private *tp = netdev_priv(dev);
+
+	rtase_irq_dis_and_clear(tp);
+
+	rtase_nic_reset(dev);
+}
+
 static void rtase_nic_enable(const struct net_device *dev)
 {
 	const struct rtase_private *tp = netdev_priv(dev);
@@ -511,6 +635,32 @@ static int rtase_open(struct net_device *dev)
 	return ret;
 }
 
+static void rtase_down(struct net_device *dev)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+	struct rtase_int_vector *ivec;
+	struct rtase_ring *ring, *tmp;
+	u32 i;
+
+	for (i = 0; i < tp->int_nums; i++) {
+		ivec = &tp->int_vector[i];
+		napi_disable(&ivec->napi);
+		list_for_each_entry_safe(ring, tmp, &ivec->ring_list,
+					 ring_entry)
+			list_del(&ring->ring_entry);
+	}
+
+	netif_tx_disable(dev);
+
+	netif_carrier_off(dev);
+
+	rtase_hw_reset(dev);
+
+	rtase_tx_clear(tp);
+
+	rtase_rx_clear(tp);
+}
+
 static int rtase_close(struct net_device *dev)
 {
 	struct rtase_private *tp = netdev_priv(dev);
-- 
2.34.1


