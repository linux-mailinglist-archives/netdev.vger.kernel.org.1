Return-Path: <netdev+bounces-155498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC24A02851
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 15:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9941885BB5
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 14:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EE71DEFD9;
	Mon,  6 Jan 2025 14:44:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DD71DE3C3;
	Mon,  6 Jan 2025 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174657; cv=none; b=lUyIVYgi18X3HD4ooi8Zkq2JFWbejsyBHat5vzXJj1RmqhRd9MQeZoho3gFqhOT/7QG75ho/+QGBilnCB/g/6KRPsl01aJRzvs4wnA2/8CnBmz6+2/WytTH9uIi51D7b2jyyazeaeTBn21/X1I/fla2yDj9AGQaN/P1vG1Mvczc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174657; c=relaxed/simple;
	bh=UzakiMkSHBdvVQj7Yt/97yT8eEhATr1TPXka4o6UvNo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZmnEWy1PU6XwyIxkqBxhGuNCn+nBEOOttDABRV75UiEhANf0z5i1iWBcZE1KXS059Qh6LJXZUnvzYbi9uLEP84sQNTO8+RxVepinHBV3zyb1x17DjV+rT0wcvZiw8UouHwHQrDIJ+5jPxREfOLpnLYiKtW+lSJtdlEYGznHMCRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4YRcLd2tmQz1V4Nx;
	Mon,  6 Jan 2025 22:41:13 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 104571A016C;
	Mon,  6 Jan 2025 22:44:13 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 6 Jan 2025 22:44:12 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.swiatkowski@linux.intel.com>,
	<shaojijie@huawei.com>
Subject: [PATCH V3 net 5/7] net: hns3: initialize reset_timer before hclgevf_misc_irq_init()
Date: Mon, 6 Jan 2025 22:36:40 +0800
Message-ID: <20250106143642.539698-6-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250106143642.539698-1-shaojijie@huawei.com>
References: <20250106143642.539698-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemk100013.china.huawei.com (7.202.194.61)

From: Jian Shen <shenjian15@huawei.com>

Currently the misc irq is initialized before reset_timer setup. But
it will access the reset_timer in the irq handler. So initialize
the reset_timer earlier.

Fixes: ff200099d271 ("net: hns3: remove unnecessary work in hclgevf_main")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
ChangeLog:
v2 RESEND -> v3:
  - Add one comment, suggested by Michal Swiatkowski.
  v2 RESEND: https://lore.kernel.org/all/20241217010839.1742227-1-shaojijie@huawei.com/
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index fd0abe37fdd7..163c6e59ea4c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -2313,6 +2313,8 @@ static void hclgevf_state_init(struct hclgevf_dev *hdev)
 	clear_bit(HCLGEVF_STATE_RST_FAIL, &hdev->state);
 
 	INIT_DELAYED_WORK(&hdev->service_task, hclgevf_service_task);
+	/* timer needs to be initialized before misc irq */
+	timer_setup(&hdev->reset_timer, hclgevf_reset_timer, 0);
 
 	mutex_init(&hdev->mbx_resp.mbx_mutex);
 	sema_init(&hdev->reset_sem, 1);
@@ -3012,7 +3014,6 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 		 HCLGEVF_DRIVER_NAME);
 
 	hclgevf_task_schedule(hdev, round_jiffies_relative(HZ));
-	timer_setup(&hdev->reset_timer, hclgevf_reset_timer, 0);
 
 	return 0;
 
-- 
2.33.0


