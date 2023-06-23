Return-Path: <netdev+bounces-13531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2B973BEE2
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 21:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342C3281CCC
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 19:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3422D1429D;
	Fri, 23 Jun 2023 19:29:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B34E11CBB
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 19:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7749C433C9;
	Fri, 23 Jun 2023 19:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687548567;
	bh=TpW3DD+tbX2KtI+8ko7C3YXrkZdAuQAwkvkJAGVFRec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jmxoQEtaQE+ZygrCgE4VIvittFwoaLOMStOn17+3288SGASA3rJO0+Vy/fiPtyHsI
	 4langpmGO8nNLrPIXUHbQyfBycjG8anBBAATFnRa42KwUYkOyy4ffQDGHU8KXDwBd9
	 KO0ZDAU2XkX+mCdFCSmblR0/O1/zE4t7W2AKZcWLL/blutVKsF4hkK2kR9ZeOYltsM
	 W+UXao7dChN2iTdCNaYwDxegTyxI7u9QuRmGYEyvaRf6jOMHPArybvd+dk+gOfew+T
	 7iBOM3P7OLY5+c36mMG8dWaFDtEGTiT8mH2Dm6OpoXl8F2dhrLbwRHRbmwDplsWMTO
	 8FuOLSgLy9SkA==
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
Subject: [net-next V2 13/15] net/mlx5: Remove redundant is_mdev_switchdev_mode() check from is_ib_rep_supported()
Date: Fri, 23 Jun 2023 12:29:05 -0700
Message-ID: <20230623192907.39033-14-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230623192907.39033-1-saeed@kernel.org>
References: <20230623192907.39033-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

is_mdev_switchdev_mode() check is done in is_eth_rep_supported().
Function is_ib_rep_supported() calls is_eth_rep_supported().
Remove the redundant check from it.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/dev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
index 3b1e925f16d2..edb06fb9bbc5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
@@ -151,9 +151,6 @@ static bool is_ib_rep_supported(struct mlx5_core_dev *dev)
 	if (!is_eth_rep_supported(dev))
 		return false;
 
-	if (!is_mdev_switchdev_mode(dev))
-		return false;
-
 	if (mlx5_core_mp_enabled(dev))
 		return false;
 
-- 
2.41.0


