Return-Path: <netdev+bounces-136380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 875A09A18AB
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 04:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 337DE1F23B9F
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 02:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F5B27456;
	Thu, 17 Oct 2024 02:37:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB99101F2
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 02:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729132621; cv=none; b=hPmsVdxhBb/O7emVk/j0fgmU1A1bFJFEoO8Fl4fvj2kT6AZG+lMI8wB8wRIh0DCkyhM2TuETRP2KzA05uM+1ir2DVfOCzj6ih7qDzriEFkko3HJRoThUzyU7hXeb4pv5UcNu6g6uefcT86Mqd15YfSo71Yjmymv/yW3r/XJPlrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729132621; c=relaxed/simple;
	bh=thPTLzlYBEEj02dJxa8yTG0lX3W69rVkQBwju4rCSqQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oq8xhX2UYBXA0IeikYEOoBnLkpQwWRtKfPEYdDDhFcEgfe4Y/u71cSio2ZI5X6vNvNH/zV5d4MU+g6MYPStr9BNVvr9EveV6QNRBI6nwyxdNGoHLovGdrcbqcL1qBdlOYIpdJ1zVhkyGEitR+t7pGSAv1a1pD8OB6w33b6b/7LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XTX1P52kTz1HJkZ;
	Thu, 17 Oct 2024 10:32:41 +0800 (CST)
Received: from dggpeml500024.china.huawei.com (unknown [7.185.36.10])
	by mail.maildlp.com (Postfix) with ESMTPS id BF18A140157;
	Thu, 17 Oct 2024 10:36:55 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 10:36:55 +0800
From: Yuan Can <yuancan@huawei.com>
To: <idosch@nvidia.com>, <petrm@nvidia.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
CC: <yuancan@huawei.com>
Subject: [PATCH net v2] mlxsw: spectrum_router: fix xa_store() error checking
Date: Thu, 17 Oct 2024 10:32:23 +0800
Message-ID: <20241017023223.74180-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500024.china.huawei.com (7.185.36.10)

It is meant to use xa_err() to extract the error encoded in the return
value of xa_store().

Fixes: 44c2fbebe18a ("mlxsw: spectrum_router: Share nexthop counters in resilient groups")
Signed-off-by: Yuan Can <yuancan@huawei.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
Changes since v1:
- Change target branch to net.
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


