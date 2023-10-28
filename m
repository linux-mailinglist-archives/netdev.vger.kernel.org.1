Return-Path: <netdev+bounces-44958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F637DA4F2
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 05:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8050282809
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 03:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1BF396;
	Sat, 28 Oct 2023 03:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB1A80C
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 03:02:41 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB07F4;
	Fri, 27 Oct 2023 20:02:39 -0700 (PDT)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SHPQP1r5szrTT6;
	Sat, 28 Oct 2023 10:59:41 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 28 Oct 2023 11:02:37 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 3/7] net: hns3: fix incorrect capability bit display for copper port
Date: Sat, 28 Oct 2023 10:59:13 +0800
Message-ID: <20231028025917.314305-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231028025917.314305-1-shaojijie@huawei.com>
References: <20231028025917.314305-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected

From: Jian Shen <shenjian15@huawei.com>

Currently, the FEC capability bit is default set for device version V2.
It's incorrect for the copper port. Eventhough it doesn't make the nic
work abnormal, but the capability information display in debugfs may
confuse user. So clear it when driver get the port type inforamtion.

Fixes: 433ccce83504 ("net: hns3: use FEC capability queried from firmware")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index a3230ac928a9..7d3f4d281704 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -11661,6 +11661,7 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 		goto err_msi_irq_uninit;
 
 	if (hdev->hw.mac.media_type == HNAE3_MEDIA_TYPE_COPPER) {
+		clear_bit(HNAE3_DEV_SUPPORT_FEC_B, ae_dev->caps);
 		if (hnae3_dev_phy_imp_supported(hdev))
 			ret = hclge_update_tp_port_info(hdev);
 		else
-- 
2.30.0


