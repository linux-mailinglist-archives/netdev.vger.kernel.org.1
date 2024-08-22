Return-Path: <netdev+bounces-120799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BE895AC86
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 06:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4121C22740
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 04:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4316C3B290;
	Thu, 22 Aug 2024 04:25:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868363BB32
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 04:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724300725; cv=none; b=N8yqMC90awya+SzhAkOXdRJ/wtVMPNlji1EYzxR2RkTJvennVGoqQovrqyGF5fg6GromGT1oeQVAvlIy1l+s1CeOX/fbs2IkP2x9mNVpimyDt867I7DrWgK274axI5dyZmKJDNhfNTH4LeBbnwoFEy3uh9PsHPPaF5vBY7BQa4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724300725; c=relaxed/simple;
	bh=zR2bKrgMPbv7xIYtto+QcPT3oWiL8h3YJzYAef6wXLI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mk5fRZMDdDPWeAHaQHkt/A2WoONV9VO92HyM00tcU1EOb005Enw/E5xPU9NRQYa7VQIM9ir3wZibL2dKSFMueU3XrC/60Z6JqOsOcfAwROt0qR5BzcV8Voh7N2Hmng93DMAgXTdWnDH7ndZhDVwfmkpModPCSllL9DF7gU3tcwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wq9993d46z1S8Vw;
	Thu, 22 Aug 2024 12:25:17 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 52A1B1401E9;
	Thu, 22 Aug 2024 12:25:21 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 12:25:20 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <idosch@nvidia.com>,
	<amcohen@nvidia.com>, <petrm@nvidia.com>, <gnault@redhat.com>,
	<b.galvani@gmail.com>, <alce@lafranque.net>, <shaozhengchao@huawei.com>,
	<horms@kernel.org>, <lizetao1@huawei.com>, <j.granados@samsung.com>,
	<linux@weissschuh.net>, <judyhsiao@chromium.org>, <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>
Subject: [PATCH net-next 07/10] net: nexthop: delete redundant judgment statements
Date: Thu, 22 Aug 2024 12:32:49 +0800
Message-ID: <20240822043252.3488749-8-lizetao1@huawei.com>
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
 net/ipv4/nexthop.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 9db10d409074..93aaea0006ba 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -1090,8 +1090,7 @@ static void nexthop_notify(int event, struct nexthop *nh, struct nl_info *info)
 		    info->nlh, gfp_any());
 	return;
 errout:
-	if (err < 0)
-		rtnl_set_sk_err(info->nl_net, RTNLGRP_NEXTHOP, err);
+	rtnl_set_sk_err(info->nl_net, RTNLGRP_NEXTHOP, err);
 }
 
 static unsigned long nh_res_bucket_used_time(const struct nh_res_bucket *bucket)
@@ -1211,8 +1210,7 @@ static void nexthop_bucket_notify(struct nh_res_table *res_table,
 	rtnl_notify(skb, nh->net, 0, RTNLGRP_NEXTHOP, NULL, GFP_KERNEL);
 	return;
 errout:
-	if (err < 0)
-		rtnl_set_sk_err(nh->net, RTNLGRP_NEXTHOP, err);
+	rtnl_set_sk_err(nh->net, RTNLGRP_NEXTHOP, err);
 }
 
 static bool valid_group_nh(struct nexthop *nh, unsigned int npaths,
-- 
2.34.1


