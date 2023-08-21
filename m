Return-Path: <netdev+bounces-29386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF32782FC2
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 19:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F0E280E56
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 17:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AACCF4F5;
	Mon, 21 Aug 2023 17:57:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B608F4E
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 17:57:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A534C433C9;
	Mon, 21 Aug 2023 17:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692640671;
	bh=cagxIgDEhFzsHUWP8eDol4BGAvO4+/KXBtfv1u8Ev1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TKjF2AZT8ehO4tsKVdgZL5sYAlUfSGp4IU22hEP3Jzhabz9LEFRR16KtJ863LERoZ
	 /MDcqQoaLmyyMKrjVxGgf+qkD2kyk5181SfLPWZbJj7W/udgCVCnFaXt7qr+ImUp8E
	 ix/TjhtrRV3yOu4kXNW6Fs5A/nHA9dmqYz+1kmea68QC4g9iTwsX4DZUSBcnOm7PL9
	 8nunqZn6FlLKaoQE7BK2C204BbhVHtcI1Lkl6/Or6+0+qSuN9SpIAbpM318G01CnIu
	 KVUNClid7gZQxdCoOh86KffGBTClXz3ltXyzGcSlOlvxY9GJ1/QbJ9rvsGcqkn/deE
	 VP2xYPGqbElog==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Adham Faris <afaris@nvidia.com>
Subject: [net-next V2 01/14] net/mlx5e: aRFS, Prevent repeated kernel rule migrations requests
Date: Mon, 21 Aug 2023 10:57:26 -0700
Message-ID: <20230821175739.81188-2-saeed@kernel.org>
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


