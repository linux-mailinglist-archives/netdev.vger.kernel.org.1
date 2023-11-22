Return-Path: <netdev+bounces-49877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C77C17F3B79
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 02:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5727FB21AAF
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 01:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED608BE1;
	Wed, 22 Nov 2023 01:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dA+ipBlQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CC6AD47
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 01:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F005EC433C9;
	Wed, 22 Nov 2023 01:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700617693;
	bh=G8DvcDc+d2mgQcHTpbfZCQKr4g3yOjNUI6s3RnzEqco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dA+ipBlQ1kMgA5QgPD9s24rvyUkNVhBMUZX7XM1x/diheXb+8ZpSs4To4ZNsU1OoG
	 q2dVe3e2wY+fKSar0AXyKkpoUsN5lV64+CrF5KAz4+4k8wABxiZopEqwzwSD4O58if
	 pRriwk0SEg7vnoZLQ0p6GRQT5dLe4zff0Lrlk/PMTGdgiMPA3FkR+h+Y6SufasI/x4
	 QCSoYFExcJPnPFKnCfiTC9ikiomd1qAe8Q9zPzwE3fEqt0KhQG2blS3uQHFOX24Rxn
	 jQa0V3FcGfVsaWyRgvCb1UA5elyowu60oHDCGqD7FYbQcVZMQq2Maug95SWx2douTF
	 O5tZWlH/61y5Q==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net 08/15] net/mlx5e: Check the number of elements before walk TC rhashtable
Date: Tue, 21 Nov 2023 17:47:57 -0800
Message-ID: <20231122014804.27716-9-saeed@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122014804.27716-1-saeed@kernel.org>
References: <20231122014804.27716-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

After IPSec TX tables are destroyed, the flow rules in TC rhashtable,
which have the destination to IPSec, are restored to the original
one, the uplink.

However, when the device is in switchdev mode and unload driver with
IPSec rules configured, TC rhashtable cleanup is done before IPSec
cleanup, which means tc_ht->tbl is already freed when walking TC
rhashtable, in order to restore the destination. So add the checking
before walking to avoid unexpected behavior.

Fixes: d1569537a837 ("net/mlx5e: Modify and restore TC rules for IPSec TX rules")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
index 5a0047bdcb51..190f10aba170 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
@@ -152,7 +152,7 @@ void mlx5_esw_ipsec_restore_dest_uplink(struct mlx5_core_dev *mdev)
 
 	xa_for_each(&esw->offloads.vport_reps, i, rep) {
 		rpriv = rep->rep_data[REP_ETH].priv;
-		if (!rpriv || !rpriv->netdev)
+		if (!rpriv || !rpriv->netdev || !atomic_read(&rpriv->tc_ht.nelems))
 			continue;
 
 		rhashtable_walk_enter(&rpriv->tc_ht, &iter);
-- 
2.42.0


