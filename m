Return-Path: <netdev+bounces-47844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9437EB913
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 22:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3AC7B20BF4
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 21:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D78433CDE;
	Tue, 14 Nov 2023 21:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H07K7olF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5266933077
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 21:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A21C433C9;
	Tue, 14 Nov 2023 21:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699999144;
	bh=Wyb2eZs0DfMtKWa3ozCNl2p9XpdjUL1C9e2WVWpwrVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H07K7olFL9WsIl9QjyjwlJuUS8FrGliBZQ0CF0w5kxSirZpigzyxToHi29shptDXn
	 MIoIXaZYYSPL65AHlP+mG0K8cD2DsiiQPWaKTA1NGaUSmc63LhjQz/atlx2RFVex/2
	 C3zYwkNKzYCwi+j3yPZApzosMiPt0lrBQ20v5QC+geegboULKxMZTe6wrUw70hSAyg
	 bNX/oxevrsT1BIUXrg9IoPMkwS/Gr1fMh8+EP/FiEJqcCQTa8iSbwdXdCByddSI8bE
	 vibOlu2Chj1WxQOJNDd3+XEPpFsPf2VpJRaE84Jveu5LpRfExKdQFJOhQ1hHlhJ4MW
	 R7UpxrzhNhU9w==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gavin Li <gavinl@nvidia.com>
Subject: [net V2 06/15] net/mlx5e: fix double free of encap_header in update funcs
Date: Tue, 14 Nov 2023 13:58:37 -0800
Message-ID: <20231114215846.5902-7-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114215846.5902-1-saeed@kernel.org>
References: <20231114215846.5902-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gavin Li <gavinl@nvidia.com>

Follow up to the previous patch to fix the same issue for
mlx5e_tc_tun_update_header_ipv4{6} when mlx5_packet_reformat_alloc()
fails.

When mlx5_packet_reformat_alloc() fails, the encap_header allocated in
mlx5e_tc_tun_update_header_ipv4{6} will be released within it. However,
e->encap_header is already set to the previously freed encap_header
before mlx5_packet_reformat_alloc(). As a result, the later
mlx5e_encap_put() will free e->encap_header again, causing a double free
issue.

mlx5e_encap_put()
     --> mlx5e_encap_dealloc()
         --> kfree(e->encap_header)

This patch fix it by not setting e->encap_header until
mlx5_packet_reformat_alloc() success.

Fixes: a54e20b4fcae ("net/mlx5e: Add basic TC tunnel set action for SRIOV offloads")
Signed-off-by: Gavin Li <gavinl@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en/tc_tun.c   | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
index 8bca696b6658..668da5c70e63 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
@@ -403,16 +403,12 @@ int mlx5e_tc_tun_update_header_ipv4(struct mlx5e_priv *priv,
 	if (err)
 		goto free_encap;
 
-	e->encap_size = ipv4_encap_size;
-	kfree(e->encap_header);
-	e->encap_header = encap_header;
-
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(attr.n, NULL);
 		/* the encap entry will be made valid on neigh update event
 		 * and not used before that.
 		 */
-		goto release_neigh;
+		goto free_encap;
 	}
 
 	memset(&reformat_params, 0, sizeof(reformat_params));
@@ -426,6 +422,10 @@ int mlx5e_tc_tun_update_header_ipv4(struct mlx5e_priv *priv,
 		goto free_encap;
 	}
 
+	e->encap_size = ipv4_encap_size;
+	kfree(e->encap_header);
+	e->encap_header = encap_header;
+
 	e->flags |= MLX5_ENCAP_ENTRY_VALID;
 	mlx5e_rep_queue_neigh_stats_work(netdev_priv(attr.out_dev));
 	mlx5e_route_lookup_ipv4_put(&attr);
@@ -669,16 +669,12 @@ int mlx5e_tc_tun_update_header_ipv6(struct mlx5e_priv *priv,
 	if (err)
 		goto free_encap;
 
-	e->encap_size = ipv6_encap_size;
-	kfree(e->encap_header);
-	e->encap_header = encap_header;
-
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(attr.n, NULL);
 		/* the encap entry will be made valid on neigh update event
 		 * and not used before that.
 		 */
-		goto release_neigh;
+		goto free_encap;
 	}
 
 	memset(&reformat_params, 0, sizeof(reformat_params));
@@ -692,6 +688,10 @@ int mlx5e_tc_tun_update_header_ipv6(struct mlx5e_priv *priv,
 		goto free_encap;
 	}
 
+	e->encap_size = ipv6_encap_size;
+	kfree(e->encap_header);
+	e->encap_header = encap_header;
+
 	e->flags |= MLX5_ENCAP_ENTRY_VALID;
 	mlx5e_rep_queue_neigh_stats_work(netdev_priv(attr.out_dev));
 	mlx5e_route_lookup_ipv6_put(&attr);
-- 
2.41.0


