Return-Path: <netdev+bounces-68690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC8584796B
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 20:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE441C29050
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 19:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8621412F370;
	Fri,  2 Feb 2024 19:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoLBeBiF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D2F12F36F
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 19:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900956; cv=none; b=AQO3kpPzxSfKxR1dI/fhDSYa5s9ru2FImFICuY2aAfj+vBydXhBBg80cg0ICczjAGKVYcvngk2MRhwA5Rbxano+KmxKBPv6AS15875CcA/YwOefgzhLvhasX14bqUL0ZD06m121rw+aY6v8SrKIy2cYjW4foUGxHdCBd6r4GJO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900956; c=relaxed/simple;
	bh=EtJCnlUQ+/lcfWm2qky+KCm7H4BTHXhsSyU+FmhFrYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9lSJXm/J9kU9TdiKWwqNnc07QShUEa4WotBMP+0rmsgviuLimgUdr7XHB5sJyFhAfBVs7JUHNzl43BN1sy7HsSxcgj3wi5e10Hyz1X5sg5LWo1PHOHyrAyyBee+JfM/cIiMYDpXiWM3j0p8hham/eyaSx57+3/FQ7kvbH9fa4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoLBeBiF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7BEC433C7;
	Fri,  2 Feb 2024 19:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706900955;
	bh=EtJCnlUQ+/lcfWm2qky+KCm7H4BTHXhsSyU+FmhFrYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XoLBeBiFv7icyjxzIX4zRsF7LBxfoh1r011TdyHDmlmhkIlqP4UH6IdZjs54MRqLs
	 oriH2yE92xLcKK7DshiCqbiz8SK6otOfAFjgWL7CgeiFbMm/QPylkGJHX+hDJ2JaRJ
	 zLTfROzCjS/r0WMbb7yRntbo0f3wmw0GevVHAto4ce57CIS3uE+7qSoSwfmNB2R/63
	 GhNmoIcUlKfMWng0ImYZWQezn5En0DI7DHuXuY4BWTBRRmgKIIYgRijALRsHSVdTkO
	 tAXO7F2yW1DZfQ0mE7fqyFC08ci1lESmFMInGJscQYfBe4cXiaDMGYDVdmB0NO04pI
	 6TH3bNNYugulQ==
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
Subject: [net-next V3 14/15] net/mlx5e: XSK, Exclude tailroom from non-linear SKBs memory calculations
Date: Fri,  2 Feb 2024 11:08:53 -0800
Message-ID: <20240202190854.1308089-15-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202190854.1308089-1-saeed@kernel.org>
References: <20240202190854.1308089-1-saeed@kernel.org>
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


