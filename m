Return-Path: <netdev+bounces-61775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08C0824EC1
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 07:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC271C21697
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 06:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43BC3D8F;
	Fri,  5 Jan 2024 06:46:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6842030C
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 06:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4T5v9C02PZz1wrTK;
	Fri,  5 Jan 2024 14:45:35 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id B8F7F1800B9;
	Fri,  5 Jan 2024 14:46:06 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 5 Jan
 2024 14:46:06 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<shaozhengchao@huawei.com>
Subject: [PATCH net-next] fib: rules: remove repeated assignment in fib_nl2rule
Date: Fri, 5 Jan 2024 14:56:34 +0800
Message-ID: <20240105065634.529045-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500026.china.huawei.com (7.185.36.106)

In fib_nl2rule(), 'err' variable has been set to -EINVAL during
declaration, and no need to set the 'err' variable to -EINVAL again.
So, remove it.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 net/core/fib_rules.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 75282222e0b4..a50a0bde8db1 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -594,7 +594,6 @@ static int fib_nl2rule(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (tb[FRA_TUN_ID])
 		nlrule->tun_id = nla_get_be64(tb[FRA_TUN_ID]);
 
-	err = -EINVAL;
 	if (tb[FRA_L3MDEV] &&
 	    fib_nl2rule_l3mdev(tb[FRA_L3MDEV], nlrule, extack) < 0)
 		goto errout_free;
-- 
2.34.1


