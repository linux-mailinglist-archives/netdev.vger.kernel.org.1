Return-Path: <netdev+bounces-27497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5801C77C296
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 23:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B54D1C20BB2
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D5610947;
	Mon, 14 Aug 2023 21:41:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69A11078F
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 21:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBB6C433AB;
	Mon, 14 Aug 2023 21:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692049316;
	bh=0/0WgKHo93qZhtR7H1mxNo2bKAFuDPBBJzaI0WkB9Eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RghTze1XLFA5ssWYh312fN06uPVODImB45aQ9BKBHpv+/Te1oanbPYvxZLBzHLq1s
	 iL9RSUjS0qZYvq0fzePHh2hIoENlt8hEmp9fmoFIP3x7XTuNQ0leuJnpUMMqc2NQ6J
	 0nF/+i5LSpPUN4grI6CIQyL/rgK9B151usn8dIehC9/oQddqEpBK2buohndvbQEY9v
	 P8RN5E98+10DbstW9qupyMwFOKsoth4YP7GBLytmg7nXgI84/+757k/mCulmnPCRH3
	 pqWPC7bEn1o9aCdnqQsttMKmNFQKKpwlWHD/gLVH+IMLNTVOn0/SkdUK1wvEDBtw9g
	 FL1u7lwFP5o0A==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: [net-next 08/14] net/mlx5: Remove redundant SF supported check from mlx5_sf_hw_table_init()
Date: Mon, 14 Aug 2023 14:41:38 -0700
Message-ID: <20230814214144.159464-9-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814214144.159464-1-saeed@kernel.org>
References: <20230814214144.159464-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Since mlx5_sf_supported() check is done as a first thing in
mlx5_sf_max_functions(), remove the redundant check.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/sf/hw_table.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/hw_table.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/hw_table.c
index c4daeaaafead..1f613320fe07 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/hw_table.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/hw_table.c
@@ -275,15 +275,14 @@ int mlx5_sf_hw_table_init(struct mlx5_core_dev *dev)
 	struct mlx5_sf_hw_table *table;
 	u16 max_ext_fn = 0;
 	u16 ext_base_id = 0;
-	u16 max_fn = 0;
 	u16 base_id;
+	u16 max_fn;
 	int err;
 
 	if (!mlx5_vhca_event_supported(dev))
 		return 0;
 
-	if (mlx5_sf_supported(dev))
-		max_fn = mlx5_sf_max_functions(dev);
+	max_fn = mlx5_sf_max_functions(dev);
 
 	err = mlx5_esw_sf_max_hpf_functions(dev, &max_ext_fn, &ext_base_id);
 	if (err)
-- 
2.41.0


