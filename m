Return-Path: <netdev+bounces-69322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 780E784AB31
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 01:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E882288F71
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 00:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFBD646;
	Tue,  6 Feb 2024 00:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nl8RSheU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C901373
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 00:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707180932; cv=none; b=Miz+iHfVaq6h2i1m+q/cdEPT253EJ+maFO4yqCH6Q/r0sxg65KSgs8tGbfJuKVyArcexy1CjPaZfedjMTfG8xFA2+qblZRukk1MgLWasVr7SXnjfIsE8RxOC7OF5FIBCOAIPQQRJKcKLJhQjOvX7GyOJKBs4HYdwjR8Pbd9u04M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707180932; c=relaxed/simple;
	bh=7oAESdKlteanAg5NbdTtvIPa6oUhHUeW59gnNsifAi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDzz33CddjuDN/npuD5lhuOVYd6gGWcqxe0Go3a54IrbHcw6L/jOsTJapjnWGVoJ5KU944SHvRKAKPpgsIQfJ3nrd67vsLACadQJVxkLXZc7KJrQHo710sm6NBAGhXxRRqA5zhiuhzsQCbY8RZCHogOL85lO1vxuUHefpoO8hnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nl8RSheU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488F2C433C7;
	Tue,  6 Feb 2024 00:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707180931;
	bh=7oAESdKlteanAg5NbdTtvIPa6oUhHUeW59gnNsifAi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nl8RSheUapsTYlWvhDEBPaJYsvsbfVqG0rl9bltIYyHsgjdXAJiZk5SG7Kd+lXcKA
	 CuU6Yg+MyDXf//RH5lgeI2PV1S/CjtKsJh2dQUxZ4oVAR+LyUTq+Zui4zPifDqeAPq
	 ZiL3moBMvndgTQZA7Gsx5PLF3XMj5fqEmxaftDY+FXCvWq82Lli2Rb6jdOpRPao2te
	 SD55HAhM1d0oWWhCsW2qwP6eWSDT3SDUulv4K41IkhFX3AhK1TkSPPmgsjN787M9jf
	 xZMmIqU999G/u5xfhGoTIwZ/epoU99iUqBguC/BwPG6IlOvrTmpLuwA8JzkNJmEWqU
	 wXweTEQGPWOOA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [net-next V4 01/15] xfrm: generalize xdo_dev_state_update_curlft to allow statistics update
Date: Mon,  5 Feb 2024 16:55:13 -0800
Message-ID: <20240206005527.1353368-2-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206005527.1353368-1-saeed@kernel.org>
References: <20240206005527.1353368-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

In order to allow drivers to fill all statistics, change the name
of xdo_dev_state_update_curlft to be xdo_dev_state_update_stats.

Acked-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 Documentation/networking/xfrm_device.rst              |  4 ++--
 .../net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c  |  7 ++++---
 include/linux/netdevice.h                             |  2 +-
 include/net/xfrm.h                                    | 11 ++++-------
 net/xfrm/xfrm_state.c                                 |  4 ++--
 net/xfrm/xfrm_user.c                                  |  2 +-
 6 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/Documentation/networking/xfrm_device.rst b/Documentation/networking/xfrm_device.rst
index 535077cbeb07..bfea9d8579ed 100644
--- a/Documentation/networking/xfrm_device.rst
+++ b/Documentation/networking/xfrm_device.rst
@@ -71,9 +71,9 @@ Callbacks to implement
 	bool	(*xdo_dev_offload_ok) (struct sk_buff *skb,
 				       struct xfrm_state *x);
 	void    (*xdo_dev_state_advance_esn) (struct xfrm_state *x);
+	void    (*xdo_dev_state_update_stats) (struct xfrm_state *x);
 
         /* Solely packet offload callbacks */
-	void    (*xdo_dev_state_update_curlft) (struct xfrm_state *x);
 	int	(*xdo_dev_policy_add) (struct xfrm_policy *x, struct netlink_ext_ack *extack);
 	void	(*xdo_dev_policy_delete) (struct xfrm_policy *x);
 	void	(*xdo_dev_policy_free) (struct xfrm_policy *x);
@@ -191,6 +191,6 @@ xdo_dev_policy_free() on any remaining offloaded states.
 
 Outcome of HW handling packets, the XFRM core can't count hard, soft limits.
 The HW/driver are responsible to perform it and provide accurate data when
-xdo_dev_state_update_curlft() is called. In case of one of these limits
+xdo_dev_state_update_stats() is called. In case of one of these limits
 occuried, the driver needs to call to xfrm_state_check_expire() to make sure
 that XFRM performs rekeying sequence.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 05612d9c6080..f160522fbe75 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -984,7 +984,7 @@ static void mlx5e_xfrm_advance_esn_state(struct xfrm_state *x)
 	queue_work(sa_entry->ipsec->wq, &work->work);
 }
 
-static void mlx5e_xfrm_update_curlft(struct xfrm_state *x)
+static void mlx5e_xfrm_update_stats(struct xfrm_state *x)
 {
 	struct mlx5e_ipsec_sa_entry *sa_entry = to_ipsec_sa_entry(x);
 	struct mlx5e_ipsec_rule *ipsec_rule = &sa_entry->ipsec_rule;
@@ -993,7 +993,8 @@ static void mlx5e_xfrm_update_curlft(struct xfrm_state *x)
 	lockdep_assert(lockdep_is_held(&x->lock) ||
 		       lockdep_is_held(&dev_net(x->xso.real_dev)->xfrm.xfrm_cfg_mutex));
 
-	if (x->xso.flags & XFRM_DEV_OFFLOAD_FLAG_ACQ)
+	if (x->xso.flags & XFRM_DEV_OFFLOAD_FLAG_ACQ ||
+	    x->xso.type != XFRM_DEV_OFFLOAD_PACKET)
 		return;
 
 	mlx5_fc_query_cached(ipsec_rule->fc, &bytes, &packets, &lastuse);
@@ -1156,7 +1157,7 @@ static const struct xfrmdev_ops mlx5e_ipsec_xfrmdev_ops = {
 	.xdo_dev_offload_ok	= mlx5e_ipsec_offload_ok,
 	.xdo_dev_state_advance_esn = mlx5e_xfrm_advance_esn_state,
 
-	.xdo_dev_state_update_curlft = mlx5e_xfrm_update_curlft,
+	.xdo_dev_state_update_stats = mlx5e_xfrm_update_stats,
 	.xdo_dev_policy_add = mlx5e_xfrm_add_policy,
 	.xdo_dev_policy_delete = mlx5e_xfrm_del_policy,
 	.xdo_dev_policy_free = mlx5e_xfrm_free_policy,
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 118c40258d07..9538576dbebc 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1062,7 +1062,7 @@ struct xfrmdev_ops {
 	bool	(*xdo_dev_offload_ok) (struct sk_buff *skb,
 				       struct xfrm_state *x);
 	void	(*xdo_dev_state_advance_esn) (struct xfrm_state *x);
-	void	(*xdo_dev_state_update_curlft) (struct xfrm_state *x);
+	void	(*xdo_dev_state_update_stats) (struct xfrm_state *x);
 	int	(*xdo_dev_policy_add) (struct xfrm_policy *x, struct netlink_ext_ack *extack);
 	void	(*xdo_dev_policy_delete) (struct xfrm_policy *x);
 	void	(*xdo_dev_policy_free) (struct xfrm_policy *x);
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 1d107241b901..4ca2f3205190 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1578,21 +1578,18 @@ struct xfrm_state *xfrm_state_lookup_byspi(struct net *net, __be32 spi,
 					      unsigned short family);
 int xfrm_state_check_expire(struct xfrm_state *x);
 #ifdef CONFIG_XFRM_OFFLOAD
-static inline void xfrm_dev_state_update_curlft(struct xfrm_state *x)
+static inline void xfrm_dev_state_update_stats(struct xfrm_state *x)
 {
 	struct xfrm_dev_offload *xdo = &x->xso;
 	struct net_device *dev = xdo->dev;
 
-	if (x->xso.type != XFRM_DEV_OFFLOAD_PACKET)
-		return;
-
 	if (dev && dev->xfrmdev_ops &&
-	    dev->xfrmdev_ops->xdo_dev_state_update_curlft)
-		dev->xfrmdev_ops->xdo_dev_state_update_curlft(x);
+	    dev->xfrmdev_ops->xdo_dev_state_update_stats)
+		dev->xfrmdev_ops->xdo_dev_state_update_stats(x);
 
 }
 #else
-static inline void xfrm_dev_state_update_curlft(struct xfrm_state *x) {}
+static inline void xfrm_dev_state_update_stats(struct xfrm_state *x) {}
 #endif
 void xfrm_state_insert(struct xfrm_state *x);
 int xfrm_state_add(struct xfrm_state *x);
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index bda5327bf34d..d8701b2d0d57 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -570,7 +570,7 @@ static enum hrtimer_restart xfrm_timer_handler(struct hrtimer *me)
 	int err = 0;
 
 	spin_lock(&x->lock);
-	xfrm_dev_state_update_curlft(x);
+	xfrm_dev_state_update_stats(x);
 
 	if (x->km.state == XFRM_STATE_DEAD)
 		goto out;
@@ -1935,7 +1935,7 @@ EXPORT_SYMBOL(xfrm_state_update);
 
 int xfrm_state_check_expire(struct xfrm_state *x)
 {
-	xfrm_dev_state_update_curlft(x);
+	xfrm_dev_state_update_stats(x);
 
 	if (!READ_ONCE(x->curlft.use_time))
 		WRITE_ONCE(x->curlft.use_time, ktime_get_real_seconds());
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index ad01997c3aa9..dc4f9b8d7cb0 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -902,7 +902,7 @@ static void copy_to_user_state(struct xfrm_state *x, struct xfrm_usersa_info *p)
 	memcpy(&p->sel, &x->sel, sizeof(p->sel));
 	memcpy(&p->lft, &x->lft, sizeof(p->lft));
 	if (x->xso.dev)
-		xfrm_dev_state_update_curlft(x);
+		xfrm_dev_state_update_stats(x);
 	memcpy(&p->curlft, &x->curlft, sizeof(p->curlft));
 	put_unaligned(x->stats.replay_window, &p->stats.replay_window);
 	put_unaligned(x->stats.replay, &p->stats.replay);
-- 
2.43.0


