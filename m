Return-Path: <netdev+bounces-181010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23048A8365F
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7C73BB658
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1DF1DD0F2;
	Thu, 10 Apr 2025 02:20:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C721C8639;
	Thu, 10 Apr 2025 02:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251604; cv=none; b=h6BrVLgTVG8DWTFtMzpdd9xn3cAYHrwvnP8ll1MhzhtG8QAB2LlAFpD/ru5UADHf1ftwOsQqysxD0sh+3m3bgPlHiODmDCYsZJu4ctk7bQdeJ+aZFusE1AU8hxtENGWP1bSIufbqrfNWxyKiWCyvMn8/mIQYRSdpIjmRSFCpcN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251604; c=relaxed/simple;
	bh=qYbrNhR2CusQb1SmRQb2ywkd4VIoINGw3PjXJTfZL/k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J70kHn6YfN4kvA8iSJUbGbZKVLy9LSXXDlMzuqdkEA0X+i4THzV1vVZ4xaFAxNZOGCtQ2LwWSep2X/tjpJsgviqH50u8ovQ0/W+7gM4BL7Xzi4IIAH1v6s7tlOfrQ9tHW6RlLe5adId32E4LqDY+cW0ReC8blHNQCvUvlbv0f4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZY3RB3wRcz13LT1;
	Thu, 10 Apr 2025 10:19:18 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 46A931402EB;
	Thu, 10 Apr 2025 10:20:00 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Apr 2025 10:19:59 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net v3 4/7] net: hibmcge: fix wrong mtu log issue
Date: Thu, 10 Apr 2025 10:13:24 +0800
Message-ID: <20250410021327.590362-5-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250410021327.590362-1-shaojijie@huawei.com>
References: <20250410021327.590362-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)

A dbg log is generated when the driver modifies the MTU,
which is expected to trace the change of the MTU.

However, the log is recorded after WRITE_ONCE().
At this time, netdev->mtu has been changed to the new value.
As a result, netdev->mtu is the same as new_mtu.

This patch modifies the log location and records logs before WRITE_ONCE().

Fixes: ff4edac6e9bd ("net: hibmcge: Implement some .ndo functions")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index e5c961ad4b9b..2e64dc1ab355 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -203,12 +203,12 @@ static int hbg_net_change_mtu(struct net_device *netdev, int new_mtu)
 	if (netif_running(netdev))
 		return -EBUSY;
 
-	hbg_hw_set_mtu(priv, new_mtu);
-	WRITE_ONCE(netdev->mtu, new_mtu);
-
 	dev_dbg(&priv->pdev->dev,
 		"change mtu from %u to %u\n", netdev->mtu, new_mtu);
 
+	hbg_hw_set_mtu(priv, new_mtu);
+	WRITE_ONCE(netdev->mtu, new_mtu);
+
 	return 0;
 }
 
-- 
2.33.0


