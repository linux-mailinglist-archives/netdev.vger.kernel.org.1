Return-Path: <netdev+bounces-168536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2F4A3F3CC
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 13:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2CA8189C4DB
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 12:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814C41FF7C2;
	Fri, 21 Feb 2025 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iLYDXFWm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1BE20E00D
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 12:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740139539; cv=none; b=k4Qa48U/oZO0sMmgKglT8ShaK1cJmUh0HkRJgEpGPLCKJ2E/N6Z9BPig8rAQ3wS0KRQoNUv+AHG0dCK0TpgW1JkvJQUHHg7dBXrP56zG4ssK9P0yRUxDqgFg0OTUglzFLwh7NJ9oZSDt4O7vaEVedHvEUYCUKpt5itUm8Y6R0vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740139539; c=relaxed/simple;
	bh=qHA/hoGDB7HySP4fs4EylCeTOLD3WptiKMRJmSEYaNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UGcuexeZ+ydIxLS2I+22BgbwfihZUs/X+6kl29VgjLvVUmOj50xK1zRy2F5Mg7tBIN/TTJO+k+eyccBDLqt80U1HP7PEnOjTwPABquQU3edLIJCz8DiLNaIvdM8ZFyQotrOXvklaCzzvPjY4bYZD5g+m7VYDvSZQVU1WHtifsYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iLYDXFWm; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740139534; x=1771675534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qHA/hoGDB7HySP4fs4EylCeTOLD3WptiKMRJmSEYaNE=;
  b=iLYDXFWmuiQXg9N3bj66a/FDRT1RO9/iWe0+s0fCEiqJ3G2SsEEQl7jQ
   xgJ8G9d98Br5ehrB6VdsWmhZ9AHSaH8fiCV/Bk8GGOxQLed9KM4wJiMiB
   KO5RD0zPoAs4hq99EZoLAtJBgTjTCbBb3WvbwXia6cX//99QotSIkcnaZ
   ivUuP7kdKfrxHgjNUH4ErA+npYbiGpJLXeiTbeqAvbpv/XC0VxHDQ3ZCb
   3mXgsJZDuTuPVOibn/Tzeeb6lu4QynUOU4yyWi9rRolcPD9VbJNgezFC0
   HBanhxi79+cKm3Fhr+x+3Rii30XO9iY3uJ6tapTKDfc4l/BNaO9V+U8vM
   A==;
X-CSE-ConnectionGUID: bIB1Qz1kRrqO1H6dD4KUgg==
X-CSE-MsgGUID: JY/qrPsORTe5sNs+9L3y3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="51599018"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="51599018"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 04:05:33 -0800
X-CSE-ConnectionGUID: qSIWHL/0Th2dmkO7iy4vJg==
X-CSE-MsgGUID: K8MAPAoITymrdE2dLtwM9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116260325"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa008.jf.intel.com with ESMTP; 21 Feb 2025 04:05:31 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	jiri@nvidia.com,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v5 10/15] ixgbe: extend .info_get with stored versions
Date: Fri, 21 Feb 2025 12:51:11 +0100
Message-Id: <20250221115116.169158-11-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250221115116.169158-1-jedrzej.jagielski@intel.com>
References: <20250221115116.169158-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add functions reading inactive versions from the inactive flash
banks.

Print stored NVM, OROM and netlist versions by devlink when there
is an ongoing update for E610 devices.

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Co-developed-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
Signed-off-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
Co-developed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
v3: use devlink_info_version_*_put() function; squash functions dealing with
running and stored versions into single ones
v5: add else to if/else if statements
---
 .../ethernet/intel/ixgbe/devlink/devlink.c    | 210 ++++++++++++++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |  59 +++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   3 +
 3 files changed, 250 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
index b13a10d430eb..8677d648576d 100644
--- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
+++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
@@ -6,6 +6,15 @@
 
 struct ixgbe_info_ctx {
 	char buf[128];
+	struct ixgbe_orom_info pending_orom;
+	struct ixgbe_nvm_info pending_nvm;
+	struct ixgbe_netlist_info pending_netlist;
+	struct ixgbe_hw_dev_caps dev_caps;
+};
+
+enum ixgbe_devlink_version_type {
+	IXGBE_DL_VERSION_RUNNING,
+	IXGBE_DL_VERSION_STORED
 };
 
 static void ixgbe_info_get_dsn(struct ixgbe_adapter *adapter,
@@ -20,7 +29,8 @@ static void ixgbe_info_get_dsn(struct ixgbe_adapter *adapter,
 }
 
 static void ixgbe_info_orom_ver(struct ixgbe_adapter *adapter,
-				struct ixgbe_info_ctx *ctx)
+				struct ixgbe_info_ctx *ctx,
+				enum ixgbe_devlink_version_type type)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	struct ixgbe_nvm_version nvm_ver;
@@ -28,7 +38,14 @@ static void ixgbe_info_orom_ver(struct ixgbe_adapter *adapter,
 	ctx->buf[0] = '\0';
 
 	if (hw->mac.type == ixgbe_mac_e610) {
-		struct ixgbe_orom_info *orom = &adapter->hw.flash.orom;
+		struct ixgbe_orom_info *orom;
+
+		if (type == IXGBE_DL_VERSION_RUNNING)
+			orom = &adapter->hw.flash.orom;
+		else if (type == IXGBE_DL_VERSION_STORED)
+			orom = &ctx->pending_orom;
+		else
+			return;
 
 		snprintf(ctx->buf, sizeof(ctx->buf), "%d.%d.%d",
 			 orom->major, orom->build, orom->patch);
@@ -51,14 +68,23 @@ static void ixgbe_info_orom_ver(struct ixgbe_adapter *adapter,
 }
 
 static void ixgbe_info_eetrack(struct ixgbe_adapter *adapter,
-			       struct ixgbe_info_ctx *ctx)
+			       struct ixgbe_info_ctx *ctx,
+			       enum ixgbe_devlink_version_type type)
 {
 	struct ixgbe_hw *hw = &adapter->hw;
 	struct ixgbe_nvm_version nvm_ver;
 
 	if (hw->mac.type == ixgbe_mac_e610) {
-		snprintf(ctx->buf, sizeof(ctx->buf), "0x%08x",
-			 hw->flash.nvm.eetrack);
+		u32 eetrack;
+
+		if (type == IXGBE_DL_VERSION_RUNNING)
+			eetrack = hw->flash.nvm.eetrack;
+		else if (type == IXGBE_DL_VERSION_STORED)
+			eetrack = ctx->pending_nvm.eetrack;
+		else
+			return;
+
+		snprintf(ctx->buf, sizeof(ctx->buf), "0x%08x", eetrack);
 		return;
 	}
 
@@ -92,33 +118,65 @@ static void ixgbe_info_fw_build(struct ixgbe_adapter *adapter,
 }
 
 static void ixgbe_info_fw_srev(struct ixgbe_adapter *adapter,
-			       struct ixgbe_info_ctx *ctx)
+			       struct ixgbe_info_ctx *ctx,
+			       enum ixgbe_devlink_version_type type)
 {
-	struct ixgbe_nvm_info *nvm = &adapter->hw.flash.nvm;
+	struct ixgbe_nvm_info *nvm;
+
+	if (type == IXGBE_DL_VERSION_RUNNING)
+		nvm = &adapter->hw.flash.nvm;
+	else if (type == IXGBE_DL_VERSION_STORED)
+		nvm = &ctx->pending_nvm;
+	else
+		return;
 
 	snprintf(ctx->buf, sizeof(ctx->buf), "%u", nvm->srev);
 }
 
 static void ixgbe_info_orom_srev(struct ixgbe_adapter *adapter,
-				 struct ixgbe_info_ctx *ctx)
+				 struct ixgbe_info_ctx *ctx,
+				 enum ixgbe_devlink_version_type type)
 {
-	struct ixgbe_orom_info *orom = &adapter->hw.flash.orom;
+	struct ixgbe_orom_info *orom;
+
+	if (type == IXGBE_DL_VERSION_RUNNING)
+		orom = &adapter->hw.flash.orom;
+	else if (type == IXGBE_DL_VERSION_STORED)
+		orom = &ctx->pending_orom;
+	else
+		return;
 
 	snprintf(ctx->buf, sizeof(ctx->buf), "%u", orom->srev);
 }
 
 static void ixgbe_info_nvm_ver(struct ixgbe_adapter *adapter,
-			       struct ixgbe_info_ctx *ctx)
+			       struct ixgbe_info_ctx *ctx,
+			       enum ixgbe_devlink_version_type type)
 {
-	struct ixgbe_nvm_info *nvm = &adapter->hw.flash.nvm;
+	struct ixgbe_nvm_info *nvm;
+
+	if (type == IXGBE_DL_VERSION_RUNNING)
+		nvm = &adapter->hw.flash.nvm;
+	else if (type == IXGBE_DL_VERSION_STORED)
+		nvm = &ctx->pending_nvm;
+	else
+		return;
 
 	snprintf(ctx->buf, sizeof(ctx->buf), "%x.%02x", nvm->major, nvm->minor);
 }
 
 static void ixgbe_info_netlist_ver(struct ixgbe_adapter *adapter,
-				   struct ixgbe_info_ctx *ctx)
+				   struct ixgbe_info_ctx *ctx,
+				   enum ixgbe_devlink_version_type type)
 {
-	struct ixgbe_netlist_info *netlist = &adapter->hw.flash.netlist;
+	struct ixgbe_netlist_info *netlist;
+
+	if (type == IXGBE_DL_VERSION_RUNNING)
+		netlist = &adapter->hw.flash.netlist;
+	else if (type == IXGBE_DL_VERSION_STORED)
+		netlist = &ctx->pending_netlist;
+	else
+		return;
 
 	/* The netlist version fields are BCD formatted */
 	snprintf(ctx->buf, sizeof(ctx->buf), "%x.%x.%x-%x.%x.%x",
@@ -128,13 +186,56 @@ static void ixgbe_info_netlist_ver(struct ixgbe_adapter *adapter,
 }
 
 static void ixgbe_info_netlist_build(struct ixgbe_adapter *adapter,
-				     struct ixgbe_info_ctx *ctx)
+				     struct ixgbe_info_ctx *ctx,
+				     enum ixgbe_devlink_version_type type)
 {
-	struct ixgbe_netlist_info *netlist = &adapter->hw.flash.netlist;
+	struct ixgbe_netlist_info *netlist;
+
+	if (type == IXGBE_DL_VERSION_RUNNING)
+		netlist = &adapter->hw.flash.netlist;
+	else if (type == IXGBE_DL_VERSION_STORED)
+		netlist = &ctx->pending_netlist;
+	else
+		return;
 
 	snprintf(ctx->buf, sizeof(ctx->buf), "0x%08x", netlist->hash);
 }
 
+static int ixgbe_set_ctx_dev_caps(struct ixgbe_hw *hw,
+				  struct ixgbe_info_ctx *ctx,
+				  struct netlink_ext_ack *extack)
+{
+	int err = ixgbe_discover_dev_caps(hw, &ctx->dev_caps);
+
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Unable to discover device capabilities");
+		return err;
+	}
+
+	if (ctx->dev_caps.common_cap.nvm_update_pending_orom) {
+		err = ixgbe_get_inactive_orom_ver(hw, &ctx->pending_orom);
+		if (err)
+			ctx->dev_caps.common_cap.nvm_update_pending_orom =
+			false;
+	}
+
+	if (ctx->dev_caps.common_cap.nvm_update_pending_nvm) {
+		err = ixgbe_get_inactive_nvm_ver(hw, &ctx->pending_nvm);
+		if (err)
+			ctx->dev_caps.common_cap.nvm_update_pending_nvm = false;
+	}
+
+	if (ctx->dev_caps.common_cap.nvm_update_pending_netlist) {
+		err = ixgbe_get_inactive_netlist_ver(hw, &ctx->pending_netlist);
+		if (err)
+			ctx->dev_caps.common_cap.nvm_update_pending_netlist =
+				false;
+	}
+
+	return 0;
+}
+
 static int ixgbe_devlink_info_get_E610(struct ixgbe_adapter *adapter,
 				       struct devlink_info_req *req,
 				       struct ixgbe_info_ctx *ctx)
@@ -153,33 +254,90 @@ static int ixgbe_devlink_info_get_E610(struct ixgbe_adapter *adapter,
 	if (err)
 		return err;
 
-	ixgbe_info_fw_srev(adapter, ctx);
+	ixgbe_info_fw_srev(adapter, ctx, IXGBE_DL_VERSION_RUNNING);
 	err = devlink_info_version_running_put(req, "fw.mgmt.srev", ctx->buf);
 	if (err)
 		return err;
 
-	ixgbe_info_orom_srev(adapter, ctx);
+	ixgbe_info_orom_srev(adapter, ctx, IXGBE_DL_VERSION_RUNNING);
 	err = devlink_info_version_running_put(req, "fw.undi.srev", ctx->buf);
 	if (err)
 		return err;
 
-	ixgbe_info_nvm_ver(adapter, ctx);
+	ixgbe_info_nvm_ver(adapter, ctx, IXGBE_DL_VERSION_RUNNING);
 	err = devlink_info_version_running_put(req, "fw.psid.api", ctx->buf);
 	if (err)
 		return err;
 
-	ixgbe_info_netlist_ver(adapter, ctx);
+	ixgbe_info_netlist_ver(adapter, ctx, IXGBE_DL_VERSION_RUNNING);
 	err = devlink_info_version_running_put(req, "fw.netlist", ctx->buf);
 	if (err)
 		return err;
 
-	ixgbe_info_netlist_build(adapter, ctx);
+	ixgbe_info_netlist_build(adapter, ctx, IXGBE_DL_VERSION_RUNNING);
 	err = devlink_info_version_running_put(req, "fw.netlist.build",
 					       ctx->buf);
 
 	return err;
 }
 
+static int
+ixgbe_devlink_pending_info_get_E610(struct ixgbe_adapter *adapter,
+				    struct devlink_info_req *req,
+				    struct ixgbe_info_ctx *ctx)
+{
+	int err = 0;
+
+	if (!ctx->dev_caps.common_cap.nvm_update_pending_nvm)
+		goto no_nvm;
+
+	ixgbe_info_fw_srev(adapter, ctx, IXGBE_DL_VERSION_STORED);
+	err = devlink_info_version_stored_put(req, "fw.mgmt.srev", ctx->buf);
+	if (err)
+		return err;
+
+	ixgbe_info_eetrack(adapter, ctx, IXGBE_DL_VERSION_STORED);
+	err = devlink_info_version_stored_put(req,
+				     DEVLINK_INFO_VERSION_GENERIC_FW_BUNDLE_ID,
+				     ctx->buf);
+	if (err)
+		return err;
+
+	ixgbe_info_nvm_ver(adapter, ctx, IXGBE_DL_VERSION_STORED);
+	err = devlink_info_version_stored_put(req, "fw.psid.api", ctx->buf);
+	if (err)
+		return err;
+
+no_nvm:
+	if (!ctx->dev_caps.common_cap.nvm_update_pending_orom)
+		goto no_orom;
+
+	ixgbe_info_orom_ver(adapter, ctx, IXGBE_DL_VERSION_STORED);
+	err = devlink_info_version_stored_put(req,
+				     DEVLINK_INFO_VERSION_GENERIC_FW_UNDI,
+				     ctx->buf);
+	if (err)
+		return err;
+
+	ixgbe_info_orom_srev(adapter, ctx, IXGBE_DL_VERSION_STORED);
+	err = devlink_info_version_stored_put(req, "fw.undi.srev", ctx->buf);
+no_orom:
+	if (err || !ctx->dev_caps.common_cap.nvm_update_pending_netlist)
+		return err;
+
+	ixgbe_info_netlist_ver(adapter, ctx, IXGBE_DL_VERSION_STORED);
+	err = devlink_info_version_stored_put(req, "fw.netlist", ctx->buf);
+
+	if (err)
+		return err;
+
+	ixgbe_info_netlist_build(adapter, ctx, IXGBE_DL_VERSION_STORED);
+	err = devlink_info_version_stored_put(req, "fw.netlist.build",
+					      ctx->buf);
+
+	return err;
+}
+
 static int ixgbe_devlink_info_get(struct devlink *devlink,
 				  struct devlink_info_req *req,
 				  struct netlink_ext_ack *extack)
@@ -198,14 +356,14 @@ static int ixgbe_devlink_info_get(struct devlink *devlink,
 	if (err)
 		goto free_ctx;
 
-	ixgbe_info_orom_ver(adapter, ctx);
+	ixgbe_info_orom_ver(adapter, ctx, IXGBE_DL_VERSION_RUNNING);
 	err = devlink_info_version_running_put(req,
 					DEVLINK_INFO_VERSION_GENERIC_FW_UNDI,
 					ctx->buf);
 	if (err)
 		goto free_ctx;
 
-	ixgbe_info_eetrack(adapter, ctx);
+	ixgbe_info_eetrack(adapter, ctx, IXGBE_DL_VERSION_RUNNING);
 	err = devlink_info_version_running_put(req,
 					DEVLINK_INFO_VERSION_GENERIC_FW_UNDI,
 					ctx->buf);
@@ -220,7 +378,15 @@ static int ixgbe_devlink_info_get(struct devlink *devlink,
 	if (err || hw->mac.type != ixgbe_mac_e610)
 		goto free_ctx;
 
+	err = ixgbe_set_ctx_dev_caps(hw, ctx, extack);
+	if (err)
+		goto free_ctx;
+
 	err = ixgbe_devlink_info_get_E610(adapter, req, ctx);
+	if (err)
+		goto free_ctx;
+
+	err = ixgbe_devlink_pending_info_get_E610(adapter, req, ctx);
 free_ctx:
 	kfree(ctx);
 	return err;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 2b1549992754..87a646659e45 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -589,6 +589,15 @@ static bool ixgbe_parse_e610_caps(struct ixgbe_hw *hw,
 		break;
 	case IXGBE_ACI_CAPS_NVM_VER:
 		break;
+	case IXGBE_ACI_CAPS_PENDING_NVM_VER:
+		caps->nvm_update_pending_nvm = true;
+		break;
+	case IXGBE_ACI_CAPS_PENDING_OROM_VER:
+		caps->nvm_update_pending_orom = true;
+		break;
+	case IXGBE_ACI_CAPS_PENDING_NET_VER:
+		caps->nvm_update_pending_netlist = true;
+		break;
 	case IXGBE_ACI_CAPS_MAX_MTU:
 		caps->max_mtu = number;
 		break;
@@ -2932,6 +2941,23 @@ static int ixgbe_get_orom_ver_info(struct ixgbe_hw *hw,
 	return err;
 }
 
+/**
+ * ixgbe_get_inactive_orom_ver - Read Option ROM version from the inactive bank
+ * @hw: pointer to the HW structure
+ * @orom: storage for Option ROM version information
+ *
+ * Read the Option ROM version and security revision data for the inactive
+ * section of flash. Used to access version data for a pending update that has
+ * not yet been activated.
+ *
+ * Return: the exit code of the operation.
+ */
+int ixgbe_get_inactive_orom_ver(struct ixgbe_hw *hw,
+				struct ixgbe_orom_info *orom)
+{
+	return ixgbe_get_orom_ver_info(hw, IXGBE_INACTIVE_FLASH_BANK, orom);
+}
+
 /**
  * ixgbe_get_nvm_ver_info - Read NVM version information
  * @hw: pointer to the HW struct
@@ -2975,6 +3001,22 @@ static int ixgbe_get_nvm_ver_info(struct ixgbe_hw *hw,
 	return 0;
 }
 
+/**
+ * ixgbe_get_inactive_nvm_ver - Read Option ROM version from the inactive bank
+ * @hw: pointer to the HW structure
+ * @nvm: storage for Option ROM version information
+ *
+ * Read the NVM EETRACK ID, Map version, and security revision of the
+ * inactive NVM bank. Used to access version data for a pending update that
+ * has not yet been activated.
+ *
+ * Return: the exit code of the operation.
+ */
+int ixgbe_get_inactive_nvm_ver(struct ixgbe_hw *hw, struct ixgbe_nvm_info *nvm)
+{
+	return ixgbe_get_nvm_ver_info(hw, IXGBE_INACTIVE_FLASH_BANK, nvm);
+}
+
 /**
  * ixgbe_get_netlist_info - Read the netlist version information
  * @hw: pointer to the HW struct
@@ -3055,6 +3097,23 @@ static int ixgbe_get_netlist_info(struct ixgbe_hw *hw,
 	return err;
 }
 
+/**
+ * ixgbe_get_inactive_netlist_ver - Read netlist version from the inactive bank
+ * @hw: pointer to the HW struct
+ * @netlist: pointer to netlist version info structure
+ *
+ * Read the netlist version data from the inactive netlist bank. Used to
+ * extract version data of a pending flash update in order to display the
+ * version data.
+ *
+ * Return: the exit code of the operation.
+ */
+int ixgbe_get_inactive_netlist_ver(struct ixgbe_hw *hw,
+				   struct ixgbe_netlist_info *netlist)
+{
+	return ixgbe_get_netlist_info(hw, IXGBE_INACTIVE_FLASH_BANK, netlist);
+}
+
 /**
  * ixgbe_get_flash_data - get flash data
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
index 2c971a34200b..07c888d554d5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
@@ -67,6 +67,9 @@ int ixgbe_aci_read_nvm(struct ixgbe_hw *hw, u16 module_typeid, u32 offset,
 		       u16 length, void *data, bool last_command,
 		       bool read_shadow_ram);
 int ixgbe_nvm_validate_checksum(struct ixgbe_hw *hw);
+int ixgbe_get_inactive_orom_ver(struct ixgbe_hw *hw, struct ixgbe_orom_info *orom);
+int ixgbe_get_inactive_nvm_ver(struct ixgbe_hw *hw, struct ixgbe_nvm_info *nvm);
+int ixgbe_get_inactive_netlist_ver(struct ixgbe_hw *hw, struct ixgbe_netlist_info *netlist);
 int ixgbe_read_sr_word_aci(struct ixgbe_hw  *hw, u16 offset, u16 *data);
 int ixgbe_read_flat_nvm(struct ixgbe_hw  *hw, u32 offset, u32 *length,
 			u8 *data, bool read_shadow_ram);
-- 
2.31.1


