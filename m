Return-Path: <netdev+bounces-48179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418377ECD90
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 20:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB7A281563
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 19:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AA1446AF;
	Wed, 15 Nov 2023 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5HI3W3H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7DC446AD
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 19:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741F6C433C9;
	Wed, 15 Nov 2023 19:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700077015;
	bh=etudxdGtBrISOhVFfZeRsNdQQI6GSAO3tH9FQxYSOVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c5HI3W3HdXbedmLCntujT1NdzxmTAC5K2A9OCDY+T1qT1JF3uKOd9UD4kmllfZbNh
	 LYpUXJgLESPLcFG/D+J3HLtYweokLPsgoHbTL28yhldLXG3jTRtTH8DFHGeDT5XWtO
	 CeqSBEl1UiU9QLmnD8cUTwSOvJ6UW28UQW7BykvIi1n3W6UMwm+ht4ZYrzh+Id2VIS
	 ONrJaB5n5YlE/lcDd2IrSLl29lyhphPGka2JawLOSJvRc6yH5vfS9LUQwfnRY5xq08
	 CvYXT9LgpZQ5/eq/ArG0vbBR/tAFjCyu5e3V2/0QMhfeqkLaYddIOptvHXuw6Cx8Ws
	 72IUdpeMZ5tHg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Kees Cook <keescook@chromium.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	Justin Stitt <justinstitt@google.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net-next V2 04/13] net/mlx5: Annotate struct mlx5_fc_bulk with __counted_by
Date: Wed, 15 Nov 2023 11:36:40 -0800
Message-ID: <20231115193649.8756-5-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115193649.8756-1-saeed@kernel.org>
References: <20231115193649.8756-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kees Cook <keescook@chromium.org>

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct mlx5_fc_bulk.

Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: linux-rdma@vger.kernel.org
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
index 17fe30a4c06c..0c26d707eed2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
@@ -539,7 +539,7 @@ struct mlx5_fc_bulk {
 	u32 base_id;
 	int bulk_len;
 	unsigned long *bitmask;
-	struct mlx5_fc fcs[];
+	struct mlx5_fc fcs[] __counted_by(bulk_len);
 };
 
 static void mlx5_fc_init(struct mlx5_fc *counter, struct mlx5_fc_bulk *bulk,
-- 
2.41.0


