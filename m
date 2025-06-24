Return-Path: <netdev+bounces-200620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D84ACAE6511
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7174717EBC0
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6605C280033;
	Tue, 24 Jun 2025 12:33:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1A2222571;
	Tue, 24 Jun 2025 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750768439; cv=none; b=bXfdMTp9VWUzI9fdNuU/iOEIgv5mhoqBHdy3M8ye4ArXKE2e32rCWrm+Cp3s1CMKK42XEPW5idIUO9Dr/y3S4AELk9m0j5KbVNCUj9j1G1zndvHk8E2RBmPlAnEd9VJyRi1hy5dKdnhmWgrMvOnn2CKUX8wHxomkTH8d6jb6ppU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750768439; c=relaxed/simple;
	bh=ntGwK67tdZVtGMNaU6QKhZxFxF5O/eBDm3EURT/Hu1s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HWRwDGhtX6y3Sozu6jPrktwMlfvZweUQKIxwUmmcG6mJvmrMrwkiAB/mmyqzW5n6iWQVb1Hkibp5qvxAbEz17T8U1OAOyKmFb19sIgAkGlZd+mLhA4dIaWz6wu9S2iFAAWRJ75AFrqIEsg+gefYAVyDP2puBhV8/6CPy4aJY4+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bRPQf1J4RzTgmJ;
	Tue, 24 Jun 2025 20:29:30 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E544180237;
	Tue, 24 Jun 2025 20:33:49 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 24 Jun
 2025 20:33:48 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <dsahern@kernel.org>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net: add sysctl ndisc_debug
Date: Tue, 24 Jun 2025 20:51:15 +0800
Message-ID: <20250624125115.3926152-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500016.china.huawei.com (7.185.36.197)

Ipv6 ndisc uses ND_PRINTK to print logs. However it only works when
ND_DEBUG was set in the compilation phase. This patch adds sysctl
ndisc_debug, so we can change the print switch when system is running and
get ipv6 ndisc log to debug.

Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 include/net/ndisc.h        | 5 ++---
 net/ipv6/ndisc.c           | 3 +++
 net/ipv6/sysctl_net_ipv6.c | 7 +++++++
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index 3c88d5bc5eed..481a7fc5d5c1 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -60,12 +60,11 @@ enum {
 
 #include <net/neighbour.h>
 
-/* Set to 3 to get tracing... */
-#define ND_DEBUG 1
+extern u8 ndisc_debug;
 
 #define ND_PRINTK(val, level, fmt, ...)				\
 do {								\
-	if (val <= ND_DEBUG)					\
+	if (val <= ndisc_debug)					\
 		net_##level##_ratelimited(fmt, ##__VA_ARGS__);	\
 } while (0)
 
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index ecb5c4b8518f..be4bb72b1d61 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -83,6 +83,9 @@ static void pndisc_destructor(struct pneigh_entry *n);
 static void pndisc_redo(struct sk_buff *skb);
 static int ndisc_is_multicast(const void *pkey);
 
+u8 ndisc_debug = 1;
+EXPORT_SYMBOL_GPL(ndisc_debug);
+
 static const struct neigh_ops ndisc_generic_ops = {
 	.family =		AF_INET6,
 	.solicit =		ndisc_solicit,
diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
index d2cd33e2698d..c0968f0c5d00 100644
--- a/net/ipv6/sysctl_net_ipv6.c
+++ b/net/ipv6/sysctl_net_ipv6.c
@@ -247,6 +247,13 @@ static struct ctl_table ipv6_rotable[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif /* CONFIG_NETLABEL */
+	{
+		.procname	= "ndisc_debug",
+		.data		= &ndisc_debug,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax
+	},
 };
 
 static int __net_init ipv6_sysctl_net_init(struct net *net)
-- 
2.34.1


