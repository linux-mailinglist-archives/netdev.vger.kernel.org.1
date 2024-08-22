Return-Path: <netdev+bounces-120802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924C695AC89
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 06:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6DD281BC2
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 04:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE584D8B0;
	Thu, 22 Aug 2024 04:25:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41395589C
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 04:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724300728; cv=none; b=IGkJs+zEVDzm5Ia/yacYG32EBArRg1st/GvaYnG23yxC5C+9Yz7CnBfqaXmNl6cK4vlz8CNf3/1yaB3/Tq4qKCKy5it1jj9Rs7sjoLCNkGu6bCtYwrcOaFvVwhUk/yXYj+14ecllSJAwp3nmhWAQqNWcB/s+gf2730r4f1Sxk6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724300728; c=relaxed/simple;
	bh=wMyf1bv1213SMmHHMV/KhyOOMqVLrkARxj6RQaC1HZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OvF3co7dNu1szqsuPfJG/pv09xeg8uoMsdOReYw0bKpM7XAtxynDAnyeV8O2ckZic2tBujC8HScQZ+a2Yox/o69rvgTxxw52S/hp9Ln74fQiakjQCUky4mT7dvdJh1JV6VLFbaBPi+FSh1H3HyYuCxOukpjrPFnK053Ge9XBx8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wq96t1wPnzhXq2;
	Thu, 22 Aug 2024 12:23:18 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 2CD501800A4;
	Thu, 22 Aug 2024 12:25:19 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 12:25:18 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <idosch@nvidia.com>,
	<amcohen@nvidia.com>, <petrm@nvidia.com>, <gnault@redhat.com>,
	<b.galvani@gmail.com>, <alce@lafranque.net>, <shaozhengchao@huawei.com>,
	<horms@kernel.org>, <lizetao1@huawei.com>, <j.granados@samsung.com>,
	<linux@weissschuh.net>, <judyhsiao@chromium.org>, <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>
Subject: [PATCH net-next 04/10] rtnetlink: delete redundant judgment statements
Date: Thu, 22 Aug 2024 12:32:46 +0800
Message-ID: <20240822043252.3488749-5-lizetao1@huawei.com>
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
 net/core/rtnetlink.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 73fd7f543fd0..cd9487a12d1a 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4087,8 +4087,7 @@ struct sk_buff *rtmsg_ifinfo_build_skb(int type, struct net_device *dev,
 	}
 	return skb;
 errout:
-	if (err < 0)
-		rtnl_set_sk_err(net, RTNLGRP_LINK, err);
+	rtnl_set_sk_err(net, RTNLGRP_LINK, err);
 	return NULL;
 }
 
-- 
2.34.1


