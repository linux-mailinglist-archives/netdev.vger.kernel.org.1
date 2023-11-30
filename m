Return-Path: <netdev+bounces-52332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8D77FE4A4
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 01:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 250C1B20EB0
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 00:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C34D385;
	Thu, 30 Nov 2023 00:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Unrr4me6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D779910C8
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 16:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701303116; x=1732839116;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q4eW1WYARWHK8XmjV06jS3nRLlxtSkMZf4EszkUSn48=;
  b=Unrr4me6jYOp5T18WD3HSMprsF1e26Ov8oxU118r43kp9+/ZdWUbAmGE
   3q1QQ2NtQUOm4YFANl9Bxn4+ZMxtxsXNiy8pVNnQQCed6p7AT6EA5rfDt
   d1wIDIas8XKd5IN4RDd0OauXb1hTSYmlhZmLfNYFR26e7OCrukNnnlJO3
   4m+FRavznPrqa5LwXJXpRQUpXujYIo/NNggwX3ZWquIH1f9uMXTbji8L/
   eC7gSPiFhIR/VxrGa+IY8baObAvCOreyXxIZ27PbveBW5Infoeq8mrJ0P
   lXrq1gL20a5FhuFoHA4o5rUZafA+HuBy9RXCvDAsVGOf/63pkcR6MfGM5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="112148"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="112148"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 16:11:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="839619979"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="839619979"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga004.fm.intel.com with ESMTP; 29 Nov 2023 16:11:56 -0800
Subject: [net-next PATCH v10 11/11] eth: bnxt: link NAPI instances to queues
 and IRQs
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: edumazet@google.com, ast@kernel.org, sdf@google.com, lorenzo@kernel.org,
 tariqt@nvidia.com, daniel@iogearbox.net, anthony.l.nguyen@intel.com,
 lucien.xin@gmail.com, michael.chan@broadcom.com, sridhar.samudrala@intel.com,
 amritha.nambiar@intel.com
Date: Wed, 29 Nov 2023 16:28:24 -0800
Message-ID: <170130410439.5198.5369308046781025813.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <170130378595.5198.158092030504280163.stgit@anambiarhost.jf.intel.com>
References: <170130378595.5198.158092030504280163.stgit@anambiarhost.jf.intel.com>
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
index e35e7e02538c..08793e24e0ee 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3845,6 +3845,9 @@ static int bnxt_init_one_rx_ring(struct bnxt *bp, int ring_nr)
 	ring = &rxr->rx_ring_struct;
 	bnxt_init_rxbd_pages(ring, type);
 
+	netif_queue_set_napi(bp->dev, ring_nr, NETDEV_QUEUE_TYPE_RX,
+			     &rxr->bnapi->napi);
+
 	if (BNXT_RX_PAGE_MODE(bp) && bp->xdp_prog) {
 		bpf_prog_add(bp->xdp_prog, 1);
 		rxr->xdp_prog = bp->xdp_prog;
@@ -3921,6 +3924,9 @@ static int bnxt_init_tx_rings(struct bnxt *bp)
 		struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
 
 		ring->fw_ring_id = INVALID_HW_RING_ID;
+
+		netif_queue_set_napi(bp->dev, i, NETDEV_QUEUE_TYPE_TX,
+				     &txr->bnapi->napi);
 	}
 
 	return 0;
@@ -9754,6 +9760,7 @@ static int bnxt_request_irq(struct bnxt *bp)
 		if (rc)
 			break;
 
+		netif_napi_set_irq(&bp->bnapi[i]->napi, irq->vector);
 		irq->requested = 1;
 
 		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
@@ -9781,6 +9788,11 @@ static void bnxt_del_napi(struct bnxt *bp)
 	if (!bp->bnapi)
 		return;
 
+	for (i = 0; i < bp->rx_nr_rings; i++)
+		netif_queue_set_napi(bp->dev, i, NETDEV_QUEUE_TYPE_RX, NULL);
+	for (i = 0; i < bp->tx_nr_rings; i++)
+		netif_queue_set_napi(bp->dev, i, NETDEV_QUEUE_TYPE_TX, NULL);
+
 	for (i = 0; i < bp->cp_nr_rings; i++) {
 		struct bnxt_napi *bnapi = bp->bnapi[i];
 


