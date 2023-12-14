Return-Path: <netdev+bounces-57163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF2A812492
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C491282992
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 01:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8F2EC2;
	Thu, 14 Dec 2023 01:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtXPpMRx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF016122
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 01:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F43C433C7;
	Thu, 14 Dec 2023 01:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702517123;
	bh=zKCONBqv5B4WAD0DUxmPeLaCswnYO2/PVLYztXh3QnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VtXPpMRxyMIJVeziwbqyX9r45np8MawR3EmHd1pwvdzqmCZZRjJu7Kd2nYPgqauKq
	 /Z9Xsb0aFGQBKykPfO1DBIYzLxs3YZUCGNZNlrXNc1WwioqlUPydY2+OfwuWwOJc5F
	 ftdk0/tFjA5A8ZrpegQVM+sV1Z5/mO4KwmobAzwRNWBXOVCH2HzrfIrpPL+a62MUqE
	 mPyIr1NNWobiQXqIrMkwkptXEC/ZtJDYeCCyOwcNGlu2w7aqaX1yGPyfINHVqsIl9I
	 0A+Sn+4a9Wp7bRc0QOncsgGRNLAgEVT2gHihJpg4/Cone92pghQw0gRPJNBm4GOh+c
	 pOaVtPtFlVMhg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	David Laight <David.Laight@ACULAB.COM>,
	Simon Horman <horms@kernel.org>
Subject: [net 14/15] net/mlx5e: Correct snprintf truncation handling for fw_version buffer
Date: Wed, 13 Dec 2023 17:25:04 -0800
Message-ID: <20231214012505.42666-15-saeed@kernel.org>
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

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

snprintf returns the length of the formatted string, excluding the trailing
null, without accounting for truncation. This means that is the return
value is greater than or equal to the size parameter, the fw_version string
was truncated.

Reported-by: David Laight <David.Laight@ACULAB.COM>
Closes: https://lore.kernel.org/netdev/81cae734ee1b4cde9b380a9a31006c1a@AcuMS.aculab.com/
Link: https://docs.kernel.org/core-api/kernel-api.html#c.snprintf
Fixes: 41e63c2baa11 ("net/mlx5e: Check return value of snprintf writing to fw_version buffer")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 792a0ea544cd..c7c1b667b105 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -49,7 +49,7 @@ void mlx5e_ethtool_get_drvinfo(struct mlx5e_priv *priv,
 	count = snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
 			 "%d.%d.%04d (%.16s)", fw_rev_maj(mdev),
 			 fw_rev_min(mdev), fw_rev_sub(mdev), mdev->board_id);
-	if (count == sizeof(drvinfo->fw_version))
+	if (count >= sizeof(drvinfo->fw_version))
 		snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
 			 "%d.%d.%04d", fw_rev_maj(mdev),
 			 fw_rev_min(mdev), fw_rev_sub(mdev));
-- 
2.43.0


