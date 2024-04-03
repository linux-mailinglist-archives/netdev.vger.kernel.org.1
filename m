Return-Path: <netdev+bounces-84302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5234896725
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 09:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B71A28BBFE
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 07:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F395C8E2;
	Wed,  3 Apr 2024 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MHCOfqP9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CB25D744
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 07:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130626; cv=none; b=mbgUX++wcXM7Vug3U4C67jQMK71gf97ZXpeFf2gjVuscSv5DXktyiBo4DP3rwPFjGUygt/VJB8pM8HRlEdwgN1b+Ulo2vPJNt+OsKvfDvju5bcZICLb2zqlSsRLKoszOwP/lCfZKFjbTVxsNS6HY8lG/LalHnilmQzsJgsvjfDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130626; c=relaxed/simple;
	bh=0CwH9kypiKAJH259pQBAVkeaXJDml4UZAJN3hYYGIAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HaFM1+5Es4Fi6YaDV4ObSFXeUfeVs5lOsoTYOu0RXKBjygm7QCbjlIrfdP2A/kkLZbwEVXa28oGLicVY2qLEoBS4mlMGZd1oazdz0oG4bQkqeZ9Fgak8IdbYAeUaxgVKfksQByycBZx5fMSzHr/XjnzHfREIAJOlw3HIfwgTX/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MHCOfqP9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712130624; x=1743666624;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0CwH9kypiKAJH259pQBAVkeaXJDml4UZAJN3hYYGIAc=;
  b=MHCOfqP9C0GsQvsgnmEQf1YztkGlIsGTIf2O3oebUg7X8Ilk3nxMKmxK
   y0gNIQw0rqFGOg5ZC3PEE4RBMzW/xFwa7pDtqhbGSaitW1ZOJ7J0Xmff5
   HcJGjgR4RKxYRvTYjTReXW+xfhty55jltyXAya/iCCNMyoHpEgsjOBvVr
   aiNgmzNvAoJb0ZXg35/PXJHBjyi0PR0sg27onJ5W7lJs6e6lzmdGwlGAN
   +6g2pUpwG1SAS437bSGvc2si0kcmnEAScFRVGMXc5Odn+UXn3DZdMGp8g
   /4oh8hZG+BjcRjoXjzGL+yP3AStyUgSgnT2uW3HEd5aFvVAYrgaeqac+0
   w==;
X-CSE-ConnectionGUID: ctbGRmEyQ9iOHYWDTrBsUA==
X-CSE-MsgGUID: j07V3KueTBezLwB4ihuQfA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="10311879"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="10311879"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 00:50:24 -0700
X-CSE-ConnectionGUID: kKCKm/nLQFe0vKye5DYV6A==
X-CSE-MsgGUID: sW9Cnzb4T+GGoIi1Z9u8ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="55790901"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 03 Apr 2024 00:50:19 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 6A6D3369EA;
	Wed,  3 Apr 2024 08:50:17 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	kuba@kernel.org,
	jiri@resnulli.us,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	andrew@lunn.ch,
	victor.raj@intel.com,
	michal.wilczynski@intel.com,
	lukasz.czapnik@intel.com,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [Intel-wired-lan] [PATCH net-next v9 1/6] devlink: extend devlink_param *set pointer
Date: Wed,  3 Apr 2024 03:41:07 -0400
Message-Id: <20240403074112.7758-2-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20240403074112.7758-1-mateusz.polchlopek@intel.com>
References: <20240403074112.7758-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend devlink_param *set function pointer to take extack as a param.
Sometimes it is needed to pass information to the end user from set
function. It is more proper to use for that netlink instead of passing
message to dmesg.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 drivers/crypto/marvell/octeontx2/otx2_cpt_devlink.c  |  9 ++++++---
 drivers/net/ethernet/amd/pds_core/core.h             |  3 ++-
 drivers/net/ethernet/amd/pds_core/devlink.c          |  3 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c    |  6 ++++--
 drivers/net/ethernet/intel/ice/devlink/devlink.c     | 12 ++++++------
 .../net/ethernet/marvell/octeontx2/af/rvu_devlink.c  | 12 ++++++++----
 .../ethernet/marvell/octeontx2/nic/otx2_devlink.c    |  3 ++-
 drivers/net/ethernet/mellanox/mlx4/main.c            |  6 ++++--
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c    |  3 ++-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c   |  3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c    |  3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c   |  3 ++-
 .../net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c  |  3 ++-
 drivers/net/ethernet/netronome/nfp/devlink_param.c   |  3 ++-
 drivers/net/ethernet/qlogic/qed/qed_devlink.c        |  3 ++-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c             |  3 ++-
 drivers/net/ethernet/ti/cpsw_new.c                   |  6 ++++--
 drivers/net/wwan/iosm/iosm_ipc_devlink.c             |  3 ++-
 include/net/devlink.h                                |  3 ++-
 include/net/dsa.h                                    |  3 ++-
 net/devlink/param.c                                  |  7 ++++---
 net/dsa/devlink.c                                    |  3 ++-
 22 files changed, 66 insertions(+), 37 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cpt_devlink.c b/drivers/crypto/marvell/octeontx2/otx2_cpt_devlink.c
index d2b8d26db968..215a1a8ba7e9 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cpt_devlink.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cpt_devlink.c
@@ -4,7 +4,8 @@
 #include "otx2_cpt_devlink.h"
 
 static int otx2_cpt_dl_egrp_create(struct devlink *dl, u32 id,
-				   struct devlink_param_gset_ctx *ctx)
+				   struct devlink_param_gset_ctx *ctx,
+				   struct netlink_ext_ack *extack)
 {
 	struct otx2_cpt_devlink *cpt_dl = devlink_priv(dl);
 	struct otx2_cptpf_dev *cptpf = cpt_dl->cptpf;
@@ -13,7 +14,8 @@ static int otx2_cpt_dl_egrp_create(struct devlink *dl, u32 id,
 }
 
 static int otx2_cpt_dl_egrp_delete(struct devlink *dl, u32 id,
-				   struct devlink_param_gset_ctx *ctx)
+				   struct devlink_param_gset_ctx *ctx,
+				   struct netlink_ext_ack *extack)
 {
 	struct otx2_cpt_devlink *cpt_dl = devlink_priv(dl);
 	struct otx2_cptpf_dev *cptpf = cpt_dl->cptpf;
@@ -45,7 +47,8 @@ static int otx2_cpt_dl_t106_mode_get(struct devlink *dl, u32 id,
 }
 
 static int otx2_cpt_dl_t106_mode_set(struct devlink *dl, u32 id,
-				     struct devlink_param_gset_ctx *ctx)
+				     struct devlink_param_gset_ctx *ctx,
+				     struct netlink_ext_ack *extack)
 {
 	struct otx2_cpt_devlink *cpt_dl = devlink_priv(dl);
 	struct otx2_cptpf_dev *cptpf = cpt_dl->cptpf;
diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
index 92d7657dd614..f9c44c5cac55 100644
--- a/drivers/net/ethernet/amd/pds_core/core.h
+++ b/drivers/net/ethernet/amd/pds_core/core.h
@@ -255,7 +255,8 @@ int pdsc_dl_flash_update(struct devlink *dl,
 int pdsc_dl_enable_get(struct devlink *dl, u32 id,
 		       struct devlink_param_gset_ctx *ctx);
 int pdsc_dl_enable_set(struct devlink *dl, u32 id,
-		       struct devlink_param_gset_ctx *ctx);
+		       struct devlink_param_gset_ctx *ctx,
+		       struct netlink_ext_ack *extack);
 int pdsc_dl_enable_validate(struct devlink *dl, u32 id,
 			    union devlink_param_value val,
 			    struct netlink_ext_ack *extack);
diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index 54864f27c87a..2681889162a2 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -37,7 +37,8 @@ int pdsc_dl_enable_get(struct devlink *dl, u32 id,
 }
 
 int pdsc_dl_enable_set(struct devlink *dl, u32 id,
-		       struct devlink_param_gset_ctx *ctx)
+		       struct devlink_param_gset_ctx *ctx,
+		       struct netlink_ext_ack *extack)
 {
 	struct pdsc *pdsc = devlink_priv(dl);
 	struct pdsc_viftype *vt_entry;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index ae4529c043f0..d9ea6fa23923 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -1096,7 +1096,8 @@ static int bnxt_dl_nvm_param_get(struct devlink *dl, u32 id,
 }
 
 static int bnxt_dl_nvm_param_set(struct devlink *dl, u32 id,
-				 struct devlink_param_gset_ctx *ctx)
+				 struct devlink_param_gset_ctx *ctx,
+				 struct netlink_ext_ack *extack)
 {
 	struct bnxt *bp = bnxt_get_bp_from_dl(dl);
 	struct hwrm_nvm_set_variable_input *req;
@@ -1145,7 +1146,8 @@ static int bnxt_remote_dev_reset_get(struct devlink *dl, u32 id,
 }
 
 static int bnxt_remote_dev_reset_set(struct devlink *dl, u32 id,
-				     struct devlink_param_gset_ctx *ctx)
+				     struct devlink_param_gset_ctx *ctx,
+				     struct netlink_ext_ack *extack)
 {
 	struct bnxt *bp = bnxt_get_bp_from_dl(dl);
 	int rc;
diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
index be9244bb8bbc..acbace240977 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
@@ -1144,9 +1144,9 @@ ice_devlink_enable_roce_get(struct devlink *devlink, u32 id,
 	return 0;
 }
 
-static int
-ice_devlink_enable_roce_set(struct devlink *devlink, u32 id,
-			    struct devlink_param_gset_ctx *ctx)
+static int ice_devlink_enable_roce_set(struct devlink *devlink, u32 id,
+				       struct devlink_param_gset_ctx *ctx,
+				       struct netlink_ext_ack *extack)
 {
 	struct ice_pf *pf = devlink_priv(devlink);
 	bool roce_ena = ctx->val.vbool;
@@ -1195,9 +1195,9 @@ ice_devlink_enable_iw_get(struct devlink *devlink, u32 id,
 	return 0;
 }
 
-static int
-ice_devlink_enable_iw_set(struct devlink *devlink, u32 id,
-			  struct devlink_param_gset_ctx *ctx)
+static int ice_devlink_enable_iw_set(struct devlink *devlink, u32 id,
+				     struct devlink_param_gset_ctx *ctx,
+				     struct netlink_ext_ack *extack)
 {
 	struct ice_pf *pf = devlink_priv(devlink);
 	bool iw_ena = ctx->val.vbool;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index 96c04f7d93f8..7498ab429963 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -1202,7 +1202,8 @@ static int rvu_af_dl_dwrr_mtu_validate(struct devlink *devlink, u32 id,
 }
 
 static int rvu_af_dl_dwrr_mtu_set(struct devlink *devlink, u32 id,
-				  struct devlink_param_gset_ctx *ctx)
+				  struct devlink_param_gset_ctx *ctx,
+				  struct netlink_ext_ack *extack)
 {
 	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
 	struct rvu *rvu = rvu_dl->rvu;
@@ -1256,7 +1257,8 @@ static int rvu_af_npc_exact_feature_get(struct devlink *devlink, u32 id,
 }
 
 static int rvu_af_npc_exact_feature_disable(struct devlink *devlink, u32 id,
-					    struct devlink_param_gset_ctx *ctx)
+					    struct devlink_param_gset_ctx *ctx,
+					    struct netlink_ext_ack *extack)
 {
 	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
 	struct rvu *rvu = rvu_dl->rvu;
@@ -1310,7 +1312,8 @@ static int rvu_af_dl_npc_mcam_high_zone_percent_get(struct devlink *devlink, u32
 }
 
 static int rvu_af_dl_npc_mcam_high_zone_percent_set(struct devlink *devlink, u32 id,
-						    struct devlink_param_gset_ctx *ctx)
+						    struct devlink_param_gset_ctx *ctx,
+						    struct netlink_ext_ack *extack)
 {
 	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
 	struct rvu *rvu = rvu_dl->rvu;
@@ -1367,7 +1370,8 @@ static int rvu_af_dl_nix_maxlf_get(struct devlink *devlink, u32 id,
 }
 
 static int rvu_af_dl_nix_maxlf_set(struct devlink *devlink, u32 id,
-				   struct devlink_param_gset_ctx *ctx)
+				   struct devlink_param_gset_ctx *ctx,
+				   struct netlink_ext_ack *extack)
 {
 	struct rvu_devlink *rvu_dl = devlink_priv(devlink);
 	struct rvu *rvu = rvu_dl->rvu;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
index 4e1130496573..99ddf31269d9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_devlink.c
@@ -32,7 +32,8 @@ static int otx2_dl_mcam_count_validate(struct devlink *devlink, u32 id,
 }
 
 static int otx2_dl_mcam_count_set(struct devlink *devlink, u32 id,
-				  struct devlink_param_gset_ctx *ctx)
+				  struct devlink_param_gset_ctx *ctx,
+				  struct netlink_ext_ack *extack)
 {
 	struct otx2_devlink *otx2_dl = devlink_priv(devlink);
 	struct otx2_nic *pfvf = otx2_dl->pfvf;
diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
index 7b02ff61126d..98688e4dbec5 100644
--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -185,7 +185,8 @@ static int mlx4_devlink_ierr_reset_get(struct devlink *devlink, u32 id,
 }
 
 static int mlx4_devlink_ierr_reset_set(struct devlink *devlink, u32 id,
-				       struct devlink_param_gset_ctx *ctx)
+				       struct devlink_param_gset_ctx *ctx,
+				       struct netlink_ext_ack *extack)
 {
 	mlx4_internal_err_reset = ctx->val.vbool;
 	return 0;
@@ -202,7 +203,8 @@ static int mlx4_devlink_crdump_snapshot_get(struct devlink *devlink, u32 id,
 }
 
 static int mlx4_devlink_crdump_snapshot_set(struct devlink *devlink, u32 id,
-					    struct devlink_param_gset_ctx *ctx)
+					    struct devlink_param_gset_ctx *ctx,
+					    struct netlink_ext_ack *extack)
 {
 	struct mlx4_priv *priv = devlink_priv(devlink);
 	struct mlx4_dev *dev = &priv->dev;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 3047d7015c52..a86f9c335b6b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1805,7 +1805,8 @@ static int mlx5_esw_vports_init(struct mlx5_eswitch *esw)
 }
 
 static int mlx5_devlink_esw_multiport_set(struct devlink *devlink, u32 id,
-					  struct devlink_param_gset_ctx *ctx)
+					  struct devlink_param_gset_ctx *ctx,
+					  struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index baaae628b0a0..51056fe454d4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2410,7 +2410,8 @@ static int esw_offloads_init_reps(struct mlx5_eswitch *esw)
 }
 
 static int esw_port_metadata_set(struct devlink *devlink, u32 id,
-				 struct devlink_param_gset_ctx *ctx)
+				 struct devlink_param_gset_ctx *ctx,
+				 struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
 	struct mlx5_eswitch *esw = dev->priv.eswitch;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index e6bfa7e4f146..8a941c0b4497 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3321,7 +3321,8 @@ static int mlx5_fs_mode_validate(struct devlink *devlink, u32 id,
 }
 
 static int mlx5_fs_mode_set(struct devlink *devlink, u32 id,
-			    struct devlink_param_gset_ctx *ctx)
+			    struct devlink_param_gset_ctx *ctx,
+			    struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
 	enum mlx5_flow_steering_mode mode;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 2911aa34a5be..979c49ae6b5c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -52,7 +52,8 @@ static void mlx5_set_fw_rst_ack(struct mlx5_core_dev *dev)
 }
 
 static int mlx5_fw_reset_enable_remote_dev_reset_set(struct devlink *devlink, u32 id,
-						     struct devlink_param_gset_ctx *ctx)
+						     struct devlink_param_gset_ctx *ctx,
+						     struct netlink_ext_ack *extack)
 {
 	struct mlx5_core_dev *dev = devlink_priv(devlink);
 	struct mlx5_fw_reset *fw_reset;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
index f20052776b3f..baedf0d45e85 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -1465,7 +1465,8 @@ mlxsw_sp_acl_tcam_region_rehash_intrvl_get(struct devlink *devlink, u32 id,
 
 static int
 mlxsw_sp_acl_tcam_region_rehash_intrvl_set(struct devlink *devlink, u32 id,
-					   struct devlink_param_gset_ctx *ctx)
+					   struct devlink_param_gset_ctx *ctx,
+					   struct netlink_ext_ack *extack)
 {
 	struct mlxsw_core *mlxsw_core = devlink_priv(devlink);
 	struct mlxsw_sp_acl_tcam_vregion *vregion;
diff --git a/drivers/net/ethernet/netronome/nfp/devlink_param.c b/drivers/net/ethernet/netronome/nfp/devlink_param.c
index a655f9e69a7b..0e1a3800f371 100644
--- a/drivers/net/ethernet/netronome/nfp/devlink_param.c
+++ b/drivers/net/ethernet/netronome/nfp/devlink_param.c
@@ -132,7 +132,8 @@ nfp_devlink_param_u8_get(struct devlink *devlink, u32 id,
 
 static int
 nfp_devlink_param_u8_set(struct devlink *devlink, u32 id,
-			 struct devlink_param_gset_ctx *ctx)
+			 struct devlink_param_gset_ctx *ctx,
+			 struct netlink_ext_ack *extack)
 {
 	const struct nfp_devlink_param_u8_arg *arg;
 	struct nfp_pf *pf = devlink_priv(devlink);
diff --git a/drivers/net/ethernet/qlogic/qed/qed_devlink.c b/drivers/net/ethernet/qlogic/qed/qed_devlink.c
index dad8e617c393..1adc7fbb3f2f 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_devlink.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_devlink.c
@@ -132,7 +132,8 @@ static int qed_dl_param_get(struct devlink *dl, u32 id,
 }
 
 static int qed_dl_param_set(struct devlink *dl, u32 id,
-			    struct devlink_param_gset_ctx *ctx)
+			    struct devlink_param_gset_ctx *ctx,
+			    struct netlink_ext_ack *extack)
 {
 	struct qed_devlink *qed_dl = devlink_priv(dl);
 	struct qed_dev *cdev;
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 2939a21ca74f..2e59319056a7 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2588,7 +2588,8 @@ static void am65_cpsw_init_port_switch_ale(struct am65_cpsw_port *port)
 }
 
 static int am65_cpsw_dl_switch_mode_set(struct devlink *dl, u32 id,
-					struct devlink_param_gset_ctx *ctx)
+					struct devlink_param_gset_ctx *ctx,
+					struct netlink_ext_ack *extack)
 {
 	struct am65_cpsw_devlink *dl_priv = devlink_priv(dl);
 	struct am65_cpsw_common *cpsw = dl_priv->common;
diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 087dcb67505a..2baa198ebfa0 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -1625,7 +1625,8 @@ static int cpsw_dl_switch_mode_get(struct devlink *dl, u32 id,
 }
 
 static int cpsw_dl_switch_mode_set(struct devlink *dl, u32 id,
-				   struct devlink_param_gset_ctx *ctx)
+				   struct devlink_param_gset_ctx *ctx,
+				   struct netlink_ext_ack *extack)
 {
 	struct cpsw_devlink *dl_priv = devlink_priv(dl);
 	struct cpsw_common *cpsw = dl_priv->cpsw;
@@ -1762,7 +1763,8 @@ static int cpsw_dl_ale_ctrl_get(struct devlink *dl, u32 id,
 }
 
 static int cpsw_dl_ale_ctrl_set(struct devlink *dl, u32 id,
-				struct devlink_param_gset_ctx *ctx)
+				struct devlink_param_gset_ctx *ctx,
+				struct netlink_ext_ack *extack)
 {
 	struct cpsw_devlink *dl_priv = devlink_priv(dl);
 	struct cpsw_common *cpsw = dl_priv->cpsw;
diff --git a/drivers/net/wwan/iosm/iosm_ipc_devlink.c b/drivers/net/wwan/iosm/iosm_ipc_devlink.c
index 2fe724d623c0..bef6819986e9 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_devlink.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_devlink.c
@@ -33,7 +33,8 @@ static int ipc_devlink_get_param(struct devlink *dl, u32 id,
 
 /* Set the param values for the specific param ID's */
 static int ipc_devlink_set_param(struct devlink *dl, u32 id,
-				 struct devlink_param_gset_ctx *ctx)
+				 struct devlink_param_gset_ctx *ctx,
+				 struct netlink_ext_ack *extack)
 {
 	struct iosm_devlink *ipc_devlink = devlink_priv(dl);
 
diff --git a/include/net/devlink.h b/include/net/devlink.h
index 9ac394bdfbe4..12f14be44e53 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -483,7 +483,8 @@ struct devlink_param {
 	int (*get)(struct devlink *devlink, u32 id,
 		   struct devlink_param_gset_ctx *ctx);
 	int (*set)(struct devlink *devlink, u32 id,
-		   struct devlink_param_gset_ctx *ctx);
+		   struct devlink_param_gset_ctx *ctx,
+		   struct netlink_ext_ack *extack);
 	int (*validate)(struct devlink *devlink, u32 id,
 			union devlink_param_value val,
 			struct netlink_ext_ack *extack);
diff --git a/include/net/dsa.h b/include/net/dsa.h
index 7c0da9effe4e..140b80e1a88c 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -1247,7 +1247,8 @@ struct dsa_switch_ops {
 int dsa_devlink_param_get(struct devlink *dl, u32 id,
 			  struct devlink_param_gset_ctx *ctx);
 int dsa_devlink_param_set(struct devlink *dl, u32 id,
-			  struct devlink_param_gset_ctx *ctx);
+			  struct devlink_param_gset_ctx *ctx,
+			  struct netlink_ext_ack *extack);
 int dsa_devlink_params_register(struct dsa_switch *ds,
 				const struct devlink_param *params,
 				size_t params_count);
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 22bc3b500518..dcf0d1ccebba 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -158,11 +158,12 @@ static int devlink_param_get(struct devlink *devlink,
 
 static int devlink_param_set(struct devlink *devlink,
 			     const struct devlink_param *param,
-			     struct devlink_param_gset_ctx *ctx)
+			     struct devlink_param_gset_ctx *ctx,
+			     struct netlink_ext_ack *extack)
 {
 	if (!param->set)
 		return -EOPNOTSUPP;
-	return param->set(devlink, param->id, ctx);
+	return param->set(devlink, param->id, ctx, extack);
 }
 
 static int
@@ -571,7 +572,7 @@ static int __devlink_nl_cmd_param_set_doit(struct devlink *devlink,
 			return -EOPNOTSUPP;
 		ctx.val = value;
 		ctx.cmode = cmode;
-		err = devlink_param_set(devlink, param, &ctx);
+		err = devlink_param_set(devlink, param, &ctx, info->extack);
 		if (err)
 			return err;
 	}
diff --git a/net/dsa/devlink.c b/net/dsa/devlink.c
index 431bf52290a1..0aac887d0098 100644
--- a/net/dsa/devlink.c
+++ b/net/dsa/devlink.c
@@ -194,7 +194,8 @@ int dsa_devlink_param_get(struct devlink *dl, u32 id,
 EXPORT_SYMBOL_GPL(dsa_devlink_param_get);
 
 int dsa_devlink_param_set(struct devlink *dl, u32 id,
-			  struct devlink_param_gset_ctx *ctx)
+			  struct devlink_param_gset_ctx *ctx,
+			  struct netlink_ext_ack *extack)
 {
 	struct dsa_switch *ds = dsa_devlink_to_ds(dl);
 
-- 
2.38.1


