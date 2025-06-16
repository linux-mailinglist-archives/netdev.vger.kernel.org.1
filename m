Return-Path: <netdev+bounces-197940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7214DADA6C7
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 05:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48137188D923
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 03:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64B1265CA7;
	Mon, 16 Jun 2025 03:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="VxGQiHqF"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E3B2AD00;
	Mon, 16 Jun 2025 03:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750044294; cv=none; b=mpE2kRyiwpDlcavebhUGpTlJrRjDFEsh/MnSBIpV3Q5giScBIiXkr3xdPzBcag46efF9U1AJtISI7jldzGpCCSEJ6u/p6cf+pgLZifdXyzc3FGSYsFe2Jb/cSU+d5sclh4WQdAN1xhfv/xT09IA2grooLIs4yrDj8JwGkwwm364=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750044294; c=relaxed/simple;
	bh=dnYFmI7WTXdyv0vzTq8oPzXkUrdsIkxAJgEyN6UIXFs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bnJ5LT+3y/nyrQF/efzH551KXuD88yryjHGUIrb6KLi6Z97dJG9YU8322Z87PczIbnA5uhJQO/Dl2GsYALJZSRdcJj3ODP2eKtrEWjaPCHavZK8t7HwrlODjRayi4EvaBmt6ynLxhaC3otmG+9DiE2V64Jmpz4hLHO/91hYRdhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=VxGQiHqF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G3OYtbC3977912, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750044274; bh=uk6gJLTYuvpCQSI3aSNFWvJyoZx57tCzDddG6aAgmGs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=VxGQiHqFJ3tbA3GADPXL0py/Ol2USSUoxcksu2mlLrjf673cYAv1UiyK7VZEXWC2Y
	 mhwLGqcmWfL/qYuJxGBCbNMRG/vZi7NHVmMHpmdfc6hi5sJ+HyPC4ObYQ7LWiXm8U9
	 KseqkuwwY1RggI/Mi3yv/cUU3ch7OmIizwGfrGlYd5v5Wd0NxmBmnyC+gUs+eigIOB
	 5OK7Y7NBNXfco7FfMEqUzzkpv0qhFuY7DxMY60kcYyjPw55cYF5DAnh6Pop7tBtQmQ
	 hgGZ+K2+Jyrvw0PNzNxkLs/d6xSBVkfazZwbaqd/X/XqnwdctzzRmfn6RxLyFT0u6b
	 sz7SA4oNvnltw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G3OYtbC3977912
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 11:24:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 11:23:30 +0800
Received: from RTDOMAIN (172.21.210.109) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 16 Jun
 2025 11:23:29 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <jdamato@fastly.com>,
        <pkshih@realtek.com>, <larry.chiu@realtek.com>,
        Justin Lai
	<justinlai0215@realtek.com>
Subject: [PATCH net-next v2 2/2] rtase: Link queues to NAPI instances
Date: Mon, 16 Jun 2025 11:22:26 +0800
Message-ID: <20250616032226.7318-3-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616032226.7318-1-justinlai0215@realtek.com>
References: <20250616032226.7318-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Link queues to NAPI instances with netif_queue_set_napi. This
information can be queried with the netdev-genl API.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase.h    |  1 +
 .../net/ethernet/realtek/rtase/rtase_main.c   | 19 +++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
index 498cfe4d0cac..20decdeb9fdb 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase.h
+++ b/drivers/net/ethernet/realtek/rtase/rtase.h
@@ -288,6 +288,7 @@ struct rtase_ring {
 	u32 cur_idx;
 	u32 dirty_idx;
 	u16 index;
+	u8 type;
 
 	struct sk_buff *skbuff[RTASE_NUM_DESC];
 	void *data_buf[RTASE_NUM_DESC];
diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index d13877f051e7..ef13109c49cf 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -326,6 +326,7 @@ static void rtase_tx_desc_init(struct rtase_private *tp, u16 idx)
 	ring->cur_idx = 0;
 	ring->dirty_idx = 0;
 	ring->index = idx;
+	ring->type = NETDEV_QUEUE_TYPE_TX;
 	ring->alloc_fail = 0;
 
 	for (i = 0; i < RTASE_NUM_DESC; i++) {
@@ -345,6 +346,9 @@ static void rtase_tx_desc_init(struct rtase_private *tp, u16 idx)
 		ring->ivec = &tp->int_vector[0];
 		list_add_tail(&ring->ring_entry, &tp->int_vector[0].ring_list);
 	}
+
+	netif_queue_set_napi(tp->dev, ring->index,
+			     ring->type, &ring->ivec->napi);
 }
 
 static void rtase_map_to_asic(union rtase_rx_desc *desc, dma_addr_t mapping,
@@ -590,6 +594,7 @@ static void rtase_rx_desc_init(struct rtase_private *tp, u16 idx)
 	ring->cur_idx = 0;
 	ring->dirty_idx = 0;
 	ring->index = idx;
+	ring->type = NETDEV_QUEUE_TYPE_RX;
 	ring->alloc_fail = 0;
 
 	for (i = 0; i < RTASE_NUM_DESC; i++)
@@ -597,6 +602,8 @@ static void rtase_rx_desc_init(struct rtase_private *tp, u16 idx)
 
 	ring->ring_handler = rx_handler;
 	ring->ivec = &tp->int_vector[idx];
+	netif_queue_set_napi(tp->dev, ring->index,
+			     ring->type, &ring->ivec->napi);
 	list_add_tail(&ring->ring_entry, &tp->int_vector[idx].ring_list);
 }
 
@@ -1161,8 +1168,12 @@ static void rtase_down(struct net_device *dev)
 		ivec = &tp->int_vector[i];
 		napi_disable(&ivec->napi);
 		list_for_each_entry_safe(ring, tmp, &ivec->ring_list,
-					 ring_entry)
+					 ring_entry) {
+			netif_queue_set_napi(tp->dev, ring->index,
+					     ring->type, NULL);
+
 			list_del(&ring->ring_entry);
+		}
 	}
 
 	netif_tx_disable(dev);
@@ -1518,8 +1529,12 @@ static void rtase_sw_reset(struct net_device *dev)
 	for (i = 0; i < tp->int_nums; i++) {
 		ivec = &tp->int_vector[i];
 		list_for_each_entry_safe(ring, tmp, &ivec->ring_list,
-					 ring_entry)
+					 ring_entry) {
+			netif_queue_set_napi(tp->dev, ring->index,
+					     ring->type, NULL);
+
 			list_del(&ring->ring_entry);
+		}
 	}
 
 	ret = rtase_init_ring(dev);
-- 
2.34.1


