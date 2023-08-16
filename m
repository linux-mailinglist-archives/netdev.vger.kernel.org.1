Return-Path: <netdev+bounces-28227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BD977EB2E
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ACE81C2119C
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 21:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DB21988C;
	Wed, 16 Aug 2023 21:00:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B5417FE5
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 21:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4C7C433CA;
	Wed, 16 Aug 2023 21:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692219657;
	bh=cagxIgDEhFzsHUWP8eDol4BGAvO4+/KXBtfv1u8Ev1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J+ljOSmosmhGbHwvdBEmnLiG3p1W/U0UKVpVXwxvG/5O/q+EGDInLCuYuB+aA3csF
	 kuDxdE219KLUKCw8Xk00kNpBS7Oz1H6VfPZtIXjjCxtkClmNcd+bTZ1YmOphVtJJSA
	 O1pa0NbRu/47kUuPqA0DZeqnIJiGCnYgPcQ+f8mJhA1cxCFY7rU213mhH/mw48JW1B
	 a9PS96TdP2ttbFpUhNTgmREY2SGwSVkj/sJAhIfJ1vQhdZr5PTIY0UO9bjrYflnOqJ
	 fA748OZgVOzVy8qzv4uV6m3O8kVvBPUJay34LMjY+oiSiNGE/g1MExeoMZ5jQtyvkt
	 4NbGJUKaqhL0Q==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Adham Faris <afaris@nvidia.com>
Subject: [net-next 01/15] net/mlx5e: aRFS, Prevent repeated kernel rule migrations requests
Date: Wed, 16 Aug 2023 14:00:35 -0700
Message-ID: <20230816210049.54733-2-saeed@kernel.org>
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

aRFS rule movement requests from one Rx ring to other Rx ring arrive
from the kernel to ensure that packets are steered to the right Rx ring.
In the time interval until satisfying such a request, several more
requests might follow, for the same flow.

This patch detects and prevents repeated aRFS rules movement requests.

In mlx5e_rx_flow_steer() ndo, after finding the aRFS rule that have been
requested to move by the kernel, check if it's already requested to move
by calling work_busy(&arfs_rule->arfs_work) handler. IOW, if this
request is pending to be executed (in the work queue) or it's executing
now but hasn't finished yet, return current filter ID and don't issue a
new transition work.

Signed-off-by: Adham Faris <afaris@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
index 5aa51d74f8b4..67d8b198a014 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c
@@ -740,7 +740,7 @@ int mlx5e_rx_flow_steer(struct net_device *dev, const struct sk_buff *skb,
 	spin_lock_bh(&arfs->arfs_lock);
 	arfs_rule = arfs_find_rule(arfs_t, &fk);
 	if (arfs_rule) {
-		if (arfs_rule->rxq == rxq_index) {
+		if (arfs_rule->rxq == rxq_index || work_busy(&arfs_rule->arfs_work)) {
 			spin_unlock_bh(&arfs->arfs_lock);
 			return arfs_rule->filter_id;
 		}
-- 
2.41.0


