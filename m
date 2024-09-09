Return-Path: <netdev+bounces-126628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0513E9721A6
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 20:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B891C21D6E
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 18:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26E21891BD;
	Mon,  9 Sep 2024 18:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbSqzDng"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9851891B5
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 18:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725905582; cv=none; b=q1hStoKgyucrRELLgcnnPj4kJEBkDN4tboNzOwpNwMZp7WXDniodcpFjKGFGuWYxouSlTbZ1nDw1cJnXcv4nBvWEvfC0MsQ0EDexZbwDH4IrpP8cRtTvYq1TVs+Kg5pc9DGoA7THxCXoZS+FHmI4ezRECzOcPJG+9YXuXzDtot8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725905582; c=relaxed/simple;
	bh=QXuBPXrIIPPVHG42N2a6WI6jC7DZNbTCPmY9FJQXn6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NzDUSJGP9K5E/UUKXOgPqMpf5HxBvic56AH/ooI4zOn4Zh7XaUXWsL/Uob2xRzFazqxAnKogmp3yuYBo5T6exc4i+n620cmsEbQBQDEh4cIzEHRDsCqyoVIUiMD1vi5hZjF6U3nrFvVtNRx38uUg1zo7whlKr/56V/lsVkTpL/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbSqzDng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0348CC4CEC5;
	Mon,  9 Sep 2024 18:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725905582;
	bh=QXuBPXrIIPPVHG42N2a6WI6jC7DZNbTCPmY9FJQXn6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GbSqzDngo6mbw+85jM3a576qwHjVkvyvjBdeawOJ0xOgIvUWAZBYlVsrL0/J1fdwj
	 kdWjirUWGFpAUkycA7CU2HskEQZgfUgaXh098Q8SGH7Rs0ezVlBN0SR2G/OyWpJ3+m
	 Xi076uhUqsDFHHSAoMviY+Kf5jvOdeT+tll/byjE22/R4pdWVnHqUiC36rGUS/a3t/
	 MiX4t1phnbtwLhSGy6EzUVw+rbeaY3MggKr8103WirFHlidxLMn8aLPpzOsiBJB6IV
	 5+Nv75kNjmymxDHo3WCf04maVGcsGxS6ikd+eyWyIoEiRyQPZX5DiY5hYJqkSkmbHg
	 TXPJu4eiIYI7g==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Hamdan Agbariya <hamdani@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Subject: [net-next V4 02/15] net/mlx5: Added missing definitions in preparation for HW Steering
Date: Mon,  9 Sep 2024 11:12:35 -0700
Message-ID: <20240909181250.41596-3-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909181250.41596-1-saeed@kernel.org>
References: <20240909181250.41596-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

As part of preparation for HWS, added missing definitions
in qp.h and fs_core.h:

 - FS_FT_FDB_RX/TX table types that are used by HWS in addition
   to an existing FS_FT_FDB
 - MLX5_WQE_CTRL_INITIATOR_SMALL_FENCE that is used by HWS to
   require fence in WQE

Reviewed-by: Hamdan Agbariya <hamdani@nvidia.com>
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h | 8 ++++++--
 include/linux/mlx5/qp.h                           | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index 78eb6b7097e1..6201647d6156 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -110,7 +110,9 @@ enum fs_flow_table_type {
 	FS_FT_RDMA_RX		= 0X7,
 	FS_FT_RDMA_TX		= 0X8,
 	FS_FT_PORT_SEL		= 0X9,
-	FS_FT_MAX_TYPE = FS_FT_PORT_SEL,
+	FS_FT_FDB_RX		= 0xa,
+	FS_FT_FDB_TX		= 0xb,
+	FS_FT_MAX_TYPE = FS_FT_FDB_TX,
 };
 
 enum fs_flow_table_op_mod {
@@ -368,7 +370,9 @@ struct mlx5_flow_root_namespace *find_root(struct fs_node *node);
 	(type == FS_FT_RDMA_RX) ? MLX5_CAP_FLOWTABLE_RDMA_RX(mdev, cap) :		\
 	(type == FS_FT_RDMA_TX) ? MLX5_CAP_FLOWTABLE_RDMA_TX(mdev, cap) :      \
 	(type == FS_FT_PORT_SEL) ? MLX5_CAP_FLOWTABLE_PORT_SELECTION(mdev, cap) :      \
-	(BUILD_BUG_ON_ZERO(FS_FT_PORT_SEL != FS_FT_MAX_TYPE))\
+	(type == FS_FT_FDB_RX) ? MLX5_CAP_ESW_FLOWTABLE_FDB(mdev, cap) :      \
+	(type == FS_FT_FDB_TX) ? MLX5_CAP_ESW_FLOWTABLE_FDB(mdev, cap) :      \
+	(BUILD_BUG_ON_ZERO(FS_FT_FDB_TX != FS_FT_MAX_TYPE))\
 	)
 
 #endif
diff --git a/include/linux/mlx5/qp.h b/include/linux/mlx5/qp.h
index ad1ce650146c..fc7eeff99a8a 100644
--- a/include/linux/mlx5/qp.h
+++ b/include/linux/mlx5/qp.h
@@ -149,6 +149,7 @@ enum {
 	MLX5_WQE_CTRL_CQ_UPDATE		= 2 << 2,
 	MLX5_WQE_CTRL_CQ_UPDATE_AND_EQE	= 3 << 2,
 	MLX5_WQE_CTRL_SOLICITED		= 1 << 1,
+	MLX5_WQE_CTRL_INITIATOR_SMALL_FENCE = 1 << 5,
 };
 
 enum {
-- 
2.46.0


