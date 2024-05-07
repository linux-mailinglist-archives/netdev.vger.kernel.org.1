Return-Path: <netdev+bounces-94126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D5F8BE4A3
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 15:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE15289E55
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 13:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C5115E1E6;
	Tue,  7 May 2024 13:49:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C166413CF9C;
	Tue,  7 May 2024 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089795; cv=none; b=Tyh+Oi9bW97O4WdtzzeOODqfU8MGWeIlz/E0xHwtV4BZZBCoXpEj4lOt+f++Xm4TifTXyQMNpLY9LD9PJcR8ray2hLC7eWN/3p9OTg9YvVu472lVsaIfQAYmdIiYrqQ+iJqSSRT5lw4/G0bPi9P5V2iajL+AtQbe/LDdjOlk3s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089795; c=relaxed/simple;
	bh=Q38qHfEOo4FrF79laZBUX0gryLfICrknwgxFjslCNew=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vms8C3XC9dXE6RkWJiXze7EzFXNOnPnPf7MiAxqYPK40Aos+8lomtKKALVcC+xJEsrjCTj9ZqGWa/NiBFITkwGCuQ7xaJ1/IWlPhd0Wx+7QlmQRH9WNIlPslroqmuvYKyBDfqYaiGqgz8oCvzLE38L6ASWSlhamKvtIM/be0tKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VYfh10CjmztT2C;
	Tue,  7 May 2024 21:46:25 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C926180065;
	Tue,  7 May 2024 21:49:50 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 21:49:49 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jiri@resnulli.us>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 net 1/7] net: hns3: using user configure after hardware reset
Date: Tue, 7 May 2024 21:42:18 +0800
Message-ID: <20240507134224.2646246-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240507134224.2646246-1-shaojijie@huawei.com>
References: <20240507134224.2646246-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)

From: Peiyang Wang <wangpeiyang1@huawei.com>

When a reset occurring, it's supposed to recover user's configuration.
Currently, the port info(speed, duplex and autoneg) is stored in hclge_mac
and will be scheduled updated. Consider the case that reset was happened
consecutively. During the first reset, the port info is configured with
a temporary value cause the PHY is reset and looking for best link config.
Second reset start and use pervious configuration which is not the user's.
The specific process is as follows:

+------+               +----+                +----+
| USER |               | PF |                | HW |
+---+--+               +-+--+                +-+--+
    |  ethtool --reset   |                     |
    +------------------->|    reset command    |
    |  ethtool --reset   +-------------------->|
    +------------------->|                     +---+
    |                    +---+                 |   |
    |                    |   |reset currently  |   | HW RESET
    |                    |   |and wait to do   |   |
    |                    |<--+                 |   |
    |                    | send pervious cfg   |<--+
    |                    | (1000M FULL AN_ON)  |
    |                    +-------------------->|
    |                    | read cfg(time task) |
    |                    | (10M HALF AN_OFF)   +---+
    |                    |<--------------------+   | cfg take effect
    |                    |    reset command    |<--+
    |                    +-------------------->|
    |                    |                     +---+
    |                    | send pervious cfg   |   | HW RESET
    |                    | (10M HALF AN_OFF)   |<--+
    |                    +-------------------->|
    |                    | read cfg(time task) |
    |                    |  (10M HALF AN_OFF)  +---+
    |                    |<--------------------+   | cfg take effect
    |                    |                     |   |
    |                    | read cfg(time task) |<--+
    |                    |  (10M HALF AN_OFF)  |
    |                    |<--------------------+
    |                    |                     |
    v                    v                     v

To avoid aboved situation, this patch introduced req_speed, req_duplex,
req_autoneg to store user's configuration and it only be used after
hardware reset and to recover user's configuration

Fixes: f5f2b3e4dcc0 ("net: hns3: add support for imp-controlled PHYs")
Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 15 +++++++++------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h   |  3 +++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index ff6a2ed23ddb..8043f1795dc7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1537,6 +1537,9 @@ static int hclge_configure(struct hclge_dev *hdev)
 			cfg.default_speed, ret);
 		return ret;
 	}
+	hdev->hw.mac.req_speed = hdev->hw.mac.speed;
+	hdev->hw.mac.req_autoneg = AUTONEG_ENABLE;
+	hdev->hw.mac.req_duplex = DUPLEX_FULL;
 
 	hclge_parse_link_mode(hdev, cfg.speed_ability);
 
@@ -3342,9 +3345,9 @@ hclge_set_phy_link_ksettings(struct hnae3_handle *handle,
 		return ret;
 	}
 
-	hdev->hw.mac.autoneg = cmd->base.autoneg;
-	hdev->hw.mac.speed = cmd->base.speed;
-	hdev->hw.mac.duplex = cmd->base.duplex;
+	hdev->hw.mac.req_autoneg = cmd->base.autoneg;
+	hdev->hw.mac.req_speed = cmd->base.speed;
+	hdev->hw.mac.req_duplex = cmd->base.duplex;
 	linkmode_copy(hdev->hw.mac.advertising, cmd->link_modes.advertising);
 
 	return 0;
@@ -3377,9 +3380,9 @@ static int hclge_tp_port_init(struct hclge_dev *hdev)
 	if (!hnae3_dev_phy_imp_supported(hdev))
 		return 0;
 
-	cmd.base.autoneg = hdev->hw.mac.autoneg;
-	cmd.base.speed = hdev->hw.mac.speed;
-	cmd.base.duplex = hdev->hw.mac.duplex;
+	cmd.base.autoneg = hdev->hw.mac.req_autoneg;
+	cmd.base.speed = hdev->hw.mac.req_speed;
+	cmd.base.duplex = hdev->hw.mac.req_duplex;
 	linkmode_copy(cmd.link_modes.advertising, hdev->hw.mac.advertising);
 
 	return hclge_set_phy_link_ksettings(&hdev->vport->nic, &cmd);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index e821dd2f1528..e3c69be8256f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -279,11 +279,14 @@ struct hclge_mac {
 	u8 media_type;	/* port media type, e.g. fibre/copper/backplane */
 	u8 mac_addr[ETH_ALEN];
 	u8 autoneg;
+	u8 req_autoneg;
 	u8 duplex;
+	u8 req_duplex;
 	u8 support_autoneg;
 	u8 speed_type;	/* 0: sfp speed, 1: active speed */
 	u8 lane_num;
 	u32 speed;
+	u32 req_speed;
 	u32 max_speed;
 	u32 speed_ability; /* speed ability supported by current media */
 	u32 module_type; /* sub media type, e.g. kr/cr/sr/lr */
-- 
2.30.0


