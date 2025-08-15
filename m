Return-Path: <netdev+bounces-214025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF45B27E05
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 12:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A9D37BF0D9
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 10:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D02D2FFDF1;
	Fri, 15 Aug 2025 10:11:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E292FFDD0;
	Fri, 15 Aug 2025 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755252702; cv=none; b=iJQPeipI2ngwIJzcif0EWboq++NWxIMx2wFO9/TBi0dzR3QFfmpxfffzfGEpAgWH+CMaJA4zj42nHL/djKzm7ANvS7odfs9sBJhgDgXloBqKWDHYdknq/82WHsf88DXkgybxN2LM8hYbOgNSHXT9WkRPnqfYp9/A0SvfSAcCMtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755252702; c=relaxed/simple;
	bh=JE2y2fSNazf/g2oerE/qZYksKDqZI/gWq2pINQRM4p4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JNVXfdl2tU2HTp7AGo5tqvkrcI6lO1BI+XAoZQPMbEhS1yw4WdXfrSQ6rxl/l3uyIHlaHBS8AEov5UaGj6y/t9uc5ARtrNStOJJqq/3ELzfJCWGnzCJf417cz47Z9yEQMdEM5am0znMVO+9d2bS0qVsugoGfvujssYUrUnwalag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c3HrK2rkxz2Dc72;
	Fri, 15 Aug 2025 18:08:49 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id AA7031402C6;
	Fri, 15 Aug 2025 18:11:31 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 Aug 2025 18:11:31 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next 1/2] net: hns3: add parameter check for tx_copybreak and tx_spare_buf_size
Date: Fri, 15 Aug 2025 18:04:13 +0800
Message-ID: <20250815100414.949752-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250815100414.949752-1-shaojijie@huawei.com>
References: <20250815100414.949752-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100013.china.huawei.com (7.202.194.61)

Since the driver always enables tx bounce buffer,
there are minimum values for `copybreak` and `tx_spare_buf_size`.

This patch will check and reject configurations
with values smaller than these minimums.

Closes: https://lore.kernel.org/all/20250723072900.GV2459@horms.kernel.org/
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index d5454e126c85..a752d0e3db3a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -1927,6 +1927,31 @@ static int hns3_set_tx_spare_buf_size(struct net_device *netdev,
 	return ret;
 }
 
+static int hns3_check_tx_copybreak(struct net_device *netdev, u32 copybreak)
+{
+	struct hns3_nic_priv *priv = netdev_priv(netdev);
+
+	if (copybreak < priv->min_tx_copybreak) {
+		netdev_err(netdev, "tx copybreak %u should be no less than %u!\n",
+			   copybreak, priv->min_tx_copybreak);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int hns3_check_tx_spare_buf_size(struct net_device *netdev, u32 buf_size)
+{
+	struct hns3_nic_priv *priv = netdev_priv(netdev);
+
+	if (buf_size < priv->min_tx_spare_buf_size) {
+		netdev_err(netdev,
+			   "tx spare buf size %u should be no less than %u!\n",
+			   buf_size, priv->min_tx_spare_buf_size);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int hns3_set_tunable(struct net_device *netdev,
 			    const struct ethtool_tunable *tuna,
 			    const void *data)
@@ -1943,6 +1968,10 @@ static int hns3_set_tunable(struct net_device *netdev,
 
 	switch (tuna->id) {
 	case ETHTOOL_TX_COPYBREAK:
+		ret = hns3_check_tx_copybreak(netdev, *(u32 *)data);
+		if (ret)
+			return ret;
+
 		priv->tx_copybreak = *(u32 *)data;
 
 		for (i = 0; i < h->kinfo.num_tqps; i++)
@@ -1957,6 +1986,10 @@ static int hns3_set_tunable(struct net_device *netdev,
 
 		break;
 	case ETHTOOL_TX_COPYBREAK_BUF_SIZE:
+		ret = hns3_check_tx_spare_buf_size(netdev, *(u32 *)data);
+		if (ret)
+			return ret;
+
 		old_tx_spare_buf_size = h->kinfo.tx_spare_buf_size;
 		new_tx_spare_buf_size = *(u32 *)data;
 		netdev_info(netdev, "request to set tx spare buf size from %u to %u\n",
-- 
2.33.0


