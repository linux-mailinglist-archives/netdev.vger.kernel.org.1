Return-Path: <netdev+bounces-126673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACD29722F9
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 21:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22921283E9D
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 19:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3D0189F5A;
	Mon,  9 Sep 2024 19:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2wx5Hip"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1556E18C31
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725911137; cv=none; b=B9hjOFUUAMJEssVXJpT9tf/g2UktF5obR61VhQwiIGygHtMymkUZ5Ycfi/wEJDqt1rNtdLDGNJg/nQg46itFGy/YD9xpLN5LHs0bnbbC68dHKGSGmtBQEZrvNk5zGS880x7bbAxuvR02JItT1FJTTDxliO/fagRtrG18ng2AS5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725911137; c=relaxed/simple;
	bh=NpWMhXoohQBqcM5rp0Pae/MyHvphNhUOhhnaTOZdLyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DKxfsFSKbq66qwG03xtZMy2M/1mYKIpzq3XklprS5QRL99YTu5XB8ml/JJYjan3zBWc0NxwadHLh2R0qujzxkOvQXdRYI7c4BONQCB3W/gHmgMONYU6aw+hipuajtfLXnrUvTyjGzJtyAZa/a4VtHnLqhmcGbhsB2qqJuhys9Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2wx5Hip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADACC4CECD;
	Mon,  9 Sep 2024 19:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725911136;
	bh=NpWMhXoohQBqcM5rp0Pae/MyHvphNhUOhhnaTOZdLyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h2wx5Hip3o4P/y/8CM9R8sgRlr4OZpjH1rV3KFrAFWPemfI3tTXFRg80/QR1ahva6
	 fxLZONoexX79j1UwD1r6+uvNUW4WdAzN2koZwoV6XfuR81Yipt6troXgVnUKcYkIqM
	 u24Fy2aEQgDGqSnZu2cfhDfXi8abfZ4WS1jTtrvWm+t+vM7Ey4borLmTZ2yFjFvec5
	 IoDqOHMKUeknGE1zo3O0eGnE8uPTa2ilbIxTe1F8F3ia/ALc0KBkwUSr/Vf47tElZn
	 8GNIiIenLr9ihqQF2Z7oaLC36FidZaXZ0QbyeV0NCW3+DgER0ZzD0P2qjO16dnZKq+
	 0u+KqkdopAxhg==
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
	Shahar Shitrit <shshitrit@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>
Subject: [net 2/7] net/mlx5e: Add missing link modes to ptys2ethtool_map
Date: Mon,  9 Sep 2024 12:45:00 -0700
Message-ID: <20240909194505.69715-3-saeed@kernel.org>
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

From: Shahar Shitrit <shshitrit@nvidia.com>

Add MLX5E_1000BASE_T and MLX5E_100BASE_TX to the legacy
modes in ptys2legacy_ethtool_table, since they were missing.

Fixes: 665bc53969d7 ("net/mlx5e: Use new ethtool get/set link ksettings API")
Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 36845872ae94..1e829b97eaac 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -139,6 +139,10 @@ void mlx5e_build_ptys2ethtool_map(void)
 				       ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT);
 	MLX5_BUILD_PTYS2ETHTOOL_CONFIG(MLX5E_100GBASE_LR4, legacy,
 				       ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT);
+	MLX5_BUILD_PTYS2ETHTOOL_CONFIG(MLX5E_100BASE_TX, legacy,
+				       ETHTOOL_LINK_MODE_100baseT_Full_BIT);
+	MLX5_BUILD_PTYS2ETHTOOL_CONFIG(MLX5E_1000BASE_T, legacy,
+				       ETHTOOL_LINK_MODE_1000baseT_Full_BIT);
 	MLX5_BUILD_PTYS2ETHTOOL_CONFIG(MLX5E_10GBASE_T, legacy,
 				       ETHTOOL_LINK_MODE_10000baseT_Full_BIT);
 	MLX5_BUILD_PTYS2ETHTOOL_CONFIG(MLX5E_25GBASE_CR, legacy,
-- 
2.46.0


