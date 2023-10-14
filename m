Return-Path: <netdev+bounces-41022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470397C95A6
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 19:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA198B20CF1
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 17:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDEF266DE;
	Sat, 14 Oct 2023 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHUaQZ7f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BFD266B3
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 17:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E36C433C8;
	Sat, 14 Oct 2023 17:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697303974;
	bh=UjgDFS/5IMOelL8eFxVzyB8902e7kAOJfC6v3aeei18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RHUaQZ7fdW89LXO1hC38jOlrv0wir9TcV5nvQMhIb9d69TUbA4lyytyV3fbH7Q9/C
	 SJ1AOOqiZehNjII3pWYzqqZNRWkxGEkYNYCWNAhD9kfVAYcLZ+rCDSfgPLbLVBsvW0
	 eHXZocqE3JbgSRziOPdjsr8mSl1Uq3BvObvo+TS86GhBk4iXSPnLTywmOqAXkuTZK9
	 F5+TDuu2/p2YHX7wtrwHWW1T9mt1NE9ugmtTnceD2q7ku4F41fNdM/AtpK5yHRlOaP
	 iinmQ9rDEfpsdIrTMsLVi+cwN2EnQs3bBOmPAeBtDy9UF1CnEaHFnrpMebaXo1547B
	 lAUoD9TuHaAAA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Adham Faris <afaris@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [net-next V3 11/15] net/mlx5e: Refactor mlx5e_rss_set_rxfh() and mlx5e_rss_get_rxfh()
Date: Sat, 14 Oct 2023 10:19:04 -0700
Message-ID: <20231014171908.290428-12-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014171908.290428-1-saeed@kernel.org>
References: <20231014171908.290428-1-saeed@kernel.org>
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
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
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


