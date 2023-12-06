Return-Path: <netdev+bounces-54593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571B18078AB
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 20:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBD12B2100C
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 19:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F4947F4E;
	Wed,  6 Dec 2023 19:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OC24h0lZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E6D1BD
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 11:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701890973; x=1733426973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zvt6CXhVc5yk2Dn7HEiJ060mJD3yzsu7T/YQ7hMWXyk=;
  b=OC24h0lZ0MRypSH3tT+zkKcZCbnLcVdPb2Mb4SOncBS9BgT+a4QQ48B8
   F2WySM3cj5q4YQMYzp3WmnU1y9U8wmRyTmkOE7as3S3f1cYsjOhfwmjwm
   wQjTA3onJRECs+elsV342I0/owrLSpxKbmAWbAwHHkdFveCdvbQOnJNAV
   +3xpR4RBpojs6uqYz6n+3fDKfOhKKv6B5jZHF/hPUx1hE5HFAPzPjIdgR
   2Lcl1TjMDYwv3V224p0IInJ3UEmAUxKTYjV+DI1hNLTnn3xBIAisV9iLx
   8Cj4AjnINkIHNmUOOPLjevB8z8a0fPv9qIKqyYxbXd6T9HeKgAbke7kSH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1214442"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1214442"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 11:29:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="889446524"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="889446524"
Received: from unknown (HELO gklab-003-001.igk.intel.com) ([10.211.3.1])
  by fmsmga002.fm.intel.com with ESMTP; 06 Dec 2023 11:29:32 -0800
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH iwl-next v1 3/3] ice: add support for 3k signing DDP sections for E825C
Date: Wed,  6 Dec 2023 20:29:19 +0100
Message-Id: <20231206192919.3826128-4-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231206192919.3826128-1-grzegorz.nitka@intel.com>
References: <20231206192919.3826128-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

E825C devices shall support the new signing type of RSA 3K for new DDP
section (SEGMENT_SIGN_TYPE_RSA3K_E825 (5) - already in the code).
The driver is responsible to verify the presence of correct signing type.
Add 3k signinig support for E825C devices based on mac_type:
ICE_MAC_GENERIC_3K_E825;

Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 6 ++++++
 drivers/net/ethernet/intel/ice/ice_ddp.c    | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 2a973fac8e54..cf4d7287f716 100644
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
2.39.3


