Return-Path: <netdev+bounces-22027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799FC765B81
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 20:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A78221C216CD
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C45D81CA09;
	Thu, 27 Jul 2023 18:39:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9941C9FA
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF1AC433C8;
	Thu, 27 Jul 2023 18:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690483171;
	bh=VKVDDMnSZY+wpuwtcjlgYAzglkIpX3rdSsUefgu+PZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=POQ6rTS/JfKakbA0JyrS610sLfNvKYt+3dwR5i8E2vmX4Ow3FNmz+0p7Wj4zYISJ3
	 T9jQ08wLh1EHwzu+91W0p7NwjH37YvajT2Z4s2TeQewo7iB+BDhpeovJMQ/UUi6O9Y
	 rnrBNcmteAPrILw5uKrhWe4i4O/kAYzcaU4FgDeR3KiyH4p7PrREVIthQpZu2+x/0k
	 GiZxhpQvJRiagGAxrsSqxkLicaSY9GHC+dIyUtrGAtSfeV3WCvIVkjclkTdKmjQ4IP
	 gzqklDnkEJRAjnmukqcLtfzk3DRmQf+LpLw2N7Qm28Bra3dICwtveg21jh8Z0P15kG
	 +OOm80Lu0HJlw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Roi Dayan <roid@nvidia.com>
Subject: [net-next V2 09/15] net/mlx5e: Remove duplicate code for user flow
Date: Thu, 27 Jul 2023 11:39:08 -0700
Message-ID: <20230727183914.69229-10-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727183914.69229-1-saeed@kernel.org>
References: <20230727183914.69229-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Parav Pandit <parav@nvidia.com>

Flow table and priority detection is same for IP user flows and other L4
flows. Hence, use same code for all these flow types.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Roi Dayan <roid@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
index aac32e505c14..08eb186615c8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
@@ -96,10 +96,6 @@ static struct mlx5e_ethtool_table *get_flow_table(struct mlx5e_priv *priv,
 	case UDP_V4_FLOW:
 	case TCP_V6_FLOW:
 	case UDP_V6_FLOW:
-		max_tuples = ETHTOOL_NUM_L3_L4_FTS;
-		prio = MLX5E_ETHTOOL_L3_L4_PRIO + (max_tuples - num_tuples);
-		eth_ft = &ethtool->l3_l4_ft[prio];
-		break;
 	case IP_USER_FLOW:
 	case IPV6_USER_FLOW:
 		max_tuples = ETHTOOL_NUM_L3_L4_FTS;
-- 
2.41.0


