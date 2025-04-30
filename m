Return-Path: <netdev+bounces-187182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1E0AA5849
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 00:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2E23BF84F
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 22:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920BB20E6E7;
	Wed, 30 Apr 2025 22:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="btr/jAzp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC64522ACD4
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 22:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746053514; cv=none; b=MU2fn3E+zXi1FcHUivoCPDCsrwO+LFJDHAZDNCDlkqW2cO8O5YdtSZEYLYOhus4ILnRzGfFT5bMWhcoLV09nqzfzl1S+25Z5FaJcWLE4waBOKRTGSx3fLJLVnc8V3P7LSbtY6Q4kyzUnrB1v9ZnjDIrEJ5tFjjVidI+Z25T8mmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746053514; c=relaxed/simple;
	bh=VL7dxNtLUsOsauajRS7M6LwcerBRKBfspc0KClZyVfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BIrcvl/GPe8Q59mv6IIwLKNRoyTilDN7OU4GKrFz3oHc9MHZ+wu7fuwreMeCcRFj0w+0BLufnipwNyRPUDGW2zrXHqx2zWL+WhOzfsLUHv4KzS+1h2Bg/ztapsaAKaTlYGT2KvPd0HFVbvdD2mM0qHUIJtRcBkfPNknePw9VOts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=btr/jAzp; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746053512; x=1777589512;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=VL7dxNtLUsOsauajRS7M6LwcerBRKBfspc0KClZyVfA=;
  b=btr/jAzpoVcSRwRN4ixBxEd3bd08W3FCOWKA5+4sw+VamlxIVqsgqp/u
   GoWYclpuLOjiyjH/ZYMAboeWK/ucpwvb5XAQTq98CEZvOAP6Pj1JhYGCr
   11QlgqR0VaX1MCCg2CMcVt9Il1ImONw+1HAhCtcjmHWp7ScdmynMjsISd
   +F5qfF6fHmoDjEOewoU1XW5Xc6wMCfU6ZsOvoW6iR98qhkRZgR/hBHHgr
   H9NQrjRCpQA+jCu45ho6hktteRt/5Trn7QaYrnfHsZr8PMK443hOGn2pd
   EiV2ddPuN8jnL3aVtvKT8eKW0cbrX6oVd47f245mB4s1taNMEvLSLj61k
   w==;
X-CSE-ConnectionGUID: j7Xti8qdSVSjxYgMNfteGQ==
X-CSE-MsgGUID: mOUX5tX/T7WViWTPZrex5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="73120915"
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="73120915"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 15:51:42 -0700
X-CSE-ConnectionGUID: AbB+TaFSSv2CVu3NtC5iAg==
X-CSE-MsgGUID: lwWiY5HnTxWgmmwGAioB3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="134145113"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 15:51:40 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 30 Apr 2025 15:51:46 -0700
Subject: [PATCH v3 15/15] ice: change default clock source for E825-C
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-kk-tspll-improvements-alignment-v3-15-ab8472e86204@intel.com>
References: <20250430-kk-tspll-improvements-alignment-v3-0-ab8472e86204@intel.com>
In-Reply-To: <20250430-kk-tspll-improvements-alignment-v3-0-ab8472e86204@intel.com>
To: Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 netdev <netdev@vger.kernel.org>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Milena Olech <milena.olech@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Karol Kolacinski <karol.kolacinski@intel.com>
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

Change the default clock source for E825-C to TIME_REF. Longer term, a
proper interface (perhaps through dpll subsystem?) to introspect and
configure the clock source should be designed.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index e5099a3ccb854424f98c5fb1524f49bde1ca4534..bfa3f58c1104def9954073501012bb58a13e8821 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2302,7 +2302,7 @@ ice_parse_1588_func_caps(struct ice_hw *hw, struct ice_hw_func_caps *func_p,
 		info->clk_src = ((number & ICE_TS_CLK_SRC_M) != 0);
 	} else {
 		info->clk_freq = ICE_TSPLL_FREQ_156_250;
-		info->clk_src = ICE_CLK_SRC_TCXO;
+		info->clk_src = ICE_CLK_SRC_TIME_REF;
 	}
 
 	if (info->clk_freq < NUM_ICE_TSPLL_FREQ) {

-- 
2.48.1.397.gec9d649cc640


