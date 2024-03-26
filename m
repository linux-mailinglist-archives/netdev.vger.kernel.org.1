Return-Path: <netdev+bounces-82122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B20388C593
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 15:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44E79B25542
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 14:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B1713C8E0;
	Tue, 26 Mar 2024 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/7cv9qU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89E613C83C
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464420; cv=none; b=PgrS1XgHwlgPe6KHESZs1RukVeaKWmaYJacnAHLwfxG/zTd5a0mJ49yY+D/Fo0T+1EpSO1Xu5RhdgpHWwZljuDvP/6kpiDMOeOOOzetF7o5Kl+3G2EiixqF1BwbhR/y3fm/YbpkMOLLoazYQPjHHwpGjleh2o4w2kZB4IoyuDY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464420; c=relaxed/simple;
	bh=ZXZFe9RdKJFei25adHKLISho6XjQaaSBDcfXhrq1uEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJLavgkBUnEKJSkxzmY44JjmcrPh1zJEAFt+vhKi6HzyeWpr/QtWrqREkvOU1J/+QIftBd3t8QUvoMEj+fFc0Qn3Sr3x9WtF/ACQ/NIrbDedvXkgUuGbw77O2+EfzrNwqasN4pOYYut8hY0ASZkoljRjdG8s+84vgAve2PwNbCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/7cv9qU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5851C43399;
	Tue, 26 Mar 2024 14:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711464420;
	bh=ZXZFe9RdKJFei25adHKLISho6XjQaaSBDcfXhrq1uEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q/7cv9qUoVx2PkyGQqBxghWokOzDSjsVu3s8bPaaCO0RQQO07PyoQk4wsSzssU5dU
	 oLEHA80Wf7LH5xm0i9+1Jus3Kq+gobisgnH2o8S9G5tx086+6KRNSlN2Czwd0D3RFM
	 L7SuwxT6r/MIkVOGGm6zkB2d6z4YTwhp9xGMLYTGEj0XRiHbXXfmjDcPW34yGT1+Sg
	 tyTjOKHZw9IvCTjwSHObZPYHu3v/Jw+b3rJcbXScPwOvyxicuETr2TBhjV2fiLnCxw
	 zvfeukppVHgJF7FFvz6SGEv/zcOxFu+jFfGDIkjqGVKIKP9KNu9wHb9O5Zsiy6VZBh
	 xOtg7SjZZGDPA==
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
	Cosmin Ratiu <cratiu@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Subject: [net 05/10] net/mlx5: Correctly compare pkt reformat ids
Date: Tue, 26 Mar 2024 07:46:41 -0700
Message-ID: <20240326144646.2078893-6-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326144646.2078893-1-saeed@kernel.org>
References: <20240326144646.2078893-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cosmin Ratiu <cratiu@nvidia.com>

struct mlx5_pkt_reformat contains a naked union of a u32 id and a
dr_action pointer which is used when the action is SW-managed (when
pkt_reformat.owner is set to MLX5_FLOW_RESOURCE_OWNER_SW). Using id
directly in that case is incorrect, as it maps to the least significant
32 bits of the 64-bit pointer in mlx5_fs_dr_action and not to the pkt
reformat id allocated in firmware.

For the purpose of comparing whether two rules are identical,
interpreting the least significant 32 bits of the mlx5_fs_dr_action
pointer as an id mostly works... until it breaks horribly and produces
the outcome described in [1].

This patch fixes mlx5_flow_dests_cmp to correctly compare ids using
mlx5_fs_dr_action_get_pkt_reformat_id for the SW-managed rules.

Link: https://lore.kernel.org/netdev/ea5264d6-6b55-4449-a602-214c6f509c1e@163.com/T/#u [1]

Fixes: 6a48faeeca10 ("net/mlx5: Add direct rule fs_cmd implementation")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 2a9421342a50..cf085a478e3e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -1664,6 +1664,16 @@ static int create_auto_flow_group(struct mlx5_flow_table *ft,
 	return err;
 }
 
+static bool mlx5_pkt_reformat_cmp(struct mlx5_pkt_reformat *p1,
+				  struct mlx5_pkt_reformat *p2)
+{
+	return p1->owner == p2->owner &&
+		(p1->owner == MLX5_FLOW_RESOURCE_OWNER_FW ?
+		 p1->id == p2->id :
+		 mlx5_fs_dr_action_get_pkt_reformat_id(p1) ==
+		 mlx5_fs_dr_action_get_pkt_reformat_id(p2));
+}
+
 static bool mlx5_flow_dests_cmp(struct mlx5_flow_destination *d1,
 				struct mlx5_flow_destination *d2)
 {
@@ -1675,8 +1685,8 @@ static bool mlx5_flow_dests_cmp(struct mlx5_flow_destination *d1,
 		     ((d1->vport.flags & MLX5_FLOW_DEST_VPORT_VHCA_ID) ?
 		      (d1->vport.vhca_id == d2->vport.vhca_id) : true) &&
 		     ((d1->vport.flags & MLX5_FLOW_DEST_VPORT_REFORMAT_ID) ?
-		      (d1->vport.pkt_reformat->id ==
-		       d2->vport.pkt_reformat->id) : true)) ||
+		      mlx5_pkt_reformat_cmp(d1->vport.pkt_reformat,
+					    d2->vport.pkt_reformat) : true)) ||
 		    (d1->type == MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE &&
 		     d1->ft == d2->ft) ||
 		    (d1->type == MLX5_FLOW_DESTINATION_TYPE_TIR &&
-- 
2.44.0


