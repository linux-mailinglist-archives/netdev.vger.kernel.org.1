Return-Path: <netdev+bounces-42852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5C87D06B1
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 05:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C59CB21483
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 03:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDFE1371;
	Fri, 20 Oct 2023 03:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuwdVg8V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA2A10E2
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 03:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB864C433C9;
	Fri, 20 Oct 2023 03:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697771072;
	bh=yL2HDruR1P99V2KXOmTy7fT+NMt7OsX+N7SkkqGIJkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nuwdVg8VSWdXuimY4yJddhjlPCefDtfZbVPyZH1quxVpaTyS58usUTil87DW2MUsq
	 mB9bWpl6RJVvTirFrq2/ms/pnPVrZuK9w/+BSWDvV4U9DV/927QV6UBLWMC759uH6X
	 kL3dxCaOlgfciONvCC8m07QyQbdhE+CUgZ4GnORLOumCWm7QTQvpl2xS/u4RcS9gUH
	 FuqkVjGiQ5Lc3CfPqgDoylFcgkEmUFN1cxE+KOaFGhsroPeOo2PF3d20RHi899Xs+r
	 RaAzP/ztM2HoVHFnYgAIijo551Jt22ScOX7my5oA8vS16Xn2u9iyI7qH2hEPA6aujQ
	 HrRPudwdq20Eg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: [net-next 01/15] xfrm: generalize xdo_dev_state_update_curlft to allow statistics update
Date: Thu, 19 Oct 2023 20:04:08 -0700
Message-ID: <20231020030422.67049-2-saeed@kernel.org>
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

In order to allow drivers to fill all statistics, change the name
of xdo_dev_state_update_curlft to be xdo_dev_state_update_stats.

Cc: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 Documentation/networking/xfrm_device.rst              |  4 ++--
 .../net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c  |  8 +++++---
 include/linux/netdevice.h                             |  2 +-
 include/net/xfrm.h                                    | 11 ++++-------
 net/xfrm/xfrm_state.c                                 |  4 ++--
 net/xfrm/xfrm_user.c                                  |  2 +-
 6 files changed, 15 insertions(+), 16 deletions(-)

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
index 655496598c68..11a7a8bcda0f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -948,7 +948,7 @@ static void mlx5e_xfrm_advance_esn_state(struct xfrm_state *x)
 	queue_work(sa_entry->ipsec->wq, &work->work);
 }
 
-static void mlx5e_xfrm_update_curlft(struct xfrm_state *x)
+static void mlx5e_xfrm_update_stats(struct xfrm_state *x)
 {
 	struct mlx5e_ipsec_sa_entry *sa_entry = to_ipsec_sa_entry(x);
 	struct mlx5e_ipsec_rule *ipsec_rule = &sa_entry->ipsec_rule;
@@ -957,7 +957,8 @@ static void mlx5e_xfrm_update_curlft(struct xfrm_state *x)
 	lockdep_assert(lockdep_is_held(&x->lock) ||
 		       lockdep_is_held(&dev_net(x->xso.real_dev)->xfrm.xfrm_cfg_mutex));
 
-	if (x->xso.flags & XFRM_DEV_OFFLOAD_FLAG_ACQ)
+	if (x->xso.flags & XFRM_DEV_OFFLOAD_FLAG_ACQ ||
+	    x->xso.type != XFRM_DEV_OFFLOAD_PACKET)
 		return;
 
 	mlx5_fc_query_cached(ipsec_rule->fc, &bytes, &packets, &lastuse);
@@ -1113,6 +1114,7 @@ static const struct xfrmdev_ops mlx5e_ipsec_xfrmdev_ops = {
 	.xdo_dev_state_free	= mlx5e_xfrm_free_state,
 	.xdo_dev_offload_ok	= mlx5e_ipsec_offload_ok,
 	.xdo_dev_state_advance_esn = mlx5e_xfrm_advance_esn_state,
+	.xdo_dev_state_update_stats = mlx5e_xfrm_update_stats,
 };
 
 static const struct xfrmdev_ops mlx5e_ipsec_packet_xfrmdev_ops = {
@@ -1122,7 +1124,7 @@ static const struct xfrmdev_ops mlx5e_ipsec_packet_xfrmdev_ops = {
 	.xdo_dev_offload_ok	= mlx5e_ipsec_offload_ok,
 	.xdo_dev_state_advance_esn = mlx5e_xfrm_advance_esn_state,
 
-	.xdo_dev_state_update_curlft = mlx5e_xfrm_update_curlft,
+	.xdo_dev_state_update_stats = mlx5e_xfrm_update_stats,
 	.xdo_dev_policy_add = mlx5e_xfrm_add_policy,
 	.xdo_dev_policy_delete = mlx5e_xfrm_del_policy,
 	.xdo_dev_policy_free = mlx5e_xfrm_free_policy,
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b8bf669212cc..be47b5a1b7f7 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1057,7 +1057,7 @@ struct xfrmdev_ops {
 	bool	(*xdo_dev_offload_ok) (struct sk_buff *skb,
 				       struct xfrm_state *x);
 	void	(*xdo_dev_state_advance_esn) (struct xfrm_state *x);
-	void	(*xdo_dev_state_update_curlft) (struct xfrm_state *x);
+	void	(*xdo_dev_state_update_stats) (struct xfrm_state *x);
 	int	(*xdo_dev_policy_add) (struct xfrm_policy *x, struct netlink_ext_ack *extack);
 	void	(*xdo_dev_policy_delete) (struct xfrm_policy *x);
 	void	(*xdo_dev_policy_free) (struct xfrm_policy *x);
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 98d7aa78adda..1b86409d79bb 100644
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
2.41.0


