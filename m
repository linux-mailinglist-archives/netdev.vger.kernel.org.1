Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735E0740DFF
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 12:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjF1KDu (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 06:03:50 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:16305 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbjF1Jyt (ORCPT
        <rfc822;netdev@vger.kernel.org>); Wed, 28 Jun 2023 05:54:49 -0400
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QrcMF10RpzLmCw;
        Wed, 28 Jun 2023 17:52:41 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 28 Jun
 2023 17:54:45 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <netdev@vger.kernel.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <idosch@nvidia.com>, <petrm@nvidia.com>, <jiri@resnulli.us>,
        <vadimp@nvidia.com>, <yuehaibing@huawei.com>,
        <shaozhengchao@huawei.com>
Subject: [PATCH net,v2] mlxsw: minimal: fix potential memory leak in mlxsw_m_linecards_init
Date:   Wed, 28 Jun 2023 18:01:16 +0800
Message-ID: <20230628100116.2199367-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org

The line cards array is not freed in the error path of
mlxsw_m_linecards_init(), which can lead to a memory leak. Fix by
freeing the array in the error path, thereby making the error path
identical to mlxsw_m_linecards_fini().

Fixes: 01328e23a476 ("mlxsw: minimal: Extend module to port mapping with slot index")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
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

