Return-Path: <netdev+bounces-14690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 580ED74322B
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 03:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850AA1C20878
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 01:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EE415AE;
	Fri, 30 Jun 2023 01:20:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA7E15A6
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 01:20:25 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDD526B6
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 18:20:24 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qscqz5QfhzqVmG;
	Fri, 30 Jun 2023 09:17:35 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 30 Jun
 2023 09:20:21 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <idosch@nvidia.com>, <petrm@nvidia.com>, <jiri@resnulli.us>,
	<vadimp@nvidia.com>, <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<shaozhengchao@huawei.com>
Subject: [PATCH RESEND,net,v2] mlxsw: minimal: fix potential memory leak in mlxsw_m_linecards_init
Date: Fri, 30 Jun 2023 09:26:47 +0800
Message-ID: <20230630012647.1078002-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The line cards array is not freed in the error path of
mlxsw_m_linecards_init(), which can lead to a memory leak. Fix by
freeing the array in the error path, thereby making the error path
identical to mlxsw_m_linecards_fini().

Fixes: 01328e23a476 ("mlxsw: minimal: Extend module to port mapping with slot index")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
v2: modify commit message.
---
 drivers/net/ethernet/mellanox/mlxsw/minimal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/minimal.c b/drivers/net/ethernet/mellanox/mlxsw/minimal.c
index 6b56eadd736e..6b98c3287b49 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/minimal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/minimal.c
@@ -417,6 +417,7 @@ static int mlxsw_m_linecards_init(struct mlxsw_m *mlxsw_m)
 err_kmalloc_array:
 	for (i--; i >= 0; i--)
 		kfree(mlxsw_m->line_cards[i]);
+	kfree(mlxsw_m->line_cards);
 err_kcalloc:
 	kfree(mlxsw_m->ports);
 	return err;
-- 
2.34.1


