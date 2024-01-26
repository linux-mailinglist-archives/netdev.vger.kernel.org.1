Return-Path: <netdev+bounces-66300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9528F83E596
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 23:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 522BF282AF4
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 22:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AD6481D6;
	Fri, 26 Jan 2024 22:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srSl60fV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365FC481D1
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 22:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308611; cv=none; b=aLK0P6lgBocdnascE1s6CPXOOCGBNKQno9vItVgFeMn2z6zVlq1ullveK/BpIRjVOKUcZrdYaoplZuFVQT1zjoIkklk18lmS7cKMaVMcaYcib6pyIMQdblvp5fn+Gso8mxF5XCmx/8jWdsDgjkSZjc5d1bH+1ecjZ7CJdCYBHYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308611; c=relaxed/simple;
	bh=pjHVDkPW6CgUbfbrxRIrPLhyz+0PC/UodDEe2ysFRco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KaNlGKZ+PRxI+ybycVreudhech6z/kz8CmOxHUpJ3ze5aztW5/ZeSeSbdwydyyrc7kky/DyaHWnjuBB+OIfR3Zk7NzxfH6znsFZSfa2K8+4D+pNj7DSEw+dhQ3dgqMKvm5OUuEyE/YFmk0/YP0KnKtPfm7pAn3NtyyHpATQLOjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srSl60fV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96178C433C7;
	Fri, 26 Jan 2024 22:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706308610;
	bh=pjHVDkPW6CgUbfbrxRIrPLhyz+0PC/UodDEe2ysFRco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=srSl60fVL0F4Vh0TNUTaXgtNPDLc1VSFenqyain1oNQuwfb4vwq0tKzz4EtOQUEne
	 brn0PVWJWWgoO7V/XzKBfXiWD8STR/qd33IxWN1gE8rShDPLH9qP9yKEOWFzEKPmIs
	 L6w1NOPwk0SL0pFfPDMZiVvR8nNptHulAarVAaEDkztLUtQnW0ie83hRFfrcSU2xxD
	 6r6trZT98pfV0lJqyl0qEBLC1LVzd3pqAcUaP0pxz93pYUR+gpf8zA1q7R9OBH+6Ia
	 6dFn0kMcuqHKFmsXooCPe97FTepL62lb9njU6ADJof06q3kKuJSxdAixB/eT48UhDn
	 t0kbXNYRBR2tg==
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
Subject: [net-next 03/15] net/mlx5e: Connect mlx5 IPsec statistics with XFRM core
Date: Fri, 26 Jan 2024 14:36:04 -0800
Message-ID: <20240126223616.98696-4-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240126223616.98696-1-saeed@kernel.org>
References: <20240126223616.98696-1-saeed@kernel.org>
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
index 46cce4e38d84..c54fd01ea635 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -988,19 +988,37 @@ static void mlx5e_xfrm_update_stats(struct xfrm_state *x)
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
2.43.0


