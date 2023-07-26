Return-Path: <netdev+bounces-21628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75106764130
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A13481C21406
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661341BF18;
	Wed, 26 Jul 2023 21:32:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8701BF0B
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B48DC433CA;
	Wed, 26 Jul 2023 21:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690407130;
	bh=SmR2+DREp+fpwu0EWDDUMlugDROn2Us9gl1NltoZhMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AxRWIVkBvu4JNIzkDwxQ7aJjUQOgMetjuddDhciikmYOrc4jMjoCyfs9t4IlE6KVP
	 hg+qpbrrRmxaR8lOugj61pQh0YgRo7J0MYf+E2CRm2sEb1MTv/9gOz2RTx3tbtuHVt
	 HbS8xAlLn8Ac+iyuSb6ldSI3MJOO92VTwZZkZuBUNbVWq4OvYsJNRLLK8CHi5QNAZi
	 ZMLkSTRkoCChgjeEu5Z6idHbqNkNaQ4jK6C/NiQpZKm22CBhf+Wz+dGmnTVxnaZkSL
	 ybtw9De2y3XWheR/hwY+3QPIB5EsN+okhsGtHYO2dCo3EQxittC9GTuXPIR+BpvQVd
	 cQ1aBT6NjcXFA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Zhengchao Shao <shaozhengchao@huawei.com>,
	Simon Horman <simon.horman@corigine.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net 01/15] net/mlx5e: fix double free in macsec_fs_tx_create_crypto_table_groups
Date: Wed, 26 Jul 2023 14:31:52 -0700
Message-ID: <20230726213206.47022-2-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726213206.47022-1-saeed@kernel.org>
References: <20230726213206.47022-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhengchao Shao <shaozhengchao@huawei.com>

In function macsec_fs_tx_create_crypto_table_groups(), when the ft->g
memory is successfully allocated but the 'in' memory fails to be
allocated, the memory pointed to by ft->g is released once. And in function
macsec_fs_tx_create(), macsec_fs_tx_destroy() is called to release the
memory pointed to by ft->g again. This will cause double free problem.

Fixes: e467b283ffd5 ("net/mlx5e: Add MACsec TX steering rules")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c
index 7fc901a6ec5f..414e28584881 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c
@@ -161,6 +161,7 @@ static int macsec_fs_tx_create_crypto_table_groups(struct mlx5e_flow_table *ft)
 
 	if (!in) {
 		kfree(ft->g);
+		ft->g = NULL;
 		return -ENOMEM;
 	}
 
-- 
2.41.0


