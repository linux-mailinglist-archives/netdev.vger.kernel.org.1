Return-Path: <netdev+bounces-49878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8F57F3B7A
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 02:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107EE1F233D8
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 01:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258968C0A;
	Wed, 22 Nov 2023 01:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBLUudNE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09195BA48
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 01:48:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5349C433CB;
	Wed, 22 Nov 2023 01:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700617693;
	bh=oHStiPAIPslIDK/pRq/+NXtB3k9fHzU8XgpcXSXD6ZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tBLUudNE0jCN8bovLCIjd7MOv3rCMcGk2JpLWpl9i0o9dFU+LLlP9l95MbaoE9yZw
	 zsQLejlH6Y40oYZTJkDfxdhawwFGx7PoQhXGBfwDvkxTe4E9nW8laBUtuB4VGbUfyL
	 mWDPhb5HLSaZpLy4hguOtdHTlMDHPUsGj6GoJs6XtSZE9spEakONxm3cJYEXT7BfwZ
	 JG4eZ3wsNZ0RsGH5HUKtDGRPrV/Pk3kRFs50pQ73RZp3/aCoML+ZY98St1SBL+qUyw
	 xF/leXU6vuBu0D9TngBaxCg4o0xy1XhgSpV+EMi0p4lFzJhkuTllCKTFH66eaOxH8p
	 0lIPejJ+qMVyw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [net 09/15] net/mlx5e: Forbid devlink reload if IPSec rules are offloaded
Date: Tue, 21 Nov 2023 17:47:58 -0800
Message-ID: <20231122014804.27716-10-saeed@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122014804.27716-1-saeed@kernel.org>
References: <20231122014804.27716-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

When devlink reload, mlx5 IPSec module can't be safely cleaned up if
there is any IPSec rule offloaded, so forbid it in this condition.

Fixes: edd8b295f9e2 ("Merge branch 'mlx5-ipsec-packet-offload-support-in-eswitch-mode'")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c |  5 +++++
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h |  2 ++
 .../mellanox/mlx5/core/eswitch_offloads.c         | 15 +++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 3e064234f6fe..8925e87a3ed5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -157,6 +157,11 @@ static int mlx5_devlink_reload_down(struct devlink *devlink, bool netns_change,
 		return -EOPNOTSUPP;
 	}
 
+	if (mlx5_eswitch_mode_is_blocked(dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "reload is unsupported if IPSec rules are configured");
+		return -EOPNOTSUPP;
+	}
+
 	if (mlx5_core_is_pf(dev) && pci_num_vf(pdev))
 		NL_SET_ERR_MSG_MOD(extack, "reload while VFs are present is unfavorable");
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index b674b57d05aa..88524c2a4355 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -846,6 +846,7 @@ void mlx5_eswitch_unblock_encap(struct mlx5_core_dev *dev);
 
 int mlx5_eswitch_block_mode(struct mlx5_core_dev *dev);
 void mlx5_eswitch_unblock_mode(struct mlx5_core_dev *dev);
+bool mlx5_eswitch_mode_is_blocked(struct mlx5_core_dev *dev);
 
 static inline int mlx5_eswitch_num_vfs(struct mlx5_eswitch *esw)
 {
@@ -947,6 +948,7 @@ static inline void mlx5_eswitch_unblock_encap(struct mlx5_core_dev *dev)
 
 static inline int mlx5_eswitch_block_mode(struct mlx5_core_dev *dev) { return 0; }
 static inline void mlx5_eswitch_unblock_mode(struct mlx5_core_dev *dev) {}
+static inline bool mlx5_eswitch_mode_is_blocked(struct mlx5_core_dev *dev) { return false; }
 static inline bool mlx5_eswitch_block_ipsec(struct mlx5_core_dev *dev)
 {
 	return false;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index bf78eeca401b..85c2a20e68fa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3693,6 +3693,21 @@ void mlx5_eswitch_unblock_mode(struct mlx5_core_dev *dev)
 	up_write(&esw->mode_lock);
 }
 
+bool mlx5_eswitch_mode_is_blocked(struct mlx5_core_dev *dev)
+{
+	struct mlx5_eswitch *esw = dev->priv.eswitch;
+	bool blocked;
+
+	if (!mlx5_esw_allowed(esw))
+		return false;
+
+	down_write(&esw->mode_lock);
+	blocked = esw->offloads.num_block_mode;
+	up_write(&esw->mode_lock);
+
+	return blocked;
+}
+
 int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 				  struct netlink_ext_ack *extack)
 {
-- 
2.42.0


