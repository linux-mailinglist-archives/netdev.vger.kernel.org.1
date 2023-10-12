Return-Path: <netdev+bounces-40473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD0E7C7767
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B16282ECF
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 19:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFC23D3A7;
	Thu, 12 Oct 2023 19:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pG+C0k1P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2723D39B
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 19:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EA1C433C8;
	Thu, 12 Oct 2023 19:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697140394;
	bh=msJAgf4+1mit8aMTSdB9VWe6D/lfDhb4lvAheCxJPM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pG+C0k1PD8+GSapaAMjMP05ByQmHE5O6mtX05/phOU67CdLwn0W+3q1/1h9rjOdBf
	 yL4nKdbsl6CUZjMKypsfGumUMo1WUi/pGBEozEBT00SIONE3PIO+49i8XptGdIvzUF
	 Ze9dtoMw19PXIPcJgZrbVBIhFI7lFV9L2JTfk/UckE872FdEBcEyv+JRIX3Iqz5TD+
	 W9QQNu5hMiA2W+944ojNp4vMc1IA8Oo9AHs5srvkBbjN30QG5weXmL0nCMts0Mfz8v
	 0jkbNY5f0+kNdbQtVL/PAXWChihp93ncNceFQ0hyfMqAvIl9oVB5zAB0eUc2omXUVa
	 i8OhoyQ9hPG7Q==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: [net 07/10] net/mlx5e: XDP, Fix XDP_REDIRECT mpwqe page fragment leaks on shutdown
Date: Thu, 12 Oct 2023 12:51:24 -0700
Message-ID: <20231012195127.129585-8-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231012195127.129585-1-saeed@kernel.org>
References: <20231012195127.129585-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dragos Tatulea <dtatulea@nvidia.com>

When mlx5e_xdp_xmit is called without the XDP_XMIT_FLUSH set it is
possible that it leaves a mpwqe session open. That is ok during runtime:
the session will be closed on the next call to mlx5e_xdp_xmit. But
having a mpwqe session still open at XDP sq close time is problematic:
the pc counter is not updated before flushing the contents of the
xdpi_fifo. This results in leaking page fragments.

The fix is to always close the mpwqe session at the end of
mlx5e_xdp_xmit, regardless of the XDP_XMIT_FLUSH flag being set or not.

Fixes: 5e0d2eef771e ("net/mlx5e: XDP, Support Enhanced Multi-Packet TX WQE")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 12f56d0db0af..8bed17d8fe56 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -874,11 +874,11 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 	}
 
 out:
-	if (flags & XDP_XMIT_FLUSH) {
-		if (sq->mpwqe.wqe)
-			mlx5e_xdp_mpwqe_complete(sq);
+	if (sq->mpwqe.wqe)
+		mlx5e_xdp_mpwqe_complete(sq);
+
+	if (flags & XDP_XMIT_FLUSH)
 		mlx5e_xmit_xdp_doorbell(sq);
-	}
 
 	return nxmit;
 }
-- 
2.41.0


