Return-Path: <netdev+bounces-129851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8354198678A
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 22:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46BE92845D6
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 20:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36080154452;
	Wed, 25 Sep 2024 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbS72fY2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF2F154420
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 20:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727295624; cv=none; b=EPPRhl15SqV5pBJGtpDH5p21orOVQcHMjAx0l+fKnvNkU5SlY4VRZy5oH8oJLpxPJ8GZOPihkMxGMG+JxoJI3F3NPUZiX5V7E4P5K4gb92H1eqZ0oPuZGcc12zTuRSMJTCVciVzhIoXYwfsdrydV6CpTxnjoKpAWY3q5ou5lTbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727295624; c=relaxed/simple;
	bh=h5RN0PGYou2v5vLsubKxgEXrp0aHqNkuR7lcYqYnEyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2CAVz8M43w2isb4Of4z5jwUHwxQkHdcI0Ix2FYyBGkr3K5CVE+t2f/vyKhmhXf4wwIeiyZVrmOzzk2FicDn7YksYVca0wrFOhjKDLE0NIj+XMICqNWtGlDeszIw/RjZXRtgQ/FBN6vqWBRxxSwk5I8HKvpClomEj1YPkI60UP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbS72fY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FF8C4CEC3;
	Wed, 25 Sep 2024 20:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727295623;
	bh=h5RN0PGYou2v5vLsubKxgEXrp0aHqNkuR7lcYqYnEyc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jbS72fY2fws6WeZqM9FnREJrxebrx2CrBuW8/vyUcL+AVs+SqnEPEZjWmMMZuP5jc
	 rhFMCIkGd7/vk1tUEpZFJpLxpAc9FxmPAFUjc+1X1dEopVX1kjqx2bkqNWjsnfq1ti
	 1bxj14RxeGdCLIhC2VCzlNaf561kg0zuWNzVjhmCUs1In5c0mBTG62J8ONw9wcTEqz
	 brwg4IrmwDmhIBOwZyjvUqM5TG19uzveVDfin9mV8ktcDqYBXCbqG6aavI+oj/BnQ+
	 miUBKr6tu57kqKrov93RzwASC81LUYwmOGW2zCAuFq1kwzvoV3aMAwV6mNXA6oCt/A
	 BFnb/inHBVYkg==
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
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [net 6/8] net/mlx5: HWS, changed E2BIG error to a negative return code
Date: Wed, 25 Sep 2024 13:20:11 -0700
Message-ID: <20240925202013.45374-7-saeed@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240925202013.45374-1-saeed@kernel.org>
References: <20240925202013.45374-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Fixed all the 'E2BIG' returns in error flow of functions to
the negative '-E2BIG' as we are using negative error codes
everywhere in HWS code.

This also fixes the following smatch warnings:
	"warn: was negative '-E2BIG' intended?"

Fixes: 74a778b4a63f ("net/mlx5: HWS, added definers handling")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/f8c77688-7d83-4937-baba-ac844dfe2e0b@stanley.mountain/
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/mlx5hws_bwc_complex.c     | 2 +-
 .../mellanox/mlx5/core/steering/hws/mlx5hws_definer.c         | 4 ++--
 .../mellanox/mlx5/core/steering/hws/mlx5hws_matcher.c         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc_complex.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc_complex.c
index bb563f50ef09..601fad5fc54a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc_complex.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_bwc_complex.c
@@ -33,7 +33,7 @@ bool mlx5hws_bwc_match_params_is_complex(struct mlx5hws_context *ctx,
 		 * and let the usual match creation path handle it,
 		 * both for good and bad flows.
 		 */
-		if (ret == E2BIG) {
+		if (ret == -E2BIG) {
 			is_complex = true;
 			mlx5hws_dbg(ctx, "Matcher definer layout: need complex matcher\n");
 		} else {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c
index 3bdb5c90efff..d566d2ddf424 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c
@@ -1845,7 +1845,7 @@ hws_definer_find_best_match_fit(struct mlx5hws_context *ctx,
 		return 0;
 	}
 
-	return E2BIG;
+	return -E2BIG;
 }
 
 static void
@@ -1931,7 +1931,7 @@ mlx5hws_definer_calc_layout(struct mlx5hws_context *ctx,
 	/* Find the match definer layout for header layout match union */
 	ret = hws_definer_find_best_match_fit(ctx, match_definer, match_hl);
 	if (ret) {
-		if (ret == E2BIG)
+		if (ret == -E2BIG)
 			mlx5hws_dbg(ctx,
 				    "Failed to create match definer from header layout - E2BIG\n");
 		else
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.c
index 33d2b31e4b46..61a1155d4b4f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.c
@@ -675,7 +675,7 @@ static int hws_matcher_bind_mt(struct mlx5hws_matcher *matcher)
 	if (!(matcher->flags & MLX5HWS_MATCHER_FLAGS_COLLISION)) {
 		ret = mlx5hws_definer_mt_init(ctx, matcher->mt);
 		if (ret) {
-			if (ret == E2BIG)
+			if (ret == -E2BIG)
 				mlx5hws_err(ctx, "Failed to set matcher templates with match definers\n");
 			return ret;
 		}
-- 
2.46.1


