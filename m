Return-Path: <netdev+bounces-25074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DE5772D6E
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 20:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55F611C20CAE
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 18:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E966168D0;
	Mon,  7 Aug 2023 17:57:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCC9168AB
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 17:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C0CC433AD;
	Mon,  7 Aug 2023 17:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691431027;
	bh=kv93oIpSrNSgqoEUpWUQRYfgGaOA4LUDejARKw66X+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dHsHZfg9esk/NyfYfcTjv2gp3wQX7IFBa5iC41qj+X0aIhtEvkiheFKprB+3yvoSL
	 md/9vc3Pm0xH0o/lNx/GBK6mHbAw9beI323ctMPxkgScb6rg/NFaOdTew9KNfdwGt8
	 AnBwuvrfgClFYXcdNqwCoq2iw0wvUKTwoG8J336fmyf5quaQN19znSxMPy+NjVzsUM
	 efv+fYgrOEwg2n2GG3DuNQCtnFaSGty25DNnM28CK4VJ1ajqMbRnbxvTpmtl5x5SHK
	 dvGlXJ0fSdeizmOi/MNC0t/yMfnwJ8sYgpkVNK8dYYZlummne+5E6aJIzBjcWEHbf5
	 pAaA2IFKyY6Iw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Roi Dayan <roid@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net-next 14/15] net/mlx5: E-Switch, Remove redundant arg ignore_flow_lvl
Date: Mon,  7 Aug 2023 10:56:41 -0700
Message-ID: <20230807175642.20834-15-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807175642.20834-1-saeed@kernel.org>
References: <20230807175642.20834-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Roi Dayan <roid@nvidia.com>

The arg is always passed as true and thus redundant.

Signed-off-by: Roi Dayan <roid@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 723dff87e6d5..e391535e1ab1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -375,7 +375,6 @@ esw_setup_indir_table(struct mlx5_flow_destination *dest,
 		      struct mlx5_flow_act *flow_act,
 		      struct mlx5_eswitch *esw,
 		      struct mlx5_flow_attr *attr,
-		      bool ignore_flow_lvl,
 		      int *i)
 {
 	struct mlx5_esw_flow_attr *esw_attr = attr->esw_attr;
@@ -385,8 +384,7 @@ esw_setup_indir_table(struct mlx5_flow_destination *dest,
 		return -EOPNOTSUPP;
 
 	for (j = esw_attr->split_count; j < esw_attr->out_count; j++, (*i)++) {
-		if (ignore_flow_lvl)
-			flow_act->flags |= FLOW_ACT_IGNORE_FLOW_LEVEL;
+		flow_act->flags |= FLOW_ACT_IGNORE_FLOW_LEVEL;
 		dest[*i].type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
 
 		dest[*i].ft = mlx5_esw_indir_table_get(esw, attr,
@@ -569,7 +567,7 @@ esw_setup_dests(struct mlx5_flow_destination *dest,
 		err = esw_setup_mtu_dest(dest, &attr->meter_attr, *i);
 		(*i)++;
 	} else if (esw_is_indir_table(esw, attr)) {
-		err = esw_setup_indir_table(dest, flow_act, esw, attr, true, i);
+		err = esw_setup_indir_table(dest, flow_act, esw, attr, i);
 	} else if (esw_is_chain_src_port_rewrite(esw, esw_attr)) {
 		err = esw_setup_chain_src_port_rewrite(dest, flow_act, esw, chains, attr, i);
 	} else {
-- 
2.41.0


