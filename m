Return-Path: <netdev+bounces-127669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6052A975FD5
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 05:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 283A0287009
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 03:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA257166F28;
	Thu, 12 Sep 2024 03:43:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261F037703
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 03:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726112590; cv=none; b=SA2oP5kR0WYwFwQpiz4qPkUHY0UE9pmQIiKkAotpt8hDVf8lLCywYQwSpkHfvY/BNTSuKzhydZ6x3LahrkmkjroFUXFVALRlm6O7yX7i+QK/wxICY3aG1ynMkz6x+JKo1msF3bkRJ418FeiWKQALt8i/mC5ZNejaCMx6LLzCZLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726112590; c=relaxed/simple;
	bh=y4f000gStBFJtGSzCbfLAIDwChuStmnq9/G6vs/6cSM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lFlaS7Oy7WvmWfo3OmbLeBmebtcmmwrA5pv6dqjAZWkQ5gRBG6HHdSwMwk6Wmp+PCdcj8uZ27pzJ/ZucNITm13tL9VuO/T6g2UJGeKpOym7wCH2pTTWs3o0hheDiIXcNXgrOuoBXWjLbGt0kojnW4nndQeGNwrml8wx3Gd4KpJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X43Df3wTBz20ntl;
	Thu, 12 Sep 2024 11:42:58 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (unknown [7.185.36.200])
	by mail.maildlp.com (Postfix) with ESMTPS id 49C9D1A0188;
	Thu, 12 Sep 2024 11:43:05 +0800 (CST)
Received: from huawei.com (10.44.142.84) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Sep
 2024 11:43:05 +0800
From: Yu Liao <liaoyu15@huawei.com>
To: <davem@davemloft.net>
CC: <liaoyu15@huawei.com>, <xiexiuqi@huawei.com>, <netdev@vger.kernel.org>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
Subject: [PATCH net-next] net: hsr: convert to use new timer API
Date: Thu, 12 Sep 2024 11:39:12 +0800
Message-ID: <20240912033912.1019563-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500003.china.huawei.com (7.185.36.200)

del_timer_sync() has been renamed to timer_delete_sync(). Inconsistent
API usage makes the code a bit confusing, so replace with the new API.

No functional changes intended.

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
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


