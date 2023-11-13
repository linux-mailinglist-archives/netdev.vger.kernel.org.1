Return-Path: <netdev+bounces-47461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E6F7EA544
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 22:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CBF2B20A12
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 21:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30B73D980;
	Mon, 13 Nov 2023 21:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U57n4lZZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8474E3D97C
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 21:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E775C433C7;
	Mon, 13 Nov 2023 21:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699909725;
	bh=AlIw3keRkgmnN0ilTd7soueMY8Kriq3D8y3v1FY12z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U57n4lZZUR6pDuVTwYQzD1tn+wR2CBAWR6FavND7cqEX47aUMBvL/VccWmOf5z5ME
	 TktCvFd3/gfiU7pM/PU7MZp1nY68H6fk+M8WD7cFGuuAVquPLTGMDCMUsic8Fgygyp
	 n3nv3La6L6l2z/crjwXw+u+WZzK/Hb9JY2McdsmZC2ZzLxD9Aro5WTEX3mBELHmGxN
	 5tlQNjOHJ0UVHsgblpFDe0XCcGwkACkBNw1lVubkmIbNCkGZhyqWUxXTGH81QjmNns
	 I8LEktGxRp/jplF/1iw8ieyPm6Yw29uMSFf+YCrD7mW/2aPfxFvfsj0Yd9x/ypBy7F
	 q77IMsW0mwyhg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: [net 16/17] net/mlx5e: Check return value of snprintf writing to fw_version buffer
Date: Mon, 13 Nov 2023 13:08:25 -0800
Message-ID: <20231113210826.47593-17-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113210826.47593-1-saeed@kernel.org>
References: <20231113210826.47593-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Treat the operation as an error case when the return value is equivalent to
the size of the name buffer. Failed to write null terminator to the name
buffer, making the string malformed and should not be used. Provide a
string with only the firmware version when forming the string with the
board id fails.

Without check, will trigger -Wformat-truncation with W=1.

    drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c: In function 'mlx5e_ethtool_get_drvinfo':
    drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c:49:31: warning: '%.16s' directive output may be truncated writing up to 16 bytes into a region of size between 13 and 22 [-Wformat-truncation=]
      49 |                  "%d.%d.%04d (%.16s)",
         |                               ^~~~~
    drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c:48:9: note: 'snprintf' output between 12 and 37 bytes into a destination of size 32
      48 |         snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      49 |                  "%d.%d.%04d (%.16s)",
         |                  ~~~~~~~~~~~~~~~~~~~~~
      50 |                  fw_rev_maj(mdev), fw_rev_min(mdev), fw_rev_sub(mdev),
         |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      51 |                  mdev->board_id);
         |                  ~~~~~~~~~~~~~~~

Fixes: 84e11edb71de ("net/mlx5e: Show board id in ethtool driver information")
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6d4ab2e97dcfbcd748ae71761a9d8e5e41cc732c
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c    | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 215261a69255..792a0ea544cd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -43,12 +43,17 @@ void mlx5e_ethtool_get_drvinfo(struct mlx5e_priv *priv,
 			       struct ethtool_drvinfo *drvinfo)
 {
 	struct mlx5_core_dev *mdev = priv->mdev;
+	int count;
 
 	strscpy(drvinfo->driver, KBUILD_MODNAME, sizeof(drvinfo->driver));
-	snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
-		 "%d.%d.%04d (%.16s)",
-		 fw_rev_maj(mdev), fw_rev_min(mdev), fw_rev_sub(mdev),
-		 mdev->board_id);
+	count = snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
+			 "%d.%d.%04d (%.16s)", fw_rev_maj(mdev),
+			 fw_rev_min(mdev), fw_rev_sub(mdev), mdev->board_id);
+	if (count == sizeof(drvinfo->fw_version))
+		snprintf(drvinfo->fw_version, sizeof(drvinfo->fw_version),
+			 "%d.%d.%04d", fw_rev_maj(mdev),
+			 fw_rev_min(mdev), fw_rev_sub(mdev));
+
 	strscpy(drvinfo->bus_info, dev_name(mdev->device),
 		sizeof(drvinfo->bus_info));
 }
-- 
2.41.0


