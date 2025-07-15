Return-Path: <netdev+bounces-207083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3B0B05915
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D674A18D6
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 11:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105292D9EF1;
	Tue, 15 Jul 2025 11:45:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3C12749D6;
	Tue, 15 Jul 2025 11:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752579957; cv=none; b=C/7ttzy/bM5GFBY3rDHlX0y5XuKbETRUIprBR2ElsqQC8YmCObP+OYdmJJRXaAZGb7NxGaWSGrNiXO2Ythzl+HMrQRWZVFwDnhOybaV9XsJXFZAEfBvxP6RRAxGGAXg6jp+rYOt14HGe6fLR37CQU2sBpMkJdVC0RKfv1xmHY/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752579957; c=relaxed/simple;
	bh=TJj1GBM3kY96ER4pDl0GjSYNA4pjhWLv2UTd9LIoEPU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BlRl+vY7eV6sZXp+mnb67jpzeXyfmX7CBu+BL2x5sFPqLOpsiexc4kDRyzC1ZqNd5P/UYh7Fn8sdVLiW5nrnlHSCypW6oIBGqehruKcvVm9/a8Z7YJgiyjEpZa/9ozGKry0MegQM84fdD4XUWj+VW0H5b9njD0UmtEI0xWOJYJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bhHMr1CPDz2CfpH;
	Tue, 15 Jul 2025 19:41:44 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id BB1A61A0188;
	Tue, 15 Jul 2025 19:45:50 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 15 Jul
 2025 19:45:49 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH v2 net-next] ipv6: mcast: Simplify mld_clear_{report|query}()
Date: Tue, 15 Jul 2025 20:07:09 +0800
Message-ID: <20250715120709.3941510-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Use __skb_queue_purge() instead of re-implementing it. Note that it uses
kfree_skb_reason() instead of kfree_skb() internally, and pass
SKB_DROP_REASON_QUEUE_PURGE drop reason to the kfree_skb tracepoint.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
v2: Add drop reason note
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


