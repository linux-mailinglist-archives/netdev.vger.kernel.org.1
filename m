Return-Path: <netdev+bounces-73129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B2A85B16B
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 04:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5D72829B2
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 03:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD8F45942;
	Tue, 20 Feb 2024 03:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7uUNvCc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288C55914E
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 03:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708399790; cv=none; b=J6yBa5e+uFQ2F9gUPsi/POJ729WoM5r7FeHeo6uCz/AEgWW/TqoYq7zkMHApF/KNZIjQNMveiDbgaRsZDmTnIo9KJcag5dC0ubhHNvf2v4LuLtj2HmrcigfzTb1dL7r2rPI0QCo1115SVkasIr4rbU7jTYWpEh3fNT5WsxB/HfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708399790; c=relaxed/simple;
	bh=i4MCCE6c8DaZ4TTe6eX3DR6H22mywFtjOSSJIEYPFtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rRSjZjvZaJcBP+fP733XRUVAS2is+FH4zhNeqBbESxQbiV+RNYFS94ixTol/ceKnW4806locA5L/6HIkjSEDcxQtC1xP5wYe9ojQB/009x7rAZIgmYIUcPEuxIz+rt3JV2RqWJMKXw2sZKoMPpzLEF/pXIKp4OoIYAsTft7bjRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7uUNvCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA71C433C7;
	Tue, 20 Feb 2024 03:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708399789;
	bh=i4MCCE6c8DaZ4TTe6eX3DR6H22mywFtjOSSJIEYPFtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S7uUNvCcd0fs2ta0+BU46wRehhNMhXJpSbAKOABGAqdg3R3fkGv3Gh63kTdjZUtZm
	 PNzwmzpEKbODID5BPauf5YPdbnNtsr/vFWK6LhwFGAi1rHmMUpL+2Y5woHnGMImXMT
	 zA3DEWBFvmABb69wehgZaUzuEWcam/RAJtC6R2aIu5w9YyIfDkNI3WnIbLvoF2ViIE
	 6OALrCOMpgcaJhb9fQvjMa3J2uOgWOLXkten6dlIRWMPbLXhAnpVjmSQ0Cotvn1pjp
	 fEDtOAc9SqeHCctPysMb5xiE5EUA0hQaRfxxnlvdaGd/psXzv4WtsYI169fhF1W/li
	 gWqfX8RLFhfIQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net 06/10] net/mlx5e: Change the warning when ignore_flow_level is not supported
Date: Mon, 19 Feb 2024 19:29:44 -0800
Message-ID: <20240220032948.35305-1-saeed@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240219182320.8914-1-saeed@kernel.org>
References: <20240219182320.8914-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

Downgrade the print from mlx5_core_warn() to mlx5_core_dbg(), as it
is just a statement of fact that firmware doesn't support ignore flow
level.

And change the wording to "firmware flow level support is missing", to
make it more accurate.

Fixes: ae2ee3be99a8 ("net/mlx5: CT: Remove warning of ignore_flow_level support for VFs")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Suggested-by: Elliott, Robert (Servers) <elliott@hpe.com>
Reviewed-by: Roi Dayan <roid@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c
index 86bf007fd05b..b500cc2c9689 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c
@@ -37,7 +37,7 @@ mlx5e_tc_post_act_init(struct mlx5e_priv *priv, struct mlx5_fs_chains *chains,
 
 	if (!MLX5_CAP_FLOWTABLE_TYPE(priv->mdev, ignore_flow_level, table_type)) {
 		if (priv->mdev->coredev_type == MLX5_COREDEV_PF)
-			mlx5_core_warn(priv->mdev, "firmware level support is missing\n");
+			mlx5_core_dbg(priv->mdev, "firmware flow level support is missing\n");
 		err = -EOPNOTSUPP;
 		goto err_check;
 	}
-- 
2.43.2


