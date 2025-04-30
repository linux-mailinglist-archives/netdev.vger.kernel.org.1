Return-Path: <netdev+bounces-187175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F70AA583F
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 00:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216113BE669
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 22:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEBD22A1E6;
	Wed, 30 Apr 2025 22:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QSDzajk+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CFE228CB8
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 22:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746053509; cv=none; b=rYpMyAVhe7tvEt+ylaaIrMhbF5IphAIEbL3vco7wEOHMKvdyQjPXFGuXvVzsvaJ2NhQWzvL5WlC00i9/0jAzNCTuVn+5XshgmTaEtU4DDPthsHehIBhHBCosPaaWq9rl2lNA8ZpWVcCl0+5ct9UU6AUk5Z67PEbmv4MCMtpwcSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746053509; c=relaxed/simple;
	bh=X7lId7WwhQNC4nb7A9C9GnLralUdmn3VDaw3pZp3Glg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kAdcoxF1Mhbd+qb5RRz2DB5E6EkxJ9QJooiTk/L8BxSV/YPx4iYb1qzQW+g60gbLkhLcrZdJWehXrSTVG1pFn0J7z764b52WvKMoSlSvIiprskp6MlduM5b19d97RbhqVbHKW2Wes/qLupdTwxdph97IvypjNsOW+C2oB45e2RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QSDzajk+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746053508; x=1777589508;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=X7lId7WwhQNC4nb7A9C9GnLralUdmn3VDaw3pZp3Glg=;
  b=QSDzajk+amT/xZA+wjZWYBvTB5zbvQ5n8Mdd39qx+2WQEh2D0tVvpNFE
   CiQe2BDiUocd/e50fYlxdgZ6jmC9RXhI6TasIdxGPSwMYq7gmAf97jQ2h
   jNDoSWJuu/KvOAQ02+t8KB1M3znGi4hmMA4p75uCkJYBRCDq4UJVKQRK9
   IZMYmcxe9Xk47NSpRb/K87Vcm6lN+Ks9dN+GQnlfsp4p0yFi0AfUhkyE4
   yfYRB7fz+iLrB7z/zc7hLtenS3e9jJkocvHLsI6l4K+hf0KaA1T8yc1si
   709YZZxkn7gJ33Rxj9Qeg9MFSd3K8f3NN52eeSPpOT9jlsEWo80SfaQ1l
   Q==;
X-CSE-ConnectionGUID: G1JNN7PXTBeZCESQmCjdTQ==
X-CSE-MsgGUID: GKDJEHjSQU+N5RUxK722pQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="73120899"
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="73120899"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 15:51:41 -0700
X-CSE-ConnectionGUID: 0bLUkZs/R7uE7p9VN28Grw==
X-CSE-MsgGUID: cEsZJrlITK2gikvMcjPMfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="134145082"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 15:51:40 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 30 Apr 2025 15:51:36 -0700
Subject: [PATCH v3 05/15] ice: use designated initializers for TSPLL consts
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-kk-tspll-improvements-alignment-v3-5-ab8472e86204@intel.com>
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

From: Karol Kolacinski <karol.kolacinski@intel.com>

Instead of multiple comments, use designated initializers for TSPLL
consts.

Adjust ice_tspll_params_e82x fields sizes.

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.h |  8 +--
 drivers/net/ethernet/intel/ice/ice_tspll.c | 95 ++++++++++--------------------
 2 files changed, 34 insertions(+), 69 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.h b/drivers/net/ethernet/intel/ice/ice_tspll.h
index 7aef430258e23e8e65cfc37ef8436ac158fa7ee5..c0b1232cc07c3ebd73264d16fc9cd8bfaec29fec 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.h
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.h
@@ -7,18 +7,18 @@
 /**
  * struct ice_tspll_params_e82x - E82X TSPLL parameters
  * @refclk_pre_div: Reference clock pre-divisor
+ * @post_pll_div: Post PLL divisor
  * @feedback_div: Feedback divisor
  * @frac_n_div: Fractional divisor
- * @post_pll_div: Post PLL divisor
  *
  * Clock Generation Unit parameters used to program the PLL based on the
  * selected TIME_REF/TCXO frequency.
  */
 struct ice_tspll_params_e82x {
-	u32 refclk_pre_div;
-	u32 feedback_div;
+	u8 refclk_pre_div;
+	u8 post_pll_div;
+	u8 feedback_div;
 	u32 frac_n_div;
-	u32 post_pll_div;
 };
 
 #define ICE_TSPLL_CK_REFCLKFREQ_E825		0x1F
diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index e973e1db2b51c9741a71ff593361dfabc5e9f2df..2c91dcd45df2e3c420e693442b4a58dd85be3ec5 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -7,76 +7,41 @@
 
 static const struct
 ice_tspll_params_e82x e82x_tspll_params[NUM_ICE_TSPLL_FREQ] = {
-	/* ICE_TSPLL_FREQ_25_000 -> 25 MHz */
-	{
-		/* refclk_pre_div */
-		1,
-		/* feedback_div */
-		197,
-		/* frac_n_div */
-		2621440,
-		/* post_pll_div */
-		6,
+	[ICE_TSPLL_FREQ_25_000] = {
+		.refclk_pre_div = 1,
+		.post_pll_div = 6,
+		.feedback_div = 197,
+		.frac_n_div = 2621440,
 	},
-
-	/* ICE_TSPLL_FREQ_122_880 -> 122.88 MHz */
-	{
-		/* refclk_pre_div */
-		5,
-		/* feedback_div */
-		223,
-		/* frac_n_div */
-		524288,
-		/* post_pll_div */
-		7,
+	[ICE_TSPLL_FREQ_122_880] = {
+		.refclk_pre_div = 5,
+		.post_pll_div = 7,
+		.feedback_div = 223,
+		.frac_n_div = 524288
 	},
-
-	/* ICE_TSPLL_FREQ_125_000 -> 125 MHz */
-	{
-		/* refclk_pre_div */
-		5,
-		/* feedback_div */
-		223,
-		/* frac_n_div */
-		524288,
-		/* post_pll_div */
-		7,
+	[ICE_TSPLL_FREQ_125_000] = {
+		.refclk_pre_div = 5,
+		.post_pll_div = 7,
+		.feedback_div = 223,
+		.frac_n_div = 524288
 	},
-
-	/* ICE_TSPLL_FREQ_153_600 -> 153.6 MHz */
-	{
-		/* refclk_pre_div */
-		5,
-		/* feedback_div */
-		159,
-		/* frac_n_div */
-		1572864,
-		/* post_pll_div */
-		6,
+	[ICE_TSPLL_FREQ_153_600] = {
+		.refclk_pre_div = 5,
+		.post_pll_div = 6,
+		.feedback_div = 159,
+		.frac_n_div = 1572864
 	},
-
-	/* ICE_TSPLL_FREQ_156_250 -> 156.25 MHz */
-	{
-		/* refclk_pre_div */
-		5,
-		/* feedback_div */
-		159,
-		/* frac_n_div */
-		1572864,
-		/* post_pll_div */
-		6,
+	[ICE_TSPLL_FREQ_156_250] = {
+		.refclk_pre_div = 5,
+		.post_pll_div = 6,
+		.feedback_div = 159,
+		.frac_n_div = 1572864
 	},
-
-	/* ICE_TSPLL_FREQ_245_760 -> 245.76 MHz */
-	{
-		/* refclk_pre_div */
-		10,
-		/* feedback_div */
-		223,
-		/* frac_n_div */
-		524288,
-		/* post_pll_div */
-		7,
+	[ICE_TSPLL_FREQ_245_760] = {
+		.refclk_pre_div = 10,
+		.post_pll_div = 7,
+		.feedback_div = 223,
+		.frac_n_div = 524288
 	},
 };
 

-- 
2.48.1.397.gec9d649cc640


