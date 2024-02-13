Return-Path: <netdev+bounces-71129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D34BE8526D7
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 02:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113361C236AA
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 01:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A257A71F;
	Tue, 13 Feb 2024 01:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lyx3EYFO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2CF79DD9
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 01:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707786368; cv=none; b=JwaFzDg4NtHFoJhw+oGAhKib16YQxLSZAAng51uoPft5wl2UUHm+rOx2ygjCrkcmGtPFB4fshaZR45f7v+YtdikNdnRjNrFg4ecPHoNj7wZCW2TW7cTqMOOy8PZGEJh3cGYhb+peqQi8qwbeyb58xd+YzFZJFExd8cFVwnsT1UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707786368; c=relaxed/simple;
	bh=QDV0x4hPyNKEPQU4r1OpQikVnBw7+qXDB41a8z+oNDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjR1W4cnQldyORDaEvPLd5Y6unRePhfTXD3Sf63Rj3INWamiLEzMOEhwOLmGWCaQXfMo3W+vhggjmNPomr9q+fQKvorNewPSHKjFPyZ6HHqAD8buUW2qKsGpPmNVloN4Ycs9liy48FfSGpQUUUlsyYOzKNyxtIGcc+MTtnutG4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lyx3EYFO; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707786366; x=1739322366;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QDV0x4hPyNKEPQU4r1OpQikVnBw7+qXDB41a8z+oNDc=;
  b=lyx3EYFOe81dRa6mRpB1SeoBi184KgWIty5+KQmE/2abQAUbo9YqQvOr
   yKVSq/NQS0d6W9dHOzU1Vaoe90d1T2vkp3jfphksQYacLAncHnwqF8u82
   7Txztm5i7epq9Ah+TF+j4YE/X1bZ2XW11GFxBKO2LawpN8yc2L21AS6ph
   Hxe0V0krPgLFXoQS3B+p60MqclBkpWnidrmu1oN7N7d1Sv2fkXJTBUIOf
   3Z/DBmvVAcJ+GvYPxg2iAjIghNxuPrkg0SzpDmP56QZBCU49QWwczxwXj
   uaaZGxz0i8hDH4hO6cretMVZCt2C0GYhdni69GUM3guPP+ABYuo9XI1wg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="436927663"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="436927663"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 17:05:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="911651338"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="911651338"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga002.fm.intel.com with ESMTP; 12 Feb 2024 17:05:43 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	anthony.l.nguyen@intel.com,
	Simon Horman <horms@kernel.org>,
	Ivan Vecera <ivecera@redhat.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: [PATCH net 3/4] i40e: avoid double calling i40e_pf_rxq_wait()
Date: Mon, 12 Feb 2024 17:05:38 -0800
Message-ID: <20240213010540.1085039-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213010540.1085039-1-anthony.l.nguyen@intel.com>
References: <20240213010540.1085039-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

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
Reviewed-by: Ivan Vecera <ivecera@redhat.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 7a416e923b36..06078c4d54e8 100644
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
2.41.0


