Return-Path: <netdev+bounces-69336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D475484AB40
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 01:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF7E1C22FDC
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 00:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A961866;
	Tue,  6 Feb 2024 00:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnMxkugv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81819BA31
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 00:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707180949; cv=none; b=RB5k0Wwrj88qNAHqf4eWmN/VkuT+/DFK3ssCjK8bkS4GtauQEmKiyGbnFcbS1ofXFyWwti07YB2tckK2vl/iF5EKYkHvsqxah3migJJWtzpZ8MD5myWDaF/+3na6Sg31a5DHvcfUq9JsMXw4vZmJgpTyohOh5h76tJAm2F0xQig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707180949; c=relaxed/simple;
	bh=Ars+QwO+yKKX8DHQIcvpOtaIIspa+mTb1s5wBZB/tQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jl47t/caId4bysLfaGPwSSi8hVELWZRwfRb3+QbUTcKdAdue8ZpgNZ8rjCMGqLFMPa7TujX4SEuwEM7KHEMMQBaSWRZ6M05zZ4FMTc6NjjuvQ1BAtj6TF0z5E96T+ZnHctNTiuS4kJ8N8+m8WzjCWaVZK48dAvGrcr94DtyDsUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnMxkugv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25EFC433C7;
	Tue,  6 Feb 2024 00:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707180949;
	bh=Ars+QwO+yKKX8DHQIcvpOtaIIspa+mTb1s5wBZB/tQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bnMxkugvGIDnpiD+wq3E3e/fX9Mr5p5cCeJoHpdv+FcB9MC6hYphXiEXKx2CLnJlX
	 RXjYBLFTtZmxXuJBFnK6zCTvQ8pnUezsP8wUUcyjwjsDGNS0MfAx9p6uzeFfuLDJ6d
	 X5Hn3zHgTm3VKefGrlvViaFS1KMIfj1CwlfsYS/FiO6G1zH5Z2Gg8n074Lx/Evv8GJ
	 /BAY2MFx+nCMokDDrNpjkrKvjNPEXjgnHXL002ab7SioC7KjGtBGdd4ixTM2clUMes
	 XJjamUw7nBW/ObZClBrRzMSPr2UVo0HJc5aZcmoyD+z55gT3z6ScV0MMJkLOwQIfY8
	 RdoMOxsFvvjjw==
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
Subject: [net-next V4 15/15] net/mlx5e: XDP, Exclude headroom and tailroom from memory calculations
Date: Mon,  5 Feb 2024 16:55:27 -0800
Message-ID: <20240206005527.1353368-16-saeed@kernel.org>
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

In the case of XDP Multi-Buffer with Striding RQ, an extra
page is allocated for the linear part of non-linear SKBs.

Including headroom and tailroom in the calculation may
result in an unnecessary increase in the amount of memory
allocated. This could be critical, particularly for large
MTUs (e.g. 7975B) and large RQ sizes (e.g. 8192).

In this case, the requested page pool size is 64K, but
32K would be sufficient. This causes a failure due to
exceeding the page pool size limit of 32K.

Exclude headroom and tailroom from SKB size calculations
to reduce page pool size.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index b9d39ef8053c..5757f4f10c12 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -257,6 +257,7 @@ static u32 mlx5e_rx_get_linear_stride_sz(struct mlx5_core_dev *mdev,
 					 struct mlx5e_xsk_param *xsk,
 					 bool mpwqe)
 {
+	bool no_head_tail_room;
 	u32 sz;
 
 	/* XSK frames are mapped as individual pages, because frames may come in
@@ -265,7 +266,13 @@ static u32 mlx5e_rx_get_linear_stride_sz(struct mlx5_core_dev *mdev,
 	if (xsk)
 		return mpwqe ? 1 << mlx5e_mpwrq_page_shift(mdev, xsk) : PAGE_SIZE;
 
-	sz = roundup_pow_of_two(mlx5e_rx_get_linear_sz_skb(params, false));
+	no_head_tail_room = params->xdp_prog && mpwqe && !mlx5e_rx_is_linear_skb(mdev, params, xsk);
+
+	/* When no_head_tail_room is set, headroom and tailroom are excluded from skb calculations.
+	 * no_head_tail_room should be set in the case of XDP with Striding RQ
+	 * when SKB is not linear. This is because another page is allocated for the linear part.
+	 */
+	sz = roundup_pow_of_two(mlx5e_rx_get_linear_sz_skb(params, no_head_tail_room));
 
 	/* XDP in mlx5e doesn't support multiple packets per page.
 	 * Do not assume sz <= PAGE_SIZE if params->xdp_prog is set.
-- 
2.43.0


