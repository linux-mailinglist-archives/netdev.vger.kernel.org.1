Return-Path: <netdev+bounces-159069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B275A14448
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 22:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3113816BB0B
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 21:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B473524335E;
	Thu, 16 Jan 2025 21:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1Uny3wa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9085D1F37AA
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 21:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737064558; cv=none; b=ZFy6X0Hfzt3kUO9vvzVnyrsHhnA5GBS7PS1dtYctAIBxIzvpycUugPMXE9Y0K7FV3K+rf80tYyYqeiH9d83RVkrSB2MaKicGyvLF3UqD5d4WBdgVGQEMazkNkWm4vYV2g1Wfw+HwhupwCEdT/UEGo+5HmiEmoWjyNSFf3Koazss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737064558; c=relaxed/simple;
	bh=k1H4Xyi58jPIckQ7FrA+5Iw1Sg4R1V8kYooAN+elpE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZ0C912ZGlmLjIAKCQoftWRKZYN0eWqP2fIlesKp4UfkxaGFA/OyN7I4UKCs2jQK93ET4ofIZ85r5ZRaqriAF1NtfJhcL0aSUvx1iTd0pLONulJsNa9H6rfxLkCxtfgy1+c4fKjl6oTlS66MDk1eCLM3LFIym7JR8fkau4OiMIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1Uny3wa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C00C4CED6;
	Thu, 16 Jan 2025 21:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737064558;
	bh=k1H4Xyi58jPIckQ7FrA+5Iw1Sg4R1V8kYooAN+elpE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J1Uny3wauLEPeZR4PUXwHKNDdeVclxPveYbHKo2/so0lhU9VrPXfgIjUu9jGpAZLd
	 aUdX650IzpdRd9NsNAeg7aHqh4bHECv4MRQDQjRwVCo0EXPBW/uz6ErmO/u8vTe30E
	 l0J05XHja7/0kDwtR5z3x7b1GgzBAHzteJ9eDxj3dZOHKYY0XXz0Ozl+LrXQm+F88x
	 p+gL3R8qm6hrMViqcEHt5gpyqfcrvqYxa8701GHt8U8gVyeuVsNaCqFu16lwxeO2k2
	 VEqbMyLLU+TdNaGHAyBLvc0wQaeiKFnzq2Z1PP1SwMozZDxFsnrz4IGqGhHvbcFKGu
	 edj7cn9nC1hVg==
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
Subject: [net-next 08/11] net/mlx5e: Handle iov backed netmems
Date: Thu, 16 Jan 2025 13:55:26 -0800
Message-ID: <20250116215530.158886-9-saeed@kernel.org>
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

Special page pools can allocate an iov backed netmem, such netmem pages
are unreachable by driver, for such cases don't attempt to access those
pages in the driver. The only affected path is
mlx5e_add_skb_frag()->skb_can_coalesce().

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index b08c2ac10b67..2ac00962c7a3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -528,15 +528,18 @@ mlx5e_add_skb_frag(struct mlx5e_rq *rq, struct sk_buff *skb,
 		   unsigned int truesize)
 {
 	dma_addr_t addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
-	struct page *page = netmem_to_page(frag_page->netmem);
 	u8 next_frag = skb_shinfo(skb)->nr_frags;
 
 	dma_sync_single_for_cpu(rq->pdev, addr + frag_offset, len,
 				rq->buff.map_dir);
 
-	if (skb_can_coalesce(skb, next_frag, page, frag_offset)) {
-		skb_coalesce_rx_frag(skb, next_frag - 1, len, truesize);
-		return;
+	if (!netmem_is_net_iov(frag_page->netmem)) {
+		struct page *page = netmem_to_page(frag_page->netmem);
+
+		if (skb_can_coalesce(skb, next_frag, page, frag_offset)) {
+			skb_coalesce_rx_frag(skb, next_frag - 1, len, truesize);
+			return;
+		}
 	}
 
 	frag_page->frags++;
-- 
2.48.0


