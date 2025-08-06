Return-Path: <netdev+bounces-211892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F52B1C467
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 12:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F07576277B5
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 10:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB86E28BA98;
	Wed,  6 Aug 2025 10:35:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6C92749E8;
	Wed,  6 Aug 2025 10:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754476524; cv=none; b=IqPCvfFuKQNelMq3i+yTu90N6gWN8rKkypShasfTvdJ8UIV3cNgULgezJUWPuPckhxtYlwJIxwSrq7g54i0x8H6TsaE7aauDRZE39uAP2UjflFzqV2dkEINivcs86Q5dgj/cyr0jGgEG3hEhersBobkRzFKhrHx3LOhkv/r4MGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754476524; c=relaxed/simple;
	bh=iTn9Wk1HODQ6O9GS9CwEXWPXuYzARim6MtqLSkmQmWg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WNPkIN5Htw3qL4ozJ4NEWMGiBFWH4Nb224BMiM6Snyw7IrYspHnX68wOWaH1Rb2eLJp/ZOYa+7X/z4dfKwaUxgRozRJAw80Y6N06Cppqi1I7JgOQPiM0zEDdZWgdCIveuUr6LSoH2g3kMIKJxWEE7I+/LVNIePU7xMnC/I858jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bxmp23vHHz23jgk;
	Wed,  6 Aug 2025 18:32:42 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5DB1F14011B;
	Wed,  6 Aug 2025 18:35:13 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 Aug 2025 18:35:12 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V3 net 2/3] net: hibmcge: fix the division by zero issue
Date: Wed, 6 Aug 2025 18:27:57 +0800
Message-ID: <20250806102758.3632674-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250806102758.3632674-1-shaojijie@huawei.com>
References: <20250806102758.3632674-1-shaojijie@huawei.com>
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

When the network port is down, the queue is released, and ring->len is 0.
In debugfs, hbg_get_queue_used_num() will be called,
which may lead to a division by zero issue.

This patch adds a check, if ring->len is 0,
hbg_get_queue_used_num() directly returns 0.

Fixes: 40735e7543f9 ("net: hibmcge: Implement .ndo_start_xmit function")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
ChangeLog:
v2 -> v3:
  - Use READ_ONCE() to read temporary variable, suggested by Jakub Kicinski
  v2: https://lore.kernel.org/all/20250805181446.3deaceb9@kernel.org/
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.h
index 2883a5899ae2..8b6110599e10 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.h
@@ -29,7 +29,12 @@ static inline bool hbg_fifo_is_full(struct hbg_priv *priv, enum hbg_dir dir)
 
 static inline u32 hbg_get_queue_used_num(struct hbg_ring *ring)
 {
-	return (ring->ntu + ring->len - ring->ntc) % ring->len;
+	u32 len = READ_ONCE(ring->len);
+
+	if (!len)
+		return 0;
+
+	return (READ_ONCE(ring->ntu) + len - READ_ONCE(ring->ntc)) % len;
 }
 
 netdev_tx_t hbg_net_start_xmit(struct sk_buff *skb, struct net_device *netdev);
-- 
2.33.0


