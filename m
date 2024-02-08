Return-Path: <netdev+bounces-70091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCFA84D93C
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 04:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 260501F22D8A
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 03:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B162D3612A;
	Thu,  8 Feb 2024 03:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwdBriWD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0E631A82
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 03:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707364463; cv=none; b=OLCjmn20fWVCwLldN45j7sG9cRHovVfEwzaV4vTvOyx4ZJeCyoz4ncMGpkCSZe3svVLczRGajKP7Ce7UAObkuAu/osvpL4MqaYJx7qcgyZVK2FPfQpSz1QiG9VXNF5qfXVrcSfsifucWWaAUFFuuALfYaEJQiCt1FL2HNLFldCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707364463; c=relaxed/simple;
	bh=NyQJ+vml9cd9DRMpL/LAikskngvKE5zg/F1Ld0yIL6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1aMWimll/Nq5ZyjCe7qH4iIX/UcOtzDVKREbCnF65YMZ9TJbyoJbxVj3bOh0VN9sL7mTqrtlbiz7k+0/xJ5/1aoYm4TaRqQJF5ndjwP4zkBBFec/i4xOQqe88IaS7HyEcNqZmwUuBDG9tS080FTYVoFd3NNt1V+DoatoRu3VHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwdBriWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BEBEC433F1;
	Thu,  8 Feb 2024 03:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707364463;
	bh=NyQJ+vml9cd9DRMpL/LAikskngvKE5zg/F1Ld0yIL6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qwdBriWDK+C3wAlK1UlWroKf6N3Ys/wlg7oQW5twt+LQNoHQ5UEXfwJSTLdmyvxec
	 7kD1h+PensQiNKJWStjOuQENdzCLtf516gvcGoinix1LwABtRbOsrhxs9+LsC1uE/T
	 tiZWcr577C4//rmU31HPLCnkzeb3lRQpTQSdkbynxb+4a+qjrRJQu8JgtjIe7oCty/
	 BQihQy7BUAaFxDdRbhvz7qjbiBVkRStAYK2i1teLn87DxfUOLX0PWwAnLGGv7bkWXI
	 /2sYzIwGbpN3kxGubbBZMCbkv9YTuE+mCcLQMzAGxFou5VvxbrpMdSWdCjjG7VDe7z
	 2vjDdqilPpxZw==
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
Subject: [net-next V2 14/15] net/mlx5: Enable SD feature
Date: Wed,  7 Feb 2024 19:53:51 -0800
Message-ID: <20240208035352.387423-15-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208035352.387423-1-saeed@kernel.org>
References: <20240208035352.387423-1-saeed@kernel.org>
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
2.43.0


