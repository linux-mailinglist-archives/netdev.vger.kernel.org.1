Return-Path: <netdev+bounces-138920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087E29AF69E
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 03:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349B21C210DB
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 01:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1A23D3B3;
	Fri, 25 Oct 2024 01:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1+m5X6n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02610374EA;
	Fri, 25 Oct 2024 01:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729819264; cv=none; b=X5wnOGDdZS+l1bD6maV+p/gAgCj2vhAA4IbP53mB9V7ytywH2SM/ybtpGP/vu6ZF8nrr9jFNHZ8HSqA9wFzkeaAHjg3zJjyKeBiiY2d83QwnSWWoGSnWqT5b1AnfcB/U7GkakxwSv4FZKLB1MzYn76hink0lTHbQ7MPM/9I6mo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729819264; c=relaxed/simple;
	bh=8pGJyl7/4GEPFa5wTS2h/jPW/fXnWw+Jz710+1/Uxz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jI7HPIYll2Fc98M28FzcGL2RFgDE1jWgG63Wyv9i3wdPrJToRLRYiHOzNz1Xv/bZcpSZ0Qdghs5/uIEa6tZ7Ou0kes0gmTJr37vDbyvxjV50dn7ybS2HIykuvv8F1bk+HjuXI9ODl7XpTrZZZd/Z/rklpIn0lQgqgFBFW6OuI/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1+m5X6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AC7FC4CEEA;
	Fri, 25 Oct 2024 01:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729819263;
	bh=8pGJyl7/4GEPFa5wTS2h/jPW/fXnWw+Jz710+1/Uxz8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=V1+m5X6nJOUm/bk1jt5sFxQFAF6C4aJaa39SWpyadxUxeTnxIeJ1vnslbcPxQdUbM
	 LyIkGrcOERZK4H2YG3DOe7LaJiWWqUiZgsyLv+by0tnWnreyfOU69THv/mTGqgp/2n
	 wnwo2pktx15YpfZtBxhRAfr8lhFOt6Z0qxGU2T3+WF70K/PU/G9Xk2/n6DWOVfEbOZ
	 DENSJElHUm1AfPeBEcNFZG7ajIDcRbf/yP1twgK50GvKWsIpufLv5nOGd/wE+jrHWj
	 YwkArSUCKlgQOzjoAVAF8jTK1AX9D/traahKuquo7hIM4taaDl3lMt/tApwLVl1Okm
	 EwoKCsbkxy+Eg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92719D1039C;
	Fri, 25 Oct 2024 01:21:03 +0000 (UTC)
From: Nelson Escobar via B4 Relay <devnull+neescoba.cisco.com@kernel.org>
Date: Thu, 24 Oct 2024 18:19:46 -0700
Subject: [PATCH net-next v2 4/5] enic: Allocate arrays in enic struct based
 on VIC config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-remove_vic_resource_limits-v2-4-039b8cae5fdd@cisco.com>
References: <20241024-remove_vic_resource_limits-v2-0-039b8cae5fdd@cisco.com>
In-Reply-To: <20241024-remove_vic_resource_limits-v2-0-039b8cae5fdd@cisco.com>
To: John Daley <johndale@cisco.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Christian Benvenuti <benve@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nelson Escobar <neescoba@cisco.com>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729819262; l=7119;
 i=neescoba@cisco.com; s=20241023; h=from:subject:message-id;
 bh=IWtPdjwW96BGMVFaLSU5zTZVelFtFaglWGXDyqhKmd8=;
 b=8L2MxBLPmvqSoDVbiEhz+M07/tyRQLkqXqFHa7xcJg9pZ2pBvTQAtdn1XnzAUbnGYxPyo3oXf
 Ogffm2q02QYB9a7obwVD13Y/fDBIhx+wAwH+nWKKs0OMwAT2cugQ8Fp
X-Developer-Key: i=neescoba@cisco.com; a=ed25519;
 pk=bLqWB7VU0KFoVybF4LVB4c2Redvnplt7+5zLHf4KwZM=
X-Endpoint-Received: by B4 Relay for neescoba@cisco.com/20241023 with
 auth_id=255
X-Original-From: Nelson Escobar <neescoba@cisco.com>
Reply-To: neescoba@cisco.com

From: Nelson Escobar <neescoba@cisco.com>

Allocate wq, rq, cq, intr, and napi arrays based on the number of
resources configured in the VIC.

Co-developed-by: John Daley <johndale@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/cisco/enic/enic.h      | 24 ++++-----
 drivers/net/ethernet/cisco/enic/enic_main.c | 84 ++++++++++++++++++++++++++---
 2 files changed, 87 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic.h b/drivers/net/ethernet/cisco/enic/enic.h
index 1f32413a8f7c690060fe385b50f7447943e72596..cfb4667953de2c578911aad138a1d392fa9d3bdc 100644
--- a/drivers/net/ethernet/cisco/enic/enic.h
+++ b/drivers/net/ethernet/cisco/enic/enic.h
@@ -23,10 +23,8 @@
 
 #define ENIC_BARS_MAX		6
 
-#define ENIC_WQ_MAX		8
-#define ENIC_RQ_MAX		8
-#define ENIC_CQ_MAX		(ENIC_WQ_MAX + ENIC_RQ_MAX)
-#define ENIC_INTR_MAX		(ENIC_CQ_MAX + 2)
+#define ENIC_WQ_MAX		256
+#define ENIC_RQ_MAX		256
 
 #define ENIC_WQ_NAPI_BUDGET	256
 
@@ -184,8 +182,8 @@ struct enic {
 	struct work_struct reset;
 	struct work_struct tx_hang_reset;
 	struct work_struct change_mtu_work;
-	struct msix_entry msix_entry[ENIC_INTR_MAX];
-	struct enic_msix_entry msix[ENIC_INTR_MAX];
+	struct msix_entry *msix_entry;
+	struct enic_msix_entry *msix;
 	u32 msg_enable;
 	spinlock_t devcmd_lock;
 	u8 mac_addr[ETH_ALEN];
@@ -204,28 +202,24 @@ struct enic {
 	bool enic_api_busy;
 	struct enic_port_profile *pp;
 
-	/* work queue cache line section */
-	____cacheline_aligned struct enic_wq wq[ENIC_WQ_MAX];
+	struct enic_wq *wq;
 	unsigned int wq_avail;
 	unsigned int wq_count;
 	u16 loop_enable;
 	u16 loop_tag;
 
-	/* receive queue cache line section */
-	____cacheline_aligned struct enic_rq rq[ENIC_RQ_MAX];
+	struct enic_rq *rq;
 	unsigned int rq_avail;
 	unsigned int rq_count;
 	struct vxlan_offload vxlan;
-	struct napi_struct napi[ENIC_RQ_MAX + ENIC_WQ_MAX];
+	struct napi_struct *napi;
 
-	/* interrupt resource cache line section */
-	____cacheline_aligned struct vnic_intr intr[ENIC_INTR_MAX];
+	struct vnic_intr *intr;
 	unsigned int intr_avail;
 	unsigned int intr_count;
 	u32 __iomem *legacy_pba;		/* memory-mapped */
 
-	/* completion queue cache line section */
-	____cacheline_aligned struct vnic_cq cq[ENIC_CQ_MAX];
+	struct vnic_cq *cq;
 	unsigned int cq_avail;
 	unsigned int cq_count;
 	struct enic_rfs_flw_tbl rfs_h;
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index eb00058b6c68ec5c1ac433b54b5bc6f3fb613777..564202e81a711a6791bef7e848627f0a439cc6f3 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -940,7 +940,7 @@ static void enic_get_stats(struct net_device *netdev,
 	net_stats->rx_errors = stats->rx.rx_errors;
 	net_stats->multicast = stats->rx.rx_multicast_frames_ok;
 
-	for (i = 0; i < ENIC_RQ_MAX; i++) {
+	for (i = 0; i < enic->rq_count; i++) {
 		struct enic_rq_stats *rqs = &enic->rq[i].stats;
 
 		if (!enic->rq[i].vrq.ctrl)
@@ -1792,7 +1792,7 @@ static void enic_free_intr(struct enic *enic)
 		free_irq(enic->pdev->irq, enic);
 		break;
 	case VNIC_DEV_INTR_MODE_MSIX:
-		for (i = 0; i < ARRAY_SIZE(enic->msix); i++)
+		for (i = 0; i < enic->intr_count; i++)
 			if (enic->msix[i].requested)
 				free_irq(enic->msix_entry[i].vector,
 					enic->msix[i].devid);
@@ -1859,7 +1859,7 @@ static int enic_request_intr(struct enic *enic)
 		enic->msix[intr].isr = enic_isr_msix_notify;
 		enic->msix[intr].devid = enic;
 
-		for (i = 0; i < ARRAY_SIZE(enic->msix); i++)
+		for (i = 0; i < enic->intr_count; i++)
 			enic->msix[i].requested = 0;
 
 		for (i = 0; i < enic->intr_count; i++) {
@@ -2456,8 +2456,7 @@ static int enic_set_intr_mode(struct enic *enic)
 	 * (the last INTR is used for notifications)
 	 */
 
-	BUG_ON(ARRAY_SIZE(enic->msix_entry) < n + m + 2);
-	for (i = 0; i < n + m + 2; i++)
+	for (i = 0; i < enic->intr_avail; i++)
 		enic->msix_entry[i].entry = i;
 
 	/* Use multiple RQs if RSS is enabled
@@ -2674,6 +2673,71 @@ static const struct netdev_stat_ops enic_netdev_stat_ops = {
 	.get_base_stats		= enic_get_base_stats,
 };
 
+static void enic_free_enic_resources(struct enic *enic)
+{
+	kfree(enic->wq);
+	enic->wq = NULL;
+
+	kfree(enic->rq);
+	enic->rq = NULL;
+
+	kfree(enic->cq);
+	enic->cq = NULL;
+
+	kfree(enic->napi);
+	enic->napi = NULL;
+
+	kfree(enic->msix_entry);
+	enic->msix_entry = NULL;
+
+	kfree(enic->msix);
+	enic->msix = NULL;
+
+	kfree(enic->intr);
+	enic->intr = NULL;
+}
+
+static int enic_alloc_enic_resources(struct enic *enic)
+{
+	enic->wq = kcalloc(enic->wq_avail, sizeof(struct enic_wq), GFP_KERNEL);
+	if (!enic->wq)
+		goto free_queues;
+
+	enic->rq = kcalloc(enic->rq_avail, sizeof(struct enic_rq), GFP_KERNEL);
+	if (!enic->rq)
+		goto free_queues;
+
+	enic->cq = kcalloc(enic->cq_avail, sizeof(struct vnic_cq), GFP_KERNEL);
+	if (!enic->cq)
+		goto free_queues;
+
+	enic->napi = kcalloc(enic->wq_avail + enic->rq_avail,
+			     sizeof(struct napi_struct), GFP_KERNEL);
+	if (!enic->napi)
+		goto free_queues;
+
+	enic->msix_entry = kcalloc(enic->intr_avail, sizeof(struct msix_entry),
+				   GFP_KERNEL);
+	if (!enic->msix_entry)
+		goto free_queues;
+
+	enic->msix = kcalloc(enic->intr_avail, sizeof(struct enic_msix_entry),
+			     GFP_KERNEL);
+	if (!enic->msix)
+		goto free_queues;
+
+	enic->intr = kcalloc(enic->intr_avail, sizeof(struct vnic_intr),
+			     GFP_KERNEL);
+	if (!enic->intr)
+		goto free_queues;
+
+	return 0;
+
+free_queues:
+	enic_free_enic_resources(enic);
+	return -ENOMEM;
+}
+
 static void enic_dev_deinit(struct enic *enic)
 {
 	unsigned int i;
@@ -2691,6 +2755,7 @@ static void enic_dev_deinit(struct enic *enic)
 	enic_free_vnic_resources(enic);
 	enic_clear_intr_mode(enic);
 	enic_free_affinity_hint(enic);
+	enic_free_enic_resources(enic);
 }
 
 static void enic_kdump_kernel_config(struct enic *enic)
@@ -2734,6 +2799,12 @@ static int enic_dev_init(struct enic *enic)
 
 	enic_get_res_counts(enic);
 
+	err = enic_alloc_enic_resources(enic);
+	if (err) {
+		dev_err(dev, "Failed to allocate enic resources\n");
+		return err;
+	}
+
 	/* modify resource count if we are in kdump_kernel
 	 */
 	enic_kdump_kernel_config(enic);
@@ -2746,7 +2817,7 @@ static int enic_dev_init(struct enic *enic)
 	if (err) {
 		dev_err(dev, "Failed to set intr mode based on resource "
 			"counts and system capabilities, aborting\n");
-		return err;
+		goto err_out_free_vnic_resources;
 	}
 
 	/* Allocate and configure vNIC resources
@@ -2788,6 +2859,7 @@ static int enic_dev_init(struct enic *enic)
 	enic_free_affinity_hint(enic);
 	enic_clear_intr_mode(enic);
 	enic_free_vnic_resources(enic);
+	enic_free_enic_resources(enic);
 
 	return err;
 }

-- 
2.47.0



