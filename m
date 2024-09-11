Return-Path: <netdev+bounces-127556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9BE975B95
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46499283725
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6C21BC9F6;
	Wed, 11 Sep 2024 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2kZRYH2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983E01BC9EF
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085891; cv=none; b=JKsPh5hEVsKwrVtjeR5Lp6lFasiM3zW0xMhp2vLYpryWd352P0a2Ewh2Bjbxvs7R+GVC49JvLhvEXhHGfQE8sQ9ARQeFo3+clbeI5GOI1t9OCUxOVuxl5NRGIYu3z+i5K4qMdGdA4feMyMGnzUsCwBqUbyKxN2Pw50jRyn7v+hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085891; c=relaxed/simple;
	bh=6uUuu+csHF6SvcQYbb09/cdTCd0l+VTCR6V+o0xMgA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MiduIDUat1HDWRYhGzNTLbX32Ru4S8fc7DIWBwpYy38CAgQ2n9snfX8+VTrr13B2mqggnoJQy4KxxoaassSpnDEtIWkTYIeWYZBiRT6lMipFRx1FDtFrhKrv8BmQuOQ32wiEk8Y3GbKQN9brhsBU44ydJ6cgikGKNx4iaAgYbww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2kZRYH2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E22EC4CEC6;
	Wed, 11 Sep 2024 20:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726085891;
	bh=6uUuu+csHF6SvcQYbb09/cdTCd0l+VTCR6V+o0xMgA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l2kZRYH2TCi0SyaPSMezvM8mZoETE7Z9gP0YnfJMjcxy1svWU9LzqkZu/WvgWVG91
	 /bq3w1DyNbil4OM4B1a4+G19j4H4stw2MB6bHP3L7GWbMbAnQBDwiokB8KTrRc1QLD
	 sFU/FYFhTZhZWpBl6Z1HyaMGn8Dl5QN/a7mZQC9ZP9RG12lgIM0hMEXaycdHUwGIZz
	 4/ZLDwdKjZOzN9iaJwLdxdlt53fIagRylkeQYGf13mIgSMwwL+C5eeNnKkWhlAogGC
	 Sowr3EpxyJyqrbTaCMNblOCv19CCju4vvQCSwZ3p4IyzUvF1EKzxUitZcLR+KaOrIk
	 KwfpLfcxgUiCg==
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
	Shay Drory <shayd@nvidia.com>
Subject: [net-next 12/15] net/mlx5: Allow users to configure affinity for SFs
Date: Wed, 11 Sep 2024 13:17:54 -0700
Message-ID: <20240911201757.1505453-13-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911201757.1505453-1-saeed@kernel.org>
References: <20240911201757.1505453-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shay Drory <shayd@nvidia.com>

SFs didn't allow to configure IRQ affinity for its vectors. Allow users
to configure the affinity of the SFs irqs.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index f15ecaef1331..2505f90c0b39 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -896,7 +896,7 @@ static int comp_irq_request_sf(struct mlx5_core_dev *dev, u16 vecidx)
 	if (!mlx5_irq_pool_is_sf_pool(pool))
 		return comp_irq_request_pci(dev, vecidx);
 
-	af_desc.is_managed = 1;
+	af_desc.is_managed = false;
 	cpumask_copy(&af_desc.mask, cpu_online_mask);
 	cpumask_andnot(&af_desc.mask, &af_desc.mask, &table->used_cpus);
 	irq = mlx5_irq_affinity_request(dev, pool, &af_desc);
-- 
2.46.0


