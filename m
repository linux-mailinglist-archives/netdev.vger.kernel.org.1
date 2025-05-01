Return-Path: <netdev+bounces-187333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5AAAA6688
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 00:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE41172F69
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 22:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B712741B2;
	Thu,  1 May 2025 22:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f+wTXH4a"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A5426F463
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 22:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140084; cv=none; b=R38KWHJt95XZgbGoNfyCleby5gkZT/4qrEt5WsZa674qtktbXUZ7WF6L0IY+asowjGZEyKpQbKi6i9A74NPeS8F/ePMpfxtD2jm5UV8linyAvrDOQX4A8brVfu1ozb24Jt2PLX8RGVdeFZA3jNHPfpE0tGiH513/zXiZDg8niv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140084; c=relaxed/simple;
	bh=tSu33t7AVifIwGn39pcyFKvKLahj6dGlHDegt9DYEHg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UQJUvFsUfVrH6iGhQeRf+BSBTv3m5zF0mDCJ2j2DXx64jX2ezrKgq4fw1pbBadXfhUMFhIDNLDUYYdNK1gEb32MAi3Alj+TQ80PvRXyAJE/4TG1fi5bkwJFb1uWINPnE66NvyXP+pSQycidLOGUg+mWJa+LT/YLThF//tITWVgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f+wTXH4a; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746140083; x=1777676083;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=tSu33t7AVifIwGn39pcyFKvKLahj6dGlHDegt9DYEHg=;
  b=f+wTXH4avb26OriQcxoa7MNy9/xFw0gINjSyeZ3jAEzHIgzkGwPdoNu4
   8OVuAs9mEhu55nY6tBDBYESyFsT8e3DKwQYcDwgWisgoTX/2yQOuo5tC1
   hjBmgcPM4rW0bjp2t4ccSjG8FQqBcl77L+1WfIQtv6BAeymzGjqWczWuF
   QVz5WEgzd7wN0m3GWM+hvrl3qHZh9NRVgVmCVvPIO09wTWJaH7/Pwi33q
   11pEuOjuN4nafWnH9VUs1sKmrWG3iviQkFk9S3/shGma6r5Yky2rHkQvz
   z7+Oymoe756LZs82hly4ZMh4HsT+Kfqehrp89BURzp9P2yr3ATyLlZj1/
   A==;
X-CSE-ConnectionGUID: i9kmkE4eQkqYZusUIlqRDA==
X-CSE-MsgGUID: e29OlmDbT0yIQ0ZZ1iw/3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="58811758"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="58811758"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 15:54:39 -0700
X-CSE-ConnectionGUID: cBYpQQXmTSGot7qpTG7+ag==
X-CSE-MsgGUID: Bdr2BZkqS1yV+LRB5tFusA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="138514325"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 15:54:38 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 01 May 2025 15:54:26 -0700
Subject: [PATCH v4 15/15] ice: default to TIME_REF instead of TXCO on
 E825-C
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250501-kk-tspll-improvements-alignment-v4-15-24c83d0ce7a8@intel.com>
References: <20250501-kk-tspll-improvements-alignment-v4-0-24c83d0ce7a8@intel.com>
In-Reply-To: <20250501-kk-tspll-improvements-alignment-v4-0-24c83d0ce7a8@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Karol Kolacinski <karol.kolacinski@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Milena Olech <milena.olech@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>
X-Mailer: b4 0.14.2

The driver currently defaults to the internal oscillator as the clock
source for E825-C hardware. While this clock source is labeled TCXO,
indicating a temperature compensated oscillator, this is only true for some
board designs. Many board designs have a less capable oscillator. The
E825-C hardware may also have its clock source set to the TIME_REF pin.
This pin is connected to the DPLL and is often a more stable clock source.
The choice of the internal oscillator is not suitable for all systems,
especially those which want to enable SyncE support.

There is currently no interface available for users to configure the clock
source. Other variants of the E82x board have the clock source configured
in the NVM, but E825-C lacks this capability, so different board designs
cannot select a different default clock via firmware.

In most setups, the TIME_REF is a suitable default clock source.
Additionally, we now fall back to the internal oscillator automatically if
the TIME_REF clock source cannot be locked.

Change the default clock source for E825-C to TIME_REF. Note that the
driver logs a dev_dbg message upon configuring the TSPLL which includes the
clock source and frequency. This can be enabled to confirm which clock
source is in use.

Longterm a proper interface to dynamically introspect and change the clock
source will be designed (perhaps some extension of the DPLL subsystem?)

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 7d731d1be862311358943c6922354504ba4721ba..742ffbfba73ca3279cec311ae359ebc6a4e6a584 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2344,7 +2344,7 @@ ice_parse_1588_func_caps(struct ice_hw *hw, struct ice_hw_func_caps *func_p,
 		info->clk_src = ((number & ICE_TS_CLK_SRC_M) != 0);
 	} else {
 		info->clk_freq = ICE_TSPLL_FREQ_156_250;
-		info->clk_src = ICE_CLK_SRC_TCXO;
+		info->clk_src = ICE_CLK_SRC_TIME_REF;
 	}
 
 	if (info->clk_freq < NUM_ICE_TSPLL_FREQ) {

-- 
2.48.1.397.gec9d649cc640


