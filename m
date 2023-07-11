Return-Path: <netdev+bounces-16775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD3174EAD7
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 11:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5581C20D5B
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 09:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CE91DDDF;
	Tue, 11 Jul 2023 09:30:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472481DDDC
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922DBC433C8;
	Tue, 11 Jul 2023 09:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689067809;
	bh=3Meowfuxom/2HCPTvLikG/v8PogUXpeXRrj7yRG6rIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Acpgp0b46qTZN0q/QZV4z8HsLhsK5PGtWLkGKkYE1Tl7zZrKNu5bSufCM20Uv3xxy
	 qbQe5Yt3DQkkLL6glbr7VA0aTwT9aKWdeso8Vvf/G56x8ascOLshtJSYNqWCTodEwi
	 dbOzHFz5f1/IRbJwHzFpLEsefAnLigFU9CHoZDzaUKb2keCB+lnYJCNL5OkFF0zue+
	 AsU5pdtqPYctA9I7zyujNwANv0JVInwbLDT3LX1/kZQbLHT0fgxi3EoY4P1BedzSrz
	 WpUMEsAZpyXjfCVRXX/L7/F5NcwJvboIo26tRGVDpm7hLmjZ4UG/5R4jvxjRTS6Se1
	 hbXLYrdFcHenQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jianbo Liu <jianbol@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH net-next 09/12] net/mlx5: Compare with old_dest param to modify rule destination
Date: Tue, 11 Jul 2023 12:29:07 +0300
Message-ID: <5fd15672173653d6904333ef197b605b0644e205.1689064922.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689064922.git.leonro@nvidia.com>
References: <cover.1689064922.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

The rule destination must be comprared with the old_dest passed in.

Fixes: 74491de93712 ("net/mlx5: Add multi dest support")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 830ff8480fe1..59df6156246e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -1066,7 +1066,7 @@ int mlx5_modify_rule_destination(struct mlx5_flow_handle *handle,
 	}
 
 	for (i = 0; i < handle->num_rules; i++) {
-		if (mlx5_flow_dests_cmp(new_dest, &handle->rule[i]->dest_attr))
+		if (mlx5_flow_dests_cmp(old_dest, &handle->rule[i]->dest_attr))
 			return _mlx5_modify_rule_destination(handle->rule[i],
 							     new_dest);
 	}
-- 
2.41.0


