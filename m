Return-Path: <netdev+bounces-25541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABB477479B
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4171C2109B
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 19:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA25168D7;
	Tue,  8 Aug 2023 19:15:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A94168D5
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 19:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5A7C433CC;
	Tue,  8 Aug 2023 19:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691522111;
	bh=mRxON/kFZ9txpUhRHlyNSpZL+APDX5ByQ218x37KZMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D6SHOh+H69UY/sVQ/poCu9rpvKBr0zSGjNJA+sxaslhtc1eNhCK6iMSgyeMFi7+Gd
	 gVRyJc+cNPK+GxnsTvX7dXSt3EuA618xAM5f9VTli2HR2fsOmCLLBFfhKS2mSXQ4RL
	 uBu/a0W1Yxik6hFeM13IkkGBv7jlBFJJubFRl4f/QrPuOYcEqlCVieTByB+thLe3/A
	 qd448/F/NBG5n+XRxAW+og6S9QTM3B+gXCSb7mPoOJRX2oPw1kYS41EPKb5JpCa+Bq
	 nszz0se7RMwC4zcC6EPu8K8RJ35RqNPkHWzOtDMamy8IKdS4AgDtucsAc0sZ4RXY/S
	 3rsDOyx3RCQOQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>
Cc: Emeel Hakim <ehakim@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Raed Salem <raeds@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next 1/2] net/mlx5e: Support IPsec upper protocol selector field offload for RX
Date: Tue,  8 Aug 2023 22:14:54 +0300
Message-ID: <c94f442c1f217c14a0f1a2521b89f532fd73c36e.1691521680.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691521680.git.leonro@nvidia.com>
References: <cover.1691521680.git.leonro@nvidia.com>
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
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c   | 10 ++++------
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c    |  2 ++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 40350227b3c3..9ee169b72d9d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -442,9 +442,8 @@ static int mlx5e_xfrm_validate_state(struct mlx5_core_dev *mdev,
 		return -EINVAL;
 	}
 
-	if (x->sel.proto != IPPROTO_IP &&
-	    (x->sel.proto != IPPROTO_UDP || x->xso.dir != XFRM_DEV_OFFLOAD_OUT)) {
-		NL_SET_ERR_MSG_MOD(extack, "Device does not support upper protocol other than UDP, and only Tx direction");
+	if (x->sel.proto != IPPROTO_IP && x->sel.proto != IPPROTO_UDP) {
+		NL_SET_ERR_MSG_MOD(extack, "Device does not support upper protocol other than UDP");
 		return -EINVAL;
 	}
 
@@ -1000,9 +999,8 @@ static int mlx5e_xfrm_validate_policy(struct mlx5_core_dev *mdev,
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


