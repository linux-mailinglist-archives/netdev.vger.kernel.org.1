Return-Path: <netdev+bounces-69335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7BA84AB3F
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 01:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9667D289BCC
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 00:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF2415C0;
	Tue,  6 Feb 2024 00:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9bGi/Ka"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAF0AD4E
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 00:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707180947; cv=none; b=Rn6+YlhmXD0kwnx2NP5khFNWNu3xIskpzNcbIvPpIcDcpqf7uAEz89apVg0J2TOJWUtusI+ju6lJwIM2O0LpVcaLD2fZNUIMNQgCvnXkq/iX79EN3QRCA5vryEciSFVuvMpbv9aEm1tWIh5Lr3xqAm92btfKTIAF32a7rZDOWfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707180947; c=relaxed/simple;
	bh=EtJCnlUQ+/lcfWm2qky+KCm7H4BTHXhsSyU+FmhFrYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4QerppxrdylhJYDo8OhICteAEMGKK3uNGC37IdJvWW1mym/cqVgocKWXZWyL9+mSxtECIkv5SoGlIDK74zrYDZhFlQUmTxxfM7DkwlLl3RqWrxnryg8MntuQdnMFNxRTqyJCxDe+9yMoL9PJ64NjAsNCiJTXMbhWOd0mjCepYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9bGi/Ka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F108C43390;
	Tue,  6 Feb 2024 00:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707180947;
	bh=EtJCnlUQ+/lcfWm2qky+KCm7H4BTHXhsSyU+FmhFrYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k9bGi/KauGAebMnhZTO2QAHzk5C9fkvG3qfesERP/7h8vfJwTGJkUx98G5QB7uDG7
	 rFrVACo67G1vkMPCo+B88lNYpGpaPaCheiwfYB5+vcrpqAxOF/RLUCuP5+RKyegMhP
	 +Au9M1WQjoaJRuSU1x7BKFKYisQ/NoZw9rXsyRH515/yTzy1nomiU2MOINy09esm+v
	 SKcq0pHYndjNtTX/12wLzTmlZVAizqZLH6uR2fTdogOs382bi03FrsoIC8a/YEO+6L
	 ftyNIR5GHTQSv5DSqGvT7Do9NxXxSJ1QIdS1DEi0OLXKMXxMmLpdzAvuStJ/2EblYp
	 2os/uxNTI4Hzw==
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
Subject: [net-next V4 14/15] net/mlx5e: XSK, Exclude tailroom from non-linear SKBs memory calculations
Date: Mon,  5 Feb 2024 16:55:26 -0800
Message-ID: <20240206005527.1353368-15-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206005527.1353368-1-saeed@kernel.org>
References: <20240206005527.1353368-1-saeed@kernel.org>
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


