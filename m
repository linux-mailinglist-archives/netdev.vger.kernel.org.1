Return-Path: <netdev+bounces-40448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF537C76BD
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3A51C210A9
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 19:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70503CCED;
	Thu, 12 Oct 2023 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKtzrtZJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F473CCEB
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 19:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936B5C433C8;
	Thu, 12 Oct 2023 19:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697138883;
	bh=MYHtN/b6jy9FXE9gfYCbOZ8VlLWid2hpiac/gm413RQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rKtzrtZJIkumAAAEeCHnw2DVioxUmGtS8CxKYBFsq6SoGHcCK/t5NAYmLuKCMt/Df
	 Ij/5Ca58RpLRtpc9AwvxgzdcCU+WhsVjuhUWYAKzvNxLCGKfwawK70DGcKajYHdhgW
	 /wTBSdKl+27DfoDi6JeYFNYuXL3H3gUlHcKLXRsf+NJrkL3TQBjJ75H4HrpNeMwyf5
	 gidP03R+g5Tm/EsXXyTjd2WTEmdDSxWVHbKr5RSCNu8NrceA5olyD2W+af47a3XQDY
	 WGxlt0aa8ZX24MKQuk7ZilpueKn8TfqP2+T/lgZi7D5wo2g5f4fO/tWI96jkfj8hut
	 XqYsPfw5nXSww==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Adham Faris <afaris@nvidia.com>
Subject: [net-next V2 11/15] net/mlx5e: Refactor mlx5e_rss_set_rxfh() and mlx5e_rss_get_rxfh()
Date: Thu, 12 Oct 2023 12:27:46 -0700
Message-ID: <20231012192750.124945-12-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012192750.124945-1-saeed@kernel.org>
References: <20231012192750.124945-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adham Faris <afaris@nvidia.com>

Initialize indirect table array with memcpy rather than for loop.
This change has made for two reasons:
1) To be consistent with the indirect table array init in
   mlx5e_rss_set_rxfh().
2) In general, prefer to use memcpy for array initializing rather than
   for loop.

Signed-off-by: Adham Faris <afaris@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/rss.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
index 7f93426b88b3..fd52541e5508 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
@@ -470,11 +470,9 @@ int mlx5e_rss_packet_merge_set_param(struct mlx5e_rss *rss,
 
 int mlx5e_rss_get_rxfh(struct mlx5e_rss *rss, u32 *indir, u8 *key, u8 *hfunc)
 {
-	unsigned int i;
-
 	if (indir)
-		for (i = 0; i < MLX5E_INDIR_RQT_SIZE; i++)
-			indir[i] = rss->indir.table[i];
+		memcpy(indir, rss->indir.table,
+		       MLX5E_INDIR_RQT_SIZE * sizeof(*rss->indir.table));
 
 	if (key)
 		memcpy(key, rss->hash.toeplitz_hash_key,
@@ -523,12 +521,10 @@ int mlx5e_rss_set_rxfh(struct mlx5e_rss *rss, const u32 *indir,
 	}
 
 	if (indir) {
-		unsigned int i;
-
 		changed_indir = true;
 
-		for (i = 0; i < MLX5E_INDIR_RQT_SIZE; i++)
-			rss->indir.table[i] = indir[i];
+		memcpy(rss->indir.table, indir,
+		       MLX5E_INDIR_RQT_SIZE * sizeof(*rss->indir.table));
 	}
 
 	if (changed_indir && rss->enabled) {
-- 
2.41.0


