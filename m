Return-Path: <netdev+bounces-135711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D5099EFB1
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 16:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D21A281369
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 14:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A47F1B21BF;
	Tue, 15 Oct 2024 14:36:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC2A14A4E0;
	Tue, 15 Oct 2024 14:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729002982; cv=none; b=G2YEVeyAoLwfHWGSNL3xcNKYC2j3kT241dpcjz66Y3nddwoSr7uSBQTaxkx0kxKY/HMAh6xG0h0APAiHAasVpOXP2eHq+RCCWzYBG8pQFGHtqkZS0g5X21wwuUdnMr4S1UPZhfuqMe6EuMRSc2DVEcK63empQ9hXYDIe0Hjk5iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729002982; c=relaxed/simple;
	bh=Me3Zk20HfZQ/FKjRB1jJTw5jYgjgRkI4vXGTjgNZKEs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mj9NR/v6tN8TIhwI7POVd1DiVNVsNlsrRFpRsAO9PIb9u+O9ZVJ11nOqegCnD7NYByXB/7WV5hiBaj7q6qfN0ahbHCN2DgcopNakcTfIWU3GPiErQIsmuHrcW8TxfSBKc/hz/E7s/dKoZNix8ZKuFQohBFXyXuBPQfxrk90KLVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XSc7d1BHNzyT8y;
	Tue, 15 Oct 2024 22:34:53 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (unknown [7.193.23.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 27F7C1400D5;
	Tue, 15 Oct 2024 22:36:16 +0800 (CST)
Received: from huawei.com (10.175.113.133) by kwepemm600001.china.huawei.com
 (7.193.23.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Oct
 2024 22:36:15 +0800
From: Wang Hai <wanghai38@huawei.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <zhangxiaoxu5@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wanghai38@huawei.com>
Subject: [PATCH v2 net] net: systemport: fix potential memory leak in bcm_sysport_xmit()
Date: Tue, 15 Oct 2024 22:35:58 +0800
Message-ID: <20241015143558.939-1-wanghai38@huawei.com>
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

The bcm_sysport_xmit() returns NETDEV_TX_OK without freeing skb
in case of dma_map_single() fails, add dev_consume_skb_any() to fix it.

Fixes: 80105befdb4b ("net: systemport: add Broadcom SYSTEMPORT Ethernet MAC driver")
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
v1->v2: replace dev_kfree_skb_any() with dev_consume_skb_any()
 drivers/net/ethernet/broadcom/bcmsysport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index c9faa8540859..cc0244515304 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -1359,6 +1359,7 @@ static netdev_tx_t bcm_sysport_xmit(struct sk_buff *skb,
 		netif_err(priv, tx_err, dev, "DMA map failed at %p (len=%d)\n",
 			  skb->data, skb_len);
 		ret = NETDEV_TX_OK;
+		dev_consume_skb_any(skb);
 		goto out;
 	}
 
-- 
2.17.1


