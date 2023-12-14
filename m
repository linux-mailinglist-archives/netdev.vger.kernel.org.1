Return-Path: <netdev+bounces-57164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BA2812493
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72B5F1C2150C
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 01:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7F9EC7;
	Thu, 14 Dec 2023 01:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZyJAEoj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD5D63DF
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 01:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7BE7C433C7;
	Thu, 14 Dec 2023 01:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702517124;
	bh=RJbgxjN90Xw0L2yrktvCzzxxSnOaDd2Bhyvax9W1sCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CZyJAEojK10Sfh7J7LDCsdyzhVq3OeX2JsWhYPyE+++y20Bn0EUHvSVx6iJh0E2fk
	 e/RBpx5Fid4uVGwuK8Wu5DgkN/24egqq9Y04yR9cq3hkyDVBrtTlVC+awzcUnrimTb
	 5HPXuAYKRin7/TNLM+QG+b3R5nsYMlcIg3YW5gTNHyzWvGjEscGD67GomFsvS1ARJ0
	 +jICR9TxJ1HxcgZVYM+bQjNaJ0dgSBgBlg6Fi2wkmMrbYUFMlg0OG12FG9z422jVDO
	 rlwYMLamgKLfSLKB1dbtSi/OKdY3RYA13boSGrhAj1q3hoqt7+aHUmRZ7Xua72PsPj
	 JccfP+gHlzkjQ==
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
Subject: [net 15/15] net/mlx5e: Correct snprintf truncation handling for fw_version buffer used by representors
Date: Wed, 13 Dec 2023 17:25:05 -0800
Message-ID: <20231214012505.42666-16-saeed@kernel.org>
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


