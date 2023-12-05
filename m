Return-Path: <netdev+bounces-53781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596678049DE
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 07:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56FB91C20E6D
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 06:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B1C134DD;
	Tue,  5 Dec 2023 06:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rALA/gWP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35F9134D0
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 06:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737A7C433C8;
	Tue,  5 Dec 2023 06:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701756827;
	bh=Ajb0QBHDOuNSNrtWlp8X9EtiuP+Al4D+gWjN6yBTUvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rALA/gWPbawBLdBIcRWycMqo/jjIwH6aR01PNmqj5OrtHmKZza2eZAAnaFOdN6W66
	 Ywp3LWtKQY+D0igh+AlpwHcFJ41rIquxM251SoBbOoRi/zgrpePuRMEVBHvpAemeSS
	 0AcM/ub2K31DTffnS9rXcTjlgXa2SS9LUCl4OlNymTyOvqVyRwv4xtTQbme44rsTIO
	 5unTuqCObFxaf+vEWHhe5xhItoiyNx7Y3kD/nJ5BfPMzvrTIyXIc6TwgyNUL9bvl2s
	 WlOyEsjC7IanTwbtjclCTjaHomjyf8zi7JOfYUe5rohFIAiddRpZpFXfjBLQJI3XX2
	 nYvLKsOeqDK+w==
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
Subject: [net V2 08/14] net/mlx5e: Check the number of elements before walk TC rhashtable
Date: Mon,  4 Dec 2023 22:13:21 -0800
Message-ID: <20231205061327.44638-9-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205061327.44638-1-saeed@kernel.org>
References: <20231205061327.44638-1-saeed@kernel.org>
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
2.43.0


