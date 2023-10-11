Return-Path: <netdev+bounces-39844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98377C49BF
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 08:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A270C282246
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 06:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346E518029;
	Wed, 11 Oct 2023 06:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBQ6BG8D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17660156FD
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 06:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6151C433C8;
	Wed, 11 Oct 2023 06:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697004766;
	bh=COvh29V66pwwk/1+/dKG8J71L6oUooRvA8JyPCfnG+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lBQ6BG8Dg1LgCEebUIwk7jZmwuzXs34eSLHUNJiUV8gpsZSEl2UcI8lCIK0/fpdRb
	 c1FgXNoaO1qIJCin9uM8YlSaLWMeZMJF8zXL74kx94snyci3Mh5UjZUKPrjWK8qW3x
	 X/9mF0iW9Tq1XDHv7xqupQIt/i4Vjc8yuaLkvM0RRbnL4P7/5sYDfi8Eq/6vnXAxBw
	 Ep7nhjD981bPyjKk4Su+q57vXhkewyNVBpEUbS2z5bTx8emxZ1oWK+2xl49WFz79DF
	 nbwW7MDq46AxQFFUu2P03jutkhi/EjLMUpZikD1PsrHuzb9VxmT2O0VJRqDbNhpdzC
	 Gpw86XR6TCv1g==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>
Subject: [net-next 15/15] net/mlx5e: Allow IPsec soft/hard limits in bytes
Date: Tue, 10 Oct 2023 23:12:30 -0700
Message-ID: <20231011061230.11530-16-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011061230.11530-1-saeed@kernel.org>
References: <20231011061230.11530-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Actually the mlx5 code already has needed support to allow users
to configure soft/hard limits in bytes. It is possible due to the
situation with TX path, where CX7 devices are missing hardware
implementation to send events to the software, see commit b2f7b01d36a9
("net/mlx5e: Simulate missing IPsec TX limits hardware functionality").

That software workaround is not limited to TX and works for bytes too.
So relax the validation logic to not block soft/hard limits in bytes.

Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec.c       | 23 +++++++++++-------
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 24 +++++++++++--------
 2 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 7d4ceb9b9c16..257c41870f78 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -56,7 +56,7 @@ static struct mlx5e_ipsec_pol_entry *to_ipsec_pol_entry(struct xfrm_policy *x)
 	return (struct mlx5e_ipsec_pol_entry *)x->xdo.offload_handle;
 }
 
-static void mlx5e_ipsec_handle_tx_limit(struct work_struct *_work)
+static void mlx5e_ipsec_handle_sw_limits(struct work_struct *_work)
 {
 	struct mlx5e_ipsec_dwork *dwork =
 		container_of(_work, struct mlx5e_ipsec_dwork, dwork.work);
@@ -486,9 +486,15 @@ static int mlx5e_xfrm_validate_state(struct mlx5_core_dev *mdev,
 			return -EINVAL;
 		}
 
-		if (x->lft.hard_byte_limit != XFRM_INF ||
-		    x->lft.soft_byte_limit != XFRM_INF) {
-			NL_SET_ERR_MSG_MOD(extack, "Device doesn't support limits in bytes");
+		if (x->lft.soft_byte_limit >= x->lft.hard_byte_limit &&
+		    x->lft.hard_byte_limit != XFRM_INF) {
+			/* XFRM stack doesn't prevent such configuration :(. */
+			NL_SET_ERR_MSG_MOD(extack, "Hard byte limit must be greater than soft one");
+			return -EINVAL;
+		}
+
+		if (!x->lft.soft_byte_limit || !x->lft.hard_byte_limit) {
+			NL_SET_ERR_MSG_MOD(extack, "Soft/hard byte limits can't be 0");
 			return -EINVAL;
 		}
 
@@ -624,11 +630,10 @@ static int mlx5e_ipsec_create_dwork(struct mlx5e_ipsec_sa_entry *sa_entry)
 	if (x->xso.type != XFRM_DEV_OFFLOAD_PACKET)
 		return 0;
 
-	if (x->xso.dir != XFRM_DEV_OFFLOAD_OUT)
-		return 0;
-
 	if (x->lft.soft_packet_limit == XFRM_INF &&
-	    x->lft.hard_packet_limit == XFRM_INF)
+	    x->lft.hard_packet_limit == XFRM_INF &&
+	    x->lft.soft_byte_limit == XFRM_INF &&
+	    x->lft.hard_byte_limit == XFRM_INF)
 		return 0;
 
 	dwork = kzalloc(sizeof(*dwork), GFP_KERNEL);
@@ -636,7 +641,7 @@ static int mlx5e_ipsec_create_dwork(struct mlx5e_ipsec_sa_entry *sa_entry)
 		return -ENOMEM;
 
 	dwork->sa_entry = sa_entry;
-	INIT_DELAYED_WORK(&dwork->dwork, mlx5e_ipsec_handle_tx_limit);
+	INIT_DELAYED_WORK(&dwork->dwork, mlx5e_ipsec_handle_sw_limits);
 	sa_entry->dwork = dwork;
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 7dba4221993f..eda1cb528deb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -1249,15 +1249,17 @@ static int rx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 	setup_fte_no_frags(spec);
 	setup_fte_upper_proto_match(spec, &attrs->upspec);
 
-	if (rx != ipsec->rx_esw)
-		err = setup_modify_header(ipsec, attrs->type,
-					  sa_entry->ipsec_obj_id | BIT(31),
-					  XFRM_DEV_OFFLOAD_IN, &flow_act);
-	else
-		err = mlx5_esw_ipsec_rx_setup_modify_header(sa_entry, &flow_act);
+	if (!attrs->drop) {
+		if (rx != ipsec->rx_esw)
+			err = setup_modify_header(ipsec, attrs->type,
+						  sa_entry->ipsec_obj_id | BIT(31),
+						  XFRM_DEV_OFFLOAD_IN, &flow_act);
+		else
+			err = mlx5_esw_ipsec_rx_setup_modify_header(sa_entry, &flow_act);
 
-	if (err)
-		goto err_mod_header;
+		if (err)
+			goto err_mod_header;
+	}
 
 	switch (attrs->type) {
 	case XFRM_DEV_OFFLOAD_PACKET:
@@ -1307,7 +1309,8 @@ static int rx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 	if (flow_act.pkt_reformat)
 		mlx5_packet_reformat_dealloc(mdev, flow_act.pkt_reformat);
 err_pkt_reformat:
-	mlx5_modify_header_dealloc(mdev, flow_act.modify_hdr);
+	if (flow_act.modify_hdr)
+		mlx5_modify_header_dealloc(mdev, flow_act.modify_hdr);
 err_mod_header:
 	kvfree(spec);
 err_alloc:
@@ -1805,7 +1808,8 @@ void mlx5e_accel_ipsec_fs_del_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 		return;
 	}
 
-	mlx5_modify_header_dealloc(mdev, ipsec_rule->modify_hdr);
+	if (ipsec_rule->modify_hdr)
+		mlx5_modify_header_dealloc(mdev, ipsec_rule->modify_hdr);
 	mlx5_esw_ipsec_rx_id_mapping_remove(sa_entry);
 	rx_ft_put(sa_entry->ipsec, sa_entry->attrs.family, sa_entry->attrs.type);
 }
-- 
2.41.0


