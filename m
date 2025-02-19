Return-Path: <netdev+bounces-167906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BDBA3CC9C
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 23:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0B2174118
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 22:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3829B1DE2C6;
	Wed, 19 Feb 2025 22:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MRQPzlCQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4F91DED6F
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 22:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005133; cv=none; b=Z4nk1YlOH6rppq9QeMKTMtPafIhGQtzy/LCz4PrRgY/r+v7BHMOQ/ua+r/9pPVnMSFmRl+Bcu8vjFhYS//fB6pUcpQM+qQNRKANRWXExpAfuNzk/qpJllVK1OXQ1qvzHaxjcIqL3vZ6+Vp0VNkNnThWyhezA6EC0TCjK+6OP6Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005133; c=relaxed/simple;
	bh=zmbVvXQXALcaFIiXJdEdlIiZUkm9FRxIcycBFuJuzy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Dcgcb990b4A21Bf8rQ2vcJKsRm3kKPRorWg97hXtVi60iYpxWattuwBT6g2dJX+0DU7uZ4mbzL0Eizjo4+Ul2pMQgQtB9id8BDe/0/zrQnP1XbEOqlcn/WQSFOATj1MU/6DdspPCS6mQwtgri1kMOoSd9pdRAS0f2JusvbaPT/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MRQPzlCQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740005131; x=1771541131;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=zmbVvXQXALcaFIiXJdEdlIiZUkm9FRxIcycBFuJuzy0=;
  b=MRQPzlCQU9bh2CIdiWt7JqAuwQLnHVjeXCyi/mm/51uQT3RZjOmzftEy
   /4zrsAZHMsArQ4VTGCYQXswXdUQbXem29IAAJxyoU3ah2Revq+u/QrxnP
   MaMMjpDOQ3RLmrEH4RVzK/w9RSzuZuFr8KEaEWcleYpK1NP4aUTzyTazq
   Jx0GHB/ByN8SQM2u2ioc7Y+0aewZAu46iIzNldMBG4sx5QtOQJLAJLNlI
   CEcq9dsA4XXv0bZ8l0BrxHqlYsvQGJGZ3uhPwX1DYa89Gagtf/AL3jnlF
   7gDOWPM8gL3fUXZn8f2g1fWIqK5iO/T/MQZvHNCg6haRrBs3bNpAeZqtt
   Q==;
X-CSE-ConnectionGUID: eWP2eFEERsuRxVNAt6SurQ==
X-CSE-MsgGUID: 6zUN6FmdTAmNqYU+TZKGOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="63241794"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="63241794"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 14:45:31 -0800
X-CSE-ConnectionGUID: hCIkB3pyRFGWcV3Xl0hu4g==
X-CSE-MsgGUID: IPLp/uVDTbysc7Pqctkqsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="119795238"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 14:15:40 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 19 Feb 2025 14:13:27 -0800
Subject: [PATCH iwl-net] ice: ensure periodic output start time is in the
 future
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-jk-gnrd-ptp-pin-patches-v1-1-9cb3efaf9eea@intel.com>
X-B4-Tracking: v=1; b=H4sIAIZXtmcC/x2NywoCMQxFf2XI2sA0TF34K+KitHEalUxoiw+G/
 rvV5eFy7tmhchGucJp2KPyUKpsOcIcJYg66MkoaDDSTn8kR3u64aklozdBE0UKLmSsu5I8uhcV
 zdDBsK3yV9//5DPJ6oHKDyxiy1LaVz6/Ye/8CBNCywYEAAAA=
X-Change-ID: 20250212-jk-gnrd-ptp-pin-patches-42561da45ec1
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.14.2

From: Karol Kolacinski <karol.kolacinski@intel.com>

On E800 series hardware, if the start time for a periodic output signal is
programmed into GLTSYN_TGT_H and GLTSYN_TGT_L registers, the hardware logic
locks up and the periodic output signal never starts. Any future attempt to
reprogram the clock function is futile as the hardware will not reset until
a power on.

The ice_ptp_cfg_perout function has logic to prevent this, as it checks if
the requested start time is in the past. If so, a new start time is
calculated by rounding up.

Since commit d755a7e129a5 ("ice: Cache perout/extts requests and check
flags"), the rounding is done to the nearest multiple of the clock period,
rather than to a full second. This is more accurate, since it ensures the
signal matches the user request precisely.

Unfortunately, there is a race condition with this rounding logic. If the
current time is close to the multiple of the period, we could calculate a
target time that is extremely soon. It takes time for the software to
program the registers, during which time this requested start time could
become a start time in the past. If that happens, the periodic output
signal will lock up.

For large enough periods, or for the logic prior to the mentioned commit,
this is unlikely. However, with the new logic rounding to the period and
with a small enough period, this becomes inevitable.

For example, attempting to enable a 10MHz signal requires a period of 100
nanoseconds. This means in the *best* case, we have 99 nanoseconds to
program the clock output. This is essentially impossible, and thus such a
small period practically guarantees that the clock output function will
lock up.

To fix this, add some slop to the clock time used to check if the start
time is in the past. Because it is not critical that output signals start
immediately, but it *is* critical that we do not brick the function, 0.5
seconds is selected. This does mean that any requested output will be
delayed by at least 0.5 seconds.

This slop is applied before rounding, so that we always round up to the
nearest multiple of the period that is at least 0.5 seconds in the future,
ensuring a minimum of 0.5 seconds to program the clock output registers.

Finally, to ensure that the hardware registers programming the clock output
complete in a timely manner, add a write flush to the end of
ice_ptp_write_perout. This ensures we don't risk any issue with PCIe
transaction batching.

Strictly speaking, this fixes a race condition all the way back at the
initial implementation of periodic output programming, as it is
theoretically possible to trigger this bug even on the old logic when
always rounding to a full second. However, the window is narrow, and the
code has been refactored heavily since then, making a direct backport not
apply cleanly.

Fixes: d755a7e129a5 ("ice: Cache perout/extts requests and check flags")
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index e26320ce52ca17b30a9538b11b754c7cf57c9af9..a99e0fbd0b8b55ad72a2bc7d13851562a6f2f5bd 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1783,6 +1783,7 @@ static int ice_ptp_write_perout(struct ice_hw *hw, unsigned int chan,
 				  8 + chan + (tmr_idx * 4));
 
 	wr32(hw, GLGEN_GPIO_CTL(gpio_pin), val);
+	ice_flush(hw);
 
 	return 0;
 }
@@ -1843,9 +1844,10 @@ static int ice_ptp_cfg_perout(struct ice_pf *pf, struct ptp_perout_request *rq,
 		div64_u64_rem(start, period, &phase);
 
 	/* If we have only phase or start time is in the past, start the timer
-	 * at the next multiple of period, maintaining phase.
+	 * at the next multiple of period, maintaining phase at least 0.5 second
+	 * from now, so we have time to write it to HW.
 	 */
-	clk = ice_ptp_read_src_clk_reg(pf, NULL);
+	clk = ice_ptp_read_src_clk_reg(pf, NULL) + NSEC_PER_MSEC * 500;
 	if (rq->flags & PTP_PEROUT_PHASE || start <= clk - prop_delay_ns)
 		start = div64_u64(clk + period - 1, period) * period + phase;
 

---
base-commit: a92c3228766429fe175ecc815f895043ea505587
change-id: 20250212-jk-gnrd-ptp-pin-patches-42561da45ec1

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


