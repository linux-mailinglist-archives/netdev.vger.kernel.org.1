Return-Path: <netdev+bounces-69392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3142984B075
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 09:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D34091F2666F
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 08:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A51212BF3B;
	Tue,  6 Feb 2024 08:55:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from njjs-sys-mailin01.njjs.baidu.com (mx309.baidu.com [180.101.52.12])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB74D12C54B
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 08:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707209705; cv=none; b=op4ZJvlRG3HsFLoGLiN9VgHOUrffSdhw5eQvuOQJPWjB7/NDQgUq9FjbvFksW5YNbUGI1mKNzAM33G5M7Fsq7CT5l0TcKe/C2TC3q1BEDtPnX7XF5kwEGlp+jdkYXC3Inrtd5aH4+p9QRNB6gbaxjDZQ/NQOcqsEM1czaCjioG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707209705; c=relaxed/simple;
	bh=9dsL4toPjj/Bya0ECfbBp3idYQ8DgJvXtPnnxlk8WRQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=WCfmQ/xsCJ5eDnlEXU4ejCN/kfooy1qYY2ixwoR3fca9V+/CVXguQlHabwBruYC9VFCZNoeZDU8WdMATMfE8fwdZoPgOh4XK3qD0qzcn0of0Nh+ebRBBS+2FOSDnbAH6lN7IldGFMfhlZyWvWuMovVZ8iu5Qo9YgPiIrQoaTnjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 775727F0003D;
	Tue,  6 Feb 2024 16:54:59 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: netdev@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH net-next] net/mlx5: Use the first node of priv.free_list in alloc_4k
Date: Tue,  6 Feb 2024 16:54:56 +0800
Message-Id: <20240206085456.48285-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Use the first node of priv.free_list, which is cache-hot;
and avoid unnecessary iterations

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
index dcf58ef..7113d98 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
@@ -228,6 +228,7 @@ static int alloc_4k(struct mlx5_core_dev *dev, u64 *addr, u32 function)
 		if (iter->function != function)
 			continue;
 		fp = iter;
+		break;
 	}
 
 	if (list_empty(&dev->priv.free_list) || !fp)
-- 
2.9.4


