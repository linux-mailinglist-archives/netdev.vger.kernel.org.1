Return-Path: <netdev+bounces-32192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E7C793636
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 09:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9C2280E0E
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 07:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C810A3FC7;
	Wed,  6 Sep 2023 07:23:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76F7211A
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 07:23:59 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C81E50;
	Wed,  6 Sep 2023 00:23:57 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RgYhG5tGqzTlqX;
	Wed,  6 Sep 2023 15:21:18 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 6 Sep 2023 15:23:55 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net 5/7] net: hns3: fix invalid mutex between tc qdisc and dcb ets command issue
Date: Wed, 6 Sep 2023 15:20:16 +0800
Message-ID: <20230906072018.3020671-6-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230906072018.3020671-1-shaojijie@huawei.com>
References: <20230906072018.3020671-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We hope that tc qdisc and dcb ets commands can not be used crosswise.
If we want to use any of the commands to configure tc,
We must use the other command to clear the existing configuration.

However, when we configure a single tc with tc qdisc,
we can still configure it with dcb ets.
Because we use mqprio_active as the tag of tc qdisc configuration,
but with dcb ets, we do not check mqprio_active.

This patch fix this issue by check mqprio_active before
executing the dcb ets command. and add dcb_ets_active to
replace HCLGE_FLAG_DCB_ENABLE and HCLGE_FLAG_MQPRIO_ENABLE
at the hclge layer,

Fixes: cacde272dd00 ("net: hns3: Add hclge_dcb module for the support of DCB feature")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  1 +
 .../hisilicon/hns3/hns3pf/hclge_dcb.c         | 20 +++++--------------
 .../hisilicon/hns3/hns3pf/hclge_main.c        |  5 +++--
 .../hisilicon/hns3/hns3pf/hclge_main.h        |  2 --
 4 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index a4b43bcd2f0c..aaf1f42624a7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -814,6 +814,7 @@ struct hnae3_tc_info {
 	u8 max_tc; /* Total number of TCs */
 	u8 num_tc; /* Total number of enabled TCs */
 	bool mqprio_active;
+	bool dcb_ets_active;
 };
 
 #define HNAE3_MAX_DSCP			64
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index fad5a5ff3cda..b98301e205f7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -259,7 +259,7 @@ static int hclge_ieee_setets(struct hnae3_handle *h, struct ieee_ets *ets)
 	int ret;
 
 	if (!(hdev->dcbx_cap & DCB_CAP_DCBX_VER_IEEE) ||
-	    hdev->flag & HCLGE_FLAG_MQPRIO_ENABLE)
+	    h->kinfo.tc_info.mqprio_active)
 		return -EINVAL;
 
 	ret = hclge_ets_validate(hdev, ets, &num_tc, &map_changed);
@@ -275,10 +275,7 @@ static int hclge_ieee_setets(struct hnae3_handle *h, struct ieee_ets *ets)
 	}
 
 	hclge_tm_schd_info_update(hdev, num_tc);
-	if (num_tc > 1)
-		hdev->flag |= HCLGE_FLAG_DCB_ENABLE;
-	else
-		hdev->flag &= ~HCLGE_FLAG_DCB_ENABLE;
+	h->kinfo.tc_info.dcb_ets_active = num_tc > 1;
 
 	ret = hclge_ieee_ets_to_tm_info(hdev, ets);
 	if (ret)
@@ -487,7 +484,7 @@ static u8 hclge_getdcbx(struct hnae3_handle *h)
 	struct hclge_vport *vport = hclge_get_vport(h);
 	struct hclge_dev *hdev = vport->back;
 
-	if (hdev->flag & HCLGE_FLAG_MQPRIO_ENABLE)
+	if (h->kinfo.tc_info.mqprio_active)
 		return 0;
 
 	return hdev->dcbx_cap;
@@ -611,7 +608,8 @@ static int hclge_setup_tc(struct hnae3_handle *h,
 	if (!test_bit(HCLGE_STATE_NIC_REGISTERED, &hdev->state))
 		return -EBUSY;
 
-	if (hdev->flag & HCLGE_FLAG_DCB_ENABLE)
+	kinfo = &vport->nic.kinfo;
+	if (kinfo->tc_info.dcb_ets_active)
 		return -EINVAL;
 
 	ret = hclge_mqprio_qopt_check(hdev, mqprio_qopt);
@@ -625,7 +623,6 @@ static int hclge_setup_tc(struct hnae3_handle *h,
 	if (ret)
 		return ret;
 
-	kinfo = &vport->nic.kinfo;
 	memcpy(&old_tc_info, &kinfo->tc_info, sizeof(old_tc_info));
 	hclge_sync_mqprio_qopt(&kinfo->tc_info, mqprio_qopt);
 	kinfo->tc_info.mqprio_active = tc > 0;
@@ -634,13 +631,6 @@ static int hclge_setup_tc(struct hnae3_handle *h,
 	if (ret)
 		goto err_out;
 
-	hdev->flag &= ~HCLGE_FLAG_DCB_ENABLE;
-
-	if (tc > 1)
-		hdev->flag |= HCLGE_FLAG_MQPRIO_ENABLE;
-	else
-		hdev->flag &= ~HCLGE_FLAG_MQPRIO_ENABLE;
-
 	return hclge_notify_init_up(hdev);
 
 err_out:
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 0f50dba6cc47..8ca368424436 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -11026,6 +11026,7 @@ static void hclge_get_mdix_mode(struct hnae3_handle *handle,
 
 static void hclge_info_show(struct hclge_dev *hdev)
 {
+	struct hnae3_handle *handle = &hdev->vport->nic;
 	struct device *dev = &hdev->pdev->dev;
 
 	dev_info(dev, "PF info begin:\n");
@@ -11042,9 +11043,9 @@ static void hclge_info_show(struct hclge_dev *hdev)
 	dev_info(dev, "This is %s PF\n",
 		 hdev->flag & HCLGE_FLAG_MAIN ? "main" : "not main");
 	dev_info(dev, "DCB %s\n",
-		 hdev->flag & HCLGE_FLAG_DCB_ENABLE ? "enable" : "disable");
+		 handle->kinfo.tc_info.dcb_ets_active ? "enable" : "disable");
 	dev_info(dev, "MQPRIO %s\n",
-		 hdev->flag & HCLGE_FLAG_MQPRIO_ENABLE ? "enable" : "disable");
+		 handle->kinfo.tc_info.mqprio_active ? "enable" : "disable");
 	dev_info(dev, "Default tx spare buffer size: %u\n",
 		 hdev->tx_spare_buf_size);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index ec233ec57222..7bc2049b723d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -919,8 +919,6 @@ struct hclge_dev {
 
 #define HCLGE_FLAG_MAIN			BIT(0)
 #define HCLGE_FLAG_DCB_CAPABLE		BIT(1)
-#define HCLGE_FLAG_DCB_ENABLE		BIT(2)
-#define HCLGE_FLAG_MQPRIO_ENABLE	BIT(3)
 	u32 flag;
 
 	u32 pkt_buf_size; /* Total pf buf size for tx/rx */
-- 
2.30.0


