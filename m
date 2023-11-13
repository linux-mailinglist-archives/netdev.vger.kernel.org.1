Return-Path: <netdev+bounces-47499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC83E7EA6B0
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDF21C20A4B
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6BF2D61A;
	Mon, 13 Nov 2023 23:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jlwEkv/p"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3AF3B282
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:06:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78247D6A
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699916761; x=1731452761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z3vl+WNFvKQ9lY0bUMvbMZhJOdYrHi5dMfI7u7498u8=;
  b=jlwEkv/pkcQRlgDAbNcFPQ2hfqNyqbIZ+LchPQ80eTrTR8k6mgKjJI6v
   Fs2bi71xZUBZEZ4p33zJw1DsZeUCXfMvpLan44KiJGk0A90g7SWAjEtEz
   SRjhyPX8K8wISAgZ6aKP46nVCPfG1qKuMd2lexLKfB9mY9bsTt+gP7HwF
   wAVBORY91jSz/Ha2ZvSWy6AoMhpp8yAAGvVFpAsmBLA/Oswyj0YBDXS7T
   gS+9w8M8Zt4G7HELgmFK5WUeXFFOl7NSt28fyABZ6LAJmjBGMnN4vqGQi
   SMWwg+bUw3jtJJk5I1P1855F2dxWTnYCoOjGjdJOHvNfbsKvlfFRG2MiU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="421633165"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="421633165"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 15:06:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="12598046"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 13 Nov 2023 15:06:00 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	anthony.l.nguyen@intel.com,
	vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [PATCH net 2/4] ice: dpll: fix check for dpll input priority range
Date: Mon, 13 Nov 2023 15:05:47 -0800
Message-ID: <20231113230551.548489-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113230551.548489-1-anthony.l.nguyen@intel.com>
References: <20231113230551.548489-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Supported priority value for input pins may differ with regard of NIC
firmware version. E810T NICs with 3.20/4.00 FW versions would accept
priority range 0-31, where firmware 4.10+ would support the range 0-9
and extra value of 255.
Remove the in-range check as the driver has no information on supported
values from the running firmware, let firmware decide if given value is
correct and return extack error if the value is not supported.

Fixes: d7999f5ea64b ("ice: implement dpll interface to control cgu")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 6 ------
 drivers/net/ethernet/intel/ice/ice_dpll.h | 1 -
 2 files changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 607f534055b6..831ba6683962 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -815,12 +815,6 @@ ice_dpll_input_prio_set(const struct dpll_pin *pin, void *pin_priv,
 	struct ice_pf *pf = d->pf;
 	int ret;
 
-	if (prio > ICE_DPLL_PRIO_MAX) {
-		NL_SET_ERR_MSG_FMT(extack, "prio out of supported range 0-%d",
-				   ICE_DPLL_PRIO_MAX);
-		return -EINVAL;
-	}
-
 	mutex_lock(&pf->dplls.lock);
 	ret = ice_dpll_hw_input_prio_set(pf, d, p, prio, extack);
 	mutex_unlock(&pf->dplls.lock);
diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index bb32b6d88373..93172e93995b 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -6,7 +6,6 @@
 
 #include "ice.h"
 
-#define ICE_DPLL_PRIO_MAX	0xF
 #define ICE_DPLL_RCLK_NUM_MAX	4
 
 /** ice_dpll_pin - store info about pins
-- 
2.41.0


