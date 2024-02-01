Return-Path: <netdev+bounces-68070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A3A845BE2
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 16:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FEC0288AB8
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 15:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35CC15B110;
	Thu,  1 Feb 2024 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kYhCLqv0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131E7626AF
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802148; cv=none; b=GmkU1h85cUoTY76sjp/1xalUtnj4fnZ4cF1LkiVodJ1qt6GJYXJdWpaCwk3CgveK31g1+Pe4alDzWywMnY9UEoQ5VlNvqhPjvlILix8zeY/aD3Sa8NL6JGI3bHe+BDqfQUVu/m0tMAnVyHrv/tZo++xG9uDs9h+Ll0eli3s6CvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802148; c=relaxed/simple;
	bh=DhQJw42Fy/VWG9VGKz5dX7ahzhubPG0WXkmbdhwwXs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d4ItXq/+xFFpMv6ECs8DtblhkYxOFwQrQQv3gK/3tkFMwLk8oVnOcKLds8Mk9Zl7MY843hXOUpU6S66Jzx4FTKNn83fEtpiu9WPWqQ3vbnRbwF12Y+092JmCcGSMNN/SGWuSpBji3SSRP8eAb3iRlApoXXEzuhmlIyXyITEUYc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kYhCLqv0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706802147; x=1738338147;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DhQJw42Fy/VWG9VGKz5dX7ahzhubPG0WXkmbdhwwXs8=;
  b=kYhCLqv0c7cmLY6+HzJkFI+KCTeiIoonc+5kOD2AXlEH5IRGApq6Os4v
   p/wjXsL5/zou3jtcXOgLncZSrxQ4xXnxvaPCwBDVSta1EwHa7obcLKMs2
   1+ommxkMnBpinZ97i8akuURzu28pFJiUJeiTJD+yIjT5X/hwzjiiGQkY+
   Ox5lGb5kHxm8udEsR3sDet/XMZqclhfHxqzYN8iS03gbdaU2ozK14FmA8
   QXLqSg85lFAPrfTAcSPL2AK4IPf/19ivLv1jMyP0XVa/RFVRuwsrYcH9X
   Plv1xuPe27nqCWT0iTX90v2EfePA7Wp92m3+HQ8K+KG7+u1dNQrpo88IJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10551406"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="10551406"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 07:42:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4418170"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa005.fm.intel.com with ESMTP; 01 Feb 2024 07:42:25 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH iwl-net 1/2] i40e: avoid double calling i40e_pf_rxq_wait()
Date: Thu,  1 Feb 2024 16:42:18 +0100
Message-Id: <20240201154219.607338-2-maciej.fijalkowski@intel.com>
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

Currently, when interface is being brought down and
i40e_vsi_stop_rings() is called, i40e_pf_rxq_wait() is called two times,
which is wrong. To showcase this scenario, simplified call stack looks
as follows:

i40e_vsi_stop_rings()
	i40e_control wait rx_q()
		i40e_control_rx_q()
		i40e_pf_rxq_wait()
	i40e_vsi_wait_queues_disabled()
		i40e_pf_rxq_wait()  // redundant call

To fix this, let us s/i40e_control_wait_rx_q/i40e_control_rx_q within
i40e_vsi_stop_rings().

Fixes: 65662a8dcdd0 ("i40e: Fix logic of disabling queues")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 6e7fd473abfd..2c46a5e7d222 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4926,7 +4926,7 @@ int i40e_vsi_start_rings(struct i40e_vsi *vsi)
 void i40e_vsi_stop_rings(struct i40e_vsi *vsi)
 {
 	struct i40e_pf *pf = vsi->back;
-	int pf_q, err, q_end;
+	int pf_q, q_end;
 
 	/* When port TX is suspended, don't wait */
 	if (test_bit(__I40E_PORT_SUSPENDED, vsi->back->state))
@@ -4936,16 +4936,10 @@ void i40e_vsi_stop_rings(struct i40e_vsi *vsi)
 	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++)
 		i40e_pre_tx_queue_cfg(&pf->hw, (u32)pf_q, false);
 
-	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++) {
-		err = i40e_control_wait_rx_q(pf, pf_q, false);
-		if (err)
-			dev_info(&pf->pdev->dev,
-				 "VSI seid %d Rx ring %d disable timeout\n",
-				 vsi->seid, pf_q);
-	}
+	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++)
+		i40e_control_rx_q(pf, pf_q, false);
 
 	msleep(I40E_DISABLE_TX_GAP_MSEC);
-	pf_q = vsi->base_queue;
 	for (pf_q = vsi->base_queue; pf_q < q_end; pf_q++)
 		wr32(&pf->hw, I40E_QTX_ENA(pf_q), 0);
 
-- 
2.34.1


