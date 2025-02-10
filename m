Return-Path: <netdev+bounces-164763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1817EA2EF74
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 15:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4693A1D84
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 14:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27903235C0B;
	Mon, 10 Feb 2025 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJ+86JVx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A06235C08
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 14:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739196901; cv=none; b=RSl72IB/sFFjZCWqi67/5jgMZeMN0+yTA7K9u/B393X3RsRYj/f+X9Iv/CoGtGaCtUCI9P9DNwUKxP7Dgu2XC5MHsH5Wv9EGBcENnuRgAvWfoUnwmMIdjghJWAVGoPzpqn90oNO5vkGeKP6lXoeNtMVPHOQkZyJ5LfGMZHDwA7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739196901; c=relaxed/simple;
	bh=6a8XNqhpjdh8KoPlMKlU3Ph79huP/CcEuLHzfeaH9eY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OoDvmSuqmE8jGParCFo8miCi5Vcn1HiNI9EJEj/RKIxQamD+MpwFp4/G2kBjtOClq/9ZH0S5BZe/cthnYOZfocM3adI79BaKVOspY7TZ3eSXpp9qL3nfUykq3y6DYGupCftg5XSHkP3Clnn/EbHg7AKb6NkZMU3Lm/Zc8PT0PKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJ+86JVx; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739196900; x=1770732900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6a8XNqhpjdh8KoPlMKlU3Ph79huP/CcEuLHzfeaH9eY=;
  b=GJ+86JVxQFYwcy72wViv1qIqEQuhAOrn2vnSDzOrCO4rB5CqO/HSLcxw
   +dl4Fqaka5Ukduhm5NRGSsQXbV2D4/4rbZejBGxNmJBh4JVIQraDalul0
   gCsaY28wGq1otVDjsaQkGYCUcMHqQv0148S8kSUz0zudJ+rwV8WDO3Ntx
   kts8pkPoVZpev6ymsFdxI5/XCj5Iucu8AS9cLJRojueEh6MlFV85QHH1j
   k74ZpcE6HuGiXTURxyXFFDJVX7IZLY+lz1mw2sE/J8WwLcAp3MY+Q1Amf
   /i0G15hCj49qY6Yz/zl4zoplsImeY21EbAAVqzd7V7FoefZLWJMCavqz3
   g==;
X-CSE-ConnectionGUID: EQtAmYXdQiOunc4n29bjcw==
X-CSE-MsgGUID: i+L71wIKSbiQt6bhCHsdCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39927458"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="39927458"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 06:14:59 -0800
X-CSE-ConnectionGUID: bvPDu8AJSt2+gIAeUahn0A==
X-CSE-MsgGUID: Dd0+l4v1TQSNt9TjUVlSJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117421027"
Received: from gklab-003-001.igk.intel.com ([10.211.3.1])
  by orviesa005.jf.intel.com with ESMTP; 10 Feb 2025 06:14:57 -0800
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH iwl-next v2 1/3] ice: rename ice_ptp_init_phc_eth56g function
Date: Mon, 10 Feb 2025 15:11:10 +0100
Message-Id: <20250210141112.3445723-2-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250210141112.3445723-1-grzegorz.nitka@intel.com>
References: <20250210141112.3445723-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Refactor the code by changing ice_ptp_init_phc_eth56g function
name to ice_ptp_init_phc_e825, to be consistent with the naming pattern
for other devices.

Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 3e824f7b30c0..fbaf2819e40e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2650,18 +2650,17 @@ static void ice_sb_access_ena_eth56g(struct ice_hw *hw, bool enable)
 }
 
 /**
- * ice_ptp_init_phc_eth56g - Perform E82X specific PHC initialization
+ * ice_ptp_init_phc_e825 - Perform E825 specific PHC initialization
  * @hw: pointer to HW struct
  *
- * Perform PHC initialization steps specific to E82X devices.
+ * Perform E825-specific PTP hardware clock initialization steps.
  *
- * Return:
- * * %0     - success
- * * %other - failed to initialize CGU
+ * Return: 0 on success, negative error code otherwise.
  */
-static int ice_ptp_init_phc_eth56g(struct ice_hw *hw)
+static int ice_ptp_init_phc_e825(struct ice_hw *hw)
 {
 	ice_sb_access_ena_eth56g(hw, true);
+
 	/* Initialize the Clock Generation Unit */
 	return ice_init_cgu_e82x(hw);
 }
@@ -6123,7 +6122,7 @@ int ice_ptp_init_phc(struct ice_hw *hw)
 	case ICE_MAC_GENERIC:
 		return ice_ptp_init_phc_e82x(hw);
 	case ICE_MAC_GENERIC_3K_E825:
-		return ice_ptp_init_phc_eth56g(hw);
+		return ice_ptp_init_phc_e825(hw);
 	default:
 		return -EOPNOTSUPP;
 	}
-- 
2.39.3


