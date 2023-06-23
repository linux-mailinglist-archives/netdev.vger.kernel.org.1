Return-Path: <netdev+bounces-13528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 333F273BED9
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 21:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B531C2134D
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 19:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1971C134A8;
	Fri, 23 Jun 2023 19:29:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B7911C82
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 19:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9889EC433B7;
	Fri, 23 Jun 2023 19:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687548565;
	bh=eMac6HPe9n8+9g4d9pwv4GqufUr5okGe1LUk8UwMvg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uZx6XcD1gwztCdvcIHuVWgzcauShktQ3O6gYXybQE2Zd5H3RjITEkYhCl76YMXi0g
	 8tKbtMhXQDFq9Ia62KC5elHhYGHlWs+mUO1lHlHp4J5yGyOIRlJItiiKc/qtMN2qK+
	 hHGNajjxo3sdjtJXtMkYbulTc7M1NbCxjT/IwXAHeaLeSmXCpZ6Ohd6VCyYV8cNyCQ
	 SjfprzgtTE0mrDC+kAAZzpaKsBT1R86EiQHXMQ5Zv2YV/esNOhlrdVBSD6neYAzgTw
	 zH1OT5h+kJrGHOfkBausQChQ8CHsUbD8asn6JFLEYslvLspDNqfb5Y0p9xBJsg7p7N
	 uDCRmX+rpaMTA==
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
Subject: [net-next V2 11/15] net/mlx5e: E-Switch, Fix shared fdb error flow
Date: Fri, 23 Jun 2023 12:29:03 -0700
Message-ID: <20230623192907.39033-12-saeed@kernel.org>
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

On error flow resources being freed in esw_master_egress_destroy_resources()
but pointers not being set to null if error flow is from creating a
bounce rule. Then in esw_acl_egress_ofld_cleanup() we try to access already
freed pointers. Fix it by resetting the pointers to null.
Also if error is from creating a second or later bounce rule then the
flow group and table being used and cannot and should not be freed.
Add a check to destroy the flow group and table if there are no bounce
rules.

mlx5_core.sf mlx5_core.sf.2: mlx5_destroy_flow_group:2306:(pid 2235): Flow group 4 wasn't destroyed, refcount > 1
mlx5_core.sf mlx5_core.sf.2: mlx5_destroy_flow_table:2295:(pid 2235): Flow table 3 wasn't destroyed, refcount > 1

Fixes: 5e0202eb49ed ("net/mlx5: E-switch, Handle multiple master egress rules")
Signed-off-by: Roi Dayan <roid@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 612be82a8ad5..cf58295ad7e2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2618,8 +2618,12 @@ static int esw_master_egress_create_resources(struct mlx5_eswitch *esw,
 
 static void esw_master_egress_destroy_resources(struct mlx5_vport *vport)
 {
+	if (!xa_empty(&vport->egress.offloads.bounce_rules))
+		return;
 	mlx5_destroy_flow_group(vport->egress.offloads.bounce_grp);
+	vport->egress.offloads.bounce_grp = NULL;
 	mlx5_destroy_flow_table(vport->egress.acl);
+	vport->egress.acl = NULL;
 }
 
 static int esw_set_master_egress_rule(struct mlx5_core_dev *master,
-- 
2.41.0


