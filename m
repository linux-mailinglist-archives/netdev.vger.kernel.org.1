Return-Path: <netdev+bounces-16760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B554974EA9D
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 11:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D552816E3
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 09:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB0618C09;
	Tue, 11 Jul 2023 09:29:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6107C18C07
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:29:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9751AC43391;
	Tue, 11 Jul 2023 09:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689067788;
	bh=ZJXKhLFLhNbHvGZ7oYr55Qb1sAK6u5UczrzFmGjk8Xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d7TTmBTQMrEhmG0LDN3XtcMc6P/p2FABAvLmzsB7joNjHw21BHp3yaztsa9M1YLHi
	 OHNAna89GZpPEISr7EqDTMT8x8GJO9FUoMpW+virHd9YUL9ndUrfFoyEb8C01KGs//
	 Out7BlcfsZN9+PAV7kTW3JnC700bvZ+eYq8jD6uFH2MarTIBLvcKpTV8DFHJbz7bUc
	 axNPh+AACLbXJ8ggwyr1MX6cf1vm+t71hECVoeqmSXazMKxIrJ/0yUSLWMJN2VFSs/
	 EXHVd64Rg0+Vj9tjmMjVndaRjvsf0aOmSHfvbqQ26fkFVMxNnLGoiJqPDJ9J0GgNdw
	 2+4AWSaxqemcA==
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jianbo Liu <jianbol@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH net-next 07/12] net/mlx5e: Refactor IPsec TX tables creation
Date: Tue, 11 Jul 2023 12:29:05 +0300
Message-ID: <d7bd2ba7ea20378dd5e3a01451335a9cec4197e6.1689064922.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689064922.git.leonro@nvidia.com>
References: <cover.1689064922.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

Add attribute for IPsec TX creation, pass all needed parameters in it,
so tx_create() can be used by eswitch.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec.h       |  8 ++++++
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 26 ++++++++++++++-----
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
index bc8e200f4059..a3cd3986b2cc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
@@ -205,6 +205,14 @@ struct mlx5e_ipsec_rx {
 	struct xarray ipsec_obj_id_map;
 };
 
+struct mlx5e_ipsec_tx_create_attr {
+	int prio;
+	int pol_level;
+	int sa_level;
+	int cnt_level;
+	enum mlx5_flow_namespace_type chains_ns;
+};
+
 struct mlx5e_ipsec {
 	struct mlx5_core_dev *mdev;
 	struct xarray sadb;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 0d386fbfb18c..f89174dbed92 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -569,15 +569,29 @@ static void tx_destroy(struct mlx5_core_dev *mdev, struct mlx5e_ipsec_tx *tx,
 	mlx5_destroy_flow_table(tx->ft.status);
 }
 
-static int tx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec_tx *tx,
+static void ipsec_tx_create_attr_set(struct mlx5e_ipsec *ipsec,
+				     struct mlx5e_ipsec_tx *tx,
+				     struct mlx5e_ipsec_tx_create_attr *attr)
+{
+	attr->prio = 0;
+	attr->pol_level = 0;
+	attr->sa_level = 1;
+	attr->cnt_level = 2;
+	attr->chains_ns = MLX5_FLOW_NAMESPACE_EGRESS_IPSEC;
+}
+
+static int tx_create(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_tx *tx,
 		     struct mlx5_ipsec_fs *roce)
 {
+	struct mlx5_core_dev *mdev = ipsec->mdev;
+	struct mlx5e_ipsec_tx_create_attr attr;
 	struct mlx5_flow_destination dest = {};
 	struct mlx5_flow_table *ft;
 	u32 flags = 0;
 	int err;
 
-	ft = ipsec_ft_create(tx->ns, 2, 0, 1, 0);
+	ipsec_tx_create_attr_set(ipsec, tx, &attr);
+	ft = ipsec_ft_create(tx->ns, attr.cnt_level, attr.prio, 1, 0);
 	if (IS_ERR(ft))
 		return PTR_ERR(ft);
 	tx->ft.status = ft;
@@ -590,7 +604,7 @@ static int tx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec_tx *tx,
 		tx->allow_tunnel_mode = mlx5_eswitch_block_encap(mdev);
 	if (tx->allow_tunnel_mode)
 		flags = MLX5_FLOW_TABLE_TUNNEL_EN_REFORMAT;
-	ft = ipsec_ft_create(tx->ns, 1, 0, 4, flags);
+	ft = ipsec_ft_create(tx->ns, attr.sa_level, attr.prio, 4, flags);
 	if (IS_ERR(ft)) {
 		err = PTR_ERR(ft);
 		goto err_sa_ft;
@@ -599,7 +613,7 @@ static int tx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec_tx *tx,
 
 	if (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_PRIO) {
 		tx->chains = ipsec_chains_create(
-			mdev, tx->ft.sa, MLX5_FLOW_NAMESPACE_EGRESS_IPSEC, 0, 0,
+			mdev, tx->ft.sa, attr.chains_ns, attr.prio, attr.pol_level,
 			&tx->ft.pol);
 		if (IS_ERR(tx->chains)) {
 			err = PTR_ERR(tx->chains);
@@ -609,7 +623,7 @@ static int tx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec_tx *tx,
 		goto connect_roce;
 	}
 
-	ft = ipsec_ft_create(tx->ns, 0, 0, 2, 0);
+	ft = ipsec_ft_create(tx->ns, attr.pol_level, attr.prio, 2, 0);
 	if (IS_ERR(ft)) {
 		err = PTR_ERR(ft);
 		goto err_pol_ft;
@@ -656,7 +670,7 @@ static int tx_get(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 	if (tx->ft.refcnt)
 		goto skip;
 
-	err = tx_create(mdev, tx, ipsec->roce);
+	err = tx_create(ipsec, tx, ipsec->roce);
 	if (err)
 		return err;
 
-- 
2.41.0


