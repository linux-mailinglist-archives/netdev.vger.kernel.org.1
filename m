Return-Path: <netdev+bounces-107822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8177491C72D
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 22:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE431B238E8
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 20:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF4413AA35;
	Fri, 28 Jun 2024 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FOwZPdDZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9287A715
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719605626; cv=none; b=ZRztHnUKHyYzxUtR/Ip76Aff9N3ja/2H4tRt342ijptbjTCXzeNLo9MqWTaQ9xFuYMKZBgDkkLrQ2ycK3RidSLD2yMlZ6ld09tJTceG5zb1oiO2fs6KxWu47OsyNDhaoSpv/BY/qcmynm5IKKuaJdjD15kO0/rNgbeMgo7gqJJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719605626; c=relaxed/simple;
	bh=CAxcZH+NrpatAL3bUe6zzlaJe/uUM5njK7rQLTWoiRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSKylZm8Vamwgzs5G+O5uCagww/lRGx94l/uoe0TwhOIz7NjBM+InuEfy/YLFi93DQ2RLh8mTSgMRUc9kLlZvUB2lGnj/6TtAwnXcExGBfri/SQNHowL6aH+AOn63qrcRVhUNGNeDM5WXLL0dXToEWclf8WEsiXs3hs9TvVNW9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FOwZPdDZ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719605625; x=1751141625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CAxcZH+NrpatAL3bUe6zzlaJe/uUM5njK7rQLTWoiRQ=;
  b=FOwZPdDZjg7ZgCAsejp8wbNVYueLvll4k2dV08jqkGzYbitQE4hxQwQD
   2CNX8zLqCtW5XmNtGfd8JjXQDDOBl7bmO2jTac3CUokaeyljv2grCFIqO
   3ACwyES3neRUuD7R90Ff0kbKTgyvUZ/t0vNbzcpGr9poUN1ZEkmBI/rjZ
   Xr7aUes01bkjGter1d7++Q5NaDucFOBaiv8eUCpJ418cbp1bhpkxgDSFi
   e2tqQ2OUVhLIXZsQOQj0v7LRIA+P4OsEy6/cHfSmYRtlYZVAubhrkjSo2
   qGWZISKtLWSDrs4L+yhYqxzsp4ab9y65XNz3Yk4MBYbchk4Cg/28XI5Wb
   A==;
X-CSE-ConnectionGUID: TPxwFG13Q1ixb9YhqRvDaQ==
X-CSE-MsgGUID: Bl9PLFnoQ9+50ppdWt4MCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="20674921"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="20674921"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 13:13:42 -0700
X-CSE-ConnectionGUID: 73U08+TnSxGB4cXoRRNA4g==
X-CSE-MsgGUID: zf8Q4g7XQUiRj5FQrPTl+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="49735532"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 28 Jun 2024 13:13:42 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>,
	anthony.l.nguyen@intel.com,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 4/6] ice: Allow different FW API versions based on MAC type
Date: Fri, 28 Jun 2024 13:13:22 -0700
Message-ID: <20240628201328.2738672-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628201328.2738672-1-anthony.l.nguyen@intel.com>
References: <20240628201328.2738672-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Greenwalt <paul.greenwalt@intel.com>

Allow the driver to be compatible with different FW API versions based
on the device's MAC type. Currently, E810 is only compatible with one
FW API version. Now the driver can be compatible with different FW API
versions for both E810 and E830. For example, E810 FW API version is
1.5.0 and E830 is 1.7.0.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_controlq.c | 11 +++++++----
 drivers/net/ethernet/intel/ice/ice_controlq.h | 15 ++++++++++++---
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
index ffe660f34992..ca80b34f2f8a 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.c
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
@@ -510,16 +510,19 @@ static int ice_shutdown_sq(struct ice_hw *hw, struct ice_ctl_q_info *cq)
  */
 static bool ice_aq_ver_check(struct ice_hw *hw)
 {
-	if (hw->api_maj_ver > EXP_FW_API_VER_MAJOR) {
+	u8 exp_fw_api_ver_major = EXP_FW_API_VER_MAJOR_BY_MAC(hw);
+	u8 exp_fw_api_ver_minor = EXP_FW_API_VER_MINOR_BY_MAC(hw);
+
+	if (hw->api_maj_ver > exp_fw_api_ver_major) {
 		/* Major API version is newer than expected, don't load */
 		dev_warn(ice_hw_to_dev(hw),
 			 "The driver for the device stopped because the NVM image is newer than expected. You must install the most recent version of the network driver.\n");
 		return false;
-	} else if (hw->api_maj_ver == EXP_FW_API_VER_MAJOR) {
-		if (hw->api_min_ver > (EXP_FW_API_VER_MINOR + 2))
+	} else if (hw->api_maj_ver == exp_fw_api_ver_major) {
+		if (hw->api_min_ver > (exp_fw_api_ver_minor + 2))
 			dev_info(ice_hw_to_dev(hw),
 				 "The driver for the device detected a newer version of the NVM image than expected. Please install the most recent version of the network driver.\n");
-		else if ((hw->api_min_ver + 2) < EXP_FW_API_VER_MINOR)
+		else if ((hw->api_min_ver + 2) < exp_fw_api_ver_minor)
 			dev_info(ice_hw_to_dev(hw),
 				 "The driver for the device detected an older version of the NVM image than expected. Please update the NVM image.\n");
 	} else {
diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.h b/drivers/net/ethernet/intel/ice/ice_controlq.h
index 8f2fd1613a95..1d54b1cdb1c5 100644
--- a/drivers/net/ethernet/intel/ice/ice_controlq.h
+++ b/drivers/net/ethernet/intel/ice/ice_controlq.h
@@ -21,9 +21,18 @@
 /* Defines that help manage the driver vs FW API checks.
  * Take a look at ice_aq_ver_check in ice_controlq.c for actual usage.
  */
-#define EXP_FW_API_VER_BRANCH		0x00
-#define EXP_FW_API_VER_MAJOR		0x01
-#define EXP_FW_API_VER_MINOR		0x05
+#define EXP_FW_API_VER_MAJOR_E810	0x01
+#define EXP_FW_API_VER_MINOR_E810	0x05
+
+#define EXP_FW_API_VER_MAJOR_E830	0x01
+#define EXP_FW_API_VER_MINOR_E830	0x07
+
+#define EXP_FW_API_VER_MAJOR_BY_MAC(hw) ((hw)->mac_type == ICE_MAC_E830 ? \
+					 EXP_FW_API_VER_MAJOR_E830 : \
+					 EXP_FW_API_VER_MAJOR_E810)
+#define EXP_FW_API_VER_MINOR_BY_MAC(hw) ((hw)->mac_type == ICE_MAC_E830 ? \
+					 EXP_FW_API_VER_MINOR_E830 : \
+					 EXP_FW_API_VER_MINOR_E810)
 
 /* Different control queue types: These are mainly for SW consumption. */
 enum ice_ctl_q {
-- 
2.41.0


