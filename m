Return-Path: <netdev+bounces-49871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 776D37F3B72
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 02:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 077B0B21AEF
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 01:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845206FDA;
	Wed, 22 Nov 2023 01:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHRdAzKC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C0F6AA2
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 01:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E129FC433C8;
	Wed, 22 Nov 2023 01:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700617688;
	bh=IT2vX80/gp3iRlX+W4TzHSR0qEkruaQ5h2CdsCTHXHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nHRdAzKCcTw4F7Ci0s1531RVwXZb+9JIaDzHW9dVhtlp7GeSETSruYGdOe3u9LBKY
	 qdgjnM7rrp/s6G97Rfij0z+Oe25iUqyf/BDGR1/T5AqS+uAxwTWFc7FFK6S0Tr5JoR
	 rbQbtfaD6q1nFtXT4348Nsp3FqTdfp24FW/uQklwZlZIMFxqVJWI56n5XAIcKqBKLz
	 n7ASSWqd5pGYs69RFoyZqMI/gzo14E56aigexceTq0bkh5EwxjwV8BNUu9xyae8zJr
	 Zs698ZbySuNJvHN4LNHtF0x8/zWhB121uiMaQ4mPGMkSbNEtyob3Yr5l0Y5yKoquKc
	 kteENN7LsCGEQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net 02/15] net/mlx5e: Ensure that IPsec sequence packet number starts from 1
Date: Tue, 21 Nov 2023 17:47:51 -0800
Message-ID: <20231122014804.27716-3-saeed@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122014804.27716-1-saeed@kernel.org>
References: <20231122014804.27716-1-saeed@kernel.org>
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
index 4028932d93ce..914b9e6eb7db 100644
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
2.42.0


