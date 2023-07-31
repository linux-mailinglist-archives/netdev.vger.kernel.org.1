Return-Path: <netdev+bounces-22793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9914B7694D8
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 13:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB1C41C2042B
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654FA182B5;
	Mon, 31 Jul 2023 11:28:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85868182A1
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E979EC433CB;
	Mon, 31 Jul 2023 11:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690802925;
	bh=NVz4QNUsP0N6AuMjrw/LG61zwTvkEXvbqsXSFN4+kTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z76qcrWMq4ryjzPxvaPvkP4t/jaIfbsCvUHKJfALMidvxhod8UFljA5046LVPBdQk
	 9iP5PCxZ2XMVwlcfmSWxsSSnO1rdHvaWu7x0JIFfZgq6/E5h0rDTkWIG8DNn1W5S0y
	 SpZIcomrWbRJ2nAId20TnlWpbu9udSZvRXLAhDgJFTceLVSyEj9z7rScJcc0/yaL+x
	 oVdbWENDiwj+wRLVCe8bMKmw+/Bit7vE5Una4qI/Pjsqxm5Sm5oz78wI4dJN1VdXSM
	 eugVXxxCOQufdg+om/tG/fdHogNmkLjGDg3S6olBO6aAjCBnQpkAr1enaQzup30yrQ
	 qicEUcz3xKcjw==
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jianbo Liu <jianbol@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next v1 05/13] net/mlx5e: Support IPsec packet offload for RX in switchdev mode
Date: Mon, 31 Jul 2023 14:28:16 +0300
Message-ID: <c91063554cf643fb50b99cf093e8a9bf11729de5.1690802064.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690802064.git.leon@kernel.org>
References: <cover.1690802064.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

As decryption must be done first, add new prio for IPsec offload in
FDB, and put it just lower than BYPASS prio and higher than TC prio.
Three levels are added for RX. The first one is for ip xfrm policy. SA
table is created in the second level for ip xfrm state. The status
table is created in the last to check the decryption result. If
success, packets continue with the next process, or dropped otherwise.
For now, the set of reg c1 is removed for swtichdev mode, and the
datapath process will be added in the next patch.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   4 +
 .../mellanox/mlx5/core/en_accel/ipsec.h       |  41 +++-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    |  80 ++++----
 .../mlx5/core/en_accel/ipsec_offload.c        |   5 +-
 .../mellanox/mlx5/core/esw/ipsec_fs.c         | 184 ++++++++++++++++++
 .../mellanox/mlx5/core/esw/ipsec_fs.h         |  39 ++++
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |   6 +
 include/linux/mlx5/fs.h                       |   1 +
 8 files changed, 313 insertions(+), 47 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 35f00700a4d6..63a2f2bb80a6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -75,6 +75,10 @@ mlx5_core-$(CONFIG_MLX5_ESWITCH)   += esw/acl/helper.o \
 				      esw/acl/egress_lgcy.o esw/acl/egress_ofld.o \
 				      esw/acl/ingress_lgcy.o esw/acl/ingress_ofld.o
 
+ifneq ($(CONFIG_MLX5_EN_IPSEC),)
+	mlx5_core-$(CONFIG_MLX5_ESWITCH)   += esw/ipsec_fs.o
+endif
+
 mlx5_core-$(CONFIG_MLX5_BRIDGE)    += esw/bridge.o esw/bridge_mcast.o esw/bridge_debugfs.o \
 				      en/rep/bridge.o
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
index 03d83cdf1e20..578af9d7aef3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
@@ -143,7 +143,7 @@ struct mlx5e_ipsec_sw_stats {
 	atomic64_t ipsec_tx_drop_trailer;
 };
 
-struct mlx5e_ipsec_rx;
+struct mlx5e_ipsec_fc;
 struct mlx5e_ipsec_tx;
 
 struct mlx5e_ipsec_work {
@@ -180,6 +180,38 @@ struct mlx5e_ipsec_rx_create_attr {
 	enum mlx5_flow_namespace_type chains_ns;
 };
 
+struct mlx5e_ipsec_ft {
+	struct mutex mutex; /* Protect changes to this struct */
+	struct mlx5_flow_table *pol;
+	struct mlx5_flow_table *sa;
+	struct mlx5_flow_table *status;
+	u32 refcnt;
+};
+
+struct mlx5e_ipsec_rule {
+	struct mlx5_flow_handle *rule;
+	struct mlx5_modify_hdr *modify_hdr;
+	struct mlx5_pkt_reformat *pkt_reformat;
+	struct mlx5_fc *fc;
+};
+
+struct mlx5e_ipsec_miss {
+	struct mlx5_flow_group *group;
+	struct mlx5_flow_handle *rule;
+};
+
+struct mlx5e_ipsec_rx {
+	struct mlx5e_ipsec_ft ft;
+	struct mlx5e_ipsec_miss pol;
+	struct mlx5e_ipsec_miss sa;
+	struct mlx5e_ipsec_rule status;
+	struct mlx5e_ipsec_miss status_drop;
+	struct mlx5_fc *status_drop_cnt;
+	struct mlx5e_ipsec_fc *fc;
+	struct mlx5_fs_chains *chains;
+	u8 allow_tunnel_mode : 1;
+};
+
 struct mlx5e_ipsec {
 	struct mlx5_core_dev *mdev;
 	struct xarray sadb;
@@ -205,13 +237,6 @@ struct mlx5e_ipsec_esn_state {
 	u8 overlap: 1;
 };
 
-struct mlx5e_ipsec_rule {
-	struct mlx5_flow_handle *rule;
-	struct mlx5_modify_hdr *modify_hdr;
-	struct mlx5_pkt_reformat *pkt_reformat;
-	struct mlx5_fc *fc;
-};
-
 struct mlx5e_ipsec_limits {
 	u64 round;
 	u8 soft_limit_hit : 1;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 52e382948c13..2db16e49abc1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -9,6 +9,7 @@
 #include "fs_core.h"
 #include "lib/ipsec_fs_roce.h"
 #include "lib/fs_chains.h"
+#include "esw/ipsec_fs.h"
 
 #define NUM_IPSEC_FTE BIT(15)
 #define MLX5_REFORMAT_TYPE_ADD_ESP_TRANSPORT_SIZE 16
@@ -19,29 +20,6 @@ struct mlx5e_ipsec_fc {
 	struct mlx5_fc *drop;
 };
 
-struct mlx5e_ipsec_ft {
-	struct mutex mutex; /* Protect changes to this struct */
-	struct mlx5_flow_table *pol;
-	struct mlx5_flow_table *sa;
-	struct mlx5_flow_table *status;
-	u32 refcnt;
-};
-
-struct mlx5e_ipsec_miss {
-	struct mlx5_flow_group *group;
-	struct mlx5_flow_handle *rule;
-};
-
-struct mlx5e_ipsec_rx {
-	struct mlx5e_ipsec_ft ft;
-	struct mlx5e_ipsec_miss pol;
-	struct mlx5e_ipsec_miss sa;
-	struct mlx5e_ipsec_rule status;
-	struct mlx5e_ipsec_fc *fc;
-	struct mlx5_fs_chains *chains;
-	u8 allow_tunnel_mode : 1;
-};
-
 struct mlx5e_ipsec_tx {
 	struct mlx5e_ipsec_ft ft;
 	struct mlx5e_ipsec_miss pol;
@@ -259,9 +237,9 @@ static void ipsec_rx_ft_disconnect(struct mlx5e_ipsec *ipsec, u32 family)
 static void rx_destroy(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 		       struct mlx5e_ipsec_rx *rx, u32 family)
 {
-
 	/* disconnect */
-	ipsec_rx_ft_disconnect(ipsec, family);
+	if (rx != ipsec->rx_esw)
+		ipsec_rx_ft_disconnect(ipsec, family);
 
 	if (rx->chains) {
 		ipsec_chains_destroy(rx->chains);
@@ -276,8 +254,12 @@ static void rx_destroy(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 	mlx5_destroy_flow_table(rx->ft.sa);
 	if (rx->allow_tunnel_mode)
 		mlx5_eswitch_unblock_encap(mdev);
-	mlx5_del_flow_rules(rx->status.rule);
-	mlx5_modify_header_dealloc(mdev, rx->status.modify_hdr);
+	if (rx == ipsec->rx_esw) {
+		mlx5_esw_ipsec_rx_status_destroy(ipsec, rx);
+	} else {
+		mlx5_del_flow_rules(rx->status.rule);
+		mlx5_modify_header_dealloc(mdev, rx->status.modify_hdr);
+	}
 	mlx5_destroy_flow_table(rx->ft.status);
 
 	mlx5_ipsec_fs_roce_rx_destroy(ipsec->roce, family);
@@ -288,6 +270,13 @@ static void ipsec_rx_create_attr_set(struct mlx5e_ipsec *ipsec,
 				     u32 family,
 				     struct mlx5e_ipsec_rx_create_attr *attr)
 {
+	if (rx == ipsec->rx_esw) {
+		/* For packet offload in switchdev mode, RX & TX use FDB namespace */
+		attr->ns = ipsec->tx_esw->ns;
+		mlx5_esw_ipsec_rx_create_attr_set(ipsec, attr);
+		return;
+	}
+
 	attr->ns = mlx5e_fs_get_ns(ipsec->fs, false);
 	attr->ttc = mlx5e_fs_get_ttc(ipsec->fs, false);
 	attr->family = family;
@@ -306,6 +295,9 @@ static int ipsec_rx_status_pass_dest_get(struct mlx5e_ipsec *ipsec,
 	struct mlx5_flow_table *ft;
 	int err;
 
+	if (rx == ipsec->rx_esw)
+		return mlx5_esw_ipsec_rx_status_pass_dest_get(ipsec, dest);
+
 	*dest = mlx5_ttc_get_default_dest(attr->ttc, family2tt(attr->family));
 	err = mlx5_ipsec_fs_roce_rx_create(ipsec->mdev, ipsec->roce, attr->ns, dest,
 					   attr->family, MLX5E_ACCEL_FS_ESP_FT_ROCE_LEVEL,
@@ -357,7 +349,10 @@ static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 
 	dest[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
 	dest[1].counter_id = mlx5_fc_id(rx->fc->cnt);
-	err = ipsec_status_rule(mdev, rx, dest);
+	if (rx == ipsec->rx_esw)
+		err = mlx5_esw_ipsec_rx_status_create(ipsec, rx, dest);
+	else
+		err = ipsec_status_rule(mdev, rx, dest);
 	if (err)
 		goto err_add;
 
@@ -406,7 +401,8 @@ static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 
 connect:
 	/* connect */
-	ipsec_rx_ft_connect(ipsec, rx, &attr);
+	if (rx != ipsec->rx_esw)
+		ipsec_rx_ft_connect(ipsec, rx, &attr);
 	return 0;
 
 err_pol_miss:
@@ -864,18 +860,22 @@ static void setup_fte_upper_proto_match(struct mlx5_flow_spec *spec, struct upsp
 	}
 }
 
-static enum mlx5_flow_namespace_type ipsec_fs_get_ns(struct mlx5e_ipsec *ipsec, u8 dir)
+static enum mlx5_flow_namespace_type ipsec_fs_get_ns(struct mlx5e_ipsec *ipsec,
+						     int type, u8 dir)
 {
+	if (ipsec->is_uplink_rep && type == XFRM_DEV_OFFLOAD_PACKET)
+		return MLX5_FLOW_NAMESPACE_FDB;
+
 	if (dir == XFRM_DEV_OFFLOAD_IN)
 		return MLX5_FLOW_NAMESPACE_KERNEL;
 
 	return MLX5_FLOW_NAMESPACE_EGRESS;
 }
 
-static int setup_modify_header(struct mlx5e_ipsec *ipsec, u32 val, u8 dir,
+static int setup_modify_header(struct mlx5e_ipsec *ipsec, int type, u32 val, u8 dir,
 			       struct mlx5_flow_act *flow_act)
 {
-	enum mlx5_flow_namespace_type ns_type = ipsec_fs_get_ns(ipsec, dir);
+	enum mlx5_flow_namespace_type ns_type = ipsec_fs_get_ns(ipsec, type, dir);
 	u8 action[MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto)] = {};
 	struct mlx5_core_dev *mdev = ipsec->mdev;
 	struct mlx5_modify_hdr *modify_hdr;
@@ -1085,7 +1085,8 @@ static int setup_pkt_reformat(struct mlx5e_ipsec *ipsec,
 			      struct mlx5_accel_esp_xfrm_attrs *attrs,
 			      struct mlx5_flow_act *flow_act)
 {
-	enum mlx5_flow_namespace_type ns_type = ipsec_fs_get_ns(ipsec, attrs->dir);
+	enum mlx5_flow_namespace_type ns_type = ipsec_fs_get_ns(ipsec, attrs->type,
+								attrs->dir);
 	struct mlx5_pkt_reformat_params reformat_params = {};
 	struct mlx5_core_dev *mdev = ipsec->mdev;
 	struct mlx5_pkt_reformat *pkt_reformat;
@@ -1127,7 +1128,7 @@ static int rx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 	struct mlx5_flow_spec *spec;
 	struct mlx5e_ipsec_rx *rx;
 	struct mlx5_fc *counter;
-	int err;
+	int err = 0;
 
 	rx = rx_ft_get(mdev, ipsec, attrs->family, attrs->type);
 	if (IS_ERR(rx))
@@ -1148,8 +1149,10 @@ static int rx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 	setup_fte_esp(spec);
 	setup_fte_no_frags(spec);
 
-	err = setup_modify_header(ipsec, sa_entry->ipsec_obj_id | BIT(31),
-				  XFRM_DEV_OFFLOAD_IN, &flow_act);
+	if (rx != ipsec->rx_esw)
+		err = setup_modify_header(ipsec, attrs->type,
+					  sa_entry->ipsec_obj_id | BIT(31),
+					  XFRM_DEV_OFFLOAD_IN, &flow_act);
 	if (err)
 		goto err_mod_header;
 
@@ -1340,7 +1343,7 @@ static int tx_add_policy(struct mlx5e_ipsec_pol_entry *pol_entry)
 		if (!attrs->reqid)
 			break;
 
-		err = setup_modify_header(ipsec, attrs->reqid,
+		err = setup_modify_header(ipsec, attrs->type, attrs->reqid,
 					  XFRM_DEV_OFFLOAD_OUT, &flow_act);
 		if (err)
 			goto err_mod_header;
@@ -1388,6 +1391,7 @@ static int rx_add_policy(struct mlx5e_ipsec_pol_entry *pol_entry)
 {
 	struct mlx5_accel_pol_xfrm_attrs *attrs = &pol_entry->attrs;
 	struct mlx5_core_dev *mdev = mlx5e_ipsec_pol2dev(pol_entry);
+	struct mlx5e_ipsec *ipsec = pol_entry->ipsec;
 	struct mlx5_flow_destination dest[2];
 	struct mlx5_flow_act flow_act = {};
 	struct mlx5_flow_handle *rule;
@@ -1433,6 +1437,8 @@ static int rx_add_policy(struct mlx5e_ipsec_pol_entry *pol_entry)
 	}
 
 	flow_act.flags |= FLOW_ACT_NO_APPEND;
+	if (rx == ipsec->rx_esw && rx->chains)
+		flow_act.flags |= FLOW_ACT_IGNORE_FLOW_LEVEL;
 	dest[dstn].type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
 	dest[dstn].ft = rx->ft.sa;
 	dstn++;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
index 5ff06263c5bd..3245d1c9d539 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
@@ -45,8 +45,9 @@ u32 mlx5_ipsec_device_caps(struct mlx5_core_dev *mdev)
 		    MLX5_CAP_FLOWTABLE_NIC_RX(mdev, decap))
 			caps |= MLX5_IPSEC_CAP_PACKET_OFFLOAD;
 
-		if (MLX5_CAP_FLOWTABLE_NIC_TX(mdev, ignore_flow_level) &&
-		    MLX5_CAP_FLOWTABLE_NIC_RX(mdev, ignore_flow_level))
+		if ((MLX5_CAP_FLOWTABLE_NIC_TX(mdev, ignore_flow_level) &&
+		     MLX5_CAP_FLOWTABLE_NIC_RX(mdev, ignore_flow_level)) ||
+		    MLX5_CAP_ESW_FLOWTABLE_FDB(mdev, ignore_flow_level))
 			caps |= MLX5_IPSEC_CAP_PRIO;
 
 		if (MLX5_CAP_FLOWTABLE_NIC_TX(mdev,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
new file mode 100644
index 000000000000..7df7a8b0a6a0
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+// Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+
+#include "fs_core.h"
+#include "eswitch.h"
+#include "en_accel/ipsec.h"
+#include "esw/ipsec_fs.h"
+
+enum {
+	MLX5_ESW_IPSEC_RX_POL_FT_LEVEL,
+	MLX5_ESW_IPSEC_RX_ESP_FT_LEVEL,
+	MLX5_ESW_IPSEC_RX_ESP_FT_CHK_LEVEL,
+};
+
+static void esw_ipsec_rx_status_drop_destroy(struct mlx5e_ipsec *ipsec,
+					     struct mlx5e_ipsec_rx *rx)
+{
+	mlx5_del_flow_rules(rx->status_drop.rule);
+	mlx5_destroy_flow_group(rx->status_drop.group);
+	mlx5_fc_destroy(ipsec->mdev, rx->status_drop_cnt);
+}
+
+static void esw_ipsec_rx_status_pass_destroy(struct mlx5e_ipsec *ipsec,
+					     struct mlx5e_ipsec_rx *rx)
+{
+	mlx5_del_flow_rules(rx->status.rule);
+	mlx5_chains_put_table(esw_chains(ipsec->mdev->priv.eswitch), 0, 1, 0);
+}
+
+static int esw_ipsec_rx_status_drop_create(struct mlx5e_ipsec *ipsec,
+					   struct mlx5e_ipsec_rx *rx)
+{
+	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
+	struct mlx5_flow_table *ft = rx->ft.status;
+	struct mlx5_core_dev *mdev = ipsec->mdev;
+	struct mlx5_flow_destination dest = {};
+	struct mlx5_flow_act flow_act = {};
+	struct mlx5_flow_handle *rule;
+	struct mlx5_fc *flow_counter;
+	struct mlx5_flow_spec *spec;
+	struct mlx5_flow_group *g;
+	u32 *flow_group_in;
+	int err = 0;
+
+	flow_group_in = kvzalloc(inlen, GFP_KERNEL);
+	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!flow_group_in || !spec) {
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	MLX5_SET(create_flow_group_in, flow_group_in, start_flow_index, ft->max_fte - 1);
+	MLX5_SET(create_flow_group_in, flow_group_in, end_flow_index, ft->max_fte - 1);
+	g = mlx5_create_flow_group(ft, flow_group_in);
+	if (IS_ERR(g)) {
+		err = PTR_ERR(g);
+		mlx5_core_err(mdev,
+			      "Failed to add ipsec rx status drop flow group, err=%d\n", err);
+		goto err_out;
+	}
+
+	flow_counter = mlx5_fc_create(mdev, false);
+	if (IS_ERR(flow_counter)) {
+		err = PTR_ERR(flow_counter);
+		mlx5_core_err(mdev,
+			      "Failed to add ipsec rx status drop rule counter, err=%d\n", err);
+		goto err_cnt;
+	}
+
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_DROP | MLX5_FLOW_CONTEXT_ACTION_COUNT;
+	dest.type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
+	dest.counter_id = mlx5_fc_id(flow_counter);
+	spec->flow_context.flow_source = MLX5_FLOW_CONTEXT_FLOW_SOURCE_UPLINK;
+	rule = mlx5_add_flow_rules(ft, spec, &flow_act, &dest, 1);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
+		mlx5_core_err(mdev,
+			      "Failed to add ipsec rx status drop rule, err=%d\n", err);
+		goto err_rule;
+	}
+
+	rx->status_drop.group = g;
+	rx->status_drop.rule = rule;
+	rx->status_drop_cnt = flow_counter;
+
+	kvfree(flow_group_in);
+	kvfree(spec);
+	return 0;
+
+err_rule:
+	mlx5_fc_destroy(mdev, flow_counter);
+err_cnt:
+	mlx5_destroy_flow_group(g);
+err_out:
+	kvfree(flow_group_in);
+	kvfree(spec);
+	return err;
+}
+
+static int esw_ipsec_rx_status_pass_create(struct mlx5e_ipsec *ipsec,
+					   struct mlx5e_ipsec_rx *rx,
+					   struct mlx5_flow_destination *dest)
+{
+	struct mlx5_flow_act flow_act = {};
+	struct mlx5_flow_handle *rule;
+	struct mlx5_flow_spec *spec;
+	int err;
+
+	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!spec)
+		return -ENOMEM;
+
+	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
+			 misc_parameters_2.ipsec_syndrome);
+	MLX5_SET(fte_match_param, spec->match_value,
+		 misc_parameters_2.ipsec_syndrome, 0);
+	spec->flow_context.flow_source = MLX5_FLOW_CONTEXT_FLOW_SOURCE_UPLINK;
+	spec->match_criteria_enable = MLX5_MATCH_MISC_PARAMETERS_2;
+	flow_act.flags = FLOW_ACT_NO_APPEND;
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
+			  MLX5_FLOW_CONTEXT_ACTION_COUNT;
+	rule = mlx5_add_flow_rules(rx->ft.status, spec, &flow_act, dest, 2);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
+		mlx5_core_warn(ipsec->mdev,
+			       "Failed to add ipsec rx status pass rule, err=%d\n", err);
+		goto err_rule;
+	}
+
+	rx->status.rule = rule;
+	kvfree(spec);
+	return 0;
+
+err_rule:
+	kvfree(spec);
+	return err;
+}
+
+void mlx5_esw_ipsec_rx_status_destroy(struct mlx5e_ipsec *ipsec,
+				      struct mlx5e_ipsec_rx *rx)
+{
+	esw_ipsec_rx_status_pass_destroy(ipsec, rx);
+	esw_ipsec_rx_status_drop_destroy(ipsec, rx);
+}
+
+int mlx5_esw_ipsec_rx_status_create(struct mlx5e_ipsec *ipsec,
+				    struct mlx5e_ipsec_rx *rx,
+				    struct mlx5_flow_destination *dest)
+{
+	int err;
+
+	err = esw_ipsec_rx_status_drop_create(ipsec, rx);
+	if (err)
+		return err;
+
+	err = esw_ipsec_rx_status_pass_create(ipsec, rx, dest);
+	if (err)
+		goto err_pass_create;
+
+	return 0;
+
+err_pass_create:
+	esw_ipsec_rx_status_drop_destroy(ipsec, rx);
+	return err;
+}
+
+void mlx5_esw_ipsec_rx_create_attr_set(struct mlx5e_ipsec *ipsec,
+				       struct mlx5e_ipsec_rx_create_attr *attr)
+{
+	attr->prio = FDB_CRYPTO_INGRESS;
+	attr->pol_level = MLX5_ESW_IPSEC_RX_POL_FT_LEVEL;
+	attr->sa_level = MLX5_ESW_IPSEC_RX_ESP_FT_LEVEL;
+	attr->status_level = MLX5_ESW_IPSEC_RX_ESP_FT_CHK_LEVEL;
+	attr->chains_ns = MLX5_FLOW_NAMESPACE_FDB;
+}
+
+int mlx5_esw_ipsec_rx_status_pass_dest_get(struct mlx5e_ipsec *ipsec,
+					   struct mlx5_flow_destination *dest)
+{
+	dest->type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
+	dest->ft = mlx5_chains_get_table(esw_chains(ipsec->mdev->priv.eswitch), 0, 1, 0);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h
new file mode 100644
index 000000000000..1d6104648d32
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef __MLX5_ESW_IPSEC_FS_H__
+#define __MLX5_ESW_IPSEC_FS_H__
+
+struct mlx5e_ipsec;
+
+#ifdef CONFIG_MLX5_ESWITCH
+void mlx5_esw_ipsec_rx_status_destroy(struct mlx5e_ipsec *ipsec,
+				      struct mlx5e_ipsec_rx *rx);
+int mlx5_esw_ipsec_rx_status_create(struct mlx5e_ipsec *ipsec,
+				    struct mlx5e_ipsec_rx *rx,
+				    struct mlx5_flow_destination *dest);
+void mlx5_esw_ipsec_rx_create_attr_set(struct mlx5e_ipsec *ipsec,
+				       struct mlx5e_ipsec_rx_create_attr *attr);
+int mlx5_esw_ipsec_rx_status_pass_dest_get(struct mlx5e_ipsec *ipsec,
+					   struct mlx5_flow_destination *dest);
+#else
+static inline void mlx5_esw_ipsec_rx_status_destroy(struct mlx5e_ipsec *ipsec,
+						    struct mlx5e_ipsec_rx *rx) {}
+
+static inline int mlx5_esw_ipsec_rx_status_create(struct mlx5e_ipsec *ipsec,
+						  struct mlx5e_ipsec_rx *rx,
+						  struct mlx5_flow_destination *dest)
+{
+	return  -EINVAL;
+}
+
+static inline void mlx5_esw_ipsec_rx_create_attr_set(struct mlx5e_ipsec *ipsec,
+						     struct mlx5e_ipsec_rx_create_attr *attr) {}
+
+static inline int mlx5_esw_ipsec_rx_status_pass_dest_get(struct mlx5e_ipsec *ipsec,
+							 struct mlx5_flow_destination *dest)
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_MLX5_ESWITCH */
+#endif /* __MLX5_ESW_IPSEC_FS_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 4ef04aa28771..8ae1854d6b73 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -2987,6 +2987,12 @@ static int init_fdb_root_ns(struct mlx5_flow_steering *steering)
 	if (err)
 		goto out_err;
 
+	maj_prio = fs_create_prio(&steering->fdb_root_ns->ns, FDB_CRYPTO_INGRESS, 3);
+	if (IS_ERR(maj_prio)) {
+		err = PTR_ERR(maj_prio);
+		goto out_err;
+	}
+
 	err = create_fdb_fast_path(steering);
 	if (err)
 		goto out_err;
diff --git a/include/linux/mlx5/fs.h b/include/linux/mlx5/fs.h
index 2cb404c7ea13..6b1fa94f69c8 100644
--- a/include/linux/mlx5/fs.h
+++ b/include/linux/mlx5/fs.h
@@ -109,6 +109,7 @@ enum mlx5_flow_namespace_type {
 
 enum {
 	FDB_BYPASS_PATH,
+	FDB_CRYPTO_INGRESS,
 	FDB_TC_OFFLOAD,
 	FDB_FT_OFFLOAD,
 	FDB_TC_MISS,
-- 
2.41.0


