Return-Path: <netdev+bounces-140223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAC59B590A
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 02:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37F82836C9
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 01:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E75313A27D;
	Wed, 30 Oct 2024 01:22:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6725442A8B;
	Wed, 30 Oct 2024 01:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730251343; cv=none; b=tKx0S4oYTEGKK3vWf+0d6BHEOJJXf8eCjd/ItKetJJ98Qs2XjKhG4fJVJSHGT8lX/NeN12LSNEMfVA3OAAMGFJXLG9wufgDlOgfTbhOYwhtd36AbWD/e/8sTDzDnX8/evSbUYiE0DA/m/LvmLWeTe36pfmfVJtaUOOryRBl4jv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730251343; c=relaxed/simple;
	bh=dw7CKm212MEtYS6faHm0xd8Sz/4ekh3Xk4HCayEH0P4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kFI0rVgemex90yrs39qgJohWo/er9wS7Jh3oUrYJzlkDtaIaTok4BQ5Qt/cPBNDXSf2H6O8QLN2QybHu531y0hJ5l8rcI5LXYeT1sk+AgS6lKZyKNFRlXXVgBsmfnA+P6vY1R1XfidAl5FEkS6fgqv7oKQpexXtecLI3P60mOj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XdTq140Thz20r7d;
	Wed, 30 Oct 2024 09:21:17 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 7066D1402E1;
	Wed, 30 Oct 2024 09:22:16 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemg200008.china.huawei.com
 (7.202.181.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 30 Oct
 2024 09:22:15 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <kuniyu@amazon.com>,
	<dsahern@kernel.org>, <ruanjinjie@huawei.com>, <lirongqing@baidu.com>,
	<ryasuoka@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2] netlink: Remove the dead code in netlink_proto_init()
Date: Wed, 30 Oct 2024 09:21:47 +0800
Message-ID: <20241030012147.357400-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg200008.china.huawei.com (7.202.181.35)

In the error path of netlink_proto_init(), frees the already allocated
bucket table for new hash tables in a loop, but it is going to panic,
so it is not necessary to clean up the resources, just remove the
dead code.

Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Add Suggested-by.
- Remove the fix tag.
- Remove instead of check >=0.
- Update the commit message.
---
 net/netlink/af_netlink.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 0a9287fadb47..52a7c7233cab 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2935,12 +2935,8 @@ static int __init netlink_proto_init(void)
 
 	for (i = 0; i < MAX_LINKS; i++) {
 		if (rhashtable_init(&nl_table[i].hash,
-				    &netlink_rhashtable_params) < 0) {
-			while (--i > 0)
-				rhashtable_destroy(&nl_table[i].hash);
-			kfree(nl_table);
+				    &netlink_rhashtable_params) < 0)
 			goto panic;
-		}
 	}
 
 	netlink_add_usersock_entry();
-- 
2.34.1


