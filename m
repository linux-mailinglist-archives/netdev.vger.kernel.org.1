Return-Path: <netdev+bounces-192539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98404AC04B2
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 08:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3FBD188DBED
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 06:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61E1222564;
	Thu, 22 May 2025 06:38:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147962222D4;
	Thu, 22 May 2025 06:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747895882; cv=none; b=SneHqTBo0ebAskqlQ2I5eeHPDk6G6nWbrPnindg6QrA8mkh+y7LVtJG5GB8BTQNPAhBsbeBg+z9ao5lQ67srjZ6WkJQc7ka0ZYp29TZXswJPMJwDm1WMIVG93uGD6u7Wdwp6CKEWyihub4HHQWEgrvai8EykPM7MX4/AFwAvsDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747895882; c=relaxed/simple;
	bh=Co7iTXeSexNM0KzOIzkhOWOr9cEpHpm6VkYH6fgg2yc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqL7vv7iT0YW3OC4U42zry6ntW04i0WH42ixISXavp4RuXS5Eq/fLa19FVpSvN0RZASZjwC86AQOinsC98eDhe8un3MnsRQ++6Ijtsg31lJMFyP1d3056za1FKD8uxh/wmZHyn31maCEfuI/33mwM3amGKXUtV/4p1B4pYe8n30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b2z9C6m4Jz6HJf7;
	Thu, 22 May 2025 14:37:03 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 04997140557;
	Thu, 22 May 2025 14:37:59 +0800 (CST)
Received: from china (10.220.118.114) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 22 May
 2025 08:37:54 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Fan Gong <gongfan1@huawei.com>
Subject: [PATCH net-next v2 2/3] hinic3: use netif_subqueue_sent api
Date: Thu, 22 May 2025 09:54:42 +0300
Message-ID: <2f14adef7673782f2ffe9e3df9e5d45ecf2b7f96.1747896423.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1747896423.git.gur.stavi@huawei.com>
References: <cover.1747896423.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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


