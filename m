Return-Path: <netdev+bounces-39837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E88D7C49B8
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 08:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4511C20E60
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 06:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B217A1118B;
	Wed, 11 Oct 2023 06:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sh55evse"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D2B15EA6
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 06:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AD6C433C8;
	Wed, 11 Oct 2023 06:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697004760;
	bh=sCKW1lulrN47qnO06iR1/PFLTCfQeGivHQvENFLnd44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sh55evse3eawotn5DPV6P3UPZnaDZNXkmV3FyJxFYsDVbqn2z/ujRcmRO8yuIjRkX
	 P3wV8Iml+42CSfNWpOAJ1tVKPlQ67gMj1bKvPyhwPpll50Gm50i5+m4f1Edo4iJ4RD
	 eaWA+xsxEuekEaCPdAwdQQtRwHY9kzM+9LXkGUOSudpVc4u+CiGwVt2Vrlo0Yw+SZP
	 eqWw9+Oln6sqEfNd3Apa2Qe9M937XW3VZE8RM3C332fWUMXTSnCRgMe4sE7WXVNoYV
	 oFGm7UwRm8ZNyJv2/CX+8Soz4p3QFuLHVYbvqQJCYRCZa9SslbJwQIlf6d2huRb+uA
	 46qPL4PkNSdMg==
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
Subject: [net-next 08/15] net/mlx5: Use PTR_ERR_OR_ZERO() to simplify code
Date: Tue, 10 Oct 2023 23:12:23 -0700
Message-ID: <20231011061230.11530-9-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011061230.11530-1-saeed@kernel.org>
References: <20231011061230.11530-1-saeed@kernel.org>
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


