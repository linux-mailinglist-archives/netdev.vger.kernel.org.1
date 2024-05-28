Return-Path: <netdev+bounces-98789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7458D27C0
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 00:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FB1C1C22F55
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 22:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3DF13E3F5;
	Tue, 28 May 2024 22:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hsHs8zWg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9C713E028
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 22:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716933983; cv=none; b=jVW1sUOdF0QdxiJAoAN23BpCGs/6p4klS5YwrHXGBsoe5uKcs33obLxENh2Qfj2T2nKY/CRfiLf5rEjhv166GIRTv+TfLHxIQXT39RxeCP/PHTloMz2cmfamoY/SAMrxxpziAeyhRyciCOot438TUpH4GPOC9BWEa2n6EUFeUSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716933983; c=relaxed/simple;
	bh=bjhA5Vdpe7z9pQvSHAYbavmWk9Tu7+fic+3eBiTBSGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lLDZiysJgimlJmoJjm51VCDM2qIqawC5v6ufcZNKhsmK5CFiqWnKA+xtTdBKjrD/6YGPxaXwEINE7g4J9q4EJqcZ1mt/Vn2of92Cbs0SI8JL8nacqxT3KKazAhQOoYYObes00vHOWePpaKcbgwGl+UkOsp5M+rzUjzBFrpAad68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hsHs8zWg; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716933983; x=1748469983;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=bjhA5Vdpe7z9pQvSHAYbavmWk9Tu7+fic+3eBiTBSGg=;
  b=hsHs8zWgmIbrIBvbtYCeo6D1wsu5XqiiCy+Iy4n6bsDkPp4AXp7c4Fid
   Nptv0c68ZMiAJLSTRDGctSKhtL0unJQEvtJ1QFSD76XhMSRmXxyshobod
   F9bYunHE1YZetadd/mb2iOr8clFnYw3VJSb5SAZH3L2VSOMt78KRflNl7
   1w+UeA961+RTjAuJJvfUKJo/y6IHAgKuMvVCLAPwQvIQ1mAO5uTiuPOVH
   FPwTUKf/rDkoi6Yw3TcAQa+vUN9fGIfGph3ATYVs/8hEjTzq7ekxJGafi
   KcLt7VskcnOUxGRVp6FwBUSWQqa4LG7w/CoJn6Xshh71IwYKbm7iYppio
   Q==;
X-CSE-ConnectionGUID: 2rew/1wRSC+5LdrV3CaXIA==
X-CSE-MsgGUID: WRDKk6c3TauxXWGQSwkDdw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13439621"
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="13439621"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:06:19 -0700
X-CSE-ConnectionGUID: +c4XEJrdQLuKbLo9cKq1Ug==
X-CSE-MsgGUID: q6n52bj5RA2lEhi5Wq8HAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,196,1712646000"; 
   d="scan'208";a="40087525"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 15:06:18 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 28 May 2024 15:06:08 -0700
Subject: [PATCH net 5/8] ice: fix 200G PHY types to link speed mapping
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-net-2024-05-28-intel-net-fixes-v1-5-dc8593d2bbc6@intel.com>
References: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
In-Reply-To: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Paul Greenwalt <paul.greenwalt@intel.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
X-Mailer: b4 0.13.0

From: Paul Greenwalt <paul.greenwalt@intel.com>

Commit 24407a01e57c ("ice: Add 200G speed/phy type use") added support
for 200G PHY speeds, but did not include the mapping of 200G PHY types
to link speed. As a result the driver is returning UNKNOWN link speed
when setting 200G ethtool advertised link modes.

To fix this add 200G PHY types to link speed mapping to
ice_get_link_speed_based_on_phy_type().

Fixes: 24407a01e57c ("ice: Add 200G speed/phy type use")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 5649b257e631..24716a3b494c 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -3148,6 +3148,16 @@ ice_get_link_speed_based_on_phy_type(u64 phy_type_low, u64 phy_type_high)
 	case ICE_PHY_TYPE_HIGH_100G_AUI2:
 		speed_phy_type_high = ICE_AQ_LINK_SPEED_100GB;
 		break;
+	case ICE_PHY_TYPE_HIGH_200G_CR4_PAM4:
+	case ICE_PHY_TYPE_HIGH_200G_SR4:
+	case ICE_PHY_TYPE_HIGH_200G_FR4:
+	case ICE_PHY_TYPE_HIGH_200G_LR4:
+	case ICE_PHY_TYPE_HIGH_200G_DR4:
+	case ICE_PHY_TYPE_HIGH_200G_KR4_PAM4:
+	case ICE_PHY_TYPE_HIGH_200G_AUI4_AOC_ACC:
+	case ICE_PHY_TYPE_HIGH_200G_AUI4:
+		speed_phy_type_high = ICE_AQ_LINK_SPEED_200GB;
+		break;
 	default:
 		speed_phy_type_high = ICE_AQ_LINK_SPEED_UNKNOWN;
 		break;

-- 
2.44.0.53.g0f9d4d28b7e6


