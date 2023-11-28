Return-Path: <netdev+bounces-51552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DC47FB077
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 04:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74D7E1C20E80
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 03:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C352CD27C;
	Tue, 28 Nov 2023 03:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LLM8qoxi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B102187
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 19:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701142439; x=1732678439;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tm/Pv7k+CGVMTO/9/lnC3StjRcbjkb2PkqasXsikYco=;
  b=LLM8qoxi7CFWP0RxiPnIpwF0MniecC1uCG2NTrWxXZEgdjBWeLIT8dtJ
   zPoGcXhFA5QBCVkr6NkqjDwMZuGo5rm4hp4QDcyw2t7TStyTKkdWhPK2q
   CDYN+WsT3VkVyj3xCxmaxfc9SW65t0MwyJcxRdRlDc0CSYPcAujkQYaHn
   xHBn74TUuJg2bUVwfCTlwzkMtlk7Bwo7n5iKUz8NT0gKqVV21GT/X1ucD
   ql4d7gNUtuJ1r+nbF2TEQ4E+YeCKUlW+oqNNjHz02QIW0u+uAU7HLxhrb
   DagPEfmYxHeVpeR98v9L5h8D2c8jfMCeaIlktEtRUCp2qNXY/nVBl7XDL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="6095517"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="6095517"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 19:33:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="9807269"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orviesa002.jf.intel.com with ESMTP; 27 Nov 2023 19:33:59 -0800
Subject: [net-next PATCH v9 11/11] eth: bnxt: link NAPI instances to queues
 and IRQs
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 27 Nov 2023 19:50:25 -0800
Message-ID: <170114342527.10303.5470997598126666835.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <170114286635.10303.8773144948795839629.stgit@anambiarhost.jf.intel.com>
References: <170114286635.10303.8773144948795839629.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Jakub Kicinski <kuba@kernel.org>

Make bnxt compatible with the newly added netlink queue GET APIs.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d8cf7b30bd03..0852ea191c15 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3844,6 +3844,9 @@ static int bnxt_init_one_rx_ring(struct bnxt *bp, int ring_nr)
 	ring = &rxr->rx_ring_struct;
 	bnxt_init_rxbd_pages(ring, type);
 
+	netif_queue_set_napi(bp->dev, ring_nr, NETDEV_QUEUE_TYPE_RX,
+			     &rxr->bnapi->napi);
+
 	if (BNXT_RX_PAGE_MODE(bp) && bp->xdp_prog) {
 		bpf_prog_add(bp->xdp_prog, 1);
 		rxr->xdp_prog = bp->xdp_prog;
@@ -3920,6 +3923,9 @@ static int bnxt_init_tx_rings(struct bnxt *bp)
 		struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
 
 		ring->fw_ring_id = INVALID_HW_RING_ID;
+
+		netif_queue_set_napi(bp->dev, i, NETDEV_QUEUE_TYPE_TX,
+				     &txr->bnapi->napi);
 	}
 
 	return 0;
@@ -9753,6 +9759,7 @@ static int bnxt_request_irq(struct bnxt *bp)
 		if (rc)
 			break;
 
+		netif_napi_set_irq(&bp->bnapi[i]->napi, irq->vector);
 		irq->requested = 1;
 
 		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
@@ -9780,6 +9787,11 @@ static void bnxt_del_napi(struct bnxt *bp)
 	if (!bp->bnapi)
 		return;
 
+	for (i = 0; i < bp->rx_nr_rings; i++)
+		netif_queue_set_napi(bp->dev, i, NETDEV_QUEUE_TYPE_RX, NULL);
+	for (i = 0; i < bp->tx_nr_rings; i++)
+		netif_queue_set_napi(bp->dev, i, NETDEV_QUEUE_TYPE_TX, NULL);
+
 	for (i = 0; i < bp->cp_nr_rings; i++) {
 		struct bnxt_napi *bnapi = bp->bnapi[i];
 


