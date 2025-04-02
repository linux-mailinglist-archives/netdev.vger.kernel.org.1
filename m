Return-Path: <netdev+bounces-178810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C430CA7902A
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 15:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AFA816C2FD
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 13:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A36D23BF9C;
	Wed,  2 Apr 2025 13:46:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDDD1482E8;
	Wed,  2 Apr 2025 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743601569; cv=none; b=GjMpeuMHEUIvd4cWJNtUf7nMabaAX+x8ClhDBYpsekaA34lxkSnW0Guxi9bLNuUqiQfBOfsJ1yooZcXAaa8xrPXGNDMIbPEZ4RLZY3yAZaPwDHFecT5T323AtC1ZlJm5y+JcObwWnaPTHG9vnU/J0zvGmFsscdXzXFuGHi2Sq64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743601569; c=relaxed/simple;
	bh=w92eSDKM73sWTnHEyRsM0ea9+L+OfX552mUSpVxogjk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t8Nb0RrKPc3vGYQgrdypW+Td4p7xMJAeDv5+p4O4JvJtQguvXTjp31eUGD+QmVDXmQf+8cX1Zk1TyzERRogcjsESC5rnOr6VI35b9aCgv5V+Wa7m/Hx3Jpukn1AXb7ebSwLZ2maB959GZU90smXaLavqWbTq1JJKNnisCZXYhdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ZSR423SDbz27hJ0;
	Wed,  2 Apr 2025 21:46:42 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 583A01A016C;
	Wed,  2 Apr 2025 21:46:03 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Apr 2025 21:46:02 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net 4/7] net: hibmcge: fix wrong mtu log issue
Date: Wed, 2 Apr 2025 21:39:02 +0800
Message-ID: <20250402133905.895421-5-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250402133905.895421-1-shaojijie@huawei.com>
References: <20250402133905.895421-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk100013.china.huawei.com (7.202.194.61)

A dbg log is generated when the driver modifies the MTU,
which is expected to trace the change of the MTU.

However, the log is recorded after WRITE_ONCE().
At this time, netdev->mtu has been changed to the new value.
As a result, netdev->mtu is the same as new_mtu.

This patch modifies the log location and records logs before WRITE_ONCE().

Fixes: ff4edac6e9bd ("net: hibmcge: Implement some .ndo functions")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
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


