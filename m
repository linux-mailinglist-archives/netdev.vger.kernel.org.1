Return-Path: <netdev+bounces-42862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA04B7D06BC
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 05:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F68EB21436
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 03:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318F663C2;
	Fri, 20 Oct 2023 03:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4NL8JHC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5D39470
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 03:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FCCC433C8;
	Fri, 20 Oct 2023 03:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697771084;
	bh=OzRc6NTniZFOXiMKmyu2ai2V4Maj9af1zmafa4c6QOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o4NL8JHCQeGr16uNzRvjfaeuQ4WJPGuv6Giryc1VxjPrmaIFo3YSpNLaA37wwVJEp
	 qTMwMr2sKgZTLCpDdVIgs5BVDvOKOQY5MJIT+Uw24DFHu3HoczyKz1l6XXP/47cujf
	 O/KCZ2D6lX8uB2C3AqhFs8hCOO4lFFtJvy3T02GEjo8d4tzNtjssfzBVUTcjPFTKtL
	 svuFMVYb48INmGZh9Va3SiBItDG3iZn9ermIB1CAx0+jWsRSftyKjkb3BpY/4+OX0p
	 rbSWjCVTwTW4shk32ez62Oeegg1xVYYlRaxWdsrePuUfz8sSXsyOLmycGe4YNkftYo
	 ooupf+rxWGx0Q==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net-next 11/15] net/mlx5e: Reduce the size of icosq_str
Date: Thu, 19 Oct 2023 20:04:18 -0700
Message-ID: <20231020030422.67049-12-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020030422.67049-1-saeed@kernel.org>
References: <20231020030422.67049-1-saeed@kernel.org>
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

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index e8eea9ffd5eb..03b119a434bc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -702,11 +702,11 @@ static int mlx5e_rx_reporter_dump(struct devlink_health_reporter *reporter,
 
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
@@ -715,7 +715,7 @@ void mlx5e_reporter_rx_timeout(struct mlx5e_rq *rq)
 	if (icosq)
 		snprintf(icosq_str, sizeof(icosq_str), "ICOSQ: 0x%x, ", icosq->sqn);
 	snprintf(err_str, sizeof(err_str),
-		 "RX timeout on channel: %d, %sRQ: 0x%x, CQ: 0x%x",
+		 "RX timeout on channel: %d, %s RQ: 0x%x, CQ: 0x%x",
 		 rq->ix, icosq_str, rq->rqn, rq->cq.mcq.cqn);
 
 	mlx5e_health_report(priv, priv->rx_reporter, err_str, &err_ctx);
-- 
2.41.0


