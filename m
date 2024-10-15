Return-Path: <netdev+bounces-135435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 614EA99DE97
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 08:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 062A9B20D16
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 06:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F702189F30;
	Tue, 15 Oct 2024 06:41:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7A417335E
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 06:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728974485; cv=none; b=I8BGb3vjr1L+Ubdm8ipYrWfB81bmjEsQlcHvBeIHtdlsHjcfEmTy7td40bcMbahlSWYjKAml0MlU6ItL3qGB0hb9obLBfvACFIE22gUfjwQjjsFVkgbrgkz99+dnSx82rCel/VR+7F1xYoFXHzWyuh4nh775aZiiu2hzcusCZTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728974485; c=relaxed/simple;
	bh=7ycVUB7CY/QbQnkUWvjkEwqbHxZA8VlqHdbIzhP28gg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UPWcU/GC7akhJEBsd8nuI3xdmAWBqr4qlevyQNfKdSWrbqzZIqjtxiaAVlIkKya9D8pDWbKkU2ISbd2fpSVn3R1nNRpM0cXBxk1vrmOk094QdZh5j3KUZsxgbeVwOFbLWjIQVKUHVOg6NRhaHv5LM+p8CXTNtlYsoiSqC38ziL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XSPZP38pBzfdHG;
	Tue, 15 Oct 2024 14:38:53 +0800 (CST)
Received: from dggpeml500024.china.huawei.com (unknown [7.185.36.10])
	by mail.maildlp.com (Postfix) with ESMTPS id EB221180106;
	Tue, 15 Oct 2024 14:41:19 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Oct
 2024 14:41:19 +0800
From: Yuan Can <yuancan@huawei.com>
To: <idosch@nvidia.com>, <petrm@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
CC: <yuancan@huawei.com>
Subject: [PATCH net-next] mlxsw: spectrum_router: fix xa_store() error checking
Date: Tue, 15 Oct 2024 14:36:51 +0800
Message-ID: <20241015063651.8610-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500024.china.huawei.com (7.185.36.10)

It is meant to use xa_err() to extract the error encoded in the return
value of xa_store().

Fixes: 44c2fbebe18a ("mlxsw: spectrum_router: Share nexthop counters in resilient groups")
Signed-off-by: Yuan Can <yuancan@huawei.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
index 800dfb64ec83..7d6d859cef3f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -3197,7 +3197,6 @@ mlxsw_sp_nexthop_sh_counter_get(struct mlxsw_sp *mlxsw_sp,
 {
 	struct mlxsw_sp_nexthop_group *nh_grp = nh->nhgi->nh_grp;
 	struct mlxsw_sp_nexthop_counter *nhct;
-	void *ptr;
 	int err;
 
 	nhct = xa_load(&nh_grp->nhgi->nexthop_counters, nh->id);
@@ -3210,12 +3209,10 @@ mlxsw_sp_nexthop_sh_counter_get(struct mlxsw_sp *mlxsw_sp,
 	if (IS_ERR(nhct))
 		return nhct;
 
-	ptr = xa_store(&nh_grp->nhgi->nexthop_counters, nh->id, nhct,
-		       GFP_KERNEL);
-	if (IS_ERR(ptr)) {
-		err = PTR_ERR(ptr);
+	err = xa_err(xa_store(&nh_grp->nhgi->nexthop_counters, nh->id, nhct,
+			      GFP_KERNEL));
+	if (err)
 		goto err_store;
-	}
 
 	return nhct;
 
-- 
2.17.1


