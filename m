Return-Path: <netdev+bounces-28228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D6F77EB35
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69CE51C21207
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 21:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B454019887;
	Wed, 16 Aug 2023 21:00:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5841719888
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 21:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124BDC433C7;
	Wed, 16 Aug 2023 21:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692219658;
	bh=2UE98QX5sk2RSQ5a/NjxXbQrmjCdmOL9t0G2a09dYWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P4Zl0Rco6qJBTp5nwKC7qEIbf/qlnz4w4jX9a0t/uGM7SR3Nktk7l0lybzLECMF3x
	 0ZWA5VShK8AyLphj8A4m9onU7V2tpGWBV5ef4RXsGeOYy3wF+5YTAbhmA8XGd3o7Mf
	 bYiWf1RQS2MgpfWFPaMX8eH6MGZ4SGtsxPa1X1DbQncdWhhCNSqCH+hwM2sr+4k7nN
	 he3w8Ij0x4MzE0M5IYbGelFq3cNMNg0NIvwKP3QWO1vwTvTErQWAfbr2WOTbfwlwZy
	 4nUjAvYe9GfcDPQC7CNRYxnGAZMV8MkP+0XYDbY4RIJJ6RcQTF5eIWNKaZ04CU6jcz
	 eXDhzq3l6vFOA==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Adham Faris <afaris@nvidia.com>
Subject: [net-next 02/15] net/mlx5e: aRFS, Warn if aRFS table does not exist for aRFS rule
Date: Wed, 16 Aug 2023 14:00:36 -0700
Message-ID: <20230816210049.54733-3-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816210049.54733-1-saeed@kernel.org>
References: <20230816210049.54733-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adham Faris <afaris@nvidia.com>

aRFS tables should be allocated and exist in advance. Driver shouldn't
reach a point where it tries to add aRFS rule to table that does not
exist.

Add warning if driver encounters such situation.

Signed-off-by: Adham Faris <afaris@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
index 67d8b198a014..e8b0acf7d454 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
@@ -519,6 +519,8 @@ static struct mlx5_flow_handle *arfs_add_rule(struct mlx5e_priv *priv,
 		 ntohs(tuple->etype));
 	arfs_table = arfs_get_table(arfs, tuple->ip_proto, tuple->etype);
 	if (!arfs_table) {
+		WARN_ONCE(1, "arfs table does not exist for etype %u and ip_proto %u\n",
+			  tuple->etype, tuple->ip_proto);
 		err = -EINVAL;
 		goto out;
 	}
-- 
2.41.0


