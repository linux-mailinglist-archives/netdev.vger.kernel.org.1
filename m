Return-Path: <netdev+bounces-301211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A5ZPA2mxOWq7wQcAu9opvQ
	(envelope-from <netdev+bounces-301211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 00:04:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 546646B2905
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 00:04:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=b8eABmbB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301211-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301211-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC9143040D9C
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 22:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EE53769F9;
	Mon, 22 Jun 2026 22:01:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57AC370D63
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 22:01:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782165683; cv=none; b=SK/RVhnUqu9kjY3dryNbMX85GkcYof+R/cATD/qYK+OwsmIygXrElG32PL+fVrdSnIWlEBVOLRGfFTUIQc9wyVtknuf3UP1toa/BD26pIE1AXRaKOallgcrIvTUcrfZIA+lg1e0kq184YtAiCpt0tc8F6pEwcOA2LQaG0TjFxP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782165683; c=relaxed/simple;
	bh=iFdOHC6I9/uXE2gETZz4KB9pBfatJzMykuIGR8SGrNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iD2lt4dvvIETpuqNr1hVMUyZWgX9sam5hK+OB2wvzrRlrYDBx597Tsen+xVLbCiYb2ogF+zDSa4i2CSQ41qdi32QFCKhNWj2LZ0diiWcmdMfukwGNX7VdlQd8vp7ySLJFcceEcoVizgZeFkgZ4Xgp1qaOqXeyFpynn46cmpk8rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b8eABmbB; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782165674; x=1813701674;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iFdOHC6I9/uXE2gETZz4KB9pBfatJzMykuIGR8SGrNI=;
  b=b8eABmbBQFIsfewCXiz7ttv/g4Gl6WKHG3zia8I3RoHUE/aDw5ru3vA1
   OsHzZrAofczxy8lDpI8ZCorNFcRZHBDVtwuJ5UdWECd0KydfMeNn5oFDy
   M0H/Zuz74Of/xne/5p1rUNxZ0kcnUj9/yc50EUW0byNDJz83+digkwGWq
   oB7bFaGzo1R0r6z0EPry8zU8R3RTIi3lVoHAcV2lhZywxXHiYmseQafQE
   aUrSNZMRFUcb0f9JMtFXXTiyzCmZcH2p7XesWRPhg/L7d+l+UXRwa5mO2
   vkiB/EpJGDq5d4W1ip9NV/7yqCHbo+v+StzC6ooZaQ1p/CDgqjZ0F1+gc
   A==;
X-CSE-ConnectionGUID: 1U8fqJzJRkyfiuvBWNWSZw==
X-CSE-MsgGUID: Bi/G+zGtQluP2k8TGY8h5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82675607"
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="82675607"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 15:01:05 -0700
X-CSE-ConnectionGUID: IkE0rWQiRWakUXU2mApK0Q==
X-CSE-MsgGUID: duJItJVdTXKNtopCWjAvsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,219,1774335600"; 
   d="scan'208";a="248205732"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 22 Jun 2026 15:01:06 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Dima Ruinskiy <dima.ruinskiy@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	timo.teras@iki.fi,
	Moriya Kadosh <moriyax.kadosh@intel.com>,
	Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH net 8/8] e1000e: Reconfigure PLL clock gate timeout and re-enable K1 on Meteor Lake
Date: Mon, 22 Jun 2026 15:00:55 -0700
Message-ID: <20260622220059.2471844-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260622220059.2471844-1-anthony.l.nguyen@intel.com>
References: <20260622220059.2471844-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301211-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:dima.ruinskiy@intel.com,m:anthony.l.nguyen@intel.com,m:jacob.e.keller@intel.com,m:timo.teras@iki.fi,m:moriyax.kadosh@intel.com,m:todd.e.brandt@linux.intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,osuosl.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 546646B2905

From: Dima Ruinskiy <dima.ruinskiy@intel.com>

Commit 3c7bf5af21960 ("e1000e: Introduce private flag to disable K1")
disabled K1 by default on Meteor Lake and newer systems due to packet
loss observed on various platforms. However, disabling K1 caused an
increase in power consumption.

To mitigate this, reconfigure the PLL clock gate value so that K1 can
remain enabled without incurring the additional power consumption.
Re-enable K1 by default, but keep the private flag to support disabling
it via ethtool. Additionally, introduce a DMI quirk table, so that K1 may
be disabled by default on known problematic systems. Currently, this
includes the Dell Pro 16 Plus, where the issue has been reported to persist
despite the changes to the PLL lock timeout.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220954
Link: https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20250623/048860.html
Link: https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20260330/054059.html
Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Co-developed-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Fixes: 3c7bf5af21960 ("e1000e: Introduce private flag to disable K1")
Tested-by: Moriya Kadosh <moriyax.kadosh@intel.com>
Tested-by: Todd Brandt <todd.e.brandt@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c |  3 +++
 drivers/net/ethernet/intel/e1000e/netdev.c  | 15 ++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index dea208db1be5..aa90e0ce8aca 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1594,6 +1594,9 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
 			phy_reg &= ~I217_PLL_CLOCK_GATE_MASK;
 			if (speed == SPEED_100 || speed == SPEED_10)
 				phy_reg |= 0x3E8;
+			else if (hw->mac.type == e1000_pch_mtp ||
+				 hw->mac.type == e1000_pch_ptp)
+				phy_reg |= 0x1D5;
 			else
 				phy_reg |= 0xFA;
 			e1e_wphy_locked(hw, I217_PLL_CLOCK_GATE_REG, phy_reg);
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 808e5cddd6a9..844f31ab37ad 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -25,6 +25,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/prefetch.h>
 #include <linux/suspend.h>
+#include <linux/dmi.h>
 
 #include "e1000.h"
 #define CREATE_TRACE_POINTS
@@ -58,6 +59,17 @@ static const struct e1000_info *e1000_info_tbl[] = {
 	[board_pch_ptp]		= &e1000_pch_ptp_info,
 };
 
+static const struct dmi_system_id disable_k1_list[] = {
+	{
+		.ident = "Dell Pro 16 Plus PB16250",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro 16 Plus PB16250"),
+		},
+	},
+	{}
+};
+
 struct e1000_reg_info {
 	u32 ofs;
 	char *name;
@@ -7670,7 +7682,8 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* init PTP hardware clock */
 	e1000e_ptp_init(adapter);
 
-	if (hw->mac.type >= e1000_pch_mtp)
+	/* disable K1 by default on known problematic systems */
+	if (hw->mac.type >= e1000_pch_mtp && dmi_check_system(disable_k1_list))
 		adapter->flags2 |= FLAG2_DISABLE_K1;
 
 	/* reset the hardware with the new settings */
-- 
2.47.1


