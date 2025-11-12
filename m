Return-Path: <netdev+bounces-237823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D7AC509A9
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 06:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E6D3A963C
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 05:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3B32C0F6C;
	Wed, 12 Nov 2025 05:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="NNCY4PvK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E53E10942;
	Wed, 12 Nov 2025 05:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762924890; cv=none; b=raICKSkvqSkZo4hGe9EpQlZVQ37VBqDeONHaJDYTHsonXo0B2SBs8FLJW5Me+Ow7/RW8nhC1xU2P/jlvBD4rTXJyh0RkUoFCdUWwZqNrY9AK5CEtJ1Er0ytxTzAj2fQYEHeLpmt2VxuZcoNWS+hkpq6rYHtLn6roolmqq+YG2aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762924890; c=relaxed/simple;
	bh=mI8T5qp75RMZvOo14g5Udf1hFjg7nPChgpTmabXEfjs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e+LwiOn5YJxZr3JkQkovyM8D55sKMjAkECd+vXjp1g1BpAcmKudAvdfxl/xe94+Sa/t9Q2LX5n4Hqf5X5ILlW7TjY46+cRlFXWaKCNUTsVjnyw9mG3Y+rp0+4SGxPSNqNjv5sjYPst/vUVWF5FFHvia1goj5mb7zMOMZjg4KIsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=NNCY4PvK; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 29483f4ca;
	Wed, 12 Nov 2025 13:21:17 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: idosch@nvidia.com
Cc: petrm@nvidia.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] mlxsw: spectrum: Fix memory leak in mlxsw_sp_flower_stats()
Date: Wed, 12 Nov 2025 05:21:14 +0000
Message-Id: <20251112052114.1591695-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a7682d66903a1kunme2d3ae7bb6ce8e
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSUtKVk9KTh4YSh4ZHx4aQlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0xVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=NNCY4PvKv3/tuAgShApIXnMbMFdwt630jeZiEC6UocbFgRT2xdEjLISatyUWMAdf6ZF0Cpi7poNmyt7uhaLp3+j2NRhczXqhBPftkIByu1EibM32XJSaJ1/wep1e8nEpSPhaYtobypZ13x3wumVa7FbeOOE42KFvkLo0tGvEDaE=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=ctO8x7yP9+riKFZtMGesTZv10tCnO11ZkNJa5/sXgFM=;
	h=date:mime-version:subject:message-id:from;

The function mlxsw_sp_flower_stats() calls mlxsw_sp_acl_ruleset_get() to
obtain a ruleset reference. If the subsequent call to
mlxsw_sp_acl_rule_lookup() fails to find a rule, the function returns
an error without releasing the ruleset reference, causing a memory leak.

Fix this by using a goto to the existing error handling label, which
calls mlxsw_sp_acl_ruleset_put() to properly release the reference.

Fixes: 7c1b8eb175b69 ("mlxsw: spectrum: Add support for TC flower offload statistics")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
index 6a4a81c63451..353fd9ca89a6 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_flower.c
@@ -830,8 +830,10 @@ int mlxsw_sp_flower_stats(struct mlxsw_sp *mlxsw_sp,
 		return -EINVAL;
 
 	rule = mlxsw_sp_acl_rule_lookup(mlxsw_sp, ruleset, f->cookie);
-	if (!rule)
-		return -EINVAL;
+	if (!rule) {
+		err = -EINVAL;
+		goto err_rule_get_stats;
+	}
 
 	err = mlxsw_sp_acl_rule_get_stats(mlxsw_sp, rule, &packets, &bytes,
 					  &drops, &lastuse, &used_hw_stats);
-- 
2.34.1


