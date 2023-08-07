Return-Path: <netdev+bounces-25155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C873773131
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 23:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 140452814DA
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E933917732;
	Mon,  7 Aug 2023 21:26:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A643317730
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 21:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DE2C433CD;
	Mon,  7 Aug 2023 21:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691443577;
	bh=LzOCvtVxdwoWm3JzDmETFTkAJQO6uLrhu9PKidmcUEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZRwU+oJV+4HvNMdcspiwCfnv8SPpzerQIVr3jx2oYUk+rHBncJkjSs+rVfnBq1agL
	 ng0/me+iFeXfI35NwUVyTcsuKNdUZGrfUHRc6J1n76kUnI1CkxWQQjd4KxFBk2jw65
	 qUiTSLFZ62oFsnjdlGICQcCyVudztisNJY0HSC/rMrl04tNOtskVszZTM2tsuuJmj1
	 SoG5X2Xn+PMin4SYSQcmufWRU+8teWCq4DXJrBxchaPsTgHMq3nQcWZGlXhqneowr6
	 7rvd+wpLai+3ggxl3TZANSL3HzYIXVpVAlqxmVe5bck+zwWSU+17lFhfRly7gv2+Xb
	 kQKtxX47ybbTg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Erez Shitrit <erezsh@nvidia.com>
Subject: [net 03/11] net/mlx5: DR, Fix wrong allocation of modify hdr pattern
Date: Mon,  7 Aug 2023 14:25:59 -0700
Message-ID: <20230807212607.50883-4-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807212607.50883-1-saeed@kernel.org>
References: <20230807212607.50883-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Fixing wrong calculation of the modify hdr pattern size,
where the previously calculated number would not be enough
to accommodate the required number of actions.

Fixes: da5d0027d666 ("net/mlx5: DR, Add cache for modify header pattern")
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Erez Shitrit <erezsh@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ptrn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ptrn.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ptrn.c
index d6947fe13d56..8ca534ef5d03 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ptrn.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_ptrn.c
@@ -82,7 +82,7 @@ dr_ptrn_alloc_pattern(struct mlx5dr_ptrn_mgr *mgr,
 	u32 chunk_size;
 	u32 index;
 
-	chunk_size = ilog2(num_of_actions);
+	chunk_size = ilog2(roundup_pow_of_two(num_of_actions));
 	/* HW modify action index granularity is at least 64B */
 	chunk_size = max_t(u32, chunk_size, DR_CHUNK_SIZE_8);
 
-- 
2.41.0


