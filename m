Return-Path: <netdev+bounces-222326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D272B53D80
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00FA058697B
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 21:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1F92E0930;
	Thu, 11 Sep 2025 21:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TpJrnjrI"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337BC2E03F0
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 21:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624750; cv=none; b=ECyPOXB5NM0a49zmzN7IOAyl1p2u4veWuyAShT/WKGsoSaJcAhKJ58tibqWgyL67PcF55xnxYKNwrddW5AjMIxU18afFQZpDBxoe3VRI5hjUgt2RpRJM4mKuRiNCRRkwd6hib+oHiY23S0QvKnyHg553ZYV68ySxIUA9SOHHvLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624750; c=relaxed/simple;
	bh=6AcFE2IXEpFr5VeQESS3kSYTsgzIkx5QPRT2Jy7o9/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Za3ORjsO+fDQr1VjRf6C0Z7eXYYW+xJ1BYPXefvCbsNqklJggoZxACCqKcUg9DL4zY4fMZc6BoWgWcfaTWWIn3AsZpTQ9zrCduuMBEOI9GyC+VyywQ2KQcFTktoaWMRIX9OPgyeFTAKfOiTmfrPH0NOjI2OYeb0THuxJKnbujfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TpJrnjrI; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757624750; x=1789160750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6AcFE2IXEpFr5VeQESS3kSYTsgzIkx5QPRT2Jy7o9/A=;
  b=TpJrnjrIbiUfQTS3QisRO4jvA1roU+zbfr4/NMWYRC8T/r1v315dTKJN
   Agaoq2erBH3teseOnZiX7vEVC+3DXubYtHaI8s9gHpURBg1xT/4CnRPi9
   88ylem1j/dop5R6K6te30MXw0xb1zxSZIZ6mZC9EuFlsGkcX98iWMw/Ul
   2zSebo+5eGnRrhLGN10yo7nP8Ur82S3fdTF9Om0IzVc+Egc5HyQmanlaB
   uMTpKDVetwbzK7tqlMBZia84/Nw+SL0ooC5+gwzPAGIy4p0QnIyvHJAYC
   WvlU6WasbUgHFtrnUqLbirrLVr8U9jW3TiuxGx0MfBV5Wcu3bHjM+PjU5
   w==;
X-CSE-ConnectionGUID: L0bUlWJ8SK6SbC7ymZ/GHA==
X-CSE-MsgGUID: xRGpZ+W3TKuKJrnVJhYjOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82558977"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="82558977"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 14:05:50 -0700
X-CSE-ConnectionGUID: zDc9pmE8QHCac4pa3C3czA==
X-CSE-MsgGUID: pFT+OUtzS3mmFAE//VBiSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="174583489"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 11 Sep 2025 14:05:48 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	horms@kernel.org,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 15/15] ixgbe: fwlog support for e610
Date: Thu, 11 Sep 2025 14:05:14 -0700
Message-ID: <20250911210525.345110-16-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250911210525.345110-1-anthony.l.nguyen@intel.com>
References: <20250911210525.345110-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

The device support firmware logging feature. Use libie code to
initialize it and allow reading the logs using debugfs.

The commands are the same as in ice driver. Look at the description in
commit 96a9a9341cda ("ice: configure FW logging") for more info.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/Kconfig            |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 32 +++++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  2 ++
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 10 ++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  2 ++
 5 files changed, 47 insertions(+)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 09f0af386af1..a563a94e2780 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -146,6 +146,7 @@ config IXGBE
 	tristate "Intel(R) 10GbE PCI Express adapters support"
 	depends on PCI
 	depends on PTP_1588_CLOCK_OPTIONAL
+	select LIBIE_FWLOG
 	select MDIO
 	select NET_DEVLINK
 	select PLDMFW
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index 7181efd0454d..c2f8189a0738 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -3921,6 +3921,38 @@ static int ixgbe_read_pba_string_e610(struct ixgbe_hw *hw, u8 *pba_num,
 	return err;
 }
 
+static int __fwlog_send_cmd(void *priv, struct libie_aq_desc *desc, void *buf,
+			    u16 size)
+{
+	struct ixgbe_hw *hw = priv;
+
+	return ixgbe_aci_send_cmd(hw, desc, buf, size);
+}
+
+int ixgbe_fwlog_init(struct ixgbe_hw *hw)
+{
+	struct ixgbe_adapter *adapter = hw->back;
+	struct libie_fwlog_api api = {
+		.pdev = adapter->pdev,
+		.send_cmd = __fwlog_send_cmd,
+		.debugfs_root = adapter->ixgbe_dbg_adapter,
+		.priv = hw,
+	};
+
+	if (hw->mac.type != ixgbe_mac_e610)
+		return -EOPNOTSUPP;
+
+	return libie_fwlog_init(&hw->fwlog, &api);
+}
+
+void ixgbe_fwlog_deinit(struct ixgbe_hw *hw)
+{
+	if (hw->mac.type != ixgbe_mac_e610)
+		return;
+
+	libie_fwlog_deinit(&hw->fwlog);
+}
+
 static const struct ixgbe_mac_operations mac_ops_e610 = {
 	.init_hw			= ixgbe_init_hw_generic,
 	.start_hw			= ixgbe_start_hw_e610,
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
index 782c489b0fa7..11916b979d28 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
@@ -96,5 +96,7 @@ int ixgbe_aci_update_nvm(struct ixgbe_hw *hw, u16 module_typeid,
 			 bool last_command, u8 command_flags);
 int ixgbe_nvm_write_activate(struct ixgbe_hw *hw, u16 cmd_flags,
 			     u8 *response_flags);
+int ixgbe_fwlog_init(struct ixgbe_hw *hw);
+void ixgbe_fwlog_deinit(struct ixgbe_hw *hw);
 
 #endif /* _IXGBE_E610_H_ */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 80e6a2ef1350..91ead3cabe83 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -172,6 +172,7 @@ static int debug = -1;
 module_param(debug, int, 0);
 MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 
+MODULE_IMPORT_NS("LIBIE_FWLOG");
 MODULE_DESCRIPTION("Intel(R) 10 Gigabit PCI Express Network Driver");
 MODULE_LICENSE("GPL v2");
 
@@ -3355,6 +3356,10 @@ static void ixgbe_handle_fw_event(struct ixgbe_adapter *adapter)
 			e_crit(drv, "%s\n", ixgbe_overheat_msg);
 			ixgbe_down(adapter);
 			break;
+		case libie_aqc_opc_fw_logs_event:
+			libie_get_fwlog_data(&hw->fwlog, event.msg_buf,
+					     le16_to_cpu(event.desc.datalen));
+			break;
 		default:
 			e_warn(hw, "unknown FW async event captured\n");
 			break;
@@ -11998,6 +12003,10 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	ixgbe_devlink_init_regions(adapter);
 	devl_register(adapter->devlink);
 	devl_unlock(adapter->devlink);
+
+	if (ixgbe_fwlog_init(hw))
+		e_dev_info("Firmware logging not supported\n");
+
 	return 0;
 
 err_netdev:
@@ -12055,6 +12064,7 @@ static void ixgbe_remove(struct pci_dev *pdev)
 	devl_lock(adapter->devlink);
 	devl_unregister(adapter->devlink);
 	ixgbe_devlink_destroy_regions(adapter);
+	ixgbe_fwlog_deinit(&adapter->hw);
 	ixgbe_dbg_adapter_exit(adapter);
 
 	set_bit(__IXGBE_REMOVING, &adapter->state);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 36577091cd9e..b1bfeb21537a 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -7,6 +7,7 @@
 #include <linux/types.h>
 #include <linux/mdio.h>
 #include <linux/netdevice.h>
+#include <linux/net/intel/libie/fwlog.h>
 #include "ixgbe_type_e610.h"
 
 /* Device IDs */
@@ -3752,6 +3753,7 @@ struct ixgbe_hw {
 	struct ixgbe_flash_info		flash;
 	struct ixgbe_hw_dev_caps	dev_caps;
 	struct ixgbe_hw_func_caps	func_caps;
+	struct libie_fwlog		fwlog;
 };
 
 struct ixgbe_info {
-- 
2.47.1


