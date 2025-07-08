Return-Path: <netdev+bounces-204960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E111EAFCB69
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA791AA0A09
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7103E2DAFB3;
	Tue,  8 Jul 2025 13:08:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8141EDA1E;
	Tue,  8 Jul 2025 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980082; cv=none; b=Ds5LgGKBsa71WKWcGszCjFEXDVFoavKhqxRxFcrcEI9OZt3QdIUHqcupfXFKO55sLbZOl7ZYfJGJ0TQF3H3fFsh7+nVICz2xUe2zM5PLk2hfJplH2VdumLtcfEuR2OxjAMazxcbNLyxwGZA4tM+FUCITpqJ/uEvyMkbcb9TFOEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980082; c=relaxed/simple;
	bh=OlY6PrjzTk1ddf4to2xW2avl8byTOo27K+DRrkg3Cgo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=expUnM1XXZTzMt+e3A5oHORBKqUjh6VNJYFKKKJhcKnKnGZGvk1CJjDyRLTVzefoXKjoYUJffqZd2hWAF/o/xm0LsHUCtwCJGRQ4OPTOQJBk/gh/qLEnDPEAAaLNyse81VnmvXunEYokwdbSzxfGOkbxHSrKQfFbL9qk3pMokXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bc1df2t1bz2qFBk;
	Tue,  8 Jul 2025 21:08:54 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id CF8C21402CB;
	Tue,  8 Jul 2025 21:07:56 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Jul 2025 21:07:56 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<arnd@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net-next 01/11] net: hns3: remove tx spare info from debugfs.
Date: Tue, 8 Jul 2025 21:00:19 +0800
Message-ID: <20250708130029.1310872-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250708130029.1310872-1-shaojijie@huawei.com>
References: <20250708130029.1310872-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk100013.china.huawei.com (7.202.194.61)

The tx spare info in debugfs is not very useful,
and there are related statistics available for troubleshooting.

This patch removes the tx spare info from debugfs.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 52 -------------------
 1 file changed, 52 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 35e57eebcf57..aec719ce3ccd 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -570,56 +570,6 @@ static int hns3_dbg_coal_info(struct hnae3_handle *h, char *buf, int len)
 	return 0;
 }
 
-static const struct hns3_dbg_item tx_spare_info_items[] = {
-	{ "QUEUE_ID", 2 },
-	{ "COPYBREAK", 2 },
-	{ "LEN", 7 },
-	{ "NTU", 4 },
-	{ "NTC", 4 },
-	{ "LTC", 4 },
-	{ "DMA", 17 },
-};
-
-static void hns3_dbg_tx_spare_info(struct hns3_enet_ring *ring, char *buf,
-				   int len, u32 ring_num, int *pos)
-{
-	char data_str[ARRAY_SIZE(tx_spare_info_items)][HNS3_DBG_DATA_STR_LEN];
-	struct hns3_tx_spare *tx_spare = ring->tx_spare;
-	char *result[ARRAY_SIZE(tx_spare_info_items)];
-	char content[HNS3_DBG_INFO_LEN];
-	u32 i, j;
-
-	if (!tx_spare) {
-		*pos += scnprintf(buf + *pos, len - *pos,
-				  "tx spare buffer is not enabled\n");
-		return;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(tx_spare_info_items); i++)
-		result[i] = &data_str[i][0];
-
-	*pos += scnprintf(buf + *pos, len - *pos, "tx spare buffer info\n");
-	hns3_dbg_fill_content(content, sizeof(content), tx_spare_info_items,
-			      NULL, ARRAY_SIZE(tx_spare_info_items));
-	*pos += scnprintf(buf + *pos, len - *pos, "%s", content);
-
-	for (i = 0; i < ring_num; i++) {
-		j = 0;
-		sprintf(result[j++], "%u", i);
-		sprintf(result[j++], "%u", ring->tx_copybreak);
-		sprintf(result[j++], "%u", tx_spare->len);
-		sprintf(result[j++], "%u", tx_spare->next_to_use);
-		sprintf(result[j++], "%u", tx_spare->next_to_clean);
-		sprintf(result[j++], "%u", tx_spare->last_to_clean);
-		sprintf(result[j++], "%pad", &tx_spare->dma);
-		hns3_dbg_fill_content(content, sizeof(content),
-				      tx_spare_info_items,
-				      (const char **)result,
-				      ARRAY_SIZE(tx_spare_info_items));
-		*pos += scnprintf(buf + *pos, len - *pos, "%s", content);
-	}
-}
-
 static const struct hns3_dbg_item rx_queue_info_items[] = {
 	{ "QUEUE_ID", 2 },
 	{ "BD_NUM", 2 },
@@ -827,8 +777,6 @@ static int hns3_dbg_tx_queue_info(struct hnae3_handle *h,
 		pos += scnprintf(buf + pos, len - pos, "%s", content);
 	}
 
-	hns3_dbg_tx_spare_info(ring, buf, len, h->kinfo.num_tqps, &pos);
-
 	return 0;
 }
 
-- 
2.33.0


