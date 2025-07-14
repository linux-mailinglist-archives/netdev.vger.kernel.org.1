Return-Path: <netdev+bounces-206674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F7EB0403E
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C686B7AFFBC
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 13:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48FD248F5E;
	Mon, 14 Jul 2025 13:39:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08CB24A066;
	Mon, 14 Jul 2025 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752500388; cv=none; b=i3giDhycYNQodpL8jwnLbl6D6oprdfBUzM2LNnErl41JgL7YBSJvDuzhIFYj/f37JpUr4vO8dPzm7w/iFvUl1SuRwM2HhL1VlcheFqGacNSBn4SMAy/yfT7m0GCoehAF9YGLI8Une+2m72WXk1Ct5H+S47gZQeojJhLHn/A1AkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752500388; c=relaxed/simple;
	bh=ISa+F8ZRrtnqdWN7xQllm5UdUGup/iPHoyTVMgXu4SY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=G9Hgm8s6XvRrX4HoN+rjai3mfeKGZsKVxLCGsXlF/ZxEsxstiDnQTVxZyQWl1X+pIo50Nt3wbQxUc7kGR7wmsovP52yv4fYg93DSUE4IbmTw5WJjjrH83gOHW8yqAIGWeW5vb1Rf99muC/gCd1hevRtpY8nr8EjmrHFbHljgWio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bgjzL6N7zz29drq;
	Mon, 14 Jul 2025 21:37:02 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 69576140230;
	Mon, 14 Jul 2025 21:39:39 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 14 Jul
 2025 21:39:38 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net-next] ipv6: mcast: Simplify mld_clear_{report|query}()
Date: Mon, 14 Jul 2025 22:01:27 +0800
Message-ID: <20250714140127.3300393-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Use __skb_queue_purge() instead of re-implementing it.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/ipv6/mcast.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 8aecdd85a6ae..36ca27496b3c 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -845,21 +845,15 @@ static void mld_clear_delrec(struct inet6_dev *idev)
 
 static void mld_clear_query(struct inet6_dev *idev)
 {
-	struct sk_buff *skb;
-
 	spin_lock_bh(&idev->mc_query_lock);
-	while ((skb = __skb_dequeue(&idev->mc_query_queue)))
-		kfree_skb(skb);
+	__skb_queue_purge(&idev->mc_query_queue);
 	spin_unlock_bh(&idev->mc_query_lock);
 }
 
 static void mld_clear_report(struct inet6_dev *idev)
 {
-	struct sk_buff *skb;
-
 	spin_lock_bh(&idev->mc_report_lock);
-	while ((skb = __skb_dequeue(&idev->mc_report_queue)))
-		kfree_skb(skb);
+	__skb_queue_purge(&idev->mc_report_queue);
 	spin_unlock_bh(&idev->mc_report_lock);
 }
 
-- 
2.34.1


