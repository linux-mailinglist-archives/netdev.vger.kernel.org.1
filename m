Return-Path: <netdev+bounces-14477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC81741E64
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 04:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04FF91C20859
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 02:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DC310E9;
	Thu, 29 Jun 2023 02:40:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C0A17EE
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 02:40:18 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4C72690;
	Wed, 28 Jun 2023 19:40:16 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qs2jT1rFVzqSTC;
	Thu, 29 Jun 2023 10:39:57 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 29 Jun
 2023 10:40:14 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>
CC: <saeedm@nvidia.com>, <leon@kernel.org>, <lkayal@nvidia.com>,
	<tariqt@nvidia.com>, <gal@nvidia.com>, <rrameshbabu@nvidia.com>,
	<vadfed@meta.com>, <ayal@nvidia.com>, <eranbe@nvidia.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH net 1/2] net/mlx5e: fix memory leak in mlx5e_fs_tt_redirect_any_create
Date: Thu, 29 Jun 2023 10:46:41 +0800
Message-ID: <20230629024642.2228767-2-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629024642.2228767-1-shaozhengchao@huawei.com>
References: <20230629024642.2228767-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The memory pointed to by the fs->any pointer is not freed in the error
path of mlx5e_fs_tt_redirect_any_create, which can lead to a memory leak.
Fix by freeing the memory in the error path, thereby making the error path
identical to mlx5e_fs_tt_redirect_any_destroy().

Fixes: 0f575c20bf06 ("net/mlx5e: Introduce Flow Steering ANY API")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
index 03cb79adf912..9cf4ec931b8b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
@@ -594,7 +594,7 @@ int mlx5e_fs_tt_redirect_any_create(struct mlx5e_flow_steering *fs)
 
 	err = fs_any_create_table(fs);
 	if (err)
-		return err;
+		goto err_free_any;
 
 	err = fs_any_enable(fs);
 	if (err)
@@ -606,7 +606,7 @@ int mlx5e_fs_tt_redirect_any_create(struct mlx5e_flow_steering *fs)
 
 err_destroy_table:
 	fs_any_destroy_table(fs_any);
-
+err_free_any:
 	kfree(fs_any);
 	mlx5e_fs_set_any(fs, NULL);
 	return err;
-- 
2.34.1


