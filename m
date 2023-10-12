Return-Path: <netdev+bounces-40471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7CE7C7765
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4331C20FC0
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 19:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA22D3CD0D;
	Thu, 12 Oct 2023 19:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdNTihPF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7FB3C68C
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 19:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2709BC433C7;
	Thu, 12 Oct 2023 19:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697140393;
	bh=tou32BMyWect8WWwsA7kPmkdT4twgTBBYvp2mWy44L4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OdNTihPF6Mr/TAdNQ8dnxOVHZ1kyCThH34u5eAJavwUHNiAb6uP1967BIbnDDqMvY
	 1rYD6MfjNrgzM9QdsWluPaQ2uzPTBINx6ByO+u62PbkluUvA551ip2xZYXukjsaVN8
	 QaKboQZZD5f6TvkGsv2uIPzDI9g6iUMcrSaWm5UbdJFqzy075du8lkPsUSDB6jT3iT
	 r8K0TqxKR3K17UzfusO1U6NcZZrAx0J5siVUrqWzdJ8VwOSEX3659I8QJ8fT/rJ4z1
	 i9JDYrnOKy05T/fhF1uHDXUS7kBz2INUQKjV66/vEwSHXVrdrgMyrfm/1Ivc1nHaNj
	 bUqzLpvxxnLDA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Chris Mason <clm@fb.com>
Subject: [net 05/10] net/mlx5e: RX, Fix page_pool allocation failure recovery for striding rq
Date: Thu, 12 Oct 2023 12:51:22 -0700
Message-ID: <20231012195127.129585-6-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012195127.129585-1-saeed@kernel.org>
References: <20231012195127.129585-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dragos Tatulea <dtatulea@nvidia.com>

When a page allocation fails during refill in mlx5e_post_rx_mpwqes, the
page will be released again on the next refill call. This triggers the
page_pool negative page fragment count warning below:

 [ 2436.447717] WARNING: CPU: 1 PID: 2419 at include/net/page_pool/helpers.h:130 mlx5e_page_release_fragmented.isra.0+0x42/0x50 [mlx5_core]
 ...
 [ 2436.447895] RIP: 0010:mlx5e_page_release_fragmented.isra.0+0x42/0x50 [mlx5_core]
 [ 2436.447991] Call Trace:
 [ 2436.447975]  mlx5e_post_rx_mpwqes+0x1d5/0xcf0 [mlx5_core]
 [ 2436.447994]  <IRQ>
 [ 2436.447996]  ? __warn+0x7d/0x120
 [ 2436.448009]  ? mlx5e_handle_rx_cqe_mpwrq+0x109/0x1d0 [mlx5_core]
 [ 2436.448002]  ? mlx5e_page_release_fragmented.isra.0+0x42/0x50 [mlx5_core]
 [ 2436.448044]  ? mlx5e_poll_rx_cq+0x87/0x6e0 [mlx5_core]
 [ 2436.448061]  ? report_bug+0x155/0x180
 [ 2436.448065]  ? handle_bug+0x36/0x70
 [ 2436.448067]  ? exc_invalid_op+0x13/0x60
 [ 2436.448070]  ? asm_exc_invalid_op+0x16/0x20
 [ 2436.448079]  mlx5e_napi_poll+0x122/0x6b0 [mlx5_core]
 [ 2436.448077]  ? mlx5e_page_release_fragmented.isra.0+0x42/0x50 [mlx5_core]
 [ 2436.448113]  ? generic_exec_single+0x35/0x100
 [ 2436.448117]  __napi_poll+0x25/0x1a0
 [ 2436.448120]  net_rx_action+0x28a/0x300
 [ 2436.448122]  __do_softirq+0xcd/0x279
 [ 2436.448126]  irq_exit_rcu+0x6a/0x90
 [ 2436.448128]  sysvec_apic_timer_interrupt+0x6e/0x90
 [ 2436.448130]  </IRQ>

This patch fixes the striding rq case by setting the skip flag on all
the wqe pages that were expected to have new pages allocated.

Fixes: 4c2a13236807 ("net/mlx5e: RX, Defer page release in striding rq for better recycling")
Tested-by: Chris Mason <clm@fb.com>
Reported-by: Chris Mason <clm@fb.com>
Closes: https://lore.kernel.org/netdev/117FF31A-7BE0-4050-B2BB-E41F224FF72F@meta.com
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 3fd11b0761e0..7988b3a9598c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -816,6 +816,8 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 		mlx5e_page_release_fragmented(rq, frag_page);
 	}
 
+	bitmap_fill(wi->skip_release_bitmap, rq->mpwqe.pages_per_wqe);
+
 err:
 	rq->stats->buff_alloc_err++;
 
-- 
2.41.0


