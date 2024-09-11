Return-Path: <netdev+bounces-127558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537AF975B97
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8621E1C222B4
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F56E1BCA12;
	Wed, 11 Sep 2024 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZPXUEm1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C73C1BCA0E
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085893; cv=none; b=rLaFDZ5NSd9FJfZlSvvdhITfCM8OMj2tYleR3OMbBZyp2Q1MZ1bV+YBJ9WBselgfaQ8CO2ai23MSclvU7eb0lgRa3LdxgUzyhe1nI+COKzyy394nE8jMyeBjtDSnWkh2Kj6TZZm0qEeeadWVNn3Rj9mmzdLpiIbdBoVgfHk1bAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085893; c=relaxed/simple;
	bh=CgjwSvF6d17c++A2qwIGw4V31UIpCOjzuXwCm0R38hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kiOnAH60TkiZQ0MUpLJHxVwDpqq4SMME4ctGiLw/vLejJ+RpR6UrKlxuo2krSOTMBW1eotpry/nVDXx0M5pkf+JcbRaUIFJ024u0/Bx9DIk/xbPOw2uGGsFCgW84OfFNeFPZ69soB/Xg3oI+IhPFFwuHYU4MXenKSQMCSg+i6bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZPXUEm1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D492FC4CEC0;
	Wed, 11 Sep 2024 20:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726085892;
	bh=CgjwSvF6d17c++A2qwIGw4V31UIpCOjzuXwCm0R38hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SZPXUEm1YRi9gPanJlhsQnhle9SVMjs1iKm0j9fWBp39H8fi09xoZFegiZBS+RXoS
	 KEdLJrsJ/Bl5aZ0yn0/JTRs659eLLHBrTc0wJTebrWx8QeZu83qJA2u7Avg4aY9ZVf
	 EYNCH8U4OhqTa9OryzeRYiPv1b55m+eYtwdC2D4NatStDyNDslsOgf80vJQbL++siB
	 qyqA4EuLQ6NgrI5/wV/vHrqq6jHA7ZbmvyrfG1Jeu/YABVFdH3PIM9JcvjOuORGzZG
	 Vzgq7Mf9kP5bp2hp0zmcPmZkR/iZHkbK3bWBRytStfGgJbmht+9QtUQg4MZ5+604ba
	 Fw+rPetuKdT2g==
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
Subject: [net-next 14/15] net/mlx5e: SHAMPO, Add no-split ethtool counters for header/data split
Date: Wed, 11 Sep 2024 13:17:56 -0700
Message-ID: <20240911201757.1505453-15-saeed@kernel.org>
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

From: Dragos Tatulea <dtatulea@nvidia.com>

When SHAMPO can't identify the protocol/header of a packet, it will
yield a packet that is not split - all the packet is in the data part.
Count this value in packets and bytes.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../ethernet/mellanox/mlx5/counters.rst          | 16 ++++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c  |  3 +++
 .../net/ethernet/mellanox/mlx5/core/en_stats.c   |  6 ++++++
 .../net/ethernet/mellanox/mlx5/core/en_stats.h   |  4 ++++
 4 files changed, 29 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
index 3bd72577af9a..99d95be4d159 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
@@ -218,6 +218,22 @@ the software port.
        [#accel]_.
      - Informative
 
+   * - `rx[i]_hds_nosplit_packets`
+     - Number of packets that were not split in header/data split mode. A
+       packet will not get split when the hardware does not support its
+       protocol splitting. An example such a protocol is ICMPv4/v6. Currently
+       TCP and UDP with IPv4/IPv6 are supported for header/data split
+       [#accel]_.
+     - Informative
+
+   * - `rx[i]_hds_nosplit_bytes`
+     - Number of bytes for packets that were not split in header/data split
+       mode. A packet will not get split when the hardware does not support its
+       protocol splitting. An example such a protocol is ICMPv4/v6. Currently
+       TCP and UDP with IPv4/IPv6 are supported for header/data split
+       [#accel]_.
+     - Informative
+
    * - `rx[i]_lro_packets`
      - The number of LRO packets received on ring i [#accel]_.
      - Acceleration
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index de9d01036c28..8e24ba96c779 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2346,6 +2346,9 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 			stats->hds_nodata_packets++;
 			stats->hds_nodata_bytes += head_size;
 		}
+	} else {
+		stats->hds_nosplit_packets++;
+		stats->hds_nosplit_bytes += data_bcnt;
 	}
 
 	mlx5e_shampo_complete_rx_cqe(rq, cqe, cqe_bcnt, *skb);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index e7a3290a708a..611ec4b6f370 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -144,6 +144,8 @@ static const struct counter_desc sw_stats_desc[] = {
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_gro_large_hds) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_hds_nodata_packets) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_hds_nodata_bytes) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_hds_nosplit_packets) },
+	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_hds_nosplit_bytes) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_ecn_mark) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_removed_vlan_packets) },
 	{ MLX5E_DECLARE_STAT(struct mlx5e_sw_stats, rx_csum_unnecessary) },
@@ -347,6 +349,8 @@ static void mlx5e_stats_grp_sw_update_stats_rq_stats(struct mlx5e_sw_stats *s,
 	s->rx_gro_large_hds           += rq_stats->gro_large_hds;
 	s->rx_hds_nodata_packets      += rq_stats->hds_nodata_packets;
 	s->rx_hds_nodata_bytes        += rq_stats->hds_nodata_bytes;
+	s->rx_hds_nosplit_packets     += rq_stats->hds_nosplit_packets;
+	s->rx_hds_nosplit_bytes       += rq_stats->hds_nosplit_bytes;
 	s->rx_ecn_mark                += rq_stats->ecn_mark;
 	s->rx_removed_vlan_packets    += rq_stats->removed_vlan_packets;
 	s->rx_csum_none               += rq_stats->csum_none;
@@ -2062,6 +2066,8 @@ static const struct counter_desc rq_stats_desc[] = {
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, gro_large_hds) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, hds_nodata_packets) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, hds_nodata_bytes) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, hds_nosplit_packets) },
+	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, hds_nosplit_bytes) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, ecn_mark) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, removed_vlan_packets) },
 	{ MLX5E_DECLARE_RX_STAT(struct mlx5e_rq_stats, wqe_err) },
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 4c5858c1dd82..5961c569cfe0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -156,6 +156,8 @@ struct mlx5e_sw_stats {
 	u64 rx_gro_large_hds;
 	u64 rx_hds_nodata_packets;
 	u64 rx_hds_nodata_bytes;
+	u64 rx_hds_nosplit_packets;
+	u64 rx_hds_nosplit_bytes;
 	u64 rx_mcast_packets;
 	u64 rx_ecn_mark;
 	u64 rx_removed_vlan_packets;
@@ -356,6 +358,8 @@ struct mlx5e_rq_stats {
 	u64 gro_large_hds;
 	u64 hds_nodata_packets;
 	u64 hds_nodata_bytes;
+	u64 hds_nosplit_packets;
+	u64 hds_nosplit_bytes;
 	u64 mcast_packets;
 	u64 ecn_mark;
 	u64 removed_vlan_packets;
-- 
2.46.0


