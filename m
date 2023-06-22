Return-Path: <netdev+bounces-13019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E045B739E31
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 12:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C7E2818DB
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 10:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FD8171BA;
	Thu, 22 Jun 2023 10:15:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84DE3AABB;
	Thu, 22 Jun 2023 10:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4208C433C0;
	Thu, 22 Jun 2023 10:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687428932;
	bh=ddwNq7oMVHZRi+PxOrJpIvndAOCIW9Xj14GqlgpwMA0=;
	h=From:To:Cc:Subject:Date:From;
	b=AfDR9xsGjodZLtdc65RB5nqBaVJu06rRUp21I7Hw3wetmfaWPNi5vdgNf3cKJBu8H
	 wMZFvpAjv3u2x+bNi7eJ8BvWZWlyz/JE98CtHOH6xXFwIKcDSHvB7mezD7Gf7nIDud
	 UX3pVYcs3yx6tjdW/kJIxuu7k5MF2OPL6AKGmdG/0pEoOYr5B1npe5I2VelDSACJdK
	 MvgcTNwzAnG0s8LZVrTalK5QshnpzfVoPY/dXX8dZEi8olKSURfIUwzlzm1Aw4sMMf
	 oIPXM+hczyzpELBKEMapdd7lRZO4iUzlWI2X31WaWhvwIEGX1Y3cnc9svGRVYLlGtc
	 VTVqaOnaQ6XdA==
From: Arnd Bergmann <arnd@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Maxim Mikityanskiy <maxtram95@gmail.com>,
	Adham Faris <afaris@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] mlx5: avoid integer overflow warning for large page size
Date: Thu, 22 Jun 2023 12:15:02 +0200
Message-Id: <20230622101525.3321642-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Build testing with 'make LLVM=1 W=1' shows a warning about a
condition that is always true on configurations with 64KB
pages:

drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c:32:22: error: result of comparison of constant 65536 with expression of type 'u16' (aka 'unsigned short') is always false [-Werror,-Wtautological-constant-out-of-range-compare]

Change the condition in a way that lets clang know this
is intentional.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
index 36826b5824847..b9f62e531bd4c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
@@ -29,7 +29,8 @@ bool mlx5e_validate_xsk_param(struct mlx5e_params *params,
 			      struct mlx5_core_dev *mdev)
 {
 	/* AF_XDP doesn't support frames larger than PAGE_SIZE. */
-	if (xsk->chunk_size > PAGE_SIZE || xsk->chunk_size < MLX5E_MIN_XSK_CHUNK_SIZE) {
+	if ((PAGE_SIZE < U16_MAX && xsk->chunk_size > PAGE_SIZE)
+	    || xsk->chunk_size < MLX5E_MIN_XSK_CHUNK_SIZE) {
 		mlx5_core_err(mdev, "XSK chunk size %u out of bounds [%u, %lu]\n", xsk->chunk_size,
 			      MLX5E_MIN_XSK_CHUNK_SIZE, PAGE_SIZE);
 		return false;
-- 
2.39.2


