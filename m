Return-Path: <netdev+bounces-75447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06655869F76
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 19:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F7961C21AE6
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 18:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837F550A7C;
	Tue, 27 Feb 2024 18:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GphmtEP/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8763C490
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 18:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709059791; cv=none; b=IyOSOG1fg4jhSoBiVB5/VmvaZzzo/KfYYj9nIgKxNIorPLrBA8fon6PPE4MkXM0P+zjH4/lI72AOWoPXhEINWrQzHTXEWEEqBQhbOsw+jKDg7hctFgzojtnDuD7omKcZtX2tVjukdiMuJ26q2w+utvyIi9Aobmmh79paUGM8yII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709059791; c=relaxed/simple;
	bh=jsN3uyeLLhoVqg2C9Ryzgnp0Mba11rgSnxLU98RFPmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oe14Xh5se/yX2wb4yXcMwd/0sRhQX5byYIk6oGhodOYHrb6DG7OZltaCGczh0EN1QcpVcWd6OK2LsCe6oE+qzlK5IrEqqx6Lv/haaZ4GB2rDT40CqzECzH/aX91qq0LHZ/8gvrkmyJSq3awUr2qFXn5QF6rkL/PjLiPdlicCAL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GphmtEP/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709059789; x=1740595789;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jsN3uyeLLhoVqg2C9Ryzgnp0Mba11rgSnxLU98RFPmM=;
  b=GphmtEP/nbOC3dcGntfHPDjFGR3c0z9EqkIlRfalaR9v58S0lsanmzx9
   /jUNquYwMPQP/q7Z/PeQ8KgKWZLeVnB9+TOCU5ihWyE/xV1fPhf01vf53
   c+i2w3ltnCr8mh+Ru7lQaqCpzytfLw0vK8a6K1IAP6VdeBl/IrO42i20E
   6wNpSdaKDMz+z5F44h0lKh/qgQ+NUg9uDbqBgxu87BwnRlu/xLRF+ybGb
   soYnWV0JNQbb27qVBM2qsarkAHZgLrmYKwPAUdQibCng+c0QOV4kBDUMi
   +Zp6uo2hCY+GfMR9GOa+0oS+PdpjO9uTih0RRAuGYMt949EJD8y+Rz8WX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14134021"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="14134021"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 10:49:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="7577693"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 27 Feb 2024 10:49:48 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	anthony.l.nguyen@intel.com,
	richardcochran@gmail.com,
	nathan.sullivan@ni.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net] igb: extend PTP timestamp adjustments to i211
Date: Tue, 27 Feb 2024 10:49:41 -0800
Message-ID: <20240227184942.362710-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Oleksij Rempel <o.rempel@pengutronix.de>

The i211 requires the same PTP timestamp adjustments as the i210,
according to its datasheet. To ensure consistent timestamping across
different platforms, this change extends the existing adjustments to
include the i211.

The adjustment result are tested and comparable for i210 and i211 based
systems.

Fixes: 3f544d2a4d5c ("igb: adjust PTP timestamps for Tx/Rx latency")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_ptp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 319c544b9f04..f94570556120 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -957,7 +957,7 @@ static void igb_ptp_tx_hwtstamp(struct igb_adapter *adapter)
 
 	igb_ptp_systim_to_hwtstamp(adapter, &shhwtstamps, regval);
 	/* adjust timestamp for the TX latency based on link speed */
-	if (adapter->hw.mac.type == e1000_i210) {
+	if (hw->mac.type == e1000_i210 || hw->mac.type == e1000_i211) {
 		switch (adapter->link_speed) {
 		case SPEED_10:
 			adjust = IGB_I210_TX_LATENCY_10;
@@ -1003,6 +1003,7 @@ int igb_ptp_rx_pktstamp(struct igb_q_vector *q_vector, void *va,
 			ktime_t *timestamp)
 {
 	struct igb_adapter *adapter = q_vector->adapter;
+	struct e1000_hw *hw = &adapter->hw;
 	struct skb_shared_hwtstamps ts;
 	__le64 *regval = (__le64 *)va;
 	int adjust = 0;
@@ -1022,7 +1023,7 @@ int igb_ptp_rx_pktstamp(struct igb_q_vector *q_vector, void *va,
 	igb_ptp_systim_to_hwtstamp(adapter, &ts, le64_to_cpu(regval[1]));
 
 	/* adjust timestamp for the RX latency based on link speed */
-	if (adapter->hw.mac.type == e1000_i210) {
+	if (hw->mac.type == e1000_i210 || hw->mac.type == e1000_i211) {
 		switch (adapter->link_speed) {
 		case SPEED_10:
 			adjust = IGB_I210_RX_LATENCY_10;
-- 
2.41.0


