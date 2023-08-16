Return-Path: <netdev+bounces-28209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE67D77EAE6
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 22:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87862281C21
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 20:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D1D17FE5;
	Wed, 16 Aug 2023 20:41:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED8618020
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 20:41:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A34C433C9;
	Wed, 16 Aug 2023 20:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692218475;
	bh=yUYZNwaHZWlqGuiJXYcWAJtm09A+co3EMsojjcShEIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o6WrRCSolSPbniF9H90LMnRmKMArU9hdNNO3bM6Fbxni18cNa86kADSzpy8zwO85G
	 LHKZ4CSEzM7F6HOZLdvESUOmJbVnBnTVzBrpFcqHnnsoYZp9DfhEflxPGG2khZQGwL
	 qtqOeml9ILN7DzR0cm4CDEV3JU+BK7U/OUu/wMKMLJe/QEOcLaRa1yfy4oDmZwcXQm
	 MrybYwVDLOoSnhtAB9X8eeuKA4ylwBhS+nbCSs89w5jyBQFe9ZRXlnTFsmXwMV8NDa
	 LbRKCHZMi3vGdGro8k+Cr3QZziEHphlIQY8HafzHmB6xttPwFn3SbTM/gAFu92lXwG
	 bX90Q+6LqH0yw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: [net 1/2] net/mlx5e: XDP, Fix fifo overrun on XDP_REDIRECT
Date: Wed, 16 Aug 2023 13:41:07 -0700
Message-ID: <20230816204108.53819-2-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816204108.53819-1-saeed@kernel.org>
References: <20230816204108.53819-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dragos Tatulea <dtatulea@nvidia.com>

Before this fix, running high rate traffic through XDP_REDIRECT
with multibuf could overrun the fifo used to release the
xdp frames after tx completion. This resulted in corrupted data
being consumed on the free side.

The culplirt was a miscalculation of the fifo size: the maximum ratio
between fifo entries / data segments was incorrect. This ratio serves to
calculate the max fifo size for a full sq where each packet uses the
worst case number of entries in the fifo.

This patch fixes the formula and names the constant. It also makes sure
that future values will use a power of 2 number of entries for the fifo
mask to work.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Fixes: 3f734b8c594b ("net/mlx5e: XDP, Use multiple single-entry objects in xdpi_fifo")
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h  | 2 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 8 +++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
index 9e8e6184f9e4..ecfe93a479da 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
@@ -84,6 +84,8 @@ enum mlx5e_xdp_xmit_mode {
  * MLX5E_XDP_XMIT_MODE_XSK:
  *    none.
  */
+#define MLX5E_XDP_FIFO_ENTRIES2DS_MAX_RATIO 4
+
 union mlx5e_xdp_info {
 	enum mlx5e_xdp_xmit_mode mode;
 	union {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index c27df14df145..f7b494125eee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1298,11 +1298,13 @@ static int mlx5e_alloc_xdpsq_fifo(struct mlx5e_xdpsq *sq, int numa)
 {
 	struct mlx5e_xdp_info_fifo *xdpi_fifo = &sq->db.xdpi_fifo;
 	int wq_sz        = mlx5_wq_cyc_get_size(&sq->wq);
-	int entries = wq_sz * MLX5_SEND_WQEBB_NUM_DS * 2; /* upper bound for maximum num of
-							   * entries of all xmit_modes.
-							   */
+	int entries;
 	size_t size;
 
+	/* upper bound for maximum num of entries of all xmit_modes. */
+	entries = roundup_pow_of_two(wq_sz * MLX5_SEND_WQEBB_NUM_DS *
+				     MLX5E_XDP_FIFO_ENTRIES2DS_MAX_RATIO);
+
 	size = array_size(sizeof(*xdpi_fifo->xi), entries);
 	xdpi_fifo->xi = kvzalloc_node(size, GFP_KERNEL, numa);
 	if (!xdpi_fifo->xi)
-- 
2.41.0


