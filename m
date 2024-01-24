Return-Path: <netdev+bounces-65366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB28F83A3F5
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C24DB22377
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 08:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40E017758;
	Wed, 24 Jan 2024 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSXKU5FZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911D917756
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084357; cv=none; b=XGiQoDvg0uuc6sNF7E8KCg54TH79BapwmsLgaaldhRl3dKeP7UwGiKnmuWzgn0U94a1oztRaipX163XSpPlImRAUSttLvpG+TmL3vxtWvYsuyWQapGlA8DvNnfQMZM/+tUcdkMHIuiJTvkNd59oBfMo0BwPE8K2Og/BCWJFd8+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084357; c=relaxed/simple;
	bh=1NWurbFv6ZN4umhSbEGGKqB6lISrm8744fUrroskShc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KunRGFtTRl2wm9lf/tJ0oK2+rl9NoD39qxlY3a+PWxEiU+pUmC9WpFvL272YgvFdqdkDoYVdvUKrua+UXOd7prRcJcpxNV7zz2EsNEnGcbHSVIbNPJWs0rEkfzlAMfqfDafwmGWwfdsrT2QQajZnSbrzg0+tj3imeCyKRnWZwP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSXKU5FZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF033C433C7;
	Wed, 24 Jan 2024 08:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706084357;
	bh=1NWurbFv6ZN4umhSbEGGKqB6lISrm8744fUrroskShc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HSXKU5FZzGidVCmjg0zVoSCfGo8KzVcVoLv8tCvs+eVYLte4ndX5HH8Oxj5L6Wk+W
	 51xM8MnLhcpq1yDg/qr9i/Us0myvlh7nvWeg80/exkQrr3pGDDvFoZCj10dvZixYUM
	 3cpZ7hswwItuY1LH41r9s6P9vcNylLcaGhaLXDLinFM0Q8KL9CD/Kqu4ibflkb+Orl
	 rKHAJbAV/APW+lgDY4W0qQQPiORB4Zmw65yp9gxsydzO1S86sfFNnJB4bLzZxJDCMk
	 6DTrE8Jpyc9F9oj7A4xAfKlxt/e9/uduBaS6cdsTdSm7wYd09CwdvulnDOaV7pc7DN
	 qrwASd20LLjOQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>,
	Erez Shitrit <erezsh@nvidia.com>
Subject: [net 09/14] net/mlx5: DR, Can't go to uplink vport on RX rule
Date: Wed, 24 Jan 2024 00:18:50 -0800
Message-ID: <20240124081855.115410-10-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124081855.115410-1-saeed@kernel.org>
References: <20240124081855.115410-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Go-To-Vport action on RX is not allowed when the vport is uplink.
In such case, the packet should be dropped.

Fixes: 9db810ed2d37 ("net/mlx5: DR, Expose steering action functionality")
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Erez Shitrit <erezsh@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../mellanox/mlx5/core/steering/dr_action.c      | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
index 95517c4aca0f..2ebb61ef3ea9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
@@ -874,11 +874,17 @@ int mlx5dr_actions_build_ste_arr(struct mlx5dr_matcher *matcher,
 							action->sampler->tx_icm_addr;
 			break;
 		case DR_ACTION_TYP_VPORT:
-			attr.hit_gvmi = action->vport->caps->vhca_gvmi;
-			dest_action = action;
-			attr.final_icm_addr = rx_rule ?
-				action->vport->caps->icm_address_rx :
-				action->vport->caps->icm_address_tx;
+			if (unlikely(rx_rule && action->vport->caps->num == MLX5_VPORT_UPLINK)) {
+				/* can't go to uplink on RX rule - dropping instead */
+				attr.final_icm_addr = nic_dmn->drop_icm_addr;
+				attr.hit_gvmi = nic_dmn->drop_icm_addr >> 48;
+			} else {
+				attr.hit_gvmi = action->vport->caps->vhca_gvmi;
+				dest_action = action;
+				attr.final_icm_addr = rx_rule ?
+						      action->vport->caps->icm_address_rx :
+						      action->vport->caps->icm_address_tx;
+			}
 			break;
 		case DR_ACTION_TYP_POP_VLAN:
 			if (!rx_rule && !(dmn->ste_ctx->actions_caps &
-- 
2.43.0


