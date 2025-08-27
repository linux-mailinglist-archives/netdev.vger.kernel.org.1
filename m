Return-Path: <netdev+bounces-217212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBEAB37C38
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 09:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E2E174EC4
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 07:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFCF2D249D;
	Wed, 27 Aug 2025 07:51:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4041D514B;
	Wed, 27 Aug 2025 07:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756281110; cv=none; b=rm/sP0qNM4S40LZa6PjbvFZN5YSo7yG8Nb0D5VrObroP+IduUTabWXfMAhLKR5fUTwoZqih1kdTJKnh0ZGD4+Fy1WQmQN39qXu5Ltx3bx7Q/HqY16x+8c4nsAeTbitYmiCLxLcYYVsiOYeavYvDHecBElMsWVw4G5tajwxHpgrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756281110; c=relaxed/simple;
	bh=u0mH3ZFUJZIxa+X6JbQQclYaJ4VJc7Ol7j47zzz8YQM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KralQzJwRo7dDSs0rvHDj03C87doW7nBUxINyi6nBTkzwr5PqtnLwnpAUjeWQqtaUoIM9oU+25RQN/T+mXgMrUlzh+o81o301SItZ6U7aGp4zjBlgLIiX29Ig2iyAC5uhc+6IAfo9r0AY6uRNPbUb1PEYZqL1Bb3vS+pE4XrwIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cBc9C45F4z1R8yW;
	Wed, 27 Aug 2025 15:48:47 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id C0ADD140144;
	Wed, 27 Aug 2025 15:51:43 +0800 (CST)
Received: from huawei.com (10.50.159.234) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 27 Aug
 2025 15:51:42 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<kuniyu@google.com>, <alex.aring@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH v2 net-next] ipv6: annotate data-races around devconf->rpl_seg_enabled
Date: Wed, 27 Aug 2025 16:12:43 +0800
Message-ID: <20250827081243.1701760-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500002.china.huawei.com (7.185.36.57)

devconf->rpl_seg_enabled can be changed concurrently from
/proc/sys/net/ipv6/conf, annotate lockless reads on it.
Also initializes extra1 and extra2 to SYSCTL_ZERO and SYSCTL_ONE
respectively to avoid negative value writes, which may lead to
unexpected results in ipv6_rpl_srh_rcv().

Fixes: 8610c7c6e3bd ("net: ipv6: add support for rpl sr exthdr")
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
v2: add extra1/2 check
---
 net/ipv6/addrconf.c | 4 +++-
 net/ipv6/exthdrs.c  | 6 ++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 1c1d5cb6a7c1..265238574aab 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -7240,7 +7240,9 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.data		= &ipv6_devconf.rpl_seg_enabled,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
 	},
 	{
 		.procname	= "ioam6_enabled",
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


