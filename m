Return-Path: <netdev+bounces-25158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA3B773136
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 23:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99FE5280D8E
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 21:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D6D17AA1;
	Mon,  7 Aug 2023 21:26:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C7717ACD
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 21:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD203C433AD;
	Mon,  7 Aug 2023 21:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691443580;
	bh=KrNI5sUEhaoGt/E6eatfL2s3yGifedgJLMbQ9JEv45Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XrYkQIOdw0ztE4T5Xmc82EukJrwz4LfzStChhkdewo1lOOCvVlhJfWNMwmsA5BL+T
	 s8NV4I7GMNbwbjTPH3dHYxaCZnQjBHUlLb7ilrQcFrW8IaQjyD4fQzXHh3Rd11n/tP
	 7LvPo+DY6cdKmKaDGMO+4Il3j10nFa86t+gZJfhGHAxV3SYpYH5ZieA6m49DG6bSWv
	 U+BBvpfDf+Qtj9k2X1+5G1hkidcBGuptAyqTccAM0JZumHa5YCee9kEGbWnOeYJwO2
	 6idn74zkM7FUSVzjCCrrmFfVAdAyroDvdMZRvcv+4m+eTwFEwnvXA1gASjgZ9M/TUy
	 8qBghhYRENdag==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Daniel Jurgens <danielj@nvidia.com>
Subject: [net 06/11] net/mlx5: Fix devlink controller number for ECVF
Date: Mon,  7 Aug 2023 14:26:02 -0700
Message-ID: <20230807212607.50883-7-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807212607.50883-1-saeed@kernel.org>
References: <20230807212607.50883-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Jurgens <danielj@nvidia.com>

The controller number for ECVFs is always 0, because the ECPF must be
the eswitch owner for EC VFs to be enabled.

Fixes: dc13180824b7 ("net/mlx5: Enable devlink port for embedded cpu VF vports")
Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index af779c700278..fdf2be548e85 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -60,7 +60,7 @@ static struct devlink_port *mlx5_esw_dl_port_alloc(struct mlx5_eswitch *esw, u16
 	}  else if (mlx5_core_is_ec_vf_vport(esw->dev, vport_num)) {
 		memcpy(dl_port->attrs.switch_id.id, ppid.id, ppid.id_len);
 		dl_port->attrs.switch_id.id_len = ppid.id_len;
-		devlink_port_attrs_pci_vf_set(dl_port, controller_num, pfnum,
+		devlink_port_attrs_pci_vf_set(dl_port, 0, pfnum,
 					      vport_num - 1, false);
 	}
 	return dl_port;
-- 
2.41.0


