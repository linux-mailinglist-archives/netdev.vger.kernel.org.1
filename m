Return-Path: <netdev+bounces-224381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC9EB84413
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 13:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A373C7B3A02
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 10:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B127B2FFF8C;
	Thu, 18 Sep 2025 10:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aos9blcv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA15C18A6DB;
	Thu, 18 Sep 2025 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758193187; cv=none; b=jDhW0rTj7PaCXdg6noTyRpxU+ehbYBxbKbcVCUCCM0VWer8HO9PzDkjeQG907cqSxRxUjSVvo+tiaEwYJMXfgyKylYx0X1izkgIvcC/FyrOY446lbnEqeT2NXkPzQRShE3mX63fr4uW6jiv9eF75xbX8TardZzzofD+zQ53o84Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758193187; c=relaxed/simple;
	bh=k7WjdxD1akUFMFsnjD+igZOq30uLF23C9JuX5ROO/Wk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aXuWS+8z6uU4RyDOTKgtP3hPEoKgoEn8UH+wh2K9PMxqVIkxRtp2q9chqzde6aHm42+5XsOIFDQazotMO40d/WxFNF/d+jRO06P1p0SC1PrqDT13hUpz0uO0YMfWLUoKKRpiv3JwPz5vW5VjlLbs5d+ciNHkFXRSR7BkjjxUeiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aos9blcv; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758193186; x=1789729186;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k7WjdxD1akUFMFsnjD+igZOq30uLF23C9JuX5ROO/Wk=;
  b=Aos9blcvkrt9eop+nKgdyLCxd9Yd0+/NoT2gWYrKdTZ7C2/snZM32qY2
   1oiJT5nx77MJqkiqnPDncmDlB+g9KQ8qmaEEwNBxcOVICPD+hY7+t3rUv
   fmd0rYmCPv7/znvKASeknMpXwD7vSyKCN6Pca6GTXWBubbpyRy6Gf9TTZ
   3/AyBXgOI37an1t9xgH0Tln6tn5IjqQjCpbrv9I761eFKmwMKciX3BdSi
   9ut7GAon0GeDNpPK6K+4Skby1y3r2Y8pFZegaCEmZuQoUgqL8VL+579TA
   pkw/9F58KAkfYZfqSrvT36h+R/Of6QC/z79EA+01VPRFvQmERi/d/E1jH
   A==;
X-CSE-ConnectionGUID: q+Jmw2+kSUC45AaKVqZlsw==
X-CSE-MsgGUID: QejdNk/gQqeNz3yxS6Kd1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="64336083"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="64336083"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 03:59:45 -0700
X-CSE-ConnectionGUID: TW+Q+WYtS32lblmpHmpoQw==
X-CSE-MsgGUID: ZVBunwrSQee44Q89CHxReQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="180627016"
Received: from p2dy149cchoong.png.intel.com ([10.107.243.50])
  by orviesa005.jf.intel.com with ESMTP; 18 Sep 2025 03:59:41 -0700
From: Chwee-Lin Choong <chwee.lin.choong@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Shalev <avi.shalev@intel.com>,
	Song Yoong Siang <yoong.siang.song@intel.com>
Subject: [PATCH iwl-net v1] igc: fix race condition in TX timestamp read for register 0
Date: Fri, 19 Sep 2025 02:38:11 +0800
Message-ID: <20250918183811.31270-1-chwee.lin.choong@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current HW bug workaround checks the TXTT_0 ready bit first,
then reads LOW -> HIGH -> LOW from register 0 to detect if a
timestamp was captured.

This sequence has a race: if a new timestamp is latched after
reading the TXTT mask but before the first LOW read, both old
and new timestamp match, causing the driver to drop a valid
timestamp.

Fix by reading the LOW register first, then the TXTT mask,
so a newly latched timestamp will always be detected.

This fix also prevents TX unit hangs observed under heavy
timestamping load.

Fixes: c789ad7cbebc ("igc: Work around HW bug causing missing timestamps")
Suggested-by: Avi Shalev <avi.shalev@intel.com>
Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
Signed-off-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index b7b46d863bee..930486b02fc1 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -774,10 +774,17 @@ static void igc_ptp_tx_reg_to_stamp(struct igc_adapter *adapter,
 static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
 {
 	struct igc_hw *hw = &adapter->hw;
+	u32 txstmpl_old;
 	u64 regval;
 	u32 mask;
 	int i;
 
+	/* Read the "low" register 0 first to establish a baseline value.
+	 * This avoids a race where a new timestamp could be latched
+	 * after checking the TXTT mask.
+	 */
+	txstmpl_old = rd32(IGC_TXSTMPL);
+
 	mask = rd32(IGC_TSYNCTXCTL) & IGC_TSYNCTXCTL_TXTT_ANY;
 	if (mask & IGC_TSYNCTXCTL_TXTT_0) {
 		regval = rd32(IGC_TXSTMPL);
@@ -801,9 +808,8 @@ static void igc_ptp_tx_hwtstamp(struct igc_adapter *adapter)
 		 * timestamp was captured, we can read the "high"
 		 * register again.
 		 */
-		u32 txstmpl_old, txstmpl_new;
+		u32 txstmpl_new;
 
-		txstmpl_old = rd32(IGC_TXSTMPL);
 		rd32(IGC_TXSTMPH);
 		txstmpl_new = rd32(IGC_TXSTMPL);
 
-- 
2.42.0


