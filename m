Return-Path: <netdev+bounces-25075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D46772D6F
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 20:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF592814F6
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 18:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23885168DD;
	Mon,  7 Aug 2023 17:57:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04D9168B9
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 17:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3CFC433AB;
	Mon,  7 Aug 2023 17:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691431028;
	bh=0IWzg5sGueAQDBVc7t2qioz+nFYUUoouL+yZo53q1oQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EV5xKxZdVECj6HtNV+d/Ak8Rc3FtgqcRtaXeRegHxGA9lq6rSRcy2T4G5nJvR4MxC
	 z2pC81tPVWp6n30IxFmMdNCu2dJhZJ2Zjg5eVGdmrDFehoB4OUgXyC7twb0UDoASBu
	 HKATtK3/2rkisYmZuy8VP0tFu7DITdwCQgwgRqPwKi89YziTRq2ox29PTtYroEyhli
	 oK7LNpmM9jw9+uuH4FZMxV5tA3/XmWrOvho9hlbsTU+SRPfbOR42EP+GofIqTrGTAD
	 prU6sGAHcOk29ocn7nqwwDHkLhgc+T4RAxfoJKqdQXpR3yjRB/0TWJTCVwTS96XBhZ
	 l9jaTDCqMt//Q==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Roi Dayan <roid@nvidia.com>,
	Vlad Buslov <vladbu@nvidia.com>
Subject: [net-next 15/15] net/mlx5: Bridge, Only handle registered netdev bridge events
Date: Mon,  7 Aug 2023 10:56:42 -0700
Message-ID: <20230807175642.20834-16-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807175642.20834-1-saeed@kernel.org>
References: <20230807175642.20834-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Roi Dayan <roid@nvidia.com>

Don't handle bridge events for a netdev that doesn't belong to
an eswitch that registered for bridge events.

Signed-off-by: Roi Dayan <roid@nvidia.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
index 560800246573..0fef853eab62 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
@@ -77,6 +77,10 @@ mlx5_esw_bridge_rep_vport_num_vhca_id_get(struct net_device *dev, struct mlx5_es
 		return NULL;
 
 	priv = netdev_priv(dev);
+
+	if (!priv->mdev->priv.eswitch->br_offloads)
+		return NULL;
+
 	rpriv = priv->ppriv;
 	*vport_num = rpriv->rep->vport;
 	*esw_owner_vhca_id = MLX5_CAP_GEN(priv->mdev, vhca_id);
-- 
2.41.0


