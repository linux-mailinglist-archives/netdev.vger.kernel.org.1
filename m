Return-Path: <netdev+bounces-120880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7A395B1F6
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 11:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4177B25AD7
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 09:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ED9185B7D;
	Thu, 22 Aug 2024 09:39:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E49B18455D;
	Thu, 22 Aug 2024 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319584; cv=none; b=f5Zn9gf4SpO9jiXGxuqKA1UlO+G+j5vQtsuzAf47CS639zMKb1LEMWI+eO2RL4TrglfXwzQNgkGPO0Lkv+co0JI7qSOAB2BkwDfVK0iXjMhYO9JUvyDfVSdoPb7kgRd0qt+uYXcTqc11PtD5PXTfuAhYt+Vv6LmGydWr48rwyXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319584; c=relaxed/simple;
	bh=mi7ijLilhXk+ETxebggdcMSRbjk0Ha+z94Nd6Y7tuDs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UCFbd2NTF2+chfW8hIwFIqzFif7p73pIObgqkkgIccoeObaVfP9H6hGruQb4nzMSXvva1ExBEED6wbxTeHvUOSvXJhsLojgnv7mhPSTzKTqK9OkIWajpCXAOagxT47vVz8BXgBFGgw90UmUPp7IKCkkpfYAPU9hfMqirGKEPb0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WqJ7s1NcSz1j6kd;
	Thu, 22 Aug 2024 17:39:37 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 853401A016C;
	Thu, 22 Aug 2024 17:39:40 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 17:39:39 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<andrew@lunn.ch>, <jdamato@fastly.com>, <horms@kernel.org>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V3 net-next 11/11] net: add ndo_validate_addr check in dev_set_mac_address
Date: Thu, 22 Aug 2024 17:33:34 +0800
Message-ID: <20240822093334.1687011-12-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240822093334.1687011-1-shaojijie@huawei.com>
References: <20240822093334.1687011-1-shaojijie@huawei.com>
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
---
 net/core/dev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index e7260889d4cb..7e9c3017e705 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9087,6 +9087,11 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
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


