Return-Path: <netdev+bounces-68691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A954A84796C
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 20:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5FE51C29092
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 19:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B465B12F37D;
	Fri,  2 Feb 2024 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTgSFNqH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C5512F37A
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900957; cv=none; b=b09ugOdMYCuaPP79KWMMWsr66eIZ3hg1WQjnYMRPWLrElCk36lSHhM8bf8CAUDqzBA1IPCLGDZJL/5Dfne1dcq2m/uPGZKS32IqGcu/WIqpyo7WPW17QKaYd1hSBmo8tyRHb7aEWgHE+FRxZmtXf1Aav8N6GoBAmt05/R7v4nvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900957; c=relaxed/simple;
	bh=Ars+QwO+yKKX8DHQIcvpOtaIIspa+mTb1s5wBZB/tQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PtycG6IV6RLMiWFPvMW/Q/LEek/J5mBJuomKWcBSeTMPG6XW3e3AZ3d//GKKz0rK+2tVQoxznVdhel+ZOPa6zmgVA8NMO5WuPR0EPKuazQxgSb8EwxebJmQ3BWXQMuGYFpO326HEtLOdmrmiOdHLIQBt5bp8fLBDndQ/4rSJ268=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTgSFNqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F270DC43390;
	Fri,  2 Feb 2024 19:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706900957;
	bh=Ars+QwO+yKKX8DHQIcvpOtaIIspa+mTb1s5wBZB/tQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JTgSFNqHXkPUG+M4ts1xtoa0rGKWSYwOADjUVlgnbsXrAGIVoZYxT4ypGvDL880oC
	 KFE5oVcxgk8om+i42rvj0pjP466uZR65F5CVbLC1+L2oRViQ48cEs3PncFUVrtczo/
	 /q09NbRvQ+pKZqBgdj0iyvE9CVWbKRhCy07lwNHx7Gj8AW5cNvP3K0Ww0+l3rKHo9q
	 XBMdVWDgNppPc3DyENYQBfOyvvrsaSZJ6p2YC0FHMYjlu+xL1lcToN+yeEnE68YX7T
	 xB9/9bFtPuA2iMAEJKFG5M4g8JNfLEfWST3yAWs554QPBahy3fyHSiC671ILs8Svsu
	 Hh3xi/VtNoPrw==
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
Subject: [net-next V3 15/15] net/mlx5e: XDP, Exclude headroom and tailroom from memory calculations
Date: Fri,  2 Feb 2024 11:08:54 -0800
Message-ID: <20240202190854.1308089-16-saeed@kernel.org>
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


