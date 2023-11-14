Return-Path: <netdev+bounces-47852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 477987EB91B
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 23:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C42CDB20C46
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 22:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15472E846;
	Tue, 14 Nov 2023 21:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoNjKw41"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CC72E844
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 21:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9519DC433CA;
	Tue, 14 Nov 2023 21:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699999151;
	bh=Nnk281opvjJMJuvdFx6lJNxgCqK/fZZDw+njSGYr6+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PoNjKw41fknZO9ALr/1udrFuAKJG91dg5TEBLBFIcJkEeYh72uCTmJvwHsUquSzzn
	 IhqGV/2bZKJltzRFaDmgmsaE8RjuXpTlkOjQVR9Z+MFdDNWIQcB4SJuBzO+pYgiHsX
	 yqK0SU3b8qZiICU8Q1h1rurMMvSTED6coR3F+7M1Hikp08my02mCwZurEhbsYqrsDD
	 nJZLD91I7pNKe8qAbJojL2TNo0TOd1JyHUVrwL/SOgMXgbKw1VMJ1jBucH1d2g7LPb
	 GEIdNlLF7lejQd3ExBZBpDnU26Hv6ffPhsEMZFBYgadUybXKQjX9xnA7D4QsRIp2tD
	 e2do+7w2cPtHg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [net V2 13/15] net/mlx5e: Reduce the size of icosq_str
Date: Tue, 14 Nov 2023 13:58:44 -0800
Message-ID: <20231114215846.5902-14-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114215846.5902-1-saeed@kernel.org>
References: <20231114215846.5902-1-saeed@kernel.org>
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


