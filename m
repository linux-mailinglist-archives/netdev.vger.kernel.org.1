Return-Path: <netdev+bounces-118084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 014B9950761
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 16:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FD611F21639
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FB019DFB6;
	Tue, 13 Aug 2024 14:16:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EE519D076;
	Tue, 13 Aug 2024 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723558611; cv=none; b=De87T/K1qFtAwgUgMQnIgIfa6Hp8VUbucTNQ/E7hVc20b0nWrmkcM/tHjZNpPzpVh9zsUcJcUCNPDkkISWW4EEJW15vGND0pxvWi0tWWV33+lm3tz4EwD48tatgGZ2fjZ/DJw/prtRPRTiBfXdcgSjEYg+/LuncmZtC9FexidRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723558611; c=relaxed/simple;
	bh=Utbg0eF5hKqhO1iCAkzircgSwZy6GNkSCEOcEzmMt0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vj+wzozVcVcVt0gWpKYK/edkCwkH9+r/QS66XvvZ+1l68knZJ4WbimCBZA+hKaCEUQD0nWtBCg2Qd+WFC5KUaya0M5Yq4yo/Zf/Xk9dlpj3ErscaN9ZgWe2dyQFbA6PxrQi+ZgxqPhHJpK3gSt/X5KvQyWaD5eukcUTWu60w1nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WjtjC60zgz1T7CR;
	Tue, 13 Aug 2024 22:16:15 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 70EED140135;
	Tue, 13 Aug 2024 22:16:44 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 22:16:43 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>, <shaojijie@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net 2/5] net: hns3: use the user's cfg after reset
Date: Tue, 13 Aug 2024 22:10:21 +0800
Message-ID: <20240813141024.1707252-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240813141024.1707252-1-shaojijie@huawei.com>
References: <20240813141024.1707252-1-shaojijie@huawei.com>
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

From: Peiyang Wang <wangpeiyang1@huawei.com>

Consider the followed case that the user change speed and reset the net
interface. Before the hw change speed successfully, the driver get old
old speed from hw by timer task. After reset, the previous speed is config
to hw. As a result, the new speed is configed successfully but lost after
PF reset. The followed pictured shows more dirrectly.

+------+              +----+                 +----+                
| USER |              | PF |                 | HW |                
+---+--+              +-+--+                 +-+--+                
    |  ethtool -s 100G  |                      |                   
    +------------------>|   set speed 100G     |                   
    |                   +--------------------->|                   
    |                   |  set successfully    |                   
    |                   |<---------------------+---+               
    |                   |query cfg (timer task)|   |               
    |                   +--------------------->|   | handle speed  
    |                   |     return 200G      |   | changing event
    |  ethtool --reset  |<---------------------+   | (100G)        
    +------------------>|  cfg previous speed  |<--+               
    |                   |  after reset (200G)  |                   
    |                   +--------------------->|                   
    |                   |                      +---+               
    |                   |query cfg (timer task)|   |               
    |                   +--------------------->|   | handle speed  
    |                   |     return 100G      |   | changing event
    |                   |<---------------------+   | (200G)        
    |                   |                      |<--+               
    |                   |query cfg (timer task)|                   
    |                   +--------------------->|                   
    |                   |     return 200G      |                   
    |                   |<---------------------+                   
    |                   |                      |                   
    v                   v                      v                   

This patch save new speed if hw change speed successfully, which will be
used after reset successfully.

Fixes: 2d03eacc0b7e ("net: hns3: Only update mac configuation when necessary")
Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 24 ++++++++++++++-----
 .../hisilicon/hns3/hns3pf/hclge_mdio.c        |  3 +++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 125e04434611..465f0d582283 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -2653,8 +2653,17 @@ static int hclge_cfg_mac_speed_dup_h(struct hnae3_handle *handle, int speed,
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
+	int ret;
+
+	ret = hclge_cfg_mac_speed_dup(hdev, speed, duplex, lane_num);
 
-	return hclge_cfg_mac_speed_dup(hdev, speed, duplex, lane_num);
+	if (ret)
+		return ret;
+
+	hdev->hw.mac.req_speed = speed;
+	hdev->hw.mac.req_duplex = duplex;
+
+	return 0;
 }
 
 static int hclge_set_autoneg_en(struct hclge_dev *hdev, bool enable)
@@ -2956,17 +2965,20 @@ static int hclge_mac_init(struct hclge_dev *hdev)
 	if (!test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state))
 		hdev->hw.mac.duplex = HCLGE_MAC_FULL;
 
-	ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.speed,
-					 hdev->hw.mac.duplex, hdev->hw.mac.lane_num);
-	if (ret)
-		return ret;
-
 	if (hdev->hw.mac.support_autoneg) {
 		ret = hclge_set_autoneg_en(hdev, hdev->hw.mac.autoneg);
 		if (ret)
 			return ret;
 	}
 
+	if (!hdev->hw.mac.autoneg) {
+		ret = hclge_cfg_mac_speed_dup_hw(hdev, hdev->hw.mac.req_speed,
+						 hdev->hw.mac.req_duplex,
+						 hdev->hw.mac.lane_num);
+		if (ret)
+			return ret;
+	}
+
 	mac->link = 0;
 
 	if (mac->user_fec_mode & BIT(HNAE3_FEC_USER_DEF)) {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
index 85fb11de43a1..80079657afeb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c
@@ -191,6 +191,9 @@ static void hclge_mac_adjust_link(struct net_device *netdev)
 	if (ret)
 		netdev_err(netdev, "failed to adjust link.\n");
 
+	hdev->hw.mac.req_speed = (u32)speed;
+	hdev->hw.mac.req_duplex = (u8)duplex;
+
 	ret = hclge_cfg_flowctrl(hdev);
 	if (ret)
 		netdev_err(netdev, "failed to configure flow control.\n");
-- 
2.33.0


