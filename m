Return-Path: <netdev+bounces-181016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2A3A83669
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C353BF8BC
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C041EA7C4;
	Thu, 10 Apr 2025 02:20:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6D71E9B00;
	Thu, 10 Apr 2025 02:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251612; cv=none; b=S6sgojmT26/z8ct04htxm+Aku+AMHywLdfb7SqM1Zm5+UbW95K67RGuH9YEKI4bEPNo8ut9w+8VVc11QdqaI6zcAvd0E0+J6sl8QT8h7RLpPb/loDD7gRTaGfUYG7fNEqxe2g7gly9uRwpvx2nudY8C3Fg0DAIhQ+6YIOu+hGCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251612; c=relaxed/simple;
	bh=I7DkFdfuScO8i9b3F0kRKooZB7ODmbojxm/2UgIFF/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZE1fGDPFWoZWFRz2Yl0WTFwuuEbEqnbxgFxN8gvrETdB3JzmQDw41An1csvBpSL7JX62KVOabCnoftBKIRf5FWo9+6Kh5jly21+VMFGnn3Z/IXKC9h1C1gn8dgoxr8u78RXLMECaODmwYxlJpDrEy5Rp8lyQegcipwhGAmE1/A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZY3QQ4qYKzQwQS;
	Thu, 10 Apr 2025 10:18:38 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 558561800EE;
	Thu, 10 Apr 2025 10:20:02 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Apr 2025 10:20:01 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net v3 7/7] net: hibmcge: fix multiple phy_stop() issue
Date: Thu, 10 Apr 2025 10:13:27 +0800
Message-ID: <20250410021327.590362-8-shaojijie@huawei.com>
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

After detecting the np_link_fail exception,
the driver attempts to fix the exception by
using phy_stop() and phy_start() in the scheduled task.

However, hbg_fix_np_link_fail() and .ndo_stop()
may be concurrently executed. As a result,
phy_stop() is executed twice, and the following Calltrace occurs:

 hibmcge 0000:84:00.2 enp132s0f2: Link is Down
 hibmcge 0000:84:00.2: failed to link between MAC and PHY, try to fix...
 ------------[ cut here ]------------
 called from state HALTED
 WARNING: CPU: 71 PID: 23391 at drivers/net/phy/phy.c:1503 phy_stop...
 ...
 pc : phy_stop+0x138/0x180
 lr : phy_stop+0x138/0x180
 sp : ffff8000c76bbd40
 x29: ffff8000c76bbd40 x28: 0000000000000000 x27: 0000000000000000
 x26: ffff2020047358c0 x25: ffff202004735940 x24: ffff20200000e405
 x23: ffff2020060e5178 x22: ffff2020060e4000 x21: ffff2020060e49c0
 x20: ffff2020060e5170 x19: ffff20202538e000 x18: 0000000000000020
 x17: 0000000000000000 x16: ffffcede02e28f40 x15: ffffffffffffffff
 x14: 0000000000000000 x13: 205d313933333254 x12: 5b5d393430303233
 x11: ffffcede04555958 x10: ffffcede04495918 x9 : ffffcede0274fee0
 x8 : 00000000000bffe8 x7 : c0000000ffff7fff x6 : 0000000000000001
 x5 : 00000000002bffa8 x4 : 0000000000000000 x3 : 0000000000000000
 x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff20202e429480
 Call trace:
  phy_stop+0x138/0x180
  hbg_fix_np_link_fail+0x4c/0x90 [hibmcge]
  hbg_service_task+0xfc/0x148 [hibmcge]
  process_one_work+0x180/0x398
  worker_thread+0x210/0x328
  kthread+0xe0/0xf0
  ret_from_fork+0x10/0x20
 ---[ end trace 0000000000000000 ]---

This patch adds the rtnl_lock to hbg_fix_np_link_fail()
to ensure that other operations are not performed concurrently.
In addition, np_link_fail exception can be fixed
only when the PHY is link.

Fixes: e0306637e85d ("net: hibmcge: Add support for mac link exception handling feature")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
index f29a937ad087..42b0083c9193 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2024 Hisilicon Limited.
 
 #include <linux/phy.h>
+#include <linux/rtnetlink.h>
 #include "hbg_common.h"
 #include "hbg_hw.h"
 #include "hbg_mdio.h"
@@ -133,12 +134,17 @@ void hbg_fix_np_link_fail(struct hbg_priv *priv)
 {
 	struct device *dev = &priv->pdev->dev;
 
+	rtnl_lock();
+
 	if (priv->stats.np_link_fail_cnt >= HBG_NP_LINK_FAIL_RETRY_TIMES) {
 		dev_err(dev, "failed to fix the MAC link status\n");
 		priv->stats.np_link_fail_cnt = 0;
-		return;
+		goto unlock;
 	}
 
+	if (!priv->mac.phydev->link)
+		goto unlock;
+
 	priv->stats.np_link_fail_cnt++;
 	dev_err(dev, "failed to link between MAC and PHY, try to fix...\n");
 
@@ -147,6 +153,9 @@ void hbg_fix_np_link_fail(struct hbg_priv *priv)
 	 */
 	hbg_phy_stop(priv);
 	hbg_phy_start(priv);
+
+unlock:
+	rtnl_unlock();
 }
 
 static void hbg_phy_adjust_link(struct net_device *netdev)
-- 
2.33.0


