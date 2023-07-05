Return-Path: <netdev+bounces-15609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6EA748B2D
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 20:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D2D280D2A
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 18:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D094D154A0;
	Wed,  5 Jul 2023 17:58:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CC9154BE
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 17:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABDDC433AD;
	Wed,  5 Jul 2023 17:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688579904;
	bh=qwlRmjzIpDCqT90LR6GJgKMGFDLXKlV9IVZ1wUmbfmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KWkQi1SHgkYEHMZ8IxT2WF9iYjFKAsmUmX41UpA4vBdLphty4BNkzcDVJ5vx4WG49
	 mUG1XSG8S0qu17zHSpDuWupPKWdyzS5jgNSemINTfDVMwb+aMDc0lhNo7FEPjbdkD/
	 rKLFccvXWoQ0o/ApCulicaVQP08WkXL7daaMtWPcVKR42zqSgoBQbR9wJ/FSHAhRZf
	 haWe8ca57+hgjkzsdmDRd147txLYIXXjyF0pjc6MPM5Us9CP5YFZuhqwFVlSyA/TUJ
	 GLnQqMipL+jZrb9tRm6cuGhb9Ud2eXb6FWiDvQhMa/ijBamuM385dYdMHwMbwcZSsM
	 2eYo57zEJUFwA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: [net V2 9/9] net/mlx5e: RX, Fix page_pool page fragment tracking for XDP
Date: Wed,  5 Jul 2023 10:57:57 -0700
Message-ID: <20230705175757.284614-10-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705175757.284614-1-saeed@kernel.org>
References: <20230705175757.284614-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dragos Tatulea <dtatulea@nvidia.com>

Currently mlx5e releases pages directly to the page_pool for XDP_TX and
does page fragment counting for XDP_REDIRECT. RX pages from the
page_pool are leaking on XDP_REDIRECT because the xdp core will release
only one fragment out of MLX5E_PAGECNT_BIAS_MAX and subsequently the page
is marked as "skip release" which avoids the driver release.

A fix would be to take an extra fragment for XDP_REDIRECT and not set the
"skip release" bit so that the release on the driver side can handle the
remaining bias fragments. But this would be a shortsighted solution.
Instead, this patch converges the two XDP paths (XDP_TX and XDP_REDIRECT) to
always do fragment tracking. The "skip release" bit is no longer
necessary for XDP.

Fixes: 6f5742846053 ("net/mlx5e: RX, Enable skb page recycling through the page_pool")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 32 +++++++------------
 2 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index f0e6095809fa..40589cebb773 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -662,8 +662,7 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
 				/* No need to check ((page->pp_magic & ~0x3UL) == PP_SIGNATURE)
 				 * as we know this is a page_pool page.
 				 */
-				page_pool_put_defragged_page(page->pp,
-							     page, -1, true);
+				page_pool_recycle_direct(page->pp, page);
 			} while (++n < num);
 
 			break;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index a9575219e455..41d37159e027 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1751,11 +1751,11 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 
 	prog = rcu_dereference(rq->xdp_prog);
 	if (prog && mlx5e_xdp_handle(rq, prog, &mxbuf)) {
-		if (test_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
+		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
 			struct mlx5e_wqe_frag_info *pwi;
 
 			for (pwi = head_wi; pwi < wi; pwi++)
-				pwi->flags |= BIT(MLX5E_WQE_FRAG_SKIP_RELEASE);
+				pwi->frag_page->frags++;
 		}
 		return NULL; /* page/packet was consumed by XDP */
 	}
@@ -1825,12 +1825,8 @@ static void mlx5e_handle_rx_cqe(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 			      rq, wi, cqe, cqe_bcnt);
 	if (!skb) {
 		/* probably for XDP */
-		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
-			/* do not return page to cache,
-			 * it will be returned on XDP_TX completion.
-			 */
-			wi->flags |= BIT(MLX5E_WQE_FRAG_SKIP_RELEASE);
-		}
+		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags))
+			wi->frag_page->frags++;
 		goto wq_cyc_pop;
 	}
 
@@ -1876,12 +1872,8 @@ static void mlx5e_handle_rx_cqe_rep(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 			      rq, wi, cqe, cqe_bcnt);
 	if (!skb) {
 		/* probably for XDP */
-		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
-			/* do not return page to cache,
-			 * it will be returned on XDP_TX completion.
-			 */
-			wi->flags |= BIT(MLX5E_WQE_FRAG_SKIP_RELEASE);
-		}
+		if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags))
+			wi->frag_page->frags++;
 		goto wq_cyc_pop;
 	}
 
@@ -2060,12 +2052,12 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	if (prog) {
 		if (mlx5e_xdp_handle(rq, prog, &mxbuf)) {
 			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags)) {
-				int i;
+				struct mlx5e_frag_page *pfp;
+
+				for (pfp = head_page; pfp < frag_page; pfp++)
+					pfp->frags++;
 
-				for (i = 0; i < sinfo->nr_frags; i++)
-					/* non-atomic */
-					__set_bit(page_idx + i, wi->skip_release_bitmap);
-				return NULL;
+				wi->linear_page.frags++;
 			}
 			mlx5e_page_release_fragmented(rq, &wi->linear_page);
 			return NULL; /* page/packet was consumed by XDP */
@@ -2163,7 +2155,7 @@ mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 				 cqe_bcnt, &mxbuf);
 		if (mlx5e_xdp_handle(rq, prog, &mxbuf)) {
 			if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMIT, rq->flags))
-				__set_bit(page_idx, wi->skip_release_bitmap); /* non-atomic */
+				frag_page->frags++;
 			return NULL; /* page/packet was consumed by XDP */
 		}
 
-- 
2.41.0


