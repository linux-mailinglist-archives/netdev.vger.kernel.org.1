Return-Path: <netdev+bounces-216778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A65B351E8
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 04:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90F01B28481
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 02:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613A12877D6;
	Tue, 26 Aug 2025 02:52:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F33D23D7CB;
	Tue, 26 Aug 2025 02:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756176721; cv=none; b=hqkKPPYKDCdVfxvLjPL1a8qYSERdv+NToSq3199l0EiiQ8rp4ITcQm0Uj5J9sC4PrLe8Y7SQn9XkdXXdxKVyI+AP0HE3lQdUQhKyTTWbkHRM3yLzn3UsIpn7pUxPGIodbRRLx3pzA+WJPQys995Xr3KSZMvdnjmv9hTFLqYIA2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756176721; c=relaxed/simple;
	bh=rXK1J0sn8NjDlpQXEbUam7aOhFmNtqzcAWh58sERuBs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CvNoFyxO0I2FcSuSXaqcUwn9PFqXzEPR1Hw+8ZwSJnGr7eILueTUW1XETy7oVaSSNROv9PYlQAEnKhnbNh7zQkNG4SKRT+VtHJM9TBKfTxBDf6JQofIpIFkre1PTSKvLZ1yN5gdNbrbd3CpdtiAoGxSntyIl7d5K1p9w+KzR7zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c9sYl2zpjz1R92w;
	Tue, 26 Aug 2025 10:48:59 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 15099180044;
	Tue, 26 Aug 2025 10:51:55 +0800 (CST)
Received: from huawei.com (10.50.159.234) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 26 Aug
 2025 10:51:54 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<kuniyu@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH net-next] ipv6: annotate data-races around devconf->rpl_seg_enabled
Date: Tue, 26 Aug 2025 10:52:06 +0800
Message-ID: <20250826025206.303325-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500002.china.huawei.com (7.185.36.57)

devconf->rpl_seg_enabled can be changed concurrently from
/proc/sys/net/ipv6/conf, annotate lockless reads on it.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 net/ipv6/exthdrs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index d1ef9644f826..a23eb8734e15 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -494,10 +494,8 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 
 	idev = __in6_dev_get(skb->dev);
 
-	accept_rpl_seg = net->ipv6.devconf_all->rpl_seg_enabled;
-	if (accept_rpl_seg > idev->cnf.rpl_seg_enabled)
-		accept_rpl_seg = idev->cnf.rpl_seg_enabled;
-
+	accept_rpl_seg = min(READ_ONCE(net->ipv6.devconf_all->rpl_seg_enabled),
+			     READ_ONCE(idev->cnf.rpl_seg_enabled));
 	if (!accept_rpl_seg) {
 		kfree_skb(skb);
 		return -1;
-- 
2.34.1


