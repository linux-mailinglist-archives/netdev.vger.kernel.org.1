Return-Path: <netdev+bounces-67860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B84F084520A
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 08:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74DF028F524
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 07:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3180E15AAB2;
	Thu,  1 Feb 2024 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sy7Rrc1M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DACB15AAA6
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772752; cv=none; b=Sh79qjaZ9cNXptIy/Kr5TI7C7gCaoiIKmdJA2Yy3t32lF6GsGgt701/9q9LoMD+Ghh8UG+wRkP6XxZG0CHTtBnDlHJit7Rgw7xX/2Hw5lq6/GspraCttYr+tzkvWkz5a29BTZPbbtlkXIQP2kZW8/vxXsgNnGWTbGVfWFG5XoRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772752; c=relaxed/simple;
	bh=EtJCnlUQ+/lcfWm2qky+KCm7H4BTHXhsSyU+FmhFrYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcPa5/GTxksfGogP8DDR8Zr1HDaG/9ra7TwM31sARxdEwlPlBnY7v64OeY7tylyyWnUbnBnmjJk69Ivzu6Fzx9UUIgdh+KWKcxVCyl6moX5FufLESzdOhcOd6HqJRDHdjsPJFBMXUAHeeRJByjIyokqORg2jL8a+lrB0aGbj2zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sy7Rrc1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B717C43394;
	Thu,  1 Feb 2024 07:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706772751;
	bh=EtJCnlUQ+/lcfWm2qky+KCm7H4BTHXhsSyU+FmhFrYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sy7Rrc1Mh5622dxg6Lr4h3EQt3J7My0TzNOvO5Oo+8PhnICMPDUQse7xVLPW7Zr2Y
	 GORjGpDVkyD5QQIBUQxmiR0rY3f7g2rsmSzye/KOYATVp0d2tW8lY6OtclOIptKi3r
	 hrvt1DyMZFPdQztgSgvsxoNDCjAaXRsqVYQq5pHW/+Gp9DUX65UrziltaJYzUg3I/4
	 6RZJm31A2Gq+ugTh2MbKjEkZ2mEszdetxBPuAB4aI1NOk7tLw2y7usMbi2TMu1oZGG
	 p9hf+8YvTnuQp8t8/b+I8ir9DnAjYn6z3Mca0Qre5Ypr5U4tI9kdqiuj3qMx4s96Ol
	 Ovi9lDGcK0d4g==
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
	Carolina Jubran <cjubran@nvidia.com>
Subject: [net-next V2 14/15] net/mlx5e: XSK, Exclude tailroom from non-linear SKBs memory calculations
Date: Wed, 31 Jan 2024 23:31:57 -0800
Message-ID: <20240201073158.22103-15-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201073158.22103-1-saeed@kernel.org>
References: <20240201073158.22103-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carolina Jubran <cjubran@nvidia.com>

Packet data buffers lack reserved headroom or tailroom,
and SKBs are allocated on a side memory when needed.

Exclude the tailroom from the SKB size calculations.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/params.c   | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 5d213a9886f1..b9d39ef8053c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -240,11 +240,14 @@ static u32 mlx5e_rx_get_linear_sz_xsk(struct mlx5e_params *params,
 	return xsk->headroom + hw_mtu;
 }
 
-static u32 mlx5e_rx_get_linear_sz_skb(struct mlx5e_params *params, bool xsk)
+static u32 mlx5e_rx_get_linear_sz_skb(struct mlx5e_params *params, bool no_head_tail_room)
 {
-	/* SKBs built on XDP_PASS on XSK RQs don't have headroom. */
-	u16 headroom = xsk ? 0 : mlx5e_get_linear_rq_headroom(params, NULL);
 	u32 hw_mtu = MLX5E_SW2HW_MTU(params, params->sw_mtu);
+	u16 headroom;
+
+	if (no_head_tail_room)
+		return SKB_DATA_ALIGN(hw_mtu);
+	headroom = mlx5e_get_linear_rq_headroom(params, NULL);
 
 	return MLX5_SKB_FRAG_SZ(headroom + hw_mtu);
 }
@@ -289,7 +292,11 @@ bool mlx5e_rx_is_linear_skb(struct mlx5_core_dev *mdev,
 	if (params->packet_merge.type != MLX5E_PACKET_MERGE_NONE)
 		return false;
 
-	/* Both XSK and non-XSK cases allocate an SKB on XDP_PASS. Packet data
+	/* Call mlx5e_rx_get_linear_sz_skb with the no_head_tail_room parameter set
+	 * to exclude headroom and tailroom from calculations.
+	 * no_head_tail_room is true when SKB is built on XDP_PASS on XSK RQs
+	 * since packet data buffers don't have headroom and tailroom resreved for the SKB.
+	 * Both XSK and non-XSK cases allocate an SKB on XDP_PASS. Packet data
 	 * must fit into a CPU page.
 	 */
 	if (mlx5e_rx_get_linear_sz_skb(params, xsk) > PAGE_SIZE)
-- 
2.43.0


