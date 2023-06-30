Return-Path: <netdev+bounces-14861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B660B7441FE
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 20:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E72A71C20C36
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 18:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2947D174F2;
	Fri, 30 Jun 2023 18:15:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0231217733
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 18:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C44C4339A;
	Fri, 30 Jun 2023 18:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688148950;
	bh=PwxdeMgq8UZ8+00y9Qlt+b5NAxzqsD7njuQQk02VJIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HNPfP8Epo63cZYW5y5WRp+BikTLPPOXoJagTXc6rtGoIJtMg8vGjwneENYXF0Lgw6
	 UiHYsJdGb+4MTKjUZCJHdXsUKtKT6DcFNrFP+vwhANj4qUvoVy0bhe1RblnKfLDqAp
	 wvgUE8RlFc4lKMrqDg3Qf2CP6KmmhbkiLqcBuA2rWVwWPWqNpCprwCxnu2kOURcPAN
	 bAc+1Vz4je62on4djY1Y8IZjrgFx3Pz61exCIypoW8Ehub9KqV1RkrTxZEWZbcTFjH
	 TLzHfPZgxzGMwpeyEOwUXqncjgfwXkZac4xtLGAWQJQ/0OgdgUSIV9ExGR1xR53bRV
	 neVAY8CwV9/mw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: [net 4/9] net/mlx5e: RX, Fix flush and close release flow of regular rq for legacy rq
Date: Fri, 30 Jun 2023 11:15:39 -0700
Message-ID: <20230630181544.82958-5-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630181544.82958-1-saeed@kernel.org>
References: <20230630181544.82958-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dragos Tatulea <dtatulea@nvidia.com>

Regular (non-XSK) RQs get flushed on XSK setup and re-activated on XSK
close. If the same regular RQ is closed (a config change for example)
soon after the XSK close, a double release occurs because the missing
wqes get released a second time.

Fixes: 3f93f82988bc ("net/mlx5e: RX, Defer page release in legacy rq for better recycling")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 704b022cd1f0..a9575219e455 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -390,10 +390,18 @@ static void mlx5e_dealloc_rx_wqe(struct mlx5e_rq *rq, u16 ix)
 {
 	struct mlx5e_wqe_frag_info *wi = get_frag(rq, ix);
 
-	if (rq->xsk_pool)
+	if (rq->xsk_pool) {
 		mlx5e_xsk_free_rx_wqe(wi);
-	else
+	} else {
 		mlx5e_free_rx_wqe(rq, wi);
+
+		/* Avoid a second release of the wqe pages: dealloc is called
+		 * for the same missing wqes on regular RQ flush and on regular
+		 * RQ close. This happens when XSK RQs come into play.
+		 */
+		for (int i = 0; i < rq->wqe.info.num_frags; i++, wi++)
+			wi->flags |= BIT(MLX5E_WQE_FRAG_SKIP_RELEASE);
+	}
 }
 
 static void mlx5e_xsk_free_rx_wqes(struct mlx5e_rq *rq, u16 ix, int wqe_bulk)
-- 
2.41.0


