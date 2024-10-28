Return-Path: <netdev+bounces-139453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9769B29DF
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 09:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AEB81C21B38
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 08:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D941922E4;
	Mon, 28 Oct 2024 08:05:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4791E517;
	Mon, 28 Oct 2024 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730102753; cv=none; b=B2V2yV2zvNt7A+jy0cU3vjHvmRLBzmT6j7F55CX6D4gUcEnrqjE5hXvadlPPKGEW9KU5zkyc7D3dIuHFR7AJdST3/AcrD6JiumfGXlwO+PZL3IT1evJE1lTmjT2mRSkd87MU1aZngY3zInBv9y29nxjLevXS281RY7SkqbGkTSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730102753; c=relaxed/simple;
	bh=dviMwiAMFSbxCHyTiVlGnp7JwQoMFZLYV9XlffgTC+c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iHN6gxTMJCYKMwxR4SPlhE1yd6cC4h50Ho4BRZVinKTf9dzuC6BBJF9Gb9xFHKRvqMuTHTuqnrBQdSTEOJ4KfC6jGXAAR4l+cjLejQBQrIR9k7Lk5TCQ+FOMOtY6Zr6+NeQ0AARf4rjIE7P9QER36S19TJ6O1/KtYGTAR88QgDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XcQrS40GvzpXVC;
	Mon, 28 Oct 2024 16:03:52 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 8826D1402CC;
	Mon, 28 Oct 2024 16:05:48 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 28 Oct
 2024 16:05:47 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <kuniyu@amazon.com>,
	<a.kovaleva@yadro.com>, <ruanjinjie@huawei.com>, <lirongqing@baidu.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net] netlink: Fix off-by-one error in netlink_proto_init()
Date: Mon, 28 Oct 2024 16:05:15 +0800
Message-ID: <20241028080515.3540779-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg200008.china.huawei.com (7.202.181.35)

In the error path of netlink_proto_init(), frees the already allocated
bucket table for new hash tables in a loop, but the loop condition
terminates when the index reaches zero, which fails to free the first
bucket table at index zero.

Check for >= 0 so that nl_table[0].hash is freed as well.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 net/netlink/af_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 0a9287fadb47..9601b85dda95 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2936,7 +2936,7 @@ static int __init netlink_proto_init(void)
 	for (i = 0; i < MAX_LINKS; i++) {
 		if (rhashtable_init(&nl_table[i].hash,
 				    &netlink_rhashtable_params) < 0) {
-			while (--i > 0)
+			while (--i >= 0)
 				rhashtable_destroy(&nl_table[i].hash);
 			kfree(nl_table);
 			goto panic;
-- 
2.34.1


