Return-Path: <netdev+bounces-65369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED11483A3F9
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8737DB22911
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 08:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A504D1756D;
	Wed, 24 Jan 2024 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elJy/oGu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819691799D
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084362; cv=none; b=EzbnfxNJ347iAL9Cuwk3xZGUQ7Jz3Bl2kOVsPHArOAxuZoZqT9cstXVMTBH0KGalWg9GemYDpBNmO81v8OR2loI0n5IOEMCsRXI/fhR7d9MdjS3o6jOfO5Ia52/kP1aBQrDEIS9QwZ2U7j6YJBUpJXT/5yX50J5A/ycmOsARbMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084362; c=relaxed/simple;
	bh=5BTi/enT1c9MzHbKr6JKJezJ41Dytznawp2dH9GFPr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVZmfIMgqzs6DUFeImCwf9npXGkuUxITsi1zk/GuroKJDaFlMWEqoTD6JqDRmE9M9dNnJoCZJ5zaLL/au4hzw4LM5IKo24qWBj2n3vo6ksAG93/pP83dstEcsoeKVlUtBzrazBTiuEUa/i/L6V4Dtns+bkUQAvH/wqhh7SS5GZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elJy/oGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C89C433F1;
	Wed, 24 Jan 2024 08:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706084362;
	bh=5BTi/enT1c9MzHbKr6JKJezJ41Dytznawp2dH9GFPr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=elJy/oGu6Hk6C7cxwtytsbK+AJhj8p3w3Cd6X4F85H6JmHbwExv5T9Os0UMW+MzyP
	 SHYNrA5fY7pmtZbzMs+EoMfj51sWLDH+HPyeFVztYcwm6JmUeai0DyINVZsG73MwK2
	 PlhJmTMKDjal25k9eFIdIf8BGhiOqvN/8CTf4FW7orqkTZ1Gt/spspf44El9EYav2o
	 NkmarvdS1fVoyPpc8lLhAC5XMMh6jQwjavF/ZpBcEbU1j6wz4gSkcseJavmLwA19fF
	 NNu8frO1urbQfKXCmS94bTogxR5AQmvCHQ44+FMCWrGB1t2ALzUaVsUUMsGqwYyc/Z
	 QCh4zIL1wmW9w==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Aya Levin <ayal@nvidia.com>
Subject: [net 12/14] net/mlx5e: Ignore IPsec replay window values on sender side
Date: Wed, 24 Jan 2024 00:18:53 -0800
Message-ID: <20240124081855.115410-13-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124081855.115410-1-saeed@kernel.org>
References: <20240124081855.115410-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

XFRM stack doesn't prevent from users to configure replay window
in TX side and strongswan sets replay_window to be 1. It causes
to failures in validation logic when trying to offload the SA.

Replay window is not relevant in TX side and should be ignored.

Fixes: cded6d80129b ("net/mlx5e: Store replay window in XFRM attributes")
Signed-off-by: Aya Levin <ayal@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c   | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 161c5190c236..05612d9c6080 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -336,12 +336,17 @@ void mlx5e_ipsec_build_accel_xfrm_attrs(struct mlx5e_ipsec_sa_entry *sa_entry,
 	/* iv len */
 	aes_gcm->icv_len = x->aead->alg_icv_len;
 
+	attrs->dir = x->xso.dir;
+
 	/* esn */
 	if (x->props.flags & XFRM_STATE_ESN) {
 		attrs->replay_esn.trigger = true;
 		attrs->replay_esn.esn = sa_entry->esn_state.esn;
 		attrs->replay_esn.esn_msb = sa_entry->esn_state.esn_msb;
 		attrs->replay_esn.overlap = sa_entry->esn_state.overlap;
+		if (attrs->dir == XFRM_DEV_OFFLOAD_OUT)
+			goto skip_replay_window;
+
 		switch (x->replay_esn->replay_window) {
 		case 32:
 			attrs->replay_esn.replay_window =
@@ -365,7 +370,7 @@ void mlx5e_ipsec_build_accel_xfrm_attrs(struct mlx5e_ipsec_sa_entry *sa_entry,
 		}
 	}
 
-	attrs->dir = x->xso.dir;
+skip_replay_window:
 	/* spi */
 	attrs->spi = be32_to_cpu(x->id.spi);
 
@@ -501,7 +506,8 @@ static int mlx5e_xfrm_validate_state(struct mlx5_core_dev *mdev,
 			return -EINVAL;
 		}
 
-		if (x->replay_esn && x->replay_esn->replay_window != 32 &&
+		if (x->replay_esn && x->xso.dir == XFRM_DEV_OFFLOAD_IN &&
+		    x->replay_esn->replay_window != 32 &&
 		    x->replay_esn->replay_window != 64 &&
 		    x->replay_esn->replay_window != 128 &&
 		    x->replay_esn->replay_window != 256) {
-- 
2.43.0


