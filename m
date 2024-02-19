Return-Path: <netdev+bounces-73043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6996A85AAE7
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 19:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3F72819FB
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEC5482E2;
	Mon, 19 Feb 2024 18:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SO7v6rc4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDD9481DB
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 18:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367011; cv=none; b=riwG+eI9uGcBCgTHRvilIXMpWhwyH6rjLw2yr+MdSuoqnimwuV72ivDlC8mBPVg8Hoa/WezUmycABMNPzA0wd1vtctplPf3Mq/pD1kq7FyFTtM0FTtLXUXCOeDAv7K7fla9w9xqsRuZ0jWF25IOGr5/nZ3JqrDvDISdY2BcmnLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367011; c=relaxed/simple;
	bh=ui5Q7u4Cev3lNjw3eM2c0399K256i235lRxtY9Lnmu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uka+4nyN9/t7ZdZDRGXG+cLKT8HEEsjV/Z1+9uQr97Yxt3SNTVWAwm4zF9q6jUivI2XUoHLnJzc9OihlnVFxpJwpMGUALoF4FGamnjYtZKoeWBtOA5zWnfp/7CqflZa3LMlHxnG6j4oqLrJih5KM5feOOmXd/NXmRm+Qkabrbbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SO7v6rc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554ACC43390;
	Mon, 19 Feb 2024 18:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708367011;
	bh=ui5Q7u4Cev3lNjw3eM2c0399K256i235lRxtY9Lnmu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SO7v6rc42GXgkoMkku3BrcrU/kAUxgxUe4JDo3AblSr2nB3vorAA5B54LMsHZ7a0K
	 uog5yjNemFn66epOFZ6EXq6H7ugdN2lYQrrbhPeW6zwjaNBqGO+Nu2ObAF1lBy9MgW
	 BmVYayYgiczETAOhrhaPhQGQBp127Q++X9Y5+1zaDUSSwnSWimX+qipCkhLgpIU/3v
	 lDvAXscq+z+jct6sWzpT4CH/MYAZ85AL6WE8KCtzRz4qj/xwPgdd6mJ79Me6Z78c2m
	 kIJeolSsVI+fdT4h686PvO6Z1I6v+A20sUx2D+b0Ef6JAmR2mGo4z2mtroP3UcNwZO
	 DtK3IEo6fK2TA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net 02/10] Revert "net/mlx5e: Check the number of elements before walk TC rhashtable"
Date: Mon, 19 Feb 2024 10:23:12 -0800
Message-ID: <20240219182320.8914-3-saeed@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219182320.8914-1-saeed@kernel.org>
References: <20240219182320.8914-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

This reverts commit 4e25b661f484df54b6751b65f9ea2434a3b67539.

This Commit was mistakenly applied by pulling the wrong tag, remove it.

Fixes: 4e25b661f484 ("net/mlx5e: Check the number of elements before walk TC rhashtable")
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
index 190f10aba170..5a0047bdcb51 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
@@ -152,7 +152,7 @@ void mlx5_esw_ipsec_restore_dest_uplink(struct mlx5_core_dev *mdev)
 
 	xa_for_each(&esw->offloads.vport_reps, i, rep) {
 		rpriv = rep->rep_data[REP_ETH].priv;
-		if (!rpriv || !rpriv->netdev || !atomic_read(&rpriv->tc_ht.nelems))
+		if (!rpriv || !rpriv->netdev)
 			continue;
 
 		rhashtable_walk_enter(&rpriv->tc_ht, &iter);
-- 
2.43.2


