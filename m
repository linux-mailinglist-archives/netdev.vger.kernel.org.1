Return-Path: <netdev+bounces-174433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52284A5E943
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 02:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9579917ACE5
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 01:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5368633F;
	Thu, 13 Mar 2025 01:16:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115C525776;
	Thu, 13 Mar 2025 01:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741828579; cv=none; b=R8LY6YLEhluDf8qjfm6uXfIP3FaA0CEW//u6+EyvzQkpgySguhaojwSLDlt9MloVoy2mLkgJcVGabur59r5LT0zZYeVcKsne4ssfWePg79g2TOBLAo1CBYJZk784pe7Y8duJfn1JBhoIW5EwxNqDmE7qf4SYOojlYMckwotQXt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741828579; c=relaxed/simple;
	bh=3PNhqqyRaFF5l4naAmFz5YjA11fh/EFAPuwXokt4+Rs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XcMbvCwwS43gVKNrUQIws9acydAkdHbWC223ZJPk9f66iQdrdGk6zQlyrNpJ41QWVshhBd1Qz33Tj9CJDsKV4oCZaZNqeSsxsT039wP7n39w9V8tIkp0Ej/QUR+XcvsT2CbWNXK2+94D24qBv4u41ou+8SNtgsFAjYeKXosqoQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZCqG93ZBcz1f0b3;
	Thu, 13 Mar 2025 09:11:45 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 67FD21A016C;
	Thu, 13 Mar 2025 09:16:08 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg200005.china.huawei.com
 (7.202.181.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 13 Mar
 2025 09:16:07 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <dsahern@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>, <fw@strlen.de>,
	<daniel@iogearbox.net>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net] net: fix NULL pointer dereference in l3mdev_l3_rcv
Date: Thu, 13 Mar 2025 09:27:13 +0800
Message-ID: <20250313012713.748006-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg200005.china.huawei.com (7.202.181.32)

When delete l3s ipvlan:

    ip link del link eth0 ipvlan1 type ipvlan mode l3s

This may cause a null pointer dereference:

    Call trace:
     ip_rcv_finish+0x48/0xd0
     ip_rcv+0x5c/0x100
     __netif_receive_skb_one_core+0x64/0xb0
     __netif_receive_skb+0x20/0x80
     process_backlog+0xb4/0x204
     napi_poll+0xe8/0x294
     net_rx_action+0xd8/0x22c
     __do_softirq+0x12c/0x354

This is because l3mdev_l3_rcv() visit dev->l3mdev_ops after
ipvlan_l3s_unregister() assign the dev->l3mdev_ops to NULL. The process
like this:

    (CPU1)                     | (CPU2)
    l3mdev_l3_rcv()            |
      check dev->priv_flags:   |
        master = skb->dev;     |
                               |
                               | ipvlan_l3s_unregister()
                               |   set dev->priv_flags
                               |   dev->l3mdev_ops = NULL;
                               |
      visit master->l3mdev_ops |

Add lock for dev->priv_flags and dev->l3mdev_ops is too expensive. Resolve
this issue by add check for master->l3mdev_ops.

Fixes: c675e06a98a4 ("ipvlan: decouple l3s mode dependencies from other modes")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 include/net/l3mdev.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/net/l3mdev.h b/include/net/l3mdev.h
index f7fe796e8429..b5af87a35a9f 100644
--- a/include/net/l3mdev.h
+++ b/include/net/l3mdev.h
@@ -165,6 +165,7 @@ static inline
 struct sk_buff *l3mdev_l3_rcv(struct sk_buff *skb, u16 proto)
 {
 	struct net_device *master = NULL;
+	const struct l3mdev_ops *l3mdev_ops;
 
 	if (netif_is_l3_slave(skb->dev))
 		master = netdev_master_upper_dev_get_rcu(skb->dev);
@@ -172,8 +173,12 @@ struct sk_buff *l3mdev_l3_rcv(struct sk_buff *skb, u16 proto)
 		 netif_has_l3_rx_handler(skb->dev))
 		master = skb->dev;
 
-	if (master && master->l3mdev_ops->l3mdev_l3_rcv)
-		skb = master->l3mdev_ops->l3mdev_l3_rcv(master, skb, proto);
+	if (!master)
+		return skb;
+
+	l3mdev_ops = master->l3mdev_ops;
+	if (l3mdev_ops && l3mdev_ops->l3mdev_l3_rcv)
+		skb = l3mdev_ops->l3mdev_l3_rcv(master, skb, proto);
 
 	return skb;
 }
-- 
2.34.1


