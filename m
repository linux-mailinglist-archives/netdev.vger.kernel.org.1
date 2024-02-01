Return-Path: <netdev+bounces-68071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8222F845BE4
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 374C71F24065
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0413415D5AE;
	Thu,  1 Feb 2024 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PFzQwV1N"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E5315A486
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802149; cv=none; b=ffdxM8XI7dwT+aXi2Kd2KH3TxTenjWg43uOU8gYxCWWZENQEhnLHhBQWGy6n91wCI1dSybAtTAln4WDg2hbotkwsX9Dq4VUSV2OY5JFy0DLGJvO+BqgxTncodrH88vcE/0xvSbLu5MNj3laPkW4fPuBht9YDGisZ0RAiUro6tUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802149; c=relaxed/simple;
	bh=Dx6cdg1qfbKn7eMZxN8RCudXM9RoNC9XZhARuZBs4a4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lMn06zMqoVbz1DComoF7AwJqgrk+EtAJoNSWYSRmD3ga3rZPRB1zgqIKve0+N47rWXVnKjezA7oVIFw+pFe5exYBLDnuZI+isOuBZZ9Xrf2xky1RxvAhKI+VyK20qrZvL7jLA8ALWtMDiNZHOZT8/Y6QX4VJ64dNEOghAcs0SWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PFzQwV1N; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706802148; x=1738338148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dx6cdg1qfbKn7eMZxN8RCudXM9RoNC9XZhARuZBs4a4=;
  b=PFzQwV1NAileIBhEKzjlK2RoVm0yLsmiITzlz5D/S6Sx5YSG2DDVA37o
   MjdSqOf4fltVL4xS5xA5Hi54gEgldm/jTtSy025AH6X8895XNBBKNpuuQ
   vX6f7Yto1ITecNwdUqV5NFWRQQmiZcT2J/usVX4wGhcwZhrtWR3QVat9M
   GlmzCSslg6B8VsAI/z8AZ8wMXea1KpOD1Q6+Xk0vjEXQW7eb3rWy4+O+T
   ADITkdbMBP163ts1qkF7wwZAnAVfokWPB9WCZlSVWBikRPqaOGsSkntc1
   09Cu4KfM3IZlbyQVsFrMpKvZWC8hdyJOKUo8anDbfZDBRYE4fNln8MF8H
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10551416"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="10551416"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 07:42:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4418208"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa005.fm.intel.com with ESMTP; 01 Feb 2024 07:42:27 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Seth Forshee <sforshee@kernel.org>
Subject: [PATCH iwl-net 2/2] i40e: take into account XDP Tx queues when stopping rings
Date: Thu,  1 Feb 2024 16:42:19 +0100
Message-Id: <20240201154219.607338-3-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240201154219.607338-1-maciej.fijalkowski@intel.com>
References: <20240201154219.607338-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Seth reported that on his side XDP traffic can not survive a round of
down/up against i40e interface. Dmesg output was telling us that we were
not able to disable the very first XDP ring. That was due to the fact
that in i40e_vsi_stop_rings() in a pre-work that is done before calling
i40e_vsi_wait_queues_disabled(), XDP Tx queues were not taken into the
account.

To fix this, let us distinguish between Rx and Tx queue boundaries and
take into the account XDP queues for Tx side.

Reported-by: Seth Forshee <sforshee@kernel.org>
Closes: https://lore.kernel.org/netdev/ZbkE7Ep1N1Ou17sA@do-x1extreme/
Fixes: 65662a8dcdd0 ("i40e: Fix logic of disabling queues")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 2c46a5e7d222..907be56965f5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4926,21 +4926,22 @@ int i40e_vsi_start_rings(struct i40e_vsi *vsi)
 void i40e_vsi_stop_rings(struct i40e_vsi *vsi)
 {
 	struct i40e_pf *pf = vsi->back;
-	int pf_q, q_end;
+	u32 pf_q, tx_q_end, rx_q_end;
 
 	/* When port TX is suspended, don't wait */
 	if (test_bit(__I40E_PORT_SUSPENDED, vsi->back->state))
 		return i40e_vsi_stop_rings_no_wait(vsi);
 
-	q_end = vsi->base_queue + vsi->num_queue_pairs;
-	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++)
-		i40e_pre_tx_queue_cfg(&pf->hw, (u32)pf_q, false);
+	tx_q_end = vsi->alloc_queue_pairs * (i40e_enabled_xdp_vsi(vsi) ? 2 : 1);
+	for (pf_q = vsi->base_queue; pf_q < tx_q_end; pf_q++)
+		i40e_pre_tx_queue_cfg(&pf->hw, pf_q, false);
 
-	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++)
+	rx_q_end = vsi->base_queue + vsi->num_queue_pairs;
+	for (pf_q = vsi->base_queue; pf_q < rx_q_end; pf_q++)
 		i40e_control_rx_q(pf, pf_q, false);
 
 	msleep(I40E_DISABLE_TX_GAP_MSEC);
-	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++)
+	for (pf_q = vsi->base_queue; pf_q < tx_q_end; pf_q++)
 		wr32(&pf->hw, I40E_QTX_ENA(pf_q), 0);
 
 	i40e_vsi_wait_queues_disabled(vsi);
-- 
2.34.1


