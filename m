Return-Path: <netdev+bounces-134136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 456DE998243
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41060B20574
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 09:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EC419F41D;
	Thu, 10 Oct 2024 09:31:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8D9191F62
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 09:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552704; cv=none; b=ADctR4HMyDUx8t/Jq9FUO+k/fWRDdAOQqDvgcMAGkztr+lDyEkCvYh8kOpTl4xJPVGeUKVT0RON6+GLIuxbx9KrzSHsFPv7nwdeTJbgCSKE/ak87aio2RQ82Jaa+d+2Wf6vNi44NV1p7i4Y4kAQ+kPepEAgEYxsu7EZtdb5lETs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552704; c=relaxed/simple;
	bh=LMldZORqVRQ9yzCTpOalfRfwPTIDVt89WeMD4LgiADQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OpTmiOe2oZliB4nFZ2AqTP6u8Ai5VZxYviXBsCVZXjtVRQxnB1yKlic+/CDMAYCBeoNoXMrPI1QFU2eM0HSgGsmuZyE0pVzOjgY1H5lbA4BomtC3yDV0wFUhpuIek8AQDy9RspSIzLmljJXENYU2QvLNTBt4CXskQi15sjS3tkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XPPYH1T7dz1HKKw;
	Thu, 10 Oct 2024 17:27:31 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (unknown [7.185.36.200])
	by mail.maildlp.com (Postfix) with ESMTPS id F0D68140113;
	Thu, 10 Oct 2024 17:31:37 +0800 (CST)
Received: from huawei.com (10.44.142.84) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 10 Oct
 2024 17:31:37 +0800
From: Yu Liao <liaoyu15@huawei.com>
To: <kuba@kernel.org>
CC: <liaoyu15@huawei.com>, <xiexiuqi@huawei.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>
Subject: [RESEND PATCH v2] net: hsr: convert to use new timer APIs
Date: Thu, 10 Oct 2024 17:27:44 +0800
Message-ID: <20241010092744.70348-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500003.china.huawei.com (7.185.36.200)

del_timer() and del_timer_sync() have been renamed to timer_delete()
and timer_delete_sync().

Inconsistent API usage makes the code a bit confusing, so replace with
the new APIs.

No functional changes intended.

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v1 -> v2: Add Simon's Reviewed-by tag.

 net/hsr/hsr_netlink.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index f6ff0b61e08a..6f09b9512484 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -128,9 +128,9 @@ static void hsr_dellink(struct net_device *dev, struct list_head *head)
 {
 	struct hsr_priv *hsr = netdev_priv(dev);
 
-	del_timer_sync(&hsr->prune_timer);
-	del_timer_sync(&hsr->prune_proxy_timer);
-	del_timer_sync(&hsr->announce_timer);
+	timer_delete_sync(&hsr->prune_timer);
+	timer_delete_sync(&hsr->prune_proxy_timer);
+	timer_delete_sync(&hsr->announce_timer);
 	timer_delete_sync(&hsr->announce_proxy_timer);
 
 	hsr_debugfs_term(hsr);
-- 
2.33.0


