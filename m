Return-Path: <netdev+bounces-165795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29845A33682
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 05:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06733A49EA
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 04:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0DE2054F2;
	Thu, 13 Feb 2025 04:03:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5540204F82;
	Thu, 13 Feb 2025 04:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739419399; cv=none; b=NZ8yg6MiO9dYLyuB4L6iTrYkCnlre978kP08wWQR68NoOfu4mfT4dyZ1KQnXrxQ9sKLRPOw5cioVTulhjDsXi/n1ybVnDLpth7ed2qsdJH+THKcJ8rZXdzuFb045/bi7zX5XXXYU8GSFkXTWwiNUL2qrRpdqUQ4PrWdj2AH23Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739419399; c=relaxed/simple;
	bh=h1f6S0iKWazCYRrrC5Faf6gA6BzAh9T9kmFlU3KOjr8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qL54ZjtiRNMoZ4y3UTYZCxORb+LD9mijs1N6jt8NITnOQDGWUyrCHCF9pJkRMQF+5XXm1fksBHPkAHDcaU7rPuIDVbtaxD12WRVtqE3lagOL67aMSopgg/duIjO34ves07zlBXDJtp4ykahSnKgiCQpc1oQj2nb5aqU31T1mY8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YthHp0FSkzwWWy;
	Thu, 13 Feb 2025 11:58:46 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 405681402E2;
	Thu, 13 Feb 2025 12:03:14 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 13 Feb 2025 12:03:13 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next 3/7] net: hibmcge: Add rx checksum offload supported in this module
Date: Thu, 13 Feb 2025 11:55:25 +0800
Message-ID: <20250213035529.2402283-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250213035529.2402283-1-shaojijie@huawei.com>
References: <20250213035529.2402283-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)

This patch implements the rx checksum offload feature
including NETIF_F_IP_CSUM NETIF_F_IPV6_CSUM and NETIF_F_RXCSUM

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c | 13 ++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 20 +++++++++++++++----
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 4667e51ccc2d..813f1a1c900f 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -14,6 +14,9 @@
 #include "hbg_txrx.h"
 #include "hbg_debugfs.h"
 
+#define HBG_SUPPORT_FEATURES (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | \
+			     NETIF_F_RXCSUM)
+
 static void hbg_all_irq_enable(struct hbg_priv *priv, bool enabled)
 {
 	struct hbg_irq_info *info;
@@ -263,6 +266,12 @@ static void hbg_net_get_stats(struct net_device *netdev,
 	stats->rx_crc_errors += h_stats->rx_fcs_error_cnt;
 }
 
+static netdev_features_t hbg_net_fix_features(struct net_device *netdev,
+					      netdev_features_t features)
+{
+	return features & HBG_SUPPORT_FEATURES;
+}
+
 static const struct net_device_ops hbg_netdev_ops = {
 	.ndo_open		= hbg_net_open,
 	.ndo_stop		= hbg_net_stop,
@@ -273,6 +282,7 @@ static const struct net_device_ops hbg_netdev_ops = {
 	.ndo_tx_timeout		= hbg_net_tx_timeout,
 	.ndo_set_rx_mode	= hbg_net_set_rx_mode,
 	.ndo_get_stats64	= hbg_net_get_stats,
+	.ndo_fix_features	= hbg_net_fix_features,
 };
 
 static void hbg_service_task(struct work_struct *work)
@@ -419,6 +429,9 @@ static int hbg_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		return ret;
 
+	/* set default features */
+	netdev->features |= HBG_SUPPORT_FEATURES;
+	netdev->hw_features |= HBG_SUPPORT_FEATURES;
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 
 	netdev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
index 8c631a9bcb6b..aa1d128a863b 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
@@ -202,8 +202,11 @@ static int hbg_napi_tx_recycle(struct napi_struct *napi, int budget)
 }
 
 static bool hbg_rx_check_l3l4_error(struct hbg_priv *priv,
-				    struct hbg_rx_desc *desc)
+				    struct hbg_rx_desc *desc,
+				    struct sk_buff *skb)
 {
+	bool rx_checksum_offload = priv->netdev->features & NETIF_F_RXCSUM;
+
 	if (likely(!FIELD_GET(HBG_RX_DESC_W4_L3_ERR_CODE_M, desc->word4) &&
 		   !FIELD_GET(HBG_RX_DESC_W4_L4_ERR_CODE_M, desc->word4)))
 		return true;
@@ -215,6 +218,10 @@ static bool hbg_rx_check_l3l4_error(struct hbg_priv *priv,
 		priv->stats.rx_desc_l3_wrong_head_cnt++;
 		return false;
 	case HBG_L3_CSUM_ERR:
+		if (!rx_checksum_offload) {
+			skb->ip_summed = CHECKSUM_NONE;
+			break;
+		}
 		priv->stats.rx_desc_l3_csum_err_cnt++;
 		return false;
 	case HBG_L3_LEN_ERR:
@@ -238,6 +245,10 @@ static bool hbg_rx_check_l3l4_error(struct hbg_priv *priv,
 		priv->stats.rx_desc_l4_len_err_cnt++;
 		return false;
 	case HBG_L4_CSUM_ERR:
+		if (!rx_checksum_offload) {
+			skb->ip_summed = CHECKSUM_NONE;
+			break;
+		}
 		priv->stats.rx_desc_l4_csum_err_cnt++;
 		return false;
 	case HBG_L4_ZERO_PORT_NUM:
@@ -322,7 +333,8 @@ static void hbg_update_rx_protocol_stats(struct hbg_priv *priv,
 	hbg_update_rx_ip_protocol_stats(priv, desc);
 }
 
-static bool hbg_rx_pkt_check(struct hbg_priv *priv, struct hbg_rx_desc *desc)
+static bool hbg_rx_pkt_check(struct hbg_priv *priv, struct hbg_rx_desc *desc,
+			     struct sk_buff *skb)
 {
 	if (unlikely(FIELD_GET(HBG_RX_DESC_W2_PKT_LEN_M, desc->word2) >
 		     priv->dev_specs.max_frame_len)) {
@@ -342,7 +354,7 @@ static bool hbg_rx_pkt_check(struct hbg_priv *priv, struct hbg_rx_desc *desc)
 		return false;
 	}
 
-	if (unlikely(!hbg_rx_check_l3l4_error(priv, desc))) {
+	if (unlikely(!hbg_rx_check_l3l4_error(priv, desc, skb))) {
 		priv->stats.rx_desc_l3l4_err_cnt++;
 		return false;
 	}
@@ -419,7 +431,7 @@ static int hbg_napi_rx_poll(struct napi_struct *napi, int budget)
 			goto next_buffer;
 		}
 
-		if (unlikely(!hbg_rx_pkt_check(priv, rx_desc))) {
+		if (unlikely(!hbg_rx_pkt_check(priv, rx_desc, buffer->skb))) {
 			hbg_buffer_free(buffer);
 			goto next_buffer;
 		}
-- 
2.33.0


