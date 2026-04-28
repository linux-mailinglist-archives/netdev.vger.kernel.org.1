Return-Path: <netdev+bounces-281665-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id i3noHuBU8GndRwEAu9opvQ
	(envelope-from <netdev+bounces-281665-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:34:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 236C147E18D
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 08:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A506B3056140
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 06:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28233346A01;
	Tue, 28 Apr 2026 06:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CK4XLYrk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA256262FC1;
	Tue, 28 Apr 2026 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777357397; cv=none; b=Dr6cfKCBBEOkzhSMUa9C494D+lHD50rI5kpBlaRh/IC5ug+qoknzt5w9UJgblqTUmGSnMv1yHQdQfNRyBmrMOpv+O7ANHZc1sdxV6WfQ9dWeLOpi5NKFJdGJ0ZnZuNN6YDpI4FCNzahO8qNcrAU/l4QnPNJQdeou7bPjvwBWKsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777357397; c=relaxed/simple;
	bh=dLjvwNQGbgsihw8eMls+gO1zacDih/y1JKuhzvrV16g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLgq7FeSb2WxFqODHzwPjaDbyNxyd5n8mIePy8rlYUQkXPR6y9dNsKwWhWsPkiLpPCVTRhi0xCnfmsPHYc6w0jwXv7pH592uFvXtGPfEADPiqNx7k8a7/IvPotRisU7NvNr0tUxI6Yd41Dv7U4WomqpXrZVJHhM2qv4m9B26G/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CK4XLYrk; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777357395; x=1808893395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dLjvwNQGbgsihw8eMls+gO1zacDih/y1JKuhzvrV16g=;
  b=CK4XLYrk5KxFUJDZMCp2MN2BKP1A7zClBKZKEmW1Yzr3Hfm5oDUVa94z
   aoHvPo+gz2P+99mr/XZQ78kCoZd4PxdB7+pmix1D6Ftcyl0zpjUy6fFQF
   IJtyHLwmBzG2JR0p4NWVrCHGXgSrlTCb5TG7X/yCc/nXlKUC2YyuVyHOk
   C1AJ6TAy4n3mTgDZBNtF/cbAwPekv215U5zbC7Toe5XvZDoCcj4TZB6vc
   7zrk4qVs+oFSATNBTLpFCqkim9orWMvthGE4+xCz495oecLPDQB8DbFWN
   o5qdCYqAPfAPgUqGY6h06xuFi04IfcRqaPPcSjyD8fgZEQW5AWHmM8B6P
   A==;
X-CSE-ConnectionGUID: vz8xq+ncRKuHCfQmdoXCrA==
X-CSE-MsgGUID: MeaCeuoTRjiKHudk8K4VMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78366129"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78366129"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 23:23:15 -0700
X-CSE-ConnectionGUID: nDjG1kawTeu7Vob6m1z6RA==
X-CSE-MsgGUID: v/kKMP4zS/KtoH1GEteb8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="232986927"
Received: from unknown (HELO localhost.png.intel.com) ([10.107.255.61])
  by orviesa010.jf.intel.com with ESMTP; 27 Apr 2026 23:23:12 -0700
From: KhaiWenTan <khai.wen.tan@linux.intel.com>
To: anthony.l.nguyen@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, faizal.abdul.rahim@intel.com,
	hong.aun.looi@intel.com, khai.wen.tan@intel.com,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Looi@web.codeaurora.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	KhaiWenTan <khai.wen.tan@linux.intel.com>
Subject: [PATCH iwl-next v4 2/3] igc: move autoneg-enabled settings into igc_handle_autoneg_enabled()
Date: Tue, 28 Apr 2026 14:00:08 +0800
Message-ID: <20260428060009.311393-3-khai.wen.tan@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428060009.311393-1-khai.wen.tan@linux.intel.com>
References: <20260428060009.311393-1-khai.wen.tan@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 236C147E18D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	R_DKIM_REJECT(1.00)[intel.com:s=Intel];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[intel.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-281665-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[khai.wen.tan@linux.intel.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.560];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linux.intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

Move the advertised link modes and flow control configuration from
igc_ethtool_set_link_ksettings() into igc_handle_autoneg_enabled().

No functional change.

Reviewed-by: Looi, Hong Aun <hong.aun.looi@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 72 ++++++++++++--------
 1 file changed, 44 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 0122009bedd0..cfcbf2fdad6e 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -2000,6 +2000,49 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
 	return 0;
 }

+/**
+ * igc_handle_autoneg_enabled - Configure autonegotiation advertisement
+ * @adapter: private driver structure
+ * @cmd: ethtool link ksettings from user
+ *
+ * Records advertised speeds and flow control settings when autoneg
+ * is enabled.
+ */
+static void igc_handle_autoneg_enabled(struct igc_adapter *adapter,
+				       const struct ethtool_link_ksettings *cmd)
+{
+	struct igc_hw *hw = &adapter->hw;
+	u16 advertised = 0;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  2500baseT_Full))
+		advertised |= ADVERTISE_2500_FULL;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  1000baseT_Full))
+		advertised |= ADVERTISE_1000_FULL;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  100baseT_Full))
+		advertised |= ADVERTISE_100_FULL;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  100baseT_Half))
+		advertised |= ADVERTISE_100_HALF;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  10baseT_Full))
+		advertised |= ADVERTISE_10_FULL;
+
+	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
+						  10baseT_Half))
+		advertised |= ADVERTISE_10_HALF;
+
+	hw->phy.autoneg_advertised = advertised;
+	if (adapter->fc_autoneg)
+		hw->fc.requested_mode = igc_fc_default;
+}
+
 static int
 igc_ethtool_set_link_ksettings(struct net_device *netdev,
 			       const struct ethtool_link_ksettings *cmd)
@@ -2007,7 +2050,6 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
 	struct igc_adapter *adapter = netdev_priv(netdev);
 	struct net_device *dev = adapter->netdev;
 	struct igc_hw *hw = &adapter->hw;
-	u16 advertised = 0;

 	/* When adapter in resetting mode, autoneg/speed/duplex
 	 * cannot be changed
@@ -2032,34 +2074,8 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
 	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
 		usleep_range(1000, 2000);

-	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
-						  2500baseT_Full))
-		advertised |= ADVERTISE_2500_FULL;
-
-	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
-						  1000baseT_Full))
-		advertised |= ADVERTISE_1000_FULL;
-
-	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
-						  100baseT_Full))
-		advertised |= ADVERTISE_100_FULL;
-
-	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
-						  100baseT_Half))
-		advertised |= ADVERTISE_100_HALF;
-
-	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
-						  10baseT_Full))
-		advertised |= ADVERTISE_10_FULL;
-
-	if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
-						  10baseT_Half))
-		advertised |= ADVERTISE_10_HALF;
-
 	if (cmd->base.autoneg == AUTONEG_ENABLE) {
-		hw->phy.autoneg_advertised = advertised;
-		if (adapter->fc_autoneg)
-			hw->fc.requested_mode = igc_fc_default;
+		igc_handle_autoneg_enabled(adapter, cmd);
 	} else {
 		netdev_info(dev, "Force mode currently not supported\n");
 	}
--
2.43.0


