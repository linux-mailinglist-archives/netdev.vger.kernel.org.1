Return-Path: <netdev+bounces-78290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9198749F8
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 09:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A32284266
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 08:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFCD83CC8;
	Thu,  7 Mar 2024 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZNe2LO1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6A583CC4
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800971; cv=none; b=pdwHja1ftKIGnu4c/3ybdIVABxB1vPSakpysP2ji2uEYpw3bceAR6QzPYGxoc1RUnjzt+sa0U2R8FN1KllmKUleEpZ3wpDoVE4wYD2b65eE9zvWH5qehLU8rXg5r/IatCqIkTFOQj+wlWrkDeGsB6rgcohWGtnK6vuKOdjKYLNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800971; c=relaxed/simple;
	bh=+Sy7v4QeR72jlTZ8HobQ495BabO97y6qzQq47FkzzjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9pjLtmbHfEvartdDpJ0xBXH81vbMJPfRT2xXRs1nhMbTUX8CAlyf6iAI8a/VQQFhGdxhhM/yU42jeyCBqmeqdREiIEpIkKwrBZozbNygffy/nfqVXfwU4nhDp3BdIrnvpNQi5eq1RexkO+o7KCqX8UogDkO35VeMjv+ezGi9ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZNe2LO1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6ADC433F1;
	Thu,  7 Mar 2024 08:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709800971;
	bh=+Sy7v4QeR72jlTZ8HobQ495BabO97y6qzQq47FkzzjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GZNe2LO1dQSV7vqIqtXbOZsmEbxLeatvKyBkhVPoW0DzjXrkK6gepOvebe0czkEE/
	 f1A90XWf6AlEl8/re1HTyJ+KAfICTW8RCl0TtbC1VCVYyHDyL/D/PpJrX0eLHxbGiS
	 MQrHBWuvJpd9gWHjBRowQF17wx1L5zbWFdIiVrqIXa5W/QulPI5ShCwwJ+Ot8qCGVR
	 XVL+xMzyweLFFEMpxb1Q8PFIDJfvXwov64AUrGiwbLzQKQ8tiQ8G4mi+YBTaejoPmJ
	 V/505gMZY7Ff0mwMcE+hmw/xP8XiPvpPhzEZS6vYe4NI0l+lMAy+ZTjc7Vnga8mbma
	 +l7Orz3nogFEQ==
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
Subject: [net-next V6 14/15] net/mlx5: Enable SD feature
Date: Thu,  7 Mar 2024 00:42:28 -0800
Message-ID: <20240307084229.500776-15-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240307084229.500776-1-saeed@kernel.org>
References: <20240307084229.500776-1-saeed@kernel.org>
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


