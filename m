Return-Path: <netdev+bounces-53150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5F080175D
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 00:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA499281FF8
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 23:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ADE3F8F2;
	Fri,  1 Dec 2023 23:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VGt0X57+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E651A6
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 15:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701472375; x=1733008375;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OjOn2S+sJIYD2bJY+tprLf0vpPzBDvB4TqiQeOPakBg=;
  b=VGt0X57+dXd9dLPJUWoBO03L4D80/DlmqsFTwEOx1vE3JAyeROtgkdGZ
   hXthMZ+iNhRE83e1D/4ZbkdDCdZdIaiJnlc1MzfzIi/st2+iCQKObGa7e
   czelLGWg01/DXUAKIZDLyoljBzNTpS8CM2TeNY0G3Vm2oZyBfIasvdPbk
   NL8jX8rzDG4mPqizNkyH8mtxjayO4YExpNt9m8sU0DiKFJe/3W3FcAptf
   0aoWc0RbjprmT4WS9m8DS7bYInn4jSnd478bAwYpDUcizx8IftktS4wUT
   o9O8M1PRb1R2ITPcMAJ1dxh0iaFgE3Em2jxFuFwAfth69Ynt2R/OCIMJH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="458542"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="458542"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 15:12:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="943228678"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="943228678"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga005.jf.intel.com with ESMTP; 01 Dec 2023 15:12:54 -0800
Subject: [net-next PATCH v11 11/11] eth: bnxt: link NAPI instances to queues
 and IRQs
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: edumazet@google.com, ast@kernel.org, sdf@google.com, lorenzo@kernel.org,
 tariqt@nvidia.com, daniel@iogearbox.net, anthony.l.nguyen@intel.com,
 lucien.xin@gmail.com, michael.chan@broadcom.com, hawk@kernel.org,
 sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Fri, 01 Dec 2023 15:29:23 -0800
Message-ID: <170147336340.5260.6773000274196548907.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <170147307026.5260.9300080745237900261.stgit@anambiarhost.jf.intel.com>
References: <170147307026.5260.9300080745237900261.stgit@anambiarhost.jf.intel.com>
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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e35e7e02538c..a0035147ef94 100644
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
@@ -3921,6 +3924,11 @@ static int bnxt_init_tx_rings(struct bnxt *bp)
 		struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
 
 		ring->fw_ring_id = INVALID_HW_RING_ID;
+
+		if (i >= bp->tx_nr_rings_xdp)
+			netif_queue_set_napi(bp->dev, i - bp->tx_nr_rings_xdp,
+					     NETDEV_QUEUE_TYPE_TX,
+					     &txr->bnapi->napi);
 	}
 
 	return 0;
@@ -9754,6 +9762,7 @@ static int bnxt_request_irq(struct bnxt *bp)
 		if (rc)
 			break;
 
+		netif_napi_set_irq(&bp->bnapi[i]->napi, irq->vector);
 		irq->requested = 1;
 
 		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
@@ -9781,6 +9790,11 @@ static void bnxt_del_napi(struct bnxt *bp)
 	if (!bp->bnapi)
 		return;
 
+	for (i = 0; i < bp->rx_nr_rings; i++)
+		netif_queue_set_napi(bp->dev, i, NETDEV_QUEUE_TYPE_RX, NULL);
+	for (i = 0; i < bp->tx_nr_rings - bp->tx_nr_rings_xdp; i++)
+		netif_queue_set_napi(bp->dev, i, NETDEV_QUEUE_TYPE_TX, NULL);
+
 	for (i = 0; i < bp->cp_nr_rings; i++) {
 		struct bnxt_napi *bnapi = bp->bnapi[i];
 


