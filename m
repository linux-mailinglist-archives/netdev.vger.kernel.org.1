Return-Path: <netdev+bounces-162851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF91A2826E
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 04:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D461881A1A
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 03:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CDD2135A2;
	Wed,  5 Feb 2025 03:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lArvJU9q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52679213258
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 03:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738725167; cv=none; b=kb4/hmNcmMV3q9ViDXv2ridnqHzWoLK3AARXJCxVdx9jiAfRavltcrCpmN0M1++Oa9XddVFoVvwDs4h50DiUF/5U2c5pKpd5bs1oJgpltMPQLUfBpzrPg8Dt+XQBXD8NIbTK1Tc/A89sTyHY+lD3N3OnzN0QXcnxKT/1cPfHFJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738725167; c=relaxed/simple;
	bh=R/h0DxOX/MuT9LoObDZtK+tS6CyeQglfavPnl9opZNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVwMXy0WOYU4kN2yNCLVN5rh+k/AWsFlKNo++VRp2+ktLRDp48H0PRS7XeOgEAc/7D8QvpEfIfE7O99BuM5LokZJM/r/QUIywvgJvSOEx1Xwz0nw1Gw3yim0qzHMb11n07cw4nIL6eFcMAvJEhkY7RpOnkA+RQM6tLGVAqzmmPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lArvJU9q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F1FC4CEE4;
	Wed,  5 Feb 2025 03:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738725166;
	bh=R/h0DxOX/MuT9LoObDZtK+tS6CyeQglfavPnl9opZNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lArvJU9qp8K01sAkEVD4O5BLQD5XJ61DTFzGSQDBCFwZrcsxusuffSufdwahSbAFw
	 7VMRLI+OWiIZiCplVttMILtA59znACXCGLCfe1HfmfIAyKYxcNEKypFSEKKJTIqJ8e
	 oenUfDQ8KN1laFORRFlYuUnrLqIi2QKMKALz/XJFS3mHr+NJvYEZLbsWYCz8iayiAo
	 3hSk2jAq2Ayebd8VJQF14D29Hj1rdWtXJALsIhasrWZyidQV7p4lqdtl7RNY4JeQpX
	 74ydlsKwF6LWXjeOJaJtCT9N7kq9ctgk+m5g5xTLhbfqKvA3V14ZUA5ruqS0mYtu5c
	 LVqWY1ZFocmhw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	tariqt@nvidia.com,
	hawk@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/4] eth: mlx4: don't try to complete XDP frames in netpoll
Date: Tue,  4 Feb 2025 19:12:11 -0800
Message-ID: <20250205031213.358973-3-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205031213.358973-1-kuba@kernel.org>
References: <20250205031213.358973-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mlx4 doesn't support xdp xmit and wasn't using page pool
until now, so it could run XDP completions in netpoll
(NAPI budget == 0) just fine. Page pool has calling
context requirements, make sure we don't try to call
it from what is potentially HW IRQ context.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_tx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_tx.c b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
index 1ddb11cb25f9..6e077d202827 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_tx.c
@@ -450,6 +450,8 @@ int mlx4_en_process_tx_cq(struct net_device *dev,
 
 	if (unlikely(!priv->port_up))
 		return 0;
+	if (unlikely(!napi_budget) && cq->type == TX_XDP)
+		return 0;
 
 	netdev_txq_bql_complete_prefetchw(ring->tx_queue);
 
-- 
2.48.1


