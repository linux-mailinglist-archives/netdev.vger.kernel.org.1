Return-Path: <netdev+bounces-47055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7277E7B08
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 10:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7EC281841
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 09:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C18613AFB;
	Fri, 10 Nov 2023 09:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14070134A4
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 09:42:42 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A8024C3F;
	Fri, 10 Nov 2023 01:42:41 -0800 (PST)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.55])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SRYgd3JNBz1P8Bl;
	Fri, 10 Nov 2023 17:39:25 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 10 Nov 2023 17:42:37 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 net 6/7] net: hns3: fix VF reset fail issue
Date: Fri, 10 Nov 2023 17:37:12 +0800
Message-ID: <20231110093713.1895949-7-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231110093713.1895949-1-shaojijie@huawei.com>
References: <20231110093713.1895949-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected

Currently the reset process in hns3 and firmware watchdog init process is
asynchronous. We think firmware watchdog initialization is completed
before VF clear the interrupt source. However, firmware initialization
may not complete early. So VF will receive multiple reset interrupts
and fail to reset.

So we add delay before VF interrupt source and 5 ms delay
is enough to avoid second reset interrupt.

Fixes: 427900d27d86 ("net: hns3: fix the timing issue of VF clearing interrupt sources")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
ChangeLog:
v1 -> v2:
  - Use timer_list to replace the 5 ms delay in irq handle suggested by Paolo
  v1: https://lore.kernel.org/all/20231028025917.314305-7-shaojijie@huawei.com/
---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  | 14 +++++++++++++-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 1c62e58ff6d8..0aa9beefd1c7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1981,8 +1981,18 @@ static enum hclgevf_evt_cause hclgevf_check_evt_cause(struct hclgevf_dev *hdev,
 	return HCLGEVF_VECTOR0_EVENT_OTHER;
 }
 
+static void hclgevf_reset_timer(struct timer_list *t)
+{
+	struct hclgevf_dev *hdev = from_timer(hdev, t, reset_timer);
+
+	hclgevf_clear_event_cause(hdev, HCLGEVF_VECTOR0_EVENT_RST);
+	hclgevf_reset_task_schedule(hdev);
+}
+
 static irqreturn_t hclgevf_misc_irq_handle(int irq, void *data)
 {
+#define HCLGEVF_RESET_DELAY	5
+
 	enum hclgevf_evt_cause event_cause;
 	struct hclgevf_dev *hdev = data;
 	u32 clearval;
@@ -1994,7 +2004,8 @@ static irqreturn_t hclgevf_misc_irq_handle(int irq, void *data)
 
 	switch (event_cause) {
 	case HCLGEVF_VECTOR0_EVENT_RST:
-		hclgevf_reset_task_schedule(hdev);
+		mod_timer(&hdev->reset_timer,
+			  jiffies + msecs_to_jiffies(HCLGEVF_RESET_DELAY));
 		break;
 	case HCLGEVF_VECTOR0_EVENT_MBX:
 		hclgevf_mbx_handler(hdev);
@@ -2937,6 +2948,7 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 		 HCLGEVF_DRIVER_NAME);
 
 	hclgevf_task_schedule(hdev, round_jiffies_relative(HZ));
+	timer_setup(&hdev->reset_timer, hclgevf_reset_timer, 0);
 
 	return 0;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index 81c16b8c8da2..a73f2bf3a56a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -219,6 +219,7 @@ struct hclgevf_dev {
 	enum hnae3_reset_type reset_level;
 	unsigned long reset_pending;
 	enum hnae3_reset_type reset_type;
+	struct timer_list reset_timer;
 
 #define HCLGEVF_RESET_REQUESTED		0
 #define HCLGEVF_RESET_PENDING		1
-- 
2.30.0


