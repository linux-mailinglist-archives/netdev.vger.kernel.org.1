Return-Path: <netdev+bounces-159070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03206A1444C
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 22:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1A2F7A3FB8
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 21:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502F5243851;
	Thu, 16 Jan 2025 21:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9D29Bhh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD7B242249
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 21:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737064559; cv=none; b=IgVMdaT3lko6/1id37W3TZJ/poYtU5wyJeGVLPePmLs4XjsRSdspo7SJrOvmBGA08Dmlprt6d+LuwhLjUiE2qkZPRBx9U8kstPMeVvmuAmfwoLb7V5jkUWyAV2cfFM1yu7hJYiRk9PbwzwhLEMJLgHsYB3fx60lLtOe1xp32+cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737064559; c=relaxed/simple;
	bh=U9Eg32W0x0Xs3/Ve5JUm9F3l5xsUwt8Qz2Yn2wvgE3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZNGN313R7sZbzBwqr75ltt91Rt2LhW0NuDmBK7/HTCH/cEQ/deCbWi/LTMzC6kFwqq3DaHYarPy0XbzfP/2eFN9/4rqbZ6CekmKCZBH3vCK0BFkGZnc35o8HVtHG/Gu8ehB6MixePKycPt70+C7EEIc50AeoctTkVDfS1P2v74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9D29Bhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3912C4CEDF;
	Thu, 16 Jan 2025 21:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737064559;
	bh=U9Eg32W0x0Xs3/Ve5JUm9F3l5xsUwt8Qz2Yn2wvgE3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B9D29BhhmEny6gwkrFsBNf0/zP0oSU5N4CI6EXTdgbTJ4rjeC/nsw03s8VzgcOqHK
	 +WDZ8ieaZ1GyQyZceDBpNfd2EF/7aNleAzAbdvXI7mmXAtUbCXVtEXIdTMRT9Gq6sl
	 K/ad/1mMAD/lXW3F/QLUMr/LW1LCWkttiSAtXbVBUI1KKN1WQmaHC/2qGXQQcbnARa
	 c7eJMqSmzwHtvK82/z5FbvDtbsvGTNOR2EvnHn/4spCE5BGDFvNTF1UABzr7oT45C6
	 6wEyfvsPU9cuJfTginWe4FEgKQSr/T1+19sbjP/U+f2ZksW5Y+/Rn4d/03lSqkUB+g
	 WNttOBny0AXNg==
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
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: [net-next 09/11] net/mlx5e: Add support for UNREADABLE netmem page pools
Date: Thu, 16 Jan 2025 13:55:27 -0800
Message-ID: <20250116215530.158886-10-saeed@kernel.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250116215530.158886-1-saeed@kernel.org>
References: <20250116215530.158886-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

On netdev_rx_queue_restart, a special type of page pool maybe expected.

In this patch declare support for UNREADABLE netmem iov pages in the
pool params only when header data split shampo RQ mode is enabled, also
set the queue index in the page pool params struct.

Shampo mode requirement: Without header split rx needs to peek at the data,
we can't do UNREADABLE_NETMEM.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 02c9737868b3..340ed7d3feac 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -946,6 +946,11 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		pp_params.netdev    = rq->netdev;
 		pp_params.dma_dir   = rq->buff.map_dir;
 		pp_params.max_len   = PAGE_SIZE;
+		pp_params.queue_idx = rq->ix;
+
+		/* Shampo header data split rx path allow for unreadable netmem */
+		if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
+			pp_params.flags |= PP_FLAG_ALLOW_UNREADABLE_NETMEM;
 
 		/* page_pool can be used even when there is no rq->xdp_prog,
 		 * given page_pool does not handle DMA mapping there is no
-- 
2.48.0


