Return-Path: <netdev+bounces-47460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD64D7EA543
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 22:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682F5280FA0
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 21:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59673D971;
	Mon, 13 Nov 2023 21:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrFKHlmE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67C03D96F
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 21:08:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732C4C433C7;
	Mon, 13 Nov 2023 21:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699909724;
	bh=Nnk281opvjJMJuvdFx6lJNxgCqK/fZZDw+njSGYr6+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MrFKHlmExjxy8c7JMZ3hCOGP5o+U4BsND87WGYEYoF05FYkbDJFLDw7XF/wOBgO5i
	 eVDh+1IWwq1GGtjDz5eBjgF2q+mI0Y551qow4q8AyUXs3nDjVKBRMhLBovX88usi+f
	 TjdFcSsB+fQq9/S6INV/sKli0465Qh7ynr/0NO5xHg4A34SukErQlKAW1DNVhEL2/2
	 6t2z9WiAVER/aU79xYRtiVc33nuQHtFM84QWvKOxrPLO7IYtd7JcAP4opWd/BEvJfv
	 2tZmgddzsxEfCHTMcR1x7ATUDzNFKOzb7LSsZ5ALA11StpAP6Rg6ncc29bmtRpE3gS
	 UroMNRy0e6OOQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [net 15/17] net/mlx5e: Reduce the size of icosq_str
Date: Mon, 13 Nov 2023 13:08:24 -0800
Message-ID: <20231113210826.47593-16-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113210826.47593-1-saeed@kernel.org>
References: <20231113210826.47593-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

icosq_str size is unnecessarily too long, and it causes a build warning
-Wformat-truncation with W=1. Looking closely, It doesn't need to be 255B,
hence this patch reduces the size to 32B which should be more than enough
to host the string: "ICOSQ: 0x%x, ".

While here, add a missing space in the formatted string.

This fixes the following build warning:

$ KCFLAGS='-Wall -Werror'
$ make O=/tmp/kbuild/linux W=1 -s -j12 drivers/net/ethernet/mellanox/mlx5/core/

drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c: In function 'mlx5e_reporter_rx_timeout':
drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c:718:56:
error: ', CQ: 0x' directive output may be truncated writing 8 bytes into a region of size between 0 and 255 [-Werror=format-truncation=]
  718 |                  "RX timeout on channel: %d, %sRQ: 0x%x, CQ: 0x%x",
      |                                                        ^~~~~~~~
drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c:717:9: note: 'snprintf' output between 43 and 322 bytes into a destination of size 288
  717 |         snprintf(err_str, sizeof(err_str),
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  718 |                  "RX timeout on channel: %d, %sRQ: 0x%x, CQ: 0x%x",
      |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  719 |                  rq->ix, icosq_str, rq->rqn, rq->cq.mcq.cqn);
      |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 521f31af004a ("net/mlx5e: Allow RQ outside of channel context")
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6d4ab2e97dcfbcd748ae71761a9d8e5e41cc732c
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index fea8c0a5fe89..4358798d6ce1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -492,11 +492,11 @@ static int mlx5e_rx_reporter_dump(struct devlink_health_reporter *reporter,
 
 void mlx5e_reporter_rx_timeout(struct mlx5e_rq *rq)
 {
-	char icosq_str[MLX5E_REPORTER_PER_Q_MAX_LEN] = {};
 	char err_str[MLX5E_REPORTER_PER_Q_MAX_LEN];
 	struct mlx5e_icosq *icosq = rq->icosq;
 	struct mlx5e_priv *priv = rq->priv;
 	struct mlx5e_err_ctx err_ctx = {};
+	char icosq_str[32] = {};
 
 	err_ctx.ctx = rq;
 	err_ctx.recover = mlx5e_rx_reporter_timeout_recover;
@@ -505,7 +505,7 @@ void mlx5e_reporter_rx_timeout(struct mlx5e_rq *rq)
 	if (icosq)
 		snprintf(icosq_str, sizeof(icosq_str), "ICOSQ: 0x%x, ", icosq->sqn);
 	snprintf(err_str, sizeof(err_str),
-		 "RX timeout on channel: %d, %sRQ: 0x%x, CQ: 0x%x",
+		 "RX timeout on channel: %d, %s RQ: 0x%x, CQ: 0x%x",
 		 rq->ix, icosq_str, rq->rqn, rq->cq.mcq.cqn);
 
 	mlx5e_health_report(priv, priv->rx_reporter, err_str, &err_ctx);
-- 
2.41.0


