Return-Path: <netdev+bounces-160859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A643A1BDE7
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 22:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58A167A3BDF
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 21:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B901EE7B3;
	Fri, 24 Jan 2025 21:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KegWzRqb"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AE61E98FC
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 21:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737754345; cv=none; b=H3ut60alyoSFK02ydPzIeuV7ycsdWk+UFa3dE7Rkk/I+m3TlvyQxA7tDfh7OxZlo2ovgR5mormOhQTCGzGn45RrF/U0rgwdqk32mI2MexLYF7TY/AF+oOjG5f7ySd89ZmzCNvpo4zZQ7cu4pr+yed78+trfIAOOVkNIzjswEInk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737754345; c=relaxed/simple;
	bh=ZrV+XyRuM02A4ZzGb2Qkos38j0RdBLVlDnc5T18iG6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVOobaMmdl9UVF/ilzeV4HYbENEET5VIRS9gQB5pA58sV/uD+bjPQNSVFW2fKybbc60ViX+3oh0x5lPWOru/4TaAuc7FR/Uj4G3UW9HqXElWrM/F2x5Vby33YD9YVj1y4klka5/CNpZZX68CEv0PqSBX5WnlXz6pWKg/2OaVbNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KegWzRqb; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737754344; x=1769290344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZrV+XyRuM02A4ZzGb2Qkos38j0RdBLVlDnc5T18iG6w=;
  b=KegWzRqb+rMLsVU1Srw9SLXnxpLE81PeSTWLN9IdQEDt5jAUUQTFxCby
   sIVkE+Nz64aq8XQMvwyLElnt1ixSP6wDWLhgsDh/Fm8cl1zqvl8BNiXBT
   7ik1O8lTcOw8DJB5HD685x0L16DK80PrHEeUDdXcFKWzmLVXR3LP5i17P
   eLpzMrgkuGCSXsCLeidgVho5pQWZjygsJsA9VmPKsMxXBggXTzsOC3SxA
   kdfsjjQGptWTjAVV5t8NjgIjfzqXjA0i70VY+72+eOrSri48l9Xo6oga8
   o7f7KtBaH3Os6x72xIo+7Mw3/ihuvoGzfLu7AwohQ9c97x243C8JEJFac
   Q==;
X-CSE-ConnectionGUID: WvU6E5rcQNOHTAllwMWlww==
X-CSE-MsgGUID: 4HEZhcJSSvCowBTvVoJdWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="41140424"
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="41140424"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 13:32:18 -0800
X-CSE-ConnectionGUID: yDYGrgq6ScOsMdSGmCiEKw==
X-CSE-MsgGUID: lgfVZouoQES3Moyw+7e02Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="107861096"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 24 Jan 2025 13:32:17 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 7/8] ice: remove invalid parameter of equalizer
Date: Fri, 24 Jan 2025 13:32:09 -0800
Message-ID: <20250124213213.1328775-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250124213213.1328775-1-anthony.l.nguyen@intel.com>
References: <20250124213213.1328775-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

It occurred that in the commit 70838938e89c ("ice: Implement driver
functionality to dump serdes equalizer values") the invalid DRATE parameter
for reading has been added. The output of the command:

  $ ethtool -d <ethX>

returns the garbage value in the place where DRATE value should be
stored.

Remove mentioned parameter to prevent return of corrupted data to
userspace.

Fixes: 70838938e89c ("ice: Implement driver functionality to dump serdes equalizer values")
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 1 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c    | 1 -
 drivers/net/ethernet/intel/ice/ice_ethtool.h    | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 01536a382e54..bdee499f991a 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1498,7 +1498,6 @@ struct ice_aqc_dnl_equa_param {
 #define ICE_AQC_RX_EQU_POST1 (0x12 << ICE_AQC_RX_EQU_SHIFT)
 #define ICE_AQC_RX_EQU_BFLF (0x13 << ICE_AQC_RX_EQU_SHIFT)
 #define ICE_AQC_RX_EQU_BFHF (0x14 << ICE_AQC_RX_EQU_SHIFT)
-#define ICE_AQC_RX_EQU_DRATE (0x15 << ICE_AQC_RX_EQU_SHIFT)
 #define ICE_AQC_RX_EQU_CTLE_GAINHF (0x20 << ICE_AQC_RX_EQU_SHIFT)
 #define ICE_AQC_RX_EQU_CTLE_GAINLF (0x21 << ICE_AQC_RX_EQU_SHIFT)
 #define ICE_AQC_RX_EQU_CTLE_GAINDC (0x22 << ICE_AQC_RX_EQU_SHIFT)
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 3072634bf049..f241493a6ac8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -710,7 +710,6 @@ static int ice_get_tx_rx_equa(struct ice_hw *hw, u8 serdes_num,
 		{ ICE_AQC_RX_EQU_POST1, rx, &ptr->rx_equ_post1 },
 		{ ICE_AQC_RX_EQU_BFLF, rx, &ptr->rx_equ_bflf },
 		{ ICE_AQC_RX_EQU_BFHF, rx, &ptr->rx_equ_bfhf },
-		{ ICE_AQC_RX_EQU_DRATE, rx, &ptr->rx_equ_drate },
 		{ ICE_AQC_RX_EQU_CTLE_GAINHF, rx, &ptr->rx_equ_ctle_gainhf },
 		{ ICE_AQC_RX_EQU_CTLE_GAINLF, rx, &ptr->rx_equ_ctle_gainlf },
 		{ ICE_AQC_RX_EQU_CTLE_GAINDC, rx, &ptr->rx_equ_ctle_gaindc },
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.h b/drivers/net/ethernet/intel/ice/ice_ethtool.h
index 8f2ad1c172c0..23b2cfbc9684 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.h
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.h
@@ -15,7 +15,6 @@ struct ice_serdes_equalization_to_ethtool {
 	int rx_equ_post1;
 	int rx_equ_bflf;
 	int rx_equ_bfhf;
-	int rx_equ_drate;
 	int rx_equ_ctle_gainhf;
 	int rx_equ_ctle_gainlf;
 	int rx_equ_ctle_gaindc;
-- 
2.47.1


