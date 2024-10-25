Return-Path: <netdev+bounces-138921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA0C9AF6A4
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 03:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EFFE282299
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 01:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DC313C807;
	Fri, 25 Oct 2024 01:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZWmymXM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0570838DC7;
	Fri, 25 Oct 2024 01:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729819264; cv=none; b=iWhET678/w1le9UzHT2D5QFeCBQS+NJ8EEzbtbtn8EJD3MEJhdr2G3mT5Le4bOOTmFEh7JhpiVwIAuUC3oEgbn4GRdOH9IrOpNN9OkRzccKWscoOIqzwgb956h+Imh3zHi33AYWAstEQsG3f5ekHA4ipK0BexmvGY0JEDIAyhAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729819264; c=relaxed/simple;
	bh=yrqbiZFhn51WEomiKGvcXRetuIKBXye22S0xMCc0lk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OPOGenGz4FdhEPB4uNFiiU1aegw3e57Z3e/jc7L86k89EsVrS46foT7ggRSLxS+kmetWv2/sj7YZql/cRFKCKetvApcdJGKz/EKKwQVteewP7oqn/M5V5C7wOQDeVfB+ML4ISASSGul+wX1zYGCo3XaUHddPxlEpcU2irqUOkHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZWmymXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC4EAC4CEEE;
	Fri, 25 Oct 2024 01:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729819263;
	bh=yrqbiZFhn51WEomiKGvcXRetuIKBXye22S0xMCc0lk8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gZWmymXMSOEezRJ3VCSJ5GujLLHsG8QGBXR2s9v0D36kt3mNNIdsKOiiXajdA45P2
	 2A+0/7w7/1gLMPjTZvHEQJlK4+WCjc8CaIg1zaoMgcF5he8BLI7tRt9iBSZ6S7Dp4a
	 oRQ/50gYTiy6rF4w36d2rUT6qCrl7Yg1+ydMhkqEd0+xo9B4j/Clqa7V0qbnefXnJM
	 7xOtBkEAYIPVrEeKdunGDv0CzvrEBl4EgGjXWTCoCo7brVjExZPc4vzK6xfV+vifK9
	 M9BucIao793uZFeAzNBrblwA4qoCb2mWTWTDV/ZFRklXpKPyY6xBGHA8trOp4SK3km
	 HD06jMv2wfIOg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3333D10399;
	Fri, 25 Oct 2024 01:21:03 +0000 (UTC)
From: Nelson Escobar via B4 Relay <devnull+neescoba.cisco.com@kernel.org>
Date: Thu, 24 Oct 2024 18:19:47 -0700
Subject: [PATCH net-next v2 5/5] enic: Adjust used MSI-X wq/rq/cq/interrupt
 resources in a more robust way
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-remove_vic_resource_limits-v2-5-039b8cae5fdd@cisco.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729819262; l=8413;
 i=neescoba@cisco.com; s=20241023; h=from:subject:message-id;
 bh=GXz0cT0Pl6EsGEqJO9PYLd3Kcxc4wzzJoA1tyJnCrJs=;
 b=QxcOUUMNugJ/vWYyjm3BtWGcEwdjRnFb0lASNna1zPMDnDrG6xJP9t8l3AmMX2/elHC9Fte40
 LTZF12OyF+oCSQIkIRNHiZRrBeAt6rcv7IbFLmwPExbYnIQt6rFOmxg
X-Developer-Key: i=neescoba@cisco.com; a=ed25519;
 pk=bLqWB7VU0KFoVybF4LVB4c2Redvnplt7+5zLHf4KwZM=
X-Endpoint-Received: by B4 Relay for neescoba@cisco.com/20241023 with
 auth_id=255
X-Original-From: Nelson Escobar <neescoba@cisco.com>
Reply-To: neescoba@cisco.com

From: Nelson Escobar <neescoba@cisco.com>

Instead of erroring out on probe if the resources are not configured
exactly right in hardware, try to make due with the resources we do have.

To accomplish this do the following:
- Make enic_set_intr_mode() only set up interrupt related stuff.
- Move resource adjustment out of enic_set_intr_mode() into its own
  function, and basing the resources used on the most constrained
  resource.
- Move the kdump resources limitations into the new function too.

Co-developed-by: John Daley <johndale@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Co-developed-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 197 ++++++++++++++--------------
 1 file changed, 96 insertions(+), 101 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 564202e81a711a6791bef7e848627f0a439cc6f3..fb979c19a1785ace633c51e47de391cf4a4640b3 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -2440,113 +2440,120 @@ static void enic_tx_hang_reset(struct work_struct *work)
 	rtnl_unlock();
 }
 
-static int enic_set_intr_mode(struct enic *enic)
+static int enic_adjust_resources(struct enic *enic)
 {
-	unsigned int n = min_t(unsigned int, enic->rq_count, ENIC_RQ_MAX);
-	unsigned int m = min_t(unsigned int, enic->wq_count, ENIC_WQ_MAX);
-	unsigned int i;
+	unsigned int max_queues;
+	unsigned int rq_avail;
+	unsigned int wq_avail;
 
-	/* Set interrupt mode (INTx, MSI, MSI-X) depending
-	 * on system capabilities.
-	 *
-	 * Try MSI-X first
-	 *
-	 * We need n RQs, m WQs, n+m CQs, and n+m+2 INTRs
-	 * (the second to last INTR is used for WQ/RQ errors)
-	 * (the last INTR is used for notifications)
-	 */
+	if (enic->rq_avail < 1 || enic->wq_avail < 1 || enic->cq_avail < 2) {
+		dev_err(enic_get_dev(enic),
+			"Not enough resources available rq: %d wq: %d cq: %d\n",
+			enic->rq_avail, enic->wq_avail,
+			enic->cq_avail);
+		return -ENOSPC;
+	}
 
-	for (i = 0; i < enic->intr_avail; i++)
-		enic->msix_entry[i].entry = i;
+	if (is_kdump_kernel()) {
+		dev_info(enic_get_dev(enic), "Running from within kdump kernel. Using minimal resources\n");
+		enic->rq_avail = 1;
+		enic->wq_avail = 1;
+		enic->config.rq_desc_count = ENIC_MIN_RQ_DESCS;
+		enic->config.wq_desc_count = ENIC_MIN_WQ_DESCS;
+		enic->config.mtu = min_t(u16, 1500, enic->config.mtu);
+	}
 
-	/* Use multiple RQs if RSS is enabled
-	 */
+	/* if RSS isn't set, then we can only use one RQ */
+	if (!ENIC_SETTING(enic, RSS))
+		enic->rq_avail = 1;
 
-	if (ENIC_SETTING(enic, RSS) &&
-	    enic->config.intr_mode < 1 &&
-	    enic->rq_count >= n &&
-	    enic->wq_count >= m &&
-	    enic->cq_count >= n + m &&
-	    enic->intr_count >= n + m + 2) {
+	switch (vnic_dev_get_intr_mode(enic->vdev)) {
+	case VNIC_DEV_INTR_MODE_INTX:
+	case VNIC_DEV_INTR_MODE_MSI:
+		enic->rq_count = 1;
+		enic->wq_count = 1;
+		enic->cq_count = 2;
+		enic->intr_count = enic->intr_avail;
+		break;
+	case VNIC_DEV_INTR_MODE_MSIX:
+		/* Adjust the number of wqs/rqs/cqs/interrupts that will be
+		 * used based on which resource is the most constrained
+		 */
+		wq_avail = min(enic->wq_avail, ENIC_WQ_MAX);
+		rq_avail = min(enic->rq_avail, ENIC_RQ_MAX);
+		max_queues = min(enic->cq_avail,
+				 enic->intr_avail - ENIC_MSIX_RESERVED_INTR);
+		if (wq_avail + rq_avail <= max_queues) {
+			/* we have enough cq and interrupt resources to cover
+			 *  the number of wqs and rqs
+			 */
+			enic->rq_count = rq_avail;
+			enic->wq_count = wq_avail;
+		} else {
+			/* recalculate wq/rq count */
+			if (rq_avail < wq_avail) {
+				enic->rq_count = min(rq_avail, max_queues / 2);
+				enic->wq_count = max_queues - enic->rq_count;
+			} else {
+				enic->wq_count = min(wq_avail, max_queues / 2);
+				enic->rq_count = max_queues - enic->wq_count;
+			}
+		}
+		enic->cq_count = enic->rq_count + enic->wq_count;
+		enic->intr_count = enic->cq_count + ENIC_MSIX_RESERVED_INTR;
 
-		if (pci_enable_msix_range(enic->pdev, enic->msix_entry,
-					  n + m + 2, n + m + 2) > 0) {
+		break;
+	default:
+		dev_err(enic_get_dev(enic), "Unknown interrupt mode\n");
+		return -EINVAL;
+	}
 
-			enic->rq_count = n;
-			enic->wq_count = m;
-			enic->cq_count = n + m;
-			enic->intr_count = n + m + 2;
+	return 0;
+}
 
-			vnic_dev_set_intr_mode(enic->vdev,
-				VNIC_DEV_INTR_MODE_MSIX);
+static int enic_set_intr_mode(struct enic *enic)
+{
+	unsigned int i;
+	int num_intr;
 
-			return 0;
-		}
-	}
+	/* Set interrupt mode (INTx, MSI, MSI-X) depending
+	 * on system capabilities.
+	 *
+	 * Try MSI-X first
+	 */
 
 	if (enic->config.intr_mode < 1 &&
-	    enic->rq_count >= 1 &&
-	    enic->wq_count >= m &&
-	    enic->cq_count >= 1 + m &&
-	    enic->intr_count >= 1 + m + 2) {
-		if (pci_enable_msix_range(enic->pdev, enic->msix_entry,
-					  1 + m + 2, 1 + m + 2) > 0) {
-
-			enic->rq_count = 1;
-			enic->wq_count = m;
-			enic->cq_count = 1 + m;
-			enic->intr_count = 1 + m + 2;
-
+	    enic->intr_avail >= ENIC_MSIX_MIN_INTR) {
+		for (i = 0; i < enic->intr_avail; i++)
+			enic->msix_entry[i].entry = i;
+
+		num_intr = pci_enable_msix_range(enic->pdev, enic->msix_entry,
+						 ENIC_MSIX_MIN_INTR,
+						 enic->intr_avail);
+		if (num_intr > 0) {
 			vnic_dev_set_intr_mode(enic->vdev,
-				VNIC_DEV_INTR_MODE_MSIX);
-
+					       VNIC_DEV_INTR_MODE_MSIX);
+			enic->intr_avail = num_intr;
 			return 0;
 		}
 	}
 
-	/* Next try MSI
-	 *
-	 * We need 1 RQ, 1 WQ, 2 CQs, and 1 INTR
-	 */
+	/* Next try MSI */
 
 	if (enic->config.intr_mode < 2 &&
-	    enic->rq_count >= 1 &&
-	    enic->wq_count >= 1 &&
-	    enic->cq_count >= 2 &&
-	    enic->intr_count >= 1 &&
+	    enic->intr_avail >= 1 &&
 	    !pci_enable_msi(enic->pdev)) {
-
-		enic->rq_count = 1;
-		enic->wq_count = 1;
-		enic->cq_count = 2;
-		enic->intr_count = 1;
-
+		enic->intr_avail = 1;
 		vnic_dev_set_intr_mode(enic->vdev, VNIC_DEV_INTR_MODE_MSI);
-
 		return 0;
 	}
 
-	/* Next try INTx
-	 *
-	 * We need 1 RQ, 1 WQ, 2 CQs, and 3 INTRs
-	 * (the first INTR is used for WQ/RQ)
-	 * (the second INTR is used for WQ/RQ errors)
-	 * (the last INTR is used for notifications)
-	 */
+	/* Next try INTx */
 
 	if (enic->config.intr_mode < 3 &&
-	    enic->rq_count >= 1 &&
-	    enic->wq_count >= 1 &&
-	    enic->cq_count >= 2 &&
-	    enic->intr_count >= 3) {
-
-		enic->rq_count = 1;
-		enic->wq_count = 1;
-		enic->cq_count = 2;
-		enic->intr_count = 3;
-
+	    enic->intr_avail >= 3) {
+		enic->intr_avail = 3;
 		vnic_dev_set_intr_mode(enic->vdev, VNIC_DEV_INTR_MODE_INTX);
-
 		return 0;
 	}
 
@@ -2758,18 +2765,6 @@ static void enic_dev_deinit(struct enic *enic)
 	enic_free_enic_resources(enic);
 }
 
-static void enic_kdump_kernel_config(struct enic *enic)
-{
-	if (is_kdump_kernel()) {
-		dev_info(enic_get_dev(enic), "Running from within kdump kernel. Using minimal resources\n");
-		enic->rq_count = 1;
-		enic->wq_count = 1;
-		enic->config.rq_desc_count = ENIC_MIN_RQ_DESCS;
-		enic->config.wq_desc_count = ENIC_MIN_WQ_DESCS;
-		enic->config.mtu = min_t(u16, 1500, enic->config.mtu);
-	}
-}
-
 static int enic_dev_init(struct enic *enic)
 {
 	struct device *dev = enic_get_dev(enic);
@@ -2805,14 +2800,7 @@ static int enic_dev_init(struct enic *enic)
 		return err;
 	}
 
-	/* modify resource count if we are in kdump_kernel
-	 */
-	enic_kdump_kernel_config(enic);
-
-	/* Set interrupt mode based on resource counts and system
-	 * capabilities
-	 */
-
+	/* Set interrupt mode based on system capabilities */
 	err = enic_set_intr_mode(enic);
 	if (err) {
 		dev_err(dev, "Failed to set intr mode based on resource "
@@ -2820,6 +2808,13 @@ static int enic_dev_init(struct enic *enic)
 		goto err_out_free_vnic_resources;
 	}
 
+	/* Adjust resource counts based on most constrained resources */
+	err = enic_adjust_resources(enic);
+	if (err) {
+		dev_err(dev, "Failed to adjust resources\n");
+		goto err_out_free_vnic_resources;
+	}
+
 	/* Allocate and configure vNIC resources
 	 */
 

-- 
2.47.0



