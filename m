Return-Path: <netdev+bounces-69461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCED84B578
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 13:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B690288071
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 12:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F8E12F399;
	Tue,  6 Feb 2024 12:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hNkNatni"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0497E3D54A
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707223305; cv=none; b=EBFKdQrP7kZ14IVBY5Aib0X48zffWVnPO650vmb9Cpo9hr/Ypwy995JGBjvA0R2CBAc7V1eC9KSVc0Lv21Koniv38QCN+1SvMihV7+u9mSboSUIVh10aDZEwBraxEAxyCcWYTb2g1i3QlTGr+Or+hNesS0lMkk8p/sydsTg8WOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707223305; c=relaxed/simple;
	bh=ABjdnj5rqhmhObksezYyewzVfd9rgdVSrARx12/Y+O4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DRsHNalQVguX5I7erfpfV23ZO/b8IO9woo/vCbOcp1ARKVVOXkaEDWav3ZZmmdoQ+Ba/wQ0U7VZzN4R+ay8XnC1Cc34O3chhfwGIwO9Dz84UYfBBHaUhXsH9SqvGiqXd3sw7gj1HaGNs+LCxap6kEtEkZIGgCdk1459Guu6g+VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hNkNatni; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707223304; x=1738759304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ABjdnj5rqhmhObksezYyewzVfd9rgdVSrARx12/Y+O4=;
  b=hNkNatniWFfh8S3s03TbkadiWy02UDm6LUKqZspno3No5nYIsy9wKGZ5
   Qd9NpvXgcOQKQf7p1qNjm81/YHfYHocv2jeEQQmwIvA+93sGTIJtAAS18
   7Lokv5/IW/XBKmZf+zY5mBuBdaoRAjyh0Ombxw9zuvTTg9QtEmwsWJQxw
   LCZWiLgVyCcZmoy6OAOnrBCKWDnxG4e1vm6FEyHSbpd606AqzIjL0q/Ai
   Wyycgx5F3OeFy0C/5HsOfy/54BaWzpjBd905sG0jIVFxPLCa2XkAj6nMh
   7rwHFCGlY5WAsjCOPn/CDCW+EuoqZdYP9yaBaNJObqg9Tu8LyZeVjfHaq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="18255149"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="18255149"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 04:41:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="5619976"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by fmviesa005.fm.intel.com with ESMTP; 06 Feb 2024 04:41:42 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Seth Forshee <sforshee@kernel.org>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH v2 iwl-net 2/2] i40e: take into account XDP Tx queues when stopping rings
Date: Tue,  6 Feb 2024 13:41:32 +0100
Message-Id: <20240206124132.636342-3-maciej.fijalkowski@intel.com>
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
Tested-by: Seth Forshee <sforshee@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 2c46a5e7d222..bf1b32a15b5e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4926,21 +4926,23 @@ int i40e_vsi_start_rings(struct i40e_vsi *vsi)
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
+	tx_q_end = vsi->base_queue +
+		vsi->alloc_queue_pairs * (i40e_enabled_xdp_vsi(vsi) ? 2 : 1);
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


