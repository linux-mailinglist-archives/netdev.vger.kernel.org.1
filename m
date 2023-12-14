Return-Path: <netdev+bounces-57162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA22D812491
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CDDD1F21935
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 01:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68124A59;
	Thu, 14 Dec 2023 01:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFiifE8b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0646110
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 01:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112C5C433CA;
	Thu, 14 Dec 2023 01:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702517122;
	bh=8xk6d+PNum0LIDBPJqFejZn6t6d9yoqMCO1izKInHhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iFiifE8biKfwPuCuKjd8FUH/fZS7c51gDZgFSWmS5lt1n+iVzQ1+y0mTt5ir/jsqm
	 WzGaAV6cvqrWa/qjhTuu18g39wdr6KGWW2//jjEuQzr3msLizpUYT3NkxwuPv8zzBh
	 IMkgZSE7I8Jcsraw/MGnpYXj/RzDId8ebss5V7ofefkMOmrDUk/qEr6LH3l0Z4SflQ
	 mGl9OnHBsLYclVqi35jTKuwq2hL2un/Cy9ECEgDuUtJjQl4F2WbOaFCwnF5mtoTN6q
	 SNXOJRBlvv5uC9n0kmEKIFNvD9VKJSXNrMxu6iAqGfYZiTTwjCuJ6sWUI3/Qw3z9r0
	 i3ngO3r4lQckw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [net 13/15] net/mlx5e: Fix error codes in alloc_branch_attr()
Date: Wed, 13 Dec 2023 17:25:03 -0800
Message-ID: <20231214012505.42666-14-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214012505.42666-1-saeed@kernel.org>
References: <20231214012505.42666-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dan Carpenter <dan.carpenter@linaro.org>

Set the error code if set_branch_dest_ft() fails.

Fixes: ccbe33003b10 ("net/mlx5e: TC, Don't offload post action rule if not supported")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 6106bbbe14de..96af9e2ab1d8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -3778,7 +3778,8 @@ alloc_branch_attr(struct mlx5e_tc_flow *flow,
 		break;
 	case FLOW_ACTION_ACCEPT:
 	case FLOW_ACTION_PIPE:
-		if (set_branch_dest_ft(flow->priv, attr))
+		err = set_branch_dest_ft(flow->priv, attr);
+		if (err)
 			goto out_err;
 		break;
 	case FLOW_ACTION_JUMP:
@@ -3788,7 +3789,8 @@ alloc_branch_attr(struct mlx5e_tc_flow *flow,
 			goto out_err;
 		}
 		*jump_count = cond->extval;
-		if (set_branch_dest_ft(flow->priv, attr))
+		err = set_branch_dest_ft(flow->priv, attr);
+		if (err)
 			goto out_err;
 		break;
 	default:
-- 
2.43.0


