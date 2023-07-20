Return-Path: <netdev+bounces-19317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD7275A444
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 04:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC12281C2C
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 02:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28511115;
	Thu, 20 Jul 2023 02:08:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61F11C04
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 02:08:12 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB7C2109
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 19:08:11 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R5x0C6NS1zrRr7;
	Thu, 20 Jul 2023 10:07:23 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 10:08:08 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <netdev@vger.kernel.org>
CC: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <lanhao@huawei.com>, <shaojijie@huawei.com>,
	<chenhao418@huawei.com>, <wangjie125@huawei.com>, <shenjian15@huawei.com>
Subject: [PATCH net 4/4] net: hns3: fix wrong bw weight of disabled tc issue
Date: Thu, 20 Jul 2023 10:05:10 +0800
Message-ID: <20230720020510.2223815-5-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230720020510.2223815-1-shaojijie@huawei.com>
References: <20230720020510.2223815-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In dwrr mode, the default bandwidth weight of disabled tc is set to 0.
If the bandwidth weight is 0, the mode will change to sp.
Therefore, disabled tc default bandwidth weight need changed to 1,
and 0 is returned when query the bandwidth weight of disabled tc.
In addition, driver need stop configure bandwidth weight if tc is disabled.

Fixes: 848440544b41 ("net: hns3: Add support of TX Scheduler & Shaper to HNS3 driver")
Signed-off-by: Jie Wang <wangjie125@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c  | 17 ++++++++++++++---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_tm.c   |  3 ++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index cda7e0d0ba56..fad5a5ff3cda 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -52,7 +52,10 @@ static void hclge_tm_info_to_ieee_ets(struct hclge_dev *hdev,
 
 	for (i = 0; i < HNAE3_MAX_TC; i++) {
 		ets->prio_tc[i] = hdev->tm_info.prio_tc[i];
-		ets->tc_tx_bw[i] = hdev->tm_info.pg_info[0].tc_dwrr[i];
+		if (i < hdev->tm_info.num_tc)
+			ets->tc_tx_bw[i] = hdev->tm_info.pg_info[0].tc_dwrr[i];
+		else
+			ets->tc_tx_bw[i] = 0;
 
 		if (hdev->tm_info.tc_info[i].tc_sch_mode ==
 		    HCLGE_SCH_MODE_SP)
@@ -123,7 +126,8 @@ static u8 hclge_ets_tc_changed(struct hclge_dev *hdev, struct ieee_ets *ets,
 }
 
 static int hclge_ets_sch_mode_validate(struct hclge_dev *hdev,
-				       struct ieee_ets *ets, bool *changed)
+				       struct ieee_ets *ets, bool *changed,
+				       u8 tc_num)
 {
 	bool has_ets_tc = false;
 	u32 total_ets_bw = 0;
@@ -137,6 +141,13 @@ static int hclge_ets_sch_mode_validate(struct hclge_dev *hdev,
 				*changed = true;
 			break;
 		case IEEE_8021QAZ_TSA_ETS:
+			if (i >= tc_num) {
+				dev_err(&hdev->pdev->dev,
+					"tc%u is disabled, cannot set ets bw\n",
+					i);
+				return -EINVAL;
+			}
+
 			/* The hardware will switch to sp mode if bandwidth is
 			 * 0, so limit ets bandwidth must be greater than 0.
 			 */
@@ -176,7 +187,7 @@ static int hclge_ets_validate(struct hclge_dev *hdev, struct ieee_ets *ets,
 	if (ret)
 		return ret;
 
-	ret = hclge_ets_sch_mode_validate(hdev, ets, changed);
+	ret = hclge_ets_sch_mode_validate(hdev, ets, changed, tc_num);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index c40ea6b8c8ec..de509e5751a7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -785,6 +785,7 @@ static void hclge_tm_tc_info_init(struct hclge_dev *hdev)
 static void hclge_tm_pg_info_init(struct hclge_dev *hdev)
 {
 #define BW_PERCENT	100
+#define DEFAULT_BW_WEIGHT	1
 
 	u8 i;
 
@@ -806,7 +807,7 @@ static void hclge_tm_pg_info_init(struct hclge_dev *hdev)
 		for (k = 0; k < hdev->tm_info.num_tc; k++)
 			hdev->tm_info.pg_info[i].tc_dwrr[k] = BW_PERCENT;
 		for (; k < HNAE3_MAX_TC; k++)
-			hdev->tm_info.pg_info[i].tc_dwrr[k] = 0;
+			hdev->tm_info.pg_info[i].tc_dwrr[k] = DEFAULT_BW_WEIGHT;
 	}
 }
 
-- 
2.30.0


