Return-Path: <netdev+bounces-120795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5470395AC82
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 06:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9031C22290
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 04:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6636639AFD;
	Thu, 22 Aug 2024 04:25:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D4F25779
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 04:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724300722; cv=none; b=A90EzwhNQNBFfIUFyZCpeOIIXSsg850Bax08b3LmkI3xWt+lAKWmrnG8oU6xBdS2fVBMgqgQmuUII+LjVwc0K7fYD4gHsCtG46uxzhyt5SBsV0m5Nz0XiEWe4Suc3qw7F9VQDctJ0wStIHeiL8FdZNyeWAVQ138UdWuJVLrFXNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724300722; c=relaxed/simple;
	bh=ea0y8yWVi43P0vkxaiRf1+gteNi0hb+tnfAaMPtD1Co=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rc7VM105YKLHvaorCWkqFd12E5145ETGJUqnmFRQRcyZlEufD5OxzFaXU7S1ywwsQuIFJO3uXvfzYd+9qde1Zx1Kgd4E5NDHJTGYCdS18hrTETsJUHmSSTw45X6YHD9VsqBoRZ6nJpnB7Lvu5E3cxjATdSBj9ydoN45qo/0NhBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wq95S0ztXz1HH4V;
	Thu, 22 Aug 2024 12:22:04 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 02F621401E9;
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
Subject: [PATCH net-next 01/10] net: vxlan: delete redundant judgment statements
Date: Thu, 22 Aug 2024 12:32:43 +0800
Message-ID: <20240822043252.3488749-2-lizetao1@huawei.com>
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
 drivers/net/vxlan/vxlan_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 8983e75e9881..34391c18bba7 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -277,8 +277,7 @@ static void __vxlan_fdb_notify(struct vxlan_dev *vxlan, struct vxlan_fdb *fdb,
 	rtnl_notify(skb, net, 0, RTNLGRP_NEIGH, NULL, GFP_ATOMIC);
 	return;
 errout:
-	if (err < 0)
-		rtnl_set_sk_err(net, RTNLGRP_NEIGH, err);
+	rtnl_set_sk_err(net, RTNLGRP_NEIGH, err);
 }
 
 static void vxlan_fdb_switchdev_notifier_info(const struct vxlan_dev *vxlan,
-- 
2.34.1


