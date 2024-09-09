Return-Path: <netdev+bounces-126335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C48970BF5
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 04:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07251F227C9
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 02:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9942191F6F;
	Mon,  9 Sep 2024 02:38:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BEA19005B;
	Mon,  9 Sep 2024 02:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725849512; cv=none; b=fD8bCe/McRr38ZfFF876xMBD+s5i0aqQgPUIdDxJDY+1Tw+XU3Dm/YzgQbvSdSOfhhI6tkhPh/mgT/nVkHUICKlVXRalF/Vk8E8sxKDAtVEWUKkesDuLZnEQHFOsG89Nm4O6cNZ6BRt011GTlG3dACFcotGZ5QEm8LdClEnj/RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725849512; c=relaxed/simple;
	bh=j2sFzKHIvZtXIzn+EfS/3JETndR1dfz583G/k3ujcDE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nE1eWuMvS0z+5vGF3mWZd2tweKxqchGBORt+H7RpUQPPGYl7a8YttCw0OKT0n0czeAvGt1h9Ds28rm3yRAft+dKwSXlMnPYPfpHzPhjrHpDvhCfi9EBjsh2ZVz7WVmpKZG6EoovQR1DuIKdlnIZocyBX5AoRyLxx6pl+u4Pjf9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X29x51VHXz2DbyX;
	Mon,  9 Sep 2024 10:38:01 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 847401A0188;
	Mon,  9 Sep 2024 10:38:27 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 10:38:26 +0800
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
Subject: [PATCH V8 net-next 11/11] net: add ndo_validate_addr check in dev_set_mac_address
Date: Mon, 9 Sep 2024 10:31:41 +0800
Message-ID: <20240909023141.3234567-12-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240909023141.3234567-1-shaojijie@huawei.com>
References: <20240909023141.3234567-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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


