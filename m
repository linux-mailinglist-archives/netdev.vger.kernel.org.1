Return-Path: <netdev+bounces-182025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D87D1A87642
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 05:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA81188AC40
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 03:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A5D151990;
	Mon, 14 Apr 2025 03:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="H6ixMF+f"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275B74C62;
	Mon, 14 Apr 2025 03:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744602171; cv=none; b=DCkgC1NVHIVkUe4CvZeT8jZv39rCE/frk9la6O0AsQi0c23QE+60zGD/7rVp6061m+fsX+hbUdfUQXTkBGemxV0iMw8w6nWmpya87W3WtuVaydjxpaar1NrTVyiZQnBiXGjxdwhOY6APrqPXFHpRMfYYj5MDKz20iFu8clT4bik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744602171; c=relaxed/simple;
	bh=akYAeKGVkCWyMEFgr8P3v+S+1gUdUXhs4zalfRa00k0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MW8rQ3Fh7328ynWm+hNF7c96CcMPsM/BfeBGX72hWzz7OMbh1AMXy4NSAXF8JiZQTc4T96KlMvhCbLizBuQQD2wUNfqIQKRaGO6Q0+jL8XPryc5Xkw4u5SkKTsjnSdAwiyurLI6+aJQfm/oretbmg70CJmwWoslzGq6pX4NlvKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=H6ixMF+f; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53E3gAedD2304343, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744602130; bh=akYAeKGVkCWyMEFgr8P3v+S+1gUdUXhs4zalfRa00k0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=H6ixMF+fJ8ARNa/+XslpG5J5si/HgZmMegjBvirG5n4W3Hh2UC3G8oQCRyyP7cjkY
	 tG+8RFH8auVSKYRACtelMTc3/8RPRDTTWlbkIIeRJdZL7/MPHZcC5WtgOX92g7tp5Y
	 wsGK6a4qdTDAEICi0L7AbM+n1WF9oMcdfmxbmVZWldsmDuoo5ZRRAK1zI+jrJIYyIL
	 e3J9RhoGcv7pmHmNlYjW4S9rgKJj1N9+FGrx6Ix+uRxAcwZjmJ8H/1XeLmrymxYh2v
	 Zaq4WHswJNZ/oHP0T2/57aqPSXO8q84LK4tllPuQGMoUHyRg20lzG5IJJ8z8lSdLC8
	 mAsHVb4kZ6CKg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53E3gAedD2304343
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 11:42:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Apr 2025 11:42:11 +0800
Received: from RTDOMAIN (172.21.210.70) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 14 Apr
 2025 11:42:10 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net-next v3] rtase: Add ndo_setup_tc support for CBS offload in traffic control setup
Date: Mon, 14 Apr 2025 11:42:02 +0800
Message-ID: <20250414034202.7261-1-justinlai0215@realtek.com>
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
v1 -> v2:
- Add a check to ensure that qopt->queue is within the specified range.
- Add a check for qopt->enable and handle it appropriately.

v2 -> v3:
- Nothing has changed, and it is simply being posted again now that
net-next has reopened.
---
 drivers/net/ethernet/realtek/rtase/rtase.h    | 15 +++++
 .../net/ethernet/realtek/rtase/rtase_main.c   | 60 +++++++++++++++++++
 2 files changed, 75 insertions(+)

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
index 2aacc1996796..6251548d50ff 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1661,6 +1661,65 @@ static void rtase_get_stats64(struct net_device *dev,
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
+static int rtase_setup_tc_cbs(struct rtase_private *tp,
+			      const struct tc_cbs_qopt_offload *qopt)
+{
+	int queue = qopt->queue;
+
+	if (queue < 0 || queue >= tp->func_tx_queue_num)
+		return -EINVAL;
+
+	if (!qopt->enable) {
+		tp->tx_qos[queue].hicredit = 0;
+		tp->tx_qos[queue].locredit = 0;
+		tp->tx_qos[queue].idleslope = 0;
+		tp->tx_qos[queue].sendslope = 0;
+
+		rtase_w32(tp, RTASE_TXQCRDT_0 + queue * 4, 0);
+	} else {
+		tp->tx_qos[queue].hicredit = qopt->hicredit;
+		tp->tx_qos[queue].locredit = qopt->locredit;
+		tp->tx_qos[queue].idleslope = qopt->idleslope;
+		tp->tx_qos[queue].sendslope = qopt->sendslope;
+
+		rtase_set_hw_cbs(tp, queue);
+	}
+
+	return 0;
+}
+
+static int rtase_setup_tc(struct net_device *dev, enum tc_setup_type type,
+			  void *type_data)
+{
+	struct rtase_private *tp = netdev_priv(dev);
+
+	switch (type) {
+	case TC_SETUP_QDISC_CBS:
+		return rtase_setup_tc_cbs(tp, type_data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static netdev_features_t rtase_fix_features(struct net_device *dev,
 					    netdev_features_t features)
 {
@@ -1696,6 +1755,7 @@ static const struct net_device_ops rtase_netdev_ops = {
 	.ndo_change_mtu = rtase_change_mtu,
 	.ndo_tx_timeout = rtase_tx_timeout,
 	.ndo_get_stats64 = rtase_get_stats64,
+	.ndo_setup_tc = rtase_setup_tc,
 	.ndo_fix_features = rtase_fix_features,
 	.ndo_set_features = rtase_set_features,
 };
-- 
2.34.1


