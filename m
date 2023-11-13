Return-Path: <netdev+bounces-47454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A6D7EA53C
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 22:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A1F1F22D99
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 21:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB51B3C088;
	Mon, 13 Nov 2023 21:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VL9WKbzp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914753C067
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 21:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABA8C433C9;
	Mon, 13 Nov 2023 21:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699909719;
	bh=sfqj7BDpKAcb64THPOF02zidFNtaJRrUUhus6LZjwfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VL9WKbzp/+x6ipEFEwE1M9LJ9uhfRXTgQUIoBFlrJN+jVsstHI5eKlTd2mb5dpAYI
	 Hrd+NijxmeiyT+uEUIuHUqJMynuGnVI3wB/7UMKjjzzEKqWoaMX167LwSiaIokfdF0
	 sDdC8DXQxJF2RM4tASD4G55FiJBRarSn8QgxHZT7ECiOXkvkR882SMr5AxBjPTPM4w
	 /dAI90rFCCZkpJZCox+5OXlzkbtJlnuQXNmJqE8InhX9zK2R9ikrm6ruMkGmTMb+N6
	 CLoLvnkF+KOWGjr9SDJO841GsFzltH6kN9yen8FSvp2Jk6pCYpc16qYmDfN0aaoQYX
	 xqszrK1Vs9bSA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Roi Dayan <roid@nvidia.com>
Subject: [net 09/17] net/mlx5e: Don't modify the peer sent-to-vport rules for IPSec offload
Date: Mon, 13 Nov 2023 13:08:18 -0800
Message-ID: <20231113210826.47593-10-saeed@kernel.org>
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

From: Jianbo Liu <jianbol@nvidia.com>

As IPSec packet offload in switchdev mode is not supported with LAG,
it's unnecessary to modify those sent-to-vport rules to the peer eswitch.

Fixes: c6c2bf5db4ea ("net/mlx5e: Support IPsec packet offload for TX in switchdev mode")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Roi Dayan <roid@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index b296ac52a439..88236e75fd90 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -984,7 +984,8 @@ mlx5_eswitch_add_send_to_vport_rule(struct mlx5_eswitch *on_esw,
 	dest.vport.flags |= MLX5_FLOW_DEST_VPORT_VHCA_ID;
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
 
-	if (rep->vport == MLX5_VPORT_UPLINK && on_esw->offloads.ft_ipsec_tx_pol) {
+	if (rep->vport == MLX5_VPORT_UPLINK &&
+	    on_esw == from_esw && on_esw->offloads.ft_ipsec_tx_pol) {
 		dest.ft = on_esw->offloads.ft_ipsec_tx_pol;
 		flow_act.flags = FLOW_ACT_IGNORE_FLOW_LEVEL;
 		dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
-- 
2.41.0


