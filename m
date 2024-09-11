Return-Path: <netdev+bounces-127548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0688E975B8D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C230D28451B
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36981BB6BE;
	Wed, 11 Sep 2024 20:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICKV8Psv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5361BB6B1
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085883; cv=none; b=jcvIrNyfJ/NZ9svKrMFNdIqMKA3ruBtGyntitrIblQIKbXspECJSn/Yx8FGdHvBRfoVCGbYzZoXGFpiDCnfOwzVXMWoHSrByHQXGozsKIYSrZGvt2itvFBcWPdTBwDKJ0Aj2Aw3Os9bCe4MV6X4F6800pkeHhHp/fTVcpbMblvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085883; c=relaxed/simple;
	bh=WUxFq2afB9ra2VyoVu8sB4rZP/K1gdIUuLtK+2eZrd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozk+dujGJ/sFOiovlNCH60cNVCx6H1YtMk/FQ2zQ/MSXJ5yUSKw7yBrYDSTP6r/Zpn7GQGrcLjhFBfHF6/zdt4sRpaCkW5/tLnQITp+gthVUu7EwkWQKl0mNqwg4x5ZvkKCCmP8FD7Ru4A85oPEm2Zh2uWMgo3eVVJbidW1/fOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICKV8Psv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEB1C4CEC0;
	Wed, 11 Sep 2024 20:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726085883;
	bh=WUxFq2afB9ra2VyoVu8sB4rZP/K1gdIUuLtK+2eZrd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ICKV8Psvhc1HSxQgM/NoQkNQFz4RYEhFg+17GGNCfoyY7viYTz8RIisyj5PULzuYm
	 iqCHuX9HDnjT/tkXQd3uxSK9rmf4tty9E0Q1x59eYgY58ukeSbFhjIUCxuJg8jGHvw
	 DRK3r3lAZDpTJtCKYd13Zpmq1Db6FphHi9u3DeEcT8ep2Z5eOoDnpazTAmC12zwiy0
	 xGh/1LSxxUKhvdLxNGseDAx8I5HR6qLqFXpv5EBf2zVbsxI/rELe1XLNs5efdkqiGn
	 I15UU87e1ayFttEJhiy3XtlwVURV54d+2/HQvlqtHhwffb4AMYzv26BH7uwiBdfGnC
	 Pb3fVgXB8AOSA==
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
	Moshe Shemesh <moshe@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [net-next 04/15] net/mlx5: fs, make get_root_namespace API function
Date: Wed, 11 Sep 2024 13:17:46 -0700
Message-ID: <20240911201757.1505453-5-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911201757.1505453-1-saeed@kernel.org>
References: <20240911201757.1505453-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Moshe Shemesh <moshe@nvidia.com>

As preparation for HW Steering support, where the function
get_root_namespace() is needed to get root FDB, make it an API function
and rename it to mlx5_get_root_namespace().

Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_core.c    | 16 ++++++++--------
 include/linux/mlx5/fs.h                          |  3 +++
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index a47d6419160d..e32725487702 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3590,8 +3590,8 @@ int mlx5_fs_remove_rx_underlay_qpn(struct mlx5_core_dev *dev, u32 underlay_qpn)
 }
 EXPORT_SYMBOL(mlx5_fs_remove_rx_underlay_qpn);
 
-static struct mlx5_flow_root_namespace
-*get_root_namespace(struct mlx5_core_dev *dev, enum mlx5_flow_namespace_type ns_type)
+struct mlx5_flow_root_namespace *
+mlx5_get_root_namespace(struct mlx5_core_dev *dev, enum mlx5_flow_namespace_type ns_type)
 {
 	struct mlx5_flow_namespace *ns;
 
@@ -3614,7 +3614,7 @@ struct mlx5_modify_hdr *mlx5_modify_header_alloc(struct mlx5_core_dev *dev,
 	struct mlx5_modify_hdr *modify_hdr;
 	int err;
 
-	root = get_root_namespace(dev, ns_type);
+	root = mlx5_get_root_namespace(dev, ns_type);
 	if (!root)
 		return ERR_PTR(-EOPNOTSUPP);
 
@@ -3639,7 +3639,7 @@ void mlx5_modify_header_dealloc(struct mlx5_core_dev *dev,
 {
 	struct mlx5_flow_root_namespace *root;
 
-	root = get_root_namespace(dev, modify_hdr->ns_type);
+	root = mlx5_get_root_namespace(dev, modify_hdr->ns_type);
 	if (WARN_ON(!root))
 		return;
 	root->cmds->modify_header_dealloc(root, modify_hdr);
@@ -3655,7 +3655,7 @@ struct mlx5_pkt_reformat *mlx5_packet_reformat_alloc(struct mlx5_core_dev *dev,
 	struct mlx5_flow_root_namespace *root;
 	int err;
 
-	root = get_root_namespace(dev, ns_type);
+	root = mlx5_get_root_namespace(dev, ns_type);
 	if (!root)
 		return ERR_PTR(-EOPNOTSUPP);
 
@@ -3681,7 +3681,7 @@ void mlx5_packet_reformat_dealloc(struct mlx5_core_dev *dev,
 {
 	struct mlx5_flow_root_namespace *root;
 
-	root = get_root_namespace(dev, pkt_reformat->ns_type);
+	root = mlx5_get_root_namespace(dev, pkt_reformat->ns_type);
 	if (WARN_ON(!root))
 		return;
 	root->cmds->packet_reformat_dealloc(root, pkt_reformat);
@@ -3703,7 +3703,7 @@ mlx5_create_match_definer(struct mlx5_core_dev *dev,
 	struct mlx5_flow_definer *definer;
 	int id;
 
-	root = get_root_namespace(dev, ns_type);
+	root = mlx5_get_root_namespace(dev, ns_type);
 	if (!root)
 		return ERR_PTR(-EOPNOTSUPP);
 
@@ -3727,7 +3727,7 @@ void mlx5_destroy_match_definer(struct mlx5_core_dev *dev,
 {
 	struct mlx5_flow_root_namespace *root;
 
-	root = get_root_namespace(dev, definer->ns_type);
+	root = mlx5_get_root_namespace(dev, definer->ns_type);
 	if (WARN_ON(!root))
 		return;
 
diff --git a/include/linux/mlx5/fs.h b/include/linux/mlx5/fs.h
index 3fb428ce7d1c..b744e554f014 100644
--- a/include/linux/mlx5/fs.h
+++ b/include/linux/mlx5/fs.h
@@ -342,4 +342,7 @@ void mlx5_packet_reformat_dealloc(struct mlx5_core_dev *dev,
 				  struct mlx5_pkt_reformat *reformat);
 
 u32 mlx5_flow_table_id(struct mlx5_flow_table *ft);
+
+struct mlx5_flow_root_namespace *
+mlx5_get_root_namespace(struct mlx5_core_dev *dev, enum mlx5_flow_namespace_type ns_type);
 #endif
-- 
2.46.0


