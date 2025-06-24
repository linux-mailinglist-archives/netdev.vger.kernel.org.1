Return-Path: <netdev+bounces-200643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0158AE66DE
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 15:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777501920030
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 13:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0892291C0F;
	Tue, 24 Jun 2025 13:44:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6D86F06B;
	Tue, 24 Jun 2025 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750772685; cv=none; b=u9by5yEATBflNGWoOnxWG86PdhS2WZzsjdg9S9ClCzS8VtEV9LxUc/wbM6bbx1WDQMKBU0CZBidBb1Okh3sTfHobLxHguy9YmWS0xnOavUGH96GZV095qm8HJBzSwHieKLg88OlYnOJngRc3uVYkKtV280HbYUeRrwamLRPG7JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750772685; c=relaxed/simple;
	bh=riAO7+kPf9HTy7Xlhr0TjuByuROmt2TY2axH8ARarj4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PDYfpOokIjHR5xI2C8PhhgyuQqjAzjZ6kNypz1qW0vrsVzAhVGKudunrCXZcbO8p/uakbddcksvjac1Vst9Indq/LBBd8fKt2YWnhj0QHist5KaSKFJ5rMQdiuz+afmKCOcRQM4PvmRHIxhX8zvcw5tEhq7plx2Iftlgd870taI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bRR0322gtz10WrW;
	Tue, 24 Jun 2025 21:40:03 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 41C3C180087;
	Tue, 24 Jun 2025 21:44:40 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 24 Jun
 2025 21:44:39 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net-next] net: Reoder rxq_idx check in  __net_mp_open_rxq()
Date: Tue, 24 Jun 2025 22:01:59 +0800
Message-ID: <20250624140159.3929503-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500002.china.huawei.com (7.185.36.57)

array_index_nospec() clamp the rxq_idx within the range of
[0, dev->real_num_rx_queues), move the check before it.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/core/netdev_rx_queue.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/core/netdev_rx_queue.c b/net/core/netdev_rx_queue.c
index d126f10197bf..3bf1151d8061 100644
--- a/net/core/netdev_rx_queue.c
+++ b/net/core/netdev_rx_queue.c
@@ -97,14 +97,12 @@ int __net_mp_open_rxq(struct net_device *dev, unsigned int rxq_idx,
 	if (!netdev_need_ops_lock(dev))
 		return -EOPNOTSUPP;
 
-	if (rxq_idx >= dev->real_num_rx_queues)
-		return -EINVAL;
-	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
-
 	if (rxq_idx >= dev->real_num_rx_queues) {
 		NL_SET_ERR_MSG(extack, "rx queue index out of range");
 		return -ERANGE;
 	}
+	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
+
 	if (dev->cfg->hds_config != ETHTOOL_TCP_DATA_SPLIT_ENABLED) {
 		NL_SET_ERR_MSG(extack, "tcp-data-split is disabled");
 		return -EINVAL;
-- 
2.34.1


