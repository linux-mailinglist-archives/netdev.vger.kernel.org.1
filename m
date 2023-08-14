Return-Path: <netdev+bounces-27245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A367A77B247
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 09:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8281C20974
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 07:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E128467;
	Mon, 14 Aug 2023 07:24:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD996D24
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 07:24:10 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0E0E73;
	Mon, 14 Aug 2023 00:24:08 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RPQm01tnyzNnMy;
	Mon, 14 Aug 2023 15:20:32 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 14 Aug
 2023 15:24:02 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <vadim.fedorenko@linux.dev>
CC: <davem@davemloft.net>, <edumazet@google.com>, <elic@nvidia.com>,
	<kuba@kernel.org>, <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
	<lizetao1@huawei.com>, <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <roid@nvidia.com>, <saeedm@nvidia.com>,
	<shayd@nvidia.com>, <vladbu@nvidia.com>, kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH -next v2] net/mlx5: Devcom, only use devcom after NULL check in mlx5_devcom_send_event()
Date: Mon, 14 Aug 2023 15:23:42 +0800
Message-ID: <20230814072342.189470-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <face8e0a-b3f6-85d9-ce1d-8afecdafe2a8@linux.dev>
References: <face8e0a-b3f6-85d9-ce1d-8afecdafe2a8@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There is a warning reported by kernel test robot:

smatch warnings:
drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c:264
	mlx5_devcom_send_event() warn: variable dereferenced before
		IS_ERR check devcom (see line 259)

The reason for the warning is that the pointer is used before check, put
the assignment to comp after devcom check to silence the warning.

Fixes: 88d162b47981 ("net/mlx5: Devcom, Infrastructure changes")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202308041028.AkXYDwJ6-lkp@intel.com/
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
v1 -> v2: Modify the order of variable declarations to end up with reverse x-mas tree order.
v1: https://lore.kernel.org/all/20230804092636.91357-1-lizetao1@huawei.com/

 drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
index feb62d952643..00e67910e3ee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
@@ -256,14 +256,15 @@ int mlx5_devcom_send_event(struct mlx5_devcom_comp_dev *devcom,
 			   int event, int rollback_event,
 			   void *event_data)
 {
-	struct mlx5_devcom_comp *comp = devcom->comp;
 	struct mlx5_devcom_comp_dev *pos;
+	struct mlx5_devcom_comp *comp;
 	int err = 0;
 	void *data;
 
 	if (IS_ERR_OR_NULL(devcom))
 		return -ENODEV;
 
+	comp = devcom->comp;
 	down_write(&comp->sem);
 	list_for_each_entry(pos, &comp->comp_dev_list_head, list) {
 		data = rcu_dereference_protected(pos->data, lockdep_is_held(&comp->sem));
-- 
2.34.1


