Return-Path: <netdev+bounces-125581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAD996DC0B
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 16:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 266F4B271CC
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 14:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9007919F49B;
	Thu,  5 Sep 2024 14:37:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E1719D8AF;
	Thu,  5 Sep 2024 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725547046; cv=none; b=gXfDSMjj9KexbKaNXMNMRUIihQIZFe5U3EE8dHxEa3UqsLCnHGlXV6smdcy0FFeqcLKkujjrAII+g6uqXxtDZ5bFiYQVaNPv8j7w6HfwJw18q2eJai6JYg6IVF3nqYxxH1yrbDQXNsKltVLZ9qfUJCTrXDd1kAyT5+XNY0Q0V0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725547046; c=relaxed/simple;
	bh=j2sFzKHIvZtXIzn+EfS/3JETndR1dfz583G/k3ujcDE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TFI45jLeV2omkinye2XYljzgSDnAejDqO50PsN/g5c1TYnFlkYu1Ofkwe09tqQusnIPonUEJGc6DMwZDz4YJsnH4Bl07WdEiA2k5ADjy2QdjI3M+ej+IiTLQDkf9fzcVCbQgYYSQP4Xnk+M6XCTe1pzMYfMO+7aWYRUjA+N2p2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4X023p5D3Wz18N54;
	Thu,  5 Sep 2024 22:36:22 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F302180100;
	Thu,  5 Sep 2024 22:37:21 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Sep 2024 22:37:20 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <shaojijie@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<libaihan@huawei.com>, <zhuyuan@huawei.com>, <forest.zhouchang@huawei.com>,
	<andrew@lunn.ch>, <jdamato@fastly.com>, <horms@kernel.org>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V7 net-next 11/11] net: add ndo_validate_addr check in dev_set_mac_address
Date: Thu, 5 Sep 2024 22:31:20 +0800
Message-ID: <20240905143120.1583460-12-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240905143120.1583460-1-shaojijie@huawei.com>
References: <20240905143120.1583460-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000007.china.huawei.com (7.193.23.189)

If driver implements ndo_validate_addr,
core should check the mac address before ndo_set_mac_address.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
ChangeLog:
v2 -> v3:
  - Use ndo_validate_addr() instead of is_valid_ether_addr()
    in dev_set_mac_address(), suggested by Jakub and Andrew.
  v2: https://lore.kernel.org/all/20240820140154.137876-1-shaojijie@huawei.com/
---
 net/core/dev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 98bb5f890b88..d6ec91ea8043 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9089,6 +9089,11 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 		return -EOPNOTSUPP;
 	if (sa->sa_family != dev->type)
 		return -EINVAL;
+	if (ops->ndo_validate_addr) {
+		err = ops->ndo_validate_addr(dev);
+		if (err)
+			return err;
+	}
 	if (!netif_device_present(dev))
 		return -ENODEV;
 	err = dev_pre_changeaddr_notify(dev, sa->sa_data, extack);
-- 
2.33.0


