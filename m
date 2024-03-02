Return-Path: <netdev+bounces-76788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D8C86EF05
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 08:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2819D1C2164D
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 07:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B860D11C88;
	Sat,  2 Mar 2024 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sb/D3QiV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933A3125BF
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709363010; cv=none; b=u8xGkOhZyZVIFzfnJzHouvfpNHONPdcOflYxW/I57mvy1dfIfm60zOferjACH9/xUwSfgeqTlMSGr9uDWcqzBrUqAZQHO2FkmAKgOutWO6BUlkS/ufmpg8gitFjxZFi7ix1MMD4EfU1Xg7bCvp1ouxIN64VSTiX6s1YnojieZVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709363010; c=relaxed/simple;
	bh=WhVPWAd6p6F3Iylzr4WUeY2Hrg+7aP6qB2ytDCgvv3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OFkDfMCFIS/B3nRjl7/zgSupUrYhYPRXAU/lUPbKq6+OEB2vMq2qq11UFhcMajA0Vw/a9BvJiOh+i3wFWSAakoaIMzAG6yBbpqLGly+fDuYBj9EjMnTQFjgFNt4w7A3ty74TvGBUHAM56cQmNb3/1eaIVfTh70u3/QwZAHCbztc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sb/D3QiV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12FDC43399;
	Sat,  2 Mar 2024 07:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709363010;
	bh=WhVPWAd6p6F3Iylzr4WUeY2Hrg+7aP6qB2ytDCgvv3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sb/D3QiVgRnSXc9khx4L2kIjEjR1e5Ts8EQfA+w5Xhm0iwhEkTd92rmqJMJYEFrIW
	 IzqSfPJX3tJxt5v//Egdz26GWTV1n+DfxoeSbLR7EE/V32vbDU3cxZkRxTdbXIswFK
	 owD8eBaGA9vzca+1a6W64NOGRZ1Cnzx4Kl9b+YNo1Y3H7/D3WZ3jxxrTQShuBvZRAh
	 tmxkcOlhEwOKdftVPIZYNQakIqsXUBsylCh5GdaTJ9VgAnKlWwek2juiuetSi0PqLA
	 wIkN36j2tycBk7K0aN0nDVDocTe2nVQD9TE2le1hQQV1EZq33lcA8vYFN7KOKPrY8a
	 ywHCSP1qOS10g==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net V2 2/9] Revert "net/mlx5e: Check the number of elements before walk TC rhashtable"
Date: Fri,  1 Mar 2024 23:03:11 -0800
Message-ID: <20240302070318.62997-3-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240302070318.62997-1-saeed@kernel.org>
References: <20240302070318.62997-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

This reverts commit 4e25b661f484df54b6751b65f9ea2434a3b67539.

This Commit was mistakenly applied by pulling the wrong tag, remove it.

Fixes: 4e25b661f484 ("net/mlx5e: Check the number of elements before walk TC rhashtable")
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
index 190f10aba170..5a0047bdcb51 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
@@ -152,7 +152,7 @@ void mlx5_esw_ipsec_restore_dest_uplink(struct mlx5_core_dev *mdev)
 
 	xa_for_each(&esw->offloads.vport_reps, i, rep) {
 		rpriv = rep->rep_data[REP_ETH].priv;
-		if (!rpriv || !rpriv->netdev || !atomic_read(&rpriv->tc_ht.nelems))
+		if (!rpriv || !rpriv->netdev)
 			continue;
 
 		rhashtable_walk_enter(&rpriv->tc_ht, &iter);
-- 
2.44.0


