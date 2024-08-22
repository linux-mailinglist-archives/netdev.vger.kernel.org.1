Return-Path: <netdev+bounces-120798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E1A95AC85
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 06:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6FFB1F224A1
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 04:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F1C41A94;
	Thu, 22 Aug 2024 04:25:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D1838DC0
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 04:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724300723; cv=none; b=vDBTkZvdj8Ls0RsdDGJ955ii1ANuZwKI7qF0O6E4CbAe6cVJhZ+WDJoP519mDwTFIjEwnYK7ydJRf34Y/gV36Yi/4QNGZWiVpMKaC3XdjcIvzsV9XBTZvolI/KOL5J99Z58LY6a1qY/9KcE+L3JsQkjEzebSY+tMH1krpaZuV1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724300723; c=relaxed/simple;
	bh=XAEv2w1uDssPxnHVjUZwz+ke1nXgokU6gXhLWhPVKJQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YosT0d4IPuEeZ6qVQWTZO2rvvkAIoif18gGqseKpTyJyUV/1asI1YxSrQJKjqGfLV3ZJMtXIMDN0bNGH1kba/PhhTGt52cV7wPVB1ZOc9TJx9Myab6+EPTRtilPGFqGcOLGdrw614XzMMp6ZhNuJoaAFCy2r2YlsNDjWQy3tYeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wq9980L9Qz1S8W3;
	Thu, 22 Aug 2024 12:25:16 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id D78BD1400DD;
	Thu, 22 Aug 2024 12:25:19 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 12:25:19 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <idosch@nvidia.com>,
	<amcohen@nvidia.com>, <petrm@nvidia.com>, <gnault@redhat.com>,
	<b.galvani@gmail.com>, <alce@lafranque.net>, <shaozhengchao@huawei.com>,
	<horms@kernel.org>, <lizetao1@huawei.com>, <j.granados@samsung.com>,
	<linux@weissschuh.net>, <judyhsiao@chromium.org>, <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>
Subject: [PATCH net-next 05/10] ipv4: delete redundant judgment statements
Date: Thu, 22 Aug 2024 12:32:47 +0800
Message-ID: <20240822043252.3488749-6-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822043252.3488749-1-lizetao1@huawei.com>
References: <20240822043252.3488749-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd500012.china.huawei.com (7.221.188.25)

The initial value of err is -ENOBUFS, and err is guaranteed to be
less than 0 before all goto errout. Therefore, on the error path
of errout, there is no need to repeatedly judge that err is less than 0,
and delete redundant judgments to make the code more concise.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 net/ipv4/devinet.c       | 6 ++----
 net/ipv4/fib_semantics.c | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 61be85154dd1..ab76744383cf 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1943,8 +1943,7 @@ static void rtmsg_ifa(int event, struct in_ifaddr *ifa, struct nlmsghdr *nlh,
 	rtnl_notify(skb, net, portid, RTNLGRP_IPV4_IFADDR, nlh, GFP_KERNEL);
 	return;
 errout:
-	if (err < 0)
-		rtnl_set_sk_err(net, RTNLGRP_IPV4_IFADDR, err);
+	rtnl_set_sk_err(net, RTNLGRP_IPV4_IFADDR, err);
 }
 
 static size_t inet_get_link_af_size(const struct net_device *dev,
@@ -2140,8 +2139,7 @@ void inet_netconf_notify_devconf(struct net *net, int event, int type,
 	rtnl_notify(skb, net, 0, RTNLGRP_IPV4_NETCONF, NULL, GFP_KERNEL);
 	return;
 errout:
-	if (err < 0)
-		rtnl_set_sk_err(net, RTNLGRP_IPV4_NETCONF, err);
+	rtnl_set_sk_err(net, RTNLGRP_IPV4_NETCONF, err);
 }
 
 static const struct nla_policy devconf_ipv4_policy[NETCONFA_MAX+1] = {
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 0f70341cb8b5..ba2df3d2ac15 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -543,8 +543,7 @@ void rtmsg_fib(int event, __be32 key, struct fib_alias *fa,
 		    info->nlh, GFP_KERNEL);
 	return;
 errout:
-	if (err < 0)
-		rtnl_set_sk_err(info->nl_net, RTNLGRP_IPV4_ROUTE, err);
+	rtnl_set_sk_err(info->nl_net, RTNLGRP_IPV4_ROUTE, err);
 }
 
 static int fib_detect_death(struct fib_info *fi, int order,
-- 
2.34.1


