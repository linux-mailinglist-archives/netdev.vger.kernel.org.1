Return-Path: <netdev+bounces-129850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E54BB986789
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 22:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F292284660
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 20:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FE51534EC;
	Wed, 25 Sep 2024 20:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIHKIe5c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8FE14F9FD
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 20:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727295622; cv=none; b=tJ3LKtl90TASDtFJrIFeU8mEGTTIbV9rAiHer5Na5mAAzksWpP/UitTgEPlgd9rwTuROVxVsEO8gsGuc3SrY5ZOPky0kyETkHaC4dqzTSK0vxUTbtEExANqH6eBqnsSi4H1LNzKU0Gncg8os+ImUJKZIaqNzPa0a0jDkw2cVN4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727295622; c=relaxed/simple;
	bh=F6JInSZ1B3JBx2nLMqz1WtCE2ayxMuc0K4E/bM7+xH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XoiK68Gbutvjy5ZRGTyxZNyOkm4w4bOsGCQrXkwSbYPWTdVnylnD1n+9QetIoc2wvzrX3zok6yGu+rkl2KBBoLl3flyZiNebzTS106arfNguw8qidVaXaFlbKNSCp1EdCTF3OzMP/AmclMkkdCcn7/IvpCifWnatLgn9pr+4n1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIHKIe5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DEFC4CEC3;
	Wed, 25 Sep 2024 20:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727295622;
	bh=F6JInSZ1B3JBx2nLMqz1WtCE2ayxMuc0K4E/bM7+xH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SIHKIe5cpkIdlucNaZy6wi/qMlhFw8anczlJ/VTFQWD+Y+NC8dMcoIBIlCSRC3LWM
	 YwWPl7BuwPS73YI4eorfyNsf76sDGvR6QykEVheXNmJMNRyPR09v8lS8qEn9ihFzg+
	 ftLRtGM+Lr3Dl1DTqShBk7KR4sPUvFm9aARaOwXcNZKlkpwmrEFOsGXP/K/gWzvlcL
	 orpkxxp0aLBUhR80ecbSa230AniiJ7J9m4fSAhvuqX7lzEcqSkcfx9DuvVgTgLtfIc
	 UC1+K8bI+AHE4x7eTb/HVDKUcYXqxmF7X8byrgnK1ptv4EB56Gt/ol0uxoE6ct98x8
	 eIfBreKXwjaOg==
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
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [net 5/8] net/mlx5: HWS, fixed double-free in error flow of creating SQ
Date: Wed, 25 Sep 2024 13:20:10 -0700
Message-ID: <20240925202013.45374-6-saeed@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240925202013.45374-1-saeed@kernel.org>
References: <20240925202013.45374-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

When SQ creation fails, call the appropriate mlx5_core destroy function.

This fixes the following smatch warnings:
  divers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c:739
    hws_send_ring_open_sq() warn: 'sq->dep_wqe' double freed
    hws_send_ring_open_sq() warn: 'sq->wq_ctrl.buf.frags' double freed
    hws_send_ring_open_sq() warn: 'sq->wr_priv' double freed

Fixes: 2ca62599aa0b ("net/mlx5: HWS, added send engine and context handling")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/e4ebc227-4b25-49bf-9e4c-14b7ea5c6a07@stanley.mountain/
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/mlx5hws_send.c        | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c
index a1adbb48735c..0c7989184c30 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c
@@ -653,6 +653,12 @@ static int hws_send_ring_create_sq(struct mlx5_core_dev *mdev, u32 pdn,
 	return err;
 }
 
+static void hws_send_ring_destroy_sq(struct mlx5_core_dev *mdev,
+				     struct mlx5hws_send_ring_sq *sq)
+{
+	mlx5_core_destroy_sq(mdev, sq->sqn);
+}
+
 static int hws_send_ring_set_sq_rdy(struct mlx5_core_dev *mdev, u32 sqn)
 {
 	void *in, *sqc;
@@ -696,7 +702,7 @@ static int hws_send_ring_create_sq_rdy(struct mlx5_core_dev *mdev, u32 pdn,
 
 	err = hws_send_ring_set_sq_rdy(mdev, sq->sqn);
 	if (err)
-		hws_send_ring_close_sq(sq);
+		hws_send_ring_destroy_sq(mdev, sq);
 
 	return err;
 }
-- 
2.46.1


