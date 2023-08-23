Return-Path: <netdev+bounces-29876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFF7784FE5
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 07:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20490281307
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 05:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FE4AD4B;
	Wed, 23 Aug 2023 05:10:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76BBAD3F
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 05:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D87C433AD;
	Wed, 23 Aug 2023 05:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692767441;
	bh=rFoUTDamZTt0uwWk163o3LduLFe1gq6XDQCSnKBQewY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ufvn3vbPTN7YHC62DtkbCFmDSH9wQ2uVT/OYoTIZjq594diWHLzT9vrG+Av/ycVTB
	 Nscg4OzIYwbhsbFY8t2bYMT+alq1ru/2ihdkBrDgzlZZtkQ0jge92jbdfi+yqgK8BJ
	 mscwjT6oNnUgqBhAfbHopyoqawT8aoBC23TYs0TWDwQbnDtpoDJZDDvCWlG3haBPIH
	 qF98No4QSz0KnaiWIn9ROGaFF00/mc4mOa6P5pDjvBcAuqvrZCpQfn+hqHutgd3gx3
	 R5XBlwEXb0bP9M5WWuqxLG8fwfZki3+vFV31wy3jp5/L1lB1tSo9FX/yvmezqFmCP7
	 WyQJbXw0k3O8Q==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Emeel Hakim <ehakim@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net-next 14/15] net/mlx5e: Support IPsec upper protocol selector field offload for RX
Date: Tue, 22 Aug 2023 22:10:11 -0700
Message-ID: <20230823051012.162483-15-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823051012.162483-1-saeed@kernel.org>
References: <20230823051012.162483-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emeel Hakim <ehakim@nvidia.com>

Support RX policy/state upper protocol selector field offload,
to enable selecting RX traffic for IPsec operation based on l4
protocol UDP with specific source/destination port.

Signed-off-by: Emeel Hakim <ehakim@nvidia.com>
Reviewed-by: Raed Salem <raeds@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c   | 10 ++++------
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c    |  2 ++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index a577f0edabe8..2bbe232c2ffa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -440,9 +440,8 @@ static int mlx5e_xfrm_validate_state(struct mlx5_core_dev *mdev,
 		return -EINVAL;
 	}
 
-	if (x->sel.proto != IPPROTO_IP &&
-	    (x->sel.proto != IPPROTO_UDP || x->xso.dir != XFRM_DEV_OFFLOAD_OUT)) {
-		NL_SET_ERR_MSG_MOD(extack, "Device does not support upper protocol other than UDP, and only Tx direction");
+	if (x->sel.proto != IPPROTO_IP && x->sel.proto != IPPROTO_UDP) {
+		NL_SET_ERR_MSG_MOD(extack, "Device does not support upper protocol other than UDP");
 		return -EINVAL;
 	}
 
@@ -983,9 +982,8 @@ static int mlx5e_xfrm_validate_policy(struct mlx5_core_dev *mdev,
 		return -EINVAL;
 	}
 
-	if (sel->proto != IPPROTO_IP &&
-	    (sel->proto != IPPROTO_UDP || x->xdo.dir != XFRM_DEV_OFFLOAD_OUT)) {
-		NL_SET_ERR_MSG_MOD(extack, "Device does not support upper protocol other than UDP, and only Tx direction");
+	if (x->selector.proto != IPPROTO_IP && x->selector.proto != IPPROTO_UDP) {
+		NL_SET_ERR_MSG_MOD(extack, "Device does not support upper protocol other than UDP");
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 3781c72d97f1..f5e29b7f5ba0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -1243,6 +1243,7 @@ static int rx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 	setup_fte_spi(spec, attrs->spi);
 	setup_fte_esp(spec);
 	setup_fte_no_frags(spec);
+	setup_fte_upper_proto_match(spec, &attrs->upspec);
 
 	if (rx != ipsec->rx_esw)
 		err = setup_modify_header(ipsec, attrs->type,
@@ -1519,6 +1520,7 @@ static int rx_add_policy(struct mlx5e_ipsec_pol_entry *pol_entry)
 		setup_fte_addr6(spec, attrs->saddr.a6, attrs->daddr.a6);
 
 	setup_fte_no_frags(spec);
+	setup_fte_upper_proto_match(spec, &attrs->upspec);
 
 	switch (attrs->action) {
 	case XFRM_POLICY_ALLOW:
-- 
2.41.0


