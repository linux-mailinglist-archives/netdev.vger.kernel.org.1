Return-Path: <netdev+bounces-27495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0CB77C294
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 23:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99812812BF
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13528101F2;
	Mon, 14 Aug 2023 21:41:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2B2101D0
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 21:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABE6C433D9;
	Mon, 14 Aug 2023 21:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692049314;
	bh=D5jiYa9WTZfQhG5MRXxx/1gaLsnLpGaTfsksXhsqVhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QGnAVwWpXOVYh3vL5y2ZTZlNWRcBXPNIyB0S4K6KtxueMvxyuPr8ygIgEFl8wvoNS
	 6P5TaDx6KKjjmIPlslIuuX/ZiuHFpeAkdIE4T+yWTquWi4O/FScheGDY7bD6Ejs2so
	 pigyk+uaFRegakd6f9V+ZpABxarm9ZH3sUKkr2hnVE4yq7wm6Klv+dMv1PPExoOyD4
	 nHdzQn2TsWJwo/eR1nM4QhiRU8eKbQRygRrz7YgMOxHzlT1WVss7B9cexq7BjaWN9i
	 wqR37MuN91bZt0ol+uSUANiK72131eYjjWa9oRtBMfU7KD984bEI9fv7v1G/dijPEP
	 BwyrFmAVWlBOg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>
Subject: [net-next 06/14] net/mlx5: E-switch, Add checking for flow rule destinations
Date: Mon, 14 Aug 2023 14:41:36 -0700
Message-ID: <20230814214144.159464-7-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814214144.159464-1-saeed@kernel.org>
References: <20230814214144.159464-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

Firmware doesn't allow flow rules in FDB to do header rewrite and send
packets to both internal and uplink vports. The following syndrome
will be generated when trying to offload such kind of rules:

mlx5_core 0000:08:00.0: mlx5_cmd_out_err:803:(pid 23569): SET_FLOW_TABLE_ENTRY(0x936) op_mod(0x0) failed, status bad parameter(0x3), syndrome (0x8c8f08), err(-22)

To avoid this syndrome, add a checking before creating FTE. If a rule
with header rewrite action forwards packets to both VF and PF, an
error is returned directly.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c     | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index e391535e1ab1..46b8c60ac39a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -535,6 +535,28 @@ esw_src_port_rewrite_supported(struct mlx5_eswitch *esw)
 	       MLX5_CAP_ESW_FLOWTABLE_FDB(esw->dev, ignore_flow_level);
 }
 
+static bool
+esw_dests_to_vf_pf_vports(struct mlx5_flow_destination *dests, int max_dest)
+{
+	bool vf_dest = false, pf_dest = false;
+	int i;
+
+	for (i = 0; i < max_dest; i++) {
+		if (dests[i].type != MLX5_FLOW_DESTINATION_TYPE_VPORT)
+			continue;
+
+		if (dests[i].vport.num == MLX5_VPORT_UPLINK)
+			pf_dest = true;
+		else
+			vf_dest = true;
+
+		if (vf_dest && pf_dest)
+			return true;
+	}
+
+	return false;
+}
+
 static int
 esw_setup_dests(struct mlx5_flow_destination *dest,
 		struct mlx5_flow_act *flow_act,
@@ -671,6 +693,15 @@ mlx5_eswitch_add_offloaded_rule(struct mlx5_eswitch *esw,
 			rule = ERR_PTR(err);
 			goto err_create_goto_table;
 		}
+
+		/* Header rewrite with combined wire+loopback in FDB is not allowed */
+		if ((flow_act.action & MLX5_FLOW_CONTEXT_ACTION_MOD_HDR) &&
+		    esw_dests_to_vf_pf_vports(dest, i)) {
+			esw_warn(esw->dev,
+				 "FDB: Header rewrite with forwarding to both PF and VF is not allowed\n");
+			rule = ERR_PTR(-EINVAL);
+			goto err_esw_get;
+		}
 	}
 
 	if (esw_attr->decap_pkt_reformat)
-- 
2.41.0


