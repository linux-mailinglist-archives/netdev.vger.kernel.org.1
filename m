Return-Path: <netdev+bounces-13527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128F773BED7
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 21:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3944C1C212A9
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 19:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0B2125A5;
	Fri, 23 Jun 2023 19:29:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACBA10967
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 19:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3263C433AB;
	Fri, 23 Jun 2023 19:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687548563;
	bh=Gk8y4OKeeQK+QK8EDke/WczfriAFm8OyPteNoasVnJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MGrhlJsrPb65zTb/luUMopIS5hb8EXV75QaPzZVeSvWQg+IcAQRk9O8mw88aEE1Xj
	 WB2mXINJzebfqQwniYv5z/aujdzXXnGFdURr5gbq5h7w0fKUHF3/9cgOd23G9llva/
	 Zr5OaFJ5yR3M+WSqjZbpsEUriGgzHktGP5EHGHqwEsigMH2MuCVhwd90pRrLj74H/V
	 heHlkPmgNJVERqo9b60drNK2Rlkpzk3BxQ240A/hnxse0IP/SwuDtnsUlm3X1oEZ55
	 rofvPX4lPaID4Tg4o2AKbsUy5rK/WBjppJsAURTuZTKckHFCGJemyv+LH+NGz4gjs+
	 92R1PNmXI9omw==
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
Subject: [net-next V2 09/15] net/mlx5e: E-Switch, Pass other_vport flag if vport is not 0
Date: Fri, 23 Jun 2023 12:29:01 -0700
Message-ID: <20230623192907.39033-10-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230623192907.39033-1-saeed@kernel.org>
References: <20230623192907.39033-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Roi Dayan <roid@nvidia.com>

When creating flow table for shared fdb resources, there is
only need to pass other_vport flag if vport is not 0 or
if the port is ECPF in BlueField.

Signed-off-by: Roi Dayan <roid@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch_offloads.c   | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 6f3b7d5eb6a4..ee507b12e908 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2551,13 +2551,13 @@ static int __esw_set_master_egress_rule(struct mlx5_core_dev *master,
 	return err;
 }
 
-static int esw_master_egress_create_resources(struct mlx5_flow_namespace *egress_ns,
+static int esw_master_egress_create_resources(struct mlx5_eswitch *esw,
+					      struct mlx5_flow_namespace *egress_ns,
 					      struct mlx5_vport *vport, size_t count)
 {
 	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
 	struct mlx5_flow_table_attr ft_attr = {
 		.max_fte = count, .prio = 0, .level = 0,
-		.flags = MLX5_FLOW_TABLE_OTHER_VPORT,
 	};
 	struct mlx5_flow_table *acl;
 	struct mlx5_flow_group *g;
@@ -2572,6 +2572,9 @@ static int esw_master_egress_create_resources(struct mlx5_flow_namespace *egress
 	if (!flow_group_in)
 		return -ENOMEM;
 
+	if (vport->vport || mlx5_core_is_ecpf(esw->dev))
+		ft_attr.flags = MLX5_FLOW_TABLE_OTHER_VPORT;
+
 	acl = mlx5_create_vport_flow_table(egress_ns, &ft_attr, vport->vport);
 	if (IS_ERR(acl)) {
 		err = PTR_ERR(acl);
@@ -2642,7 +2645,7 @@ static int esw_set_master_egress_rule(struct mlx5_core_dev *master,
 	if (vport->egress.acl && vport->egress.type != VPORT_EGRESS_ACL_TYPE_SHARED_FDB)
 		return 0;
 
-	err = esw_master_egress_create_resources(egress_ns, vport, count);
+	err = esw_master_egress_create_resources(esw, egress_ns, vport, count);
 	if (err)
 		return err;
 
-- 
2.41.0


