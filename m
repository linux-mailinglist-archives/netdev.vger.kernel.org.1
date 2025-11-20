Return-Path: <netdev+bounces-240482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E31C7568E
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88DE4360E5A
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB163702F9;
	Thu, 20 Nov 2025 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eeHWdSgE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29616376BC0;
	Thu, 20 Nov 2025 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656110; cv=none; b=d+OzFMOCS5/1CuMqbNYAWd2I9jOsbZ1du3ubX6Oulz0pGv5oJNbAAXiMi1KuBtTwGEyTQHFYILmLoE3N5Gz/aBJ5V3en3jCX9X7AIkqA9L4v4jvADUxlQhaly+ph8uOJsigfnryK1/RUf8YUsFmDZYQR6ASBuiPywf96Q+H1x+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656110; c=relaxed/simple;
	bh=Lh+5jACMhiO/2Y5m+VvRKadn77MvcK31xvDS10Hga1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjEXW1U1BfJ/1MtfuxcGkyiQu7siz3ESTzfARszFKtadxeDY3hRtkySpKZf+iRTR+AB4SmsdE0E7W1g3VXEJk23IikDE80ZsfLxYIDNXv3uub2KishuNwvpxY0/KqQMXu1r/ubxA/3tDBKOYmiXdoIlWHjnB3oKYCCY+Q+g+0mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eeHWdSgE; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763656109; x=1795192109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lh+5jACMhiO/2Y5m+VvRKadn77MvcK31xvDS10Hga1g=;
  b=eeHWdSgEYXxCHpnkeGmCAHTQySUBZfcMCLDb+wfNbYhV/t9d8PGnkc3o
   Mm5txqosZmcc9ijLyWt7Lk7Xex6GcNUq04vjIGZgDIZDswnY3Sm863Ti+
   LpwfpjadkvzBkg7Wmbnxijhbl+15Dvt4D2m08/7j7xWGkflWQHDRppI9K
   YFOlOIhIGzeKPU/Lm6prDgVTBzYKx1gpaGJNX/OYAWCQ0VGpEzkfmvUxN
   iRlZsRU1yAz8frIWnb2U2Vq5wHRzJybhkPxQWZDAthORI14yiBczONRbW
   In2nrkbDoStR3g+T6w81HY17DsO1PeoJ5pc9B53D0mIJcksJFyVXOvc81
   g==;
X-CSE-ConnectionGUID: jFAf6G+JQNCZt672X9YSRw==
X-CSE-MsgGUID: SnrSC7q9RuWXtUU8XUYwsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="69599308"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="69599308"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 08:28:29 -0800
X-CSE-ConnectionGUID: CQw5iJrYTVe8N6t16ut0pw==
X-CSE-MsgGUID: be4QnUz6S4GKgwOXDdNJ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="191531300"
Received: from hpe-dl385gen10.igk.intel.com ([10.91.240.117])
  by orviesa008.jf.intel.com with ESMTP; 20 Nov 2025 08:28:27 -0800
From: Jakub Slepecki <jakub.slepecki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jakub.slepecki@intel.com
Subject: [PATCH iwl-next 6/8] ice: add functions to query for vsi's pvids
Date: Thu, 20 Nov 2025 17:28:11 +0100
Message-ID: <20251120162813.37942-7-jakub.slepecki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120162813.37942-1-jakub.slepecki@intel.com>
References: <20251120162813.37942-1-jakub.slepecki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

PVID information is set across two structs and several members depending
primarily on DVM support and VSI type.  This commit adds function that
guess whether PVID is set and where and allow to access raw VLAN ID set.
This is intended to be used later on to decide what MAC{,VLAN} filters
to set for a VSI.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jakub Slepecki <jakub.slepecki@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 56 ++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_lib.h |  2 +
 2 files changed, 58 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 44f3c2bab308..55ba043f8f5e 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -4059,3 +4059,59 @@ void ice_vsi_update_l2tsel(struct ice_vsi *vsi, enum ice_l2tsel l2tsel)
 		wr32(hw, qrx_context_offset, regval);
 	}
 }
+
+/**
+ * ice_vsi_has_outer_pvid - check if VSI has outer Port VLAN ID assigned
+ * @info: props of VSI in question
+ *
+ * Return: true if VSI has outer PVID, false otherwise.
+ */
+static bool
+ice_vsi_has_outer_pvid(const struct ice_aqc_vsi_props *info)
+{
+	return info->outer_vlan_flags & ICE_AQ_VSI_OUTER_VLAN_PORT_BASED_INSERT;
+}
+
+/**
+ * ice_vsi_has_inner_pvid - check if VSI has inner Port VLAN ID assigned
+ * @info: props of VSI in question
+ *
+ * Return: true if VSI has inner PVID, false otherwise.
+ */
+static bool
+ice_vsi_has_inner_pvid(const struct ice_aqc_vsi_props *info)
+{
+	return info->inner_vlan_flags & ICE_AQ_VSI_INNER_VLAN_INSERT_PVID;
+}
+
+/**
+ * ice_vsi_has_pvid - check if VSI has Port VLAN ID assigned
+ * @vsi: VSI in question
+ *
+ * Return: true if VSI has either outer or inner PVID, false otherwise.
+ */
+bool
+ice_vsi_has_pvid(struct ice_vsi *vsi)
+{
+	return ice_vsi_has_outer_pvid(&vsi->info) ||
+	       ice_vsi_has_inner_pvid(&vsi->info);
+}
+
+/**
+ * ice_vsi_pvid - retrieve VSI's Port VLAN ID
+ * @vsi: VSI in question
+ *
+ * Return: VSI's PVID; it is valid only if ice_vsi_has_pvid is true.
+ */
+u16
+ice_vsi_pvid(struct ice_vsi *vsi)
+{
+	__le16 vlan_info = 0;
+
+	if (ice_vsi_has_outer_pvid(&vsi->info))
+		vlan_info = vsi->info.port_based_outer_vlan;
+	else if (ice_vsi_has_inner_pvid(&vsi->info))
+		vlan_info = vsi->info.port_based_inner_vlan;
+
+	return le16_to_cpu(vlan_info) & VLAN_VID_MASK;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 2cb1eb98b9da..c28c69963946 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -124,4 +124,6 @@ void ice_clear_feature_support(struct ice_pf *pf, enum ice_feature f);
 void ice_init_feature_support(struct ice_pf *pf);
 bool ice_vsi_is_rx_queue_active(struct ice_vsi *vsi);
 void ice_vsi_update_l2tsel(struct ice_vsi *vsi, enum ice_l2tsel l2tsel);
+bool ice_vsi_has_pvid(struct ice_vsi *vsi);
+u16 ice_vsi_pvid(struct ice_vsi *vsi);
 #endif /* !_ICE_LIB_H_ */
-- 
2.43.0


