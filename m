Return-Path: <netdev+bounces-41020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A67E77C95A4
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 19:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460431F21807
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 17:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ACA262BD;
	Sat, 14 Oct 2023 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmeU/cIF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A47262A7
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 17:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2CBC433C7;
	Sat, 14 Oct 2023 17:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697303971;
	bh=sCKW1lulrN47qnO06iR1/PFLTCfQeGivHQvENFLnd44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KmeU/cIFd6nqm6wyeV63r7NQyGWu6AjtJ4Saya7+2wxc0kMnSZOVmy6ioEvn3mJYH
	 6RFlU5FYAsMM8yYXLxU+2VworpV24IplJeZPL9lN1by1yC7rM+VxVHaib39U9wskz6
	 0wbpLk+ttq2zYgl5qYryWDMHrJRINcMqVIBq5Vj4mUmMO5/Vj1GzzibZ1kwssMR5sl
	 gETE5pGxfuDZsVqiavvvRYUvHqXyP5xF1wojkwz2Oziq6B9mB4gXdtfVQVkrDmb/n3
	 Z7rlMsEvhgj6MTTPHmv4uicmg4yH8Uvuy1fWYpeytGBfVL4dRU/ciZvp1oNk1VDFUz
	 y3nIYbX3Jlmtw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [net-next V3 08/15] net/mlx5: Use PTR_ERR_OR_ZERO() to simplify code
Date: Sat, 14 Oct 2023 10:19:01 -0700
Message-ID: <20231014171908.290428-9-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014171908.290428-1-saeed@kernel.org>
References: <20231014171908.290428-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinjie Ruan <ruanjinjie@huawei.com>

Return PTR_ERR_OR_ZERO() instead of return 0 or PTR_ERR() to
simplify code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
index 7d9bbb494d95..101b3bb90863 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
@@ -507,10 +507,7 @@ static int mlx5_lag_create_ttc_table(struct mlx5_lag *ldev)
 
 	mlx5_lag_set_outer_ttc_params(ldev, &ttc_params);
 	port_sel->outer.ttc = mlx5_create_ttc_table(dev, &ttc_params);
-	if (IS_ERR(port_sel->outer.ttc))
-		return PTR_ERR(port_sel->outer.ttc);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(port_sel->outer.ttc);
 }
 
 static int mlx5_lag_create_inner_ttc_table(struct mlx5_lag *ldev)
@@ -521,10 +518,7 @@ static int mlx5_lag_create_inner_ttc_table(struct mlx5_lag *ldev)
 
 	mlx5_lag_set_inner_ttc_params(ldev, &ttc_params);
 	port_sel->inner.ttc = mlx5_create_inner_ttc_table(dev, &ttc_params);
-	if (IS_ERR(port_sel->inner.ttc))
-		return PTR_ERR(port_sel->inner.ttc);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(port_sel->inner.ttc);
 }
 
 int mlx5_lag_port_sel_create(struct mlx5_lag *ldev,
-- 
2.41.0


