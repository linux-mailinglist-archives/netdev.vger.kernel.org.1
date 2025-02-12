Return-Path: <netdev+bounces-165719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AE4A333AD
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 00:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267CA3A44A0
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 23:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EF2206F2C;
	Wed, 12 Feb 2025 23:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZPClpUZS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED04A126C05
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 23:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739404487; cv=none; b=FaJboe8RnfCb3AONWiUyaT9ZcJklL1UJF9Yy7f9sRC6hIqUvsvhdRdblaed8eJnoo2R3DZ/F6H0xIMyDc4nLIwnPy02vOw1L1+W3Im3X4pMfmODMirGJMZIvpkYqx44mjqdXl8IkqThpiJwSmHCJ1hXSaw4jd29P+wJG4NQDQf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739404487; c=relaxed/simple;
	bh=/BPC5biIS3ofqER+HjqinKdLE/NVePjzIrN9YlotZ80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iOV8yZJvyTg277X4IDtumtE0tVop3+dDVIcDif/pEZ9yTu0xI7h6M+Ht/ZwKDYZkLJ/P5A9zlyobm8DGI3DfLdJt5TjfCRGv7mReDnNuwNSl7kLH92wXX3Sle25vKTqkalkYEBWWZQE54zJWntjvC0whkQhb5KS5qvFCAXd3Cds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZPClpUZS; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739404485; x=1770940485;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=/BPC5biIS3ofqER+HjqinKdLE/NVePjzIrN9YlotZ80=;
  b=ZPClpUZSIe0cWR6f/e12qbOnq5X7ba+MftRbOoAkFe1cvJ4KfzoGh+LM
   6mHzKqfFcKdEYFKx97HtLV4vOs+FQZqAvepYa/0GNSks5xD8N6QyP6GAG
   iO+d1tm86O3TUyna4q2d0HJaPcDxPTLx2DR4P0t03RJL1O2o/RUHQ3nxp
   fSC8nMWPkmTyliBYOgaFXXIH4GCTahBvoA+9v7UTecuOUJMGZOWa6s4OL
   NrNl3CENgFUljaqwHCVNmiOI6z8WmUrtuLCe9HUKE6tDpTB/6rns/a2Rp
   nK1ES4gbh/emL0+EhTKQLcW9bhdm6ULDiXFEBAWyJDRK7SeQCAdzwRQ4F
   A==;
X-CSE-ConnectionGUID: idJ2RSm4RaCk4ypN1xZbtg==
X-CSE-MsgGUID: vx5yhm5STnGpnPHd8I6SUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40204130"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40204130"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 15:54:45 -0800
X-CSE-ConnectionGUID: J9dwdDcsSHeJAaMppe3kOg==
X-CSE-MsgGUID: ifIclfBrQ9aEj9usfuhjYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="150140779"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 15:54:45 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 12 Feb 2025 15:54:39 -0800
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
Message-Id: <20250212-jk-gnrd-ptp-pin-patches-v1-1-7cbae692ac97@intel.com>
X-B4-Tracking: v=1; b=H4sIAL40rWcC/x3MwQqDMAyA4VeRnBewwXrYq4wdShs1bmShLVMQ3
 93i8Tv8/wGFs3CBZ3dA5r8U+WmDe3QQl6Azo6RmoJ58T45w/eCsOaFVQxNFCzUuXHAgP7oUBs/
 RQast8yT7fX6BbF9UrvA+zwt2VGzKcgAAAA==
X-Change-ID: 20250212-jk-gnrd-ptp-pin-patches-42561da45ec1
To: netdev <netdev@vger.kernel.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Karol Kolacinski <karol.kolacinski@intel.com>, 
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
base-commit: e589adf5b70c07b1ab974d077046fdbf583b2f36
change-id: 20250212-jk-gnrd-ptp-pin-patches-42561da45ec1

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


