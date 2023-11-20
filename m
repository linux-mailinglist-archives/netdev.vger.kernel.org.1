Return-Path: <netdev+bounces-49462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC91E7F21C8
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 00:56:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED79F1C20EC7
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 23:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A893B79D;
	Mon, 20 Nov 2023 23:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOIU9e4E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B641B3B2B7
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 23:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B81C433C8;
	Mon, 20 Nov 2023 23:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700524574;
	bh=OceCmHiwxPE+SArvReBo7dFQ9NRi58z0a2tgI+q7DJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WOIU9e4Ek5VOnB2woRPWoku4CJlzFYo9G3Eoyq4KIsSyILvoj1NV4JhWuK2KayTxj
	 J2/d3cp6KBLne2Tpolcd9LW63Z3fYSqWqCt0Ediao1S9+VZMwB8GD7c6AIMLK7AgIR
	 QxQLT5GL9eq2kG+kXrq6IS744MtoM1qYrulQLXgDvU4HrU70fNoty92rjARrUVjp2H
	 SmtaxUezZSVVJxPIlzM0G5kf0O8uPTbbLnxeeWdcZZTcSNDSJmf9g7RpHb8m/M2Knh
	 gM89embav+Meh68RRhi7JWEG+at4Gvh3EhA9TgjDD0LpdSqcnpN9Cqw05xanBXsudD
	 3TW9ymAus6EUQ==
From: Jakub Kicinski <kuba@kernel.org>
To: amritha.nambiar@intel.com
Cc: michael.chan@broadcom.com,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 11/10] eth: bnxt: link NAPI instances to queues and IRQs
Date: Mon, 20 Nov 2023 15:56:11 -0800
Message-ID: <20231120235611.788520-1-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <170018355327.3767.5169918029687620348.stgit@anambiarhost.jf.intel.com>
References: <170018355327.3767.5169918029687620348.stgit@anambiarhost.jf.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make bnxt compatible with the newly added netlink queue GET APIs.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e6ac1bd21bb3..ee4f4fc38bb5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3835,6 +3835,9 @@ static int bnxt_init_one_rx_ring(struct bnxt *bp, int ring_nr)
 	ring = &rxr->rx_ring_struct;
 	bnxt_init_rxbd_pages(ring, type);
 
+	netif_queue_set_napi(bp->dev, ring_nr, NETDEV_QUEUE_TYPE_RX,
+			     &rxr->bnapi->napi);
+
 	if (BNXT_RX_PAGE_MODE(bp) && bp->xdp_prog) {
 		bpf_prog_add(bp->xdp_prog, 1);
 		rxr->xdp_prog = bp->xdp_prog;
@@ -3911,6 +3914,9 @@ static int bnxt_init_tx_rings(struct bnxt *bp)
 		struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
 
 		ring->fw_ring_id = INVALID_HW_RING_ID;
+
+		netif_queue_set_napi(bp->dev, i, NETDEV_QUEUE_TYPE_TX,
+				     &txr->bnapi->napi);
 	}
 
 	return 0;
@@ -9536,6 +9542,7 @@ static int bnxt_request_irq(struct bnxt *bp)
 		if (rc)
 			break;
 
+		netif_napi_set_irq(&bp->bnapi[i]->napi, irq->vector);
 		irq->requested = 1;
 
 		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
@@ -9563,6 +9570,11 @@ static void bnxt_del_napi(struct bnxt *bp)
 	if (!bp->bnapi)
 		return;
 
+	for (i = 0; i < bp->rx_nr_rings; i++)
+		netif_queue_set_napi(bp->dev, i, NETDEV_QUEUE_TYPE_RX, NULL);
+	for (i = 0; i < bp->tx_nr_rings; i++)
+		netif_queue_set_napi(bp->dev, i, NETDEV_QUEUE_TYPE_TX, NULL);
+
 	for (i = 0; i < bp->cp_nr_rings; i++) {
 		struct bnxt_napi *bnapi = bp->bnapi[i];
 
-- 
2.42.0


