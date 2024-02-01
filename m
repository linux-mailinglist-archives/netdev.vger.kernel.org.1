Return-Path: <netdev+bounces-67849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8DA8451F7
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 08:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3311C23ADE
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 07:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41200158D9A;
	Thu,  1 Feb 2024 07:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTtDY65G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9281586E8
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 07:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772735; cv=none; b=MnMzX4nUBj4O4Vu2CkQw9gOMLGZU+bsXqz/RRNXx7Idh1TQ8/wq2UT5Z1VGpIwszykueCKqB4iQFu/jfkuITR+nH4QMBcL+OiB8VOVRYniE4WTHnhmakThb9W/lWXJe3qDs6TIjUwHAhESSpfiGw0Nis9Dq5HmBAsbEV8VucoS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772735; c=relaxed/simple;
	bh=pjHVDkPW6CgUbfbrxRIrPLhyz+0PC/UodDEe2ysFRco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCFZj0U0Y2PlgzBb0uV7IOTodheSvJuYLDqeZoVb6UPzqquqBIm75LbOZRzqqAGm6Dpn0jU3YAepqYwY6s2ZgpD3k1hD7jidG58I+MAQ0pewti/OH4Pj8WXGgdHnUjUl5HFWrp+UiBO9Nx9rD6cVy6QcmPjijqUAlua7uy78Rt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTtDY65G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCF3C43399;
	Thu,  1 Feb 2024 07:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706772734;
	bh=pjHVDkPW6CgUbfbrxRIrPLhyz+0PC/UodDEe2ysFRco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GTtDY65GxNePT6CsbQa1JfnP5BLg0Px+qJ8BPD2fUr3guaNih5N9TmX4gB+T8dPaO
	 tkjPHJ0YrEm6xsMYrfKIUyM428RCTmmP5oiRlHHglwj3y1k3OmILolkOpWnv0ku3+l
	 wD/kdlm0A16eLs5r3yXaxttAU6ecsiR2J/CUTv9MdhDA21h6/qLoSF/S2jE2fnksnq
	 rpJ1H41craAZbOHcUEku6JK9aQPL84wYWD7fOvKUXUeyAl75HEb5o/UN7KJgDZZiFJ
	 ca2qD/E02ctb+LvlTFdUoDSPvtosTuk4TU7noJ5I0K5aXoMBi72p4ncLynbn8sfixp
	 b0Iu29P/AMakA==
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
Subject: [net-next V2 03/15] net/mlx5e: Connect mlx5 IPsec statistics with XFRM core
Date: Wed, 31 Jan 2024 23:31:46 -0800
Message-ID: <20240201073158.22103-4-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201073158.22103-1-saeed@kernel.org>
References: <20240201073158.22103-1-saeed@kernel.org>
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


