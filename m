Return-Path: <netdev+bounces-174829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C40A60D8E
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 10:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A753B2EAA
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 09:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CD01EEA30;
	Fri, 14 Mar 2025 09:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="EL46Phh7"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF34B1DF261;
	Fri, 14 Mar 2025 09:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945262; cv=none; b=lLCxXMRUwj/DDvvQsN1ObIhm/D9rySogsA5IEKi045z0KXvD3ZuqSJefSz2/nmGrwIX/tfER1tMuG7WHYUc+RPPxFLAOHajmbquFkS/QOT6PJQSNRzkvmYt88v9jFkVZ2/+Wg/wzGATyySe0kjvfRGVmDkcnzLnv/XwaScanzsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945262; c=relaxed/simple;
	bh=udFOvdLj27iPudZRiBJ+1S1ef2uPlN9jD3ISs0kURzg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tnvc8W94LNa7Ez8awP0lpYTITR/oYsmdOVCQJIbBGlt9QDWCeBaKgGfYxUWRsbUj0AWC6KD/2hX1iJOcJWO1sgCAflJIexBBsIaD8mjha6ZxMXnHYiz6KyeZ/uJyPWHZu41phRsyyiQ+PG9EuNIaZ/ludVtKsTJAkRoKtuNhhLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=EL46Phh7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52E9eae672853427, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741945236; bh=udFOvdLj27iPudZRiBJ+1S1ef2uPlN9jD3ISs0kURzg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=EL46Phh7LRGl8rzVloXPKtzZ9PvboaNbVrhrqNjDf4MekzHupe15DBZlXtNRzbFKa
	 8ivN3R7IekMUMsiOLV26s/SjNw1BqmWzz/zjpg6u2ucZINjTWthHBdPFRqlFOv+ylb
	 6+gJF8nMjPKCHxgguaAN1sdoPnEDItsSgakmFQ3J6IUR8c8bPSEFh0noH7QQ51su8h
	 9NJXcMDBevz7UB+NeFRs7muCGRF91kz8a2bpDdKdiCyOTGyZ2PzOE4McEbGhlXGHhK
	 zUpBUBjpitYYCyt29ZkSJ6cfnXSGeZIEdC6IX7EAr1w20haTn0jfg9QAjnvdpu1FAn
	 YTbPSR0CLKAPQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52E9eae672853427
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 17:40:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Mar 2025 17:40:37 +0800
Received: from RTDOMAIN (172.21.210.70) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 14 Mar
 2025 17:40:34 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net-next] rtase: Add ndo_setup_tc support for CBS offload in traffic control setup
Date: Fri, 14 Mar 2025 17:40:21 +0800
Message-ID: <20250314094021.10120-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
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

Add support for ndo_setup_tc to enable CBS offload functionality as
part of traffic control configuration for network devices.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase.h    | 15 ++++++
 .../net/ethernet/realtek/rtase/rtase_main.c   | 49 +++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
index 2bbfcad613ab..498cfe4d0cac 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase.h
+++ b/drivers/net/ethernet/realtek/rtase/rtase.h
@@ -170,6 +170,7 @@ enum rtase_registers {
 #define RTASE_TC_MODE_MASK GENMASK(11, 10)
 
 	RTASE_TOKSEL      = 0x2046,
+	RTASE_TXQCRDT_0   = 0x2500,
 	RTASE_RFIFONFULL  = 0x4406,
 	RTASE_INT_MITI_TX = 0x0A00,
 	RTASE_INT_MITI_RX = 0x0A80,
@@ -259,6 +260,12 @@ union rtase_rx_desc {
 #define RTASE_VLAN_TAG_MASK     GENMASK(15, 0)
 #define RTASE_RX_PKT_SIZE_MASK  GENMASK(13, 0)
 
+/* txqos hardware definitions */
+#define RTASE_1T_CLOCK            64
+#define RTASE_1T_POWER            10000000
+#define RTASE_IDLESLOPE_INT_SHIFT 25
+#define RTASE_IDLESLOPE_INT_MASK  GENMASK(31, 25)
+
 #define RTASE_IVEC_NAME_SIZE (IFNAMSIZ + 10)
 
 struct rtase_int_vector {
@@ -294,6 +301,13 @@ struct rtase_ring {
 	u64 alloc_fail;
 };
 
+struct rtase_txqos {
+	int hicredit;
+	int locredit;
+	int idleslope;
+	int sendslope;
+};
+
 struct rtase_stats {
 	u64 tx_dropped;
 	u64 rx_dropped;
@@ -313,6 +327,7 @@ struct rtase_private {
 
 	struct page_pool *page_pool;
 	struct rtase_ring tx_ring[RTASE_NUM_TX_QUEUE];
+	struct rtase_txqos tx_qos[RTASE_NUM_TX_QUEUE];
 	struct rtase_ring rx_ring[RTASE_NUM_RX_QUEUE];
 	struct rtase_counters *tally_vaddr;
 	dma_addr_t tally_paddr;
diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 2aacc1996796..2a61cd192026 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1661,6 +1661,54 @@ static void rtase_get_stats64(struct net_device *dev,
 	stats->rx_length_errors = tp->stats.rx_length_errors;
 }
 
+static void rtase_set_hw_cbs(const struct rtase_private *tp, u32 queue)
+{
+	u32 idle = tp->tx_qos[queue].idleslope * RTASE_1T_CLOCK;
+	u32 val, i;
+
+	val = u32_encode_bits(idle / RTASE_1T_POWER, RTASE_IDLESLOPE_INT_MASK);
+	idle %= RTASE_1T_POWER;
+
+	for (i = 1; i <= RTASE_IDLESLOPE_INT_SHIFT; i++) {
+		idle *= 2;
+		if ((idle / RTASE_1T_POWER) == 1)
+			val |= BIT(RTASE_IDLESLOPE_INT_SHIFT - i);
+
+		idle %= RTASE_1T_POWER;
+	}
+
+	rtase_w32(tp, RTASE_TXQCRDT_0 + queue * 4, val);
+}
+
+static void rtase_setup_tc_cbs(struct rtase_private *tp,
+			       const struct tc_cbs_qopt_offload *qopt)
+{
+	u32 queue = qopt->queue;
+
+	tp->tx_qos[queue].hicredit = qopt->hicredit;
+	tp->tx_qos[queue].locredit = qopt->locredit;
+	tp->tx_qos[queue].idleslope = qopt->idleslope;
+	tp->tx_qos[queue].sendslope = qopt->sendslope;
+
+	rtase_set_hw_cbs(tp, queue);
+}
+
+static int rtase_setup_tc(struct net_device *dev, enum tc_setup_type type,
+			  void *type_data)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+
+	switch (type) {
+	case TC_SETUP_QDISC_CBS:
+		rtase_setup_tc_cbs(tp, type_data);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static netdev_features_t rtase_fix_features(struct net_device *dev,
 					    netdev_features_t features)
 {
@@ -1696,6 +1744,7 @@ static const struct net_device_ops rtase_netdev_ops = {
 	.ndo_change_mtu = rtase_change_mtu,
 	.ndo_tx_timeout = rtase_tx_timeout,
 	.ndo_get_stats64 = rtase_get_stats64,
+	.ndo_setup_tc = rtase_setup_tc,
 	.ndo_fix_features = rtase_fix_features,
 	.ndo_set_features = rtase_set_features,
 };
-- 
2.34.1


