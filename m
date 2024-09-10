Return-Path: <netdev+bounces-126871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAF2972B89
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 10:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DB551C245E7
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E91218DF94;
	Tue, 10 Sep 2024 08:06:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50410188A3A;
	Tue, 10 Sep 2024 08:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955581; cv=none; b=ckgxY4DZm/RZIiLBdpuKPSXQeu7vfBdjyb/e0cHrZbF8Szi6Vr7nApqcFAplWcl2qJpwysNvp0oI2JekcWHIy0TNl9lSz321H8gg5WTWBB21xZ+4o4Vx9GT9BHOM3+iT+ov2BjB8f5noAMWgV+SwSI/FwJb46UrEwJF24xbrepc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955581; c=relaxed/simple;
	bh=AzWTqf9mgdhH51glUN+Q5u9Y9J9MonZTUf7E4KxwEHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dHW8BIWW3zxnIqr0ZQ5o2eBAsUvDtnU/w7iiGCapq9fN/MwZIO7STYPRbQ6+x1nB9qTsFh4/MAQZqK+8lmY1LSg6yL381blu/fvAPV4gV+OyIpewPrQgYOiWSvXWU5pWWXNjal7dbriQg1SidRCOCHID682CjojORsf9QsPfJyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X2x8r6xypz2Dc3f;
	Tue, 10 Sep 2024 16:05:48 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id D7EC61A0188;
	Tue, 10 Sep 2024 16:06:16 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 16:06:15 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<andrew@lunn.ch>, <jdamato@fastly.com>, <horms@kernel.org>,
	<kalesh-anakkur.purayil@broadcom.com>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V9 net-next 11/11] net: add ndo_validate_addr check in dev_set_mac_address
Date: Tue, 10 Sep 2024 15:59:42 +0800
Message-ID: <20240910075942.1270054-12-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240910075942.1270054-1-shaojijie@huawei.com>
References: <20240910075942.1270054-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
index 22c3f14d9287..00e0f473ed44 100644
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


