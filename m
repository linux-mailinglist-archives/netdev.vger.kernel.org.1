Return-Path: <netdev+bounces-25067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85596772D64
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40235281418
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 17:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA73416419;
	Mon,  7 Aug 2023 17:57:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B251640B
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 17:57:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEDDC4339A;
	Mon,  7 Aug 2023 17:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691431020;
	bh=c5I5aeGfx66mzk91H5KgILUV4waE2HEAOTz6mFfv6wY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fuVwhyErEJCn6XqIHQ90cSOQCMyLvdOB8rI5StUSmtq+8bSkrO121EWu0OeCd1VcS
	 SadQ7ceIV92UjJwTwY7F+4xtRZNBtWbona5EZpzpgWNwhigYlA0/fmXqsSAX0Zk/31
	 GF37slrF2S/RFoFtFrBQKIl4Mbntm0XndjT/J+UylHL1n/h207xoSOYYJR1knyPbUy
	 wOCR0cLi5ILegTFV+j/V7asbd9TCfhxFDa0Ne8s+zbkHySwAlGJQlTugdabpusHJoj
	 2xUzjiKY5IdqmnodX/rF5HbZ1y1z8zJKvfLpSiudFVLGIigpfkr59C5sclp2kYJCgo
	 6WeKgX8TBZKFg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	Shay Drory <shayd@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>
Subject: [net-next 07/15] net/mlx5: Introduce mlx5_cpumask_default_spread
Date: Mon,  7 Aug 2023 10:56:34 -0700
Message-ID: <20230807175642.20834-8-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807175642.20834-1-saeed@kernel.org>
References: <20230807175642.20834-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maher Sanalla <msanalla@nvidia.com>

For better code readability in the completion IRQ request code, define
the cpu lookup per completion vector logic in a separate function.

The new method mlx5_cpumask_default_spread() given a vector index 'n'
will return the 'nth' cpu. This new method will be used also in the next
patch.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 41fa15757101..ad654d460d0c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -826,20 +826,18 @@ static void comp_irq_release_pci(struct mlx5_core_dev *dev, u16 vecidx)
 	mlx5_irq_release_vector(irq);
 }
 
-static int comp_irq_request_pci(struct mlx5_core_dev *dev, u16 vecidx)
+static int mlx5_cpumask_default_spread(int numa_node, int index)
 {
-	struct mlx5_eq_table *table = dev->priv.eq_table;
 	const struct cpumask *prev = cpu_none_mask;
 	const struct cpumask *mask;
-	struct mlx5_irq *irq;
 	int found_cpu = 0;
 	int i = 0;
 	int cpu;
 
 	rcu_read_lock();
-	for_each_numa_hop_mask(mask, dev->priv.numa_node) {
+	for_each_numa_hop_mask(mask, numa_node) {
 		for_each_cpu_andnot(cpu, mask, prev) {
-			if (i++ == vecidx) {
+			if (i++ == index) {
 				found_cpu = cpu;
 				goto spread_done;
 			}
@@ -849,7 +847,17 @@ static int comp_irq_request_pci(struct mlx5_core_dev *dev, u16 vecidx)
 
 spread_done:
 	rcu_read_unlock();
-	irq = mlx5_irq_request_vector(dev, found_cpu, vecidx, &table->rmap);
+	return found_cpu;
+}
+
+static int comp_irq_request_pci(struct mlx5_core_dev *dev, u16 vecidx)
+{
+	struct mlx5_eq_table *table = dev->priv.eq_table;
+	struct mlx5_irq *irq;
+	int cpu;
+
+	cpu = mlx5_cpumask_default_spread(dev->priv.numa_node, vecidx);
+	irq = mlx5_irq_request_vector(dev, cpu, vecidx, &table->rmap);
 	if (IS_ERR(irq))
 		return PTR_ERR(irq);
 
-- 
2.41.0


