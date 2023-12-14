Return-Path: <netdev+bounces-57481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 151FF81329A
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 15:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABCA5B2112B
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA0B59B4F;
	Thu, 14 Dec 2023 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GHfjHAQ1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD65118
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 06:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702563015; x=1734099015;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P5+juMLHJnwyDiBpl3S0dM5Nn3q6D4TIwTTHAV2aD7E=;
  b=GHfjHAQ1wc8ZDtbSwBZ3hl8nfmiVSvKqKDKTV/M4vjwB1rKKi63iAG45
   xjl/DOb1JeSHztV8qPlflhY3acdwcUB0Ek6QCUN5e6pB8ySK7U/YTTDdT
   EYXYnPYm5KSE0CBbzRnoSzCd4FBXs5Mid58iRsObqbElPNqqFpjOJSIgO
   NVSHNKR3u3sviQ3L5gF/CaCwri0WVf3+67mQ9yKYpglOTocYLm7B5vr8C
   W7v/Lg90dJ2PZ61DhrGldFrAQcsl9EtLSs0MklSbP6OapOfEJspsEQYs0
   /SCKWVI8ZvlPo3V9I17h282+RNb8D3ls2p01SC1SUqAVgUCZbKyOu5Vyb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="1942365"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="1942365"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 06:10:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="918071248"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="918071248"
Received: from unknown (HELO amlin-019-225.igk.intel.com) ([10.102.19.225])
  by fmsmga001.fm.intel.com with ESMTP; 14 Dec 2023 06:10:13 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next] i40e: add trace events related to SFP module IOCTLs
Date: Thu, 14 Dec 2023 15:10:12 +0100
Message-Id: <20231214141012.224894-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add trace events related to SFP module IOCTLs for troubleshooting.

Riewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 src/CORE/i40e_ethtool.c |  5 +++++
 src/CORE/i40e_trace.h   | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/src/CORE/i40e_ethtool.c b/src/CORE/i40e_ethtool.c
index 0838566..e9d9d4b 100644
--- a/src/CORE/i40e_ethtool.c
+++ b/src/CORE/i40e_ethtool.c
@@ -1057,6 +1057,7 @@ static int i40e_get_link_ksettings(struct net_device *netdev,
 	ethtool_link_ksettings_zero_link_mode(ks, supported);
 	ethtool_link_ksettings_zero_link_mode(ks, advertising);
 
+	i40e_trace(ioctl_get_link_ksettings, pf, hw_link_info->link_info);
 	if (link_up)
 		i40e_get_settings_link_up(hw, ks, netdev, pf);
 	else
@@ -7219,9 +7220,12 @@ static int i40e_get_module_info(struct net_device *netdev,
 		modinfo->eeprom_len = I40E_MODULE_QSFP_MAX_LEN;
 		break;
 	default:
+		i40e_trace(ioctl_get_module_info, pf, ~0UL);
 		netdev_dbg(vsi->netdev, "SFP module type unrecognized or no SFP connector used.\n");
 		return -EOPNOTSUPP;
 	}
+	i40e_trace(ioctl_get_module_info, pf, (((u64)modinfo->type) << 32) |
+		   modinfo->eeprom_len);
 	return 0;
 }
 
@@ -7244,6 +7248,7 @@ static int i40e_get_module_eeprom(struct net_device *netdev,
 	u32 value = 0;
 	int i;
 
+	i40e_trace(ioctl_get_module_eeprom, pf, ee ? ee->len : 0U);
 	if (!ee || !ee->len || !data)
 		return -EINVAL;
 
diff --git a/src/CORE/i40e_trace.h b/src/CORE/i40e_trace.h
index cac0f7c..f54fc36 100644
--- a/src/CORE/i40e_trace.h
+++ b/src/CORE/i40e_trace.h
@@ -428,6 +428,24 @@ DEFINE_EVENT(
 
 	TP_ARGS(pf, val));
 
+DEFINE_EVENT(
+	i40e_ioctl_template, i40e_ioctl_get_module_info,
+	TP_PROTO(struct i40e_pf *pf, u64 val),
+
+	TP_ARGS(pf, val));
+
+DEFINE_EVENT(
+	i40e_ioctl_template, i40e_ioctl_get_module_eeprom,
+	TP_PROTO(struct i40e_pf *pf, u64 val),
+
+	TP_ARGS(pf, val));
+
+DEFINE_EVENT(
+	i40e_ioctl_template, i40e_ioctl_get_link_ksettings,
+	TP_PROTO(struct i40e_pf *pf, u64 val),
+
+	TP_ARGS(pf, val));
+
 DECLARE_EVENT_CLASS(
 	i40e_nvmupd_template,
 
-- 
2.31.1


