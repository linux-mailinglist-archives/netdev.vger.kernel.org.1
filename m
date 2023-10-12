Return-Path: <netdev+bounces-40475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCE77C7769
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E496E282C7C
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 19:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBD13D968;
	Thu, 12 Oct 2023 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6aBdPRs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E71E3D39B
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 19:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7C5C43395;
	Thu, 12 Oct 2023 19:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697140396;
	bh=6w+Qbp5FDzsN/+MdzSKHSBt3HZjqhvGNZ9eMDp8xgqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q6aBdPRsxOipPdXkr/e/3nAQ+Ff8HTA2L060xatp1QM2gIoocQmLjATmS1J9GHsSF
	 U0NRGXAd1SITMDclHIQcg3EFYLmWslJ37cbcVD3UW508HPjQ4kEuN49NOOHCTRDKot
	 FD/lf8dpHGUgdXWDmItXUwCflycfIH4EMiYUTzLyRiDvkgoNN4r5e4g1M/mJ/oX3tX
	 jNVnJ3ajibDmyEj1vLeyqBPUYF18oOWRN8avssoGpI2D7hk18BXtWm3GYT3IwVHgHH
	 rSlrJP1GoJM6Vp0eiKF4NrLKSAFIAxM4l49eOfVsmTe6CUaVTdr+t0bNZcQMfGSGE4
	 3eB9i572Ftt/g==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Ariel Levkovich <lariel@nvidia.com>
Subject: [net 09/10] net/mlx5e: Don't offload internal port if filter device is out device
Date: Thu, 12 Oct 2023 12:51:26 -0700
Message-ID: <20231012195127.129585-10-saeed@kernel.org>
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

From: Jianbo Liu <jianbol@nvidia.com>

In the cited commit, if the routing device is ovs internal port, the
out device is set to uplink, and packets go out after encapsulation.

If filter device is uplink, it can trigger the following syndrome:
mlx5_core 0000:08:00.0: mlx5_cmd_out_err:803:(pid 3966): SET_FLOW_TABLE_ENTRY(0x936) op_mod(0x0) failed, status bad parameter(0x3), syndrome (0xcdb051), err(-22)

Fix this issue by not offloading internal port if filter device is out
device. In this case, packets are not forwarded to the root table to
be processed, the termination table is used instead to forward them
from uplink to uplink.

Fixes: 100ad4e2d758 ("net/mlx5e: Offload internal port as encap route device")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Ariel Levkovich <lariel@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
index 1730f6a716ee..b10e40e1a9c1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
@@ -24,7 +24,8 @@ static int mlx5e_set_int_port_tunnel(struct mlx5e_priv *priv,
 
 	route_dev = dev_get_by_index(dev_net(e->out_dev), e->route_dev_ifindex);
 
-	if (!route_dev || !netif_is_ovs_master(route_dev))
+	if (!route_dev || !netif_is_ovs_master(route_dev) ||
+	    attr->parse_attr->filter_dev == e->out_dev)
 		goto out;
 
 	err = mlx5e_set_fwd_to_int_port_actions(priv, attr, e->route_dev_ifindex,
-- 
2.41.0


