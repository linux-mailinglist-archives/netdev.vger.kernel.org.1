Return-Path: <netdev+bounces-47458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C7B7EA541
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 22:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3DE1F22F74
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 21:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EEDB3D3A6;
	Mon, 13 Nov 2023 21:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQFU7/XO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A363D3A4
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 21:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A678BC433C8;
	Mon, 13 Nov 2023 21:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699909722;
	bh=ZoV45BynYt/XbKrhLaYV/LKpiIYH7uL7rWHPz8tsCmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dQFU7/XOn6/qULnmpRBPWHiuZrtCvj8VKc1oMRCRV/OSSIuSmM+a5Dk+Ps9WYMBGQ
	 jNQ0+7e6E/P26JSvIyyqfA6wo5OSdRIc1zM84FOfigMiKjFLxveR6aHd/U+RUv7qNJ
	 QrtrcNrONbnS63J/yysgGZuqaFsIiia5Hl/rH/EsyZyioSGmHX2IzQJ/d7R31el4lm
	 z4erAa92veNVpi730mb+flwTfKSZP3ELGCUHG+Kvyyn3w69tBba4S7BXowNk0Lwpyf
	 lyemoFQeGdDEZ25RxNXp3kseEEcNbp0Por2+UX4stnlncp6FJXrxQrfpQlvUPvboQd
	 Re9PIa6fVA6fQ==
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
Subject: [net 13/17] net/mlx5: Fix a NULL vs IS_ERR() check
Date: Mon, 13 Nov 2023 13:08:22 -0800
Message-ID: <20231113210826.47593-14-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113210826.47593-1-saeed@kernel.org>
References: <20231113210826.47593-1-saeed@kernel.org>
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
index 693e55b010d9..5c569d4bfd00 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -1493,7 +1493,7 @@ mlx5e_vport_vf_rep_load(struct mlx5_core_dev *dev, struct mlx5_eswitch_rep *rep)
 
 	dl_port = mlx5_esw_offloads_devlink_port(dev->priv.eswitch,
 						 rpriv->rep->vport);
-	if (dl_port) {
+	if (!IS_ERR(dl_port)) {
 		SET_NETDEV_DEVLINK_PORT(netdev, dl_port);
 		mlx5e_rep_vnic_reporter_create(priv, dl_port);
 	}
-- 
2.41.0


