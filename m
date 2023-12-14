Return-Path: <netdev+bounces-57150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4C2812484
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716B92825BD
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 01:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8D0802;
	Thu, 14 Dec 2023 01:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQ0ZtV5k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE6F7EF
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 01:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C393C433C8;
	Thu, 14 Dec 2023 01:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702517110;
	bh=xinlK6Jga3gljsbRQeBWDabzypgK8fCAaDEZHlBYCsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EQ0ZtV5kFKuaA9dQNN3XD5fVTDc7oQp22Z51CFzr7yJtyiYGvw979f9vfefs0k3gR
	 kwZrZ0nAJ8TZd0AB5fPZB7lZH6RVM9CvPTQMla9JlsayudgswvCnK9f/cdtFnN4vJm
	 C84v2rsqrobow0MJlsEYL4i6OJLFYWnci8eqDdED9wGJY4YW3pHQQiYAL3eGoc2fDy
	 NBST7OQVmKzwvDZIzmLRRI0ytvbT8BM2Wfvvv+TjBJLgwf5115i4YeZHEXmGsoco/O
	 t80e1o245Bb0KzXeaf1MWLt/lgacy8a++WA9nV+uii8n3H7TcneKA9qxa7VOqXyGyy
	 lgeuTaamdYxbg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Vlad Buslov <vladbu@nvidia.com>
Subject: [net 01/15] Revert "net/mlx5e: fix double free of encap_header in update funcs"
Date: Wed, 13 Dec 2023 17:24:51 -0800
Message-ID: <20231214012505.42666-2-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214012505.42666-1-saeed@kernel.org>
References: <20231214012505.42666-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vlad Buslov <vladbu@nvidia.com>

This reverts commit 3a4aa3cb83563df942be49d145ee3b7ddf17d6bb.

This patch is causing a null ptr issue, the proper fix is in the next
patch.

Fixes: 3a4aa3cb8356 ("net/mlx5e: fix double free of encap_header in update funcs")
Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en/tc_tun.c   | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
index 668da5c70e63..8bca696b6658 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
@@ -403,12 +403,16 @@ int mlx5e_tc_tun_update_header_ipv4(struct mlx5e_priv *priv,
 	if (err)
 		goto free_encap;
 
+	e->encap_size = ipv4_encap_size;
+	kfree(e->encap_header);
+	e->encap_header = encap_header;
+
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(attr.n, NULL);
 		/* the encap entry will be made valid on neigh update event
 		 * and not used before that.
 		 */
-		goto free_encap;
+		goto release_neigh;
 	}
 
 	memset(&reformat_params, 0, sizeof(reformat_params));
@@ -422,10 +426,6 @@ int mlx5e_tc_tun_update_header_ipv4(struct mlx5e_priv *priv,
 		goto free_encap;
 	}
 
-	e->encap_size = ipv4_encap_size;
-	kfree(e->encap_header);
-	e->encap_header = encap_header;
-
 	e->flags |= MLX5_ENCAP_ENTRY_VALID;
 	mlx5e_rep_queue_neigh_stats_work(netdev_priv(attr.out_dev));
 	mlx5e_route_lookup_ipv4_put(&attr);
@@ -669,12 +669,16 @@ int mlx5e_tc_tun_update_header_ipv6(struct mlx5e_priv *priv,
 	if (err)
 		goto free_encap;
 
+	e->encap_size = ipv6_encap_size;
+	kfree(e->encap_header);
+	e->encap_header = encap_header;
+
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(attr.n, NULL);
 		/* the encap entry will be made valid on neigh update event
 		 * and not used before that.
 		 */
-		goto free_encap;
+		goto release_neigh;
 	}
 
 	memset(&reformat_params, 0, sizeof(reformat_params));
@@ -688,10 +692,6 @@ int mlx5e_tc_tun_update_header_ipv6(struct mlx5e_priv *priv,
 		goto free_encap;
 	}
 
-	e->encap_size = ipv6_encap_size;
-	kfree(e->encap_header);
-	e->encap_header = encap_header;
-
 	e->flags |= MLX5_ENCAP_ENTRY_VALID;
 	mlx5e_rep_queue_neigh_stats_work(netdev_priv(attr.out_dev));
 	mlx5e_route_lookup_ipv6_put(&attr);
-- 
2.43.0


