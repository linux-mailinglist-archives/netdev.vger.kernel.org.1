Return-Path: <netdev+bounces-259630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKV3N3Sul2nO5QIAu9opvQ
	(envelope-from <netdev+bounces-259630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 01:44:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63219163F29
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 01:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43A303094A71
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 00:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88258221F2F;
	Fri, 20 Feb 2026 00:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eVWpzMuA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C142192F9
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 00:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771548045; cv=none; b=k4w0E0fltrs+cK6tb0+RS8DDjSUO3Kgb3bsBcr5gWcUwZ847rGdAvsntt16a5vWqwtJKnGcYnPH/DfM4sFLyo50hBSbtiJXoBfz/7LRGqu+sJp+gu1RSYDgoRnt8nTV3G0piYbHGc7UAyx/+Djsct90znzPpiosWQRU5djlilME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771548045; c=relaxed/simple;
	bh=kFtBCng7ZSYIZhAaLkiDNmPLg2yD/8IbcyECZtCdeGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RdfBfjrWN6WrmxR2W8fdp4q5CiR3W9HItjF2aj6Hq442uFTfdbmKVUb7dNHoyjcC9qSi+D4P1Sv1IEQf39/Rb2CQhE5XAMVUCCAX3rMUuEfAbrBUo8zNnKZxgT7bI7g9fEktH7oF5B/D3Dp/2FWfVDYGD5Y6RYECYa3mUJuc0do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eVWpzMuA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771548044; x=1803084044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kFtBCng7ZSYIZhAaLkiDNmPLg2yD/8IbcyECZtCdeGg=;
  b=eVWpzMuAPmH2z+KfVKQgCGWV4nHY0xhisQ6UFZrUtiFG5f2d9Kp/u6vS
   QmAQVkLzII5DYUr0xJ6SBPdvA41qo87PodwhMJTZvA+V6+rWtFu1X5EWL
   XoP1v8vNWUd/OxqXQi9utv3k0Am73eh0mCqZqQSjDLY9EcfjXJK6Ptorm
   jL9k10nIUJu7yQkL6+12qHe5kRo30FcEeX6xjvZvmNvqvdKiRbyEC9Qsj
   Q38rAmZh4gsPzT9eBxs3Ki+1UqXXDbcyRFB6PtpGRsBPkzuS+MtFeOYcS
   ZrwoHt4b73OHZd5FHzc5X4g45YSj3c7KbmRDQLG3MFXzgXbweEn5t/mh4
   w==;
X-CSE-ConnectionGUID: PcXXtcFqSISXYllHMQ/bOw==
X-CSE-MsgGUID: 4PmhMCysTR+gFcYukrTnrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="76484244"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="76484244"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 16:40:35 -0800
X-CSE-ConnectionGUID: EAvpaic8RG2RWodKTh1uhA==
X-CSE-MsgGUID: TGOQTxrFTGOFhRtpgBWUgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="218850495"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 19 Feb 2026 16:40:34 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Vitaly Lifshits <vitaly.lifshits@intel.com>,
	anthony.l.nguyen@intel.com,
	dima.ruinskiy@intel.com,
	Avigail Dahan <avigailx.dahan@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH net 11/13] e1000e: introduce new board type for Panther Lake PCH
Date: Thu, 19 Feb 2026 16:40:23 -0800
Message-ID: <20260220004027.729384-12-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260220004027.729384-1-anthony.l.nguyen@intel.com>
References: <20260220004027.729384-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259630-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email,intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 63219163F29
X-Rspamd-Action: no action

From: Vitaly Lifshits <vitaly.lifshits@intel.com>

Add new board type for Panther Lake devices for separating device-specific
features and flows.
Additionally, remove the deprecated device IDs 0x57B5 and 0x57B6, which
are not used by any existing devices.

Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/e1000.h   |  4 +++-
 drivers/net/ethernet/intel/e1000e/hw.h      |  2 --
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 22 ++++++++++++++++++++-
 drivers/net/ethernet/intel/e1000e/netdev.c  | 15 +++++++-------
 4 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index aa08f397988e..63ebe00376f5 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -117,7 +117,8 @@ enum e1000_boards {
 	board_pch_cnp,
 	board_pch_tgp,
 	board_pch_adp,
-	board_pch_mtp
+	board_pch_mtp,
+	board_pch_ptp
 };
 
 struct e1000_ps_page {
@@ -527,6 +528,7 @@ extern const struct e1000_info e1000_pch_cnp_info;
 extern const struct e1000_info e1000_pch_tgp_info;
 extern const struct e1000_info e1000_pch_adp_info;
 extern const struct e1000_info e1000_pch_mtp_info;
+extern const struct e1000_info e1000_pch_ptp_info;
 extern const struct e1000_info e1000_es2_info;
 
 void e1000e_ptp_init(struct e1000_adapter *adapter);
diff --git a/drivers/net/ethernet/intel/e1000e/hw.h b/drivers/net/ethernet/intel/e1000e/hw.h
index fc8ed38aa095..c7ac599e5a7a 100644
--- a/drivers/net/ethernet/intel/e1000e/hw.h
+++ b/drivers/net/ethernet/intel/e1000e/hw.h
@@ -118,8 +118,6 @@ struct e1000_hw;
 #define E1000_DEV_ID_PCH_ARL_I219_V24		0x57A1
 #define E1000_DEV_ID_PCH_PTP_I219_LM25		0x57B3
 #define E1000_DEV_ID_PCH_PTP_I219_V25		0x57B4
-#define E1000_DEV_ID_PCH_PTP_I219_LM26		0x57B5
-#define E1000_DEV_ID_PCH_PTP_I219_V26		0x57B6
 #define E1000_DEV_ID_PCH_PTP_I219_LM27		0x57B7
 #define E1000_DEV_ID_PCH_PTP_I219_V27		0x57B8
 #define E1000_DEV_ID_PCH_NVL_I219_LM29		0x57B9
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 0ff8688ac3b8..23421a640097 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -528,7 +528,7 @@ static s32 e1000_init_phy_params_pchlan(struct e1000_hw *hw)
 
 	phy->id = e1000_phy_unknown;
 
-	if (hw->mac.type == e1000_pch_mtp) {
+	if (hw->mac.type == e1000_pch_mtp || hw->mac.type == e1000_pch_ptp) {
 		phy->retry_count = 2;
 		e1000e_enable_phy_retry(hw);
 	}
@@ -6208,3 +6208,23 @@ const struct e1000_info e1000_pch_mtp_info = {
 	.phy_ops		= &ich8_phy_ops,
 	.nvm_ops		= &spt_nvm_ops,
 };
+
+const struct e1000_info e1000_pch_ptp_info = {
+	.mac			= e1000_pch_ptp,
+	.flags			= FLAG_IS_ICH
+				  | FLAG_HAS_WOL
+				  | FLAG_HAS_HW_TIMESTAMP
+				  | FLAG_HAS_CTRLEXT_ON_LOAD
+				  | FLAG_HAS_AMT
+				  | FLAG_HAS_FLASH
+				  | FLAG_HAS_JUMBO_FRAMES
+				  | FLAG_APME_IN_WUC,
+	.flags2			= FLAG2_HAS_PHY_STATS
+				  | FLAG2_HAS_EEE,
+	.pba			= 26,
+	.max_hw_frame_size	= 9022,
+	.get_variants		= e1000_get_variants_ich8lan,
+	.mac_ops		= &ich8_mac_ops,
+	.phy_ops		= &ich8_phy_ops,
+	.nvm_ops		= &spt_nvm_ops,
+};
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index ddbe2f7d8112..814698807f3d 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -55,6 +55,7 @@ static const struct e1000_info *e1000_info_tbl[] = {
 	[board_pch_tgp]		= &e1000_pch_tgp_info,
 	[board_pch_adp]		= &e1000_pch_adp_info,
 	[board_pch_mtp]		= &e1000_pch_mtp_info,
+	[board_pch_ptp]		= &e1000_pch_ptp_info,
 };
 
 struct e1000_reg_info {
@@ -7925,14 +7926,12 @@ static const struct pci_device_id e1000_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LNP_I219_V21), board_pch_mtp },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ARL_I219_LM24), board_pch_mtp },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ARL_I219_V24), board_pch_mtp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_LM25), board_pch_mtp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_V25), board_pch_mtp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_LM26), board_pch_mtp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_V26), board_pch_mtp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_LM27), board_pch_mtp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_V27), board_pch_mtp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_NVL_I219_LM29), board_pch_mtp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_NVL_I219_V29), board_pch_mtp },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_LM25), board_pch_ptp },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_V25), board_pch_ptp },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_LM27), board_pch_ptp },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_PTP_I219_V27), board_pch_ptp },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_NVL_I219_LM29), board_pch_ptp },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_NVL_I219_V29), board_pch_ptp },
 
 	{ 0, 0, 0, 0, 0, 0, 0 }	/* terminate list */
 };
-- 
2.47.1


