Return-Path: <netdev+bounces-19313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E46075A43F
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 04:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07B1281BF8
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 02:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA8E7E0;
	Thu, 20 Jul 2023 02:08:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE8A64C
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 02:08:11 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FCB2106
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 19:08:09 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R5wxR6kVvztR3d;
	Thu, 20 Jul 2023 10:04:59 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 10:08:06 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <netdev@vger.kernel.org>
CC: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <lanhao@huawei.com>, <shaojijie@huawei.com>,
	<chenhao418@huawei.com>, <wangjie125@huawei.com>, <shenjian15@huawei.com>
Subject: [PATCH net 1/4] net: hns3: fix the imp capability bit cannot exceed 32 bits issue
Date: Thu, 20 Jul 2023 10:05:07 +0800
Message-ID: <20230720020510.2223815-2-shaojijie@huawei.com>
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

Current only the first 32 bits of the capability flag bit are considered.
When the matching capability flag bit is greater than 31 bits,
it will get an error bit.This patch use bitmap to solve this issue.
It can handle each capability bit whitout bit width limit.

Fixes: da77aef9cc58 ("net: hns3: create common cmdq resource allocate/free/query APIs")
Signed-off-by: Hao Lan <lanhao@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  3 ++-
 .../hns3/hns3_common/hclge_comm_cmd.c         | 21 ++++++++++++++++---
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index b99d75260d59..7de167329b1e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -31,6 +31,7 @@
 #include <linux/pci.h>
 #include <linux/pkt_sched.h>
 #include <linux/types.h>
+#include <linux/bitmap.h>
 #include <net/pkt_cls.h>
 #include <net/pkt_sched.h>
 
@@ -407,7 +408,7 @@ struct hnae3_ae_dev {
 	unsigned long hw_err_reset_req;
 	struct hnae3_dev_specs dev_specs;
 	u32 dev_version;
-	unsigned long caps[BITS_TO_LONGS(HNAE3_DEV_CAPS_MAX_NUM)];
+	DECLARE_BITMAP(caps, HNAE3_DEV_CAPS_MAX_NUM);
 	void *priv;
 };
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
index b85c412683dd..16ba98ff2c9b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
@@ -171,6 +171,20 @@ static const struct hclge_comm_caps_bit_map hclge_vf_cmd_caps[] = {
 	{HCLGE_COMM_CAP_GRO_B, HNAE3_DEV_SUPPORT_GRO_B},
 };
 
+static void
+hclge_comm_capability_to_bitmap(unsigned long *bitmap, __le32 *caps)
+{
+	const unsigned int words = HCLGE_COMM_QUERY_CAP_LENGTH;
+	u32 val[HCLGE_COMM_QUERY_CAP_LENGTH];
+	unsigned int i;
+
+	for (i = 0; i < words; i++)
+		val[i] = __le32_to_cpu(caps[i]);
+
+	bitmap_from_arr32(bitmap, val,
+			  HCLGE_COMM_QUERY_CAP_LENGTH * BITS_PER_TYPE(u32));
+}
+
 static void
 hclge_comm_parse_capability(struct hnae3_ae_dev *ae_dev, bool is_pf,
 			    struct hclge_comm_query_version_cmd *cmd)
@@ -179,11 +193,12 @@ hclge_comm_parse_capability(struct hnae3_ae_dev *ae_dev, bool is_pf,
 				is_pf ? hclge_pf_cmd_caps : hclge_vf_cmd_caps;
 	u32 size = is_pf ? ARRAY_SIZE(hclge_pf_cmd_caps) :
 				ARRAY_SIZE(hclge_vf_cmd_caps);
-	u32 caps, i;
+	DECLARE_BITMAP(caps, HCLGE_COMM_QUERY_CAP_LENGTH * BITS_PER_TYPE(u32));
+	u32 i;
 
-	caps = __le32_to_cpu(cmd->caps[0]);
+	hclge_comm_capability_to_bitmap(caps, cmd->caps);
 	for (i = 0; i < size; i++)
-		if (hnae3_get_bit(caps, caps_map[i].imp_bit))
+		if (test_bit(caps_map[i].imp_bit, caps))
 			set_bit(caps_map[i].local_bit, ae_dev->caps);
 }
 
-- 
2.30.0


