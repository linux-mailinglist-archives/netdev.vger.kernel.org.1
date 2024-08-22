Return-Path: <netdev+bounces-120797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B2295AC84
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 06:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE881F22300
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 04:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72173F9F9;
	Thu, 22 Aug 2024 04:25:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DBD381B8
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 04:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724300723; cv=none; b=bWnd1KnizhgRppLK7P2YyX0VrDYbQeXrsDa2/g1cd6qZUbDrIcdC9gEkElxVCpz8UNa/BVBW+Qkc6j72H3UO8pZrdDdX6cLQHyi6PG/X+YT15Rw2tBMfRvLyCa2h1MZ56f4ji/Xp7hOcPopNN8JSKmUHB0k1sMMs026sxJypjHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724300723; c=relaxed/simple;
	bh=P8kyva4Coy5jhYkR+YUBJlGGMR7KXbJ9fBg8YpHLPnc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gvI4BeOICYFh3oSN0rsUqJVXCAbKOH7Xm7UuGAZY1JKTvY8FIIvk37OqKSfNoJajeHJpj+TQNfxQxIJIBV+0h9P6b5OOhMHfj8JDqg2OnapnC8fNcXO+RgaNQeiU9EplwrQVxWMKu4hRnyKfUu4rCk96yVNMYFyRcUz0vtI1ot8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wq95S6D4vz1HH4b;
	Thu, 22 Aug 2024 12:22:04 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id B61031A0188;
	Thu, 22 Aug 2024 12:25:17 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 12:25:16 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <idosch@nvidia.com>,
	<amcohen@nvidia.com>, <petrm@nvidia.com>, <gnault@redhat.com>,
	<b.galvani@gmail.com>, <alce@lafranque.net>, <shaozhengchao@huawei.com>,
	<horms@kernel.org>, <lizetao1@huawei.com>, <j.granados@samsung.com>,
	<linux@weissschuh.net>, <judyhsiao@chromium.org>, <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>
Subject: [PATCH net-next 02/10] fib: rules: delete redundant judgment statements
Date: Thu, 22 Aug 2024 12:32:44 +0800
Message-ID: <20240822043252.3488749-3-lizetao1@huawei.com>
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

The initial value of err is -ENOMEM, and err is guaranteed to be
less than 0 before all goto errout. Therefore, on the error path
of errout, there is no need to repeatedly judge that err is less than 0,
and delete redundant judgments to make the code more concise.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 net/core/fib_rules.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 6ebffbc63236..3c76b835493d 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -1205,8 +1205,7 @@ static void notify_rule_change(int event, struct fib_rule *rule,
 	rtnl_notify(skb, net, pid, ops->nlgroup, nlh, GFP_KERNEL);
 	return;
 errout:
-	if (err < 0)
-		rtnl_set_sk_err(net, ops->nlgroup, err);
+	rtnl_set_sk_err(net, ops->nlgroup, err);
 }
 
 static void attach_rules(struct list_head *rules, struct net_device *dev)
-- 
2.34.1


