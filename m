Return-Path: <netdev+bounces-65367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F8E83A3F7
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797E61C21FBC
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 08:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C52017756;
	Wed, 24 Jan 2024 08:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMZg+B1z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EE517564
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 08:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084359; cv=none; b=bnXaLvSmFJrtTEeuAwgFOkgVwdJh57GOHgDOOFQtxy0/tEHe5nVZ354gDCjwGG3cGjrHQBrH1yBeb+91bVLRCsxL4z9jnlFU1k4LO6GmA3fDknb1N4Z5lpHHDRUJiKHeiduKQQhnfhLQIJE92wGse2WEoZ/Z8+/T5Fz9BMzoMJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084359; c=relaxed/simple;
	bh=GI7oEMHXVBCLguqPv3qTznIlJSQoUJ5cSk+zr6FOS6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZVCwq/zhf7/R27G9jz5ESyOx0QHLUqrbT3KLPkAdKL23KaMTsiU6YDHrs4GnPAZTWNgrHbgOCpesGMNVkvLhv+ZcdOYjLONJHjflHUr8+Wb5jH2jcCV/fAgOslCLSezo7RQpcJEG/pF7tdCB5a9Pu38ajHJlPFo6B7hvITekQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMZg+B1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF505C433C7;
	Wed, 24 Jan 2024 08:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706084358;
	bh=GI7oEMHXVBCLguqPv3qTznIlJSQoUJ5cSk+zr6FOS6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NMZg+B1z185baVB9L837K+xaX/DGeloY8z7qtS4Ph1EzAoSBwr1PTaHzkSPgG9a22
	 CLr4veLHfzMpuyNNkKitnOgj6PBk3xydWWiib0hXVAStkvjLBCPi0PFxaCpD62HUcb
	 IG+1AdvDmUqiydhxAoggPf/PCt1nK6EwVuf66czPt3MeW7BhTjQFfiDSQVPLPvciRG
	 uqeZcpw5915i8oGSSX7hfi+faMhHNVHcOw3RJxTlTXEhhoO4y2VrEfqH6Z2c3xv0Yh
	 9o70ezJYlFGQdXv53F7FPJYtnti4f4K9Dy6eYztu5D+P/EnnZuB0qzaFAItg8vcB5z
	 hGKyu/ZPAQGaA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>
Subject: [net 10/14] net/mlx5: Use mlx5 device constant for selecting CQ period mode for ASO
Date: Wed, 24 Jan 2024 00:18:51 -0800
Message-ID: <20240124081855.115410-11-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124081855.115410-1-saeed@kernel.org>
References: <20240124081855.115410-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

mlx5 devices have specific constants for choosing the CQ period mode. These
constants do not have to match the constants used by the kernel software
API for DIM period mode selection.

Fixes: cdd04f4d4d71 ("net/mlx5: Add support to create SQ and CQ for ASO")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c
index 40c7be124041..58bd749b5e4d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c
@@ -98,7 +98,7 @@ static int create_aso_cq(struct mlx5_aso_cq *cq, void *cqc_data)
 	mlx5_fill_page_frag_array(&cq->wq_ctrl.buf,
 				  (__be64 *)MLX5_ADDR_OF(create_cq_in, in, pas));
 
-	MLX5_SET(cqc,   cqc, cq_period_mode, DIM_CQ_PERIOD_MODE_START_FROM_EQE);
+	MLX5_SET(cqc,   cqc, cq_period_mode, MLX5_CQ_PERIOD_MODE_START_FROM_EQE);
 	MLX5_SET(cqc,   cqc, c_eqn_or_apu_element, eqn);
 	MLX5_SET(cqc,   cqc, uar_page,      mdev->priv.uar->index);
 	MLX5_SET(cqc,   cqc, log_page_size, cq->wq_ctrl.buf.page_shift -
-- 
2.43.0


