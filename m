Return-Path: <netdev+bounces-94133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 332198BE4B2
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 15:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E280028B6FC
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 13:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D212C15FA82;
	Tue,  7 May 2024 13:50:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B691815E1E2;
	Tue,  7 May 2024 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715089801; cv=none; b=rhkNswYv//zxfuPkb40L+DvynUVlZieOtZmZ1MosXY8/vCrY6o4EE7vPXSbg+8xE4CfhyW6lY7tZ6cJ36zrwmyvQDMBEtawrPkcHUHNnr5nhTJXHlMrF+/YwxF+a1xWyP4rtFNOSRJaLaIZxftzdAq5h325XlmRvdwDwARuyMjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715089801; c=relaxed/simple;
	bh=DuwCtrSlUNDnmtWfQfx1BvJwkNFl/gBu/OaoVqRMsrQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N2/RcgqBzIHKzA/JmwsekK5uaM0SIvJM0RjmUuHbRdMq+0EkMp/ix+TJWKJQa2YaMYpuwQ0ObF1LQpACFLIPXd0WKvBsbDQj86cai+p0kyr4U3x6VAQO8JOho0+8FvTlXTxfbyxm4KiqcF2fFfvJ137vCchAuOjiL1XAFJle01g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VYfh937C4z1RCRl;
	Tue,  7 May 2024 21:46:33 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 15CC714022D;
	Tue,  7 May 2024 21:49:52 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 21:49:51 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jiri@resnulli.us>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 net 5/7] net: hns3: use appropriate barrier function after setting a bit value
Date: Tue, 7 May 2024 21:42:22 +0800
Message-ID: <20240507134224.2646246-6-shaojijie@huawei.com>
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

There is a memory barrier in followed case. When set the port down,
hclgevf_set_timmer will set DOWN in state. Meanwhile, the service task has
different behaviour based on whether the state is DOWN. Thus, to make sure
service task see DOWN, use smp_mb__after_atomic after calling set_bit().

          CPU0                        CPU1
========================== ===================================
hclgevf_set_timer_task()    hclgevf_periodic_service_task()
  set_bit(DOWN,state)         test_bit(DOWN,state)

pf also has this issue.

Fixes: ff200099d271 ("net: hns3: remove unnecessary work in hclgevf_main")
Fixes: 1c6dfe6fc6f7 ("net: hns3: remove mailbox and reset work in hclge_main")
Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 3 +--
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 1d255b3ae988..e3d6a64b4575 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -7957,8 +7957,7 @@ static void hclge_set_timer_task(struct hnae3_handle *handle, bool enable)
 		/* Set the DOWN flag here to disable link updating */
 		set_bit(HCLGE_STATE_DOWN, &hdev->state);
 
-		/* flush memory to make sure DOWN is seen by service task */
-		smp_mb__before_atomic();
+		smp_mb__after_atomic(); /* flush memory to make sure DOWN is seen by service task */
 		hclge_flush_link_update(hdev);
 	}
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index b57111252d07..08db8e84be4e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -2181,8 +2181,7 @@ static void hclgevf_set_timer_task(struct hnae3_handle *handle, bool enable)
 	} else {
 		set_bit(HCLGEVF_STATE_DOWN, &hdev->state);
 
-		/* flush memory to make sure DOWN is seen by service task */
-		smp_mb__before_atomic();
+		smp_mb__after_atomic(); /* flush memory to make sure DOWN is seen by service task */
 		hclgevf_flush_link_update(hdev);
 	}
 }
-- 
2.30.0


