Return-Path: <netdev+bounces-123682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D650C966188
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 14:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B04B1F26D31
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 12:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF14F1B29BE;
	Fri, 30 Aug 2024 12:22:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B433B1AF4C1;
	Fri, 30 Aug 2024 12:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725020533; cv=none; b=qE5exGI51uqvgaR5AUc1/3gpr+AUXSZdZghB+4I7YL6E9c0+g/u+ZLxv5GBw27/tiS2kNh6hOw43SOEvBS+wqXaxjc1Ye5mVLeRAeBUWN97KHYZhh/quRQj6WxF2COCsqGHKgDkwFzFmvb0BShkZbWespRCKD7N+qedy/JhkNPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725020533; c=relaxed/simple;
	bh=6qlCfPZAxbTgCqffuq+sksoAH4R8qdus5diqaiztjYQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mh6Do3utWLfiapVVSMF+cmkbX200CL3ZR53iHL+afHGtpNau1tb2PzRN1A6lCTSSFNjMdgySLIWDSJMTu4KgHtwaPP5g1xambHHfHJVm5jFQ2eXXeiJaJOUOLQ9vFKCaJUxwuRzC3djUXDw/f5JmoVe2758VkB6qa6oVZIsNCbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WwHHq1LfKz1HHdx;
	Fri, 30 Aug 2024 20:18:47 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 3725B180041;
	Fri, 30 Aug 2024 20:22:09 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 20:22:08 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <shaojijie@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<libaihan@huawei.com>, <andrew@lunn.ch>, <jdamato@fastly.com>,
	<horms@kernel.org>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V6 net-next 11/11] net: add ndo_validate_addr check in dev_set_mac_address
Date: Fri, 30 Aug 2024 20:16:04 +0800
Message-ID: <20240830121604.2250904-12-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240830121604.2250904-1-shaojijie@huawei.com>
References: <20240830121604.2250904-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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


