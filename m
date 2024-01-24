Return-Path: <netdev+bounces-65365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE0783A3F4
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E30428A38A
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 08:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F374817558;
	Wed, 24 Jan 2024 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUWMF2RX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEAE17738
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084355; cv=none; b=DXJfraNgI2uGOJLeaFQC/j7VTm62QaTZpQ3D2Z5AbTc9M4Z5gWhCXUQfj/JoVi/Ou5TXJnEAahGYAeBBdmGkFOaqtxZDwvrnXepY+jO53HOJhoJGqLnktgPSzRFsWlwLH0chxztO/YyhnIUzTiYxgPBo5l+H8XHmFIJAM/Mgz+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084355; c=relaxed/simple;
	bh=NECOEb92w8JXgb6T9sTe8mVmrAk5Mg9uL3JPUxu+/FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=le0jUlqL8geUVUvzeVaCSsYzW9xTqP5CpPv0nt4jIIR1NbiGAVC78hesNXw7X43y6+T6RexrEIbe3W4UyW0nXdRrjtE70b8CGeVcbOYecvWZKw29egZZ7mqeuDSLaVN/NXKZ3KGwryW2ImjFGyhcyadE1/VL9M1jY+ijlcSNOxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUWMF2RX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE63C433C7;
	Wed, 24 Jan 2024 08:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706084355;
	bh=NECOEb92w8JXgb6T9sTe8mVmrAk5Mg9uL3JPUxu+/FQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VUWMF2RXK+nY1SlJExttCCe4W3XcgedxOCju0Z24rvtFni075bE8rE4JeJKpaPEww
	 hR09JzyuJ21eWvW2H28FGdfY1keHBLZeJ2LnIvAXLmj/AsTKbfFwHdV1wuqqTOa1xJ
	 lkmgVND7zonYmPsAOLlIXqLCWfth1tG5PVQrpzAmICJ4ezNlglIY8nBD6HuhNaXeHK
	 1l7704g2uKqQg0dFz8MnToqBYhrMGNgei67n+UxNLra1sLzJJgaM8D7j7Ee7v7V0Na
	 WQF846FIP5Y2G8GJQDOrfmfMLtyc7cGowxeS7193vcTCbwvU7Z8QJpX7fthjGgKtdO
	 /4IUe4pN1dSog==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [net 08/14] net/mlx5: DR, Use the right GVMI number for drop action
Date: Wed, 24 Jan 2024 00:18:49 -0800
Message-ID: <20240124081855.115410-9-saeed@kernel.org>
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

When FW provides ICM addresses for drop RX/TX, the provided capability
is 64 bits that contain its GVMI as well as the ICM address itself.
In case of TX DROP this GVMI is different from the GVMI that the
domain is operating on.

This patch fixes the action to use these GVMI IDs, as provided by FW.

Fixes: 9db810ed2d37 ("net/mlx5: DR, Expose steering action functionality")
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
index 6f9790e97fed..95517c4aca0f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
@@ -788,6 +788,7 @@ int mlx5dr_actions_build_ste_arr(struct mlx5dr_matcher *matcher,
 		switch (action_type) {
 		case DR_ACTION_TYP_DROP:
 			attr.final_icm_addr = nic_dmn->drop_icm_addr;
+			attr.hit_gvmi = nic_dmn->drop_icm_addr >> 48;
 			break;
 		case DR_ACTION_TYP_FT:
 			dest_action = action;
-- 
2.43.0


