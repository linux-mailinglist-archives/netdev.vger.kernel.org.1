Return-Path: <netdev+bounces-175878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0F8A67DA8
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 21:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FFBF19C5262
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 20:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CF11E7C12;
	Tue, 18 Mar 2025 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mHssNSZk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFCC1DC9BA
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328322; cv=none; b=XIrKoZJGcpTwxY9TCfY8a2/dIBv5fgktJ/0qAI5tpBImXYBgxMMQ9g6Z4ZxJt32IkBG5FhF3lb0TwRJssodNwUPHMv2JRE3/8qsJKW5nhhzXAOz3q3VlHoyXVW0XMegBGXCAx88ozeWoSYPgo3qDCxUhspTE4Vwa0NT/xXviBdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328322; c=relaxed/simple;
	bh=Rkkm5bbeS//M3rYAjHlDLinhHjL45pJ9oUu2SwinxMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3DQwhOXu4hjkgO6NDBseo0tm5+ShoW/DV8JD++YxdT6Jf+U6y/c5zpC4izD0Mia6ht3XvwQW7N55O0LL4KGo0GoghzAoh71UpT1Y2TZsUUWnUDdLr6F88Pf+X856hWmCKVMQsLa81Iwfv6qZ5eZHdG72A4uvTqAvR1K4JnV/7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mHssNSZk; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742328321; x=1773864321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rkkm5bbeS//M3rYAjHlDLinhHjL45pJ9oUu2SwinxMg=;
  b=mHssNSZkfEFjBcovhgc+KVbRGPRnbLv7TwsQTiE8L8Djzv/A8Khej20s
   7nZbsymgw2BIjpbpjOs1U8ycINhoEKtRtI5YsFwYZn89n3YMUnhAKJ0UW
   04Wr66Txzpau/KjKrbKaM1ItPQkWxjjjoccjjlEG68E38ZoEMo3mZ9+lI
   voGAKE87lW6bHMHiHWlU4qKWcjWQVdfP7K9rkTQFeHHK8K81S3OEXpcOp
   UcEV3gRmVMv2OLCuJ0YnNqPF60emaMbRktPErmVFdB3E+ZdrHNMRWGwj0
   Czdp2ZWO3o+lZpAvehE2SIqzPagtlqwZ9YlF/Fx6vluhcFxOfccbgqCRT
   w==;
X-CSE-ConnectionGUID: jFZy9FFeQwCITB3Ct0ck8Q==
X-CSE-MsgGUID: wrQTpz8QTEeHadOm2PR6Bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43593009"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="43593009"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 13:05:19 -0700
X-CSE-ConnectionGUID: V0LKrlPZSSGTRt2ZEumgpw==
X-CSE-MsgGUID: HE3HtwHrT92tVOkX2vOobg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="153363123"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 18 Mar 2025 13:05:18 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	konrad.knitter@intel.com,
	horms@kernel.org,
	kees@kernel.org,
	jirislaby@kernel.org,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Sunitha Mekala <sunithax.d.mekala@intel.com>
Subject: [PATCH net 1/9] ice: health.c: fix compilation on gcc 7.5
Date: Tue, 18 Mar 2025 13:04:45 -0700
Message-ID: <20250318200511.2958251-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250318200511.2958251-1-anthony.l.nguyen@intel.com>
References: <20250318200511.2958251-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

GCC 7 is not as good as GCC 8+ in telling what is a compile-time
const, and thus could be used for static storage.
Fortunately keeping strings as const arrays is enough to make old
gcc happy.

Excerpt from the report:
My GCC is: gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0.

  CC [M]  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.o
drivers/net/ethernet/intel/ice/devlink/health.c:35:3: error: initializer element is not constant
   ice_common_port_solutions, {ice_port_number_label}},
   ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ice/devlink/health.c:35:3: note: (near initialization for 'ice_health_status_lookup[0].solution')
drivers/net/ethernet/intel/ice/devlink/health.c:35:31: error: initializer element is not constant
   ice_common_port_solutions, {ice_port_number_label}},
                               ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ice/devlink/health.c:35:31: note: (near initialization for 'ice_health_status_lookup[0].data_label[0]')
drivers/net/ethernet/intel/ice/devlink/health.c:37:46: error: initializer element is not constant
   "Change or replace the module or cable.", {ice_port_number_label}},
                                              ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ice/devlink/health.c:37:46: note: (near initialization for 'ice_health_status_lookup[1].data_label[0]')
drivers/net/ethernet/intel/ice/devlink/health.c:39:3: error: initializer element is not constant
   ice_common_port_solutions, {ice_port_number_label}},
   ^~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 85d6164ec56d ("ice: add fw and port health reporters")
Reported-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Closes: https://lore.kernel.org/netdev/CY8PR11MB7134BF7A46D71E50D25FA7A989F72@CY8PR11MB7134.namprd11.prod.outlook.com
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/devlink/health.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
index ea40f7941259..19c3d37aa768 100644
--- a/drivers/net/ethernet/intel/ice/devlink/health.c
+++ b/drivers/net/ethernet/intel/ice/devlink/health.c
@@ -25,10 +25,10 @@ struct ice_health_status {
  * The below lookup requires to be sorted by code.
  */
 
-static const char *const ice_common_port_solutions =
+static const char ice_common_port_solutions[] =
 	"Check your cable connection. Change or replace the module or cable. Manually set speed and duplex.";
-static const char *const ice_port_number_label = "Port Number";
-static const char *const ice_update_nvm_solution = "Update to the latest NVM image.";
+static const char ice_port_number_label[] = "Port Number";
+static const char ice_update_nvm_solution[] = "Update to the latest NVM image.";
 
 static const struct ice_health_status ice_health_status_lookup[] = {
 	{ICE_AQC_HEALTH_STATUS_ERR_UNKNOWN_MOD_STRICT, "An unsupported module was detected.",
-- 
2.47.1


