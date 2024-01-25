Return-Path: <netdev+bounces-66015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044FD83CF0D
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 22:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39441B288D6
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 21:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9B713BE8C;
	Thu, 25 Jan 2024 21:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G17z5uiT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5FB13A263
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 21:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219889; cv=none; b=QRs1j2wMq0JKnrwEb2A0CLnzLgIdnvGG9xEdhubPo4B3vC7Xs8N7I1ZjJBjs0NiDD/EBsbVjbcEwp/48zDdxmFH0uk9hRpVt0SGKJHI/+lsKZqC78rXCrwj3lyHitV4+nTlAnod+t5zj+/5MbsnrBFYR1ockNCJGIXvh3c588bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219889; c=relaxed/simple;
	bh=nqImKu4UP9QZDLrIAqb2Vj5H8xAkE4affWK0NnGrb4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3WKJ7nH64mvFxKidVbCrg0VE8qVO4Ln6K1araiRpDfMde0BnFHX/M33SLP63LLA3Oaw3AeKv8riXRx2EXzI9AqZhz3AvRcug32DODVo6xVg+GpSAIBwEq/SLjK+1IDWuQBQqj+MXCCIt1T8PCtyhNBD1JEE/BMDAIYOszJSHj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G17z5uiT; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706219888; x=1737755888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nqImKu4UP9QZDLrIAqb2Vj5H8xAkE4affWK0NnGrb4s=;
  b=G17z5uiT9YGlLX8RdF6Z3clYY0MGQ3TxN3j2tF1QWnmKXYidsYzTijyC
   NgAciGabgwbqJVBzXfEPl+2vVBKvMOepSl/7sNrLIzNPkrpg+YwSvr+2p
   ocpTEkT5dKRHX+CKoYStdfdl++afprag8ZlVbHwM4uJfu81Zfd5Wj4DTw
   sBO7pZX6e6+j4NWnOFyd2GGzK2AEZ8wZN30ZnAWfqFqnp5yVkARc857Hu
   XzHqWGnwD4Q3QNT+0jP1HtYJv1jplu0om+53YNLzMF8WEP+T0q0HFMPpn
   gIeYLuUWonsImgarbOeNm1HVv8/LywxBIkOS8cd88NKOVAx8QyvWrDjEf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9069113"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9069113"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 13:58:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="35239933"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 25 Jan 2024 13:58:03 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 5/7] ice: rename ice_ptp_tx_cfg_intr
Date: Thu, 25 Jan 2024 13:57:53 -0800
Message-ID: <20240125215757.2601799-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240125215757.2601799-1-anthony.l.nguyen@intel.com>
References: <20240125215757.2601799-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The ice_ptp_tx_cfg_intr() function sends a control queue message to
configure the PHY timestamp interrupt block. This is a very similar name
to a function which is used to configure the MAC Other Interrupt Cause
Enable register.

Rename this function to ice_ptp_cfg_phy_interrupt in order to make it
more obvious to the reader what action it performs, and distinguish it
from other similarly named functions.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 69d11dbda22c..6f2a1ad5c2a3 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1455,14 +1455,14 @@ void ice_ptp_link_change(struct ice_pf *pf, u8 port, bool linkup)
 }
 
 /**
- * ice_ptp_tx_ena_intr - Enable or disable the Tx timestamp interrupt
+ * ice_ptp_cfg_phy_interrupt - Configure PHY interrupt settings
  * @pf: PF private structure
  * @ena: bool value to enable or disable interrupt
  * @threshold: Minimum number of packets at which intr is triggered
  *
  * Utility function to enable or disable Tx timestamp interrupt and threshold
  */
-static int ice_ptp_tx_ena_intr(struct ice_pf *pf, bool ena, u32 threshold)
+static int ice_ptp_cfg_phy_interrupt(struct ice_pf *pf, bool ena, u32 threshold)
 {
 	struct ice_hw *hw = &pf->hw;
 	int err = 0;
@@ -2674,8 +2674,8 @@ void ice_ptp_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	struct ice_ptp *ptp = &pf->ptp;
 	struct ice_hw *hw = &pf->hw;
 	struct timespec64 ts;
-	int err, itr = 1;
 	u64 time_diff;
+	int err;
 
 	if (ptp->state == ICE_PTP_READY) {
 		ice_ptp_prepare_for_reset(pf, reset_type);
@@ -2726,7 +2726,7 @@ void ice_ptp_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 	if (!ice_is_e810(hw)) {
 		/* Enable quad interrupts */
-		err = ice_ptp_tx_ena_intr(pf, true, itr);
+		err = ice_ptp_cfg_phy_interrupt(pf, true, 1);
 		if (err)
 			goto err;
 	}
@@ -2979,7 +2979,7 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
 {
 	struct ice_hw *hw = &pf->hw;
 	struct timespec64 ts;
-	int err, itr = 1;
+	int err;
 
 	err = ice_ptp_init_phc(hw);
 	if (err) {
@@ -3014,7 +3014,7 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
 
 	if (!ice_is_e810(hw)) {
 		/* Enable quad interrupts */
-		err = ice_ptp_tx_ena_intr(pf, true, itr);
+		err = ice_ptp_cfg_phy_interrupt(pf, true, 1);
 		if (err)
 			goto err_exit;
 	}
-- 
2.41.0


