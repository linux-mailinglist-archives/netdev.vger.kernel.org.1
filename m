Return-Path: <netdev+bounces-34034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE827A1B8B
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 11:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B3F281C6C
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 09:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2915DF58;
	Fri, 15 Sep 2023 09:59:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833C06FB1
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 09:59:26 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B04B1FE1;
	Fri, 15 Sep 2023 02:57:49 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Rn8hJ4cb3z1N8KZ;
	Fri, 15 Sep 2023 17:55:44 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 15 Sep 2023 17:57:43 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 4/5] net: hns3: fix fail to delete tc flower rules during reset issue
Date: Fri, 15 Sep 2023 17:53:04 +0800
Message-ID: <20230915095305.422328-5-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230915095305.422328-1-shaojijie@huawei.com>
References: <20230915095305.422328-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Firmware does not respond driver commands during reset
Therefore, rule will fail to delete while the firmware is resetting

So, if failed to delete rule, set rule state to TO_DEL,
and the rule will be deleted when periodic task being scheduled.

Fixes: 0205ec041ec6 ("net: hns3: add support for hw tc offload of tc flower")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index c0d03283775f..2bd77871f3bf 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -7348,6 +7348,12 @@ static int hclge_del_cls_flower(struct hnae3_handle *handle,
 	ret = hclge_fd_tcam_config(hdev, HCLGE_FD_STAGE_1, true, rule->location,
 				   NULL, false);
 	if (ret) {
+		/* if tcam config fail, set rule state to TO_DEL,
+		 * so the rule will be deleted when periodic
+		 * task being scheduled.
+		 */
+		hclge_update_fd_list(hdev, HCLGE_FD_TO_DEL, rule->location, NULL);
+		set_bit(HCLGE_STATE_FD_TBL_CHANGED, &hdev->state);
 		spin_unlock_bh(&hdev->fd_rule_lock);
 		return ret;
 	}
-- 
2.30.0


