Return-Path: <netdev+bounces-159067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5888EA14449
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 22:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF903A6940
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 21:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE9C242266;
	Thu, 16 Jan 2025 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s623yPyE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B53022CBDC
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737064556; cv=none; b=itv5vnWQhLhD11FtN+3ZxRmWXuPz5mnSq0rKNxnSWd+yCF0W3H4W3Jw7MrjKEF5e4O+ra43pQFwKNGl8a4yF0QQmC9oCwLq8WXNDPcnX/G0OSLeHEF/JTUspJWsE9ehI10AKMtfWOOyNv/om8rFfjV5EX34NUHam98MoVZDTXQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737064556; c=relaxed/simple;
	bh=HQ5ejpHYL17BwCWvx86kgR1GknZUZ2atB5m7+vTF1Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YVCnwGiwlTZoesHnMdVFPbhN1+OLMHJO1HenEALE2QQaR0RIAWldKjZOx8NR7WQd6YKd0dlW/5jofP6Dgr43yU7ujPviB0lklv842IPbiWTd5LTXZbd1r+bNQJD8l0AzcRFel4pcipv0X3KsfZHdX0MphsHKWhB/XKtKBzY4myA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s623yPyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14ACFC4CEDF;
	Thu, 16 Jan 2025 21:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737064556;
	bh=HQ5ejpHYL17BwCWvx86kgR1GknZUZ2atB5m7+vTF1Lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s623yPyEupJaNCzhAMUBXrpv1TPPsDhBNynFxW+sd46TwPMH5VLSV3c/PIdoScuSt
	 qVr6YgLIxMxpWI4YsROzk1l+fP89lEjSZQs8o0xekKkuq3fvQFDzOSm/hlK25K7fGT
	 pPvSTtuiGuMyn2Pm9/R1SKpUzTe3/oIM+EF1H13VvogruovpWNi7yBuvW30n1gPvre
	 SCoaopZwCEzJ0CSLOqbXI5S2fxDmbFH5D+PAYmg0fmzQZPE2taZsEk25z4dEA3dyJA
	 ggbu5FrXFxWG8pxjGnH3ZCfFClpvVYtmhSR9dBqMVAhZ5q7fGFs0EFUTfTSDr4ujUQ
	 Z0fTZeu5LMFTA==
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
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: [net-next 06/11] net/mlx5e: SHAMPO: Headers page pool stats
Date: Thu, 16 Jan 2025 13:55:24 -0800
Message-ID: <20250116215530.158886-7-saeed@kernel.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250116215530.158886-1-saeed@kernel.org>
References: <20250116215530.158886-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Expose the stats of the new headers page pool.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 53 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en_stats.h    | 24 +++++++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 611ec4b6f370..a34b829a810b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -208,6 +208,18 @@ static const struct counter_desc sw_stats_desc[] = {
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_ring) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_ring_full) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_recycle_released_ref) },
+
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_hd_alloc_fast) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_hd_alloc_slow) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_hd_alloc_slow_high_order) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_hd_alloc_empty) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_hd_alloc_refill) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_hd_alloc_waive) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_hd_recycle_cached) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_hd_recycle_cache_full) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_hd_recycle_ring) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_hd_recycle_ring_full) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_pp_hd_recycle_released_ref) },
 #endif
 #ifdef CONFIG_MLX5_EN_TLS
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_tls_decrypted_packets) },
@@ -389,6 +401,18 @@ static void mlx5e_stats_grp_sw_update_stats_rq_stats(struct mlx5e_sw_stats *s,
 	s->rx_pp_recycle_ring			+= rq_stats->pp_recycle_ring;
 	s->rx_pp_recycle_ring_full		+= rq_stats->pp_recycle_ring_full;
 	s->rx_pp_recycle_released_ref		+= rq_stats->pp_recycle_released_ref;
+
+	s->rx_pp_hd_alloc_fast          += rq_stats->pp_hd_alloc_fast;
+	s->rx_pp_hd_alloc_slow          += rq_stats->pp_hd_alloc_slow;
+	s->rx_pp_hd_alloc_empty         += rq_stats->pp_hd_alloc_empty;
+	s->rx_pp_hd_alloc_refill        += rq_stats->pp_hd_alloc_refill;
+	s->rx_pp_hd_alloc_waive         += rq_stats->pp_hd_alloc_waive;
+	s->rx_pp_hd_alloc_slow_high_order	+= rq_stats->pp_hd_alloc_slow_high_order;
+	s->rx_pp_hd_recycle_cached		+= rq_stats->pp_hd_recycle_cached;
+	s->rx_pp_hd_recycle_cache_full		+= rq_stats->pp_hd_recycle_cache_full;
+	s->rx_pp_hd_recycle_ring		+= rq_stats->pp_hd_recycle_ring;
+	s->rx_pp_hd_recycle_ring_full		+= rq_stats->pp_hd_recycle_ring_full;
+	s->rx_pp_hd_recycle_released_ref	+= rq_stats->pp_hd_recycle_released_ref;
 #endif
 #ifdef CONFIG_MLX5_EN_TLS
 	s->rx_tls_decrypted_packets   += rq_stats->tls_decrypted_packets;
@@ -518,6 +542,23 @@ static void mlx5e_stats_update_stats_rq_page_pool(struct mlx5e_channel *c)
 	rq_stats->pp_recycle_ring = stats.recycle_stats.ring;
 	rq_stats->pp_recycle_ring_full = stats.recycle_stats.ring_full;
 	rq_stats->pp_recycle_released_ref = stats.recycle_stats.released_refcnt;
+
+	pool = c->rq.hd_page_pool;
+	if (!pool || !page_pool_get_stats(pool, &stats))
+		return;
+
+	rq_stats->pp_hd_alloc_fast = stats.alloc_stats.fast;
+	rq_stats->pp_hd_alloc_slow = stats.alloc_stats.slow;
+	rq_stats->pp_hd_alloc_slow_high_order = stats.alloc_stats.slow_high_order;
+	rq_stats->pp_hd_alloc_empty = stats.alloc_stats.empty;
+	rq_stats->pp_hd_alloc_waive = stats.alloc_stats.waive;
+	rq_stats->pp_hd_alloc_refill = stats.alloc_stats.refill;
+
+	rq_stats->pp_hd_recycle_cached = stats.recycle_stats.cached;
+	rq_stats->pp_hd_recycle_cache_full = stats.recycle_stats.cache_full;
+	rq_stats->pp_hd_recycle_ring = stats.recycle_stats.ring;
+	rq_stats->pp_hd_recycle_ring_full = stats.recycle_stats.ring_full;
+	rq_stats->pp_hd_recycle_released_ref = stats.recycle_stats.released_refcnt;
 }
 #else
 static void mlx5e_stats_update_stats_rq_page_pool(struct mlx5e_channel *c)
@@ -2098,6 +2139,18 @@ static const struct counter_desc rq_stats_desc[] = {
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_ring) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_ring_full) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_recycle_released_ref) },
+
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_hd_alloc_fast) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_hd_alloc_slow) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_hd_alloc_slow_high_order) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_hd_alloc_empty) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_hd_alloc_refill) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_hd_alloc_waive) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_hd_recycle_cached) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_hd_recycle_cache_full) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_hd_recycle_ring) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_hd_recycle_ring_full) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, pp_hd_recycle_released_ref) },
 #endif
 #ifdef CONFIG_MLX5_EN_TLS
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, tls_decrypted_packets) },
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 5961c569cfe0..d69071e20083 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -227,6 +227,18 @@ struct mlx5e_sw_stats {
 	u64 rx_pp_recycle_ring;
 	u64 rx_pp_recycle_ring_full;
 	u64 rx_pp_recycle_released_ref;
+
+	u64 rx_pp_hd_alloc_fast;
+	u64 rx_pp_hd_alloc_slow;
+	u64 rx_pp_hd_alloc_slow_high_order;
+	u64 rx_pp_hd_alloc_empty;
+	u64 rx_pp_hd_alloc_refill;
+	u64 rx_pp_hd_alloc_waive;
+	u64 rx_pp_hd_recycle_cached;
+	u64 rx_pp_hd_recycle_cache_full;
+	u64 rx_pp_hd_recycle_ring;
+	u64 rx_pp_hd_recycle_ring_full;
+	u64 rx_pp_hd_recycle_released_ref;
 #endif
 #ifdef CONFIG_MLX5_EN_TLS
 	u64 tx_tls_encrypted_packets;
@@ -393,6 +405,18 @@ struct mlx5e_rq_stats {
 	u64 pp_recycle_ring;
 	u64 pp_recycle_ring_full;
 	u64 pp_recycle_released_ref;
+
+	u64 pp_hd_alloc_fast;
+	u64 pp_hd_alloc_slow;
+	u64 pp_hd_alloc_slow_high_order;
+	u64 pp_hd_alloc_empty;
+	u64 pp_hd_alloc_refill;
+	u64 pp_hd_alloc_waive;
+	u64 pp_hd_recycle_cached;
+	u64 pp_hd_recycle_cache_full;
+	u64 pp_hd_recycle_ring;
+	u64 pp_hd_recycle_ring_full;
+	u64 pp_hd_recycle_released_ref;
 #endif
 #ifdef CONFIG_MLX5_EN_TLS
 	u64 tls_decrypted_packets;
-- 
2.48.0


