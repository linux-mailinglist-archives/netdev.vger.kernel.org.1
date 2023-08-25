Return-Path: <netdev+bounces-30556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 213B5787FF0
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 08:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFFE7281740
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 06:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DFC28917;
	Fri, 25 Aug 2023 06:30:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501775247
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 06:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACE2C433CB;
	Fri, 25 Aug 2023 06:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692945001;
	bh=4120ySJRCMaepaIP6aKv/o4XxhFEMCZxAOJcHYfvrSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DJbSQmx58/C5xK+P7vcBD0wDKSZJO25Puprm72C7jnrmV+dGSvNBsqnTL5bdrOH7x
	 iSRxaquFAGKONruIyXXNYCvxEcQxUF4VPbMLOOXPNTWNC/37OnWUGs9DqifGj1UANi
	 3NJC8KU8CEVU1imJwGms6CE5rjkyCJMklqcY09OKm0ViVKY4a8yjjurufHgHwLm2Zw
	 +KKuzXjRpKKEG6zDDhXDtuKXfK6HbnpE1Ua2XJtUzS0iTRlUmznMEyyPC/gudzBze6
	 NSUw5lP+Ecf6ZRhhNhZURaXc+dRbnEa71mD43+kJuZgn+xBJ0AwS0IQ2IVXki373Bs
	 HgosP7me5q/Bw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net-next V4 6/8] net/mlx5: Provide an interface to block change of IPsec capabilities
Date: Thu, 24 Aug 2023 23:28:34 -0700
Message-ID: <20230825062836.103744-7-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825062836.103744-1-saeed@kernel.org>
References: <20230825062836.103744-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

mlx5 HW can't perform IPsec offload operation simultaneously both on PF
and VFs at the same time. While the previous patches added devlink knobs
to change IPsec capabilities dynamically, there is a need to add a logic
to block such IPsec capabilities for the cases when IPsec is already
configured.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec.c       | 20 +++++++++++-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 32 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  9 ++++++
 include/linux/mlx5/driver.h                   |  1 +
 4 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 3b88a8bb7082..7d4ceb9b9c16 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -38,6 +38,7 @@
 #include <net/netevent.h>
 
 #include "en.h"
+#include "eswitch.h"
 #include "ipsec.h"
 #include "ipsec_rxtx.h"
 #include "en_rep.h"
@@ -670,6 +671,11 @@ static int mlx5e_xfrm_add_state(struct xfrm_state *x,
 	if (err)
 		goto err_xfrm;
 
+	if (!mlx5_eswitch_block_ipsec(priv->mdev)) {
+		err = -EBUSY;
+		goto err_xfrm;
+	}
+
 	/* check esn */
 	if (x->props.flags & XFRM_STATE_ESN)
 		mlx5e_ipsec_update_esn_state(sa_entry);
@@ -678,7 +684,7 @@ static int mlx5e_xfrm_add_state(struct xfrm_state *x,
 
 	err = mlx5_ipsec_create_work(sa_entry);
 	if (err)
-		goto err_xfrm;
+		goto unblock_ipsec;
 
 	err = mlx5e_ipsec_create_dwork(sa_entry);
 	if (err)
@@ -735,6 +741,8 @@ static int mlx5e_xfrm_add_state(struct xfrm_state *x,
 	if (sa_entry->work)
 		kfree(sa_entry->work->data);
 	kfree(sa_entry->work);
+unblock_ipsec:
+	mlx5_eswitch_unblock_ipsec(priv->mdev);
 err_xfrm:
 	kfree(sa_entry);
 	NL_SET_ERR_MSG_WEAK_MOD(extack, "Device failed to offload this state");
@@ -764,6 +772,7 @@ static void mlx5e_xfrm_del_state(struct xfrm_state *x)
 static void mlx5e_xfrm_free_state(struct xfrm_state *x)
 {
 	struct mlx5e_ipsec_sa_entry *sa_entry = to_ipsec_sa_entry(x);
+	struct mlx5e_ipsec *ipsec = sa_entry->ipsec;
 
 	if (x->xso.flags & XFRM_DEV_OFFLOAD_FLAG_ACQ)
 		goto sa_entry_free;
@@ -780,6 +789,7 @@ static void mlx5e_xfrm_free_state(struct xfrm_state *x)
 	if (sa_entry->work)
 		kfree(sa_entry->work->data);
 	kfree(sa_entry->work);
+	mlx5_eswitch_unblock_ipsec(ipsec->mdev);
 sa_entry_free:
 	kfree(sa_entry);
 }
@@ -1055,6 +1065,11 @@ static int mlx5e_xfrm_add_policy(struct xfrm_policy *x,
 	pol_entry->x = x;
 	pol_entry->ipsec = priv->ipsec;
 
+	if (!mlx5_eswitch_block_ipsec(priv->mdev)) {
+		err = -EBUSY;
+		goto ipsec_busy;
+	}
+
 	mlx5e_ipsec_build_accel_pol_attrs(pol_entry, &pol_entry->attrs);
 	err = mlx5e_accel_ipsec_fs_add_pol(pol_entry);
 	if (err)
@@ -1064,6 +1079,8 @@ static int mlx5e_xfrm_add_policy(struct xfrm_policy *x,
 	return 0;
 
 err_fs:
+	mlx5_eswitch_unblock_ipsec(priv->mdev);
+ipsec_busy:
 	kfree(pol_entry);
 	NL_SET_ERR_MSG_MOD(extack, "Device failed to offload this policy");
 	return err;
@@ -1074,6 +1091,7 @@ static void mlx5e_xfrm_del_policy(struct xfrm_policy *x)
 	struct mlx5e_ipsec_pol_entry *pol_entry = to_ipsec_pol_entry(x);
 
 	mlx5e_accel_ipsec_fs_del_pol(pol_entry);
+	mlx5_eswitch_unblock_ipsec(pol_entry->ipsec->mdev);
 }
 
 static void mlx5e_xfrm_free_policy(struct xfrm_policy *x)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index db1c2a076364..38a149dd479f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -48,6 +48,7 @@
 #include "devlink.h"
 #include "ecpf.h"
 #include "en/mod_hdr.h"
+#include "en_accel/ipsec.h"
 
 enum {
 	MLX5_ACTION_NONE = 0,
@@ -2336,3 +2337,34 @@ struct mlx5_core_dev *mlx5_eswitch_get_core_dev(struct mlx5_eswitch *esw)
 	return mlx5_esw_allowed(esw) ? esw->dev : NULL;
 }
 EXPORT_SYMBOL(mlx5_eswitch_get_core_dev);
+
+bool mlx5_eswitch_block_ipsec(struct mlx5_core_dev *dev)
+{
+	struct mlx5_eswitch *esw = dev->priv.eswitch;
+
+	if (!mlx5_esw_allowed(esw))
+		return true;
+
+	mutex_lock(&esw->state_lock);
+	if (esw->enabled_ipsec_vf_count) {
+		mutex_unlock(&esw->state_lock);
+		return false;
+	}
+
+	dev->num_ipsec_offloads++;
+	mutex_unlock(&esw->state_lock);
+	return true;
+}
+
+void mlx5_eswitch_unblock_ipsec(struct mlx5_core_dev *dev)
+{
+	struct mlx5_eswitch *esw = dev->priv.eswitch;
+
+	if (!mlx5_esw_allowed(esw))
+		/* Failure means no eswitch => core dev is not a PF */
+		return;
+
+	mutex_lock(&esw->state_lock);
+	dev->num_ipsec_offloads--;
+	mutex_unlock(&esw->state_lock);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index ed3abcd70c46..0e51fd066fcc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -380,6 +380,7 @@ struct mlx5_eswitch {
 	struct blocking_notifier_head n_head;
 	struct xarray paired;
 	struct mlx5_devcom_comp_dev *devcom;
+	u16 enabled_ipsec_vf_count;
 };
 
 void esw_offloads_disable(struct mlx5_eswitch *esw);
@@ -855,6 +856,8 @@ mlx5_eswitch_get_slow_fdb(struct mlx5_eswitch *esw)
 
 int mlx5_eswitch_restore_ipsec_rule(struct mlx5_eswitch *esw, struct mlx5_flow_handle *rule,
 				    struct mlx5_esw_flow_attr *esw_attr, int attr_idx);
+bool mlx5_eswitch_block_ipsec(struct mlx5_core_dev *dev);
+void mlx5_eswitch_unblock_ipsec(struct mlx5_core_dev *dev);
 #else  /* CONFIG_MLX5_ESWITCH */
 /* eswitch API stubs */
 static inline int  mlx5_eswitch_init(struct mlx5_core_dev *dev) { return 0; }
@@ -916,6 +919,12 @@ static inline void mlx5_eswitch_unblock_encap(struct mlx5_core_dev *dev)
 
 static inline int mlx5_eswitch_block_mode(struct mlx5_core_dev *dev) { return 0; }
 static inline void mlx5_eswitch_unblock_mode(struct mlx5_core_dev *dev) {}
+static inline bool mlx5_eswitch_block_ipsec(struct mlx5_core_dev *dev)
+{
+	return false;
+}
+
+static inline void mlx5_eswitch_unblock_ipsec(struct mlx5_core_dev *dev) {}
 #endif /* CONFIG_MLX5_ESWITCH */
 
 #endif /* __MLX5_ESWITCH_H__ */
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index e95f10066eac..3033bbaeac81 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -813,6 +813,7 @@ struct mlx5_core_dev {
 	/* MACsec notifier chain to sync MACsec core and IB database */
 	struct blocking_notifier_head macsec_nh;
 #endif
+	u64 num_ipsec_offloads;
 };
 
 struct mlx5_db {
-- 
2.41.0


