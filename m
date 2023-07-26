Return-Path: <netdev+bounces-21635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91CF76413C
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DDBA2810CF
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848EA1C9E9;
	Wed, 26 Jul 2023 21:32:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAD81AA8E
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:32:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED1CC43215;
	Wed, 26 Jul 2023 21:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690407136;
	bh=2IXGjJj8W46P+3FtXe/av+YqSs8rAyM48JY1/NaVM4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oc5gMWMqDj/ntgyiDBsJSJ00uYpBk6ggewf3aOQGjTNAxFBARCutf5RLmjnRQSQeL
	 hBAaWoEo6b11K3tiv9DJLRuRpE+2QW2Sp68IFadmDsI7m38njeOAxMQwaltVsZKMLm
	 LRyqWDNuCWYB/SkhOncfYJwK0lI8tDZZbyBJIfhyw8pgsapI7wAhJf5WlpUhdztz0D
	 rqrlI3bD9kbuMiocPFgvp2wZ6sAMBV4/HOkELvZUr9FeaE9lAp4UaR8jIncBK9ejZ0
	 FbmxKMuJiXi8EnL4RF0QHuhYJY9kvGDbSXTPBGN2Ik9G76Yaa6HJR/aZjp+IvQS5FX
	 rTfj2kwyfvw4A==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Vlad Buslov <vladbu@nvidia.com>
Subject: [net 08/15] net/mlx5e: Move representor neigh cleanup to profile cleanup_tx
Date: Wed, 26 Jul 2023 14:31:59 -0700
Message-ID: <20230726213206.47022-9-saeed@kernel.org>
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

From: Jianbo Liu <jianbol@nvidia.com>

For IP tunnel encapsulation in ECMP (Equal-Cost Multipath) mode, as
the flow is duplicated to the peer eswitch, the related neighbour
information on the peer uplink representor is created as well.

In the cited commit, eswitch devcom unpair is moved to uplink unload
API, specifically the profile->cleanup_tx. If there is a encap rule
offloaded in ECMP mode, when one eswitch does unpair (because of
unloading the driver, for instance), and the peer rule from the peer
eswitch is going to be deleted, the use-after-free error is triggered
while accessing neigh info, as it is already cleaned up in uplink's
profile->disable, which is before its profile->cleanup_tx.

To fix this issue, move the neigh cleanup to profile's cleanup_tx
callback, and after mlx5e_cleanup_uplink_rep_tx is called. The neigh
init is moved to init_tx for symmeter.

[ 2453.376299] BUG: KASAN: slab-use-after-free in mlx5e_rep_neigh_entry_release+0x109/0x3a0 [mlx5_core]
[ 2453.379125] Read of size 4 at addr ffff888127af9008 by task modprobe/2496

[ 2453.381542] CPU: 7 PID: 2496 Comm: modprobe Tainted: G    B              6.4.0-rc7+ #15
[ 2453.383386] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[ 2453.384335] Call Trace:
[ 2453.384625]  <TASK>
[ 2453.384891]  dump_stack_lvl+0x33/0x50
[ 2453.385285]  print_report+0xc2/0x610
[ 2453.385667]  ? __virt_addr_valid+0xb1/0x130
[ 2453.386091]  ? mlx5e_rep_neigh_entry_release+0x109/0x3a0 [mlx5_core]
[ 2453.386757]  kasan_report+0xae/0xe0
[ 2453.387123]  ? mlx5e_rep_neigh_entry_release+0x109/0x3a0 [mlx5_core]
[ 2453.387798]  mlx5e_rep_neigh_entry_release+0x109/0x3a0 [mlx5_core]
[ 2453.388465]  mlx5e_rep_encap_entry_detach+0xa6/0xe0 [mlx5_core]
[ 2453.389111]  mlx5e_encap_dealloc+0xa7/0x100 [mlx5_core]
[ 2453.389706]  mlx5e_tc_tun_encap_dests_unset+0x61/0xb0 [mlx5_core]
[ 2453.390361]  mlx5_free_flow_attr_actions+0x11e/0x340 [mlx5_core]
[ 2453.391015]  ? complete_all+0x43/0xd0
[ 2453.391398]  ? free_flow_post_acts+0x38/0x120 [mlx5_core]
[ 2453.392004]  mlx5e_tc_del_fdb_flow+0x4ae/0x690 [mlx5_core]
[ 2453.392618]  mlx5e_tc_del_fdb_peers_flow+0x308/0x370 [mlx5_core]
[ 2453.393276]  mlx5e_tc_clean_fdb_peer_flows+0xf5/0x140 [mlx5_core]
[ 2453.393925]  mlx5_esw_offloads_unpair+0x86/0x540 [mlx5_core]
[ 2453.394546]  ? mlx5_esw_offloads_set_ns_peer.isra.0+0x180/0x180 [mlx5_core]
[ 2453.395268]  ? down_write+0xaa/0x100
[ 2453.395652]  mlx5_esw_offloads_devcom_event+0x203/0x530 [mlx5_core]
[ 2453.396317]  mlx5_devcom_send_event+0xbb/0x190 [mlx5_core]
[ 2453.396917]  mlx5_esw_offloads_devcom_cleanup+0xb0/0xd0 [mlx5_core]
[ 2453.397582]  mlx5e_tc_esw_cleanup+0x42/0x120 [mlx5_core]
[ 2453.398182]  mlx5e_rep_tc_cleanup+0x15/0x30 [mlx5_core]
[ 2453.398768]  mlx5e_cleanup_rep_tx+0x6c/0x80 [mlx5_core]
[ 2453.399367]  mlx5e_detach_netdev+0xee/0x120 [mlx5_core]
[ 2453.399957]  mlx5e_netdev_change_profile+0x84/0x170 [mlx5_core]
[ 2453.400598]  mlx5e_vport_rep_unload+0xe0/0xf0 [mlx5_core]
[ 2453.403781]  mlx5_eswitch_unregister_vport_reps+0x15e/0x190 [mlx5_core]
[ 2453.404479]  ? mlx5_eswitch_register_vport_reps+0x200/0x200 [mlx5_core]
[ 2453.405170]  ? up_write+0x39/0x60
[ 2453.405529]  ? kernfs_remove_by_name_ns+0xb7/0xe0
[ 2453.405985]  auxiliary_bus_remove+0x2e/0x40
[ 2453.406405]  device_release_driver_internal+0x243/0x2d0
[ 2453.406900]  ? kobject_put+0x42/0x2d0
[ 2453.407284]  bus_remove_device+0x128/0x1d0
[ 2453.407687]  device_del+0x240/0x550
[ 2453.408053]  ? waiting_for_supplier_show+0xe0/0xe0
[ 2453.408511]  ? kobject_put+0xfa/0x2d0
[ 2453.408889]  ? __kmem_cache_free+0x14d/0x280
[ 2453.409310]  mlx5_rescan_drivers_locked.part.0+0xcd/0x2b0 [mlx5_core]
[ 2453.409973]  mlx5_unregister_device+0x40/0x50 [mlx5_core]
[ 2453.410561]  mlx5_uninit_one+0x3d/0x110 [mlx5_core]
[ 2453.411111]  remove_one+0x89/0x130 [mlx5_core]
[ 2453.411628]  pci_device_remove+0x59/0xf0
[ 2453.412026]  device_release_driver_internal+0x243/0x2d0
[ 2453.412511]  ? parse_option_str+0x14/0x90
[ 2453.412915]  driver_detach+0x7b/0xf0
[ 2453.413289]  bus_remove_driver+0xb5/0x160
[ 2453.413685]  pci_unregister_driver+0x3f/0xf0
[ 2453.414104]  mlx5_cleanup+0xc/0x20 [mlx5_core]

Fixes: 2be5bd42a5bb ("net/mlx5: Handle pairing of E-switch via uplink un/load APIs")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_rep.c    | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 0b265a3f9b76..99b3843396f3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -1160,6 +1160,10 @@ static int mlx5e_init_rep_tx(struct mlx5e_priv *priv)
 		return err;
 	}
 
+	err = mlx5e_rep_neigh_init(rpriv);
+	if (err)
+		goto err_neigh_init;
+
 	if (rpriv->rep->vport == MLX5_VPORT_UPLINK) {
 		err = mlx5e_init_uplink_rep_tx(rpriv);
 		if (err)
@@ -1176,6 +1180,8 @@ static int mlx5e_init_rep_tx(struct mlx5e_priv *priv)
 	if (rpriv->rep->vport == MLX5_VPORT_UPLINK)
 		mlx5e_cleanup_uplink_rep_tx(rpriv);
 err_init_tx:
+	mlx5e_rep_neigh_cleanup(rpriv);
+err_neigh_init:
 	mlx5e_destroy_tises(priv);
 	return err;
 }
@@ -1189,22 +1195,17 @@ static void mlx5e_cleanup_rep_tx(struct mlx5e_priv *priv)
 	if (rpriv->rep->vport == MLX5_VPORT_UPLINK)
 		mlx5e_cleanup_uplink_rep_tx(rpriv);
 
+	mlx5e_rep_neigh_cleanup(rpriv);
 	mlx5e_destroy_tises(priv);
 }
 
 static void mlx5e_rep_enable(struct mlx5e_priv *priv)
 {
-	struct mlx5e_rep_priv *rpriv = priv->ppriv;
-
 	mlx5e_set_netdev_mtu_boundaries(priv);
-	mlx5e_rep_neigh_init(rpriv);
 }
 
 static void mlx5e_rep_disable(struct mlx5e_priv *priv)
 {
-	struct mlx5e_rep_priv *rpriv = priv->ppriv;
-
-	mlx5e_rep_neigh_cleanup(rpriv);
 }
 
 static int mlx5e_update_rep_rx(struct mlx5e_priv *priv)
@@ -1254,7 +1255,6 @@ static int uplink_rep_async_event(struct notifier_block *nb, unsigned long event
 
 static void mlx5e_uplink_rep_enable(struct mlx5e_priv *priv)
 {
-	struct mlx5e_rep_priv *rpriv = priv->ppriv;
 	struct net_device *netdev = priv->netdev;
 	struct mlx5_core_dev *mdev = priv->mdev;
 	u16 max_mtu;
@@ -1276,7 +1276,6 @@ static void mlx5e_uplink_rep_enable(struct mlx5e_priv *priv)
 	mlx5_notifier_register(mdev, &priv->events_nb);
 	mlx5e_dcbnl_initialize(priv);
 	mlx5e_dcbnl_init_app(priv);
-	mlx5e_rep_neigh_init(rpriv);
 	mlx5e_rep_bridge_init(priv);
 
 	netdev->wanted_features |= NETIF_F_HW_TC;
@@ -1291,7 +1290,6 @@ static void mlx5e_uplink_rep_enable(struct mlx5e_priv *priv)
 
 static void mlx5e_uplink_rep_disable(struct mlx5e_priv *priv)
 {
-	struct mlx5e_rep_priv *rpriv = priv->ppriv;
 	struct mlx5_core_dev *mdev = priv->mdev;
 
 	rtnl_lock();
@@ -1301,7 +1299,6 @@ static void mlx5e_uplink_rep_disable(struct mlx5e_priv *priv)
 	rtnl_unlock();
 
 	mlx5e_rep_bridge_cleanup(priv);
-	mlx5e_rep_neigh_cleanup(rpriv);
 	mlx5e_dcbnl_delete_app(priv);
 	mlx5_notifier_unregister(mdev, &priv->events_nb);
 	mlx5e_rep_tc_disable(priv);
-- 
2.41.0


