Return-Path: <netdev+bounces-67861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD10684520B
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 08:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C84428F755
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 07:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E8115AAAC;
	Thu,  1 Feb 2024 07:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptYJzAsu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753631386AD
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 07:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706772753; cv=none; b=szz+cQzs0eFNf9GR/DyvEwitLGNbAPBXfVy1akKwoth8z9x44TqXEm4MECopuFE9LQPVvy5XghEJVjswn+EIeUMl4aiLPviLnkfrBNO75EM/xOQtRCW8duSXnsEaHLPk12+UEyVtRTLtefPqRyjJRiuANpwY31AHLbgKQaQbUR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706772753; c=relaxed/simple;
	bh=Ars+QwO+yKKX8DHQIcvpOtaIIspa+mTb1s5wBZB/tQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1YArb96S/vPgzk2qdHk6b/S+fMBq1rA9TxrWwQK5eFhLPx95aFUkABUW9eOisduW3q7s7WGabkxZhOR6a3kiusUWF5NRZGaoY7JHTbz8CIpVv2LFYuFxkk5cAqh2ofrnNzH/9eii/ISgQcZHBzGcMFEYyRCmsI9BkSNq/ZN1F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptYJzAsu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E0CC433B2;
	Thu,  1 Feb 2024 07:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706772753;
	bh=Ars+QwO+yKKX8DHQIcvpOtaIIspa+mTb1s5wBZB/tQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ptYJzAsu67bXh4ioYULQ86dHbdSO95wSuB4TbZTkwlhPNqcU1gYHtg2r4udS8+PwF
	 uaPoQL+jN6jbuxuPuo3xvvvrLTkD7u6fAtSefwM0pS1t8BR+0DAVfSKBRpzHkabKPg
	 0ssG3CGZ6j9x+MljFZ1GltLM9AArkHNfkt90lHtVEJwe1Uw6l7lgYPZRZ4Ry9Y+DQa
	 WDrxhCqmRv+KIiwh5OXLKi6JJjgLr142mT6qTyJLZ1BFD/yvkhE5PqK02+ni7RsJX9
	 Y5g+nWF69tHsEobElrhElOnwcLfTQoVmveca7ceR+NvnPgeDlgD8HNKBKfcdYJLYOi
	 6TZQvvh6gyhig==
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
Subject: [net-next V2 15/15] net/mlx5e: XDP, Exclude headroom and tailroom from memory calculations
Date: Wed, 31 Jan 2024 23:31:58 -0800
Message-ID: <20240201073158.22103-16-saeed@kernel.org>
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


