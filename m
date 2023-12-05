Return-Path: <netdev+bounces-54134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDD28060F6
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 22:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C491C2107E
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 21:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F88D6E2D3;
	Tue,  5 Dec 2023 21:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MW9Nwb9G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70906E2D0
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 21:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B964C433C8;
	Tue,  5 Dec 2023 21:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701812739;
	bh=7/sTvgDxLgRMxCxbEeYUyoa0gwAX2prZmNZwwAHtDBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MW9Nwb9GktI1kNfow+qUX7QugjZh88OIEzz66dm+uoM24iQvzZS50EtJxt3OOiTJ5
	 gHCBfXSK8pIpakuZ1FvtTZmcEEERmUQzYRFSwM89X4H4+zh1GFanmFlTuWxIvxOlBG
	 dNuvfAcF9H8xjU/PaNb+s2K7itUWY01RpkCRdd2rlNT072mAuznjDKVryxbyM5+ThD
	 DWgNRaZuVDMfjbRVKsI3In430LpxJK6Yr0O3GxWRJ9Go/uOpe/4/z6cSNyYIxhoT64
	 0fyHg4lMfLCDHz+/LMysINB+LQ9ts7IMGBvS+eJpn0ktfWI8ZHRCoI0PLJ3t9eNHe0
	 YvBQHL+8miAvQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net V3 02/15] net/mlx5e: Ensure that IPsec sequence packet number starts from 1
Date: Tue,  5 Dec 2023 13:45:21 -0800
Message-ID: <20231205214534.77771-3-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205214534.77771-1-saeed@kernel.org>
References: <20231205214534.77771-1-saeed@kernel.org>
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
2.43.0


