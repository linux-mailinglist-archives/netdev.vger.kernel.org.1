Return-Path: <netdev+bounces-42859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E417D06B8
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 05:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3ECF1C20F6C
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 03:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F16AEDF;
	Fri, 20 Oct 2023 03:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlkmrErh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D3A7476
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 03:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2DCC433C9;
	Fri, 20 Oct 2023 03:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697771081;
	bh=qM/kEWEAJdWZ0FZLWZAPZFFrBRowmZg/sacMb+wtza8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jlkmrErhG/X8aBPl/rSM2/N/Az5qlRWQYVh8iEyeMOOxd7BsqSnLsBYSN79c/xk8s
	 KmsKKlK/OV2J01cZlKRC9pXUCGfSoWW/5IDOc5E81hgQsDOEiVv5H0fvvdMSBse1zz
	 aURZZr/n+UE4QrdJdWzIxvfUDdvDGsJqePbPWgZMzOOV7JWVuRrMuRDSEyugeP2wHH
	 ZXK1Z3aGZbQZdP/43fuQXHNMuzKYwhKdPovCaurYaalbtOzymHT6O2sBqk7vnZhJsr
	 pb007+jCbl1pcOuW77istkutezjLeoYQbC5JmmLJb/CSt6/2477jy1TZbf7gtzsqlM
	 LJUdw5fq69+cg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net-next 08/15] net/mlx5e: Connect mlx5 IPsec statistics with XFRM core
Date: Thu, 19 Oct 2023 20:04:15 -0700
Message-ID: <20231020030422.67049-9-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020030422.67049-1-saeed@kernel.org>
References: <20231020030422.67049-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Fill integrity, replay and bad trailer counters.

As an example, after simulating replay window attack with 5 packets:
[leonro@c ~]$ grep XfrmInStateSeqError /proc/net/xfrm_stat
XfrmInStateSeqError     	5
[leonro@c ~]$ sudo ip -s x s
<...>
	stats:
	  replay-window 0 replay 5 failed 0

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec.c       | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index bf88232a2fc2..5b2660662811 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -980,19 +980,37 @@ static void mlx5e_xfrm_update_stats(struct xfrm_state *x)
 {
 	struct mlx5e_ipsec_sa_entry *sa_entry = to_ipsec_sa_entry(x);
 	struct mlx5e_ipsec_rule *ipsec_rule = &sa_entry->ipsec_rule;
+	struct net *net = dev_net(x->xso.dev);
 	u64 packets, bytes, lastuse;
 
 	lockdep_assert(lockdep_is_held(&x->lock) ||
 		       lockdep_is_held(&dev_net(x->xso.real_dev)->xfrm.xfrm_cfg_mutex) ||
 		       lockdep_is_held(&dev_net(x->xso.real_dev)->xfrm.xfrm_state_lock));
 
-	if (x->xso.flags & XFRM_DEV_OFFLOAD_FLAG_ACQ ||
-	    x->xso.type != XFRM_DEV_OFFLOAD_PACKET)
+	if (x->xso.flags & XFRM_DEV_OFFLOAD_FLAG_ACQ)
+		return;
+
+	if (sa_entry->attrs.dir == XFRM_DEV_OFFLOAD_IN) {
+		mlx5_fc_query_cached(ipsec_rule->auth.fc, &bytes, &packets, &lastuse);
+		x->stats.integrity_failed += packets;
+		XFRM_ADD_STATS(net, LINUX_MIB_XFRMINSTATEPROTOERROR, packets);
+
+		mlx5_fc_query_cached(ipsec_rule->trailer.fc, &bytes, &packets, &lastuse);
+		XFRM_ADD_STATS(net, LINUX_MIB_XFRMINHDRERROR, packets);
+	}
+
+	if (x->xso.type != XFRM_DEV_OFFLOAD_PACKET)
 		return;
 
 	mlx5_fc_query_cached(ipsec_rule->fc, &bytes, &packets, &lastuse);
 	x->curlft.packets += packets;
 	x->curlft.bytes += bytes;
+
+	if (sa_entry->attrs.dir == XFRM_DEV_OFFLOAD_IN) {
+		mlx5_fc_query_cached(ipsec_rule->replay.fc, &bytes, &packets, &lastuse);
+		x->stats.replay += packets;
+		XFRM_ADD_STATS(net, LINUX_MIB_XFRMINSTATESEQERROR, packets);
+	}
 }
 
 static int mlx5e_xfrm_validate_policy(struct mlx5_core_dev *mdev,
-- 
2.41.0


