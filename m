Return-Path: <netdev+bounces-152065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B349F2935
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 05:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF0D1888075
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 04:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352C41CBEA4;
	Mon, 16 Dec 2024 04:13:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2355A1C3C18;
	Mon, 16 Dec 2024 04:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734322429; cv=none; b=PziATaOIAxh46CBqM6iqAi5g1LjE9nZAKGmIREZS6PZSEFSLZ0vmfnyehbxiWCgXOuxihQI/xGCjnCKv5nth6aU1isSD5UbebpQmxuynvH5UTaG09724GMjRy+5TZjKPvlFR73lw0UBzdIm0QQ7/Qz9ctsauR6lkqaSMbUOnRDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734322429; c=relaxed/simple;
	bh=2urIXQ5l2+fcRXGgzVAlnCT58QgDYHlk1hwadoBNabE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hzClMLcuCeP2K5eJgtQjNootWWxvv9EMJud7SekZZrAMeY9lhGRj+YvhmB8aiFuN+N++OodAY5OZi0o26IUUDl2XZe/0uabauIEYA/PbZhankYhuwUyV5TIRtic5UUwF+bGuqsdgR6jrNSMPrYcUFJv+dTlyO4FdLHHmJgy0lfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YBRLq0L9DzgZ9k;
	Mon, 16 Dec 2024 12:10:43 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 461521800CB;
	Mon, 16 Dec 2024 12:13:38 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 16 Dec 2024 12:13:37 +0800
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
Subject: [PATCH V8 net-next 2/7] net: hibmcge: Add irq_info file to debugfs
Date: Mon, 16 Dec 2024 12:05:27 +0800
Message-ID: <20241216040532.1566229-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241216040532.1566229-1-shaojijie@huawei.com>
References: <20241216040532.1566229-1-shaojijie@huawei.com>
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
index 773a6434b114..56d8599563c0 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_debugfs.c
@@ -55,9 +55,31 @@ static int hbg_dbg_rx_ring(struct seq_file *s, void *unused)
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
+			   str_true_false(hbg_hw_irq_is_enabled(priv,
+								info->mask)),
+			   str_true_false(info->need_print),
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


