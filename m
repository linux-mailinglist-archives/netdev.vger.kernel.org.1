Return-Path: <netdev+bounces-170678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D66A498AE
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 13:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0FA33B571A
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 12:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B9A26A1B7;
	Fri, 28 Feb 2025 12:01:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E1826A0E1;
	Fri, 28 Feb 2025 12:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740744108; cv=none; b=OfYd9iPxAYLKF7EamNHoPSDyZ3vkAsRIaqe/X+fu29kjBr3cF61Mhe0lJ3gMEbXbK68JowtrbJ/o3l5N84Cd5yGVenjXWDOQu1XGn2kD0bbWTzxURGbUn4ma6JXKDWtbnnXcSy2oNn2cbMhYXGlAgckLPDEK1kJ+XiKBSCQ975I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740744108; c=relaxed/simple;
	bh=CdUzwIq2crQloPmcrMvb8FhYXHdnxG0/9g4YFAaV2x8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gpuGlU3xgYkA9Xhz5m3+7sKZJO6Uq1PJJ/yTUG02SEOwd75pTJiTVnOmBCxCs2VZoiYVwAWi/i8Gdh2gvNELMcYgZ/t979TLdYt52l0YLRsof8muXBCPUqh12m4jffekyg9xA1wrNdQ8MsQQpdT8/B6kFcF8ppoxbYUT3qBuLiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z46CP1f7Fz1ltXr;
	Fri, 28 Feb 2025 19:57:37 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C01B14010D;
	Fri, 28 Feb 2025 20:01:43 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 28 Feb 2025 20:01:42 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kalesh-anakkur.purayil@broadcom.com>,
	<shaojijie@huawei.com>
Subject: [PATCH v4 net-next 2/6] net: hibmcge: Add support for checksum offload
Date: Fri, 28 Feb 2025 19:54:07 +0800
Message-ID: <20250228115411.1750803-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250228115411.1750803-1-shaojijie@huawei.com>
References: <20250228115411.1750803-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk100013.china.huawei.com (7.202.194.61)

This patch implements the rx checksum offload feature.

The tx checksum offload processing in .ndo_start_xmit()
has been accepted. This patch also adds the tx checksum
feature, including NETIF_F_IP_CSUM and NETIF_F_IPV6_CSUM

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
ChangeLog:
v3 -> v4:
  - Don't drop packets on csum validation failure, suggested by Jakub Kicinski.
  v3: https://lore.kernel.org/all/20250221115526.1082660-2-shaojijie@huawei.com/
v2 -> v3:
  - Remove .ndo_fix_features() suggested by Jakub Kicinski.
  v2: https://lore.kernel.org/all/20250218085829.3172126-1-shaojijie@huawei.com/
v1 -> v2:
  - Use !! to convert integer to boolean, suggested by Simon Horman.
  v1: https://lore.kernel.org/all/20250213035529.2402283-1-shaojijie@huawei.com/
---
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |  6 ++++
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 29 +++++++++++++++----
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 969df6020942..688f408de84c 100644
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
@@ -419,6 +422,9 @@ static int hbg_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		return ret;
 
+	/* set default features */
+	netdev->features |= HBG_SUPPORT_FEATURES;
+	netdev->hw_features |= HBG_SUPPORT_FEATURES;
 	netdev->priv_flags |= IFF_UNICAST_FLT;
 
 	netdev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
index 35dd3512d00e..8d814c8f19ea 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
@@ -202,8 +202,14 @@ static int hbg_napi_tx_recycle(struct napi_struct *napi, int budget)
 }
 
 static bool hbg_rx_check_l3l4_error(struct hbg_priv *priv,
-				    struct hbg_rx_desc *desc)
+				    struct hbg_rx_desc *desc,
+				    struct sk_buff *skb)
 {
+	bool rx_checksum_offload = !!(priv->netdev->features & NETIF_F_RXCSUM);
+
+	skb->ip_summed = rx_checksum_offload ?
+			 CHECKSUM_UNNECESSARY : CHECKSUM_NONE;
+
 	if (likely(!FIELD_GET(HBG_RX_DESC_W4_L3_ERR_CODE_M, desc->word4) &&
 		   !FIELD_GET(HBG_RX_DESC_W4_L4_ERR_CODE_M, desc->word4)))
 		return true;
@@ -215,8 +221,13 @@ static bool hbg_rx_check_l3l4_error(struct hbg_priv *priv,
 		priv->stats.rx_desc_l3_wrong_head_cnt++;
 		return false;
 	case HBG_L3_CSUM_ERR:
+		skb->ip_summed = CHECKSUM_NONE;
 		priv->stats.rx_desc_l3_csum_err_cnt++;
-		return false;
+
+		/* Don't drop packets on csum validation failure,
+		 * suggest by Jakub
+		 */
+		break;
 	case HBG_L3_LEN_ERR:
 		priv->stats.rx_desc_l3_len_err_cnt++;
 		return false;
@@ -238,8 +249,13 @@ static bool hbg_rx_check_l3l4_error(struct hbg_priv *priv,
 		priv->stats.rx_desc_l4_len_err_cnt++;
 		return false;
 	case HBG_L4_CSUM_ERR:
+		skb->ip_summed = CHECKSUM_NONE;
 		priv->stats.rx_desc_l4_csum_err_cnt++;
-		return false;
+
+		/* Don't drop packets on csum validation failure,
+		 * suggest by Jakub
+		 */
+		break;
 	case HBG_L4_ZERO_PORT_NUM:
 		priv->stats.rx_desc_l4_zero_port_num_cnt++;
 		return false;
@@ -322,7 +338,8 @@ static void hbg_update_rx_protocol_stats(struct hbg_priv *priv,
 	hbg_update_rx_ip_protocol_stats(priv, desc);
 }
 
-static bool hbg_rx_pkt_check(struct hbg_priv *priv, struct hbg_rx_desc *desc)
+static bool hbg_rx_pkt_check(struct hbg_priv *priv, struct hbg_rx_desc *desc,
+			     struct sk_buff *skb)
 {
 	if (unlikely(FIELD_GET(HBG_RX_DESC_W2_PKT_LEN_M, desc->word2) >
 		     priv->dev_specs.max_frame_len)) {
@@ -342,7 +359,7 @@ static bool hbg_rx_pkt_check(struct hbg_priv *priv, struct hbg_rx_desc *desc)
 		return false;
 	}
 
-	if (unlikely(!hbg_rx_check_l3l4_error(priv, desc))) {
+	if (unlikely(!hbg_rx_check_l3l4_error(priv, desc, skb))) {
 		priv->stats.rx_desc_l3l4_err_cnt++;
 		return false;
 	}
@@ -413,7 +430,7 @@ static int hbg_napi_rx_poll(struct napi_struct *napi, int budget)
 		rx_desc = (struct hbg_rx_desc *)buffer->skb->data;
 		pkt_len = FIELD_GET(HBG_RX_DESC_W2_PKT_LEN_M, rx_desc->word2);
 
-		if (unlikely(!hbg_rx_pkt_check(priv, rx_desc))) {
+		if (unlikely(!hbg_rx_pkt_check(priv, rx_desc, buffer->skb))) {
 			hbg_buffer_free(buffer);
 			goto next_buffer;
 		}
-- 
2.33.0


