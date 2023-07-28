Return-Path: <netdev+bounces-22186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3A4766662
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 10:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7911C211DB
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 08:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BD7107AE;
	Fri, 28 Jul 2023 08:02:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ADD107A4
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 08:02:11 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE355593;
	Fri, 28 Jul 2023 01:01:52 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RC0Pj56DYztRZw;
	Fri, 28 Jul 2023 15:58:33 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 16:01:49 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>, <shaojijie@huawei.com>,
	<netdev@vger.kernel.org>, <stable@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 3/6] net: hns3: refactor hclge_mac_link_status_wait for interface reuse
Date: Fri, 28 Jul 2023 15:58:37 +0800
Message-ID: <20230728075840.4022760-4-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230728075840.4022760-1-shaojijie@huawei.com>
References: <20230728075840.4022760-1-shaojijie@huawei.com>
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
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jie Wang <wangjie125@huawei.com>

Some nic configurations could only be performed after link is down. So this
patch refactor this API for reuse.

Signed-off-by: Jie Wang <wangjie125@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 5594b8dd1e1d..b440e42e1d9c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -72,6 +72,8 @@ static void hclge_restore_hw_table(struct hclge_dev *hdev);
 static void hclge_sync_promisc_mode(struct hclge_dev *hdev);
 static void hclge_sync_fd_table(struct hclge_dev *hdev);
 static void hclge_update_fec_stats(struct hclge_dev *hdev);
+static int hclge_mac_link_status_wait(struct hclge_dev *hdev, int link_ret,
+				      int wait_cnt);
 
 static struct hnae3_ae_algo ae_algo;
 
@@ -7647,10 +7649,9 @@ static void hclge_phy_link_status_wait(struct hclge_dev *hdev,
 	} while (++i < HCLGE_PHY_LINK_STATUS_NUM);
 }
 
-static int hclge_mac_link_status_wait(struct hclge_dev *hdev, int link_ret)
+static int hclge_mac_link_status_wait(struct hclge_dev *hdev, int link_ret,
+				      int wait_cnt)
 {
-#define HCLGE_MAC_LINK_STATUS_NUM  100
-
 	int link_status;
 	int i = 0;
 	int ret;
@@ -7663,13 +7664,15 @@ static int hclge_mac_link_status_wait(struct hclge_dev *hdev, int link_ret)
 			return 0;
 
 		msleep(HCLGE_LINK_STATUS_MS);
-	} while (++i < HCLGE_MAC_LINK_STATUS_NUM);
+	} while (++i < wait_cnt);
 	return -EBUSY;
 }
 
 static int hclge_mac_phy_link_status_wait(struct hclge_dev *hdev, bool en,
 					  bool is_phy)
 {
+#define HCLGE_MAC_LINK_STATUS_NUM  100
+
 	int link_ret;
 
 	link_ret = en ? HCLGE_LINK_STATUS_UP : HCLGE_LINK_STATUS_DOWN;
@@ -7677,7 +7680,8 @@ static int hclge_mac_phy_link_status_wait(struct hclge_dev *hdev, bool en,
 	if (is_phy)
 		hclge_phy_link_status_wait(hdev, link_ret);
 
-	return hclge_mac_link_status_wait(hdev, link_ret);
+	return hclge_mac_link_status_wait(hdev, link_ret,
+					  HCLGE_MAC_LINK_STATUS_NUM);
 }
 
 static int hclge_set_app_loopback(struct hclge_dev *hdev, bool en)
-- 
2.30.0


