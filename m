Return-Path: <netdev+bounces-66847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1FA8412CC
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 19:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9801C24ED4
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 18:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDD433CE7;
	Mon, 29 Jan 2024 18:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HAiN2qId"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C4512E5B
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 18:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706554480; cv=none; b=rjiMu8tyYvcuBAINvkorspACgKAwFEMlA8FnY9bKbV3FNay9ZbA8Od1QXl5vp9Th652LdnzUOER8GGji61G/DJEMDky/5/eF6sUqF+LHVey6h9X3qPfUv+/R/2oFcviWsmfSOI3LZNVnsvtRMVfrseEWjY0E3vV/KWWDWm9yqMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706554480; c=relaxed/simple;
	bh=AFRXawxcR8cvrZO4qCBm/va/rrsov5mWzY8z+yKlaJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=foI0Y07gRGt7Vz+RAE4/HaDsThvdqOZxNgiye74CjGHyAJoS++UkRKQXYqRT8jAacmHFGORVCme2JvYq1Bwx1i7blFi75THMZtYIguUGgos4K9V3wyYtqY3SIO0VRoCilF7dyPfuiKDezwsZo2ODblhqRZtkQO+AEf8xD6D14t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HAiN2qId; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706554477; x=1738090477;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AFRXawxcR8cvrZO4qCBm/va/rrsov5mWzY8z+yKlaJw=;
  b=HAiN2qIdbtvd7wMn1Ih0iLqxZpxD5sTtWe7GtPrBP+bpixobq5+ZXdHk
   yFTD7gNIkgCh+hlUeFRG7MEE7DO88KVuxgecaOsFyUCLhROmu52A4k1l1
   W96dg04K+m6pVnojutzvX2rIS3EqkuD9wnB5HAwnL47quOrjo+d3rBZbA
   mouAP1olxXHWWJVlkF9I34GLKSTjXPfStWtXCJMyhoRf+434Gd3UoBqGF
   dTwpF7Qq7W5UxIRaLLUqpAX2IiURuj7zqYo6eXj+pARGjL6vEprzcKmy7
   JHHoTzI7NW1lXGjZBgdJnMONmIr6ACK+2nuOie5H4EA4dFcaA6N8zVddD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2879932"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="2879932"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 10:52:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="3470146"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 29 Jan 2024 10:52:49 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	richardcochran@gmail.com,
	Trey Harrison <harrisondigitalmedia@gmail.com>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net 1/2] e1000e: correct maximum frequency adjustment values
Date: Mon, 29 Jan 2024 10:52:37 -0800
Message-ID: <20240129185240.787397-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240129185240.787397-1-anthony.l.nguyen@intel.com>
References: <20240129185240.787397-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The e1000e driver supports hardware with a variety of different clock
speeds, and thus a variety of different increment values used for
programming its PTP hardware clock.

The values currently programmed in e1000e_ptp_init are incorrect. In
particular, only two maximum adjustments are used: 24000000 - 1, and
600000000 - 1. These were originally intended to be used with the 96 MHz
clock and the 25 MHz clock.

Both of these values are actually slightly too high. For the 96 MHz clock,
the actual maximum value that can safely be programmed is 23,999,938. For
the 25 MHz clock, the maximum value is 599,999,904.

Worse, several devices use a 24 MHz clock or a 38.4 MHz clock. These parts
are incorrectly assigned one of either the 24million or 600million values.
For the 24 MHz clock, this is not a significant issue: its current
increment value can support an adjustment up to 7billion in the positive
direction. However, the 38.4 KHz clock uses an increment value which can
only support up to 230,769,157 before it starts overflowing.

To understand where these values come from, consider that frequency
adjustments have the form of:

new_incval = base_incval + (base_incval * adjustment) / (unit of adjustment)

The maximum adjustment is reported in terms of parts per billion:
new_incval = base_incval + (base_incval * adjustment) / 1 billion

The largest possible adjustment is thus given by the following:
max_incval = base_incval + (base_incval * max_adj) / 1 billion

Re-arranging to solve for max_adj:
max_adj = (max_incval - base_incval) * 1 billion / base_incval

We also need to ensure that negative adjustments cannot underflow. This can
be achieved simply by ensuring max_adj is always less than 1 billion.

Introduce new macros in e1000.h codifying the maximum adjustment in PPB for
each frequency given its associated increment values. Also clarify where
these values come from by commenting about the above equations.

Replace the switch statement in e1000e_ptp_init with one which mirrors the
increment value switch statement from e1000e_get_base_timinica. For each
device, assign the appropriate maximum adjustment based on its frequency.
Some parts can have one of two frequency modes as determined by
E1000_TSYNCRXCTL_SYSCFI.

Since the new flow directly matches the assignments in
e1000e_get_base_timinca, and uses well defined macro names, it is much
easier to verify that the resulting maximum adjustments are correct. It
also avoids difficult to parse construction such as the "hw->mac.type <
e1000_phc_lpt", and the use of fallthrough which was especially confusing
when combined with a conditional block.

Note that I believe the current increment value configuration used for
24MHz clocks is sub-par, as it leaves at least 3 extra bits available in
the INCVALUE register. However, fixing that requires more careful review of
the clock rate and associated values.

Reported-by: Trey Harrison <harrisondigitalmedia@gmail.com>
Fixes: 68fe1d5da548 ("e1000e: Add Support for 38.4MHZ frequency")
Fixes: d89777bf0e42 ("e1000e: add support for IEEE-1588 PTP")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/e1000.h | 20 ++++++++++++++++++++
 drivers/net/ethernet/intel/e1000e/ptp.c   | 22 +++++++++++++++-------
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index a187582d2299..ba9c19e6994c 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -360,23 +360,43 @@ s32 e1000e_get_base_timinca(struct e1000_adapter *adapter, u32 *timinca);
  * As a result, a shift of INCVALUE_SHIFT_n is used to fit a value of
  * INCVALUE_n into the TIMINCA register allowing 32+8+(24-INCVALUE_SHIFT_n)
  * bits to count nanoseconds leaving the rest for fractional nonseconds.
+ *
+ * Any given INCVALUE also has an associated maximum adjustment value. This
+ * maximum adjustment value is the largest increase (or decrease) which can be
+ * safely applied without overflowing the INCVALUE. Since INCVALUE has
+ * a maximum range of 24 bits, its largest value is 0xFFFFFF.
+ *
+ * To understand where the maximum value comes from, consider the following
+ * equation:
+ *
+ *   new_incval = base_incval + (base_incval * adjustment) / 1billion
+ *
+ * To avoid overflow that means:
+ *   max_incval = base_incval + (base_incval * max_adj) / billion
+ *
+ * Re-arranging:
+ *   max_adj = floor(((max_incval - base_incval) * 1billion) / 1billion)
  */
 #define INCVALUE_96MHZ		125
 #define INCVALUE_SHIFT_96MHZ	17
 #define INCPERIOD_SHIFT_96MHZ	2
 #define INCPERIOD_96MHZ		(12 >> INCPERIOD_SHIFT_96MHZ)
+#define MAX_PPB_96MHZ		23999900 /* 23,999,900 ppb */
 
 #define INCVALUE_25MHZ		40
 #define INCVALUE_SHIFT_25MHZ	18
 #define INCPERIOD_25MHZ		1
+#define MAX_PPB_25MHZ		599999900 /* 599,999,900 ppb */
 
 #define INCVALUE_24MHZ		125
 #define INCVALUE_SHIFT_24MHZ	14
 #define INCPERIOD_24MHZ		3
+#define MAX_PPB_24MHZ		999999999 /* 999,999,999 ppb */
 
 #define INCVALUE_38400KHZ	26
 #define INCVALUE_SHIFT_38400KHZ	19
 #define INCPERIOD_38400KHZ	1
+#define MAX_PPB_38400KHZ	230769100 /* 230,769,100 ppb */
 
 /* Another drawback of scaling the incvalue by a large factor is the
  * 64-bit SYSTIM register overflows more quickly.  This is dealt with
diff --git a/drivers/net/ethernet/intel/e1000e/ptp.c b/drivers/net/ethernet/intel/e1000e/ptp.c
index 02d871bc112a..bbcfd529399b 100644
--- a/drivers/net/ethernet/intel/e1000e/ptp.c
+++ b/drivers/net/ethernet/intel/e1000e/ptp.c
@@ -280,8 +280,17 @@ void e1000e_ptp_init(struct e1000_adapter *adapter)
 
 	switch (hw->mac.type) {
 	case e1000_pch2lan:
+		adapter->ptp_clock_info.max_adj = MAX_PPB_96MHZ;
+		break;
 	case e1000_pch_lpt:
+		if (er32(TSYNCRXCTL) & E1000_TSYNCRXCTL_SYSCFI)
+			adapter->ptp_clock_info.max_adj = MAX_PPB_96MHZ;
+		else
+			adapter->ptp_clock_info.max_adj = MAX_PPB_25MHZ;
+		break;
 	case e1000_pch_spt:
+		adapter->ptp_clock_info.max_adj = MAX_PPB_24MHZ;
+		break;
 	case e1000_pch_cnp:
 	case e1000_pch_tgp:
 	case e1000_pch_adp:
@@ -289,15 +298,14 @@ void e1000e_ptp_init(struct e1000_adapter *adapter)
 	case e1000_pch_lnp:
 	case e1000_pch_ptp:
 	case e1000_pch_nvp:
-		if ((hw->mac.type < e1000_pch_lpt) ||
-		    (er32(TSYNCRXCTL) & E1000_TSYNCRXCTL_SYSCFI)) {
-			adapter->ptp_clock_info.max_adj = 24000000 - 1;
-			break;
-		}
-		fallthrough;
+		if (er32(TSYNCRXCTL) & E1000_TSYNCRXCTL_SYSCFI)
+			adapter->ptp_clock_info.max_adj = MAX_PPB_24MHZ;
+		else
+			adapter->ptp_clock_info.max_adj = MAX_PPB_38400KHZ;
+		break;
 	case e1000_82574:
 	case e1000_82583:
-		adapter->ptp_clock_info.max_adj = 600000000 - 1;
+		adapter->ptp_clock_info.max_adj = MAX_PPB_25MHZ;
 		break;
 	default:
 		break;
-- 
2.41.0


