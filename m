Return-Path: <netdev+bounces-164662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BACEFA2EA27
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710E1166BE4
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9C51D61B5;
	Mon, 10 Feb 2025 10:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VE2WWVs3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ABD1D515B
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739184838; cv=none; b=SKFMR738zwgftMYmk7VK8CE3orAMSPQhPe3m6dIkqITWiGPtzILCbbZpMm2M1cHYMElRS0UujGCnwUWxymTttm8nyU3281L4/DWhLIWoqjkJxO/4vsE2Y6r0mFhN5CtzE/cJ/fU6Wy22Z9fnX6mGoQjUC1lamTeYCoQft0azMrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739184838; c=relaxed/simple;
	bh=GM6VJSBpOMWRU+b+GUpUMOWYRl+SmDkjju99OJjRWds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cDMtIEqAp8ZtLkzrayTBiFQ+NsgtJfB46JhcfP3bWAnqLGJsQzfkQ6rHkesF4gRbA5+l9IA2AdpGqPO7bfXL0AYfCiMk8/ZBhIZM5gOVzeEYdG8+4N20ixp7V76Ad/HnmNeolHIs+7WF2L52VtBAzDfqhM9TllyaVkgTssKLjEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VE2WWVs3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739184837; x=1770720837;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GM6VJSBpOMWRU+b+GUpUMOWYRl+SmDkjju99OJjRWds=;
  b=VE2WWVs3c2hRLNQsezjDjIWNYFO7YJyx43Zv2LzW6qmHxCUknghCzwCc
   DDYuX8yqcKNy4nTvcCDkOmhKXr296GdnswQJLED1XVOhRVcy031a8uPRW
   0kmA8P2JBbqrt7b+LEMVannRwwgGa5HMwnTcCuIYR9JVqJeQq3wnbtui8
   GLwPz8GqKfgQjMJ9JiTIhKX9mtSyRimSb4+b2InFfZo+Ptnfy89ojw2/B
   lp3RMzpHTCyIy5ud/TgLzt/bN1FTiumqxMhdMjM9rHI4S7yOnsp+ICg3I
   58mBMtwJi8GyuLmuEzQd/Amm76zZ9YJWFRrTf2wiFrds/hxT8y59km5jb
   Q==;
X-CSE-ConnectionGUID: jFsYjBVSTvWP1qw+N5J3qw==
X-CSE-MsgGUID: dfwlFhfcRd+gAU1zKdhsrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="39910059"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="39910059"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 02:53:56 -0800
X-CSE-ConnectionGUID: 1HnBKCHEQp6R/L+86DF7hA==
X-CSE-MsgGUID: oqbxFyjBQJu8+7Daudj8QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149344599"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa001.jf.intel.com with ESMTP; 10 Feb 2025 02:53:54 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [PATCH iwl-next v3] ixgbe: add support for thermal sensor event reception
Date: Mon, 10 Feb 2025 11:40:17 +0100
Message-Id: <20250210104017.62838-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

E610 NICs unlike the previous devices utilising ixgbe driver
are notified in the case of overheatning by the FW ACI event.

In event of overheat when threshold is exceeded, FW suspends all
traffic and sends overtemp event to the driver. Then driver
logs appropriate message and closes the adapter instance.
The card remains in that state until the platform is rebooted.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
---
v2,3 : commit msg tweaks
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      | 5 +++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 7236f20c9a30..5c804948dd1f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3165,6 +3165,7 @@ static void ixgbe_aci_event_cleanup(struct ixgbe_aci_event *event)
 static void ixgbe_handle_fw_event(struct ixgbe_adapter *adapter)
 {
 	struct ixgbe_aci_event event __cleanup(ixgbe_aci_event_cleanup);
+	struct net_device *netdev = adapter->netdev;
 	struct ixgbe_hw *hw = &adapter->hw;
 	bool pending = false;
 	int err;
@@ -3185,6 +3186,10 @@ static void ixgbe_handle_fw_event(struct ixgbe_adapter *adapter)
 		case ixgbe_aci_opc_get_link_status:
 			ixgbe_handle_link_status_event(adapter, &event);
 			break;
+		case ixgbe_aci_opc_temp_tca_event:
+			e_crit(drv, "%s\n", ixgbe_overheat_msg);
+			ixgbe_close(netdev);
+			break;
 		default:
 			e_warn(hw, "unknown FW async event captured\n");
 			break;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index 8d06ade3c7cd..617e07878e4f 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -171,6 +171,9 @@ enum ixgbe_aci_opc {
 	ixgbe_aci_opc_done_alt_write			= 0x0904,
 	ixgbe_aci_opc_clear_port_alt_write		= 0x0906,
 
+	/* TCA Events */
+	ixgbe_aci_opc_temp_tca_event                    = 0x0C94,
+
 	/* debug commands */
 	ixgbe_aci_opc_debug_dump_internals		= 0xFF08,
 
-- 
2.31.1


