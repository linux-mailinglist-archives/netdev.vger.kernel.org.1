Return-Path: <netdev+bounces-238633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3901BC5C481
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 10:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7CE84FA35A
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 09:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9905305948;
	Fri, 14 Nov 2025 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="fqyGTAkT"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1083019B2;
	Fri, 14 Nov 2025 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112201; cv=none; b=qxNx3S3yxh68RKilNQaoBDd/u3hs6LuR8Rm/Pb1b6r66pC5rcFTyMxLXBQDNyuofPzl0zdSnq5SE3IPN9kJCYhOQW4y+GvuDqemidQ+F6WXSgL+K9yAwLpCh7EhMLRxbTLFW6Z6JXuS+Vwn9tWFqncO6BYJH8uF0g4mbPXQyFr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112201; c=relaxed/simple;
	bh=qhA9HrVIyGp0rmSliY21AI+PexOFbnsS0md6s/x5L+E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B7cfnnqUpNjJQWxfYKDLNZJg1tuZrQAuM8RelPUv3/N0OiTXRULqc8xcslgv0pzgQDHLVtdWXg2vowk0khwPkpLh+Cpk1MUoAexM8NZHlM4HgVVCUPEJ0Gtpa8VcDe7hah8Vu7lTpgcZwushC8fQekQomiHHpKHlKV1jlvT21ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=fqyGTAkT; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JxI/9OTgPKE8lW7Ar+EpvZl1IaGpbnnrdXqbr/0/GKg=;
	b=fqyGTAkT82mLn2s2B/oekByWKPiGqmdByJtdpAQ9x30oQudJL5g8xSIBK7Rv657Hu5iEYjfeL
	RQsGbgED2+HqB5fU+tMLBN7unXZfAOlrxF/6hkOI2lPWXkmMHyUBekEAknbvd+v8WtdokWgbGpg
	ITOf9iu2/5vzaY/Jn/0LZ0g=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4d7BTq0QrVz1cyR3;
	Fri, 14 Nov 2025 17:21:35 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 18F8A1A016C;
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
Subject: [PATCH net-next 1/3] net: hibmcge: Add tracepoint function to print some fields of rx_desc
Date: Fri, 14 Nov 2025 17:22:20 +0800
Message-ID: <20251114092222.2071583-2-shaojijie@huawei.com>
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

From: Tao Lan <lantao5@huawei.com>

Add tracepoint function to print some fields of rx_desc

Signed-off-by: Tao Lan <lantao5@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../net/ethernet/hisilicon/hibmcge/Makefile   |  1 +
 .../net/ethernet/hisilicon/hibmcge/hbg_reg.h  |  4 +
 .../ethernet/hisilicon/hibmcge/hbg_trace.h    | 84 +++++++++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c |  4 +
 4 files changed, 93 insertions(+)
 create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/hbg_trace.h

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/Makefile b/drivers/net/ethernet/hisilicon/hibmcge/Makefile
index 1a9da564b306..d6610ba16855 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/Makefile
+++ b/drivers/net/ethernet/hisilicon/hibmcge/Makefile
@@ -3,6 +3,7 @@
 # Makefile for the HISILICON BMC GE network device drivers.
 #
 
+ccflags-y += -I$(src)
 obj-$(CONFIG_HIBMCGE) += hibmcge.o
 
 hibmcge-objs = hbg_main.o hbg_hw.o hbg_mdio.o hbg_irq.o hbg_txrx.o hbg_ethtool.o \
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index a39d1e796e4a..30b3903c8f2d 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -252,6 +252,8 @@ struct hbg_rx_desc {
 
 #define HBG_RX_DESC_W2_PKT_LEN_M	GENMASK(31, 16)
 #define HBG_RX_DESC_W2_PORT_NUM_M	GENMASK(15, 12)
+#define HBG_RX_DESC_W3_IP_OFFSET_M	GENMASK(23, 16)
+#define HBG_RX_DESC_W3_VLAN_M		GENMASK(15, 0)
 #define HBG_RX_DESC_W4_IP_TCP_UDP_M	GENMASK(31, 30)
 #define HBG_RX_DESC_W4_IPSEC_B		BIT(29)
 #define HBG_RX_DESC_W4_IP_VERSION_B	BIT(28)
@@ -269,6 +271,8 @@ struct hbg_rx_desc {
 #define HBG_RX_DESC_W4_L3_ERR_CODE_M	GENMASK(12, 9)
 #define HBG_RX_DESC_W4_L2_ERR_B		BIT(8)
 #define HBG_RX_DESC_W4_IDX_MATCH_B	BIT(7)
+#define HBG_RX_DESC_W4_PARSE_MODE_M	GENMASK(6, 5)
+#define HBG_RX_DESC_W5_VALID_SIZE_M	GENMASK(15, 0)
 
 enum hbg_l3_err_code {
 	HBG_L3_OK = 0,
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_trace.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_trace.h
new file mode 100644
index 000000000000..b70fd960da8d
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_trace.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2025 Hisilicon Limited. */
+
+/* This must be outside ifdef _HBG_TRACE_H */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM hibmcge
+
+#if !defined(_HBG_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
+#define _HBG_TRACE_H_
+
+#include <linux/bitfield.h>
+#include <linux/pci.h>
+#include <linux/tracepoint.h>
+#include <linux/types.h>
+#include "hbg_reg.h"
+
+TRACE_EVENT(hbg_rx_desc,
+	    TP_PROTO(struct hbg_priv *priv, u32 index,
+		     struct hbg_rx_desc *rx_desc),
+	    TP_ARGS(priv, index, rx_desc),
+
+	    TP_STRUCT__entry(__field(u32, index)
+			     __field(u8, port_num)
+			     __field(u8, ip_offset)
+			     __field(u8, parse_mode)
+			     __field(u8, l4_error_code)
+			     __field(u8, l3_error_code)
+			     __field(u8, l2_error_code)
+			     __field(u16, packet_len)
+			     __field(u16, valid_size)
+			     __field(u16, vlan)
+			     __string(pciname, pci_name(priv->pdev))
+			     __string(devname, priv->netdev->name)
+	    ),
+
+	    TP_fast_assign(__entry->index = index,
+			   __entry->packet_len =
+				FIELD_GET(HBG_RX_DESC_W2_PKT_LEN_M,
+					  rx_desc->word2);
+			   __entry->port_num =
+				FIELD_GET(HBG_RX_DESC_W2_PORT_NUM_M,
+					  rx_desc->word2);
+			   __entry->ip_offset =
+				FIELD_GET(HBG_RX_DESC_W3_IP_OFFSET_M,
+					  rx_desc->word3);
+			   __entry->vlan =
+				FIELD_GET(HBG_RX_DESC_W3_VLAN_M,
+					  rx_desc->word3);
+			   __entry->parse_mode =
+				FIELD_GET(HBG_RX_DESC_W4_PARSE_MODE_M,
+					  rx_desc->word4);
+			   __entry->l4_error_code =
+				FIELD_GET(HBG_RX_DESC_W4_L4_ERR_CODE_M,
+					  rx_desc->word4);
+			   __entry->l3_error_code =
+				FIELD_GET(HBG_RX_DESC_W4_L3_ERR_CODE_M,
+					  rx_desc->word4);
+			   __entry->l2_error_code =
+				FIELD_GET(HBG_RX_DESC_W4_L2_ERR_B,
+					  rx_desc->word4);
+			   __entry->valid_size =
+				FIELD_GET(HBG_RX_DESC_W5_VALID_SIZE_M,
+					  rx_desc->word5);
+			   __assign_str(pciname);
+			   __assign_str(devname);
+	    ),
+
+	    TP_printk("%s %s index:%u, port num:%u, len:%u, valid size:%u, ip_offset:%u, vlan:0x%04x, parse mode:%u, l4_err:0x%x, l3_err:0x%x, l2_err:0x%x",
+		      __get_str(pciname), __get_str(devname), __entry->index,
+		      __entry->port_num, __entry->packet_len,
+		      __entry->valid_size, __entry->ip_offset,  __entry->vlan,
+		      __entry->parse_mode, __entry->l4_error_code,
+		      __entry->l3_error_code, __entry->l2_error_code
+	    )
+);
+
+#endif /* _HBG_TRACE_H_ */
+
+/* This must be outside ifdef _HBG_TRACE_H */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE hbg_trace
+#include <trace/define_trace.h>
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
index 8d814c8f19ea..5f2e48f1dd25 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
@@ -7,6 +7,9 @@
 #include "hbg_reg.h"
 #include "hbg_txrx.h"
 
+#define CREATE_TRACE_POINTS
+#include "hbg_trace.h"
+
 #define netdev_get_tx_ring(netdev) \
 			(&(((struct hbg_priv *)netdev_priv(netdev))->tx_ring))
 
@@ -429,6 +432,7 @@ static int hbg_napi_rx_poll(struct napi_struct *napi, int budget)
 			break;
 		rx_desc = (struct hbg_rx_desc *)buffer->skb->data;
 		pkt_len = FIELD_GET(HBG_RX_DESC_W2_PKT_LEN_M, rx_desc->word2);
+		trace_hbg_rx_desc(priv, ring->ntc, rx_desc);
 
 		if (unlikely(!hbg_rx_pkt_check(priv, rx_desc, buffer->skb))) {
 			hbg_buffer_free(buffer);
-- 
2.33.0


