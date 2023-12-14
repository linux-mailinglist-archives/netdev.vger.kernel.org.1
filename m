Return-Path: <netdev+bounces-57158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A3F81248D
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE451B20797
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 01:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A5E79E22;
	Thu, 14 Dec 2023 01:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cC5LtWAl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648AD20FD
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 01:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB1AC433C9;
	Thu, 14 Dec 2023 01:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702517118;
	bh=oe/0ldL0SCZQeqyNXewTTY4haopxR8wW0k/82BOeOzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cC5LtWAlNAvCVbp3J3x5q2q9/P9E0yfo128NnVwKV/GWc9reaD/f8ZFivE0tjAg4e
	 rx6dAx5jpvvJ9wvL/uprEYqUuUvq28cVON8nK2J/U7bhMzs4r3y0LkR2qhFulSGg6h
	 fxGpS9xf4T1BPvNLrJrJD2tUVXJGUYNBzX/1lBTXIdU6NqruTZy0XTR4RNG8NWLpVN
	 lt8gX33XlpFCJdZ5NBKSYMP6fGeSBteYnLWgQhdlyKngLpYyrHWhvutGXwLKw7avfQ
	 GdkRfiLF8+84RIYoLDFFL0/enRX9mwoduINYljAXfcbsWYxFyyIliB6/S8AZzXVX0N
	 MY7jhJKB7UGZg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>
Subject: [net 09/15] net/mlx5e: XDP, Drop fragmented packets larger than MTU size
Date: Wed, 13 Dec 2023 17:24:59 -0800
Message-ID: <20231214012505.42666-10-saeed@kernel.org>
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

From: Carolina Jubran <cjubran@nvidia.com>

XDP transmits fragmented packets that are larger than MTU size instead of
dropping those packets. The drop check that checks whether a packet is larger
than MTU is comparing MTU size against the linear part length only.

Adjust the drop check to compare MTU size against both linear and non-linear
part lengths to avoid transmitting fragmented packets larger than MTU size.

Fixes: 39a1665d16a2 ("net/mlx5e: Implement sending multi buffer XDP frames")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 7decc81ed33a..13c7ed1bb37e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -493,6 +493,7 @@ mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
 	dma_addr_t dma_addr = xdptxd->dma_addr;
 	u32 dma_len = xdptxd->len;
 	u16 ds_cnt, inline_hdr_sz;
+	unsigned int frags_size;
 	u8 num_wqebbs = 1;
 	int num_frags = 0;
 	bool inline_ok;
@@ -503,8 +504,9 @@ mlx5e_xmit_xdp_frame(struct mlx5e_xdpsq *sq, struct mlx5e_xmit_data *xdptxd,
 
 	inline_ok = sq->min_inline_mode == MLX5_INLINE_MODE_NONE ||
 		dma_len >= MLX5E_XDP_MIN_INLINE;
+	frags_size = xdptxd->has_frags ? xdptxdf->sinfo->xdp_frags_size : 0;
 
-	if (unlikely(!inline_ok || sq->hw_mtu < dma_len)) {
+	if (unlikely(!inline_ok || sq->hw_mtu < dma_len + frags_size)) {
 		stats->err++;
 		return false;
 	}
-- 
2.43.0


