Return-Path: <netdev+bounces-134567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E3499A2DB
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 13:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB811F20A9D
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 11:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2019C216A0C;
	Fri, 11 Oct 2024 11:39:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E413216A04;
	Fri, 11 Oct 2024 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728646780; cv=none; b=IIHsD1kRquwFutfx6r31w1gYRUJD7Q0N4uMiXm/9a9LasPHPKtM+/6Iv5+MXMx5Ctjj+egQ3N+T1tK4In0ICh/il2qyLfbyKHPCs0mlb5D2U3wHa2pnthpqV5CTxZMJEa8BvmSJF3h8nWfihTTl3WUpE6BKwNm6tJebIau4guOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728646780; c=relaxed/simple;
	bh=1WSe7szNgbqmj+OHZdGutVlfB/mb/yI7GOj+WtDowxs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B7LKCGnx8B9c2IbpKFhYbatdAl7wHvoyjU4BfcsZM1asUKQg/JU9OZBGwUGHLH5v/RWZbOt6lWG+QaG6FCTa9x3f1N2JDFWoMiZZgwS/4KGEX74MY4NXvY2B2ugb9Qy4uyejBPezRI33H65tNa5lA2W45PgebxeSstSYe9T09G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XQ4Ph5NWPzyT2q;
	Fri, 11 Oct 2024 19:38:16 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (unknown [7.193.23.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 4482A14037C;
	Fri, 11 Oct 2024 19:39:35 +0800 (CST)
Received: from huawei.com (10.175.113.133) by kwepemm600001.china.huawei.com
 (7.193.23.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 11 Oct
 2024 19:39:34 +0800
From: Wang Hai <wanghai38@huawei.com>
To: <andreas@gaisler.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <kristoffer@gaisler.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net] net: ethernet: aeroflex: fix potential memory leak in greth_start_xmit_gbit()
Date: Fri, 11 Oct 2024 19:39:08 +0800
Message-ID: <20241011113908.43966-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600001.china.huawei.com (7.193.23.3)

The greth_start_xmit_gbit() returns NETDEV_TX_OK without freeing skb
in case of skb->len being too long, add dev_kfree_skb() to fix it.

Fixes: d4c41139df6e ("net: Add Aeroflex Gaisler 10/100/1G Ethernet MAC driver")
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/net/ethernet/aeroflex/greth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/aeroflex/greth.c b/drivers/net/ethernet/aeroflex/greth.c
index 27af7746d645..8f6835a710b9 100644
--- a/drivers/net/ethernet/aeroflex/greth.c
+++ b/drivers/net/ethernet/aeroflex/greth.c
@@ -484,6 +484,7 @@ greth_start_xmit_gbit(struct sk_buff *skb, struct net_device *dev)
 
 	if (unlikely(skb->len > MAX_FRAME_SIZE)) {
 		dev->stats.tx_errors++;
+		dev_kfree_skb(skb);
 		goto out;
 	}
 
-- 
2.17.1


