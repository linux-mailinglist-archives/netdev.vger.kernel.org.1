Return-Path: <netdev+bounces-71083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EF5851F41
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 22:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B801C21E6F
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 21:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9024D10A;
	Mon, 12 Feb 2024 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nEnk283e"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C354CB22
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 21:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772334; cv=none; b=H7MxNRbSiDQ/H3OHacnjaupdifTVnAWAmKL/wfFsJA7yw2C7hnpqVH+VL/CopssNS/x7/kis5OuKrUwAr4QMxME4wLsJMmVyzKFSG1K8rJgHI76c6JZ7y0Wo8hhs1rDawGD4Ont4sgnTBPC6xcwtEuCl6WgjQ22GGiIFkyTts1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772334; c=relaxed/simple;
	bh=3XOHZS6ndgiQBDUm//SH5hcoMhJxioYbwuBe6r25oWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCy4g/DmAG2x+CfRoe242YemNPv+0GcylFbogq71u2Jx3xThUDOHe6W7wL6P9fWV0E56kXlgMG5bxriUxDZPNS5/FB7ATFDLFnTlFHfK/sreZPafJHeVay5hUjz28S66WrIc0q83Kd5zjencuj0n1TgbO2BzLlLrQJQMpRFsong=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nEnk283e; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707772332; x=1739308332;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3XOHZS6ndgiQBDUm//SH5hcoMhJxioYbwuBe6r25oWE=;
  b=nEnk283e8lo2Ysoo7M/8NgRgowVdwbMrExlBz+cHMe40PBQkuvWhUFF8
   S9DHRtYzNYCkjo20ZzM1atmQTgebwYuWgOoTD5GF+auMncNuthZiLmIUJ
   Oc/oTbU88mmlr2eaS1OdPew6VpsbjmbRNhXCMk6Hm5VW+9KBQ0TF4TRFo
   dXKdrjkGwr51GlXCV4MEcSeZ6nJm7ZBzORiFgAdXR0tKZxZEies+IyWij
   0BGipPG1N0ETRbU76cy909E0LXGLhu7lugMrNuasjVbeOVB44UDGjc26j
   +qQlcYbiHuKbAbO8fwzh5ZQSds2ghYTaL8sjJLyHmHOprDW353QYYdsBZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="436910923"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="436910923"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 13:12:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="7335618"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 12 Feb 2024 13:12:07 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>,
	anthony.l.nguyen@intel.com,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 3/5] ice: add support for 3k signing DDP sections for E825C
Date: Mon, 12 Feb 2024 13:11:57 -0800
Message-ID: <20240212211202.1051990-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240212211202.1051990-1-anthony.l.nguyen@intel.com>
References: <20240212211202.1051990-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

E825C devices shall support the new signing type of RSA 3K for new DDP
section (SEGMENT_SIGN_TYPE_RSA3K_E825 (5) - already in the code).
The driver is responsible to verify the presence of correct signing type.
Add 3k signinig support for E825C devices based on mac_type:
ICE_MAC_GENERIC_3K_E825;

Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 6 ++++++
 drivers/net/ethernet/intel/ice/ice_ddp.c    | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index a7e6e5c1d06e..9266f25a9978 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -154,6 +154,12 @@ static int ice_set_mac_type(struct ice_hw *hw)
 	case ICE_DEV_ID_E823L_SFP:
 		hw->mac_type = ICE_MAC_GENERIC;
 		break;
+	case ICE_DEV_ID_E825C_BACKPLANE:
+	case ICE_DEV_ID_E825C_QSFP:
+	case ICE_DEV_ID_E825C_SFP:
+	case ICE_DEV_ID_E825C_SGMII:
+		hw->mac_type = ICE_MAC_GENERIC_3K_E825;
+		break;
 	case ICE_DEV_ID_E830_BACKPLANE:
 	case ICE_DEV_ID_E830_QSFP56:
 	case ICE_DEV_ID_E830_SFP:
diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index 8b7504a9df31..7532d11ad7f3 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -1825,6 +1825,7 @@ static u32 ice_get_pkg_segment_id(enum ice_mac_type mac_type)
 		seg_id = SEGMENT_TYPE_ICE_E830;
 		break;
 	case ICE_MAC_GENERIC:
+	case ICE_MAC_GENERIC_3K_E825:
 	default:
 		seg_id = SEGMENT_TYPE_ICE_E810;
 		break;
@@ -1845,6 +1846,9 @@ static u32 ice_get_pkg_sign_type(enum ice_mac_type mac_type)
 	case ICE_MAC_E830:
 		sign_type = SEGMENT_SIGN_TYPE_RSA3K_SBB;
 		break;
+	case ICE_MAC_GENERIC_3K_E825:
+		sign_type = SEGMENT_SIGN_TYPE_RSA3K_E825;
+		break;
 	case ICE_MAC_GENERIC:
 	default:
 		sign_type = SEGMENT_SIGN_TYPE_RSA2K;
-- 
2.41.0


