Return-Path: <netdev+bounces-71940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7F785595E
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 04:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0FB71C2A177
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 03:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDE3D51C;
	Thu, 15 Feb 2024 03:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKe7RLxt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7E81BC5B
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 03:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966513; cv=none; b=icFdl2A4DtEwlzomU4qW3LZcClZUpPzocxq760M/zeW4Cb49Fnvajqv2Aahe1Lk1o26IJetBC1A6z2tPT09i7AAh1/QyX5KXRc7jcmuorBxNs/qLbvf+mAZyaGtx96BaJC92hu5CJuWvuk0udMgk661UcPZxYNowQsr7fLVQxXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966513; c=relaxed/simple;
	bh=NyQJ+vml9cd9DRMpL/LAikskngvKE5zg/F1Ld0yIL6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDjHD53aFprs/EIMKmMvFosDL8gj+g/vgYXyJkb8ojLDpnUZeWwzOE2XqfNJG0w3SzGYOrvE5odfrYAgf0sJ2sTiNz9hUd8HqZ/O6LMonz3tlX80tKDEcTYjnRoT76XGTQvKUnb1rgXPwXis/MStZ3KfOqobB1IULRXaq5RG/6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKe7RLxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B31C433F1;
	Thu, 15 Feb 2024 03:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707966513;
	bh=NyQJ+vml9cd9DRMpL/LAikskngvKE5zg/F1Ld0yIL6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QKe7RLxtkGX7DZIzi6587PZJPuko/c/xsIOxUU9ERurQ3uQhVrxHMxptxfG1oYwXn
	 S1WmRwt3+hMdLuY1Rc/Dh8p0wgbchplEPHD7itmoOm8suqHPVdwqAqi+ngDytzkyBc
	 yokkUeoys2R/gzwcUEjuCAszA/fQl07WzVbe1CoPfKBTJNZGUekcNKpIOa4IB7Abnk
	 xcgTsti/2NXEp7DMTKvNOx5By4VCtiTYPEGASoR4QS6MWwqyllDmaCWlFjshYD+mbD
	 NYwU5ipNsBKsNfivnzrxO9fYbpvEoyiiQyIY9u+8jIqIqNKz5LpnvLKi8xP+XtPTH6
	 JDpBeIsPbjPpQ==
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
Subject: [net-next V3 14/15] net/mlx5: Enable SD feature
Date: Wed, 14 Feb 2024 19:08:13 -0800
Message-ID: <20240215030814.451812-15-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215030814.451812-1-saeed@kernel.org>
References: <20240215030814.451812-1-saeed@kernel.org>
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


