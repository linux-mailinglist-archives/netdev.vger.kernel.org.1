Return-Path: <netdev+bounces-14696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDF2743255
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 03:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B178C280F1D
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 01:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F32B15AE;
	Fri, 30 Jun 2023 01:42:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D1C1FA8
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 01:42:43 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B890030E6;
	Thu, 29 Jun 2023 18:42:41 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QsdLS4PvyzLn07;
	Fri, 30 Jun 2023 09:40:32 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 30 Jun
 2023 09:42:38 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>
CC: <saeedm@nvidia.com>, <leon@kernel.org>, <lkayal@nvidia.com>,
	<tariqt@nvidia.com>, <gal@nvidia.com>, <rrameshbabu@nvidia.com>,
	<vadfed@meta.com>, <ayal@nvidia.com>, <eranbe@nvidia.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH net,v2 2/2] net/mlx5e: fix memory leak in mlx5e_ptp_open
Date: Fri, 30 Jun 2023 09:49:03 +0800
Message-ID: <20230630014903.1082615-3-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630014903.1082615-1-shaozhengchao@huawei.com>
References: <20230630014903.1082615-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When kvzalloc_node or kvzalloc failed in mlx5e_ptp_open, the memory
pointed by "c" or "cparams" is not freed, which can lead to a memory
leak. Fix by freeing the array in the error path.

Fixes: 145e5637d941 ("net/mlx5e: Add TX PTP port object support")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index 3cbebfba582b..b0b429a0321e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -729,8 +729,10 @@ int mlx5e_ptp_open(struct mlx5e_priv *priv, struct mlx5e_params *params,
 
 	c = kvzalloc_node(sizeof(*c), GFP_KERNEL, dev_to_node(mlx5_core_dma_dev(mdev)));
 	cparams = kvzalloc(sizeof(*cparams), GFP_KERNEL);
-	if (!c || !cparams)
-		return -ENOMEM;
+	if (!c || !cparams) {
+		err = -ENOMEM;
+		goto err_free;
+	}
 
 	c->priv     = priv;
 	c->mdev     = priv->mdev;
-- 
2.34.1


