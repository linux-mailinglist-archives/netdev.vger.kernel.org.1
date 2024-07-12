Return-Path: <netdev+bounces-110984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD74792F313
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 02:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67EE41F22BA3
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 00:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A960C4683;
	Fri, 12 Jul 2024 00:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuG2knB0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FEC441D
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 00:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720744407; cv=none; b=koplIkfsffyKyZwRdqBebnx6E2eEFiUsjtRUlPpQKyDtF4ryNSS1SWfU0oM2Miu013GBhzeJ46THACCi2v36kON0b/G+696+jlBtxpwUykJlJjHYS9C7rZQf4JFT1S48VLXNczSwT/jsEmiDBot3mj4zsAq8xTldntIBL8pVymY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720744407; c=relaxed/simple;
	bh=vvEJwGnN6uyldzpKsS7JynTlHkGx4A9fSa8syNIOeLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RC9rr29R2qzvdA3cyE+n8SSk2ouhO7a6tlMwEoDncqGrFQZaZSt3+ggHVa0Xjuk1IfF8ALUVyil/Q5Brbqr7zTrKjsMtRoyiEuezKyWRgwGGWlkKiEQI9c2g/qCASixriXxSf/IvOT9llEakDpgVMO64Mouk6x0VA+DBqjwfAjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuG2knB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598D0C4AF09;
	Fri, 12 Jul 2024 00:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720744407;
	bh=vvEJwGnN6uyldzpKsS7JynTlHkGx4A9fSa8syNIOeLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FuG2knB0tC28M6WuM5RxSRV8h9A8qaMUbRpJCK2+I9GPg4R254vqkVt9CF7EBzc3d
	 Hoh+mDsOfibQ4J2k5msWbuKXUBsqShV2Q5v4gmOsZOe43cp9JCqQd50/Y631GN4wN8
	 xX5mO97Q82C7RI0kYB59xihjGSyREmQIjT8X+n5D/60raHOCxm/Fdi7y4cdv/3KGAE
	 LCbqbZ7pT+YGp9RcAD8oVZSi9eejVAAszSLFmgqMM+8OYIYRMJZWqky6BCdToHnB1A
	 fE4fFqKWw1g/1pPq0VulAKwlEvHqkNTxdODggdU3COsjqmFEU3GWeBbws49QcwurJC
	 ZasLtHUx9xOFg==
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
	Daniel Jurgens <danielj@nvidia.com>,
	William Tu <witu@nvidia.com>
Subject: [PATCH net-next V3 2/4] net/mlx5: Set sf_eq_usage for SF max EQs
Date: Thu, 11 Jul 2024 17:33:08 -0700
Message-ID: <20240712003310.355106-3-saeed@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240712003310.355106-1-saeed@kernel.org>
References: <20240712003310.355106-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Jurgens <danielj@nvidia.com>

When setting max_io_eqs for an SF function also set the sf_eq_usage_cap.
This is to indicate to the SF driver from the PF that the user has set
the max io eqs via devlink. So the SF driver can later query the proper
max eq value from the new cap.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 72949cb85244..099a716f1784 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4676,6 +4676,9 @@ mlx5_devlink_port_fn_max_io_eqs_set(struct devlink_port *port, u32 max_io_eqs,
 	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_ctx, capability);
 	MLX5_SET(cmd_hca_cap_2, hca_caps, max_num_eqs_24b, max_eqs);
 
+	if (mlx5_esw_is_sf_vport(esw, vport_num))
+		MLX5_SET(cmd_hca_cap_2, hca_caps, sf_eq_usage, 1);
+
 	err = mlx5_vport_set_other_func_cap(esw->dev, hca_caps, vport_num,
 					    MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE2);
 	if (err)
-- 
2.45.2


