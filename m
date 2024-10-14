Return-Path: <netdev+bounces-135216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FE499CDE4
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 16:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5951F23C3D
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 14:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0A41A76A5;
	Mon, 14 Oct 2024 14:37:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D044A24;
	Mon, 14 Oct 2024 14:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916646; cv=none; b=TWjcQOIvOr9pQKDKU4ixeINZJOMt8Vf19d4FwXUyFSMwuTP5Miql161QkbAgTMYeHHtNAxSfWTfG7qHzRU7dMcFTgZSfd4kgf5SOa3TY8Q+iH3ZzFZannDBEkV4ifuKbFm2iW4eAH5/I5hVt6BGBR6jPT90lDmYarYKZtQ0BKoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916646; c=relaxed/simple;
	bh=seOGrShxODMYZ05aHugBbw0isx2IFEiunBYacuosxBs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ca6JrU6P205Zj7aNtwagi5Qi0HmuKIBnPGtQVgiZzDBgPlTH5ZI3g/vTboEvT2+y9MuKB986dUPwYYRa0bA9sjTsX4I58A4W7Lnf0g1UO99tzxxk3IWYCAkbSQX5FbzE+wf+5qH17rBUtrIfjg1tNNsbQShjj9yfHA/L7iDapyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XS0CW6nw2z2DdNw;
	Mon, 14 Oct 2024 22:36:07 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (unknown [7.193.23.3])
	by mail.maildlp.com (Postfix) with ESMTPS id C895D140158;
	Mon, 14 Oct 2024 22:37:19 +0800 (CST)
Received: from huawei.com (10.175.113.133) by kwepemm600001.china.huawei.com
 (7.193.23.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 14 Oct
 2024 22:37:18 +0800
From: Wang Hai <wanghai38@huawei.com>
To: <radhey.shyam.pandey@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<michal.simek@amd.com>, <andre.przywara@arm.com>, <zhangxiaoxu5@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <wanghai38@huawei.com>
Subject: [PATCH net] net: xilinx: axienet: fix potential memory leak in axienet_start_xmit()
Date: Mon, 14 Oct 2024 22:37:04 +0800
Message-ID: <20241014143704.31938-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600001.china.huawei.com (7.193.23.3)

The axienet_start_xmit() returns NETDEV_TX_OK without freeing skb
in case of dma_map_single() fails, add dev_kfree_skb_any() to fix it.

Fixes: 71791dc8bdea ("net: axienet: Check for DMA mapping errors")
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index ea7d7c03f48e..53cf1a927278 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1046,6 +1046,7 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		if (net_ratelimit())
 			netdev_err(ndev, "TX DMA mapping error\n");
 		ndev->stats.tx_dropped++;
+		dev_kfree_skb_any(skb);
 		return NETDEV_TX_OK;
 	}
 	desc_set_phys_addr(lp, phys, cur_p);
@@ -1066,6 +1067,7 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 			ndev->stats.tx_dropped++;
 			axienet_free_tx_chain(lp, orig_tail_ptr, ii + 1,
 					      true, NULL, 0);
+			dev_kfree_skb_any(skb);
 			return NETDEV_TX_OK;
 		}
 		desc_set_phys_addr(lp, phys, cur_p);
-- 
2.17.1


