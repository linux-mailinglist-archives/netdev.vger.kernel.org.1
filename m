Return-Path: <netdev+bounces-179964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA92A7EFED
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 23:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BAFE3AADED
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E29A22A1ED;
	Mon,  7 Apr 2025 21:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PnUcA80l"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD01226CE4;
	Mon,  7 Apr 2025 21:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744062697; cv=none; b=SaJ1JlQrmEfiwSi2sO+IzgkZuahBjRs9/3oED7gZDNPZuLUnzeiqkrxAapSWOS3MbMeKBq/hOyc3fqljvnTr00nMVXtv5ZFR8QcWPAEFdnxKFEw9B7Smnc9NOR2OvWJ8GTKg+G0abRQmG4dyr+R2U6Bciy8cW61vsec8F8jqgtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744062697; c=relaxed/simple;
	bh=LTTGRnzZZm9unP6+jXYKmbJi/V1jB6Raxf/VLj9zINA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWnGmPbDbNCuLwrPpvEfdzaOHQIKUJUQZnG8M68ok0O0AdvRMV/oHOKitLa1bLTLmI6/rHEIDu81DUPa9MrDWuoxRPcis/Eg/lInpif32xf3U3J5Ki4iQFjWsuKVkF7mwrv5w/C3UiW9Cz3FpiPc0ZLoFrYkFuWWKfblCQrNT9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PnUcA80l; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744062695; x=1775598695;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LTTGRnzZZm9unP6+jXYKmbJi/V1jB6Raxf/VLj9zINA=;
  b=PnUcA80llUp5uM8X6rSs/+gL5AYHV4XYZ3ziXGOVluM8egwZogjsttAA
   zLPoCQDFbUvndK/2175KwAY6NIu8KU5BpU5SnnEsN7ZrzykpNHpeQlHP5
   eqpb72e+Q44LTkuNUG0Jph1/2ncc6N+wWGWjFgiGLCc4V8GPZDsUprxi5
   jE6769n3JvQVl0p4vdHUw9QiQ4Kp/qtIITey4EgpR0z+7ApEVc8hhpK5z
   zK559+wxx7UKfZ9F4Cirtqh4X3hAVv1WCUJhMdEOvVBGT7teFp7AEmXM8
   IAjxYR5iJ1SKxvDbpo6weY8O5TTgjxcu5woSBBMh6/OoM34hdLVYGoupB
   A==;
X-CSE-ConnectionGUID: 9M67ZT2mQZqSKuXeeUMDGg==
X-CSE-MsgGUID: BluADylRQFaqJYzUSMH2+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49268644"
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="49268644"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 14:51:29 -0700
X-CSE-ConnectionGUID: RlHYKj8XT/uqsvohAihd6w==
X-CSE-MsgGUID: 5/ROMxwZQISZQlLgOP7ThQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="133055778"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 07 Apr 2025 14:51:28 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Bharath R <bharath.r@intel.com>,
	Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH net-next 10/15] ixgbe: extend .info_get with() stored versions
Date: Mon,  7 Apr 2025 14:51:14 -0700
Message-ID: <20250407215122.609521-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250407215122.609521-1-anthony.l.nguyen@intel.com>
References: <20250407215122.609521-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Add functions reading inactive versions from the inactive flash
bank.

Print stored NVM, OROM and netlist versions by devlink when there
is an ongoing update for E610 device.

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Bharath R <bharath.r@intel.com>
Co-developed-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
Signed-off-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
Co-developed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../ethernet/intel/ixgbe/devlink/devlink.c    | 207 ++++++++++++++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |  59 +++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   5 +
 3 files changed, 249 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
index a7c39e951c7b..a3b79a643b85 100644
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
 
 		snprintf(ctx->buf, sizeof(ctx->buf), "%u.%u.%u",
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
+				false;
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
 static int ixgbe_devlink_info_get_e610(struct ixgbe_adapter *adapter,
 				       struct devlink_info_req *req,
 				       struct ixgbe_info_ctx *ctx)
@@ -153,31 +254,85 @@ static int ixgbe_devlink_info_get_e610(struct ixgbe_adapter *adapter,
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
 	return devlink_info_version_running_put(req, "fw.netlist.build",
 						ctx->buf);
 }
 
+static int
+ixgbe_devlink_pending_info_get_e610(struct ixgbe_adapter *adapter,
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
+					      DEVLINK_INFO_VERSION_GENERIC_FW_BUNDLE_ID,
+					      ctx->buf);
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
+					      DEVLINK_INFO_VERSION_GENERIC_FW_UNDI,
+					      ctx->buf);
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
+	if (err)
+		return err;
+
+	ixgbe_info_netlist_build(adapter, ctx, IXGBE_DL_VERSION_STORED);
+	return devlink_info_version_stored_put(req, "fw.netlist.build",
+					       ctx->buf);
+}
+
 static int ixgbe_devlink_info_get(struct devlink *devlink,
 				  struct devlink_info_req *req,
 				  struct netlink_ext_ack *extack)
@@ -206,21 +361,29 @@ static int ixgbe_devlink_info_get(struct devlink *devlink,
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
 					       DEVLINK_INFO_VERSION_GENERIC_FW_BUNDLE_ID,
 					       ctx->buf);
 	if (err || hw->mac.type != ixgbe_mac_e610)
 		goto free_ctx;
 
+	err = ixgbe_set_ctx_dev_caps(hw, ctx, extack);
+	if (err)
+		goto free_ctx;
+
 	err = ixgbe_devlink_info_get_e610(adapter, req, ctx);
+	if (err)
+		goto free_ctx;
+
+	err = ixgbe_devlink_pending_info_get_e610(adapter, req, ctx);
 free_ctx:
 	kfree(ctx);
 	return err;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index f856690106af..24443db831eb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -588,6 +588,15 @@ static bool ixgbe_parse_e610_caps(struct ixgbe_hw *hw,
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
 	return ixgbe_get_orom_srev(hw, bank, &orom->srev);
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
index 2c971a34200b..7565a40d792f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
@@ -67,6 +67,11 @@ int ixgbe_aci_read_nvm(struct ixgbe_hw *hw, u16 module_typeid, u32 offset,
 		       u16 length, void *data, bool last_command,
 		       bool read_shadow_ram);
 int ixgbe_nvm_validate_checksum(struct ixgbe_hw *hw);
+int ixgbe_get_inactive_orom_ver(struct ixgbe_hw *hw,
+				struct ixgbe_orom_info *orom);
+int ixgbe_get_inactive_nvm_ver(struct ixgbe_hw *hw, struct ixgbe_nvm_info *nvm);
+int ixgbe_get_inactive_netlist_ver(struct ixgbe_hw *hw,
+				   struct ixgbe_netlist_info *netlist);
 int ixgbe_read_sr_word_aci(struct ixgbe_hw  *hw, u16 offset, u16 *data);
 int ixgbe_read_flat_nvm(struct ixgbe_hw  *hw, u32 offset, u32 *length,
 			u8 *data, bool read_shadow_ram);
-- 
2.47.1


