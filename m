Return-Path: <netdev+bounces-57157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E922281248C
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED489B21238
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 01:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0E17F9;
	Thu, 14 Dec 2023 01:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGvmP0G5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A140946A2
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 01:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A72C433C9;
	Thu, 14 Dec 2023 01:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702517117;
	bh=Mu9Xn91286+2wllO7EGzHSJcvlQwhXUD9IjgPOUs7yM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TGvmP0G5WvGzGVALEiRizfgnxOt4WOVjzEyM44dJ3TxOYRKajqGtzQ3r4zMwicArS
	 R47eRrNn+Lq65rYLZsl7qRP4XBGMIn1ZbFoEulaVkQ+csQbb9ZGGGJvMa14b48Ddt1
	 IZQER3Vy4L/TM8WeOeFgBGUU0m66e0VjfOOmtFoWIlqttx6ABJJvqa3lbqdb5imNwC
	 MEg0Ful57l1Gd4rUxUD7lLfFF1RUxkMM2kQ/GpulrPnc9duanZYTo9I5K5waPcujpv
	 GenY0h+0OeklgSlzYF3V3VaIRhU0gxGy3Xrq799zREReoBmlGp2r3RQJmyxvlJK57Z
	 XRdZZ+L4okYkQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Chris Mi <cmi@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>
Subject: [net 08/15] net/mlx5e: Decrease num_block_tc when unblock tc offload
Date: Wed, 13 Dec 2023 17:24:58 -0800
Message-ID: <20231214012505.42666-9-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214012505.42666-1-saeed@kernel.org>
References: <20231214012505.42666-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Mi <cmi@nvidia.com>

The cited commit increases num_block_tc when unblock tc offload.
Actually should decrease it.

Fixes: c8e350e62fc5 ("net/mlx5e: Make TC and IPsec offloads mutually exclusive on a netdev")
Signed-off-by: Chris Mi <cmi@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index c1e89dc77db9..41a2543a52cd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -2142,7 +2142,7 @@ static int mlx5e_ipsec_block_tc_offload(struct mlx5_core_dev *mdev)
 
 static void mlx5e_ipsec_unblock_tc_offload(struct mlx5_core_dev *mdev)
 {
-	mdev->num_block_tc++;
+	mdev->num_block_tc--;
 }
 
 int mlx5e_accel_ipsec_fs_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
-- 
2.43.0


