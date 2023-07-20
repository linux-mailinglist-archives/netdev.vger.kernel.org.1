Return-Path: <netdev+bounces-19316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DB875A443
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 04:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47F91C21211
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 02:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C56864C;
	Thu, 20 Jul 2023 02:08:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8976817E9
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 02:08:12 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507E81FFE
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 19:08:10 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R5x0C36h3z18Lbg;
	Thu, 20 Jul 2023 10:07:23 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 10:08:07 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <netdev@vger.kernel.org>
CC: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <lanhao@huawei.com>, <shaojijie@huawei.com>,
	<chenhao418@huawei.com>, <wangjie125@huawei.com>, <shenjian15@huawei.com>
Subject: [PATCH net 2/4] net: hns3: add tm flush when setting tm
Date: Thu, 20 Jul 2023 10:05:08 +0800
Message-ID: <20230720020510.2223815-3-shaojijie@huawei.com>
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

From: Hao Lan <lanhao@huawei.com>

When the tm module is configured with traffic, traffic
may be abnormal. This patch fixes this problem.
Before the tm module is configured, traffic processing
should be stopped. After the tm module is configured,
traffic processing is enabled.

Signed-off-by: Hao Lan <lanhao@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  4 +++
 .../hns3/hns3_common/hclge_comm_cmd.c         |  1 +
 .../hns3/hns3_common/hclge_comm_cmd.h         |  2 ++
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    |  3 ++
 .../hisilicon/hns3/hns3pf/hclge_dcb.c         | 34 ++++++++++++++++---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_tm.c | 31 ++++++++++++++++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_tm.h |  4 +++
 7 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 7de167329b1e..514a20bce4f4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -102,6 +102,7 @@ enum HNAE3_DEV_CAP_BITS {
 	HNAE3_DEV_SUPPORT_FEC_STATS_B,
 	HNAE3_DEV_SUPPORT_LANE_NUM_B,
 	HNAE3_DEV_SUPPORT_WOL_B,
+	HNAE3_DEV_SUPPORT_TM_FLUSH_B,
 };
 
 #define hnae3_ae_dev_fd_supported(ae_dev) \
@@ -173,6 +174,9 @@ enum HNAE3_DEV_CAP_BITS {
 #define hnae3_ae_dev_wol_supported(ae_dev) \
 	test_bit(HNAE3_DEV_SUPPORT_WOL_B, (ae_dev)->caps)
 
+#define hnae3_ae_dev_tm_flush_supported(hdev) \
+	test_bit(HNAE3_DEV_SUPPORT_TM_FLUSH_B, (hdev)->ae_dev->caps)
+
 enum HNAE3_PF_CAP_BITS {
 	HNAE3_PF_SUPPORT_VLAN_FLTR_MDF_B = 0,
 };
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
index 16ba98ff2c9b..dcecb23daac6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
@@ -156,6 +156,7 @@ static const struct hclge_comm_caps_bit_map hclge_pf_cmd_caps[] = {
 	{HCLGE_COMM_CAP_FEC_STATS_B, HNAE3_DEV_SUPPORT_FEC_STATS_B},
 	{HCLGE_COMM_CAP_LANE_NUM_B, HNAE3_DEV_SUPPORT_LANE_NUM_B},
 	{HCLGE_COMM_CAP_WOL_B, HNAE3_DEV_SUPPORT_WOL_B},
+	{HCLGE_COMM_CAP_TM_FLUSH_B, HNAE3_DEV_SUPPORT_TM_FLUSH_B},
 };
 
 static const struct hclge_comm_caps_bit_map hclge_vf_cmd_caps[] = {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h
index 18f1b4bf362d..2b7197ce0ae8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h
@@ -153,6 +153,7 @@ enum hclge_opcode_type {
 	HCLGE_OPC_TM_INTERNAL_STS	= 0x0850,
 	HCLGE_OPC_TM_INTERNAL_CNT	= 0x0851,
 	HCLGE_OPC_TM_INTERNAL_STS_1	= 0x0852,
+	HCLGE_OPC_TM_FLUSH		= 0x0872,
 
 	/* Packet buffer allocate commands */
 	HCLGE_OPC_TX_BUFF_ALLOC		= 0x0901,
@@ -349,6 +350,7 @@ enum HCLGE_COMM_CAP_BITS {
 	HCLGE_COMM_CAP_FEC_STATS_B = 25,
 	HCLGE_COMM_CAP_LANE_NUM_B = 27,
 	HCLGE_COMM_CAP_WOL_B = 28,
+	HCLGE_COMM_CAP_TM_FLUSH_B = 31,
 };
 
 enum HCLGE_COMM_API_CAP_BITS {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 6546cfe7f7cc..52546f625c8b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -411,6 +411,9 @@ static struct hns3_dbg_cap_info hns3_dbg_cap[] = {
 	}, {
 		.name = "support wake on lan",
 		.cap_bit = HNAE3_DEV_SUPPORT_WOL_B,
+	}, {
+		.name = "support tm flush",
+		.cap_bit = HNAE3_DEV_SUPPORT_TM_FLUSH_B,
 	}
 };
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index c4aded65e848..cda7e0d0ba56 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -216,6 +216,10 @@ static int hclge_notify_down_uinit(struct hclge_dev *hdev)
 	if (ret)
 		return ret;
 
+	ret = hclge_tm_flush_cfg(hdev, true);
+	if (ret)
+		return ret;
+
 	return hclge_notify_client(hdev, HNAE3_UNINIT_CLIENT);
 }
 
@@ -227,6 +231,10 @@ static int hclge_notify_init_up(struct hclge_dev *hdev)
 	if (ret)
 		return ret;
 
+	ret = hclge_tm_flush_cfg(hdev, false);
+	if (ret)
+		return ret;
+
 	return hclge_notify_client(hdev, HNAE3_UP_CLIENT);
 }
 
@@ -313,6 +321,7 @@ static int hclge_ieee_setpfc(struct hnae3_handle *h, struct ieee_pfc *pfc)
 	struct net_device *netdev = h->kinfo.netdev;
 	struct hclge_dev *hdev = vport->back;
 	u8 i, j, pfc_map, *prio_tc;
+	int last_bad_ret = 0;
 	int ret;
 
 	if (!(hdev->dcbx_cap & DCB_CAP_DCBX_VER_IEEE))
@@ -350,13 +359,28 @@ static int hclge_ieee_setpfc(struct hnae3_handle *h, struct ieee_pfc *pfc)
 	if (ret)
 		return ret;
 
-	ret = hclge_buffer_alloc(hdev);
-	if (ret) {
-		hclge_notify_client(hdev, HNAE3_UP_CLIENT);
+	ret = hclge_tm_flush_cfg(hdev, true);
+	if (ret)
 		return ret;
-	}
 
-	return hclge_notify_client(hdev, HNAE3_UP_CLIENT);
+	/* No matter whether the following operations are performed
+	 * successfully or not, disabling the tm flush and notify
+	 * the network status to up are necessary.
+	 * Do not return immediately.
+	 */
+	ret = hclge_buffer_alloc(hdev);
+	if (ret)
+		last_bad_ret = ret;
+
+	ret = hclge_tm_flush_cfg(hdev, false);
+	if (ret)
+		last_bad_ret = ret;
+
+	ret = hclge_notify_client(hdev, HNAE3_UP_CLIENT);
+	if (ret)
+		last_bad_ret = ret;
+
+	return last_bad_ret;
 }
 
 static int hclge_ieee_setapp(struct hnae3_handle *h, struct dcb_app *app)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index 922c0da3660c..c40ea6b8c8ec 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -1484,7 +1484,11 @@ int hclge_tm_schd_setup_hw(struct hclge_dev *hdev)
 		return ret;
 
 	/* Cfg schd mode for each level schd */
-	return hclge_tm_schd_mode_hw(hdev);
+	ret = hclge_tm_schd_mode_hw(hdev);
+	if (ret)
+		return ret;
+
+	return hclge_tm_flush_cfg(hdev, false);
 }
 
 static int hclge_pause_param_setup_hw(struct hclge_dev *hdev)
@@ -2113,3 +2117,28 @@ int hclge_tm_get_port_shaper(struct hclge_dev *hdev,
 
 	return 0;
 }
+
+int hclge_tm_flush_cfg(struct hclge_dev *hdev, bool enable)
+{
+	struct hclge_desc desc;
+	int ret;
+
+	if (!hnae3_ae_dev_tm_flush_supported(hdev))
+		return 0;
+
+	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_TM_FLUSH, false);
+
+	desc.data[0] = cpu_to_le32(enable ? HCLGE_TM_FLUSH_EN_MSK : 0);
+
+	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+	if (ret) {
+		dev_err(&hdev->pdev->dev,
+			"failed to config tm flush, ret = %d\n", ret);
+		return ret;
+	}
+
+	if (enable)
+		msleep(HCLGE_TM_FLUSH_TIME_MS);
+
+	return ret;
+}
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
index dd6f1fd486cf..45dcfef3f90c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
@@ -33,6 +33,9 @@ enum hclge_opcode_type;
 #define HCLGE_DSCP_MAP_TC_BD_NUM	2
 #define HCLGE_DSCP_TC_SHIFT(n)		(((n) & 1) * 4)
 
+#define HCLGE_TM_FLUSH_TIME_MS	10
+#define HCLGE_TM_FLUSH_EN_MSK	BIT(0)
+
 struct hclge_pg_to_pri_link_cmd {
 	u8 pg_id;
 	u8 rsvd1[3];
@@ -272,4 +275,5 @@ int hclge_tm_get_port_shaper(struct hclge_dev *hdev,
 			     struct hclge_tm_shaper_para *para);
 int hclge_up_to_tc_map(struct hclge_dev *hdev);
 int hclge_dscp_to_tc_map(struct hclge_dev *hdev);
+int hclge_tm_flush_cfg(struct hclge_dev *hdev, bool enable);
 #endif
-- 
2.30.0


