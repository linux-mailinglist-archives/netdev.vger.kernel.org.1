Return-Path: <netdev+bounces-57151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39794812485
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03DA282799
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 01:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D856E63D;
	Thu, 14 Dec 2023 01:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ckw5vqqL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A6DECB
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 01:25:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32438C433C7;
	Thu, 14 Dec 2023 01:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702517111;
	bh=IoQAmO1stQ3t8fpUpzJkKMnyQbHMFhP7B/uvngiaX/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ckw5vqqLOae6BnNvA9wMxsrk+OeGIn+JlHGedd2WHoSD73+7OkKR8RuyLeXMLYwuO
	 iD6s+VOZyBvRTNMkjr993NEnefKPuMHFhvYPimdShXWqvE9BloUGrDkb8KuxMLTGHS
	 Um32yEyFJVNnZ2JUtNEWUzi+oHLs93m6zkoqjxGjV+rNEBybAuJfvWkQ2dOntUOsyf
	 um016aCR3yQQ6RQa70KbBzOCWis9M5OyI+VW2YVc468pI2yWPqekV9jLV8ollMtDZ7
	 bLGiDIDltbc6LyLNezIiqhxI2fCMxRmvFqxV2773Kgpt9c+UkL6yCO7GZ4rKJiaPsw
	 jvzKUicoGemgw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Vlad Buslov <vladbu@nvidia.com>
Subject: [net 02/15] Revert "net/mlx5e: fix double free of encap_header"
Date: Wed, 13 Dec 2023 17:24:52 -0800
Message-ID: <20231214012505.42666-3-saeed@kernel.org>
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

This reverts commit 6f9b1a0731662648949a1c0587f6acb3b7f8acf1.

This patch is causing a null ptr issue, the proper fix is in the next
patch.

Fixes: 6f9b1a073166 ("net/mlx5e: fix double free of encap_header")
Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
index 8bca696b6658..00a04fdd756f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
@@ -300,6 +300,9 @@ int mlx5e_tc_tun_create_header_ipv4(struct mlx5e_priv *priv,
 	if (err)
 		goto destroy_neigh_entry;
 
+	e->encap_size = ipv4_encap_size;
+	e->encap_header = encap_header;
+
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(attr.n, NULL);
 		/* the encap entry will be made valid on neigh update event
@@ -319,8 +322,6 @@ int mlx5e_tc_tun_create_header_ipv4(struct mlx5e_priv *priv,
 		goto destroy_neigh_entry;
 	}
 
-	e->encap_size = ipv4_encap_size;
-	e->encap_header = encap_header;
 	e->flags |= MLX5_ENCAP_ENTRY_VALID;
 	mlx5e_rep_queue_neigh_stats_work(netdev_priv(attr.out_dev));
 	mlx5e_route_lookup_ipv4_put(&attr);
@@ -567,6 +568,9 @@ int mlx5e_tc_tun_create_header_ipv6(struct mlx5e_priv *priv,
 	if (err)
 		goto destroy_neigh_entry;
 
+	e->encap_size = ipv6_encap_size;
+	e->encap_header = encap_header;
+
 	if (!(nud_state & NUD_VALID)) {
 		neigh_event_send(attr.n, NULL);
 		/* the encap entry will be made valid on neigh update event
@@ -586,8 +590,6 @@ int mlx5e_tc_tun_create_header_ipv6(struct mlx5e_priv *priv,
 		goto destroy_neigh_entry;
 	}
 
-	e->encap_size = ipv6_encap_size;
-	e->encap_header = encap_header;
 	e->flags |= MLX5_ENCAP_ENTRY_VALID;
 	mlx5e_rep_queue_neigh_stats_work(netdev_priv(attr.out_dev));
 	mlx5e_route_lookup_ipv6_put(&attr);
-- 
2.43.0


