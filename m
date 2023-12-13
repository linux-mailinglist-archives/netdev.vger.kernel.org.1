Return-Path: <netdev+bounces-54145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 943E8806101
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 22:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D56A1F2170E
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 21:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5C36F63B;
	Tue,  5 Dec 2023 21:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfFgimlH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7E46E2B3
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 21:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20268C433C7;
	Tue,  5 Dec 2023 21:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701812749;
	bh=0olGoP/DDNOnO9J0W8cswJ78sOoZ6xFirua5/QysDXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RfFgimlHgefZluenWagXTvUqX8ekZoAPFuVg9Ub3HvSGB0Bv9syG3Oo0z3mvtck/s
	 nYmyrBqs1Dq4hEuSQdIZkEa/QvJ6TS06zPbRa2e39ib7KQ66wFxWjjvvRZCQZ5reNZ
	 /qn6TEuC+bs5ZQINBRMOGzbT8lMPwrAj1RbdVnf2/79hTR2zRJWLY3m7fIkxtcnTAg
	 BX/2b6hqkt8dgYrmaAtYO4sLQTOGW0WteirFazuZjm/QY/iT1cfxFqkA6iRfMKJbC0
	 36rRMVAdtruuw9rdcUc1ng+MowQ7bIwP4+HlpO4DYrLxrqoGY3oA+pXnuGli9p4yPD
	 LoQlySmsyKiEA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [net V3 13/15] net/mlx5: Fix a NULL vs IS_ERR() check
Date: Tue,  5 Dec 2023 13:45:32 -0800
Message-ID: <20231205214534.77771-14-saeed@kernel.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

The mlx5_esw_offloads_devlink_port() function returns error pointers, not
NULL.

Fixes: 7bef147a6ab6 ("net/mlx5: Don't skip vport check")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 3ab682bbcf86..1bf7540a65ad 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -1497,7 +1497,7 @@ mlx5e_vport_vf_rep_load(struct mlx5_core_dev *dev, struct mlx5_eswitch_rep *rep)
 
 	dl_port = mlx5_esw_offloads_devlink_port(dev->priv.eswitch,
 						 rpriv->rep->vport);
-	if (dl_port) {
+	if (!IS_ERR(dl_port)) {
 		SET_NETDEV_DEVLINK_PORT(netdev, dl_port);
 		mlx5e_rep_vnic_reporter_create(priv, dl_port);
 	}
-- 
2.43.0


