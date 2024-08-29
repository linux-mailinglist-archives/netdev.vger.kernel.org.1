Return-Path: <netdev+bounces-123222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B49F96431F
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 13:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E94A1F238C2
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 11:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8191922E3;
	Thu, 29 Aug 2024 11:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SFq6xNRB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930FF191F9E
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 11:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931191; cv=none; b=SI31CBQu920OKVYNlwDmApw4Kqs+tEVI5+rVvSX+ihRunHAhl3cSuSXhhAaW4PHRhacPcQjUpWOCj0v27yK2suTQ5EmT5Rf/uVoN1CuBS/sA65o3f5Ri9vNaWHN2s7n5/HDEW9Malacaafcr1UDCueP/XYEs+nOiCgUxNQRJMv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931191; c=relaxed/simple;
	bh=If+Z7mrgpTFgl4Ce+4n6Qlb4wefvbL9BNglcNr4a2j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NpM0IA5YCA/Ejd4aGd4gwMBMLFqBit4xnYEQHPEHHxzo0Ks/yDedgsDsziI2Z+2OjSzuje8a+I+Qo+BIWYKNIbUbeHaS+9fM5rd+aoTBCGEQxhuQWqmI7N0Arpq21Uw3Q7uS/30J97nsB4UZuMaCKvG0SbqVBaHpBJ/6dKi2y9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SFq6xNRB; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724931189; x=1756467189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=If+Z7mrgpTFgl4Ce+4n6Qlb4wefvbL9BNglcNr4a2j0=;
  b=SFq6xNRBhWW07waRKdaG49XCrLwPcOzU4OLWBxmxhw5mH5HKOJACuu0H
   4zKrkpTK4/qCPrzQPHZoQW7jNHrG9rxIp22V5/2wb3182iFyALOEE/uA0
   KMhyJ0OJ7U+UGCkvnhzgtCjgoYt9aDD17PKCX81fMIC3z9LFVMnpm9b8j
   UwEGavIrbspt5DVKzz2Ht5730zpOv6T+wtkFqEZGPOiSNhmDMeXjOQbtu
   tICRxHmDuiEsPLzWWnuwHFHVZ6ujNq2XZmqc47eMlcxAs+koGvoJSYyZp
   NnUflNVEvneaxCoHsllxHqlfr1SNvAbDruhkXVcxK2G3wuMDW34KnZN8Q
   A==;
X-CSE-ConnectionGUID: nu1XAPXbT6aCvLRvtpEE+w==
X-CSE-MsgGUID: cu8rCFtIR/ODtFRfEeu/0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23677867"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="23677867"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 04:33:09 -0700
X-CSE-ConnectionGUID: ux8s74g/QomTlF0xF9Hb6w==
X-CSE-MsgGUID: f+IAcxfDQYC5guOZ5Di9rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="63230590"
Received: from kkolacin-desk1.igk.intel.com ([10.217.160.108])
  by fmviesa007.fm.intel.com with ESMTP; 29 Aug 2024 04:33:08 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH v3 iwl-next 2/7] ice: Add SDPs support for E825C
Date: Thu, 29 Aug 2024 13:28:09 +0200
Message-ID: <20240829113257.1023835-11-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829113257.1023835-9-karol.kolacinski@intel.com>
References: <20240829113257.1023835-9-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support of PTP SDPs (Software Definable Pins) for E825C products.

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
V1 -> V2: Removed redundant n_pins assignment and enable and verify move

 drivers/net/ethernet/intel/ice/ice_ptp.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 0afea1d87f1a..f5b9b2d30880 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -20,6 +20,16 @@ static const struct ice_ptp_pin_desc ice_pin_desc_e82x[] = {
 	{  ONE_PPS,   { -1,  5 }},
 };
 
+static const struct ice_ptp_pin_desc ice_pin_desc_e825c[] = {
+	/* name,        gpio */
+	{  SDP0,      {  0,  0 }},
+	{  SDP1,      {  1,  1 }},
+	{  SDP2,      {  2,  2 }},
+	{  SDP3,      {  3,  3 }},
+	{  TIME_SYNC, {  4, -1 }},
+	{  ONE_PPS,   { -1,  5 }},
+};
+
 static const struct ice_ptp_pin_desc ice_pin_desc_e810[] = {
 	/* name,      gpio */
 	{  SDP0,    {  0, 0 }},
@@ -2624,8 +2634,14 @@ static void ice_ptp_set_funcs_e82x(struct ice_pf *pf)
 #endif /* CONFIG_ICE_HWTS */
 	pf->ptp.info.enable = ice_ptp_gpio_enable;
 	pf->ptp.info.verify = ice_verify_pin;
-	pf->ptp.ice_pin_desc = ice_pin_desc_e82x;
-	pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e82x);
+
+	if (ice_is_e825c(&pf->hw)) {
+		pf->ptp.ice_pin_desc = ice_pin_desc_e825c;
+		pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e825c);
+	} else {
+		pf->ptp.ice_pin_desc = ice_pin_desc_e82x;
+		pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e82x);
+	}
 	ice_ptp_setup_pin_cfg(pf);
 }
 
-- 
2.46.0


