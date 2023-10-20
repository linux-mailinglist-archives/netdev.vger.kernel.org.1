Return-Path: <netdev+bounces-42855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBCD7D06B4
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 05:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755541C20F4F
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 03:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3BD3FF1;
	Fri, 20 Oct 2023 03:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAzsY3d5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6397818
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 03:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E40C433C8;
	Fri, 20 Oct 2023 03:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697771076;
	bh=JNzS6pagBwYkpuu4vbAl2omHExKhBibQX9iJVsxwvTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MAzsY3d58tqya6K9E2DFMusG8FCxMuqqOyJO7Qrqe59CzLEYCf6X54bBnVJvsvwRJ
	 QBkcZs8Msxj1c0U7TpWGVOHAWO1XcDaQ1FwZSej1IjT3qKHNvauQYuWz6BvgVuy7aX
	 gDLMxO28qbaQ+x3ceN5rvYYPd46etUS1CNN9jl9KFsErpM8rSvcGQz9Zi1rbeSK7eF
	 9XVQNMFLCR/QVI9Sp6KSNGb04qS1f15XT/PAI2mT/FkvEVnZvmYlWZK7ZApy7shT3o
	 +LKxePdUy10CU6qE2yQjoUBCiMSVl0vPvlsRfvqK6iSsTiP4kNCJBO1GOrgETj01Zi
	 /Vic55B9ZIPsg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net-next 04/15] net/mlx5e: Ensure that IPsec sequence packet number starts from 1
Date: Thu, 19 Oct 2023 20:04:11 -0700
Message-ID: <20231020030422.67049-5-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020030422.67049-1-saeed@kernel.org>
References: <20231020030422.67049-1-saeed@kernel.org>
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


