Return-Path: <netdev+bounces-43191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5FA7D1B5B
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 08:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53ACCB21550
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 06:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A651D26B;
	Sat, 21 Oct 2023 06:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cw/SIAE0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDBAD268
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 06:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3EBC433C8;
	Sat, 21 Oct 2023 06:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697870791;
	bh=GpLz4XP1DfpAfyF6sE3D40kPG2AD+/0ewXOCqLaUKy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cw/SIAE0Tq5F1ZkkJx4/5LVvgatIFpgv+z4FC990DstEitQkpD7Ff2Ey3zueijsJ5
	 hoNDI8axul9wD30f6Ru211iSy22HugD3eGryHH9k+rhO4nVAWfgv62hD5yyl2iRiVz
	 zjQhgFDXGAZomWmq35vuHSwIMOQlkJK9Ir2/UY3NDKBgetnfhv/ghOU+DpbD5aeNBT
	 JacqNyF5PnShdhKLN5v+vAmL9bJKfoSw/RA0CrkhNjeCwj9508uUGEfL4t+8kG8uXd
	 EAihskiuJNL7kPJZyyaJeTdZ6/tYBzT0XCe+lmzK1YCIs9tIGzZtNF1wWYr41FcylA
	 Rv0lQe7Nv4l+Q==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net-next V2 04/15] net/mlx5e: Ensure that IPsec sequence packet number starts from 1
Date: Fri, 20 Oct 2023 23:46:09 -0700
Message-ID: <20231021064620.87397-5-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231021064620.87397-1-saeed@kernel.org>
References: <20231021064620.87397-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

According to RFC4303, section "3.3.3. Sequence Number Generation",
the first packet sent using a given SA will contain a sequence
number of 1.

However if user didn't set seq/oseq, the HW used zero as first sequence
packet number. Such misconfiguration causes to drop of first packet
if replay window protection was enabled in SA.

To fix it, set sequence number to be at least 1.

Fixes: 7db21ef4566e ("net/mlx5e: Set IPsec replay sequence numbers")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index ddd2230f04aa..bf88232a2fc2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -121,7 +121,14 @@ static bool mlx5e_ipsec_update_esn_state(struct mlx5e_ipsec_sa_entry *sa_entry)
 	if (x->xso.type == XFRM_DEV_OFFLOAD_CRYPTO)
 		esn_msb = xfrm_replay_seqhi(x, htonl(seq_bottom));
 
-	sa_entry->esn_state.esn = esn;
+	if (sa_entry->esn_state.esn_msb)
+		sa_entry->esn_state.esn = esn;
+	else
+		/* According to RFC4303, section "3.3.3. Sequence Number Generation",
+		 * the first packet sent using a given SA will contain a sequence
+		 * number of 1.
+		 */
+		sa_entry->esn_state.esn = max_t(u32, esn, 1);
 	sa_entry->esn_state.esn_msb = esn_msb;
 
 	if (unlikely(overlap && seq_bottom < MLX5E_IPSEC_ESN_SCOPE_MID)) {
-- 
2.41.0


