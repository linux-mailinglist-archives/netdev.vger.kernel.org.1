Return-Path: <netdev+bounces-135715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499BE99F009
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 16:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BF591C2272D
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 14:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4966C1D5142;
	Tue, 15 Oct 2024 14:48:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D4B18A6D9;
	Tue, 15 Oct 2024 14:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003706; cv=none; b=lWM851250S4zMu/5KRcSVyOVpFZZSmwS1gIamj4KRGXSU2gqKpomAW4hVrW+k7N2cS2z+QnK8mYcHIXxEjPGY2ZgOSjeY0bOJ/pEKGEYo1uRCrQ4I+HRfPbPKU4L+DPs5oVrMhrEYjvi4MzU4lbBGCdnJih2CR1/NUAi+Nk5cbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003706; c=relaxed/simple;
	bh=XgoA3+FERjry6apyY/FxUCOBF3D/pHuQU1olz/NGBvM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TtiaE80wF1lS0ioM5S6XsLjCf0rTsXEwb9KDzBKKGG50JFDncNRezUs6fAVZgO72XUwW1FmXjANTXdtsZVwbZ201NB7bTvczLStkvZlTAy6KH7uOIpMyPAR35a/7SsbC4G2xcmJcMbFhNi+lOafZKhLxuZMQl4BOF3pmRNjFr0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XScPk4T1xz1j9qX;
	Tue, 15 Oct 2024 22:47:06 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (unknown [7.193.23.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 909BE180043;
	Tue, 15 Oct 2024 22:48:19 +0800 (CST)
Received: from huawei.com (10.175.113.133) by kwepemm600001.china.huawei.com
 (7.193.23.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Oct
 2024 22:48:18 +0800
From: Wang Hai <wanghai38@huawei.com>
To: <ajit.khaparde@broadcom.com>, <horms@kernel.org>,
	<sriharsha.basavapatna@broadcom.com>, <somnath.kotur@broadcom.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <VenkatKumar.Duvvuru@Emulex.Com>,
	<zhangxiaoxu5@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wanghai38@huawei.com>
Subject: [PATCH v2 net] be2net: fix potential memory leak in be_xmit()
Date: Tue, 15 Oct 2024 22:48:02 +0800
Message-ID: <20241015144802.12150-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600001.china.huawei.com (7.193.23.3)

The be_xmit() returns NETDEV_TX_OK without freeing skb
in case of be_xmit_enqueue() fails, add dev_kfree_skb_any() to fix it.

Fixes: 760c295e0e8d ("be2net: Support for OS2BMC.")
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
v1->v2: Add label drop_skb for dev_kfree_skb_any()
 drivers/net/ethernet/emulex/benet/be_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index a8596ebcdfd6..875fe379eea2 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1381,10 +1381,8 @@ static netdev_tx_t be_xmit(struct sk_buff *skb, struct net_device *netdev)
 	be_get_wrb_params_from_skb(adapter, skb, &wrb_params);
 
 	wrb_cnt = be_xmit_enqueue(adapter, txo, skb, &wrb_params);
-	if (unlikely(!wrb_cnt)) {
-		dev_kfree_skb_any(skb);
-		goto drop;
-	}
+	if (unlikely(!wrb_cnt))
+		goto drop_skb;
 
 	/* if os2bmc is enabled and if the pkt is destined to bmc,
 	 * enqueue the pkt a 2nd time with mgmt bit set.
@@ -1393,7 +1391,7 @@ static netdev_tx_t be_xmit(struct sk_buff *skb, struct net_device *netdev)
 		BE_WRB_F_SET(wrb_params.features, OS2BMC, 1);
 		wrb_cnt = be_xmit_enqueue(adapter, txo, skb, &wrb_params);
 		if (unlikely(!wrb_cnt))
-			goto drop;
+			goto drop_skb;
 		else
 			skb_get(skb);
 	}
@@ -1407,6 +1405,8 @@ static netdev_tx_t be_xmit(struct sk_buff *skb, struct net_device *netdev)
 		be_xmit_flush(adapter, txo);
 
 	return NETDEV_TX_OK;
+drop_skb:
+	dev_kfree_skb_any(skb);
 drop:
 	tx_stats(txo)->tx_drv_drops++;
 	/* Flush the already enqueued tx requests */
-- 
2.17.1


