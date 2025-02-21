Return-Path: <netdev+bounces-168520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1192BA3F39B
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 13:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568A81796AC
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 12:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9EF1F3FE2;
	Fri, 21 Feb 2025 12:03:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E2E3D994;
	Fri, 21 Feb 2025 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740139401; cv=none; b=qLrAniy8S2tvKwEPd8g1xEgOMzGLy7P5udN+itVX8Skx1565sfGZoekL7gQP+9unfP/HpLIK4kLBcWuKjVyJkoX/YfdMlcyGg8ZRw4t0/atlyYXWHScXgkQ+PRGXA5/4xNEQlxXpI3CwV9DcdSC/NTdBTl6/oxbgw25cPjjXbKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740139401; c=relaxed/simple;
	bh=BYYsQzd47c7AR7j0T6417jE6X+jM9iOom/u3VNLGXIU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mtdrbdPdTk0suXo7MTqibQkk7AFuNDcztBe7fOMsExOfe9d352Zs+C77WH/C1namreDn/r1ZmGgWc3m1mzkug5BzjWvaHr4DfnaOS4XlyZ1VtSNHYjHnKtEi2zc9Gz0yBV4sTTqCfXQxjpE2reGHrBRnGpj/9gtQHHoI+oHCVew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YzpbC0FlTzGsvk;
	Fri, 21 Feb 2025 19:59:51 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 8148D18010B;
	Fri, 21 Feb 2025 20:03:15 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Feb 2025 20:03:14 +0800
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
Subject: [PATCH v3 net-next 2/6] net: hibmcge: Add support for rx checksum offload
Date: Fri, 21 Feb 2025 19:55:22 +0800
Message-ID: <20250221115526.1082660-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250221115526.1082660-1-shaojijie@huawei.com>
References: <20250221115526.1082660-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemk100013.china.huawei.com (7.202.194.61)

This patch implements the rx checksum offload feature
including NETIF_F_IP_CSUM NETIF_F_IPV6_CSUM and NETIF_F_RXCSUM

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
ChangeLog:
v2 -> v3:
  - Remove .ndo_fix_features() suggested by Jakub Kicinski.
  v2: https://lore.kernel.org/all/20250218085829.3172126-1-shaojijie@huawei.com/
v1 -> v2:
  - Use !! to convert integer to boolean, suggested by Simon Horman.
  v1: https://lore.kernel.org/all/20250213035529.2402283-1-shaojijie@huawei.com/
---
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c | 13 ++++++++++++
 .../net/ethernet/hisilicon/hibmcge/hbg_txrx.c | 20 +++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

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
index 35dd3512d00e..2c7657e8ba27 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
@@ -202,8 +202,11 @@ static int hbg_napi_tx_recycle(struct napi_struct *napi, int budget)
 }
 
 static bool hbg_rx_check_l3l4_error(struct hbg_priv *priv,
-				    struct hbg_rx_desc *desc)
+				    struct hbg_rx_desc *desc,
+				    struct sk_buff *skb)
 {
+	bool rx_checksum_offload = !!(priv->netdev->features & NETIF_F_RXCSUM);
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
@@ -413,7 +425,7 @@ static int hbg_napi_rx_poll(struct napi_struct *napi, int budget)
 		rx_desc = (struct hbg_rx_desc *)buffer->skb->data;
 		pkt_len = FIELD_GET(HBG_RX_DESC_W2_PKT_LEN_M, rx_desc->word2);
 
-		if (unlikely(!hbg_rx_pkt_check(priv, rx_desc))) {
+		if (unlikely(!hbg_rx_pkt_check(priv, rx_desc, buffer->skb))) {
 			hbg_buffer_free(buffer);
 			goto next_buffer;
 		}
-- 
2.33.0


