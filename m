Return-Path: <netdev+bounces-77753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355A7872D33
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 04:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66EA81C21579
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 03:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E439513AE2;
	Wed,  6 Mar 2024 03:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfd6m0RZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE91134B6
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 03:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709694205; cv=none; b=Tv+NqFHQ6Ii8eQXEL3b+MT1cGkK+lcERcozEh9/Uk1crxRCemsCeAQYGVlbLuJNG+NCWDT5XZuL4fZ43xU1G5kkIMivpVe/gCIlopz1N2mCLgvzjEFHwxGMrGyCvoO61uRKWS4+X2v/I2DhpKNqZbFgOxgYbzDoPoEppetPZQKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709694205; c=relaxed/simple;
	bh=+Sy7v4QeR72jlTZ8HobQ495BabO97y6qzQq47FkzzjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Keo/ihSDRaer0JGg5yEx4FKgkQxSDRm9GiIP1FsqbzdoJDjnv/dD1NS5skwnuxLABwOBooR9J+eShzxZbLdHk7hmfZNkMs3T+Q4cPQLP5NdLX+0hvQ8uDhT8sQMiXaXYBreFhThjIjSL1SfxDIMHX4fcSk6usYwAFhQlYJRF7gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfd6m0RZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768A1C43390;
	Wed,  6 Mar 2024 03:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709694205;
	bh=+Sy7v4QeR72jlTZ8HobQ495BabO97y6qzQq47FkzzjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sfd6m0RZDUdkdWORB2w8UqiS1+hmkDps2weV4+IMQ8tWHhAxW2QJTRprt8M16JFXv
	 WZm7UqHymWL//1X/k3bGKl1nhcfsXH94T6bfurUSfSFilYbuKUvJ3evWBoxrGvcYMx
	 uVh1IbNpVx6kZB4Oe41SogvZFnrgRdwQ4Md+nkBqPEvzPzuQp1Oyp9rEHfQU032rbT
	 2XPX5xc1Z0IBro11yqHE1wKSdDv0xZUPKXy/EipxUEqP0ARfl/lCBNC1uVrtcVmtj1
	 zTm8htZR4jWlrVZ01dFJx48hCg+rH55fclKeUUbTTvAsdzP5sSgKqIa/MhoVJyWrYN
	 fTTsUFjWBOWnw==
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
Subject: [net-next V5 14/15] net/mlx5: Enable SD feature
Date: Tue,  5 Mar 2024 19:02:57 -0800
Message-ID: <20240306030258.16874-15-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306030258.16874-1-saeed@kernel.org>
References: <20240306030258.16874-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tariq Toukan <tariqt@nvidia.com>

Have an actual mlx5_sd instance in the core device, and fix the getter
accordingly. This allows SD stuff to flow, the feature becomes supported
only here.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h | 3 ++-
 include/linux/mlx5/driver.h                        | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h
index 0810b92b48d0..37d5f445598c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h
@@ -59,10 +59,11 @@ struct mlx5_sd;
 
 static inline struct mlx5_sd *mlx5_get_sd(struct mlx5_core_dev *dev)
 {
-	return NULL;
+	return dev->sd;
 }
 
 static inline void mlx5_set_sd(struct mlx5_core_dev *dev, struct mlx5_sd *sd)
 {
+	dev->sd = sd;
 }
 #endif
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 41f03b352401..bf9324a31ae9 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -823,6 +823,7 @@ struct mlx5_core_dev {
 	struct blocking_notifier_head macsec_nh;
 #endif
 	u64 num_ipsec_offloads;
+	struct mlx5_sd          *sd;
 };
 
 struct mlx5_db {
-- 
2.44.0


