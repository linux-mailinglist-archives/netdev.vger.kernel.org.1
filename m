Return-Path: <netdev+bounces-59318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79B581A67B
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 18:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 753B2287465
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 17:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1219747A61;
	Wed, 20 Dec 2023 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jfZZz//P"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9251E47A42
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703093920; x=1734629920;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ohevLhZwHFFA2z/8eGI/uohrYFzoGWSxtEckjdNCjr0=;
  b=jfZZz//Pg/uu5QhtpnLiDSWKbi7ABntNBGONubMuRAKyYbF4Sys+1mTd
   doBmGLbfqyZdKvaI262SogpeaI28qO6Zz9lcIrZNFwzohlKAAj7gAZufR
   is4HTS3Kj/XFOMSTQKokVHgYhpAIoK5AmicgmEtZiHu083XWFz86Bg96Z
   3ReGXhNQxe02sy7KVtMcIbr+mQuv2uwbaiREaKhbNVN/h0M7fvXIgfh2d
   ivQxA9JfjMGLDXJdB51MuH1wMR4wq2mtKgCLPS8oTc8QaK7xJWQyyJtLv
   YntBOWs+p+pSpaJf49P+78MnXh3GiwBewqyC+/gTn9RjLBGFkcruSMMVu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="2686211"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="2686211"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 09:38:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="1023550721"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="1023550721"
Received: from unknown (HELO amlin-019-225.igk.intel.com) ([10.102.19.225])
  by fmsmga006.fm.intel.com with ESMTP; 20 Dec 2023 09:38:38 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v2] i40e: add trace events related to SFP module IOCTLs
Date: Wed, 20 Dec 2023 18:38:37 +0100
Message-Id: <20231220173837.3326983-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add trace events related to SFP module IOCTLs for troubleshooting.

Example:
        echo "i40e_*" >/sys/kernel/tracing/set_ftrace_filter
        echo "i40e_ioctl*" >/sys/kernel/tracing/events/i40e/filter
        echo 1  >/sys/kernel/tracing/tracing_on
        echo 1  >/sys/kernel/tracing/events/i40e/enable
        ...
        cat     /sys/kernel/tracing/trace

Riewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v1->v2 applied to proper git branch
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  5 +++++
 drivers/net/ethernet/intel/i40e/i40e_trace.h   | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index c841779..bdf2b6b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1074,6 +1074,7 @@ static int i40e_get_link_ksettings(struct net_device *netdev,
 	ethtool_link_ksettings_zero_link_mode(ks, supported);
 	ethtool_link_ksettings_zero_link_mode(ks, advertising);
 
+	i40e_trace(ioctl_get_link_ksettings, pf, hw_link_info->link_info);
 	if (link_up)
 		i40e_get_settings_link_up(hw, ks, netdev, pf);
 	else
@@ -5585,9 +5586,12 @@ static int i40e_get_module_info(struct net_device *netdev,
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
 
@@ -5610,6 +5614,7 @@ static int i40e_get_module_eeprom(struct net_device *netdev,
 	int status;
 	int i;
 
+	i40e_trace(ioctl_get_module_eeprom, pf, ee ? ee->len : 0U);
 	if (!ee || !ee->len || !data)
 		return -EINVAL;
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_trace.h b/drivers/net/ethernet/intel/i40e/i40e_trace.h
index 33b4e30..b9be2f4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_trace.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_trace.h
@@ -202,6 +202,24 @@ DEFINE_EVENT(
 
 	TP_ARGS(ring, desc, xdp));
 
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
 	i40e_xmit_template,
 
-- 
2.25.1


