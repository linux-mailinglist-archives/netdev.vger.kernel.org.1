Return-Path: <netdev+bounces-69460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7CF84B576
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 13:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D11C1C23AC6
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 12:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D5312EBE3;
	Tue,  6 Feb 2024 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oDFVvQVH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC1E487B4
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707223304; cv=none; b=e2OlLswa1OWXV+cgflmXzNIDbVzf3LUnAQG/cbx0OsQwU2BZQKJrCoqOHyBX/l0o5jIAjQQ/4qsbT8DIkjFiDI84vn1deZExwoOVq9KbV8D18dj94WVDcaafp2ImtB3JZNXiD0l6gUytYDpUj55IXajO2LrLUYziSTWiXTWDmKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707223304; c=relaxed/simple;
	bh=qxoLmloFR+9+GhytewaFGvg+IJiae2V+Vk54IVBsmL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jeVvLPA6VSkNV8KxOj4lFtm5S4R/8j5hW1Ml7E1ruJedm3IZUJrUaZS+KeoVvK7cSr1PrgyZLAhDZswwENBSKxa73mc/7O0ZH+rkpEEa3svNsm/tDfnnCqLcwWlAEt8b4mkct/qAMt5uciQlfSTZF5A0AdFXIt9m5Id0Sw/3rRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oDFVvQVH; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707223303; x=1738759303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qxoLmloFR+9+GhytewaFGvg+IJiae2V+Vk54IVBsmL8=;
  b=oDFVvQVH36C6wOb9CK0nRSPbNa8egocZIXGE8h4HLQGhM34m9J4HMPhG
   6JNkmTBYzbXZkKaFVCo6DcIxXUyho/H3QhGM1tk7kI17Hwxqg/h96F89L
   DCiGFEe0dups8z//OTTSYdSulMhAExoAduw7rn9IA06loVqYv8cis5SvF
   oredXOMSTsUyrxaBG+ydM6sP7W4eozBb1k1THhV3lNVW2ekpbfoCgtS6W
   KigNfW6IVmINCzRZ3NVg5BnVSwnGlTDU5an6nPo52nnw7tVI1iFkY7ehF
   jp/fORSBdaSW4h+W/FK2sAMClA3vd8ckzoCzlbmnEhkf6+51PO8Fa1TG+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="18255146"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="18255146"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 04:41:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="5619965"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa005.fm.intel.com with ESMTP; 06 Feb 2024 04:41:40 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v2 iwl-net 1/2] i40e: avoid double calling i40e_pf_rxq_wait()
Date: Tue,  6 Feb 2024 13:41:31 +0100
Message-Id: <20240206124132.636342-2-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240206124132.636342-1-maciej.fijalkowski@intel.com>
References: <20240206124132.636342-1-maciej.fijalkowski@intel.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
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


