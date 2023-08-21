Return-Path: <netdev+bounces-29387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9CC782FC6
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 19:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DBDA280EFC
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 17:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFBC8F4E;
	Mon, 21 Aug 2023 17:57:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3200AE54A
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 17:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B89C433CA;
	Mon, 21 Aug 2023 17:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692640672;
	bh=2UE98QX5sk2RSQ5a/NjxXbQrmjCdmOL9t0G2a09dYWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RYxTxjAyIoess2aeqPlDznNBPC6ISRhyHaV6+T3Nb1E7WXQSnFUqo8xyWcKm+Yb1q
	 xCj9vcwotMjLlq9k92vRLWgdxnweSCq61tt1rXBKqawI/a9JAZdaXd0NHDpQoiQTi2
	 Ud8XK4yFVIR8+VMjeAiTRu1xmqFfBKxHg4bykIurRG9FM4rxw8wPyNjCo3b/HTyEyd
	 r077qlXSfqRjJNSd7Hi4b24mUPvUqki19V8bxs1e9qa1rFDOUWN9M+Ofr70+QrY420
	 f0w/bE/s4cLxiRzr4x5kkC49LTYX+TAItqCLoo+HqfZR3p/K6vSQ7MYyo+3TLABKrA
	 dEUEvNm9Xb4eg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Adham Faris <afaris@nvidia.com>
Subject: [net-next V2 02/14] net/mlx5e: aRFS, Warn if aRFS table does not exist for aRFS rule
Date: Mon, 21 Aug 2023 10:57:27 -0700
Message-ID: <20230821175739.81188-3-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821175739.81188-1-saeed@kernel.org>
References: <20230821175739.81188-1-saeed@kernel.org>
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


