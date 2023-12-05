Return-Path: <netdev+bounces-54147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15212806103
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 22:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C3EDB21187
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 21:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482146FCD4;
	Tue,  5 Dec 2023 21:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNJo1FB+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABDD6FCD2
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 21:45:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB93C433C7;
	Tue,  5 Dec 2023 21:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701812751;
	bh=RJbgxjN90Xw0L2yrktvCzzxxSnOaDd2Bhyvax9W1sCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WNJo1FB+5pQRT/byHcA0usgEYWDRIHoHuow+YEJ9bHnfj2vhjORwhaAU9FNG7biZA
	 /bx2rAeob2sS8SpbaXNSCzWne9jDBa1wc5F1cueDLCyGipdseVhZ2P2JO/QWTEc8Zf
	 CoHiUYdfq/3ttHEQoCsVIb2ari2gM3UBZKBrJF4FhjROLwAtYrsx+S11dEqDW7ZGM/
	 uSQ9PoHdlheyg6+lrPdLhfyRL+NmWwFfAvKHovbcyX+gZ1gBo+6gXN1JnFiAEa4zfm
	 8cREcmbpL146+HQsYFmV1g65VSHMD20NxDh+UQgSnJGM0+5x5GAbfyGAHTHvJFiGQ6
	 AuMaiv8azrOcQ==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: [net V3 15/15] net/mlx5e: Correct snprintf truncation handling for fw_version buffer used by representors
Date: Tue,  5 Dec 2023 13:45:34 -0800
Message-ID: <20231205214534.77771-16-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205214534.77771-1-saeed@kernel.org>
References: <20231205214534.77771-1-saeed@kernel.org>
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

Link: https://docs.kernel.org/core-api/kernel-api.html#c.snprintf
Fixes: 1b2bd0c0264f ("net/mlx5e: Check return value of snprintf writing to fw_version buffer for representors")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 1bf7540a65ad..e92d4f83592e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -78,7 +78,7 @@ static void mlx5e_rep_get_drvinfo(struct net_device *dev,
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


