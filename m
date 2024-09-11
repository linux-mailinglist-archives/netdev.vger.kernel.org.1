Return-Path: <netdev+bounces-127546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF7A975B8B
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8271C219D9
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1BA1BB69A;
	Wed, 11 Sep 2024 20:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQl7Hv+m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5789A1BB696
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085882; cv=none; b=nwlyoD3+JgHIprTCYW4WloKfsDwenYgWziFsdIOzlKcO/Xg/yxAbR/2LQ4BMOpdfF6mnNu7Rejxib/oCYVTFR5ToZTRYclzeiptzqv3piD+KG75Y5Kc6Rzq8g/hreJ3t11ZQVw5NbHaDjhh+H7NqJTl98MebJvH4vByecFOwwDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085882; c=relaxed/simple;
	bh=vBN8vBcLLZ7D/zw9ZNtIzp9q+Xf5WKDt/BJe/4F90rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xb/+/Gn9BrjuOJqWz8k25vv5rdiQX9hw+46DZeFw3xFctxNprOQL1BDWM/KfZsUG0bmXgzSzjRPdkLZ6Y8e25MUdBm9FbA2PT3dIek6gKK/cea2dm7ct7qlE+Gd8CueSxH5b+eARsHe7JyOyOrwMhDc2EMctSgwyZDLCIPXzkAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQl7Hv+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D118FC4CEC0;
	Wed, 11 Sep 2024 20:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726085881;
	bh=vBN8vBcLLZ7D/zw9ZNtIzp9q+Xf5WKDt/BJe/4F90rQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fQl7Hv+mKtQXJxcu3OCe1EpcGPOwZn33Capv2Gut+I+Yh02G7BrA8Npmx+jgt7W4a
	 cRfN1VlqUMwph53p0mrEmO8zRbtN5QbXlGNau13DdxoqO5saZVUGmXfSvAQ4aqIwM/
	 7amQjHdJGVXS2CYB1I/5bl6R+RvzA18BkMw9GDvYjJ2n3EeYIcV9zW3FYTmlG5ILLU
	 U5pA+/ggdcDDVD4oj/FNOCdLSspS/sncpgptrV8xUMvqiYHqYWuVRkehIgNwrVpTNV
	 l+rakZ2gEx4MexvmsWxdqy/GnwHSEp8sDmQj6DP3StpNl/5PobBDI/9Rytl6bkSKZC
	 x4QdaLDDIQBzw==
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
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [net-next 02/15] net/mlx5: HWS, fixed error flow return values of some functions
Date: Wed, 11 Sep 2024 13:17:44 -0700
Message-ID: <20240911201757.1505453-3-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911201757.1505453-1-saeed@kernel.org>
References: <20240911201757.1505453-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Fixed all the '-ret' returns in error flow of functions to 'ret',
as the internal functions are already returning negative error values
(e.g. -EINVAL)

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/mlx5hws_matcher.c     | 2 +-
 .../mellanox/mlx5/core/steering/hws/mlx5hws_rule.c        | 8 ++++----
 .../mellanox/mlx5/core/steering/hws/mlx5hws_table.c       | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.c
index 1964261415aa..33d2b31e4b46 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.c
@@ -967,7 +967,7 @@ int mlx5hws_matcher_attach_at(struct mlx5hws_matcher *matcher,
 
 	ret = hws_matcher_check_and_process_at(matcher, at);
 	if (ret)
-		return -ret;
+		return ret;
 
 	required_stes = at->num_of_action_stes - (!is_jumbo || at->only_term);
 	if (matcher->action_ste[MLX5HWS_ACTION_STE_IDX_ANY].max_stes < required_stes) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_rule.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_rule.c
index c79ee70edf03..8a011b958b43 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_rule.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_rule.c
@@ -751,11 +751,11 @@ int mlx5hws_rule_destroy(struct mlx5hws_rule *rule,
 
 	ret = hws_rule_enqueue_precheck(rule, attr);
 	if (unlikely(ret))
-		return -ret;
+		return ret;
 
 	ret = hws_rule_destroy_hws(rule, attr);
 
-	return -ret;
+	return ret;
 }
 
 int mlx5hws_rule_action_update(struct mlx5hws_rule *rule,
@@ -767,7 +767,7 @@ int mlx5hws_rule_action_update(struct mlx5hws_rule *rule,
 
 	ret = hws_rule_enqueue_precheck_update(rule, attr);
 	if (unlikely(ret))
-		return -ret;
+		return ret;
 
 	ret = hws_rule_create_hws(rule,
 				  attr,
@@ -776,5 +776,5 @@ int mlx5hws_rule_action_update(struct mlx5hws_rule *rule,
 				  at_idx,
 				  rule_actions);
 
-	return -ret;
+	return ret;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_table.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_table.c
index 9dbc3e9da5ea..8c063a8d87d7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_table.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_table.c
@@ -489,5 +489,5 @@ int mlx5hws_table_set_default_miss(struct mlx5hws_table *tbl,
 	return 0;
 out:
 	mutex_unlock(&ctx->ctrl_lock);
-	return -ret;
+	return ret;
 }
-- 
2.46.0


