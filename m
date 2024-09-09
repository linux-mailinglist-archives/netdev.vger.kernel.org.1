Return-Path: <netdev+bounces-126675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBC69722FB
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 21:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AEA52847F1
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 19:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B9318A6CE;
	Mon,  9 Sep 2024 19:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZxNELuY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155C318A6C9
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 19:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725911139; cv=none; b=hfs+WIKtXmUBzay1oRoph84xES1MIkVJk5+TCWVFRtcEs5BQATvQPwXh/j2pYnAIJXH7eJNLayP/NNkm1gcvqdLghHOgyp6VGs5IufeIEZ2OM/xPZpTC//mGJp1Z4Ba4zjPZ8KOMshqICoedFJsywUXcIS15oCxl8QYGwRh/bWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725911139; c=relaxed/simple;
	bh=xRhxaGEsT0RO6AqnJjP9ypWip4eZkoZGBzQQmfgCvm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpEgeWxMzQV1gvUBaXbJJvq5nB1CLcuQQxi4UaLeO9DsQwTt+BuuCiOIT2OElWc/gRBDiLjuYukvIrlncNeWLH4QuuSf6MU3W32hRyWl3qzxG33r3GqN7VgiWb/xSdNFk2RM5seP3zr/bLHrvqH6cCXWJ/xjtPun96WBNw8CVvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZxNELuY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78995C4CECB;
	Mon,  9 Sep 2024 19:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725911138;
	bh=xRhxaGEsT0RO6AqnJjP9ypWip4eZkoZGBzQQmfgCvm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CZxNELuYDnisMqBxPLpajHFK6CEFoKJ+58IZ9kqMhtkTHZd6sRR6A6fwzSh/RcEKC
	 y6I/bcU819ih9I/Hc0zAxUjdtw968upgNf32c9tYynm41gt3EWuE6BNCV7jcM287R0
	 vryUhZY9TH5jQlfmXrrFyVO8+6KqApR4ydEQ9I8bSfT6vojcrSNAdT57e7qsdqtVKA
	 JEoLb8FBF9Tu5Ap7iH30BMiaplux3zN0Z7wfgo3jerNM8UBgYQYS+yOIJFOnYIigzo
	 dpQmjFAb20nLRzYUpGIs9DotcLZOqVmrAh6xXVsvCIQ6MAw7PeJewArOhThrH5ju8S
	 nx5Msh/7dnT1Q==
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
	Carolina Jubran <cjubran@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: [net 4/7] net/mlx5: Explicitly set scheduling element and TSAR type
Date: Mon,  9 Sep 2024 12:45:02 -0700
Message-ID: <20240909194505.69715-5-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909194505.69715-1-saeed@kernel.org>
References: <20240909194505.69715-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carolina Jubran <cjubran@nvidia.com>

Ensure the scheduling element type and TSAR type are explicitly
initialized in the QoS rate group creation.

This prevents potential issues due to default values.

Fixes: 1ae258f8b343 ("net/mlx5: E-switch, Introduce rate limiting groups API")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 20146a2dc7f4..997c412a81af 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -421,6 +421,7 @@ __esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *ex
 {
 	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_esw_rate_group *group;
+	__be32 *attr;
 	u32 divider;
 	int err;
 
@@ -428,6 +429,12 @@ __esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *ex
 	if (!group)
 		return ERR_PTR(-ENOMEM);
 
+	MLX5_SET(scheduling_context, tsar_ctx, element_type,
+		 SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
+
+	attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
+	*attr = cpu_to_be32(TSAR_ELEMENT_TSAR_TYPE_DWRR << 16);
+
 	MLX5_SET(scheduling_context, tsar_ctx, parent_element_id,
 		 esw->qos.root_tsar_ix);
 	err = mlx5_create_scheduling_element_cmd(esw->dev,
-- 
2.46.0


