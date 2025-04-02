Return-Path: <netdev+bounces-178809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A89EFA79032
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 15:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F281E188A00B
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 13:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6EB23BD0B;
	Wed,  2 Apr 2025 13:46:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719CC23959D;
	Wed,  2 Apr 2025 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743601568; cv=none; b=gj7FGRyp2DH554v5S7/ZBNbfMVsJ6/fzO5RocA6hogIQXHN4kL4ryL0t8PvisS39kaAvqHoQpUIYGKD8qitCisTRWbeWz+Wtt7Tl81tuDUQNnluAIk1yikmTNMeHuX6/I2QZeRynJXwVKJPgj5wTXM/wxsSh9qwKw93DWwK7Bp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743601568; c=relaxed/simple;
	bh=STZiqEqBoqs6VURN7RgnYW/jv45b+rjTmPdGXicBnLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Amgls4jlLfWUR9cJEykNkbPGlg5MNS2Ei1bMVGH9pDhwwMdr+VMvmfbRkpF++RwJieub1rLxwIsbV6IAb2cv9VN+JIgKbvtk3mNyWaYjA3pfT4ptVxuEJclxhgfLItRTzJRFRShE4VbbORldxF7HONoXW2u9cNiuBfV+fhzxzeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZSR2f5sdnz13L8R;
	Wed,  2 Apr 2025 21:45:30 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id CC91F1402DB;
	Wed,  2 Apr 2025 21:46:02 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Apr 2025 21:46:02 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net 3/7] net: hibmcge: fix the share of irq statistics among different network ports issue
Date: Wed, 2 Apr 2025 21:39:01 +0800
Message-ID: <20250402133905.895421-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250402133905.895421-1-shaojijie@huawei.com>
References: <20250402133905.895421-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk100013.china.huawei.com (7.202.194.61)

hbg_irqs is a global array which contains irq statistics.
However, the irq statistics of different network ports
point to the same global array. As a result, the statistics are incorrect.

This patch allocates a statistics array for each network port
to prevent the statistics of different network ports
from affecting each other.

irq statistics are removed from hbg_irq_info. Therefore,
all data in hbg_irq_info remains unchanged. Therefore,
the input parameter of some functions is changed to const.

Fixes: 4d089035fa19 ("net: hibmcge: Add interrupt supported in this module")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hibmcge/hbg_common.h   |  8 ++++---
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.c  |  4 ++--
 .../ethernet/hisilicon/hibmcge/hbg_diagnose.c |  2 +-
 .../net/ethernet/hisilicon/hibmcge/hbg_irq.c  | 24 ++++++++++++-------
 .../net/ethernet/hisilicon/hibmcge/hbg_main.c |  2 +-
 5 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
index f8cdab62bf85..7725cb0c5c8a 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_common.h
@@ -108,14 +108,16 @@ struct hbg_irq_info {
 	bool re_enable;
 	bool need_print;
 	bool need_reset;
-	u64 count;
 
-	void (*irq_handle)(struct hbg_priv *priv, struct hbg_irq_info *info);
+	void (*irq_handle)(struct hbg_priv *priv,
+			   const struct hbg_irq_info *info);
 };
 
 struct hbg_vector {
 	char name[HBG_VECTOR_NUM][32];
-	struct hbg_irq_info *info_array;
+
+	u64 *stats_array;
+	const struct hbg_irq_info *info_array;
 	u32 info_array_len;
 };
 
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
index 5e0ba4d5b08d..9c09e4835990 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
@@ -61,7 +61,7 @@ static int hbg_dbg_irq_info(struct seq_file *s, void *unused)
 {
 	struct net_device *netdev = dev_get_drvdata(s->private);
 	struct hbg_priv *priv = netdev_priv(netdev);
-	struct hbg_irq_info *info;
+	const struct hbg_irq_info *info;
 	u32 i;
 
 	for (i = 0; i < priv->vectors.info_array_len; i++) {
@@ -73,7 +73,7 @@ static int hbg_dbg_irq_info(struct seq_file *s, void *unused)
 								info->mask)),
 			   str_true_false(info->need_reset),
 			   str_true_false(info->need_print),
-			   info->count);
+			   priv->vectors.stats_array[i]);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.c
index d61c03f34ff0..f23fb5920c3c 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_diagnose.c
@@ -234,7 +234,7 @@ static u64 hbg_get_irq_stats(struct hbg_vector *vectors, u32 mask)
 
 	for (i = 0; i < vectors->info_array_len; i++)
 		if (vectors->info_array[i].mask == mask)
-			return vectors->info_array[i].count;
+			return vectors->stats_array[i];
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
index e79e9ab3e530..8af0bc4cca21 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_irq.c
@@ -6,7 +6,7 @@
 #include "hbg_hw.h"
 
 static void hbg_irq_handle_err(struct hbg_priv *priv,
-			       struct hbg_irq_info *irq_info)
+			       const struct hbg_irq_info *irq_info)
 {
 	if (irq_info->need_print)
 		dev_err(&priv->pdev->dev,
@@ -17,30 +17,30 @@ static void hbg_irq_handle_err(struct hbg_priv *priv,
 }
 
 static void hbg_irq_handle_tx(struct hbg_priv *priv,
-			      struct hbg_irq_info *irq_info)
+			      const struct hbg_irq_info *irq_info)
 {
 	napi_schedule(&priv->tx_ring.napi);
 }
 
 static void hbg_irq_handle_rx(struct hbg_priv *priv,
-			      struct hbg_irq_info *irq_info)
+			      const struct hbg_irq_info *irq_info)
 {
 	napi_schedule(&priv->rx_ring.napi);
 }
 
 static void hbg_irq_handle_rx_buf_val(struct hbg_priv *priv,
-				      struct hbg_irq_info *irq_info)
+				      const struct hbg_irq_info *irq_info)
 {
 	priv->stats.rx_fifo_less_empty_thrsld_cnt++;
 }
 
 #define HBG_IRQ_I(name, handle) \
-	{#name, HBG_INT_MSK_##name##_B, false, false, false, 0, handle}
+	{#name, HBG_INT_MSK_##name##_B, false, false, false, handle}
 #define HBG_ERR_IRQ_I(name, need_print, ndde_reset) \
 	{#name, HBG_INT_MSK_##name##_B, true, need_print, \
-	ndde_reset, 0, hbg_irq_handle_err}
+	ndde_reset, hbg_irq_handle_err}
 
-static struct hbg_irq_info hbg_irqs[] = {
+static const struct hbg_irq_info hbg_irqs[] = {
 	HBG_IRQ_I(RX, hbg_irq_handle_rx),
 	HBG_IRQ_I(TX, hbg_irq_handle_tx),
 	HBG_ERR_IRQ_I(TX_PKT_CPL, true, true),
@@ -64,7 +64,7 @@ static struct hbg_irq_info hbg_irqs[] = {
 
 static irqreturn_t hbg_irq_handle(int irq_num, void *p)
 {
-	struct hbg_irq_info *info;
+	const struct hbg_irq_info *info;
 	struct hbg_priv *priv = p;
 	u32 status;
 	u32 i;
@@ -79,7 +79,7 @@ static irqreturn_t hbg_irq_handle(int irq_num, void *p)
 			hbg_hw_irq_enable(priv, info->mask, false);
 			hbg_hw_irq_clear(priv, info->mask);
 
-			info->count++;
+			priv->vectors.stats_array[i]++;
 			if (info->irq_handle)
 				info->irq_handle(priv, info);
 
@@ -132,6 +132,12 @@ int hbg_irq_init(struct hbg_priv *priv)
 					     irq_names_map[i]);
 	}
 
+	vectors->stats_array = devm_kcalloc(&priv->pdev->dev,
+					    ARRAY_SIZE(hbg_irqs),
+					    sizeof(u64), GFP_KERNEL);
+	if (!vectors->stats_array)
+		return -ENOMEM;
+
 	vectors->info_array = hbg_irqs;
 	vectors->info_array_len = ARRAY_SIZE(hbg_irqs);
 	return 0;
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 2ac5454338e4..e5c961ad4b9b 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -21,7 +21,7 @@
 
 static void hbg_all_irq_enable(struct hbg_priv *priv, bool enabled)
 {
-	struct hbg_irq_info *info;
+	const struct hbg_irq_info *info;
 	u32 i;
 
 	for (i = 0; i < priv->vectors.info_array_len; i++) {
-- 
2.33.0


