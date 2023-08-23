Return-Path: <netdev+bounces-29872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F651784FE0
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 07:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 404FE1C20C5C
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 05:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4412EA94C;
	Wed, 23 Aug 2023 05:10:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED676A937
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 05:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1825C433A9;
	Wed, 23 Aug 2023 05:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692767435;
	bh=t7MiNnA4SY2z7TGIpeZD9bcbTBQv6ro0RBJ+niZrsRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q/sc0PYvDtSji0SL8Z/AfybO/N0lQdy+8120P+25jaSWAWgsVrsnJQfczhuR0HSKE
	 YTNvKVlu0BrYWrej3cui0zhGKYhaMvJopN1KSZxuoegkSAtvXmCFQiHY4gxMsoFfis
	 eUPEcauBWS4XUykopFK6NgHkh8vRbtHddnl/A2vIMz72E0yPj5J6Bkx97mfRcAzAmD
	 TCEOpMOxAwcRNaM7d68Z5w9DKFqN2ymfWDE8tv1/7GRnrZ8PxFmu/WAE4aQvmdkFTG
	 sAmNXm1w/S5XAYZPr17luqUT5ppq+4aoyEAKWnYPlFRLGcbewVVq3cPFObt+cYh5UN
	 VSuT0ZD6g+2fw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net-next 10/15] net/mlx5: Return -EOPNOTSUPP in mlx5_devlink_port_fn_migratable_set() directly
Date: Tue, 22 Aug 2023 22:10:07 -0700
Message-ID: <20230823051012.162483-11-saeed@kernel.org>
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

From: Jiri Pirko <jiri@nvidia.com>

Instead of initializing "err" variable, just return "-EOPNOTSUPP"
directly where it is needed.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 609605c42d6d..87cc6ad2e17f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4309,7 +4309,7 @@ int mlx5_devlink_port_fn_migratable_set(struct devlink_port *port, bool enable,
 	struct mlx5_vport *vport;
 	void *query_ctx;
 	void *hca_caps;
-	int err = -EOPNOTSUPP;
+	int err;
 
 	esw = mlx5_devlink_eswitch_get(port->devlink);
 	if (IS_ERR(esw))
@@ -4317,7 +4317,7 @@ int mlx5_devlink_port_fn_migratable_set(struct devlink_port *port, bool enable,
 
 	if (!MLX5_CAP_GEN(esw->dev, migration)) {
 		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support migration");
-		return err;
+		return -EOPNOTSUPP;
 	}
 
 	vport = mlx5_devlink_port_fn_get_vport(port, esw);
-- 
2.41.0


