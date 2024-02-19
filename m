Return-Path: <netdev+bounces-73044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D3B85AAE8
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 19:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A1C28243E
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B42482CB;
	Mon, 19 Feb 2024 18:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNZUqK5o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2586481DB
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 18:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367013; cv=none; b=Q3GExCZKoUctY8IDdof2e7TwbXc82Vb2FV8Gl7rrQSnN0b40WiThxB5U114u/XUQdq3XuIsHxeJT2aNqiPjZt5vU++KvELm3PHNIb5QL7WrShq413t0bYWRjv7/C8Sl915kW5FCKnI8lWsPq6MxNt/XwFJ6Pye5TUlFNpGouqL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367013; c=relaxed/simple;
	bh=Ga0TZcUYanXDP+17fFxdQ3JQJMZkoYNKWXAdeyxEYlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tT2Cfo2BOmvwVVM1ibzzwPEOBiQgRGftc5KSASlBYrmDaTJdHnuPOiAYCEVCckuMQzxKvIrPpljv4X0xHjAGYGpf4fnkvt9wF1p13g3e2ckDtb4m58kmXJv3GXWdwtqny6OT01u+5QOXZA/e2rHWLRGeg7ZODOuhUVlL0bLRBkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNZUqK5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF2AC43399;
	Mon, 19 Feb 2024 18:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708367013;
	bh=Ga0TZcUYanXDP+17fFxdQ3JQJMZkoYNKWXAdeyxEYlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SNZUqK5oZqpJLQlNDNAgaioQRuTgOQ2lZH9tLaRd3zr+gjfY822E0yyA9auQZY0cW
	 xuW3P2Cp+Kxu6jrOkyC7dlNOk0Ck6nkqsjG0zLjEe1BK4JX2Y715xKe8G8/oovjBfp
	 EhQyxt4SSMEnaT1T338uvOQ8vmByhwDLqKTmDBgUAfw+td4xhRinb8VIky5rXBe2bZ
	 H1/Y6gVPgsJYGgA8MeRtsxaWhO1/xonXDiXP8vhFV/oWrXipmPJ9+BCDm375lg5Et/
	 q/rmqraXG3HqVmTtb+Qydse0cBv72N8/5ucFO4Ml5Q7JEKAUS+DEOjhz91G6lC71gs
	 sONJmPtgSIYxw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [net 03/10] net/mlx5: E-switch, Change flow rule destination checking
Date: Mon, 19 Feb 2024 10:23:13 -0800
Message-ID: <20240219182320.8914-4-saeed@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219182320.8914-1-saeed@kernel.org>
References: <20240219182320.8914-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

The checking in the cited commit is not accurate. In the common case,
VF destination is internal, and uplink destination is external.
However, uplink destination with packet reformat is considered as
internal because firmware uses LB+hairpin to support it. Update the
checking so header rewrite rules with both internal and external
destinations are not allowed.

Fixes: e0e22d59b47a ("net/mlx5: E-switch, Add checking for flow rule destinations")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c     | 23 +++++++++++--------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 14b3bd3c5e2f..baaae628b0a0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -535,21 +535,26 @@ esw_src_port_rewrite_supported(struct mlx5_eswitch *esw)
 }
 
 static bool
-esw_dests_to_vf_pf_vports(struct mlx5_flow_destination *dests, int max_dest)
+esw_dests_to_int_external(struct mlx5_flow_destination *dests, int max_dest)
 {
-	bool vf_dest = false, pf_dest = false;
+	bool internal_dest = false, external_dest = false;
 	int i;
 
 	for (i = 0; i < max_dest; i++) {
-		if (dests[i].type != MLX5_FLOW_DESTINATION_TYPE_VPORT)
+		if (dests[i].type != MLX5_FLOW_DESTINATION_TYPE_VPORT &&
+		    dests[i].type != MLX5_FLOW_DESTINATION_TYPE_UPLINK)
 			continue;
 
-		if (dests[i].vport.num == MLX5_VPORT_UPLINK)
-			pf_dest = true;
+		/* Uplink dest is external, but considered as internal
+		 * if there is reformat because firmware uses LB+hairpin to support it.
+		 */
+		if (dests[i].vport.num == MLX5_VPORT_UPLINK &&
+		    !(dests[i].vport.flags & MLX5_FLOW_DEST_VPORT_REFORMAT_ID))
+			external_dest = true;
 		else
-			vf_dest = true;
+			internal_dest = true;
 
-		if (vf_dest && pf_dest)
+		if (internal_dest && external_dest)
 			return true;
 	}
 
@@ -695,9 +700,9 @@ mlx5_eswitch_add_offloaded_rule(struct mlx5_eswitch *esw,
 
 		/* Header rewrite with combined wire+loopback in FDB is not allowed */
 		if ((flow_act.action & MLX5_FLOW_CONTEXT_ACTION_MOD_HDR) &&
-		    esw_dests_to_vf_pf_vports(dest, i)) {
+		    esw_dests_to_int_external(dest, i)) {
 			esw_warn(esw->dev,
-				 "FDB: Header rewrite with forwarding to both PF and VF is not allowed\n");
+				 "FDB: Header rewrite with forwarding to both internal and external dests is not allowed\n");
 			rule = ERR_PTR(-EINVAL);
 			goto err_esw_get;
 		}
-- 
2.43.2


