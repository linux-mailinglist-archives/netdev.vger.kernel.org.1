Return-Path: <netdev+bounces-150667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB619EB252
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7FBE1886E3B
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 13:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D01F1AA7B7;
	Tue, 10 Dec 2024 13:55:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BEE1E515;
	Tue, 10 Dec 2024 13:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838954; cv=none; b=lR3oLEGJYMvl3UGVjovXkEvI+guJUJ5piB2QeuDM4MddaR8XQ5hf+vykdbr1RNbY4P+HhUk9oRfmpzW+YIcNu0fnJdkEtjpcEzZEIcT2Eb1cpjTWtWa0DxGmrtR50gsarR5BrxgM7QjpxOdlq5H+qLplJR5futHBXzlzqDf4n7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838954; c=relaxed/simple;
	bh=CjshBgLiHFJxOBHgvbBkBL75PPsoGMc2CrtGGp/hGCw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKVHv/u/TfGaxVc9v152HHom9UU8I0hKuHXRLdOiCqaP9nPdQGj5yb572AJtEqcvPJmVK9dLNIND44AArM6pqKj+YEtBw7IqIZpL1JK27KFQXhUmuooxL8Obd8KMoVwtF1I6NV51aBBNXK+oYfcBxY1tRZdhKgSBKe0SZXupDkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Y70cR2gBVz1JF4V;
	Tue, 10 Dec 2024 21:55:35 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D166140259;
	Tue, 10 Dec 2024 21:55:49 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Dec 2024 21:55:48 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<gregkh@linuxfoundation.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>, <hkelam@marvell.com>
Subject: [PATCH V6 net-next 2/7] net: hibmcge: Add irq_info file to debugfs
Date: Tue, 10 Dec 2024 21:48:50 +0800
Message-ID: <20241210134855.2864577-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241210134855.2864577-1-shaojijie@huawei.com>
References: <20241210134855.2864577-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemk100013.china.huawei.com (7.202.194.61)

the driver requested three interrupts: "tx", "rx", "err".
The err interrupt is a summary interrupt. We distinguish
different errors based on the status register and mask.

With "cat /proc/interrupts | grep hibmcge",
we can't distinguish the detailed cause of the error,
so we added this file to debugfs.

the following effects are achieved:
[root@localhost sjj]# cat /sys/kernel/debug/hibmcge/0000\:83\:00.1/irq_info
RX                  : enabled: true , logged: false, count: 0
TX                  : enabled: true , logged: false, count: 0
MAC_MII_FIFO_ERR    : enabled: false, logged: true , count: 0
MAC_PCS_RX_FIFO_ERR : enabled: false, logged: true , count: 0
MAC_PCS_TX_FIFO_ERR : enabled: false, logged: true , count: 0
MAC_APP_RX_FIFO_ERR : enabled: false, logged: true , count: 0
MAC_APP_TX_FIFO_ERR : enabled: false, logged: true , count: 0
SRAM_PARITY_ERR     : enabled: true , logged: true , count: 0
TX_AHB_ERR          : enabled: true , logged: true , count: 0
RX_BUF_AVL          : enabled: true , logged: false, count: 0
REL_BUF_ERR         : enabled: true , logged: true , count: 0
TXCFG_AVL           : enabled: true , logged: false, count: 0
TX_DROP             : enabled: true , logged: false, count: 0
RX_DROP             : enabled: true , logged: false, count: 0
RX_AHB_ERR          : enabled: true , logged: true , count: 0
MAC_FIFO_ERR        : enabled: true , logged: false, count: 0
RBREQ_ERR           : enabled: true , logged: false, count: 0
WE_ERR              : enabled: true , logged: false, count: 0

The irq framework of hibmcge driver also includes tx/rx interrupts.
Therefore, TX and RX are not moved separately form this file.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../ethernet/hisilicon/hibmcge/hbg_debugfs.c  | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
index 9c0b2c7231fe..99d4e22a1d6f 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
@@ -56,9 +56,31 @@ static int hbg_dbg_rx_ring(struct seq_file *s, void *unused)
 	return 0;
 }
 
+static int hbg_dbg_irq_info(struct seq_file *s, void *unused)
+{
+	struct net_device *netdev = dev_get_drvdata(s->private);
+	struct hbg_priv *priv = netdev_priv(netdev);
+	struct hbg_irq_info *info;
+	u32 i;
+
+	for (i = 0; i < priv->vectors.info_array_len; i++) {
+		info = &priv->vectors.info_array[i];
+		seq_printf(s,
+			   "%-20s: enabled: %-5s, logged: %-5s, count: %llu\n",
+			   info->name,
+			   hbg_get_bool_str(hbg_hw_irq_is_enabled(priv,
+								  info->mask)),
+			   hbg_get_bool_str(info->need_print),
+			   info->count);
+	}
+
+	return 0;
+}
+
 static const struct hbg_dbg_info hbg_dbg_infos[] = {
 	{ "tx_ring", hbg_dbg_tx_ring },
 	{ "rx_ring", hbg_dbg_rx_ring },
+	{ "irq_info", hbg_dbg_irq_info },
 };
 
 static void hbg_debugfs_uninit(void *data)
-- 
2.33.0


