Return-Path: <netdev+bounces-120803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEA895AC8A
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 06:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6883928273B
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 04:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF27A61FC5;
	Thu, 22 Aug 2024 04:25:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70A225779
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 04:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724300728; cv=none; b=NO1aEeS453pnr+Bzc1sd8Td7ECQXs40QkTERROhs1SYkxlPD3CSYHeyLphIReu4/Z8377TBycBuznlDqpL3KcMwO+0bbSRHe2+20CpaUbXMFM666f9Cxjh60dOPROZjr0lGqFIl2iQGoJjPks8Swml46yeGCr8WOmmjxdImfswM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724300728; c=relaxed/simple;
	bh=c+aiDkG5K9O38mRIHTq0MT6frypsrKgZPpCWDP4OHbI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ucQulw62RogUNXw30Ymoa0To75ZvLATY0mUSYv7pd4RIwS2RGuvzrzkDzufdKB2AcCrvoQcqZo0SnUw5HVXLkxNT0v5mJ2APlk2LQmY9WiXJ1jmdbG9eRyyuwHCmf4F4blAN2zrR/zG2brXbbFEDxWjZ6Fx3ozfcm6EVCqzZQJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Wq96z4cRLz1xvGH;
	Thu, 22 Aug 2024 12:23:23 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B4B91A0188;
	Thu, 22 Aug 2024 12:25:18 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 12:25:17 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <idosch@nvidia.com>,
	<amcohen@nvidia.com>, <petrm@nvidia.com>, <gnault@redhat.com>,
	<b.galvani@gmail.com>, <alce@lafranque.net>, <shaozhengchao@huawei.com>,
	<horms@kernel.org>, <lizetao1@huawei.com>, <j.granados@samsung.com>,
	<linux@weissschuh.net>, <judyhsiao@chromium.org>, <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>
Subject: [PATCH net-next 03/10] neighbour: delete redundant judgment statements
Date: Thu, 22 Aug 2024 12:32:45 +0800
Message-ID: <20240822043252.3488749-4-lizetao1@huawei.com>
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
 net/core/neighbour.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index a6fe88eca939..77b819cd995b 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3530,8 +3530,7 @@ static void __neigh_notify(struct neighbour *n, int type, int flags,
 	rtnl_notify(skb, net, 0, RTNLGRP_NEIGH, NULL, GFP_ATOMIC);
 	return;
 errout:
-	if (err < 0)
-		rtnl_set_sk_err(net, RTNLGRP_NEIGH, err);
+	rtnl_set_sk_err(net, RTNLGRP_NEIGH, err);
 }
 
 void neigh_app_ns(struct neighbour *n)
-- 
2.34.1


