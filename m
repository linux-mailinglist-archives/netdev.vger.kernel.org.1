Return-Path: <netdev+bounces-165263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF68A314EC
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 20:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5613A8057
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D522D2638B8;
	Tue, 11 Feb 2025 19:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwrarNwu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00F42638B1
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 19:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301716; cv=none; b=C24JpUMOWgoARbnutP5Ae3hHsVWezi1sv71bYjqcOXoTvjzFYk0qOfxtWomWu1/WSiLIRUI1jPw7dmuD9x7JT+Eu1oFVD1j7KSjigfiVAUwj/RXS0KhLhMaZeWkTaHn3Vvw5tO8nyILbAmj2dji2yXUh1FHAQeqK4X5bs4AdFvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301716; c=relaxed/simple;
	bh=BnfEtkuSRakxY27SXHJr8MvG2/eU/7W7dexHODJa/pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUv6nar7FEqBElHrK0WBPXLfxbCzYQ7vTGjktenu88PfKL6Yvox93utFZsiwphBMUl9ERZ2fv+b0G2Qbw49iGeLf6IpHd8O+n+b/j681pyFdYzBelPa2njCvCqVTAfIWUDNBWganJ3weL5QyL4Qg2zjCusK90cKE/xrT85BWDOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwrarNwu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A6CC4CEDD;
	Tue, 11 Feb 2025 19:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739301716;
	bh=BnfEtkuSRakxY27SXHJr8MvG2/eU/7W7dexHODJa/pQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kwrarNwugPMucOHuesHxcq2d6z4h6cmHwJ8cxo6knjde3xWI3Y08c/mYBe4F903Do
	 N1gr+eo+pn6Xu++i4v8YPbj1ZGbjRISLneHzyz0ee9ewZZIfQefvU65mcwbgfUKnwX
	 Mccun0DXTfEc9xxngB2PAsivkwgEZCdrqneh+nJNEsHp0aXBjHEQviS3t3jVxt80RE
	 AJExDZyGDFU3L8yorLfQZonii8pXPUEoDm2EGoK8tBjUgpQ0fqvpMgUCQ/yLZL41N5
	 xdY2n2gVKEw0m53dDeCgMIssafJiEqMho+zJxLoe0OwNoiIuwEtmUrp9dIY9h/qnZa
	 xRNtwCS5LtQog==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: tariqt@nvidia.com,
	idosch@idosch.org,
	hawk@kernel.org,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/4] eth: mlx4: don't try to complete XDP frames in netpoll
Date: Tue, 11 Feb 2025 11:21:39 -0800
Message-ID: <20250211192141.619024-3-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250211192141.619024-1-kuba@kernel.org>
References: <20250211192141.619024-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mlx4 doesn't support ndo_xdp_xmit / XDP_REDIRECT and wasn't
using page pool until now, so it could run XDP completions
in netpoll (NAPI budget == 0) just fine. Page pool has calling
context requirements, make sure we don't try to call it from
what is potentially HW IRQ context.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - clarify the commit msg
v1: https://lore.kernel.org/20250205031213.358973-3-kuba@kernel.org
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


