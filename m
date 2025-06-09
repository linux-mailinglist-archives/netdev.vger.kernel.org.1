Return-Path: <netdev+bounces-195725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03245AD214F
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 16:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01ACB188CF4C
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 14:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5181C18A6AB;
	Mon,  9 Jun 2025 14:49:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683C58F40;
	Mon,  9 Jun 2025 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749480548; cv=none; b=lxibkQIDG6DTjG4VawWfa4JIfoBNz+XWkGJvgX15tBSJ/t+INXwWKMmzXksYu6CYzhHUjNdp730t4DI7qAjSlaLnEXbQWcyLHp0D4lcypaEE9jBO14AdXNkTrlLn4fQNr1tUPBmUULMzMEWYFKG63+stc3qxWzyxO6zga64VyG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749480548; c=relaxed/simple;
	bh=Co7iTXeSexNM0KzOIzkhOWOr9cEpHpm6VkYH6fgg2yc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U4e5YtpNIvmh8u1dCElE7mPETejvBtgNnunKgtMfLux28Ols5NA+IKDJEz61339KPGBWwUBAOWDNUw1k1R2riV6GXzFlJP8v0svjfktdHanvYPYifFA4EOP/c73kQWIUZstTrLv9lgfNnOg3lyJxwtwA9lumevJacNe1oOGF034=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bGF7m1MMCz6L5cK;
	Mon,  9 Jun 2025 22:44:52 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 5BE041404C5;
	Mon,  9 Jun 2025 22:49:04 +0800 (CST)
Received: from china (10.220.118.114) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 9 Jun
 2025 16:48:58 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Fan Gong <gongfan1@huawei.com>
Subject: [PATCH net-next v3 2/3] hinic3: use netif_subqueue_sent api
Date: Mon, 9 Jun 2025 18:07:53 +0300
Message-ID: <5fd897b75729cf078385aacd9ed40091314ea63d.1749038081.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1749038081.git.gur.stavi@huawei.com>
References: <cover.1749038081.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 frapeml500005.china.huawei.com (7.182.85.13)

Improve consistency of code by using only netif_subqueue variant apis

Signed-off-by: Gur Stavi <gur.stavi@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
index ae08257dd1d2..7b6f101da313 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
@@ -542,8 +542,7 @@ static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
 		goto err_drop_pkt;
 	}
 
-	netdev_tx_sent_queue(netdev_get_tx_queue(netdev, txq->sq->q_id),
-			     skb->len);
+	netif_subqueue_sent(netdev, txq->sq->q_id, skb->len);
 	netif_subqueue_maybe_stop(netdev, tx_q->sq->q_id,
 				  hinic3_wq_free_wqebbs(&tx_q->sq->wq),
 				  tx_q->tx_stop_thrs,
-- 
2.45.2


