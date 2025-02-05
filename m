Return-Path: <netdev+bounces-162938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FB1A2885D
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 11:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 684EA7A94CB
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 10:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D23B22C339;
	Wed,  5 Feb 2025 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FgtdGvGY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E28122AE73
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738752197; cv=none; b=jTYo8dx0zoWJ2WUtlQaivQcpxN+wdBlrmcm8I/sZlVW0VA6WAtBhA+zrZJecKD8CiJyiJ1sw4ejBt+cZPqSo7l1KyESGQwDx3Tl93mvQzn4hRf3jMRcXHoVUYtP8vixgqcLV8MAwyt3yIERHrPF0JnpjMfxcfbwTAE01sRleAx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738752197; c=relaxed/simple;
	bh=4Ag5ibDA/QpCTvAlojzppiuL7T6KCryqcE51LrTwlJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kIIQVI8bMNjquofIKo9pKu6DRkuLxtnSEz1L1L+jh23frXo9p88jOWm8jaPZlxE/QfnmjVHlA9J4Zip4AwDuxpdsLgD1g62ozDCKzvThpqDQsntvEXm5xS2ywgtSWuru3ymxSMWh7SxYLxhKn5H92bD4on2x30Gv7QMFQwxonI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FgtdGvGY; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738752196; x=1770288196;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4Ag5ibDA/QpCTvAlojzppiuL7T6KCryqcE51LrTwlJE=;
  b=FgtdGvGYMT0IrhSMQxeO2elC0OnTUOY2qrW3F/Z2IS6vlp+YSilnlr40
   sgv/k0Ly1p4/zx0+tOe6mIsiZvQ7jsq3eaDB25UZEWGGXNe7oM293A98p
   kJIApMAvdlyVi7c+QardYT/ecc7xhDu5v+qy9yytDgD6aYSi1sjgb4cnA
   vdx97VxSOE63xc25yypTps6RsTlYJnG6qrcci23ihbXhEdlD2ntpYq4Am
   STpQAFIX3QjukufxZ75eIThv171AED5eff66+iXEOqVUJFKJS4PX2QFuE
   phKMpTpE2lCKcr39YAZwcAL4m6WSjOY4f6ZUsib+rtgcWA6J/j35BZdiY
   w==;
X-CSE-ConnectionGUID: NueEUZzSTC60Nff8F3MLcQ==
X-CSE-MsgGUID: Okk4AsJPTyW+9Lg8YNimXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39453190"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="39453190"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 02:43:16 -0800
X-CSE-ConnectionGUID: F2mt01+/Rc+vMCUx0oi0pQ==
X-CSE-MsgGUID: cVvQEpvDT5GIYb/7SfZTPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116061698"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa005.jf.intel.com with ESMTP; 05 Feb 2025 02:43:12 -0800
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.246.222])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 2A8A22FC63;
	Wed,  5 Feb 2025 10:43:10 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Konrad Knitter <konrad.knitter@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Nick Desaulniers <nick.desaulniers@gmail.com>
Subject: [PATCH iwl-net] ice: health.c: fix compilation on gcc 7.5
Date: Wed,  5 Feb 2025 11:42:12 +0100
Message-ID: <20250205104252.30464-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GCC 7 is not as good as GCC 8+ in telling what is a compile-time const,
and thus could be used for static storage. So we could not use variables
for that, no matter how much "const" keyword is sprinkled around.

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
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
I would really like to bump min gcc to 8.5 (RH 8 family),
instead of supporting old Ubuntu. However SLES 15 is also stuck with gcc 7.5 :(

CC: Linus Torvalds <torvalds@linux-foundation.org>
CC: Kees Cook <kees@kernel.org>
CC: Nick Desaulniers <nick.desaulniers@gmail.com>
---
 drivers/net/ethernet/intel/ice/devlink/health.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
index ea40f7941259..4bc546bafad1 100644
--- a/drivers/net/ethernet/intel/ice/devlink/health.c
+++ b/drivers/net/ethernet/intel/ice/devlink/health.c
@@ -23,12 +23,12 @@ struct ice_health_status {
  * For instance, Health Code 0x1002 is triggered when the command fails.
  * Such codes should be disregarded by the end-user.
  * The below lookup requires to be sorted by code.
+ * #defines instead of proper const strings are used due to gcc 7 limitation.
  */
 
-static const char *const ice_common_port_solutions =
-	"Check your cable connection. Change or replace the module or cable. Manually set speed and duplex.";
-static const char *const ice_port_number_label = "Port Number";
-static const char *const ice_update_nvm_solution = "Update to the latest NVM image.";
+#define ice_common_port_solutions	"Check your cable connection. Change or replace the module or cable. Manually set speed and duplex."
+#define ice_port_number_label		"Port Number"
+#define ice_update_nvm_solution		"Update to the latest NVM image."
 
 static const struct ice_health_status ice_health_status_lookup[] = {
 	{ICE_AQC_HEALTH_STATUS_ERR_UNKNOWN_MOD_STRICT, "An unsupported module was detected.",

base-commit: 4241a702e0d0c2ca9364cfac08dbf134264962de
-- 
2.46.0


