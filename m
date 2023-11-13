Return-Path: <netdev+bounces-47451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B257EA55C
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 22:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34E91F22B6E
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 21:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9018A2E626;
	Mon, 13 Nov 2023 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhCCZWk6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747BC2E625
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 21:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6E0C433CB;
	Mon, 13 Nov 2023 21:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699909716;
	bh=Wyb2eZs0DfMtKWa3ozCNl2p9XpdjUL1C9e2WVWpwrVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hhCCZWk6wawEh8dhy/lWepa9hlJTG5ZSmcuTm1gW2beJfoNVFzKKW8dL1gX3fz3Ui
	 VJK4xAdtGAfsKkEu3ymw/n1BtdmZQj2QbSaA2lSpEUgT6PBUYYO5chxVL99zd2Co/L
	 Z/0R8tU4na7VwSGQAmzPCq/Z9Wi9bhshtoSfsAu29JVv3gugv4XMjWQCJEv1ZZCruW
	 INpIO6y1XSHYvCHfdeg2/TKP0lgxOpUuW8aLaacV+YwBv1mzk8vlVe1jv5XNOGvp9y
	 nG4T5RRRFgvomY38q10oQ3ao1wi/cxaehlwdNXrmXouJ9+Orl1gaQliGOqgmDffjOt
	 Q8PVMEFlO47RQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gavin Li <gavinl@nvidia.com>
Subject: [net 06/17] net/mlx5e: fix double free of encap_header in update funcs
Date: Mon, 13 Nov 2023 13:08:15 -0800
Message-ID: <20231113210826.47593-7-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113210826.47593-1-saeed@kernel.org>
References: <20231113210826.47593-1-saeed@kernel.org>
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


